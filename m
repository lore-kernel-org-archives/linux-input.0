Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289D33016FB
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2026 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783105035; cv=none; b=kdxPN3c0c5OKPHdBtrbc5Rgs1zrZ7Rvg9nzuW/W+nGsldyr0fSy7tC7Fr8nFy7vou7hN/8FrsNqcTvA4oKg7XQFh00vuPjkSrdVCCLZHOUSdDhDU26WIHBjMfrWoeJFUxxnwYutDsnQqP/0nqQY+bRKLVz9NUuXbZeew5+N4xmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783105035; c=relaxed/simple;
	bh=XcFvAXpWU5/WppnXOU4F50pRYW5hlQ6iBApH6KT2qws=;
	h=Date:From:To:Cc:Subject:Message-ID; b=U48RM+91dcYXRog7O+CLK+YEo1/4PpscpULsmh+hJ8LSn6Vc/yha2A7aIpUvv1+HdH/nziNfZMS7mn1JhTnEECI4EqpmXDbshXZaiZdgQ6cQ8f6/GlsV6EAzRtiCeoyWVP4xJxJCGi8JullHqy+iD8yis0Vzgi+ysjEvnC5mFI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WI1gFfxL; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WI1gFfxL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783105034; x=1814641034;
  h=date:from:to:cc:subject:message-id;
  bh=XcFvAXpWU5/WppnXOU4F50pRYW5hlQ6iBApH6KT2qws=;
  b=WI1gFfxLhF3zN2ae8l4m2lwjITRCjc2JfBt4Go8nfqPIi+kY6SciXjQJ
   9rpDrRYpdjkMc7pI1qQtoxj2ML9Hx/GsG11sCEKyKdnanjOPC/z7AcHpp
   G/0nrwcTS8AVd0OWaDm9pifgZDfEfa7mvIx6wYl7LeWw1keT6Yjo4pUBO
   4X9nbfXs2gxNsGsbIwiAJ3nfJoATJs3OuPbfkHtB2riRNgxvX+Mye2wG8
   oDhIGXZbV7o2KKbjAu/vX2yX7kmvxQ6nq4okMLw7sth3REI75n88WNDy/
   ykdraKsECSjIpe0PGaZrbLGaczCCGT4fWcq380ZGQsmEWsQF66+4c2APS
   Q==;
X-CSE-ConnectionGUID: MKsv8DLETYiK3dHfWTHeJg==
X-CSE-MsgGUID: wJAoQjtRTcWhfzCCBe8B3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11836"; a="84047432"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="84047432"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 11:57:13 -0700
X-CSE-ConnectionGUID: ZfAjtZfWSxOAHUw+LaIS8A==
X-CSE-MsgGUID: 2mZafQIsS/a2HBi0b2TXww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="252702529"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 03 Jul 2026 11:57:11 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wfj4W-00000000CRD-3Q7D;
	Fri, 03 Jul 2026 18:57:08 +0000
Date: Sat, 04 Jul 2026 02:56:42 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:for-linus] BUILD SUCCESS
 536394ec81419b67d9f4f0028812c4372397be1b
Message-ID: <202607040232.bGnBelZw-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
branch HEAD: 536394ec81419b67d9f4f0028812c4372397be1b  Input: maple_keyb - set driver data before registering input device

elapsed time: 760m

configs tested: 324
configs skipped: 5

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
arc                          axs103_defconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-16.1.0
arc                   randconfig-001-20260703    gcc-16.1.0
arc                   randconfig-001-20260703    gcc-8.5.0
arc                   randconfig-001-20260704    gcc-8.5.0
arc                            randconfig-002    gcc-16.1.0
arc                   randconfig-002-20260703    gcc-16.1.0
arc                   randconfig-002-20260703    gcc-8.5.0
arc                   randconfig-002-20260704    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                        keystone_defconfig    gcc-16.1.0
arm                        mvebu_v7_defconfig    clang-23
arm                            randconfig-001    gcc-16.1.0
arm                   randconfig-001-20260703    gcc-16.1.0
arm                   randconfig-001-20260703    gcc-8.5.0
arm                   randconfig-001-20260704    gcc-8.5.0
arm                            randconfig-002    gcc-16.1.0
arm                   randconfig-002-20260703    gcc-16.1.0
arm                   randconfig-002-20260703    gcc-8.5.0
arm                   randconfig-002-20260704    gcc-8.5.0
arm                            randconfig-003    gcc-16.1.0
arm                   randconfig-003-20260703    gcc-16.1.0
arm                   randconfig-003-20260703    gcc-8.5.0
arm                   randconfig-003-20260704    gcc-8.5.0
arm                            randconfig-004    gcc-16.1.0
arm                   randconfig-004-20260703    gcc-16.1.0
arm                   randconfig-004-20260703    gcc-8.5.0
arm                   randconfig-004-20260704    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    gcc-10.5.0
arm64                 randconfig-001-20260703    clang-23
arm64                 randconfig-001-20260703    gcc-10.5.0
arm64                 randconfig-001-20260704    gcc-16.1.0
arm64                          randconfig-002    gcc-10.5.0
arm64                 randconfig-002-20260703    gcc-10.5.0
arm64                 randconfig-002-20260703    gcc-12.5.0
arm64                 randconfig-002-20260704    gcc-16.1.0
arm64                          randconfig-003    gcc-10.5.0
arm64                 randconfig-003-20260703    gcc-10.5.0
arm64                 randconfig-003-20260704    gcc-16.1.0
arm64                          randconfig-004    gcc-10.5.0
arm64                 randconfig-004-20260703    gcc-10.5.0
arm64                 randconfig-004-20260703    gcc-8.5.0
arm64                 randconfig-004-20260704    gcc-16.1.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    gcc-10.5.0
csky                  randconfig-001-20260703    gcc-10.5.0
csky                  randconfig-001-20260703    gcc-12.5.0
csky                  randconfig-001-20260704    gcc-16.1.0
csky                           randconfig-002    gcc-10.5.0
csky                  randconfig-002-20260703    gcc-10.5.0
csky                  randconfig-002-20260704    gcc-16.1.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260703    gcc-11.5.0
hexagon               randconfig-001-20260703    gcc-16.1.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260703    gcc-11.5.0
hexagon               randconfig-002-20260703    gcc-16.1.0
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    clang-22
i386        buildonly-randconfig-001-20260703    clang-22
i386                 buildonly-randconfig-002    clang-22
i386        buildonly-randconfig-002-20260703    clang-22
i386                 buildonly-randconfig-003    clang-22
i386        buildonly-randconfig-003-20260703    clang-22
i386                 buildonly-randconfig-004    clang-22
i386        buildonly-randconfig-004-20260703    clang-22
i386                 buildonly-randconfig-005    clang-22
i386        buildonly-randconfig-005-20260703    clang-22
i386                 buildonly-randconfig-006    clang-22
i386        buildonly-randconfig-006-20260703    clang-22
i386                                defconfig    gcc-16.1.0
i386                           randconfig-001    clang-22
i386                  randconfig-001-20260703    clang-22
i386                           randconfig-002    clang-22
i386                  randconfig-002-20260703    clang-22
i386                           randconfig-003    clang-22
i386                  randconfig-003-20260703    clang-22
i386                           randconfig-004    clang-22
i386                  randconfig-004-20260703    clang-22
i386                           randconfig-005    clang-22
i386                  randconfig-005-20260703    clang-22
i386                           randconfig-006    clang-22
i386                  randconfig-006-20260703    clang-22
i386                           randconfig-007    clang-22
i386                  randconfig-007-20260703    clang-22
i386                           randconfig-011    clang-22
i386                  randconfig-011-20260703    clang-22
i386                           randconfig-012    clang-22
i386                  randconfig-012-20260703    clang-22
i386                           randconfig-013    clang-22
i386                  randconfig-013-20260703    clang-22
i386                           randconfig-014    clang-22
i386                  randconfig-014-20260703    clang-22
i386                           randconfig-015    clang-22
i386                  randconfig-015-20260703    clang-22
i386                           randconfig-016    clang-22
i386                  randconfig-016-20260703    clang-22
i386                           randconfig-017    clang-22
i386                  randconfig-017-20260703    clang-22
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260703    gcc-11.5.0
loongarch             randconfig-001-20260703    gcc-16.1.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260703    gcc-11.5.0
loongarch             randconfig-002-20260703    gcc-16.1.0
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
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                               defconfig    gcc-11.5.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260703    gcc-11.5.0
nios2                 randconfig-001-20260703    gcc-16.1.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260703    gcc-11.5.0
nios2                 randconfig-002-20260703    gcc-16.1.0
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    clang-23
parisc                randconfig-001-20260703    clang-23
parisc                randconfig-001-20260704    clang-23
parisc                         randconfig-002    clang-23
parisc                randconfig-002-20260703    clang-23
parisc                randconfig-002-20260704    clang-23
parisc64                            defconfig    clang-23
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                      chrp32_defconfig    clang-23
powerpc                     ep8248e_defconfig    gcc-16.1.0
powerpc                        randconfig-001    clang-23
powerpc               randconfig-001-20260703    clang-23
powerpc               randconfig-001-20260704    clang-23
powerpc                        randconfig-002    clang-23
powerpc               randconfig-002-20260703    clang-23
powerpc               randconfig-002-20260704    clang-23
powerpc64                      randconfig-001    clang-23
powerpc64             randconfig-001-20260703    clang-23
powerpc64             randconfig-001-20260704    clang-23
powerpc64                      randconfig-002    clang-23
powerpc64             randconfig-002-20260703    clang-23
powerpc64             randconfig-002-20260704    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260703    gcc-9.5.0
riscv                 randconfig-001-20260704    gcc-10.5.0
riscv                 randconfig-002-20260703    gcc-9.5.0
riscv                 randconfig-002-20260704    gcc-10.5.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260703    gcc-9.5.0
s390                  randconfig-001-20260704    gcc-10.5.0
s390                  randconfig-002-20260703    gcc-9.5.0
s390                  randconfig-002-20260704    gcc-10.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                            hp6xx_defconfig    gcc-16.1.0
sh                    randconfig-001-20260703    gcc-9.5.0
sh                    randconfig-001-20260704    gcc-10.5.0
sh                    randconfig-002-20260703    gcc-9.5.0
sh                    randconfig-002-20260704    gcc-10.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260703    gcc-11.5.0
sparc                 randconfig-001-20260704    gcc-16.1.0
sparc                 randconfig-002-20260703    gcc-11.5.0
sparc                 randconfig-002-20260704    gcc-16.1.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260703    gcc-11.5.0
sparc64               randconfig-001-20260704    gcc-16.1.0
sparc64               randconfig-002-20260703    gcc-11.5.0
sparc64               randconfig-002-20260704    gcc-16.1.0
um                               allmodconfig    clang-17
um                               allmodconfig    clang-23
um                                allnoconfig    clang-16
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260703    gcc-11.5.0
um                    randconfig-001-20260704    gcc-16.1.0
um                    randconfig-002-20260703    gcc-11.5.0
um                    randconfig-002-20260704    gcc-16.1.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    gcc-14
x86_64      buildonly-randconfig-001-20260703    gcc-14
x86_64               buildonly-randconfig-002    gcc-14
x86_64      buildonly-randconfig-002-20260703    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260703    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260703    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260703    gcc-14
x86_64               buildonly-randconfig-006    gcc-14
x86_64      buildonly-randconfig-006-20260703    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                         randconfig-001    clang-22
x86_64                randconfig-001-20260703    clang-22
x86_64                         randconfig-002    clang-22
x86_64                randconfig-002-20260703    clang-22
x86_64                         randconfig-003    clang-22
x86_64                randconfig-003-20260703    clang-22
x86_64                         randconfig-004    clang-22
x86_64                randconfig-004-20260703    clang-22
x86_64                         randconfig-005    clang-22
x86_64                randconfig-005-20260703    clang-22
x86_64                         randconfig-006    clang-22
x86_64                randconfig-006-20260703    clang-22
x86_64                         randconfig-011    gcc-14
x86_64                randconfig-011-20260703    gcc-13
x86_64                randconfig-011-20260703    gcc-14
x86_64                         randconfig-012    gcc-14
x86_64                randconfig-012-20260703    gcc-14
x86_64                         randconfig-013    gcc-14
x86_64                randconfig-013-20260703    gcc-14
x86_64                         randconfig-014    gcc-14
x86_64                randconfig-014-20260703    gcc-14
x86_64                         randconfig-015    gcc-14
x86_64                randconfig-015-20260703    gcc-14
x86_64                         randconfig-016    gcc-14
x86_64                randconfig-016-20260703    clang-22
x86_64                randconfig-016-20260703    gcc-14
x86_64                         randconfig-071    clang-22
x86_64                randconfig-071-20260703    clang-22
x86_64                         randconfig-072    clang-22
x86_64                randconfig-072-20260703    clang-22
x86_64                         randconfig-073    clang-22
x86_64                randconfig-073-20260703    clang-22
x86_64                         randconfig-074    clang-22
x86_64                randconfig-074-20260703    clang-22
x86_64                         randconfig-075    clang-22
x86_64                randconfig-075-20260703    clang-22
x86_64                         randconfig-076    clang-22
x86_64                randconfig-076-20260703    clang-22
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
xtensa                       common_defconfig    gcc-16.1.0
xtensa                randconfig-001-20260703    gcc-11.5.0
xtensa                randconfig-001-20260704    gcc-16.1.0
xtensa                randconfig-002-20260703    gcc-11.5.0
xtensa                randconfig-002-20260704    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
