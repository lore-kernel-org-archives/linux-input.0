Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8327299948
	for <linux-input@vger.kernel.org>; Sun, 15 Feb 2026 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771158910; cv=none; b=CXLjqJAiG22bgZWVU687t3PZzdzZvqrA/diBG53bzTnGDUnLtINpyvRRxRT3WHlnG9L0AEt+Yk7bBhcPS467jK7gOz+F6CojxgF5zzxbIDmN98tjpdTAi+9a8ncXFbDeKkaKTqxGUfT3kkHnUHbpMNVtmEOFUZ466jfgzsPfSuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771158910; c=relaxed/simple;
	bh=38sLyzhQ0idkluGSI4sm/r8sE2GaSXGlNx0tVlWViCM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HxHYSmLIa2T/UbiRNSsa4123uxHCFWgEA17g8AzYHmSplLK7PbC55rVg8/jzu65/tKl1W3Vh07enTEvQu8cwkOyyZ4Z907bXX4mdsFeLYSTH0TFJE0zaBlP0uaWtbSnkduTv27BJfVBpBIRyUyYkA6MTrAXwQtY+4rId4Aqb+/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lAkiNUvy; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lAkiNUvy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771158908; x=1802694908;
  h=date:from:to:cc:subject:message-id;
  bh=38sLyzhQ0idkluGSI4sm/r8sE2GaSXGlNx0tVlWViCM=;
  b=lAkiNUvyk8b2w5Cz4SCA5s71mrdOt1PoT0KOVmB8MCwwqg9YySiBs2W9
   xYrMfbPFMzTM5ii3DAHuRdO5uAnvDkcTrXGbuv++egy7vQTo1GR21juKI
   IS1zS4EJCGf7wd9Um7s7KmW481tO0XlKelab7+eDvYPu2sVBWMCNUvild
   BL/rpbcyBm4CK7Ov3Q8yWNAelDWM2cahLMAR/MRDAlCzoPzo4wyicwnZ5
   KqaBB91RVXgkdPpNX+rt+YKjEMnASn6YNALFqXSKJSbLuUhR0CgbwiVh6
   q4ioEYtWwJWZUBAj7QccDtk5NJzA2WRievSMC2m+s8F9uO7i/h3F4dngA
   g==;
X-CSE-ConnectionGUID: XTC9m6PZQVaiuG0e63l+gw==
X-CSE-MsgGUID: 9Yl5IUBIQcqglQKc2C8OwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11701"; a="83635010"
X-IronPort-AV: E=Sophos;i="6.21,292,1763452800"; 
   d="scan'208";a="83635010"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 04:35:07 -0800
X-CSE-ConnectionGUID: uV/iV56rRTK5sRCZzJCwxA==
X-CSE-MsgGUID: 0+JnXdH0RbiZYeJAlle7mw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 15 Feb 2026 04:35:06 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vrbL5-00000000yUW-3GY3;
	Sun, 15 Feb 2026 12:35:03 +0000
Date: Sun, 15 Feb 2026 20:34:25 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:for-linus] BUILD SUCCESS
 273a171dee33cb77070d7259c469d9440548c7df
Message-ID: <202602152017.UysIO2mN-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
branch HEAD: 273a171dee33cb77070d7259c469d9440548c7df  Merge branch 'next' into for-linus

elapsed time: 877m

configs tested: 241
configs skipped: 6

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
arc                        nsim_700_defconfig    gcc-15.2.0
arc                   randconfig-001-20260215    clang-20
arc                   randconfig-002-20260215    clang-20
arc                        vdk_hs38_defconfig    clang-22
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                     am200epdkit_defconfig    gcc-15.2.0
arm                          collie_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                         nhk8815_defconfig    clang-22
arm                          pxa910_defconfig    gcc-15.2.0
arm                             pxa_defconfig    clang-22
arm                             pxa_defconfig    gcc-15.2.0
arm                   randconfig-001-20260215    clang-20
arm                   randconfig-002-20260215    clang-20
arm                   randconfig-003-20260215    clang-20
arm                   randconfig-004-20260215    clang-20
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
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260215    gcc-14
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
i386                  randconfig-012-20260215    clang-20
i386                  randconfig-013-20260215    clang-20
i386                  randconfig-014-20260215    clang-20
i386                  randconfig-015-20260215    clang-20
i386                  randconfig-016-20260215    clang-20
i386                  randconfig-017-20260215    clang-20
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
m68k                        m5307c3_defconfig    gcc-15.2.0
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
mips                         rt305x_defconfig    gcc-15.2.0
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
powerpc                       ebony_defconfig    gcc-15.2.0
powerpc                    gamecube_defconfig    clang-22
powerpc                 mpc836x_rdk_defconfig    clang-22
powerpc                      ppc6xx_defconfig    clang-22
powerpc               randconfig-001-20260215    clang-22
powerpc               randconfig-001-20260215    gcc-11.5.0
powerpc               randconfig-002-20260215    clang-22
powerpc                     redwood_defconfig    gcc-15.2.0
powerpc                     stx_gp3_defconfig    gcc-15.2.0
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
riscv                 randconfig-002-20260215    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260215    gcc-13.4.0
s390                  randconfig-002-20260215    gcc-13.4.0
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
sh                    randconfig-002-20260215    gcc-13.4.0
sh                            titan_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260215    gcc-9.5.0
sparc                 randconfig-002-20260215    gcc-9.5.0
sparc                       sparc32_defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260215    gcc-9.5.0
sparc64               randconfig-002-20260215    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260215    gcc-9.5.0
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
x86_64                randconfig-001-20260215    gcc-14
x86_64                randconfig-002-20260215    gcc-14
x86_64                randconfig-003-20260215    gcc-14
x86_64                randconfig-004-20260215    gcc-14
x86_64                randconfig-005-20260215    gcc-14
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
xtensa                generic_kc705_defconfig    clang-22
xtensa                randconfig-001-20260215    gcc-9.5.0
xtensa                randconfig-002-20260215    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
