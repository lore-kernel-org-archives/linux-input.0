Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97438279DB6
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782497521; cv=none; b=rfrO+19lIiVmRVCrzGch7Dt90CAdfvjt++9XAeh/xU9Yg8OW/F2UQD0Djo+HbcYRtu5pDXNjgH6ihZW2QO9FzZwUjHsIQetazITcwHMXbPE+nIGm1yX0E3YLEhL3LG5v0uQEikGSTvix4iTtVsr0+H1iV0EEFLDDC9OhOWRPqiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782497521; c=relaxed/simple;
	bh=RFOnU62AM63fYwgnCVOUnr6iJ0egJrWV9R2q42K1KgY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ppD1BCHDpUJ9lMPCJRrqEJ1G9Ng3h8wutOHoEr5kBh5zfj4+PiUTUDwBsXIXBdAmOsgArGu57jg5uKke3EArlL6yE4uCczPEbDk0krdAX81JYHGhAoKe36xsXAmxbjJLCHozbp7m5YyhODC1Xo/99k8u6xKxgt5/gFXphxAFcwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sc++KTYa; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sc++KTYa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782497519; x=1814033519;
  h=date:from:to:cc:subject:message-id;
  bh=RFOnU62AM63fYwgnCVOUnr6iJ0egJrWV9R2q42K1KgY=;
  b=Sc++KTYaXCwRtSqaI4wtao4xGg/X4sime5RSREEcSQIehTVw4OCyXVxu
   CiTOusyWgLYJ7QjRC1cLuirHsroFKe+eEqXLSEyeZmvFOvhIcuqgOmCh0
   7O+tAD+5rIszqafcgk98w5ePTONQ3E05orpO6NlXu6fmbSob12ie+CQUI
   Vjxpdq2HTiMLegJJaWwWE7rwxFpoh3lDF3yLn4R21IT6Rgh0adIRgR2mL
   dvC70QwTijUNTcwwM/1y7hHGoaXk75x+WLeAcZqedSjGhFi4+NYeQshTK
   jH0ZLN2O/Qdqqgh9/Zc517sZQhAzGINQBksvv8h9bf4T0pVlQTiUIrr8M
   Q==;
X-CSE-ConnectionGUID: xeLONGGnRZOztkVvWbo8bg==
X-CSE-MsgGUID: 3djW6RhoSLyZK6P9C5mBQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="85844404"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="85844404"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 11:11:59 -0700
X-CSE-ConnectionGUID: kWhkNUjgSY6w0bJUmwRQpA==
X-CSE-MsgGUID: +1ruoZ3MQrGiUtCDMWrfwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="250303939"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 26 Jun 2026 11:11:57 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wdB1u-000000005KH-3KfN;
	Fri, 26 Jun 2026 18:11:54 +0000
Date: Sat, 27 Jun 2026 02:11:01 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:for-linus] BUILD SUCCESS
 d577e46785d45484b2ab7e7309c49b18764bf56c
Message-ID: <202606270251.cFZTKTnO-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
branch HEAD: d577e46785d45484b2ab7e7309c49b18764bf56c  Input: synaptics-rmi4 - bound the F30 keymap to the GPIO/LED count

elapsed time: 771m

configs tested: 299
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260626    gcc-11.5.0
arc                   randconfig-001-20260626    gcc-13.4.0
arc                   randconfig-002-20260626    gcc-13.4.0
arc                   randconfig-002-20260626    gcc-9.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260626    gcc-13.4.0
arm                   randconfig-002-20260626    clang-23
arm                   randconfig-002-20260626    gcc-13.4.0
arm                   randconfig-003-20260626    gcc-13.4.0
arm                   randconfig-004-20260626    clang-21
arm                   randconfig-004-20260626    gcc-13.4.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    clang-23
arm64                 randconfig-001-20260626    clang-23
arm64                 randconfig-001-20260626    gcc-8.5.0
arm64                          randconfig-002    clang-23
arm64                 randconfig-002-20260626    clang-23
arm64                 randconfig-002-20260626    gcc-8.5.0
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260626    clang-23
arm64                 randconfig-003-20260626    gcc-8.5.0
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260626    clang-23
arm64                 randconfig-004-20260626    gcc-8.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    clang-23
csky                  randconfig-001-20260626    clang-23
csky                  randconfig-001-20260626    gcc-8.5.0
csky                           randconfig-002    clang-23
csky                  randconfig-002-20260626    clang-23
csky                  randconfig-002-20260626    gcc-8.5.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260626    gcc-11.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260626    gcc-11.5.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260626    gcc-14
i386        buildonly-randconfig-002-20260626    gcc-14
i386        buildonly-randconfig-003-20260626    gcc-14
i386        buildonly-randconfig-004-20260626    gcc-14
i386        buildonly-randconfig-005-20260626    gcc-14
i386        buildonly-randconfig-006-20260626    gcc-14
i386                                defconfig    gcc-16.1.0
i386                           randconfig-001    gcc-14
i386                  randconfig-001-20260626    clang-22
i386                  randconfig-001-20260626    gcc-14
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260626    gcc-14
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260626    clang-22
i386                  randconfig-003-20260626    gcc-14
i386                           randconfig-004    gcc-14
i386                  randconfig-004-20260626    clang-22
i386                  randconfig-004-20260626    gcc-14
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260626    gcc-14
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260626    gcc-14
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260626    gcc-14
i386                  randconfig-011-20260626    gcc-14
i386                  randconfig-012-20260626    gcc-14
i386                  randconfig-013-20260626    gcc-14
i386                  randconfig-014-20260626    gcc-14
i386                  randconfig-015-20260626    gcc-14
i386                  randconfig-016-20260626    gcc-14
i386                  randconfig-017-20260626    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260626    gcc-11.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260626    gcc-11.5.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
microblaze                          defconfig    gcc-16.1.0
microblaze                      mmu_defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                     loongson2k_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                               defconfig    gcc-11.5.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260626    gcc-11.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260626    gcc-11.5.0
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-8.5.0
parisc                randconfig-001-20260626    gcc-8.5.0
parisc                         randconfig-002    gcc-8.5.0
parisc                randconfig-002-20260626    gcc-12.5.0
parisc                randconfig-002-20260626    gcc-8.5.0
parisc64                            defconfig    clang-23
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    gcc-16.1.0
powerpc                      ep88xc_defconfig    gcc-16.1.0
powerpc                        randconfig-001    gcc-8.5.0
powerpc               randconfig-001-20260626    clang-23
powerpc               randconfig-001-20260626    gcc-8.5.0
powerpc                        randconfig-002    gcc-8.5.0
powerpc               randconfig-002-20260626    gcc-11.5.0
powerpc               randconfig-002-20260626    gcc-8.5.0
powerpc64                      randconfig-001    gcc-8.5.0
powerpc64             randconfig-001-20260626    clang-23
powerpc64             randconfig-001-20260626    gcc-8.5.0
powerpc64                      randconfig-002    gcc-8.5.0
powerpc64             randconfig-002-20260626    gcc-13.4.0
powerpc64             randconfig-002-20260626    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    clang-23
riscv                 randconfig-001-20260626    clang-23
riscv                 randconfig-001-20260626    gcc-11.5.0
riscv                          randconfig-002    clang-23
riscv                 randconfig-002-20260626    clang-23
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    clang-23
s390                  randconfig-001-20260626    clang-23
s390                           randconfig-002    clang-23
s390                  randconfig-002-20260626    clang-23
s390                  randconfig-002-20260626    gcc-8.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-16.1.0
sh                             randconfig-001    clang-23
sh                    randconfig-001-20260626    clang-23
sh                    randconfig-001-20260626    gcc-9.5.0
sh                             randconfig-002    clang-23
sh                    randconfig-002-20260626    clang-23
sh                    randconfig-002-20260626    gcc-16.1.0
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-16.1.0
sparc                 randconfig-001-20260626    gcc-12.5.0
sparc                          randconfig-002    gcc-11.5.0
sparc                 randconfig-002-20260626    gcc-12.5.0
sparc                 randconfig-002-20260626    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-12.5.0
sparc64               randconfig-001-20260626    clang-20
sparc64               randconfig-001-20260626    gcc-12.5.0
sparc64                        randconfig-002    clang-20
sparc64               randconfig-002-20260626    clang-20
sparc64               randconfig-002-20260626    gcc-12.5.0
um                               allmodconfig    clang-23
um                                allnoconfig    clang-16
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    clang-23
um                    randconfig-001-20260626    clang-18
um                    randconfig-001-20260626    gcc-12.5.0
um                             randconfig-002    clang-23
um                    randconfig-002-20260626    clang-23
um                    randconfig-002-20260626    gcc-12.5.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    gcc-14
x86_64      buildonly-randconfig-001-20260626    clang-22
x86_64      buildonly-randconfig-001-20260626    gcc-14
x86_64               buildonly-randconfig-002    gcc-14
x86_64      buildonly-randconfig-002-20260626    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260626    clang-22
x86_64      buildonly-randconfig-003-20260626    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260626    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260626    clang-22
x86_64      buildonly-randconfig-005-20260626    gcc-14
x86_64               buildonly-randconfig-006    gcc-14
x86_64      buildonly-randconfig-006-20260626    clang-22
x86_64      buildonly-randconfig-006-20260626    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                         randconfig-001    gcc-14
x86_64                randconfig-001-20260626    clang-22
x86_64                         randconfig-002    gcc-14
x86_64                randconfig-002-20260626    clang-22
x86_64                randconfig-002-20260626    gcc-14
x86_64                         randconfig-003    clang-22
x86_64                randconfig-003-20260626    clang-22
x86_64                         randconfig-004    clang-22
x86_64                randconfig-004-20260626    clang-22
x86_64                         randconfig-005    gcc-14
x86_64                randconfig-005-20260626    clang-22
x86_64                randconfig-005-20260626    gcc-13
x86_64                         randconfig-006    clang-22
x86_64                randconfig-006-20260626    clang-22
x86_64                         randconfig-011    gcc-14
x86_64                randconfig-011-20260626    gcc-14
x86_64                         randconfig-012    gcc-14
x86_64                randconfig-012-20260626    gcc-14
x86_64                         randconfig-013    clang-22
x86_64                         randconfig-013    gcc-14
x86_64                randconfig-013-20260626    clang-22
x86_64                randconfig-013-20260626    gcc-14
x86_64                         randconfig-014    gcc-14
x86_64                randconfig-014-20260626    gcc-14
x86_64                         randconfig-015    gcc-14
x86_64                randconfig-015-20260626    gcc-14
x86_64                         randconfig-016    clang-22
x86_64                         randconfig-016    gcc-14
x86_64                randconfig-016-20260626    gcc-14
x86_64                         randconfig-071    gcc-14
x86_64                randconfig-071-20260626    gcc-14
x86_64                         randconfig-072    gcc-14
x86_64                randconfig-072-20260626    clang-22
x86_64                randconfig-072-20260626    gcc-14
x86_64                         randconfig-073    clang-22
x86_64                         randconfig-073    gcc-14
x86_64                randconfig-073-20260626    gcc-14
x86_64                         randconfig-074    gcc-14
x86_64                randconfig-074-20260626    gcc-14
x86_64                         randconfig-075    gcc-13
x86_64                         randconfig-075    gcc-14
x86_64                randconfig-075-20260626    gcc-14
x86_64                         randconfig-076    clang-22
x86_64                         randconfig-076    gcc-14
x86_64                randconfig-076-20260626    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260626    gcc-12.5.0
xtensa                         randconfig-002    gcc-13.4.0
xtensa                randconfig-002-20260626    gcc-10.5.0
xtensa                randconfig-002-20260626    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
