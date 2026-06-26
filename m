Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D745D38C40C
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782500435; cv=none; b=rspOYY0MgJAL0U5iiQUfxP8Tlp7LF82a2fH3XxFS6TZdQZzWDrPOovDlQZ1OR8U6GwEreeyU22QLD6xiicOpAFuc87qPcqNckacxCBJ137l5DO2IlAzDcLWOn5juI8WeiGH1sLI8gU9tyl/VRkkHVuk1saSNc4HU+8ko0QoXzv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782500435; c=relaxed/simple;
	bh=I4tfmDq0EBgz4Mjn8Aj7Xo3moEd1QZQCteNk07Hpm+k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pLTO1gHsLrDeeyRdUXd6u/bJM+B7kqfvFW5fKU75gVAa9vS/UNpblCPmtLGExe9Z3abs2LTkNjc5AdbiCb+kPdG2X42fUGBl8CqTYwyR6lyc/S9mJ1wVbwMtDZABG+wt+O143cEAMNcgPxlQdI2ltCZmGrOUtXMZlorsY6ocNWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eNfxZkC5; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eNfxZkC5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782500433; x=1814036433;
  h=date:from:to:cc:subject:message-id;
  bh=I4tfmDq0EBgz4Mjn8Aj7Xo3moEd1QZQCteNk07Hpm+k=;
  b=eNfxZkC5Selrq60euAUKccJgON2xKAdq0AQ+M8jMpkSC+wULhg1ohyI5
   Jbg9/aCuxWQLy6LnMIAxx0rboAH9jP4YaSNPhy41rxSiT6BevGhukszz0
   b8bACHlwxguFIHdEdx7NguvHGdjpXU+NA6scRtPGY3zRa9wXX50Wcd6di
   H774BgZJcur+0GAn07wGnEghhf2SLElqqNIxB0cBQusLjTTDSVxSn/zkd
   MYq5IR7XIN/y7HHDGyXbaPsa/yMdwjcFZFFNtbntSNHJGt7jUZlAozttJ
   5kcXXXhozwag/+ylYfAJnYiAmPT6P+hNdV274/dbqWAkwayoAhfQXyD2w
   w==;
X-CSE-ConnectionGUID: QLhQiU//SgO6ng0tJCbfbQ==
X-CSE-MsgGUID: rL0zx+HbTLuAJE7QR43Yyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="86987374"
X-IronPort-AV: E=Sophos;i="6.24,227,1774335600"; 
   d="scan'208";a="86987374"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 12:00:33 -0700
X-CSE-ConnectionGUID: qda3wiObSn6/ESiFPy8InA==
X-CSE-MsgGUID: 6nPJ2IGCQBCnD3jOFmxtzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,227,1774335600"; 
   d="scan'208";a="275635887"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 26 Jun 2026 12:00:31 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wdBmu-000000005MD-0Wis;
	Fri, 26 Jun 2026 19:00:28 +0000
Date: Sat, 27 Jun 2026 02:59:40 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:next] BUILD SUCCESS
 f373f18a3c43afaad15b2a91880dd65347ed760f
Message-ID: <202606270230.boVs42Lc-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
branch HEAD: f373f18a3c43afaad15b2a91880dd65347ed760f  dt-bindings: input: syna,rmi4: Document syna,rmi4-s3706b

elapsed time: 733m

configs tested: 290
configs skipped: 12

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
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260626    gcc-11.5.0
arc                   randconfig-001-20260626    gcc-13.4.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260626    gcc-13.4.0
arc                   randconfig-002-20260626    gcc-9.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                            randconfig-001    gcc-16.1.0
arm                   randconfig-001-20260626    gcc-13.4.0
arm                            randconfig-002    gcc-15.2.0
arm                   randconfig-002-20260626    clang-23
arm                   randconfig-002-20260626    gcc-13.4.0
arm                            randconfig-003    clang-23
arm                   randconfig-003-20260626    gcc-13.4.0
arm                            randconfig-004    gcc-13.4.0
arm                   randconfig-004-20260626    clang-21
arm                   randconfig-004-20260626    gcc-13.4.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    clang-23
arm64                 randconfig-001-20260626    clang-23
arm64                          randconfig-002    clang-23
arm64                 randconfig-002-20260626    clang-23
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260626    clang-23
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260626    clang-23
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    clang-23
csky                  randconfig-001-20260626    clang-23
csky                           randconfig-002    clang-23
csky                  randconfig-002-20260626    clang-23
hexagon                          allmodconfig    clang-23
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260626    clang-23
hexagon               randconfig-001-20260626    gcc-11.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260626    clang-23
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
i386        buildonly-randconfig-004-20260626    gcc-12
i386        buildonly-randconfig-004-20260626    gcc-14
i386        buildonly-randconfig-005-20260626    gcc-14
i386        buildonly-randconfig-006-20260626    gcc-14
i386                                defconfig    clang-22
i386                                defconfig    gcc-16.1.0
i386                           randconfig-001    clang-22
i386                  randconfig-001-20260626    clang-22
i386                  randconfig-001-20260626    gcc-14
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260626    gcc-14
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260626    clang-22
i386                  randconfig-003-20260626    gcc-14
i386                           randconfig-004    clang-22
i386                  randconfig-004-20260626    clang-22
i386                  randconfig-004-20260626    gcc-14
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260626    gcc-14
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260626    gcc-14
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260626    gcc-14
i386                  randconfig-011-20260626    gcc-14
i386                  randconfig-012-20260626    clang-22
i386                  randconfig-012-20260626    gcc-14
i386                  randconfig-013-20260626    clang-22
i386                  randconfig-013-20260626    gcc-14
i386                  randconfig-014-20260626    gcc-14
i386                  randconfig-015-20260626    gcc-14
i386                  randconfig-016-20260626    clang-22
i386                  randconfig-016-20260626    gcc-14
i386                  randconfig-017-20260626    clang-22
i386                  randconfig-017-20260626    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260626    gcc-11.5.0
loongarch             randconfig-001-20260626    gcc-16.1.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260626    clang-18
loongarch             randconfig-002-20260626    gcc-11.5.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    gcc-16.1.0
microblaze                      mmu_defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                     cu1830-neo_defconfig    gcc-16.1.0
mips                       rbtx49xx_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260626    gcc-11.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260626    gcc-11.5.0
nios2                 randconfig-002-20260626    gcc-8.5.0
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
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    gcc-16.1.0
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
riscv                          randconfig-001    clang-23
riscv                 randconfig-001-20260626    gcc-11.5.0
riscv                          randconfig-002    clang-23
riscv                 randconfig-002-20260626    clang-23
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                           randconfig-001    clang-23
s390                  randconfig-001-20260626    clang-23
s390                           randconfig-002    clang-23
s390                  randconfig-002-20260626    gcc-8.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-16.1.0
sh                             randconfig-001    clang-23
sh                    randconfig-001-20260626    gcc-9.5.0
sh                             randconfig-002    clang-23
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
x86_64               buildonly-randconfig-001    gcc-12
x86_64      buildonly-randconfig-001-20260626    clang-22
x86_64      buildonly-randconfig-001-20260626    gcc-14
x86_64               buildonly-randconfig-002    clang-22
x86_64      buildonly-randconfig-002-20260626    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260626    clang-22
x86_64      buildonly-randconfig-003-20260626    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260626    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260626    clang-22
x86_64      buildonly-randconfig-005-20260626    gcc-14
x86_64               buildonly-randconfig-006    clang-22
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
x86_64                         randconfig-013    gcc-14
x86_64                randconfig-013-20260626    clang-22
x86_64                randconfig-013-20260626    gcc-14
x86_64                         randconfig-014    gcc-14
x86_64                randconfig-014-20260626    gcc-14
x86_64                         randconfig-015    gcc-14
x86_64                randconfig-015-20260626    gcc-14
x86_64                         randconfig-016    gcc-14
x86_64                randconfig-016-20260626    gcc-14
x86_64                randconfig-071-20260626    gcc-14
x86_64                randconfig-072-20260626    clang-22
x86_64                randconfig-072-20260626    gcc-14
x86_64                randconfig-073-20260626    gcc-14
x86_64                randconfig-074-20260626    gcc-14
x86_64                randconfig-075-20260626    gcc-14
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
xtensa                           allyesconfig    gcc-16.1.0
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260626    gcc-12.5.0
xtensa                         randconfig-002    gcc-13.4.0
xtensa                randconfig-002-20260626    gcc-10.5.0
xtensa                randconfig-002-20260626    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
