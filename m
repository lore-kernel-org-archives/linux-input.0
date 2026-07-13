Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CABC317162
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783925456; cv=none; b=Uxcmkd2c4ZW3n/Q6gCZob6KYr6WIbYmgUkfBL+fs7yJ8+cVQ58bAlXf2Be4VziZpBgWxSz2aFSAuHFyOvaPmb2yDPnTVJJ0qu3Vo7ZZsN8Oqn4iEveCXiNIP54pdlwWD8GxhRAH9jaRFoa3FkkuuCBdObxexaA9rvu5e8JIGF7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783925456; c=relaxed/simple;
	bh=08nU/WzdmQfLh5twBBN/uBQqltBiduJkwvBz6wuekqE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MbCOEz+YR/ITukT/WUKPrUcfX6cpgEkLHEKckaEXZjfcdYXVZqS/qg1RwPJdyuxIHD710S0efUMh/v9iNWhwD8B3PTjUydwzK1k94IdNbeI/SZuLmY0vxD8BKUqk44JdOqC62ZfOY9pA/i7G+xvu/zrLXwr9xVJFCUIAe8kdc8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eysmbjh8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eysmbjh8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783925455; x=1815461455;
  h=date:from:to:cc:subject:message-id;
  bh=08nU/WzdmQfLh5twBBN/uBQqltBiduJkwvBz6wuekqE=;
  b=eysmbjh84Iq+Ew9wzGWVU+K5HnL42qYIfBlk5VvpTiY1X0q7fux2NI1Y
   lLirB0oo3kvPal6jQCWZ2G+pm4OcZKGhAFFcLS50nwY5GJUtA7hOx+FUj
   2s8OILC0+V3z87dl2VW8/HWVr2Iui12SI2kdI8tqTshizusBJMS+q91Em
   tqnAyvych877P5C8JNHlNCbDgEhuQ2d4vVAgaIpW+mUypZWly8ZxMWLaf
   VOWTTK3dHPXRYskMgyIAwQtcnTp3hU/uoelj0deMkhWBPNGB4wQZ8i2Yb
   cW0RaEFWvxMNBRmjRe0w5d1WvxTw2RSd+kGX1yIqwTry6TUBB+PP9DoQE
   A==;
X-CSE-ConnectionGUID: KkSKmAGtTX2k/cL9iXF2ZA==
X-CSE-MsgGUID: cjXlD7fERkmF2FEq3lohqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84383340"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84383340"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 23:50:54 -0700
X-CSE-ConnectionGUID: XUcBVXXNSbevMOq/B0i0yg==
X-CSE-MsgGUID: kfq51GTQSG6WU3xXTN74HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="249098876"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 12 Jul 2026 23:50:52 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wjAUt-00000000LSa-1WXc;
	Mon, 13 Jul 2026 06:50:46 +0000
Date: Mon, 13 Jul 2026 14:49:39 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:for-linus] BUILD SUCCESS
 adea84ee6cdea611146c4251d3c1616f5a09feca
Message-ID: <202607131428.BPPpK4Qa-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
branch HEAD: adea84ee6cdea611146c4251d3c1616f5a09feca  Input: mms114 - fix multi-touch slot corruption

elapsed time: 722m

configs tested: 189
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260713    gcc-8.5.0
arc                   randconfig-002-20260713    gcc-8.5.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260713    gcc-8.5.0
arm                   randconfig-002-20260713    gcc-8.5.0
arm                   randconfig-003-20260713    gcc-8.5.0
arm                   randconfig-004-20260713    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    clang-23
arm64                 randconfig-001-20260713    clang-23
arm64                 randconfig-001-20260713    gcc-13.4.0
arm64                          randconfig-002    clang-23
arm64                 randconfig-002-20260713    clang-23
arm64                 randconfig-002-20260713    gcc-13.4.0
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260713    clang-23
arm64                 randconfig-003-20260713    gcc-13.4.0
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260713    clang-23
arm64                 randconfig-004-20260713    gcc-13.4.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    clang-23
csky                  randconfig-001-20260713    clang-23
csky                  randconfig-001-20260713    gcc-13.4.0
csky                           randconfig-002    clang-23
csky                  randconfig-002-20260713    clang-23
csky                  randconfig-002-20260713    gcc-13.4.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260713    clang-23
hexagon               randconfig-002-20260713    clang-23
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260713    gcc-14
i386        buildonly-randconfig-002-20260713    gcc-14
i386        buildonly-randconfig-003-20260713    gcc-14
i386        buildonly-randconfig-004-20260713    gcc-14
i386        buildonly-randconfig-005-20260713    gcc-14
i386        buildonly-randconfig-006-20260713    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260713    clang-22
i386                  randconfig-002-20260713    clang-22
i386                  randconfig-003-20260713    clang-22
i386                  randconfig-004-20260713    clang-22
i386                  randconfig-005-20260713    clang-22
i386                  randconfig-006-20260713    clang-22
i386                  randconfig-007-20260713    clang-22
i386                  randconfig-011-20260713    clang-22
i386                  randconfig-012-20260713    clang-22
i386                  randconfig-013-20260713    clang-22
i386                  randconfig-014-20260713    clang-22
i386                  randconfig-015-20260713    clang-22
i386                  randconfig-016-20260713    clang-22
i386                  randconfig-017-20260713    clang-22
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260713    clang-23
loongarch             randconfig-002-20260713    clang-23
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                  maltasmvp_eva_defconfig    gcc-16.1.0
mips                        omega2p_defconfig    clang-17
mips                          rm200_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260713    clang-23
nios2                 randconfig-002-20260713    clang-23
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260713    clang-23
parisc                randconfig-002-20260713    clang-23
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260713    clang-23
powerpc               randconfig-002-20260713    clang-23
powerpc64             randconfig-001-20260713    clang-23
powerpc64             randconfig-002-20260713    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    clang-19
riscv                 randconfig-001-20260713    clang-19
riscv                          randconfig-002    clang-19
riscv                 randconfig-002-20260713    clang-19
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    clang-19
s390                  randconfig-001-20260713    clang-19
s390                           randconfig-002    clang-19
s390                  randconfig-002-20260713    clang-19
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                             randconfig-001    clang-19
sh                    randconfig-001-20260713    clang-19
sh                             randconfig-002    clang-19
sh                    randconfig-002-20260713    clang-19
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260713    gcc-12.5.0
sparc                 randconfig-002-20260713    gcc-12.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260713    gcc-12.5.0
sparc64               randconfig-002-20260713    gcc-12.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260713    gcc-12.5.0
um                    randconfig-002-20260713    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260713    clang-22
x86_64      buildonly-randconfig-002-20260713    clang-22
x86_64      buildonly-randconfig-003-20260713    clang-22
x86_64      buildonly-randconfig-004-20260713    clang-22
x86_64      buildonly-randconfig-005-20260713    clang-22
x86_64      buildonly-randconfig-006-20260713    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260713    gcc-13
x86_64                randconfig-002-20260713    gcc-13
x86_64                randconfig-003-20260713    gcc-13
x86_64                randconfig-004-20260713    gcc-13
x86_64                randconfig-005-20260713    gcc-13
x86_64                randconfig-006-20260713    gcc-13
x86_64                randconfig-011-20260713    gcc-14
x86_64                randconfig-012-20260713    gcc-14
x86_64                randconfig-013-20260713    gcc-14
x86_64                randconfig-014-20260713    gcc-14
x86_64                randconfig-015-20260713    gcc-14
x86_64                randconfig-016-20260713    gcc-14
x86_64                randconfig-071-20260713    gcc-14
x86_64                randconfig-072-20260713    gcc-14
x86_64                randconfig-073-20260713    gcc-14
x86_64                randconfig-074-20260713    gcc-14
x86_64                randconfig-075-20260713    gcc-14
x86_64                randconfig-076-20260713    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260713    gcc-12.5.0
xtensa                randconfig-002-20260713    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
