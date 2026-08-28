Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E7944AB9E
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787918783; cv=none; b=leINaXiQP5hOERYNST10Is6Z4HCgSnSppnE9IA5u1sXNyX6L7aPThU+q1Q/TjIJ0MC/FkUqvf35oDNzDxkL6fzFHgwK6WqX95ihPa1NFsfEMYNjUXL3wgTvI94MnCGGHQcXo6zaTycmwhIdgbdwXXuPG8C2iSCx2xueibJpfz4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787918783; c=relaxed/simple;
	bh=Md1bi2QKNKMeT/Gax2rQnbvh+OyAR8RV60WlNw/6Jjc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=repP5ykAP7oz0KVNLow2mfhikQx9lZiHYtoB1g1vz4/js9e1Gb38czl1tovd8yX24oArQrTiCGiLtmqVlRjEjmZdcoxJKaD47UIbRIC7ejmZ+xAT9D664Di6rRDPe82v/Qq7Dj2QJENA0DmaguRZetSCqPFWAJAN+cUgCmRaDSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EI0BQw4t; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EI0BQw4t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787918775; x=1819454775;
  h=date:from:to:cc:subject:message-id;
  bh=Md1bi2QKNKMeT/Gax2rQnbvh+OyAR8RV60WlNw/6Jjc=;
  b=EI0BQw4tpjH/j1oltmnEysiE/O9cnP/f69Wo5X69Aic48++w9aRSPA+w
   ux7mt0XWnYlFDjUVruGhG6iJ0p3AvWRsI3WDNNjij9+x06ArEWuNBl4Ai
   VFiPHAp0hUdrwNIG2VZXU/D49V6p5v7D8YU1Y8+zAsaZW4SiuiPhnakDF
   uplOiYhEorGlBYhkiO6qg8ej+q3VTENE3fZZwIkjdtWR5uNtD0uxoZBxd
   +F3SDXVvM/3BmXWE5BsNVW+BER9z0alnyFhS/zGREzwpG3tr/ZIiqW5u1
   qelD5l34TOjkGauHtr6xPnTbyxpEZoDR1P4S51yC/JunY+FYNX9zHr22l
   Q==;
X-CSE-ConnectionGUID: BXMdFjk8QtOJvnzv+FDqzA==
X-CSE-MsgGUID: 6EU4pruJRjiz3fmw6NHXbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="87557675"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="87557675"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 05:06:13 -0700
X-CSE-ConnectionGUID: piqYdHNrTfmwRqeDXn74iw==
X-CSE-MsgGUID: 2H03lBnFS8K1HytxZe56Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="273402311"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 28 Aug 2026 05:06:11 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wzvLV-00000000B3h-1xsD;
	Fri, 28 Aug 2026 12:06:09 +0000
Date: Fri, 28 Aug 2026 20:05:49 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:master] BUILD SUCCESS
 fcc1d6eab4ce4ba86ae05a87ecf7ce06cd2ca4d8
Message-ID: <202608282017.JYaRyH9A-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git master
branch HEAD: fcc1d6eab4ce4ba86ae05a87ecf7ce06cd2ca4d8  Input: st-keyscan - improve probe error handling

elapsed time: 1405m

configs tested: 289
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-14
arc                              allmodconfig    clang-24
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-14
arc                              allyesconfig    clang-24
arc                                 defconfig    gcc-16.1.0
arc                     nsimosci_hs_defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-16.1.0
arc                   randconfig-001-20260828    clang-17
arc                   randconfig-001-20260828    gcc-16.1.0
arc                            randconfig-002    gcc-16.1.0
arc                   randconfig-002-20260828    clang-17
arc                   randconfig-002-20260828    gcc-16.1.0
arc                        vdk_hs38_defconfig    gcc-16.1.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-14
arm                              allyesconfig    clang-24
arm                       aspeed_g5_defconfig    gcc-16.1.0
arm                         at91_dt_defconfig    gcc-16.1.0
arm                         axm55xx_defconfig    gcc-16.1.0
arm                          collie_defconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                            mmp2_defconfig    gcc-16.1.0
arm                       multi_v4t_defconfig    gcc-16.1.0
arm                        mvebu_v5_defconfig    gcc-16.1.0
arm                        neponset_defconfig    gcc-16.1.0
arm                             pxa_defconfig    gcc-16.1.0
arm                            randconfig-001    gcc-16.1.0
arm                   randconfig-001-20260828    clang-17
arm                   randconfig-001-20260828    gcc-16.1.0
arm                            randconfig-002    gcc-16.1.0
arm                   randconfig-002-20260828    clang-17
arm                   randconfig-002-20260828    gcc-16.1.0
arm                            randconfig-003    gcc-16.1.0
arm                   randconfig-003-20260828    clang-17
arm                   randconfig-003-20260828    gcc-16.1.0
arm                            randconfig-004    gcc-16.1.0
arm                   randconfig-004-20260828    clang-17
arm                   randconfig-004-20260828    gcc-16.1.0
arm                           sama5_defconfig    gcc-16.1.0
arm                       spear13xx_defconfig    gcc-16.1.0
arm                       versatile_defconfig    gcc-16.1.0
arm                         vf610m4_defconfig    gcc-16.1.0
arm64                            allmodconfig    clang-14
arm64                            allmodconfig    clang-24
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    clang-14
arm64                          randconfig-001    clang-24
arm64                 randconfig-001-20260828    clang-14
arm64                 randconfig-001-20260828    clang-24
arm64                          randconfig-002    clang-14
arm64                          randconfig-002    clang-24
arm64                 randconfig-002-20260828    clang-14
arm64                 randconfig-002-20260828    clang-24
arm64                          randconfig-003    clang-14
arm64                          randconfig-003    clang-24
arm64                 randconfig-003-20260828    clang-14
arm64                 randconfig-003-20260828    clang-24
arm64                          randconfig-004    clang-14
arm64                          randconfig-004    clang-24
arm64                 randconfig-004-20260828    clang-14
arm64                 randconfig-004-20260828    clang-24
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    clang-14
csky                           randconfig-001    clang-24
csky                  randconfig-001-20260828    clang-14
csky                  randconfig-001-20260828    clang-24
csky                           randconfig-002    clang-14
csky                           randconfig-002    clang-24
csky                  randconfig-002-20260828    clang-14
csky                  randconfig-002-20260828    clang-24
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260828    clang-18
hexagon               randconfig-002-20260828    clang-18
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260828    clang-22
i386        buildonly-randconfig-002-20260828    clang-22
i386        buildonly-randconfig-003-20260828    clang-22
i386        buildonly-randconfig-004-20260828    clang-22
i386        buildonly-randconfig-005-20260828    clang-22
i386        buildonly-randconfig-006-20260828    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260828    gcc-14
i386                  randconfig-002-20260828    gcc-14
i386                  randconfig-003-20260828    gcc-14
i386                  randconfig-004-20260828    gcc-14
i386                  randconfig-005-20260828    gcc-14
i386                  randconfig-006-20260828    gcc-14
i386                  randconfig-007-20260828    gcc-14
i386                  randconfig-011-20260828    gcc-14
i386                  randconfig-012-20260828    gcc-14
i386                  randconfig-013-20260828    gcc-14
i386                  randconfig-014-20260828    gcc-14
i386                  randconfig-015-20260828    gcc-14
i386                  randconfig-016-20260828    gcc-14
i386                  randconfig-017-20260828    gcc-14
loongarch                        allmodconfig    clang-14
loongarch                        allmodconfig    clang-24
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-14
loongarch                           defconfig    clang-24
loongarch                loongson32_defconfig    gcc-16.1.0
loongarch             randconfig-001-20260828    clang-18
loongarch             randconfig-002-20260828    clang-18
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-14
m68k                             allyesconfig    clang-24
m68k                          amiga_defconfig    gcc-16.1.0
m68k                                defconfig    clang-14
m68k                                defconfig    clang-24
m68k                       m5329evb_defconfig    gcc-16.1.0
m68k                          multi_defconfig    gcc-16.1.0
m68k                            q40_defconfig    gcc-16.1.0
microblaze                       alldefconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-14
microblaze                          defconfig    clang-24
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                     decstation_defconfig    gcc-16.1.0
mips                     loongson2k_defconfig    gcc-16.1.0
mips                   sb1250_swarm_defconfig    gcc-16.1.0
nios2                         10m50_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-14
nios2                             allnoconfig    clang-24
nios2                               defconfig    clang-14
nios2                               defconfig    clang-24
nios2                 randconfig-001-20260828    clang-18
nios2                 randconfig-002-20260828    clang-18
openrisc                         alldefconfig    gcc-16.1.0
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-14
openrisc                          allnoconfig    clang-24
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-14
parisc                            allnoconfig    clang-24
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-9.5.0
parisc                randconfig-001-20260828    gcc-9.5.0
parisc                         randconfig-002    gcc-9.5.0
parisc                randconfig-002-20260828    gcc-9.5.0
parisc64                            defconfig    clang-14
parisc64                            defconfig    clang-24
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-14
powerpc                           allnoconfig    clang-24
powerpc                 canyonlands_defconfig    gcc-16.1.0
powerpc                       holly_defconfig    gcc-16.1.0
powerpc                  iss476-smp_defconfig    gcc-16.1.0
powerpc                   lite5200b_defconfig    gcc-16.1.0
powerpc                     mpc5200_defconfig    gcc-16.1.0
powerpc                 mpc8315_rdb_defconfig    gcc-16.1.0
powerpc                 mpc836x_rdk_defconfig    gcc-16.1.0
powerpc                 mpc837x_rdb_defconfig    gcc-16.1.0
powerpc                     powernv_defconfig    gcc-16.1.0
powerpc                        randconfig-001    gcc-9.5.0
powerpc               randconfig-001-20260828    gcc-9.5.0
powerpc                        randconfig-002    gcc-9.5.0
powerpc               randconfig-002-20260828    gcc-9.5.0
powerpc                     redwood_defconfig    gcc-16.1.0
powerpc                     tqm5200_defconfig    gcc-16.1.0
powerpc                        warp_defconfig    gcc-16.1.0
powerpc                         wii_defconfig    gcc-16.1.0
powerpc64                      randconfig-001    gcc-9.5.0
powerpc64             randconfig-001-20260828    gcc-9.5.0
powerpc64                      randconfig-002    gcc-9.5.0
powerpc64             randconfig-002-20260828    gcc-9.5.0
riscv                            allmodconfig    clang-14
riscv                            allmodconfig    clang-24
riscv                             allnoconfig    clang-14
riscv                             allnoconfig    clang-24
riscv                            allyesconfig    clang-14
riscv                            allyesconfig    clang-24
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260828    clang-17
riscv                 randconfig-002-20260828    clang-17
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-14
s390                              allnoconfig    clang-24
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260828    clang-17
s390                  randconfig-002-20260828    clang-17
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-14
sh                                allnoconfig    clang-24
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260828    clang-17
sh                    randconfig-002-20260828    clang-17
sh                   rts7751r2dplus_defconfig    gcc-16.1.0
sh                          sdk7780_defconfig    gcc-16.1.0
sh                           se7343_defconfig    gcc-16.1.0
sh                           se7724_defconfig    gcc-16.1.0
sh                           se7780_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-14
sparc                             allnoconfig    clang-24
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260828    gcc-9.5.0
sparc                 randconfig-002-20260828    gcc-9.5.0
sparc                       sparc64_defconfig    gcc-16.1.0
sparc64                          alldefconfig    gcc-16.1.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260828    gcc-9.5.0
sparc64               randconfig-002-20260828    gcc-9.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-14
um                                allnoconfig    clang-24
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260828    gcc-9.5.0
um                    randconfig-002-20260828    gcc-9.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-14
x86_64                            allnoconfig    clang-24
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    gcc-14
x86_64      buildonly-randconfig-001-20260828    gcc-14
x86_64               buildonly-randconfig-002    gcc-14
x86_64      buildonly-randconfig-002-20260828    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260828    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260828    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260828    gcc-14
x86_64               buildonly-randconfig-006    gcc-14
x86_64      buildonly-randconfig-006-20260828    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260828    gcc-14
x86_64                randconfig-002-20260828    gcc-14
x86_64                randconfig-003-20260828    gcc-14
x86_64                randconfig-004-20260828    gcc-14
x86_64                randconfig-005-20260828    gcc-14
x86_64                randconfig-006-20260828    gcc-14
x86_64                         randconfig-011    clang-22
x86_64                randconfig-011-20260828    clang-22
x86_64                         randconfig-012    clang-22
x86_64                randconfig-012-20260828    clang-22
x86_64                         randconfig-013    clang-22
x86_64                randconfig-013-20260828    clang-22
x86_64                         randconfig-014    clang-22
x86_64                randconfig-014-20260828    clang-22
x86_64                         randconfig-015    clang-22
x86_64                randconfig-015-20260828    clang-22
x86_64                         randconfig-016    clang-22
x86_64                randconfig-016-20260828    clang-22
x86_64                randconfig-071-20260828    clang-22
x86_64                randconfig-072-20260828    clang-22
x86_64                randconfig-073-20260828    clang-22
x86_64                randconfig-074-20260828    clang-22
x86_64                randconfig-075-20260828    clang-22
x86_64                randconfig-076-20260828    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-14
xtensa                            allnoconfig    clang-24
xtensa                           allyesconfig    clang-20
xtensa                  audio_kc705_defconfig    gcc-16.1.0
xtensa                  cadence_csp_defconfig    gcc-16.1.0
xtensa                          iss_defconfig    gcc-16.1.0
xtensa                randconfig-001-20260828    gcc-9.5.0
xtensa                randconfig-002-20260828    gcc-9.5.0
xtensa                    smp_lx200_defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
