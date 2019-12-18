include(CMakeParseArguments)
find_package(Vala QUIET)

include(CMakeParseArguments)
macro(vala_precompile output target_name)
    cmake_parse_arguments(ARGS "" "DIRECTORY;GENERATE_GIR;GENERATE_HEADER;GENERATE_VAPI" "TARGET;PACKAGES;OPTIONS;GENERATE_SYMBOLS;CUSTOM_VAPIS" "" ${ARGN})

    if(ARGS_DIRECTORY)
        set(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${ARGS_DIRECTORY})
    else(ARGS_DIRECTORY)
        set(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
    endif(ARGS_DIRECTORY)
    include_directories(${DIRECTORY})
    set(vala_pkg_opts "")
    foreach(pkg ${ARGS_PACKAGES})
        list(APPEND vala_pkg_opts "--pkg=${pkg}")
    endforeach(pkg ${ARGS_PACKAGES})
    set(in_files "")
    set(out_files "")
    set(out_files_display "")
    set(${output} "")

    foreach(src ${ARGS_UNPARSED_ARGUMENTS})
        string(REGEX MATCH "^/" IS_MATCHED ${src})
        if(${IS_MATCHED} MATCHES "/")
            set(src_file_path ${src})
        else()
            set(src_file_path ${CMAKE_CURRENT_SOURCE_DIR}/${src})
        endif()
        list(APPEND in_files ${src_file_path})
        string(REPLACE ".vala" ".c" src ${src})
        string(REPLACE ".gs" ".c" src ${src})
        if(${IS_MATCHED} MATCHES "/")
            get_filename_component(VALA_FILE_NAME ${src} NAME)
            set(out_file "${CMAKE_CURRENT_BINARY_DIR}/${VALA_FILE_NAME}")
            list(APPEND out_files "${CMAKE_CURRENT_BINARY_DIR}/${VALA_FILE_NAME}")
        else()
            set(out_file "${DIRECTORY}/${src}")
            list(APPEND out_files "${DIRECTORY}/${src}")
        endif()
        list(APPEND ${output} ${out_file})
        list(APPEND out_files_display "${src}")
    endforeach(src ${ARGS_DEFAULT_ARGS})

    set(custom_vapi_arguments "")
    if(ARGS_CUSTOM_VAPIS)
        foreach(vapi ${ARGS_CUSTOM_VAPIS})
            if(${vapi} MATCHES ${CMAKE_SOURCE_DIR} OR ${vapi} MATCHES ${CMAKE_BINARY_DIR})
                list(APPEND custom_vapi_arguments ${vapi})
            else (${vapi} MATCHES ${CMAKE_SOURCE_DIR} OR ${vapi} MATCHES ${CMAKE_BINARY_DIR})
                list(APPEND custom_vapi_arguments ${CMAKE_CURRENT_SOURCE_DIR}/${vapi})
            endif(${vapi} MATCHES ${CMAKE_SOURCE_DIR} OR ${vapi} MATCHES ${CMAKE_BINARY_DIR})
        endforeach(vapi ${ARGS_CUSTOM_VAPIS})
    endif(ARGS_CUSTOM_VAPIS)

    set(vapi_arguments "")
    if(ARGS_GENERATE_VAPI)
        list(APPEND out_files "${DIRECTORY}/${ARGS_GENERATE_VAPI}.vapi")
        list(APPEND out_files_display "${ARGS_GENERATE_VAPI}.vapi")
        set(vapi_arguments "--library=${ARGS_GENERATE_VAPI}" "--vapi=${ARGS_GENERATE_VAPI}.vapi")

        if (NOT ARGS_GENERATE_HEADER)
            set(ARGS_GENERATE_HEADER ${ARGS_GENERATE_VAPI})
        endif(NOT ARGS_GENERATE_HEADER)
    endif(ARGS_GENERATE_VAPI)

    set(header_arguments "")
    if(ARGS_GENERATE_HEADER)
        list(APPEND out_files "${DIRECTORY}/${ARGS_GENERATE_HEADER}.h")
        list(APPEND out_files_display "${ARGS_GENERATE_HEADER}.h")
        list(APPEND header_arguments "--header=${ARGS_GENERATE_HEADER}.h")
    endif(ARGS_GENERATE_HEADER)

    set(gir_arguments "")
    set(gircomp_command "")
    if(ARGS_GENERATE_GIR)
        list(APPEND out_files "${DIRECTORY}/${ARGS_GENERATE_GIR}.gir")
        list(APPEND out_files_display "${ARGS_GENERATE_GIR}.gir")
        set(gir_arguments "--gir=${ARGS_GENERATE_GIR}.gir")

        include (FindGirCompiler)
        find_package(GirCompiler REQUIRED)
        
        set(gircomp_command 
            COMMAND 
                ${G_IR_COMPILER_EXECUTABLE}
            ARGS 
                "${DIRECTORY}/${ARGS_GENERATE_GIR}.gir"
                -o "${DIRECTORY}/${ARGS_GENERATE_GIR}.typelib")
    endif(ARGS_GENERATE_GIR)

    set(symbols_arguments "")
    if(ARGS_GENERATE_SYMBOLS)
        list(APPEND out_files "${DIRECTORY}/${ARGS_GENERATE_SYMBOLS}.symbols")
        list(APPEND out_files_display "${ARGS_GENERATE_SYMBOLS}.symbols")
        set(symbols_arguments "--symbols=${ARGS_GENERATE_SYMBOLS}.symbols")
    endif(ARGS_GENERATE_SYMBOLS)

    set(STAMP_TARGET ${target_name}_valac)
    set(OUTPUT_STAMP ${CMAKE_CURRENT_BINARY_DIR}/${target_name}_valac.stamp)

    add_custom_command(
    OUTPUT
        ${OUTPUT_STAMP}
    COMMAND 
        ${VALA_EXECUTABLE} 
    ARGS 
        "-C" 
        ${header_arguments} 
        ${vapi_arguments} 
        ${gir_arguments} 
        ${symbols_arguments} 
        "-b" ${CMAKE_CURRENT_SOURCE_DIR} 
        "-d" ${DIRECTORY} 
        ${vala_pkg_opts} 
        ${ARGS_OPTIONS} 
        "-g"
        ${in_files} 
        ${custom_vapi_arguments}
    COMMAND
        touch
    ARGS
        ${OUTPUT_STAMP}
    DEPENDS 
        ${in_files} 
        ${ARGS_CUSTOM_VAPIS}
    COMMENT
        "Generating ${out_files_display}"
    ${gircomp_command}
    )
    add_custom_target(${STAMP_TARGET} DEPENDS ${in_files})
    add_custom_command(OUTPUT ${out_files} DEPENDS ${OUTPUT_STAMP} COMMENT "")
endmacro(vala_precompile)
