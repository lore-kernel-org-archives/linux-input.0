Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D7F1B6D1A
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 22:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785796055; cv=none; b=msMvXbM/7KRX3omZHZJtjsdJTS7buYFvJ4zqrYMZSmEMa9Pu/t+9ZVwsI6Xu4HBo2A8wsQl9y26oIyU5Rpn9tJ0QATEBAbP98n+F5Ek7s3fzi/X0mc9dPHJQtXTwhBRHPw8pKSoxjHnFGnMKquBz/MYina2wuEns+3hXeIf+tHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785796055; c=relaxed/simple;
	bh=Xyjnpx4Ud6qLRMoAR6kH/FQpZ65BwWkrJuLFLKC4IX8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UpDId0LKbKcwwNZ5dnntkVehEVfqR3/ukJIBO/sdAwb4ZHvNQ0gtuyfLUjBiyRb1mZXPQzhImkvOLREmRKkvaPHBtcRGSqoavpV7H3lnXTN84PQmDcGYh1KKq21hY7rg6pLc204AVIxjEW1ds7XG3ohFRQ2O8IfTYfFjNcneoZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gRwFL1nD; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gRwFL1nD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785796054; x=1817332054;
  h=date:from:to:cc:subject:message-id;
  bh=Xyjnpx4Ud6qLRMoAR6kH/FQpZ65BwWkrJuLFLKC4IX8=;
  b=gRwFL1nDUVJe34s/337Avge+dWOksHojSyCQoroZ2D6x9dI/iJEbKuUe
   xkbux+zyWo9Mp8lFajkRSUMB30rnm118aS2e6G/Auix600MBUrkqpDMgZ
   Zb2O/MmXoKZT1XoLvhdpb1MCIfGBJj6FgzzV0bJQ51k/Rlql6/5tEpd6V
   diXfEHkkpuIrbCdFa3VODhSeaiXI09yyuUQ9f7vz1n/uulfKk5ikwrwiH
   f78j9NfVME5R19zLirk9a3t1UuiVXl12+sgjjvN8WUNw4nQa4KmiSegNX
   LAeWV+Ru5c7toEZASCpaMB8lsqyDBhOyV0TjNs/Qh/9wKDHpGa8TRi5Ak
   A==;
X-CSE-ConnectionGUID: YkX+6N3sQzCAet5xzcjmsg==
X-CSE-MsgGUID: iCQCD4OeSzadNnXU+iltWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="103745117"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="103745117"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 15:27:33 -0700
X-CSE-ConnectionGUID: GX3C7qPVTqSUBT3wuYJkvA==
X-CSE-MsgGUID: Y6Rt1GvlTBmDYg803YgPww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="260081590"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 03 Aug 2026 15:27:33 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wr185-0000000089F-2SbY;
	Mon, 03 Aug 2026 22:27:30 +0000
Date: Tue, 04 Aug 2026 06:26:25 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:master] BUILD SUCCESS
 50411cada028f54d859d4b2361c1d87168562c49
Message-ID: <202608040611.KduMFBmB-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git master
branch HEAD: 50411cada028f54d859d4b2361c1d87168562c49  Input: samsung-keypad - use pm_runtime_active guard

elapsed time: 750m

configs tested: 180
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260803    gcc-8.5.0
arc                  randconfig-001-20260804    gcc-8.5.0
arc                  randconfig-002-20260803    gcc-8.5.0
arc                  randconfig-002-20260804    gcc-8.5.0
arm                  randconfig-001-20260803    gcc-8.5.0
arm                  randconfig-001-20260804    gcc-8.5.0
arm                  randconfig-002-20260803    gcc-8.5.0
arm                  randconfig-002-20260804    gcc-8.5.0
arm                  randconfig-003-20260803    gcc-8.5.0
arm                  randconfig-003-20260804    gcc-8.5.0
arm                  randconfig-004-20260803    gcc-8.5.0
arm                  randconfig-004-20260804    gcc-8.5.0
arm                          stm32_defconfig    gcc-16.1.0
arm64                randconfig-001-20260803    gcc-12.5.0
arm64                randconfig-001-20260804    gcc-11.5.0
arm64                randconfig-002-20260803    gcc-12.5.0
arm64                randconfig-002-20260804    gcc-11.5.0
arm64                randconfig-003-20260803    gcc-12.5.0
arm64                randconfig-003-20260804    gcc-11.5.0
arm64                randconfig-004-20260803    gcc-12.5.0
arm64                randconfig-004-20260804    gcc-11.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260803    gcc-12.5.0
csky                 randconfig-001-20260804    gcc-11.5.0
csky                 randconfig-002-20260803    gcc-12.5.0
csky                 randconfig-002-20260804    gcc-11.5.0
hexagon              randconfig-001-20260803    clang-18
hexagon              randconfig-001-20260804    gcc-16.1.0
hexagon              randconfig-002-20260803    clang-18
hexagon              randconfig-002-20260804    gcc-16.1.0
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    clang-22
i386       buildonly-randconfig-001-20260803    clang-22
i386       buildonly-randconfig-001-20260804    gcc-14
i386       buildonly-randconfig-002-20260803    clang-22
i386       buildonly-randconfig-002-20260804    gcc-14
i386       buildonly-randconfig-003-20260803    clang-22
i386       buildonly-randconfig-003-20260804    gcc-14
i386       buildonly-randconfig-004-20260803    clang-22
i386       buildonly-randconfig-004-20260804    gcc-14
i386       buildonly-randconfig-005-20260803    clang-22
i386       buildonly-randconfig-005-20260804    gcc-14
i386       buildonly-randconfig-006-20260803    clang-22
i386       buildonly-randconfig-006-20260804    gcc-14
i386                          randconfig-001    gcc-13
i386                 randconfig-001-20260803    gcc-13
i386                 randconfig-001-20260804    clang-22
i386                 randconfig-002-20260803    gcc-13
i386                 randconfig-002-20260804    clang-22
i386                 randconfig-003-20260803    gcc-13
i386                 randconfig-003-20260804    clang-22
i386                 randconfig-004-20260803    gcc-13
i386                 randconfig-004-20260804    clang-22
i386                 randconfig-005-20260803    gcc-13
i386                 randconfig-005-20260804    clang-22
i386                 randconfig-006-20260803    gcc-13
i386                 randconfig-006-20260804    clang-22
i386                 randconfig-007-20260803    gcc-13
i386                 randconfig-007-20260804    clang-22
i386                 randconfig-011-20260803    clang-22
i386                 randconfig-011-20260804    gcc-13
i386                 randconfig-012-20260803    clang-22
i386                 randconfig-012-20260804    gcc-13
i386                 randconfig-013-20260803    clang-22
i386                 randconfig-013-20260804    gcc-13
i386                 randconfig-014-20260803    clang-22
i386                 randconfig-014-20260804    gcc-13
i386                 randconfig-015-20260803    clang-22
i386                 randconfig-015-20260804    gcc-13
i386                 randconfig-016-20260803    clang-22
i386                 randconfig-016-20260804    gcc-13
i386                 randconfig-017-20260803    clang-22
i386                 randconfig-017-20260804    gcc-13
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260803    clang-18
loongarch            randconfig-001-20260804    gcc-16.1.0
loongarch            randconfig-002-20260803    clang-18
loongarch            randconfig-002-20260804    gcc-16.1.0
mips                      bmips_be_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260803    clang-18
nios2                randconfig-001-20260804    gcc-16.1.0
nios2                randconfig-002-20260803    clang-18
nios2                randconfig-002-20260804    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-15.2.0
parisc               randconfig-001-20260803    gcc-15.2.0
parisc               randconfig-001-20260804    gcc-8.5.0
parisc               randconfig-002-20260803    gcc-15.2.0
parisc               randconfig-002-20260804    gcc-8.5.0
powerpc                      eiger_defconfig    clang-24
powerpc              randconfig-001-20260803    gcc-15.2.0
powerpc              randconfig-001-20260804    gcc-8.5.0
powerpc              randconfig-002-20260803    gcc-15.2.0
powerpc              randconfig-002-20260804    gcc-8.5.0
powerpc                    redwood_defconfig    clang-24
powerpc                    taishan_defconfig    clang-21
powerpc64            randconfig-001-20260803    gcc-15.2.0
powerpc64            randconfig-001-20260804    gcc-8.5.0
powerpc64            randconfig-002-20260803    gcc-15.2.0
powerpc64            randconfig-002-20260804    gcc-8.5.0
riscv                         randconfig-001    gcc-8.5.0
riscv                randconfig-001-20260803    gcc-8.5.0
riscv                randconfig-002-20260803    gcc-8.5.0
s390                 randconfig-001-20260803    gcc-8.5.0
s390                 randconfig-002-20260803    gcc-8.5.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260803    gcc-8.5.0
sh                   randconfig-002-20260803    gcc-8.5.0
sh                          se7751_defconfig    gcc-16.1.0
sparc                randconfig-001-20260803    gcc-16.1.0
sparc                randconfig-001-20260804    gcc-16.1.0
sparc                randconfig-002-20260803    gcc-16.1.0
sparc                randconfig-002-20260804    gcc-16.1.0
sparc64              randconfig-001-20260803    gcc-16.1.0
sparc64              randconfig-001-20260804    gcc-16.1.0
sparc64              randconfig-002-20260803    gcc-16.1.0
sparc64              randconfig-002-20260804    gcc-16.1.0
um                   randconfig-001-20260803    gcc-16.1.0
um                   randconfig-001-20260804    gcc-16.1.0
um                   randconfig-002-20260803    gcc-16.1.0
um                   randconfig-002-20260804    gcc-16.1.0
x86_64     buildonly-randconfig-001-20260803    clang-22
x86_64     buildonly-randconfig-001-20260804    gcc-14
x86_64     buildonly-randconfig-002-20260803    clang-22
x86_64     buildonly-randconfig-002-20260804    gcc-14
x86_64     buildonly-randconfig-003-20260803    clang-22
x86_64     buildonly-randconfig-003-20260804    gcc-14
x86_64     buildonly-randconfig-004-20260803    clang-22
x86_64     buildonly-randconfig-004-20260804    gcc-14
x86_64     buildonly-randconfig-005-20260803    clang-22
x86_64     buildonly-randconfig-005-20260804    gcc-14
x86_64     buildonly-randconfig-006-20260803    clang-22
x86_64     buildonly-randconfig-006-20260804    gcc-14
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    gcc-14
x86_64               randconfig-001-20260803    gcc-14
x86_64               randconfig-001-20260804    gcc-14
x86_64               randconfig-002-20260803    gcc-14
x86_64               randconfig-002-20260804    gcc-14
x86_64               randconfig-003-20260803    gcc-14
x86_64               randconfig-003-20260804    gcc-14
x86_64               randconfig-004-20260803    gcc-14
x86_64               randconfig-004-20260804    gcc-14
x86_64               randconfig-005-20260803    gcc-14
x86_64               randconfig-005-20260804    gcc-14
x86_64               randconfig-006-20260803    gcc-14
x86_64               randconfig-006-20260804    gcc-14
x86_64               randconfig-011-20260803    gcc-14
x86_64               randconfig-011-20260804    clang-22
x86_64               randconfig-012-20260803    gcc-14
x86_64               randconfig-012-20260804    clang-22
x86_64               randconfig-013-20260803    gcc-14
x86_64               randconfig-013-20260804    clang-22
x86_64               randconfig-014-20260803    gcc-14
x86_64               randconfig-014-20260804    clang-22
x86_64               randconfig-015-20260803    gcc-14
x86_64               randconfig-015-20260804    clang-22
x86_64               randconfig-016-20260803    gcc-14
x86_64               randconfig-016-20260804    clang-22
x86_64                        randconfig-071    clang-22
x86_64               randconfig-071-20260803    clang-22
x86_64               randconfig-072-20260803    clang-22
x86_64               randconfig-073-20260803    clang-22
x86_64               randconfig-074-20260803    clang-22
x86_64               randconfig-075-20260803    clang-22
x86_64               randconfig-076-20260803    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260803    gcc-16.1.0
xtensa               randconfig-001-20260804    gcc-16.1.0
xtensa               randconfig-002-20260803    gcc-16.1.0
xtensa               randconfig-002-20260804    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
