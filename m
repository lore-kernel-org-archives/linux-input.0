Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794690797;
	b=NHI7smayGOrxDQc6QIB6az23o/P9aXVuJi++/tvdRa7MtZL5vR3cfpY4L+N5BC+yrGdI
	 An0hANgmhn33/DCHepxKzr7xmrLPQAy1l19HUs/gRZ4GLCmyPfyk/uFrsMJ5oW5DHlV4M
	 yNoYEXRdnQaRx8npWnD0ZBGr8Bc2kdmI1p0K20zgV1z612KkOqNkPafRHip55kyDYmSCS
	 qZivJMEi2jP6rNtotVw33HS8gL+U9TB8fXhDXedY1jCCvUIa4hhfhwrYaM2fW3JwvxSzm
	 0oW9sN6vhl2EtTZu/8xmC0IVBMNrZODByLh8HducbsktnC2w2O2MVGLeUkbIcHKJ78w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794690797;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=ImWfHFlQZY3lYKtNqwtHO7yq3yvipSAcjr+rVsqs8dY=;
	b=aS+1s+GjU29iOgQSTHLmuwS4S3xsWuDkOv+O5YRjf4eBosozC5edelKWyV2hZ5Eb863Q
	 ZeEFX/HkMB7VyPLJ7lMb3XqBSyaRSVG8BLQRzy/ZVBbt6sHtiFbWyZf3QKT/doeBva5kY
	 qStCLu6UQxvPZ3gOBEtCCLPIL36pDpUKr3vzAe4/11z/ekXglaPfYSXcTp+PEXndpLzrG
	 dD0OmXvMghmrJQtx5sOZEzbyxM6AHs4wZlJ2neUeQ8oFt2yPfwCfNn/4CiNqs2Nz0RD+k
	 MRj5iZdDeHl/oqowS+0uSMqDhjgKwa+9rl9ule5IHv+MNVI0/nBJyEbcaLuT96DeQmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T6ct90Vm;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279D0606A333
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 21:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 279D0606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T6ct90Vm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794690797; x=1826226797;
  h=date:from:to:cc:subject:message-id;
  bh=kvlEN3oVNrIvN5GGsfHfJPUDa49XkNQET+8epsE1/xE=;
  b=T6ct90VmFNdkFFEMsLaDq5qrAu9/AZsTxZ2rTAoa6tac4mljKqrynvRr
   uFxDQGtGmIRO8nyD0fJ/3+r/boe+GIzQrrpL39UlP4+YmHq4MyoXFiBzp
   zSLwDI/9ziXsCOxrH3VbhJztVBmW5S2XNmSWuaFRkyD1GwObkOXMPIU2d
   ApiHARs+7Tge/Dzzczj1sIRLQUp20CyarzEOSmHksdVTR34TmyC+18ZuT
   ES2qRYz6sq4IpVLCA5nZIdSepjnjwUBI4B2p3yIrymOctDmAccVaGf7xT
   gQzjsUuWf95MdxXGt0SvMqEs8hv1SEpM7pr1eE/gCLnsNJiIbJfM9wRkh
   Q==;
X-CSE-ConnectionGUID: 4wlp/IddRMaSkBy/0YCIRg==
X-CSE-MsgGUID: sr4HqXVHQu28PyOVNEsDXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11966"; a="3479955"
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; 
   d="scan'208";a="3479955"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2026 13:13:13 -0800
X-CSE-ConnectionGUID: BnehLPKLRxeJkcxOUtmvyg==
X-CSE-MsgGUID: tfow2aHSSlCb2bDXhUew3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; 
   d="scan'208";a="9458485"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 14 Nov 2026 13:13:11 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xSL3d-000000015zg-07Lq;
	Sat, 14 Nov 2026 21:13:09 +0000
Date: Sun, 15 Nov 2026 05:12:59 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:master] BUILD SUCCESS
 ab13b5fc808e043a13f861a7c1c2ba8173c22b84
Message-ID: <20261115051259.SWaIjGnl-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git master
branch HEAD: ab13b5fc808e043a13f861a7c1c2ba8173c22b84  Input: tsc2007 - drop redundant error message on IRQ request failure

elapsed time: 789m

configs tested: 427
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261114    gcc-12.5.0
alpha                 randconfig-2001-20261114    gcc-12.5.0
alpha                 randconfig-2200-20261114    gcc-9.5.0  smatch
alpha                randconfig-r2100-20261114    gcc-15.3.0 cocci
alpha                randconfig-r2305-20261114    gcc-8.5.0  sparse
alpha                randconfig-r2308-20261114    gcc-8.5.0  sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261114    clang-24
arc                   randconfig-1000-20261115    gcc-11.5.0
arc                   randconfig-1001-20261114    clang-24
arc                   randconfig-1001-20261115    gcc-11.5.0
arc                   randconfig-2000-20261114    gcc-11.5.0
arc                   randconfig-2001-20261114    gcc-11.5.0
arc                   randconfig-2002-20261114    gcc-11.5.0
arc                   randconfig-2003-20261114    gcc-11.5.0
arc                   randconfig-2004-20261114    gcc-11.5.0
arc                   randconfig-2005-20261114    gcc-11.5.0
arc                   randconfig-2200-20261114    gcc-8.5.0  smatch
arc                  randconfig-r2100-20261114    gcc-12.5.0 cocci
arc                  randconfig-r2101-20261114    gcc-10.5.0 cocci
arc                  randconfig-r2101-20261114    gcc-12.5.0 cocci
arc                  randconfig-r2108-20261114    clang-24   cocci
arc                  randconfig-r2305-20261114    gcc-12.5.0 sparse
arc                  randconfig-r2311-20261114    gcc-15.3.0 sparse
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                             dove_defconfig    clang-24
arm                             mps2_defconfig    clang-24
arm                         multi_v5_defconfig    clang-24
arm                            omap1_defconfig    clang-24
arm                   randconfig-1000-20261114    clang-24
arm                   randconfig-1000-20261115    gcc-11.5.0
arm                   randconfig-1001-20261114    clang-24
arm                   randconfig-1001-20261115    gcc-11.5.0
arm                   randconfig-1002-20261114    clang-24
arm                   randconfig-1002-20261115    gcc-11.5.0
arm                   randconfig-1003-20261114    clang-24
arm                   randconfig-1003-20261115    gcc-11.5.0
arm                   randconfig-2000-20261114    gcc-10.5.0
arm                   randconfig-2001-20261114    gcc-10.5.0
arm                   randconfig-2002-20261114    gcc-10.5.0
arm                   randconfig-2200-20261114    clang-17   smatch
arm                  randconfig-r2101-20261114    gcc-15.3.0 cocci
arm                  randconfig-r2106-20261114    clang-24   cocci
arm                  randconfig-r2111-20261114    clang-24   cocci
arm                  randconfig-r2305-20261114    clang-24   sparse
arm                  randconfig-r2309-20261114    clang-24   sparse
arm                  randconfig-r2311-20261114    gcc-8.5.0  sparse
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261114    gcc-16.2.0
arm64                 randconfig-1001-20261114    gcc-16.2.0
arm64                 randconfig-1002-20261114    gcc-16.2.0
arm64                 randconfig-1003-20261114    gcc-16.2.0
arm64                 randconfig-2000-20261114    gcc-10.5.0
arm64                 randconfig-2001-20261114    gcc-10.5.0
arm64                 randconfig-2002-20261114    gcc-10.5.0
arm64                 randconfig-2200-20261114    clang-17   smatch
arm64                randconfig-r2102-20261114    gcc-15.3.0 cocci
arm64                randconfig-r2308-20261114    gcc-15.3.0 sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261114    gcc-16.2.0
csky                  randconfig-1001-20261114    gcc-16.2.0
csky                  randconfig-2000-20261114    gcc-16.2.0
csky                  randconfig-2001-20261114    gcc-16.2.0
csky                  randconfig-2200-20261114    gcc-16.2.0 smatch
csky                 randconfig-r2108-20261114    clang-21   cocci
csky                 randconfig-r2109-20261114    clang-21   cocci
csky                 randconfig-r2302-20261114    gcc-16.2.0 sparse
csky                 randconfig-r2306-20261114    clang-22   sparse
csky                 randconfig-r2307-20261114    clang-24   sparse
csky                 randconfig-r2310-20261114    clang-22   sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261114    clang-24
hexagon               randconfig-1000-20261115    clang-24
hexagon               randconfig-1001-20261114    clang-24
hexagon               randconfig-1001-20261115    clang-24
hexagon               randconfig-2000-20261114    gcc-16.2.0
hexagon               randconfig-2001-20261114    gcc-16.2.0
hexagon               randconfig-2200-20261114    clang-24   smatch
hexagon              randconfig-r2104-20261114    gcc-12.5.0 cocci
hexagon              randconfig-r2104-20261114    gcc-15.3.0 cocci
hexagon              randconfig-r2111-20261114    clang-17   cocci
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261114    gcc-14
i386        buildonly-randconfig-1001-20261114    gcc-14
i386        buildonly-randconfig-1002-20261114    gcc-14
i386        buildonly-randconfig-1003-20261114    gcc-14
i386        buildonly-randconfig-1004-20261114    gcc-14
i386        buildonly-randconfig-1005-20261114    gcc-14
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261114    gcc-12
i386                  randconfig-1000-20261115    clang-22
i386                  randconfig-1001-20261114    gcc-12
i386                  randconfig-1001-20261115    clang-22
i386                  randconfig-1002-20261114    gcc-12
i386                  randconfig-1002-20261115    clang-22
i386                  randconfig-1003-20261114    gcc-12
i386                  randconfig-1003-20261115    clang-22
i386                  randconfig-1004-20261114    gcc-12
i386                  randconfig-1004-20261115    clang-22
i386                  randconfig-1005-20261114    gcc-12
i386                  randconfig-1005-20261115    clang-22
i386                  randconfig-1006-20261114    gcc-12
i386                  randconfig-1006-20261115    clang-22
i386                  randconfig-1007-20261114    clang-22
i386                  randconfig-1008-20261114    clang-22
i386                  randconfig-1009-20261114    clang-22
i386                  randconfig-1010-20261114    clang-22
i386                  randconfig-1011-20261114    clang-22
i386                  randconfig-1012-20261114    clang-22
i386                  randconfig-1013-20261114    clang-22
i386                  randconfig-2000-20261114    clang-22
i386                  randconfig-2001-20261114    clang-22
i386                  randconfig-2002-20261114    clang-22
i386                  randconfig-2003-20261114    clang-22
i386                  randconfig-2004-20261114    clang-22
i386                  randconfig-2005-20261114    clang-22
i386                  randconfig-2100-20261114    gcc-14     cocci
i386                  randconfig-2101-20261114    gcc-14     cocci
i386                  randconfig-2102-20261114    gcc-14     cocci
i386                  randconfig-2103-20261114    gcc-14     cocci
i386                  randconfig-2104-20261114    gcc-14     cocci
i386                  randconfig-2105-20261114    gcc-14     cocci
i386                  randconfig-2200-20261114    gcc-14     smatch
i386                  randconfig-2300-20261114    clang-22   sparse
i386                  randconfig-2301-20261114    clang-22   sparse
i386                  randconfig-2302-20261114    clang-22   sparse
i386                 randconfig-r2101-20261114    gcc-12.5.0 cocci
i386                 randconfig-r2108-20261114    gcc-8.5.0  cocci
i386                 randconfig-r2110-20261114    clang-21   cocci
i386                 randconfig-r2309-20261114    clang-22   sparse
i386                 randconfig-r2311-20261114    clang-22   sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261114    clang-24
loongarch             randconfig-1000-20261115    clang-24
loongarch             randconfig-1001-20261114    clang-24
loongarch             randconfig-1001-20261115    clang-24
loongarch             randconfig-2000-20261114    gcc-11.5.0
loongarch             randconfig-2001-20261114    gcc-11.5.0
loongarch             randconfig-2200-20261114    clang-18   smatch
loongarch            randconfig-r2109-20261114    clang-17   cocci
loongarch            randconfig-r2300-20261114    gcc-16.2.0 sparse
loongarch            randconfig-r2303-20261114    gcc-8.5.0  sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                  randconfig-2000-20261114    gcc-12.5.0
m68k                  randconfig-2001-20261114    gcc-12.5.0
m68k                  randconfig-2200-20261114    gcc-16.2.0 smatch
m68k                 randconfig-r2107-20261114    clang-17   cocci
m68k                 randconfig-r2110-20261114    clang-17   cocci
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261114    gcc-12.5.0
microblaze            randconfig-2001-20261114    gcc-12.5.0
microblaze            randconfig-2200-20261114    gcc-9.5.0  smatch
microblaze           randconfig-r2109-20261114    gcc-8.5.0  cocci
microblaze           randconfig-r2302-20261114    gcc-8.5.0  sparse
microblaze           randconfig-r2304-20261114    gcc-8.5.0  sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                            jazz_defconfig    clang-24
mips                         omega2p_defconfig    clang-24
mips                  randconfig-2000-20261114    gcc-16.2.0
mips                  randconfig-2001-20261114    gcc-16.2.0
mips                  randconfig-2002-20261114    gcc-16.2.0
mips                  randconfig-2200-20261114    gcc-15.3.0 smatch
mips                 randconfig-r2106-20261114    clang-17   cocci
mips                 randconfig-r2108-20261114    clang-17   cocci
mips                 randconfig-r2301-20261114    gcc-16.2.0 sparse
mips                 randconfig-r2303-20261114    gcc-12.5.0 sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261114    clang-24
nios2                 randconfig-1000-20261115    clang-24
nios2                 randconfig-1001-20261114    clang-24
nios2                 randconfig-1001-20261115    clang-24
nios2                 randconfig-2000-20261114    gcc-11.5.0
nios2                 randconfig-2001-20261114    gcc-11.5.0
nios2                 randconfig-2200-20261114    gcc-11.5.0 smatch
nios2                randconfig-r2103-20261114    gcc-12.5.0 cocci
nios2                randconfig-r2105-20261114    gcc-12.5.0 cocci
nios2                randconfig-r2109-20261114    gcc-8.5.0  cocci
nios2                randconfig-r2301-20261114    clang-24   sparse
nios2                randconfig-r2304-20261114    gcc-12.5.0 sparse
nios2                randconfig-r2306-20261114    clang-24   sparse
nios2                randconfig-r2307-20261114    clang-22   sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc              randconfig-2000-20261114    gcc-16.2.0
openrisc              randconfig-2001-20261114    gcc-16.2.0
openrisc              randconfig-2002-20261114    gcc-16.2.0
openrisc              randconfig-2200-20261114    gcc-16.2.0 smatch
openrisc             randconfig-r2102-20261114    gcc-12.5.0 cocci
openrisc             randconfig-r2104-20261114    gcc-10.5.0 cocci
openrisc             randconfig-r2106-20261114    clang-21   cocci
openrisc             randconfig-r2110-20261114    clang-24   cocci
openrisc             randconfig-r2307-20261114    gcc-15.3.0 sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                randconfig-2000-20261114    gcc-11.5.0
parisc                randconfig-2001-20261114    gcc-11.5.0
parisc                randconfig-2200-20261114    gcc-8.5.0  smatch
parisc               randconfig-r2100-20261114    gcc-10.5.0 cocci
parisc               randconfig-r2103-20261114    gcc-15.3.0 cocci
parisc               randconfig-r2110-20261114    gcc-8.5.0  cocci
parisc               randconfig-r2310-20261114    clang-24   sparse
parisc64                             defconfig    clang-24
powerpc                     adder875_defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                    motionpro_defconfig    clang-24
powerpc                      mpc5200_defconfig    clang-24
powerpc                  mpc837x_rdb_defconfig    clang-24
powerpc               randconfig-2000-20261114    gcc-8.5.0
powerpc               randconfig-2001-20261114    gcc-8.5.0
powerpc               randconfig-2002-20261114    gcc-8.5.0
powerpc               randconfig-2200-20261114    clang-24   smatch
powerpc              randconfig-r2105-20261114    gcc-10.5.0 cocci
powerpc              randconfig-r2301-20261114    gcc-8.5.0  sparse
powerpc              randconfig-r2306-20261114    gcc-15.3.0 sparse
powerpc64             randconfig-2000-20261114    gcc-8.5.0
powerpc64             randconfig-2001-20261114    gcc-8.5.0
powerpc64             randconfig-2002-20261114    gcc-8.5.0
powerpc64             randconfig-2200-20261114    clang-17   smatch
powerpc64            randconfig-r2102-20261114    gcc-12.5.0 cocci
powerpc64            randconfig-r2103-20261114    gcc-10.5.0 cocci
powerpc64            randconfig-r2104-20261114    gcc-12.5.0 cocci
powerpc64            randconfig-r2109-20261114    clang-24   cocci
powerpc64            randconfig-r2300-20261114    gcc-12.5.0 sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                 randconfig-1000-20261114    gcc-15.3.0
riscv                 randconfig-1001-20261114    gcc-15.3.0
riscv                 randconfig-2000-20261114    gcc-12.5.0
riscv                 randconfig-2001-20261114    gcc-12.5.0
riscv                 randconfig-2002-20261114    gcc-12.5.0
riscv                 randconfig-2003-20261114    gcc-12.5.0
riscv                 randconfig-2004-20261114    gcc-12.5.0
riscv                 randconfig-2005-20261114    gcc-12.5.0
riscv                 randconfig-2200-20261114    clang-24   smatch
riscv                randconfig-r2111-20261114    gcc-8.5.0  cocci
riscv                randconfig-r2300-20261114    clang-24   sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                  randconfig-1000-20261114    gcc-15.3.0
s390                  randconfig-1001-20261114    gcc-15.3.0
s390                  randconfig-2000-20261114    clang-24
s390                  randconfig-2001-20261114    clang-24
s390                  randconfig-2002-20261114    clang-24
s390                  randconfig-2003-20261114    clang-24
s390                  randconfig-2004-20261114    clang-24
s390                  randconfig-2005-20261114    clang-24
s390                  randconfig-2200-20261114    clang-24   smatch
s390                 randconfig-r2103-20261114    gcc-12.5.0 cocci
s390                 randconfig-r2107-20261114    gcc-8.5.0  cocci
s390                 randconfig-r2111-20261114    clang-21   cocci
s390                 randconfig-r2302-20261114    clang-24   sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                          ecovec24_defconfig    clang-24
sh                              espt_defconfig    clang-24
sh                    randconfig-1000-20261114    gcc-15.3.0
sh                    randconfig-1001-20261114    gcc-15.3.0
sh                    randconfig-2000-20261114    gcc-13.5.0
sh                    randconfig-2001-20261114    gcc-13.5.0
sh                    randconfig-2002-20261114    gcc-13.5.0
sh                    randconfig-2003-20261114    gcc-13.5.0
sh                    randconfig-2004-20261114    gcc-13.5.0
sh                    randconfig-2005-20261114    gcc-13.5.0
sh                    randconfig-2200-20261114    gcc-9.5.0  smatch
sh                   randconfig-r2105-20261114    gcc-12.5.0 cocci
sh                   randconfig-r2302-20261114    gcc-12.5.0 sparse
sh                   randconfig-r2303-20261114    gcc-16.2.0 sparse
sh                   randconfig-r2304-20261114    clang-24   sparse
sh                   randconfig-r2307-20261114    gcc-8.5.0  sparse
sh                            se7206_defconfig    clang-24
sh                            se7750_defconfig    clang-24
sh                            se7751_defconfig    clang-24
sh                    sh7770_generic_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                 randconfig-1000-20261114    gcc-12.5.0
sparc                 randconfig-1001-20261114    gcc-12.5.0
sparc                 randconfig-2000-20261114    clang-21
sparc                 randconfig-2001-20261114    clang-21
sparc                 randconfig-2200-20261114    gcc-8.5.0  smatch
sparc                randconfig-r2106-20261114    gcc-8.5.0  cocci
sparc                randconfig-r2107-20261114    gcc-8.5.0  cocci
sparc                randconfig-r2304-20261114    gcc-16.2.0 sparse
sparc                randconfig-r2309-20261114    gcc-8.5.0  sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261114    gcc-12.5.0
sparc64               randconfig-1001-20261114    gcc-12.5.0
sparc64               randconfig-2000-20261114    clang-21
sparc64               randconfig-2001-20261114    clang-21
sparc64               randconfig-2200-20261114    gcc-16.2.0 smatch
sparc64              randconfig-r2102-20261114    gcc-10.5.0 cocci
sparc64              randconfig-r2108-20261114    gcc-8.5.0  cocci
sparc64              randconfig-r2303-20261114    clang-24   sparse
sparc64              randconfig-r2308-20261114    clang-22   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261114    gcc-12.5.0
um                    randconfig-1001-20261114    gcc-12.5.0
um                    randconfig-2000-20261114    clang-21
um                    randconfig-2001-20261114    clang-21
um                    randconfig-2200-20261114    gcc-14     smatch
um                   randconfig-r2107-20261114    clang-21   cocci
um                   randconfig-r2110-20261114    gcc-8.5.0  cocci
um                   randconfig-r2111-20261114    gcc-8.5.0  cocci
um                   randconfig-r2308-20261114    clang-24   sparse
um                   randconfig-r2309-20261114    gcc-15.3.0 sparse
um                   randconfig-r2311-20261114    clang-24   sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261114    gcc-14
x86_64      buildonly-randconfig-1001-20261114    gcc-14
x86_64      buildonly-randconfig-1002-20261114    gcc-14
x86_64      buildonly-randconfig-1003-20261114    gcc-14
x86_64      buildonly-randconfig-1004-20261114    gcc-14
x86_64      buildonly-randconfig-1005-20261114    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261114    gcc-14
x86_64                randconfig-1000-20261115    gcc-14
x86_64                randconfig-1001-20261114    gcc-14
x86_64                randconfig-1001-20261115    gcc-14
x86_64                randconfig-1002-20261114    gcc-14
x86_64                randconfig-1002-20261115    gcc-14
x86_64                randconfig-1003-20261114    gcc-14
x86_64                randconfig-1003-20261115    gcc-14
x86_64                randconfig-1004-20261114    gcc-14
x86_64                randconfig-1004-20261115    gcc-14
x86_64                randconfig-1005-20261114    gcc-14
x86_64                randconfig-1005-20261115    gcc-14
x86_64                randconfig-1006-20261114    gcc-14
x86_64                randconfig-1007-20261114    gcc-14
x86_64                randconfig-1008-20261114    gcc-14
x86_64                randconfig-1009-20261114    gcc-14
x86_64                randconfig-1010-20261114    gcc-14
x86_64                randconfig-1011-20261114    gcc-14
x86_64                randconfig-1012-20261114    clang-22
x86_64                randconfig-1012-20261115    gcc-14
x86_64                randconfig-1013-20261114    clang-22
x86_64                randconfig-1013-20261115    gcc-14
x86_64                randconfig-1014-20261114    clang-22
x86_64                randconfig-1014-20261115    gcc-14
x86_64                randconfig-1015-20261114    clang-22
x86_64                randconfig-1015-20261115    gcc-14
x86_64                randconfig-1016-20261114    clang-22
x86_64                randconfig-1016-20261115    gcc-14
x86_64                randconfig-1017-20261114    clang-22
x86_64                randconfig-1017-20261115    gcc-14
x86_64                randconfig-2000-20261114    gcc-14
x86_64                randconfig-2001-20261114    gcc-14
x86_64                randconfig-2002-20261114    gcc-14
x86_64                randconfig-2003-20261114    gcc-14
x86_64                randconfig-2004-20261114    gcc-14
x86_64                randconfig-2005-20261114    gcc-14
x86_64                randconfig-2100-20261114    gcc-14     cocci
x86_64                randconfig-2101-20261114    gcc-14     cocci
x86_64                randconfig-2102-20261114    gcc-14     cocci
x86_64                randconfig-2103-20261114    gcc-14     cocci
x86_64                randconfig-2104-20261114    gcc-14     cocci
x86_64                randconfig-2105-20261114    gcc-14     cocci
x86_64                randconfig-2200-20261114    gcc-14     smatch
x86_64                randconfig-2300-20261114    clang-22   sparse
x86_64                randconfig-2301-20261114    clang-22   sparse
x86_64                randconfig-2302-20261114    clang-22   sparse
x86_64               randconfig-r2105-20261114    gcc-15.3.0 cocci
x86_64               randconfig-r2300-20261114    gcc-8.5.0  sparse
x86_64               randconfig-r2306-20261114    gcc-8.5.0  sparse
x86_64               randconfig-r2310-20261114    gcc-15.3.0 sparse
x86_64               randconfig-r2310-20261114    gcc-8.5.0  sparse
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
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261114    gcc-12.5.0
xtensa                randconfig-1001-20261114    gcc-12.5.0
xtensa                randconfig-2000-20261114    gcc-16.2.0
xtensa                randconfig-2001-20261114    gcc-16.2.0
xtensa               randconfig-r2106-20261114    gcc-8.5.0  cocci
xtensa               randconfig-r2107-20261114    clang-24   cocci
xtensa               randconfig-r2301-20261114    gcc-12.5.0 sparse
xtensa               randconfig-r2305-20261114    gcc-16.2.0 sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
