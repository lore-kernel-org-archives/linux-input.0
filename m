Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCA3331ED6
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781118226; cv=none; b=q929yYY4PvnRubBoP8xjPEhVMEJVuy9IphvFrGE9JiSNslWc7dWQWFi5/VwZX3yhQtF89B8zf3zMSkXXvqOCS9oZxNm361WoiLeltsRSUpKaMNI/MgpJ0Ya9f6+6DldVruexbfof5VMhLVKrY3wi9Wb1TrCotzqgrn13qXTc//c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781118226; c=relaxed/simple;
	bh=cesEysJL3Zqq4/LfqgDSWtbp8TESB76svGB/eqMku/A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DbgesRIggDf2KB4qxK2Vu+StfqZlG4glcM9aDouUuG7kLHyyPG1vTMGlHNla3Bu2b1kOGxZkZLb3K3RVzD+4VUtpQnJ9/EGT5NZMa+w16qhE3MFlQynCKKDz9GEWi1gS/RWwLWfeqwJaqAv3t6zW9oyEwE1p3M+RWUBNB8LO05Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IGbMIFdk; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IGbMIFdk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781118225; x=1812654225;
  h=date:from:to:cc:subject:message-id;
  bh=cesEysJL3Zqq4/LfqgDSWtbp8TESB76svGB/eqMku/A=;
  b=IGbMIFdkeFa9klSzeaBmLBrQS7+uFjzF86T7k7C16pwSilKiRGZT6l6s
   QPlfjOlNR0mgerHo0sg7y3FUf3BQsPSAL/sC+OOm//Oga1sDfTVxP96Xl
   oXZHOTcC9H5fh9pPduHRIj9IxIeuGYc1L26N6VjwZqUsossWzJNm2R4BV
   FPbgpSlpyZF1lJMGTSwzM0kkklGGHmb71ljxddW7flbxLnOUpd9JPwCi8
   /yAbeNuqItKZqkJVUSoui47og2ZwqHzfqEiJiHwkIbNWrUt9tcQ1lQ27e
   aIfUbKo8WYcXkBL2qMcGywczRF1E0oH6JopLCHYoR4rUs4LNjuhHLcu+s
   Q==;
X-CSE-ConnectionGUID: xg+rgqrDRdm/IxWhHvhS1A==
X-CSE-MsgGUID: a5sxBPDnQECMm2bYfcgayg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="104586612"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="104586612"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 12:03:44 -0700
X-CSE-ConnectionGUID: jSWip93RRtyjUU18B4DawA==
X-CSE-MsgGUID: PyCkhAHCTwqqK1UY3Uh5cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="250168329"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 10 Jun 2026 12:03:42 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wXODE-00000000Lmk-0DPm;
	Wed, 10 Jun 2026 19:03:40 +0000
Date: Thu, 11 Jun 2026 03:02:51 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:next] BUILD SUCCESS
 ead562291438b5657d7e4d5e8d6d54611b132370
Message-ID: <202606110342.N0NFGCku-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
branch HEAD: ead562291438b5657d7e4d5e8d6d54611b132370  Input: ipaq-micro-keys - simplify allocation

elapsed time: 761m

configs tested: 236
configs skipped: 3

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
arc                   randconfig-001-20260610    gcc-8.5.0
arc                   randconfig-001-20260611    gcc-14.3.0
arc                   randconfig-002-20260610    gcc-8.5.0
arc                   randconfig-002-20260611    gcc-14.3.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                        mvebu_v7_defconfig    clang-23
arm                   randconfig-001-20260610    gcc-8.5.0
arm                   randconfig-001-20260611    gcc-14.3.0
arm                   randconfig-002-20260610    gcc-8.5.0
arm                   randconfig-002-20260611    gcc-14.3.0
arm                   randconfig-003-20260610    gcc-8.5.0
arm                   randconfig-003-20260611    gcc-14.3.0
arm                   randconfig-004-20260610    gcc-8.5.0
arm                   randconfig-004-20260611    gcc-14.3.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260610    gcc-11.5.0
arm64                 randconfig-002-20260610    gcc-11.5.0
arm64                 randconfig-003-20260610    gcc-11.5.0
arm64                 randconfig-004-20260610    gcc-11.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260610    gcc-11.5.0
csky                  randconfig-002-20260610    gcc-11.5.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260610    clang-22
hexagon               randconfig-002-20260610    clang-22
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260610    gcc-14
i386        buildonly-randconfig-002-20260610    gcc-14
i386        buildonly-randconfig-003-20260610    gcc-14
i386        buildonly-randconfig-004-20260610    gcc-14
i386        buildonly-randconfig-005-20260610    gcc-14
i386        buildonly-randconfig-006-20260610    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260610    gcc-14
i386                  randconfig-002-20260610    gcc-14
i386                  randconfig-003-20260610    gcc-14
i386                  randconfig-004-20260610    gcc-14
i386                  randconfig-005-20260610    gcc-14
i386                  randconfig-006-20260610    gcc-14
i386                  randconfig-007-20260610    gcc-14
i386                  randconfig-011-20260610    gcc-14
i386                  randconfig-012-20260610    gcc-14
i386                  randconfig-013-20260610    gcc-14
i386                  randconfig-014-20260610    gcc-14
i386                  randconfig-015-20260610    gcc-14
i386                  randconfig-016-20260610    gcc-14
i386                  randconfig-017-20260610    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260610    clang-22
loongarch             randconfig-002-20260610    clang-22
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                         apollo_defconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                        m5272c3_defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260610    clang-22
nios2                 randconfig-002-20260610    clang-22
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    clang-23
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260610    gcc-8.5.0
parisc                randconfig-001-20260611    gcc-13.4.0
parisc                randconfig-002-20260610    gcc-8.5.0
parisc                randconfig-002-20260611    gcc-13.4.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-001-20260610    gcc-8.5.0
powerpc               randconfig-001-20260611    gcc-13.4.0
powerpc               randconfig-002-20260610    gcc-8.5.0
powerpc               randconfig-002-20260611    gcc-13.4.0
powerpc64             randconfig-001-20260610    gcc-8.5.0
powerpc64             randconfig-001-20260611    gcc-13.4.0
powerpc64             randconfig-002-20260610    gcc-8.5.0
powerpc64             randconfig-002-20260611    gcc-13.4.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    gcc-16.1.0
riscv                 randconfig-001-20260610    gcc-16.1.0
riscv                          randconfig-002    gcc-16.1.0
riscv                 randconfig-002-20260610    gcc-16.1.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    gcc-16.1.0
s390                  randconfig-001-20260610    gcc-16.1.0
s390                           randconfig-002    gcc-16.1.0
s390                  randconfig-002-20260610    gcc-16.1.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    clang-23
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-16.1.0
sh                    randconfig-001-20260610    gcc-16.1.0
sh                             randconfig-002    gcc-16.1.0
sh                    randconfig-002-20260610    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-14.3.0
sparc                 randconfig-001-20260610    gcc-14.3.0
sparc                 randconfig-001-20260611    gcc-15.2.0
sparc                          randconfig-002    gcc-14.3.0
sparc                 randconfig-002-20260610    gcc-14.3.0
sparc                 randconfig-002-20260611    gcc-15.2.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-14.3.0
sparc64               randconfig-001-20260610    gcc-14.3.0
sparc64               randconfig-001-20260611    gcc-15.2.0
sparc64                        randconfig-002    gcc-14.3.0
sparc64               randconfig-002-20260610    gcc-14.3.0
sparc64               randconfig-002-20260611    gcc-15.2.0
um                               allmodconfig    clang-17
um                               allmodconfig    clang-23
um                                allnoconfig    clang-16
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-14.3.0
um                    randconfig-001-20260610    gcc-14.3.0
um                    randconfig-001-20260611    gcc-15.2.0
um                             randconfig-002    gcc-14.3.0
um                    randconfig-002-20260610    gcc-14.3.0
um                    randconfig-002-20260611    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260610    gcc-14
x86_64      buildonly-randconfig-002-20260610    gcc-14
x86_64      buildonly-randconfig-003-20260610    gcc-14
x86_64      buildonly-randconfig-004-20260610    gcc-14
x86_64      buildonly-randconfig-005-20260610    gcc-14
x86_64      buildonly-randconfig-006-20260610    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260610    gcc-13
x86_64                randconfig-002-20260610    gcc-13
x86_64                randconfig-003-20260610    gcc-13
x86_64                randconfig-004-20260610    gcc-13
x86_64                randconfig-005-20260610    gcc-13
x86_64                randconfig-006-20260610    gcc-13
x86_64                randconfig-011-20260610    gcc-14
x86_64                randconfig-012-20260610    gcc-14
x86_64                randconfig-013-20260610    gcc-14
x86_64                randconfig-014-20260610    gcc-14
x86_64                randconfig-015-20260610    gcc-14
x86_64                randconfig-016-20260610    gcc-14
x86_64                randconfig-071-20260610    gcc-14
x86_64                randconfig-072-20260610    gcc-14
x86_64                randconfig-073-20260610    gcc-14
x86_64                randconfig-074-20260610    gcc-14
x86_64                randconfig-075-20260610    gcc-14
x86_64                randconfig-076-20260610    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                           allyesconfig    gcc-16.1.0
xtensa                         randconfig-001    gcc-14.3.0
xtensa                randconfig-001-20260610    gcc-14.3.0
xtensa                randconfig-001-20260611    gcc-15.2.0
xtensa                         randconfig-002    gcc-14.3.0
xtensa                randconfig-002-20260610    gcc-14.3.0
xtensa                randconfig-002-20260611    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
