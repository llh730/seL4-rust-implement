
#pragma once

#define CONFIG_IMAGE_ELF  1  /* ElfloaderImageELF=ON */
/* disabled: CONFIG_IMAGE_BINARY */
#define CONFIG_ELFLOADER_IMAGE  elf
/* disabled: CONFIG_ARM_MONITOR_HOOK */
/* disabled: CONFIG_GPT_PTIMER_NS_PL1_ACCESS */
/* disabled: CONFIG_ARM_ERRATA_764369 */
#define CONFIG_HASH_NONE  1  /* ElfloaderHashNone=ON */
/* disabled: CONFIG_HASH_SHA */
/* disabled: CONFIG_HASH_MD5 */
#define CONFIG_HASH_INSTRUCTIONS  hash_none
#define CONFIG_ELFLOADER_INCLUDE_DTB  1  /* ElfloaderIncludeDtb=ON */
/* disabled: CONFIG_ELFLOADER_ROOTSERVERS_LAST */
/* disabled: CONFIG_ELFLOADER_ARMV8_LEAVE_AARCH64 */