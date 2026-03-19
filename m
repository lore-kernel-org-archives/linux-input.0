Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF37314A90
	for <linux-input@vger.kernel.org>; Thu, 19 Mar 2026 04:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773894162; cv=none; b=q2VOi/Q2LTJrlP1YjxI2Ul4DdvSsb7zrXP38IYT0mQzkqcn3ri4oAOPn9SUkBcuvBRCtakJ94H0WdXr3atLHZfgG7zLKDxNAf7Dpoq2PzE02WjDFHd6gvZLUgt1rX+EDHj5tT6g950qwwkEbOtPNQly163V42gwKqoQhsa3E67g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773894162; c=relaxed/simple;
	bh=28lRgQMmYbOSDGFkiZPASNTvIlI3WiR11zMIDAVsfOc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=X39iOHSdXTKXuhboguPl1HtUigLz6CQ69esK4XNWpQNEGg2e6szFuyanCNrnPSMdT6H1pMg+WbTkX94caafo/xENvHBJaMwvlTmVhxVGj75TF9UxZ72iMeZRqolUc7iZ3UJQhNpHedxOwiHOrs07NggvlmCP34pRwiDKPqjqImg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JUoeDmNF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JUoeDmNF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773894160; x=1805430160;
  h=date:from:to:cc:subject:message-id;
  bh=28lRgQMmYbOSDGFkiZPASNTvIlI3WiR11zMIDAVsfOc=;
  b=JUoeDmNFRI82Z7ikns0MwnQ9rxWdMfRCW7K62Rp3CJPD6z4McHo/J2vK
   aaFkSBHVlkPCf5FP+k/VfKlb3nbYCWc6N3D9Ta8aSXg97zODPMXykNNnu
   A2VV5PDVp2EhSI4jHpetcVE6TDAwc9ZULnIbPG+wYaJLm1ip38GzlDf/N
   OZENz6QXnZ5hUAdWI/AczoeYhjFBeB2Xcx4cdkel9Yo2NSJaAFlBoD/dD
   efJhmSHPwKxjMHiLPw+hqpqaWj20HbVBBMcBNeI4STofzxVKS75akUfun
   CLaSKUOIDIBTAEbh9nlBcBsu1e95nvnsCgbKKhds/XZYPd/XeS7uxgggo
   A==;
X-CSE-ConnectionGUID: GbvlogHeRhunNoUEOcd7xg==
X-CSE-MsgGUID: zJR2BKDoTAeaD0shAKkntg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="73976458"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="73976458"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 21:22:39 -0700
X-CSE-ConnectionGUID: JhWr+rYaQFygM0EWVxTvUg==
X-CSE-MsgGUID: ctp92f6tTh+avYWElsFs8Q==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO a51c2a36b9df) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 18 Mar 2026 21:22:38 -0700
Received: from kbuild by a51c2a36b9df with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w34sy-000000000Iz-08uV;
	Thu, 19 Mar 2026 04:22:03 +0000
Date: Thu, 19 Mar 2026 12:21:12 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:next] BUILD SUCCESS
 b8303880b641fa12db4e752b19f1b5160f0fa965
Message-ID: <202603191206.dVXkHEoq-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
branch HEAD: b8303880b641fa12db4e752b19f1b5160f0fa965  Input: atlas - convert ACPI driver to a platform one

elapsed time: 733m

configs tested: 163
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260319    gcc-11.5.0
arc                   randconfig-002-20260319    gcc-11.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260319    gcc-11.5.0
arm                   randconfig-002-20260319    gcc-11.5.0
arm                   randconfig-003-20260319    gcc-11.5.0
arm                   randconfig-004-20260319    gcc-11.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260319    gcc-15.2.0
arm64                 randconfig-002-20260319    gcc-15.2.0
arm64                 randconfig-003-20260319    gcc-15.2.0
arm64                 randconfig-004-20260319    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260319    gcc-15.2.0
csky                  randconfig-002-20260319    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260319    gcc-11.5.0
hexagon               randconfig-002-20260319    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260319    gcc-14
i386        buildonly-randconfig-002-20260319    gcc-14
i386        buildonly-randconfig-003-20260319    gcc-14
i386        buildonly-randconfig-004-20260319    gcc-14
i386        buildonly-randconfig-005-20260319    gcc-14
i386        buildonly-randconfig-006-20260319    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260319    gcc-14
i386                  randconfig-002-20260319    gcc-14
i386                  randconfig-003-20260319    gcc-14
i386                  randconfig-004-20260319    gcc-14
i386                  randconfig-005-20260319    gcc-14
i386                  randconfig-006-20260319    gcc-14
i386                  randconfig-007-20260319    gcc-14
i386                  randconfig-011-20260319    clang-20
i386                  randconfig-012-20260319    clang-20
i386                  randconfig-013-20260319    clang-20
i386                  randconfig-014-20260319    clang-20
i386                  randconfig-015-20260319    clang-20
i386                  randconfig-016-20260319    clang-20
i386                  randconfig-017-20260319    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260319    gcc-11.5.0
loongarch             randconfig-002-20260319    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                            mac_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260319    gcc-11.5.0
nios2                 randconfig-002-20260319    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260319    clang-19
parisc                randconfig-002-20260319    clang-19
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                      chrp32_defconfig    clang-19
powerpc               randconfig-001-20260319    clang-19
powerpc               randconfig-002-20260319    clang-19
powerpc64             randconfig-001-20260319    clang-19
powerpc64             randconfig-002-20260319    clang-19
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260319    gcc-8.5.0
sparc                 randconfig-002-20260319    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260319    gcc-8.5.0
sparc64               randconfig-002-20260319    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260319    gcc-8.5.0
um                    randconfig-002-20260319    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260319    clang-20
x86_64      buildonly-randconfig-002-20260319    clang-20
x86_64      buildonly-randconfig-003-20260319    clang-20
x86_64      buildonly-randconfig-004-20260319    clang-20
x86_64      buildonly-randconfig-005-20260319    clang-20
x86_64      buildonly-randconfig-006-20260319    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260319    gcc-14
x86_64                randconfig-002-20260319    gcc-14
x86_64                randconfig-003-20260319    gcc-14
x86_64                randconfig-004-20260319    gcc-14
x86_64                randconfig-005-20260319    gcc-14
x86_64                randconfig-006-20260319    gcc-14
x86_64                randconfig-011-20260319    gcc-13
x86_64                randconfig-012-20260319    gcc-13
x86_64                randconfig-013-20260319    gcc-13
x86_64                randconfig-014-20260319    gcc-13
x86_64                randconfig-015-20260319    gcc-13
x86_64                randconfig-016-20260319    gcc-13
x86_64                randconfig-071-20260319    clang-20
x86_64                randconfig-072-20260319    clang-20
x86_64                randconfig-073-20260319    clang-20
x86_64                randconfig-074-20260319    clang-20
x86_64                randconfig-075-20260319    clang-20
x86_64                randconfig-076-20260319    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260319    gcc-8.5.0
xtensa                randconfig-002-20260319    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
