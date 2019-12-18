#include <stdio.h>

#include "../hat/hat.h"
#include "main.h"

#define VALA_ENTRYPOINT _wide_world_importers_live_temp_main__vala_main

/**
 * Main methode voor onze executable.<br />
 * We wrappen de vala main method om meer controle te hebben hierover.
 *
 * @return exit code
 */
int main(int argc, char* argv[]) {
    return VALA_ENTRYPOINT();
}