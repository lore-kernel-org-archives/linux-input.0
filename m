Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671653F9F50
	for <linux-input@vger.kernel.org>; Thu, 24 Sep 2026 18:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790275131; cv=none; b=VxZMUngqE0VNngEGO2+CXc9lS4mlfyEdIBzrkpOuSlHGXzHiYZPP2UBJ/92eOEeTMyZblevEEFKwWPVNbSuEm852reci3QD3pm1fzoBFBw2YulDzi+K7o+S8rEL6sArt+KaXOoc+wGZi2BQ0bnsWtfOriOb/uGKL7zXJa7xGDgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790275131; c=relaxed/simple;
	bh=jDmlabTfZuq16g4glqCXdscD0NwauDqW/w5PNwrI/bo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fTiAkwoL3TvPfCY8Spt7exHInpuZtfavLsdCs8ZypQ2zNfsS283ub+bDM+UIUJ5A9CfoIH1xXkWTE3sDqAEefkCmKV1NwWL/zEOmWLQa6x5DuVri6aYJNfZvQuO98vQVXx8RjpKtQV7ijdgcBYiE7ASWaUnIHwUQ7msni8L8Lc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WKXyVyfy; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WKXyVyfy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790275130; x=1821811130;
  h=date:from:to:cc:subject:message-id;
  bh=jDmlabTfZuq16g4glqCXdscD0NwauDqW/w5PNwrI/bo=;
  b=WKXyVyfyK4gHZc6k1B3ZIo6kokjA9G1j47Udkkhq5p5afmfR/xrRZIY0
   meufcYOZycT5sCl+GyHRgZcexCgSxt7sOXz6yaB+p+qlN9DVL5EhDumwq
   H6mTBozPWHTD/RjW4/R4pJ7R2d0NJO78KUy8uI4ds4a44vvNSWZ3J95RY
   zKpkAJmzVtcTv9SP8pFSxtaIPM8S03GuciWAVR473jAwwafb7qOpoSdBC
   romSJ2vvnNvBvnd/okUay+eIPFLYSwAFaMH628OwMjIKXVb5M1rdKelV6
   dKz/RV0lWlSxZbDAxpRU9Kmm52L+XiY1YbhOuhIxoDu9DJmpC6qJPwX4h
   Q==;
X-CSE-ConnectionGUID: lPhVVHHASquWOodEnMbl7A==
X-CSE-MsgGUID: VHxnf+LiQH+UDLM5PylWHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90925581"
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="90925581"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 11:38:49 -0700
X-CSE-ConnectionGUID: ARnSqB1STvSGhhSQkrOuFg==
X-CSE-MsgGUID: WlM/2kHCS/CBDTXqOs5Wlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="273204651"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 24 Sep 2026 11:38:47 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x9oLE-00000000JOo-2cRh;
	Thu, 24 Sep 2026 18:38:44 +0000
Date: Fri, 25 Sep 2026 02:37:46 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:master] BUILD SUCCESS
 daae2ab46e0cb612f50ca1d86cf50e5962461ae5
Message-ID: <202609250243.lvw8gw9Z-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git master
branch HEAD: daae2ab46e0cb612f50ca1d86cf50e5962461ae5  Input: gscps2 - drop busy-wait and manual interrupt pump on transmit

elapsed time: 4405m

configs tested: 260
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r1304-20260924    gcc-16.1.0 sparse
alpha                randconfig-r2201-20260923    gcc-8.5.0  smatch
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                      haps_hs_smp_defconfig    gcc-16.1.0
arc                   randconfig-1000-20260924    clang-24
arc                   randconfig-1001-20260924    clang-24
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                           ep93xx_defconfig    clang-24
arm                         multi_v7_defconfig    clang-24
arm                   randconfig-1000-20260924    clang-24
arm                   randconfig-1001-20260924    clang-24
arm                   randconfig-1002-20260924    clang-24
arm                   randconfig-1003-20260924    clang-24
arm                  randconfig-r1300-20260923    gcc-8.5.0  sparse
arm                  randconfig-r1305-20260924    gcc-16.1.0 sparse
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260924    gcc-11.5.0
arm64                 randconfig-1001-20260924    gcc-11.5.0
arm64                 randconfig-1002-20260924    gcc-11.5.0
arm64                 randconfig-1003-20260924    gcc-11.5.0
arm64                randconfig-r1302-20260924    gcc-16.1.0 sparse
arm64                randconfig-r1303-20260923    gcc-8.5.0  sparse
arm64                randconfig-r1307-20260924    gcc-11.5.0 sparse
arm64                randconfig-r2106-20260923    gcc-15.2.0 cocci
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260924    gcc-11.5.0
csky                  randconfig-1001-20260924    gcc-11.5.0
csky                 randconfig-r1300-20260924    gcc-16.1.0 sparse
csky                 randconfig-r1302-20260923    gcc-8.5.0  sparse
csky                 randconfig-r2107-20260923    gcc-15.2.0 cocci
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260924    gcc-8.5.0
hexagon               randconfig-1001-20260924    gcc-8.5.0
hexagon              randconfig-r1301-20260924    gcc-16.1.0 sparse
i386                               allnoconfig    gcc-16.1.0
i386        buildonly-randconfig-1000-20260924    gcc-14
i386        buildonly-randconfig-1001-20260924    gcc-14
i386        buildonly-randconfig-1002-20260924    gcc-14
i386        buildonly-randconfig-1003-20260924    gcc-14
i386        buildonly-randconfig-1004-20260924    gcc-14
i386        buildonly-randconfig-1005-20260924    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260924    gcc-12
i386                  randconfig-1001-20260924    gcc-12
i386                  randconfig-1002-20260924    gcc-12
i386                  randconfig-1003-20260924    gcc-12
i386                  randconfig-1004-20260924    gcc-12
i386                  randconfig-1005-20260924    gcc-12
i386                  randconfig-1006-20260924    gcc-12
i386                  randconfig-1007-20260924    clang-22
i386                  randconfig-1008-20260924    clang-22
i386                  randconfig-1009-20260924    clang-22
i386                  randconfig-1010-20260924    clang-22
i386                  randconfig-1011-20260924    clang-22
i386                  randconfig-1012-20260924    clang-22
i386                  randconfig-1013-20260924    clang-22
i386                  randconfig-1300-20260924    clang-22   sparse
i386                  randconfig-1301-20260924    clang-22   sparse
i386                  randconfig-1302-20260924    clang-22   sparse
i386                  randconfig-2100-20260923    clang-22   cocci
i386                  randconfig-2101-20260923    clang-22   cocci
i386                  randconfig-2102-20260923    clang-22   cocci
i386                  randconfig-2103-20260923    clang-22   cocci
i386                  randconfig-2200-20260923    gcc-12     smatch
i386                 randconfig-r2100-20260923    gcc-14     cocci
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260924    gcc-8.5.0
loongarch             randconfig-1001-20260924    gcc-8.5.0
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                           amiga_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                        m5249evb_defconfig    clang-24
m68k                        m5249evb_defconfig    gcc-16.1.0
m68k                         m5307c3_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                        bmips_be_defconfig    gcc-16.1.0
mips                 randconfig-r1309-20260924    gcc-11.5.0 sparse
mips                 randconfig-r2104-20260923    gcc-15.2.0 cocci
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260924    gcc-8.5.0
nios2                 randconfig-1001-20260924    gcc-8.5.0
nios2                randconfig-r1303-20260924    gcc-16.1.0 sparse
nios2                randconfig-r1305-20260923    gcc-8.5.0  sparse
nios2                randconfig-r1306-20260924    gcc-11.5.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
parisc                            alldefconfig    clang-24
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260924    gcc-8.5.0
parisc                randconfig-1001-20260924    gcc-8.5.0
parisc               randconfig-r1306-20260924    gcc-14     sparse
parisc               randconfig-r2103-20260923    gcc-14     cocci
parisc               randconfig-r2202-20260923    gcc-12.5.0 smatch
parisc64                             defconfig    clang-24
powerpc                     adder875_defconfig    clang-24
powerpc                            allnoconfig    clang-24
powerpc                       mgcoge_defconfig    gcc-16.1.0
powerpc                      ppa8548_defconfig    clang-24
powerpc               randconfig-1000-20260924    gcc-8.5.0
powerpc               randconfig-1001-20260924    gcc-8.5.0
powerpc              randconfig-r1304-20260923    gcc-8.5.0  sparse
powerpc64             randconfig-1000-20260924    gcc-8.5.0
powerpc64             randconfig-1001-20260924    gcc-8.5.0
powerpc64            randconfig-r1309-20260924    gcc-14     sparse
powerpc64            randconfig-r2103-20260923    gcc-14     cocci
powerpc64            randconfig-r2105-20260923    gcc-15.2.0 cocci
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260924    gcc-15.2.0
riscv                 randconfig-1001-20260924    gcc-15.2.0
riscv                 randconfig-2000-20260923    gcc-9.5.0
riscv                 randconfig-2001-20260923    gcc-9.5.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260924    gcc-15.2.0
s390                  randconfig-1001-20260924    gcc-15.2.0
s390                  randconfig-2000-20260923    gcc-9.5.0
s390                  randconfig-2001-20260923    gcc-9.5.0
s390                 randconfig-r1301-20260923    gcc-8.5.0  sparse
s390                 randconfig-r1308-20260924    gcc-11.5.0 sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                      magicpanelr2_defconfig    clang-24
sh                    randconfig-1000-20260924    gcc-15.2.0
sh                    randconfig-1001-20260924    gcc-15.2.0
sh                    randconfig-2000-20260923    gcc-9.5.0
sh                    randconfig-2001-20260923    gcc-9.5.0
sh                   randconfig-r2101-20260923    gcc-14     cocci
sh                    rts7751r2dplus_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260924    clang-17
sparc                 randconfig-1001-20260924    clang-17
sparc                 randconfig-2000-20260923    gcc-14.3.0
sparc                 randconfig-2001-20260923    gcc-14.3.0
sparc                randconfig-r1308-20260924    gcc-14     sparse
sparc                randconfig-r2200-20260923    gcc-8.5.0  smatch
sparc                randconfig-r2201-20260923    gcc-11.5.0 smatch
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260924    clang-17
sparc64               randconfig-1001-20260924    clang-17
sparc64               randconfig-2000-20260923    gcc-14.3.0
sparc64               randconfig-2001-20260923    gcc-14.3.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260924    clang-17
um                    randconfig-1001-20260924    clang-17
um                    randconfig-2000-20260923    gcc-14.3.0
um                    randconfig-2001-20260923    gcc-14.3.0
um                   randconfig-r1307-20260924    gcc-14     sparse
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20260923    gcc-14
x86_64      buildonly-randconfig-1000-20260924    clang-22
x86_64      buildonly-randconfig-1001-20260923    gcc-14
x86_64      buildonly-randconfig-1001-20260924    clang-22
x86_64      buildonly-randconfig-1002-20260923    gcc-14
x86_64      buildonly-randconfig-1002-20260924    clang-22
x86_64      buildonly-randconfig-1003-20260923    gcc-14
x86_64      buildonly-randconfig-1003-20260924    clang-22
x86_64      buildonly-randconfig-1004-20260923    gcc-14
x86_64      buildonly-randconfig-1004-20260924    clang-22
x86_64      buildonly-randconfig-1005-20260923    gcc-14
x86_64      buildonly-randconfig-1005-20260924    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260924    clang-22
x86_64                randconfig-1001-20260924    clang-22
x86_64                randconfig-1002-20260924    clang-22
x86_64                randconfig-1003-20260924    clang-22
x86_64                randconfig-1004-20260924    clang-22
x86_64                randconfig-1005-20260924    clang-22
x86_64                randconfig-1006-20260924    clang-22
x86_64                randconfig-1007-20260924    clang-22
x86_64                randconfig-1008-20260924    clang-22
x86_64                randconfig-1009-20260924    clang-22
x86_64                randconfig-1010-20260924    clang-22
x86_64                randconfig-1011-20260924    clang-22
x86_64                randconfig-1012-20260923    gcc-14
x86_64                randconfig-1012-20260924    clang-22
x86_64                randconfig-1013-20260923    gcc-14
x86_64                randconfig-1013-20260924    clang-22
x86_64                randconfig-1014-20260923    gcc-14
x86_64                randconfig-1014-20260924    clang-22
x86_64                randconfig-1015-20260923    gcc-14
x86_64                randconfig-1015-20260924    clang-22
x86_64                randconfig-1016-20260923    gcc-14
x86_64                randconfig-1016-20260924    clang-22
x86_64                randconfig-1017-20260923    gcc-14
x86_64                randconfig-1017-20260924    clang-22
x86_64                randconfig-1300-20260924    clang-22   sparse
x86_64                randconfig-1301-20260924    clang-22   sparse
x86_64                randconfig-1302-20260924    clang-22   sparse
x86_64                randconfig-2100-20260923    clang-22   cocci
x86_64                randconfig-2101-20260923    clang-22   cocci
x86_64                randconfig-2102-20260923    clang-22   cocci
x86_64                randconfig-2103-20260923    clang-22   cocci
x86_64                randconfig-2200-20260923    gcc-14     smatch
x86_64               randconfig-r2100-20260923    gcc-14     cocci
x86_64               randconfig-r2101-20260923    gcc-14     cocci
x86_64               randconfig-r2102-20260923    gcc-14     cocci
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                            alldefconfig    gcc-16.1.0
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20260924    clang-17
xtensa                randconfig-1001-20260924    clang-17
xtensa                randconfig-2000-20260923    gcc-14.3.0
xtensa                randconfig-2001-20260923    gcc-14.3.0
xtensa               randconfig-r2202-20260923    gcc-10.5.0 smatch

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
