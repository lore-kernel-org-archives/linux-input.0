Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED825421F1A
	for <linux-input@vger.kernel.org>; Fri,  8 May 2026 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778275413; cv=none; b=S1FUge/3A1jO+8XD1Axpr0jqPStxErQzj8gTLOyMDVHMis92DfwxLShudb2439kCBTEN7bx0EPTQsirvqLMvniPnFkpWokX9WJCmk+w0MA0GtPByHpnvjTf4m1SXLgf50AowxmNRkcOxCHaVSudO5WDisFGn0O5FKeIoqQRdOn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778275413; c=relaxed/simple;
	bh=F6VoSUEr+vZ6Y3Qy72+l1S1WqOGXamCPXinfjvPdyp0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bnkol/l7ZptljMnmbYNBe+yxtX307Xyd31gyw3enG36/ZXgDWefHvaZOjCrFEJ4rZXrtFxbkflgqpWCMr0tDXFAbnyKVCX2SriCQAqwvNWbIZqAbpuycg2R5K07YHNXO6wZ1lq0tLrlKHffKyPD79UYU+Iue6jMhOzkr/+tJHJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BMjItmGK; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BMjItmGK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778275411; x=1809811411;
  h=date:from:to:cc:subject:message-id;
  bh=F6VoSUEr+vZ6Y3Qy72+l1S1WqOGXamCPXinfjvPdyp0=;
  b=BMjItmGKA3SE6bQu4DBu/IH3woej31yCObuGAYulfsIA/EWAMfriePzI
   fc3E81/DvUIExuzhNi2/h6yRzHRH5TUSJw9JGP6LJaf4ZOxIf+OVk2K/H
   JdGGnVhNqvTBy4ndrA/V2g+qTNqZfs8Bzvgtb12wgPkGKsdIKdD79dL+g
   H1i1k2BYH9KH88LAYp4oUzgfTHE/vD9hd32DPMvcNLhPucwmJWqnuB8Wg
   URQ6dSgza+6ZCMcb5OjRdUH78NdtQqdkb/6pPxonfbpepvvgpOjuDZfiM
   /xOwJ93f1Hf6UwXnWpZ+Mgy1owP8RmGvy1JSrtyEHgecYWE4s8qt0V/kh
   A==;
X-CSE-ConnectionGUID: Apk/i75URYyxeV1vWlAnFg==
X-CSE-MsgGUID: ix+YsJCSQCWjKW75jZZm1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="82875436"
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; 
   d="scan'208";a="82875436"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 14:23:30 -0700
X-CSE-ConnectionGUID: blSVvtcJRjil4RBb7t8lIA==
X-CSE-MsgGUID: 6Z1Yy+SxRR+18lhdzziW5g==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 82327192134e) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 08 May 2026 14:23:29 -0700
Received: from kbuild by 82327192134e with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wLSfO-000000000Rd-2vmF;
	Fri, 08 May 2026 21:23:26 +0000
Date: Sat, 09 May 2026 05:22:28 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:for-linus] BUILD SUCCESS
 74d695fd6f9d70df849c555f358ddfd26e2d85bf
Message-ID: <202605090521.WcvOfSZW-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
branch HEAD: 74d695fd6f9d70df849c555f358ddfd26e2d85bf  Input: fm801-gp - simplify initialisation of pci_device_id array

elapsed time: 1197m

configs tested: 334
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                     haps_hs_smp_defconfig    gcc-15.2.0
arc                 nsimosci_hs_smp_defconfig    gcc-15.2.0
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260508    gcc-12.5.0
arc                   randconfig-001-20260508    gcc-8.5.0
arc                   randconfig-001-20260509    gcc-9.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260508    gcc-12.5.0
arc                   randconfig-002-20260508    gcc-8.5.0
arc                   randconfig-002-20260509    gcc-9.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                           h3600_defconfig    gcc-15.2.0
arm                        neponset_defconfig    gcc-15.2.0
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260508    gcc-12.5.0
arm                   randconfig-001-20260508    gcc-8.5.0
arm                   randconfig-001-20260509    gcc-9.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260508    gcc-12.5.0
arm                   randconfig-002-20260508    gcc-8.5.0
arm                   randconfig-002-20260509    gcc-9.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260508    gcc-12.5.0
arm                   randconfig-003-20260508    gcc-8.5.0
arm                   randconfig-003-20260509    gcc-9.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260508    gcc-12.5.0
arm                   randconfig-004-20260508    gcc-8.5.0
arm                   randconfig-004-20260509    gcc-9.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260508    gcc-14.3.0
arm64                 randconfig-001-20260509    gcc-10.5.0
arm64                 randconfig-002-20260508    gcc-14.3.0
arm64                 randconfig-002-20260509    gcc-10.5.0
arm64                 randconfig-003-20260508    gcc-14.3.0
arm64                 randconfig-003-20260509    gcc-10.5.0
arm64                 randconfig-004-20260508    gcc-14.3.0
arm64                 randconfig-004-20260509    gcc-10.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260508    gcc-14.3.0
csky                  randconfig-001-20260509    gcc-10.5.0
csky                  randconfig-002-20260508    gcc-14.3.0
csky                  randconfig-002-20260509    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260508    clang-23
hexagon               randconfig-001-20260508    gcc-11.5.0
hexagon               randconfig-001-20260509    clang-17
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260508    clang-23
hexagon               randconfig-002-20260508    gcc-11.5.0
hexagon               randconfig-002-20260509    clang-17
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260508    gcc-14
i386        buildonly-randconfig-001-20260509    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260508    gcc-14
i386        buildonly-randconfig-002-20260509    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260508    gcc-14
i386        buildonly-randconfig-003-20260509    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260508    gcc-14
i386        buildonly-randconfig-004-20260509    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260508    gcc-14
i386        buildonly-randconfig-005-20260509    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260508    gcc-14
i386        buildonly-randconfig-006-20260509    gcc-14
i386                                defconfig    gcc-15.2.0
i386                           randconfig-001    gcc-14
i386                  randconfig-001-20260508    gcc-14
i386                  randconfig-001-20260509    clang-20
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260508    gcc-14
i386                  randconfig-002-20260509    clang-20
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260508    gcc-14
i386                  randconfig-003-20260509    clang-20
i386                           randconfig-004    gcc-14
i386                  randconfig-004-20260508    gcc-14
i386                  randconfig-004-20260509    clang-20
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260508    gcc-14
i386                  randconfig-005-20260509    clang-20
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260508    gcc-14
i386                  randconfig-006-20260509    clang-20
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260508    gcc-14
i386                  randconfig-007-20260509    clang-20
i386                  randconfig-011-20260508    gcc-13
i386                  randconfig-012-20260508    gcc-13
i386                  randconfig-013-20260508    gcc-13
i386                  randconfig-014-20260508    gcc-13
i386                  randconfig-015-20260508    gcc-13
i386                  randconfig-016-20260508    gcc-13
i386                  randconfig-017-20260508    gcc-13
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260508    clang-23
loongarch             randconfig-001-20260508    gcc-11.5.0
loongarch             randconfig-001-20260509    clang-17
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260508    clang-23
loongarch             randconfig-002-20260508    gcc-11.5.0
loongarch             randconfig-002-20260509    clang-17
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                      loongson3_defconfig    gcc-15.2.0
mips                        omega2p_defconfig    clang-23
mips                         rt305x_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260508    clang-23
nios2                 randconfig-001-20260508    gcc-11.5.0
nios2                 randconfig-001-20260509    clang-17
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260508    clang-23
nios2                 randconfig-002-20260508    gcc-11.5.0
nios2                 randconfig-002-20260509    clang-17
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                 simple_smp_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-9.5.0
parisc                randconfig-001-20260508    gcc-9.5.0
parisc                randconfig-001-20260509    gcc-11.5.0
parisc                         randconfig-002    gcc-9.5.0
parisc                randconfig-002-20260508    gcc-9.5.0
parisc                randconfig-002-20260509    gcc-11.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                       holly_defconfig    clang-23
powerpc                        randconfig-001    gcc-9.5.0
powerpc               randconfig-001-20260508    gcc-9.5.0
powerpc               randconfig-001-20260509    gcc-11.5.0
powerpc                        randconfig-002    gcc-9.5.0
powerpc               randconfig-002-20260508    gcc-9.5.0
powerpc               randconfig-002-20260509    gcc-11.5.0
powerpc                     tqm8555_defconfig    gcc-15.2.0
powerpc64                      randconfig-001    gcc-9.5.0
powerpc64             randconfig-001-20260508    gcc-9.5.0
powerpc64             randconfig-001-20260509    gcc-11.5.0
powerpc64                      randconfig-002    gcc-9.5.0
powerpc64             randconfig-002-20260508    gcc-9.5.0
powerpc64             randconfig-002-20260509    gcc-11.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260508    clang-23
riscv                 randconfig-001-20260509    clang-23
riscv                 randconfig-002-20260508    clang-23
riscv                 randconfig-002-20260509    clang-23
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260508    clang-23
s390                  randconfig-001-20260509    clang-23
s390                  randconfig-002-20260508    clang-23
s390                  randconfig-002-20260509    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                        apsh4ad0a_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                     magicpanelr2_defconfig    gcc-15.2.0
sh                          polaris_defconfig    gcc-15.2.0
sh                    randconfig-001-20260508    clang-23
sh                    randconfig-001-20260509    clang-23
sh                    randconfig-002-20260508    clang-23
sh                    randconfig-002-20260509    clang-23
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-12
sparc                 randconfig-001-20260508    gcc-12
sparc                 randconfig-001-20260509    clang-23
sparc                          randconfig-002    gcc-12
sparc                 randconfig-002-20260508    gcc-12
sparc                 randconfig-002-20260509    clang-23
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-12
sparc64               randconfig-001-20260508    gcc-12
sparc64               randconfig-001-20260509    clang-23
sparc64                        randconfig-002    gcc-12
sparc64               randconfig-002-20260508    gcc-12
sparc64               randconfig-002-20260509    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-12
um                    randconfig-001-20260508    gcc-12
um                    randconfig-001-20260509    clang-23
um                             randconfig-002    gcc-12
um                    randconfig-002-20260508    gcc-12
um                    randconfig-002-20260509    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64               buildonly-randconfig-001    gcc-14
x86_64      buildonly-randconfig-001-20260508    gcc-14
x86_64               buildonly-randconfig-002    gcc-14
x86_64      buildonly-randconfig-002-20260508    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260508    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260508    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260508    gcc-14
x86_64               buildonly-randconfig-006    gcc-14
x86_64      buildonly-randconfig-006-20260508    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                         randconfig-001    clang-20
x86_64                randconfig-001-20260508    clang-20
x86_64                         randconfig-002    clang-20
x86_64                randconfig-002-20260508    clang-20
x86_64                         randconfig-003    clang-20
x86_64                randconfig-003-20260508    clang-20
x86_64                         randconfig-004    clang-20
x86_64                randconfig-004-20260508    clang-20
x86_64                         randconfig-005    clang-20
x86_64                randconfig-005-20260508    clang-20
x86_64                         randconfig-006    clang-20
x86_64                randconfig-006-20260508    clang-20
x86_64                         randconfig-011    gcc-14
x86_64                randconfig-011-20260508    gcc-14
x86_64                         randconfig-012    gcc-14
x86_64                randconfig-012-20260508    gcc-14
x86_64                         randconfig-013    gcc-14
x86_64                randconfig-013-20260508    gcc-14
x86_64                         randconfig-014    gcc-14
x86_64                randconfig-014-20260508    gcc-14
x86_64                         randconfig-015    gcc-14
x86_64                randconfig-015-20260508    gcc-14
x86_64                         randconfig-016    gcc-14
x86_64                randconfig-016-20260508    gcc-14
x86_64                         randconfig-071    gcc-14
x86_64                randconfig-071-20260508    gcc-14
x86_64                randconfig-071-20260509    clang-20
x86_64                         randconfig-072    gcc-14
x86_64                randconfig-072-20260508    gcc-14
x86_64                randconfig-072-20260509    clang-20
x86_64                         randconfig-073    gcc-14
x86_64                randconfig-073-20260508    gcc-14
x86_64                randconfig-073-20260509    clang-20
x86_64                         randconfig-074    gcc-14
x86_64                randconfig-074-20260508    gcc-14
x86_64                randconfig-074-20260509    clang-20
x86_64                         randconfig-075    gcc-14
x86_64                randconfig-075-20260508    gcc-14
x86_64                randconfig-075-20260509    clang-20
x86_64                         randconfig-076    gcc-14
x86_64                randconfig-076-20260508    gcc-14
x86_64                randconfig-076-20260509    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                         randconfig-001    gcc-12
xtensa                randconfig-001-20260508    gcc-12
xtensa                randconfig-001-20260509    clang-23
xtensa                         randconfig-002    gcc-12
xtensa                randconfig-002-20260508    gcc-12
xtensa                randconfig-002-20260509    clang-23

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
