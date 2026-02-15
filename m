Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AC021D3F2
	for <linux-input@vger.kernel.org>; Sun, 15 Feb 2026 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771149652; cv=none; b=lpSHt5T8K4ixSiu5CUFK231xJdRMSavvoRWrU4abe5qOUQ1erJu29Rn9lGM07MBsHdrLF67vBVP1vrb3CEWTnxpj3C0TcCemmwsQuw7T/g1aBOqSc87X5fydc69xMYpyZSyBOzGkhjwU/tyV6nqaEN0z605vT+IxzoOwNXx9xBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771149652; c=relaxed/simple;
	bh=OuwdCZqMGRfBppb8EqZXmvekqMj5yXdhMi/Tmc/AMs0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sm5jmaJKneN8QeKsGECSWgCwLXoeyU5Ny5//9AdCjhshTLvycVxO8ZE7KU1m0HJc3zkLe4qt2MmJYtWwLrXxotQ8cntG+1/mWDtyrTshb1j4C9CJ0aD0zqRccmJ+7/bHQjHANq+sI8xC4GLe3NYNw1r30zcxcgIH04KunknHM70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BSVE6x/C; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BSVE6x/C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771149650; x=1802685650;
  h=date:from:to:cc:subject:message-id;
  bh=OuwdCZqMGRfBppb8EqZXmvekqMj5yXdhMi/Tmc/AMs0=;
  b=BSVE6x/CYoHx8heLP2JlvFzVoAw7Fu9PQSxbi4E2wEAf3uaP3oWMrDvT
   /HZhlJbpWt/7Ioe7956mGMKsaTnaDge5E47+9sReyR98W65lYvoxCQX28
   4t3dsI9cJ4JFvDNOnixtApm2Ii9WqVWSIX7DS9x0oZe0aKZCFDfoDDj4V
   N7ZpdZ77LdYF+UwcY4VUYMijwvfhhTQjomcVKe1crzMYpy5DLzHTRMGMB
   anthNu43cyfyWdVxPSHPWf8/bfhzC4RMSoAs9lZcAnJdM64u1393XfIN7
   Pfjuyr72uJojkBCAN0MzfhARqSK0Nw+OWfULexkWnHVgfxlYHHSfcl+Bc
   Q==;
X-CSE-ConnectionGUID: 8S4Tmt7iRS2UF6oE5IRZKQ==
X-CSE-MsgGUID: TXd570mYSOSfRcMcRZjGDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11701"; a="89854209"
X-IronPort-AV: E=Sophos;i="6.21,292,1763452800"; 
   d="scan'208";a="89854209"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 02:00:50 -0800
X-CSE-ConnectionGUID: N1pT20W2QG22QUH52cktrA==
X-CSE-MsgGUID: PnQXO5C1TRKBX1oYgC/5og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,292,1763452800"; 
   d="scan'208";a="217489803"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 15 Feb 2026 02:00:48 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vrYvl-00000000yFs-2cSW;
	Sun, 15 Feb 2026 10:00:45 +0000
Date: Sun, 15 Feb 2026 18:00:44 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:next] BUILD SUCCESS
 ab2e361ca97a42b7af8be1d273646b30d3b75bf3
Message-ID: <202602151836.Lo3FUTJa-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
branch HEAD: ab2e361ca97a42b7af8be1d273646b30d3b75bf3  dt-bindings: input: qcom,pm8941-pwrkey: Document PMM8654AU

elapsed time: 723m

configs tested: 256
configs skipped: 2

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
arc                            hsdk_defconfig    clang-22
arc                   randconfig-001-20260215    clang-20
arc                   randconfig-002-20260215    clang-20
arc                        vdk_hs38_defconfig    clang-22
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                          collie_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                         nhk8815_defconfig    clang-22
arm                             pxa_defconfig    clang-22
arm                   randconfig-001-20260215    clang-20
arm                   randconfig-002-20260215    clang-20
arm                   randconfig-003-20260215    clang-20
arm                   randconfig-004-20260215    clang-20
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260215    gcc-8.5.0
arm64                 randconfig-002-20260215    gcc-8.5.0
arm64                 randconfig-003-20260215    gcc-8.5.0
arm64                 randconfig-004-20260215    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260215    gcc-8.5.0
csky                  randconfig-002-20260215    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260215    clang-22
hexagon               randconfig-002-20260215    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260215    gcc-14
i386        buildonly-randconfig-002-20260215    clang-20
i386        buildonly-randconfig-002-20260215    gcc-14
i386        buildonly-randconfig-003-20260215    gcc-14
i386        buildonly-randconfig-004-20260215    gcc-14
i386        buildonly-randconfig-005-20260215    gcc-14
i386        buildonly-randconfig-006-20260215    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260215    clang-20
i386                  randconfig-002-20260215    clang-20
i386                  randconfig-003-20260215    clang-20
i386                  randconfig-004-20260215    clang-20
i386                  randconfig-004-20260215    gcc-14
i386                  randconfig-005-20260215    clang-20
i386                  randconfig-005-20260215    gcc-14
i386                  randconfig-006-20260215    clang-20
i386                  randconfig-006-20260215    gcc-14
i386                  randconfig-007-20260215    clang-20
i386                  randconfig-007-20260215    gcc-14
i386                  randconfig-011-20260215    clang-20
i386                  randconfig-011-20260215    gcc-14
i386                  randconfig-012-20260215    clang-20
i386                  randconfig-013-20260215    clang-20
i386                  randconfig-013-20260215    gcc-14
i386                  randconfig-014-20260215    clang-20
i386                  randconfig-014-20260215    gcc-14
i386                  randconfig-015-20260215    clang-20
i386                  randconfig-016-20260215    clang-20
i386                  randconfig-016-20260215    gcc-13
i386                  randconfig-017-20260215    clang-20
i386                  randconfig-017-20260215    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260215    clang-22
loongarch             randconfig-002-20260215    clang-22
loongarch             randconfig-002-20260215    gcc-13.4.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                         amcore_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                        mvme147_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          ath25_defconfig    clang-22
mips                        bcm47xx_defconfig    clang-22
mips                         bigsur_defconfig    clang-22
mips                 decstation_r4k_defconfig    clang-22
mips                           ip30_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260215    clang-22
nios2                 randconfig-001-20260215    gcc-8.5.0
nios2                 randconfig-002-20260215    clang-22
nios2                 randconfig-002-20260215    gcc-8.5.0
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
parisc                randconfig-001-20260215    clang-22
parisc                randconfig-001-20260215    gcc-11.5.0
parisc                randconfig-002-20260215    clang-22
parisc                randconfig-002-20260215    gcc-10.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                    gamecube_defconfig    clang-22
powerpc                 mpc836x_rdk_defconfig    clang-22
powerpc                      ppc6xx_defconfig    clang-22
powerpc               randconfig-001-20260215    clang-22
powerpc               randconfig-001-20260215    gcc-11.5.0
powerpc               randconfig-002-20260215    clang-22
powerpc                     redwood_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260215    clang-22
powerpc64             randconfig-002-20260215    clang-22
powerpc64             randconfig-002-20260215    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv             nommu_k210_sdcard_defconfig    clang-22
riscv                 randconfig-001-20260215    gcc-13.4.0
riscv                 randconfig-001-20260215    gcc-8.5.0
riscv                 randconfig-002-20260215    gcc-11.5.0
riscv                 randconfig-002-20260215    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260215    gcc-13.4.0
s390                  randconfig-002-20260215    gcc-13.4.0
s390                  randconfig-002-20260215    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                               j2_defconfig    gcc-15.2.0
sh                          landisk_defconfig    clang-22
sh                    randconfig-001-20260215    gcc-13.4.0
sh                    randconfig-001-20260215    gcc-15.2.0
sh                    randconfig-002-20260215    gcc-11.5.0
sh                    randconfig-002-20260215    gcc-13.4.0
sh                            titan_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260215    gcc-15.2.0
sparc                 randconfig-001-20260215    gcc-9.5.0
sparc                 randconfig-002-20260215    gcc-8.5.0
sparc                 randconfig-002-20260215    gcc-9.5.0
sparc                       sparc32_defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260215    gcc-9.5.0
sparc64               randconfig-002-20260215    clang-22
sparc64               randconfig-002-20260215    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260215    clang-22
um                    randconfig-001-20260215    gcc-9.5.0
um                    randconfig-002-20260215    gcc-14
um                    randconfig-002-20260215    gcc-9.5.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260215    clang-20
x86_64      buildonly-randconfig-002-20260215    clang-20
x86_64      buildonly-randconfig-002-20260215    gcc-14
x86_64      buildonly-randconfig-003-20260215    clang-20
x86_64      buildonly-randconfig-004-20260215    clang-20
x86_64      buildonly-randconfig-005-20260215    clang-20
x86_64      buildonly-randconfig-005-20260215    gcc-14
x86_64      buildonly-randconfig-006-20260215    clang-20
x86_64      buildonly-randconfig-006-20260215    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260215    clang-20
x86_64                randconfig-001-20260215    gcc-14
x86_64                randconfig-002-20260215    gcc-14
x86_64                randconfig-003-20260215    clang-20
x86_64                randconfig-003-20260215    gcc-14
x86_64                randconfig-004-20260215    gcc-14
x86_64                randconfig-005-20260215    gcc-14
x86_64                randconfig-006-20260215    clang-20
x86_64                randconfig-006-20260215    gcc-14
x86_64                randconfig-011-20260215    gcc-14
x86_64                randconfig-012-20260215    gcc-14
x86_64                randconfig-013-20260215    gcc-14
x86_64                randconfig-014-20260215    gcc-14
x86_64                randconfig-015-20260215    gcc-14
x86_64                randconfig-016-20260215    gcc-14
x86_64                randconfig-071-20260215    gcc-14
x86_64                randconfig-072-20260215    gcc-14
x86_64                randconfig-073-20260215    gcc-14
x86_64                randconfig-074-20260215    gcc-14
x86_64                randconfig-075-20260215    gcc-14
x86_64                randconfig-076-20260215    gcc-14
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
xtensa                generic_kc705_defconfig    clang-22
xtensa                randconfig-001-20260215    gcc-12.5.0
xtensa                randconfig-001-20260215    gcc-9.5.0
xtensa                randconfig-002-20260215    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
