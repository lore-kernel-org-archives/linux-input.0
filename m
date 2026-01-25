Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE27F1CF7D5
	for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 20:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769373358; cv=none; b=aF7L7IDLiogKxWYBNBp9OlSPeh9UrOhKGn40wk/LCD4D6KGrGo8tadqKfLv+CzosJvoU0cATjbWY/uRNsHI79jF2EsvRtE9RptX0g5CjAoyguSeOTgcdhHgTI+IrQGSB34l7+iUaJ2g2l0Ecy7ePQY6p+UIq0iKRY6SFxSd0xIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769373358; c=relaxed/simple;
	bh=kgISwSQvkZ1tdCgq+K6LBnZVguldSkLUvFggywtzyvo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ujf6sMfJStsH15hZIpc7mt7Owz0o+zDRNTP+6c3WZFjbdhbj68w5IpbAxv0HB6OW6otQp95yHPjCsW/nWBGpXB6H3LqEasE2eVsN/WtnVSz25hMn3ggz76TXXlF+K63qFsZPKfchwqmNZSb0eHcFrej2Zrzfn7Ef1ymPZletZqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iu46w+CS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iu46w+CS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769373356; x=1800909356;
  h=date:from:to:cc:subject:message-id;
  bh=kgISwSQvkZ1tdCgq+K6LBnZVguldSkLUvFggywtzyvo=;
  b=iu46w+CS+N7gnyqK9BmHXkmRYzxNgvG74jK4VSKGec4Pjesw5dlfGsR0
   0hJx9IB8BpEeDTc0DetnAyd/dhm3Ed96pRz3ZM5Phkefe3uBQ3U5UD8Np
   LUZjO+pDlYeB1xHKjTva5CF7mlACU4TAeWPJMZqQ3w8tS1sficXQB/jBF
   A/NJJ9Tu7jNnwWb00Qeym15DZZgjbyFrHj4kh5Y+g0JxSFTGSI6B7HFFv
   31T5VLGNq4Y+r5u2OtXRyZVhDMjcIqeNIrv8GS5lKmblRny9ouTWck7Do
   qs0DewAzS97GlhOy5q2W4ADFksVZYwy7S2MUHqyKCALM8BKuYnn1Jh7tM
   Q==;
X-CSE-ConnectionGUID: lmurvfDGQ+SqtVmVwPTBIQ==
X-CSE-MsgGUID: YkxsVzMBQJiOu/LPXDVnsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="96024437"
X-IronPort-AV: E=Sophos;i="6.21,253,1763452800"; 
   d="scan'208";a="96024437"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2026 12:35:55 -0800
X-CSE-ConnectionGUID: RNDWEDOHR96sEtxrb3pXKg==
X-CSE-MsgGUID: YiJ0orW6SQqKIY4WHqT86g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,253,1763452800"; 
   d="scan'208";a="207570518"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 25 Jan 2026 12:35:54 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vk6pr-00000000Wdq-1EaE;
	Sun, 25 Jan 2026 20:35:51 +0000
Date: Mon, 26 Jan 2026 04:35:43 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:next] BUILD SUCCESS
 7ff574599464bd0e30da88aabc7be9de1021204a
Message-ID: <202601260454.wQGfqO17-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
branch HEAD: 7ff574599464bd0e30da88aabc7be9de1021204a  Input: novatek-nvt-ts - drop wake_type check

elapsed time: 862m

configs tested: 315
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260125    gcc-10.5.0
arc                   randconfig-001-20260126    gcc-10.5.0
arc                   randconfig-002-20260125    gcc-10.5.0
arc                   randconfig-002-20260126    gcc-10.5.0
arc                        vdk_hs38_defconfig    gcc-15.2.0
arm                              alldefconfig    gcc-15.2.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                       imx_v6_v7_defconfig    gcc-11.5.0
arm                         lpc18xx_defconfig    clang-22
arm                   milbeaut_m10v_defconfig    clang-19
arm                        multi_v7_defconfig    gcc-15.2.0
arm                          pxa168_defconfig    clang-22
arm                   randconfig-001-20260125    gcc-10.5.0
arm                   randconfig-001-20260126    gcc-10.5.0
arm                   randconfig-002-20260125    gcc-10.5.0
arm                   randconfig-002-20260126    gcc-10.5.0
arm                   randconfig-003-20260125    gcc-10.5.0
arm                   randconfig-003-20260126    gcc-10.5.0
arm                   randconfig-004-20260125    gcc-10.5.0
arm                   randconfig-004-20260126    gcc-10.5.0
arm                        shmobile_defconfig    gcc-11.5.0
arm                        shmobile_defconfig    gcc-15.2.0
arm                          sp7021_defconfig    clang-22
arm                          sp7021_defconfig    gcc-15.2.0
arm                        spear3xx_defconfig    gcc-15.2.0
arm                           spitz_defconfig    gcc-15.2.0
arm                         wpcm450_defconfig    gcc-11.5.0
arm                         wpcm450_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260125    clang-17
arm64                 randconfig-001-20260125    gcc-11.5.0
arm64                 randconfig-001-20260126    gcc-15.2.0
arm64                 randconfig-002-20260125    clang-22
arm64                 randconfig-002-20260125    gcc-11.5.0
arm64                 randconfig-002-20260126    gcc-15.2.0
arm64                 randconfig-003-20260125    clang-22
arm64                 randconfig-003-20260125    gcc-11.5.0
arm64                 randconfig-003-20260126    gcc-15.2.0
arm64                 randconfig-004-20260125    clang-22
arm64                 randconfig-004-20260125    gcc-11.5.0
arm64                 randconfig-004-20260126    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260125    gcc-11.5.0
csky                  randconfig-001-20260125    gcc-15.2.0
csky                  randconfig-001-20260126    gcc-15.2.0
csky                  randconfig-002-20260125    gcc-11.5.0
csky                  randconfig-002-20260126    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260125    clang-22
hexagon               randconfig-001-20260126    gcc-15.2.0
hexagon               randconfig-002-20260125    clang-20
hexagon               randconfig-002-20260125    clang-22
hexagon               randconfig-002-20260126    gcc-15.2.0
i386                             alldefconfig    gcc-14
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260125    gcc-14
i386        buildonly-randconfig-001-20260126    clang-20
i386        buildonly-randconfig-002-20260125    gcc-14
i386        buildonly-randconfig-002-20260126    clang-20
i386        buildonly-randconfig-003-20260125    gcc-14
i386        buildonly-randconfig-003-20260126    clang-20
i386        buildonly-randconfig-004-20260125    gcc-14
i386        buildonly-randconfig-004-20260126    clang-20
i386        buildonly-randconfig-005-20260125    gcc-14
i386        buildonly-randconfig-005-20260126    clang-20
i386        buildonly-randconfig-006-20260125    gcc-14
i386        buildonly-randconfig-006-20260126    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260125    clang-20
i386                  randconfig-001-20260125    gcc-14
i386                  randconfig-002-20260125    clang-20
i386                  randconfig-002-20260125    gcc-14
i386                  randconfig-003-20260125    clang-20
i386                  randconfig-003-20260125    gcc-14
i386                  randconfig-004-20260125    clang-20
i386                  randconfig-005-20260125    clang-20
i386                  randconfig-005-20260125    gcc-14
i386                  randconfig-006-20260125    clang-20
i386                  randconfig-007-20260125    clang-20
i386                  randconfig-011-20260125    gcc-14
i386                  randconfig-012-20260125    gcc-14
i386                  randconfig-013-20260125    gcc-14
i386                  randconfig-014-20260125    clang-20
i386                  randconfig-014-20260125    gcc-14
i386                  randconfig-015-20260125    clang-20
i386                  randconfig-015-20260125    gcc-14
i386                  randconfig-016-20260125    gcc-14
i386                  randconfig-017-20260125    clang-20
i386                  randconfig-017-20260125    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260125    clang-22
loongarch             randconfig-001-20260126    gcc-15.2.0
loongarch             randconfig-002-20260125    clang-22
loongarch             randconfig-002-20260125    gcc-14.3.0
loongarch             randconfig-002-20260126    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    gcc-15.2.0
m68k                        m5407c3_defconfig    gcc-11.5.0
m68k                           sun3_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                      mmu_defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                         bigsur_defconfig    clang-22
mips                           ci20_defconfig    clang-22
mips                      fuloong2e_defconfig    gcc-15.2.0
mips                     loongson2k_defconfig    gcc-15.2.0
mips                           mtx1_defconfig    clang-22
nios2                         3c120_defconfig    gcc-11.5.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260125    clang-22
nios2                 randconfig-001-20260125    gcc-8.5.0
nios2                 randconfig-001-20260126    gcc-15.2.0
nios2                 randconfig-002-20260125    clang-22
nios2                 randconfig-002-20260125    gcc-8.5.0
nios2                 randconfig-002-20260126    gcc-15.2.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260125    gcc-8.5.0
parisc                randconfig-001-20260126    gcc-8.5.0
parisc                randconfig-002-20260125    gcc-8.5.0
parisc                randconfig-002-20260126    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      cm5200_defconfig    clang-22
powerpc                     ep8248e_defconfig    clang-22
powerpc                      ep88xc_defconfig    gcc-11.5.0
powerpc                  iss476-smp_defconfig    clang-22
powerpc                 mpc836x_rdk_defconfig    clang-22
powerpc                      ppc44x_defconfig    clang-22
powerpc               randconfig-001-20260125    clang-22
powerpc               randconfig-001-20260125    gcc-8.5.0
powerpc               randconfig-001-20260126    gcc-8.5.0
powerpc               randconfig-002-20260125    clang-22
powerpc               randconfig-002-20260125    gcc-8.5.0
powerpc               randconfig-002-20260126    gcc-8.5.0
powerpc                     redwood_defconfig    gcc-11.5.0
powerpc                    socrates_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260125    gcc-12.5.0
powerpc64             randconfig-001-20260125    gcc-8.5.0
powerpc64             randconfig-001-20260126    gcc-8.5.0
powerpc64             randconfig-002-20260125    clang-17
powerpc64             randconfig-002-20260125    gcc-8.5.0
powerpc64             randconfig-002-20260126    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260125    clang-22
riscv                 randconfig-001-20260126    gcc-9.5.0
riscv                 randconfig-002-20260125    clang-16
riscv                 randconfig-002-20260125    clang-22
riscv                 randconfig-002-20260126    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260125    clang-22
s390                  randconfig-001-20260125    gcc-11.5.0
s390                  randconfig-001-20260126    gcc-9.5.0
s390                  randconfig-002-20260125    clang-22
s390                  randconfig-002-20260125    gcc-9.5.0
s390                  randconfig-002-20260126    gcc-9.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                         apsh4a3a_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260125    clang-22
sh                    randconfig-001-20260125    gcc-15.2.0
sh                    randconfig-001-20260126    gcc-9.5.0
sh                    randconfig-002-20260125    clang-22
sh                    randconfig-002-20260125    gcc-14.3.0
sh                    randconfig-002-20260126    gcc-9.5.0
sh                          rsk7203_defconfig    clang-22
sh                          rsk7264_defconfig    gcc-11.5.0
sh                      rts7751r2d1_defconfig    gcc-15.2.0
sh                           sh2007_defconfig    gcc-15.2.0
sh                   sh7724_generic_defconfig    gcc-15.2.0
sh                             shx3_defconfig    gcc-15.2.0
sh                          urquell_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260125    gcc-8.5.0
sparc                 randconfig-002-20260125    gcc-15.2.0
sparc                 randconfig-002-20260125    gcc-8.5.0
sparc                       sparc64_defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260125    gcc-12.5.0
sparc64               randconfig-001-20260125    gcc-8.5.0
sparc64               randconfig-002-20260125    clang-20
sparc64               randconfig-002-20260125    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260125    gcc-14
um                    randconfig-001-20260125    gcc-8.5.0
um                    randconfig-002-20260125    clang-16
um                    randconfig-002-20260125    gcc-8.5.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260125    clang-20
x86_64      buildonly-randconfig-002-20260125    clang-20
x86_64      buildonly-randconfig-002-20260125    gcc-14
x86_64      buildonly-randconfig-003-20260125    clang-20
x86_64      buildonly-randconfig-004-20260125    clang-20
x86_64      buildonly-randconfig-005-20260125    clang-20
x86_64      buildonly-randconfig-005-20260125    gcc-14
x86_64      buildonly-randconfig-006-20260125    clang-20
x86_64      buildonly-randconfig-006-20260125    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260125    gcc-14
x86_64                randconfig-002-20260125    gcc-14
x86_64                randconfig-003-20260125    gcc-14
x86_64                randconfig-004-20260125    gcc-14
x86_64                randconfig-005-20260125    gcc-14
x86_64                randconfig-006-20260125    gcc-14
x86_64                randconfig-011-20260125    clang-20
x86_64                randconfig-012-20260125    clang-20
x86_64                randconfig-013-20260125    clang-20
x86_64                randconfig-014-20260125    clang-20
x86_64                randconfig-015-20260125    gcc-14
x86_64                randconfig-016-20260125    gcc-13
x86_64                randconfig-071-20260125    clang-20
x86_64                randconfig-072-20260125    clang-20
x86_64                randconfig-072-20260125    gcc-14
x86_64                randconfig-073-20260125    clang-20
x86_64                randconfig-074-20260125    clang-20
x86_64                randconfig-074-20260125    gcc-14
x86_64                randconfig-075-20260125    clang-20
x86_64                randconfig-075-20260125    gcc-14
x86_64                randconfig-076-20260125    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260125    gcc-12.5.0
xtensa                randconfig-001-20260125    gcc-8.5.0
xtensa                randconfig-002-20260125    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
