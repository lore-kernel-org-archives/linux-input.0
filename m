Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0612D1C5D72
	for <linux-input@vger.kernel.org>; Sat, 27 Jun 2026 18:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782584585; cv=none; b=OUV5YACR7pmhI1Qddaufq3ZsiAOweeO+aG1Vw5mUALSUBkdPJ+E4+B8fpgz/4V5eYYC65ESLEFUequsua2rM9r1WRzwUErEVI+T5nAkVuZFRPVqR7yx0KAbJ9w2zh/qI+HHu1ettCBp2B7ITCkFrPI5dqx92OJvTgrIyt887dhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782584585; c=relaxed/simple;
	bh=J6WYvWVJrcMYY4sAUHcUBmzyLHpBNN3cDhPtbjljLfw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YsmAbYMourgWANYDntV+DRoDSP+Ewh9tIESQatTmOtZ5pKPiQQUFKDb+wSRyzV4kFUX7EnIqqbuWVtMLuFCzX2ivXMLXVV3ivg1zcuWhwstSbthOJnCXrYzne8KTigI9sd/E03lFN4A0bL8/qKeFCCLflB9Lvnugmx0sEaVcc9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMxZgXPe; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMxZgXPe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782584582; x=1814120582;
  h=date:from:to:cc:subject:message-id;
  bh=J6WYvWVJrcMYY4sAUHcUBmzyLHpBNN3cDhPtbjljLfw=;
  b=YMxZgXPe7il5cYtdRYL7YHqp4iM53iISTz6MDC3cZiKn9LHgBShnuafv
   etPJ2Q6PgpbTdMEXIC6QTaaYP3azDZOGndVBanibXNYzJNhp/K/prKGb8
   o8QdHGxonVGpt7l+GC1k4E1x+aLObRnO5nh9g3bsuzDm3F5HDKtEfiPbN
   1zhQBHnETPbjOv8xyU0tBu7PJGm9h3Kz245ptFx6R5QrFCgG5PA6ayAgB
   c+np0BKn7YM/neRe3cDA31kb5dCZMzKt2Mfc1QWfi3SWMq//3dsR6eSlX
   7tXV9fecMsV4O0kVxpJOhZBjT1LVQzEIEYcUcfCYTJ6mQ/VS1rVZx5a8k
   g==;
X-CSE-ConnectionGUID: We9ImkXES/+JBwzRtnXLNQ==
X-CSE-MsgGUID: GRs+xtiwTOquIG1D5I0Yhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11830"; a="83369875"
X-IronPort-AV: E=Sophos;i="6.24,228,1774335600"; 
   d="scan'208";a="83369875"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2026 11:23:01 -0700
X-CSE-ConnectionGUID: 8uCLLW93TxGtjOvW/r5Nuw==
X-CSE-MsgGUID: t/G5Lxx9S7mS73OINd2DHQ==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 27 Jun 2026 11:22:59 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wdXg9-0000000060b-1Qbg;
	Sat, 27 Jun 2026 18:22:57 +0000
Date: Sun, 28 Jun 2026 02:22:21 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:next] BUILD SUCCESS
 c8f174900926d3b58cd048ac33b4cbb3de419bfe
Message-ID: <202606280210.P8AVeex6-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
branch HEAD: c8f174900926d3b58cd048ac33b4cbb3de419bfe  Input: sur40 - fix MAX_CONTACTS value based on PixelSense specification

elapsed time: 730m

configs tested: 213
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260627    gcc-8.5.0
arc                   randconfig-002-20260627    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                          pxa910_defconfig    gcc-16.1.0
arm                   randconfig-001-20260627    gcc-16.1.0
arm                   randconfig-002-20260627    clang-23
arm                   randconfig-003-20260627    gcc-16.1.0
arm                   randconfig-004-20260627    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    gcc-14.3.0
arm64                 randconfig-001-20260627    gcc-10.5.0
arm64                          randconfig-002    gcc-8.5.0
arm64                 randconfig-002-20260627    clang-23
arm64                          randconfig-003    clang-20
arm64                 randconfig-003-20260627    gcc-10.5.0
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260627    gcc-16.1.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    gcc-13.4.0
csky                  randconfig-001-20260627    gcc-16.1.0
csky                           randconfig-002    gcc-14.3.0
csky                  randconfig-002-20260627    gcc-14.3.0
hexagon                          allmodconfig    clang-23
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon                        randconfig-001    clang-23
hexagon               randconfig-001-20260627    clang-23
hexagon                        randconfig-002    clang-23
hexagon               randconfig-002-20260627    clang-18
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260627    clang-22
i386        buildonly-randconfig-002-20260627    clang-22
i386        buildonly-randconfig-003-20260627    clang-22
i386        buildonly-randconfig-004-20260627    clang-22
i386        buildonly-randconfig-005-20260627    gcc-13
i386        buildonly-randconfig-006-20260627    clang-22
i386                                defconfig    clang-22
i386                           randconfig-001    clang-22
i386                  randconfig-001-20260627    clang-22
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260627    clang-22
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260627    gcc-13
i386                           randconfig-004    clang-22
i386                  randconfig-004-20260627    clang-22
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260627    clang-22
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260627    gcc-14
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260627    clang-22
i386                  randconfig-011-20260627    clang-22
i386                  randconfig-012-20260627    clang-22
i386                  randconfig-013-20260627    gcc-14
i386                  randconfig-014-20260627    clang-22
i386                  randconfig-015-20260627    gcc-14
i386                  randconfig-016-20260627    clang-22
i386                  randconfig-017-20260627    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-20
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    clang-23
loongarch             randconfig-001-20260627    clang-23
loongarch                      randconfig-002    gcc-16.1.0
loongarch             randconfig-002-20260627    gcc-16.1.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260627    gcc-11.5.0
nios2                          randconfig-002    gcc-8.5.0
nios2                 randconfig-002-20260627    gcc-11.5.0
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-8.5.0
parisc                randconfig-001-20260627    gcc-8.5.0
parisc                         randconfig-002    gcc-12.5.0
parisc                randconfig-002-20260627    gcc-8.5.0
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    gcc-16.1.0
powerpc                        randconfig-001    gcc-10.5.0
powerpc               randconfig-001-20260627    clang-23
powerpc                        randconfig-002    gcc-8.5.0
powerpc               randconfig-002-20260627    clang-17
powerpc64                      randconfig-001    clang-16
powerpc64             randconfig-001-20260627    clang-20
powerpc64                      randconfig-002    clang-23
powerpc64             randconfig-002-20260627    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260627    clang-22
riscv                 randconfig-002-20260627    clang-23
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                  randconfig-001-20260627    clang-23
s390                  randconfig-002-20260627    clang-23
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-16.1.0
sh                    randconfig-001-20260627    gcc-16.1.0
sh                    randconfig-002-20260627    gcc-10.5.0
sh                           se7724_defconfig    gcc-16.1.0
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-16.1.0
sparc                 randconfig-001-20260627    gcc-13.4.0
sparc                          randconfig-002    gcc-11.5.0
sparc                 randconfig-002-20260627    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64                        randconfig-001    gcc-12.5.0
sparc64               randconfig-001-20260627    gcc-13.4.0
sparc64                        randconfig-002    clang-20
sparc64               randconfig-002-20260627    gcc-15.2.0
um                               allmodconfig    clang-23
um                                allnoconfig    clang-16
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                             randconfig-001    clang-23
um                    randconfig-001-20260627    clang-22
um                             randconfig-002    clang-23
um                    randconfig-002-20260627    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    gcc-12
x86_64      buildonly-randconfig-001-20260627    gcc-13
x86_64               buildonly-randconfig-002    clang-22
x86_64      buildonly-randconfig-002-20260627    clang-22
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260627    clang-22
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260627    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260627    clang-22
x86_64               buildonly-randconfig-006    clang-22
x86_64      buildonly-randconfig-006-20260627    clang-22
x86_64                              defconfig    gcc-14
x86_64                         randconfig-001    gcc-14
x86_64                randconfig-001-20260627    clang-22
x86_64                         randconfig-002    gcc-14
x86_64                randconfig-002-20260627    gcc-12
x86_64                         randconfig-003    clang-22
x86_64                randconfig-003-20260627    clang-22
x86_64                         randconfig-004    clang-22
x86_64                randconfig-004-20260627    gcc-14
x86_64                         randconfig-005    gcc-14
x86_64                randconfig-005-20260627    gcc-14
x86_64                         randconfig-006    clang-22
x86_64                randconfig-006-20260627    clang-22
x86_64                         randconfig-011    gcc-14
x86_64                randconfig-011-20260627    clang-22
x86_64                         randconfig-012    gcc-14
x86_64                randconfig-012-20260627    clang-22
x86_64                         randconfig-013    clang-22
x86_64                randconfig-013-20260627    gcc-14
x86_64                         randconfig-014    gcc-14
x86_64                randconfig-014-20260627    gcc-14
x86_64                         randconfig-015    gcc-14
x86_64                randconfig-015-20260627    gcc-14
x86_64                         randconfig-016    clang-22
x86_64                randconfig-016-20260627    gcc-14
x86_64                randconfig-071-20260627    clang-22
x86_64                randconfig-072-20260627    clang-22
x86_64                randconfig-073-20260627    clang-22
x86_64                randconfig-074-20260627    gcc-14
x86_64                randconfig-075-20260627    gcc-14
x86_64                randconfig-076-20260627    clang-22
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    gcc-16.1.0
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260627    gcc-8.5.0
xtensa                         randconfig-002    gcc-13.4.0
xtensa                randconfig-002-20260627    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
