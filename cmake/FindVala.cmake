find_program(VALA_EXECUTABLE NAMES valac valac-0.38 valac-0.36 valac-0.34)

execute_process(COMMAND ${VALA_EXECUTABLE} "--version" OUTPUT_VARIABLE "VALA_VERSION")
string(REPLACE "Vala" "" "VALA_VERSION" ${VALA_VERSION})
string(STRIP ${VALA_VERSION} "VALA_VERSION")

include(FindPackageHandleStandardArgs)
        find_package_handle_standard_args(Vala
            REQUIRED_VARS
                VALA_EXECUTABLE
            VERSION_VAR
                VALA_VERSION
            )

mark_as_advanced(VALA_EXECUTABLE)
