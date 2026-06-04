Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427441C5F27
	for <linux-input@vger.kernel.org>; Thu,  4 Jun 2026 03:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780544259; cv=none; b=W8hyan3hm7+jbqnrUJ0m9oy2vQwtAjWdb4RgTbqEuU+E+hf0QYdwYJoZgxznDSrW/6ALcP6nOwGg8pASYIwkgLGVTU9o+xqfA+mGeizFHoGZmvCwIwvojUiB4soBYVCuIuaN4jgPLhQWmsr7Ffr2UtKXEr8CpGjsEZpePYKxMOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780544259; c=relaxed/simple;
	bh=uqrQR9mlAKqG4V6+UI/4bqWVlfPS3e0DujZJpvqw5Hg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jwHCXX7JSAccXkwOs1na2Y6jMXLNB3mxSCtUM7LmOq5yhON23AVWbyXtOA5UFFJcP8NFEvCCdZFtYF/9+rUsnx/8hOX5s/M2vQOpYmqxMk3TbXi8KS/O5Gav1xeaAx7GdTXkNADVJrxcMHN8oBdxehc4Oz0fWff6szOcav+gQE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NVOdaYmM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVOdaYmM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780544258; x=1812080258;
  h=date:from:to:cc:subject:message-id;
  bh=uqrQR9mlAKqG4V6+UI/4bqWVlfPS3e0DujZJpvqw5Hg=;
  b=NVOdaYmMytOZW+qosV+31F9peMy+exYnwZpaMhGCp6B5n3w50lK44538
   CEimfxNJEGg0xigiS8zlVHfvUKOXc50/4J50ywFHWHImBOoWLpp2aLu24
   u66LtRoQemYkuOIbeV3ztYsQZW4Ae23+NKSZfQUmuE3Qz/OCGgmScGN2h
   CLHJQ57NWE27LFq1N4iUq6XiqnCulzdyQZWPRpTW5u9lc400aS9Nu6fQO
   K6J5zyk95fsyFCThNnJx14qqQZjwoK3rG0WruMKF9VS6/kE6DC03y/4cF
   SPO0bs0QQN/0aJlrkJ/ar+/0iW1wz3S/+avaqsijEDvZ3JNXV9Wsv1T2w
   Q==;
X-CSE-ConnectionGUID: aFluhdNfT3yHeZw4CysYqg==
X-CSE-MsgGUID: KACnEgEqSJul5jNJVANN0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81362501"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="81362501"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 20:37:38 -0700
X-CSE-ConnectionGUID: trdhPBoSQjy6RLePQUDxLQ==
X-CSE-MsgGUID: d8kcuCnGToqlMSsCe+ekow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="241920280"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 03 Jun 2026 20:37:36 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wUyti-00000000EEo-15Os;
	Thu, 04 Jun 2026 03:37:34 +0000
Date: Thu, 04 Jun 2026 11:37:04 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:for-linus] BUILD SUCCESS
 ad0979fe053e9f2db82da82188256ef6eb41095a
Message-ID: <202606041155.QhHRXjIL-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
branch HEAD: ad0979fe053e9f2db82da82188256ef6eb41095a  Input: atkbd - add DMI quirk for Lenovo Yoga Air 14 (83QK)

elapsed time: 1665m

configs tested: 147
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                   randconfig-001-20260604    clang-17
arc                   randconfig-002-20260604    clang-17
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260604    clang-17
arm                   randconfig-002-20260604    clang-17
arm                   randconfig-003-20260604    clang-17
arm                   randconfig-004-20260604    clang-17
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260604    gcc-11.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260604    gcc-11.5.0
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386        buildonly-randconfig-001-20260604    clang-20
i386        buildonly-randconfig-002-20260604    clang-20
i386        buildonly-randconfig-003-20260604    clang-20
i386        buildonly-randconfig-004-20260604    clang-20
i386        buildonly-randconfig-005-20260604    clang-20
i386        buildonly-randconfig-006-20260604    clang-20
i386                  randconfig-011-20260604    gcc-14
i386                  randconfig-012-20260604    gcc-14
i386                  randconfig-013-20260604    gcc-14
i386                  randconfig-014-20260604    gcc-14
i386                  randconfig-015-20260604    gcc-14
i386                  randconfig-016-20260604    gcc-14
i386                  randconfig-017-20260604    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260604    gcc-11.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260604    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-17
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260604    gcc-11.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260604    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-17
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-17
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-16.1.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-17
powerpc                           allnoconfig    gcc-15.2.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-17
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    clang-17
riscv                 randconfig-001-20260604    clang-17
riscv                          randconfig-002    clang-17
riscv                 randconfig-002-20260604    clang-17
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    clang-17
s390                  randconfig-001-20260604    clang-17
s390                           randconfig-002    clang-17
s390                  randconfig-002-20260604    clang-17
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-17
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    clang-17
sh                    randconfig-001-20260604    clang-17
sh                             randconfig-002    clang-17
sh                    randconfig-002-20260604    clang-17
sh                          urquell_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-17
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-16.1.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-17
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20260604    gcc-14
x86_64      buildonly-randconfig-002-20260604    gcc-14
x86_64      buildonly-randconfig-003-20260604    gcc-14
x86_64      buildonly-randconfig-004-20260604    gcc-14
x86_64      buildonly-randconfig-005-20260604    gcc-14
x86_64      buildonly-randconfig-006-20260604    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-17
xtensa                            allnoconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
