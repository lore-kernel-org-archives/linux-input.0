Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C7D34405F
	for <linux-input@vger.kernel.org>; Wed, 18 Feb 2026 19:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771443549; cv=none; b=DlZN/B7ySO5XDMpSDNq7EgyihBTNmpgiksOT3SWXvLLUbNj2JYSCLyrfJ7opq+flvv8AcBhymMCgGNZH2HTqFNlERYRJ31hHbDIIvFchhnGXUnOOrjFqq3Ys0Q78GSvg/EDnqP92HET+xSNVLvonFCqVdSqlEzkSdP5UZpVwK6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771443549; c=relaxed/simple;
	bh=1+tASPaDjFuB67WpphO3d/4Ys9IcsVRjIlw7HOy6+MU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tNFgHak5Wkf6XuTxiZQx0b+1ycjh4q+Ds+55RwgRMgX16QNnBILgeEyJxAg8hRcGj06DB03KXsZcJt8aEmWg7AexvtnBaiHWhIP6bohLbxjVHjL82o12ALtsDOmv1jNZF1tO+J8jOE8rgVDMl57G1k4ntNsQWfIkLRbKDsnJpPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MEcfU6lv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MEcfU6lv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771443548; x=1802979548;
  h=date:from:to:cc:subject:message-id;
  bh=1+tASPaDjFuB67WpphO3d/4Ys9IcsVRjIlw7HOy6+MU=;
  b=MEcfU6lvqP+DY3PE7bzY7KKhAXAGddzOKen5VI81oFu1z5M6fOYCIa+O
   rPLr44bLEBzPjNLSYCb9Z4uaAMsW5gTVHtNr0C88+oMhfYX0Gy6lfDSp0
   vobKEzT90Jp+15UXVZ8qUxlNzl/FjzbKkULKsJp/Qed4f4vm/Nzz+hiiI
   SNr98YIFtbuvT+PGtAc9UPX90FZhjThnZDbgKCw7I18BuLpUiAHLe9uF6
   e5wLAiuum3pX/LrvvwuTiVJlcOSWvpPJjjTXEcxy6FpmZEPFlLXpq8v80
   BCMTy8/F/yKpRFiho5DnKOQzOYV+8RfhfzmRvOK784kUEhU/8O2f4NE1J
   Q==;
X-CSE-ConnectionGUID: y+QznnejTEu2jDa2kuYOgw==
X-CSE-MsgGUID: 7kJsXA+eQnaKKpQ28lYUaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="76363055"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="76363055"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 11:39:08 -0800
X-CSE-ConnectionGUID: eHnBdqvXSCyPepdlYnL1ww==
X-CSE-MsgGUID: rcCF4ue+QnS/rDhHvVkrwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="214396236"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 18 Feb 2026 11:39:07 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vsnO4-000000012g8-00KZ;
	Wed, 18 Feb 2026 19:39:04 +0000
Date: Thu, 19 Feb 2026 03:38:28 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:next] BUILD SUCCESS
 e7b53288d9ea899abc6d47a7f20065ab511a810c
Message-ID: <202602190320.jTjAUDZm-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
branch HEAD: e7b53288d9ea899abc6d47a7f20065ab511a810c  Input: drv260x - fix unbalanced regulator_disable() call

elapsed time: 720m

configs tested: 269
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                          axs103_defconfig    gcc-15.2.0
arc                      axs103_smp_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                     haps_hs_smp_defconfig    clang-23
arc                     haps_hs_smp_defconfig    gcc-15.2.0
arc                        nsim_700_defconfig    clang-23
arc                   randconfig-001-20260218    clang-23
arc                   randconfig-001-20260219    clang-23
arc                   randconfig-002-20260218    clang-23
arc                   randconfig-002-20260219    clang-23
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                            dove_defconfig    gcc-15.2.0
arm                          exynos_defconfig    clang-23
arm                            hisi_defconfig    gcc-15.2.0
arm                      jornada720_defconfig    clang-23
arm                            mps2_defconfig    clang-23
arm                        multi_v5_defconfig    gcc-15.2.0
arm                        mvebu_v5_defconfig    clang-23
arm                        neponset_defconfig    gcc-15.2.0
arm                       netwinder_defconfig    clang-23
arm                         orion5x_defconfig    clang-23
arm                             pxa_defconfig    gcc-15.2.0
arm                   randconfig-001-20260218    clang-23
arm                   randconfig-001-20260219    clang-23
arm                   randconfig-002-20260218    clang-23
arm                   randconfig-002-20260219    clang-23
arm                   randconfig-003-20260218    clang-23
arm                   randconfig-003-20260219    clang-23
arm                   randconfig-004-20260218    clang-23
arm                   randconfig-004-20260219    clang-23
arm                         socfpga_defconfig    clang-23
arm                           spitz_defconfig    gcc-15.2.0
arm                           stm32_defconfig    gcc-15.2.0
arm                       versatile_defconfig    gcc-15.2.0
arm                    vt8500_v6_v7_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260218    clang-23
arm64                 randconfig-002-20260218    clang-23
arm64                 randconfig-003-20260218    clang-23
arm64                 randconfig-004-20260218    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260218    clang-23
csky                  randconfig-002-20260218    clang-23
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260218    clang-16
hexagon               randconfig-001-20260219    clang-17
hexagon               randconfig-002-20260218    clang-16
hexagon               randconfig-002-20260219    clang-17
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260218    clang-20
i386        buildonly-randconfig-002-20260218    clang-20
i386        buildonly-randconfig-003-20260218    clang-20
i386        buildonly-randconfig-004-20260218    clang-20
i386        buildonly-randconfig-005-20260218    clang-20
i386        buildonly-randconfig-006-20260218    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260218    clang-20
i386                  randconfig-002-20260218    clang-20
i386                  randconfig-003-20260218    clang-20
i386                  randconfig-004-20260218    clang-20
i386                  randconfig-005-20260218    clang-20
i386                  randconfig-006-20260218    clang-20
i386                  randconfig-007-20260218    clang-20
i386                  randconfig-011-20260218    gcc-14
i386                  randconfig-012-20260218    gcc-14
i386                  randconfig-013-20260218    gcc-14
i386                  randconfig-014-20260218    gcc-14
i386                  randconfig-015-20260218    gcc-14
i386                  randconfig-016-20260218    gcc-14
i386                  randconfig-017-20260218    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260218    clang-16
loongarch             randconfig-001-20260219    clang-17
loongarch             randconfig-002-20260218    clang-16
loongarch             randconfig-002-20260219    clang-17
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    gcc-15.2.0
m68k                        mvme16x_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          ath25_defconfig    clang-23
mips                         bigsur_defconfig    clang-23
mips                         cobalt_defconfig    clang-23
mips                 decstation_r4k_defconfig    clang-23
mips                           ip28_defconfig    gcc-15.2.0
mips                malta_qemu_32r6_defconfig    clang-23
mips                      pic32mzda_defconfig    clang-23
mips                          rm200_defconfig    clang-23
mips                   sb1250_swarm_defconfig    gcc-15.2.0
mips                           xway_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260218    clang-16
nios2                 randconfig-001-20260219    clang-17
nios2                 randconfig-002-20260218    clang-16
nios2                 randconfig-002-20260219    clang-17
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc         de0_nano_multicore_defconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                generic-32bit_defconfig    gcc-15.2.0
parisc                randconfig-001-20260218    gcc-8.5.0
parisc                randconfig-002-20260218    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                    adder875_defconfig    gcc-15.2.0
powerpc                     akebono_defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                    amigaone_defconfig    clang-23
powerpc                      chrp32_defconfig    clang-23
powerpc                      cm5200_defconfig    clang-23
powerpc                   currituck_defconfig    gcc-15.2.0
powerpc                      ep88xc_defconfig    clang-23
powerpc                        fsp2_defconfig    gcc-15.2.0
powerpc                        icon_defconfig    gcc-15.2.0
powerpc                      katmai_defconfig    gcc-15.2.0
powerpc                     kmeter1_defconfig    clang-23
powerpc                  mpc885_ads_defconfig    gcc-15.2.0
powerpc                      pcm030_defconfig    clang-23
powerpc                     ppa8548_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260218    gcc-8.5.0
powerpc               randconfig-002-20260218    gcc-8.5.0
powerpc                     redwood_defconfig    gcc-15.2.0
powerpc                  storcenter_defconfig    clang-23
powerpc                     tqm8540_defconfig    clang-23
powerpc                     tqm8555_defconfig    clang-23
powerpc                        warp_defconfig    clang-23
powerpc                 xes_mpc85xx_defconfig    clang-23
powerpc64             randconfig-001-20260218    gcc-8.5.0
powerpc64             randconfig-002-20260218    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260218    clang-23
riscv                 randconfig-002-20260218    clang-23
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260218    clang-23
s390                  randconfig-002-20260218    clang-23
s390                       zfcpdump_defconfig    gcc-15.2.0
sh                               alldefconfig    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                          kfr2r09_defconfig    gcc-15.2.0
sh                          landisk_defconfig    gcc-15.2.0
sh                          polaris_defconfig    gcc-15.2.0
sh                          r7785rp_defconfig    gcc-15.2.0
sh                    randconfig-001-20260218    clang-23
sh                    randconfig-002-20260218    clang-23
sh                          rsk7269_defconfig    gcc-15.2.0
sh                   sh7770_generic_defconfig    clang-23
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260218    gcc-10.5.0
sparc                 randconfig-002-20260218    gcc-10.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260218    gcc-10.5.0
sparc64               randconfig-002-20260218    gcc-10.5.0
um                               alldefconfig    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260218    gcc-10.5.0
um                    randconfig-002-20260218    gcc-10.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260218    gcc-14
x86_64      buildonly-randconfig-001-20260219    gcc-14
x86_64      buildonly-randconfig-002-20260218    gcc-14
x86_64      buildonly-randconfig-002-20260219    gcc-14
x86_64      buildonly-randconfig-003-20260218    gcc-14
x86_64      buildonly-randconfig-003-20260219    gcc-14
x86_64      buildonly-randconfig-004-20260218    gcc-14
x86_64      buildonly-randconfig-004-20260219    gcc-14
x86_64      buildonly-randconfig-005-20260218    gcc-14
x86_64      buildonly-randconfig-005-20260219    gcc-14
x86_64      buildonly-randconfig-006-20260218    gcc-14
x86_64      buildonly-randconfig-006-20260219    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260218    gcc-14
x86_64                randconfig-002-20260218    gcc-14
x86_64                randconfig-003-20260218    gcc-14
x86_64                randconfig-004-20260218    gcc-14
x86_64                randconfig-005-20260218    gcc-14
x86_64                randconfig-006-20260218    gcc-14
x86_64                randconfig-011-20260218    gcc-13
x86_64                randconfig-012-20260218    gcc-13
x86_64                randconfig-013-20260218    gcc-13
x86_64                randconfig-014-20260218    gcc-13
x86_64                randconfig-015-20260218    gcc-13
x86_64                randconfig-016-20260218    gcc-13
x86_64                randconfig-071-20260218    clang-20
x86_64                randconfig-072-20260218    clang-20
x86_64                randconfig-073-20260218    clang-20
x86_64                randconfig-074-20260218    clang-20
x86_64                randconfig-075-20260218    clang-20
x86_64                randconfig-076-20260218    clang-20
x86_64                randconfig-076-20260218    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-15.2.0
xtensa                       common_defconfig    gcc-15.2.0
xtensa                generic_kc705_defconfig    clang-23
xtensa                randconfig-001-20260218    gcc-10.5.0
xtensa                randconfig-002-20260218    gcc-10.5.0
xtensa                    smp_lx200_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
