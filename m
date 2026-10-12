Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C083B27DB
	for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820200; cv=none; b=XyaRRln5CmzFEiOPH4fZT1GQywvjB6N0O6A/sgu0FApMVnnyZARvxSBBCNjwQoxq7DGdKANkjgRtr1LEUHf8JubDkUp9VRZyx0H3IXjzTa05XtIs2G2D7LcPHzGacVO3ZOqZ89SLiynI5JkFbZRkl3p3TH2zRJiCnVbyGZI3kIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820200; c=relaxed/simple;
	bh=HFxK6pm2Js+4hRNuub+CqhcUCq5ETe6HTePtI/QvW9M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KeqddejgqFUcPYHAamPhu+UaXVw34GhYwSSRplXGWP1/O32KHMpsnJsmv31wQKO9bjuWTjKQeDxqctA1bRXN7vhh/XDlfSsmwpNUjHeXRArh3Y701gdjVqreyOXZmb2B5L1+Q2u8USK8vf1RrkHT7Btg/lCVmwUCF153K9f/xLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i9crlRDf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i9crlRDf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791820198; x=1823356198;
  h=date:from:to:cc:subject:message-id;
  bh=HFxK6pm2Js+4hRNuub+CqhcUCq5ETe6HTePtI/QvW9M=;
  b=i9crlRDf5ujY2zwmkS9HWaMmFlSjZFryIepd8+zlny6N8QyD//hKZWXt
   PV1ghkPucLRDj7uhixau8rBRpAsT+oJzDI80NgyNaMPzBaxavUy48mHPD
   C59/JM0BuLl8zg1TYATELlEcp54fJzZ8bKDrMtnEn/cyaY/jFEN+d7s4g
   MrfnnIa1sHlyni34CladLNsYrm4z4TX3QmvJ1YQXs7JnDNA7m9pSykR5c
   nXKKzJCQG6SL5POs7aNbzs6LP0VeywL5YQ/eWDXWKTGevducPLSxhqKeg
   XrG8i+KT3DiHaLSXVKnCpGEy8tjYADuEcLfsa/jThABCP4SxXDYcqj82G
   g==;
X-CSE-ConnectionGUID: dzDrUThtSniJleIdLzxNWw==
X-CSE-MsgGUID: vAGvzZuVSPWl4EjUbuaNFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="412568"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="412568"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 08:49:58 -0700
X-CSE-ConnectionGUID: CFXEHRMDRyeBwbhNBERs5Q==
X-CSE-MsgGUID: 8GwAFfz8RZyVwn3Uy9iW+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="849832"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 12 Oct 2026 08:49:56 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xGIHi-00000000BjF-0r9y;
	Mon, 12 Oct 2026 15:49:54 +0000
Date: Mon, 12 Oct 2026 23:49:20 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:master] BUILD SUCCESS
 68a0deade76c01da05f434df9094c2d4cefce1ef
Message-ID: <202610122317.iiVdQoo1-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git master
branch HEAD: 68a0deade76c01da05f434df9094c2d4cefce1ef  Input: mms114 - fix touch slot corruption in suspend

elapsed time: 1156m

configs tested: 429
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2101-20261011    gcc-14.3.0 cocci
alpha                randconfig-r2103-20261011    gcc-8.5.0  cocci
alpha                randconfig-r2106-20261011    clang-24   cocci
alpha                randconfig-r2107-20261011    gcc-11.5.0 cocci
alpha                randconfig-r2201-20261011    gcc-8.5.0  smatch
alpha                randconfig-r2202-20261011    gcc-16.1.0 smatch
alpha                randconfig-r2304-20261011    gcc-16.1.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261012    gcc-8.5.0
arc                   randconfig-1001-20261012    gcc-8.5.0
arc                   randconfig-2000-20261011    gcc-8.5.0
arc                   randconfig-2001-20261011    gcc-8.5.0
arc                  randconfig-r2102-20261011    gcc-14.3.0 cocci
arc                  randconfig-r2105-20261011    gcc-11.5.0 cocci
arc                  randconfig-r2201-20261011    gcc-8.5.0  smatch
arc                  randconfig-r2306-20261011    gcc-8.5.0  sparse
arc                  randconfig-r2309-20261011    gcc-13     sparse
arc                  randconfig-r2310-20261011    clang-19   sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                   randconfig-1000-20261012    gcc-8.5.0
arm                   randconfig-1001-20261012    gcc-8.5.0
arm                   randconfig-1002-20261012    gcc-8.5.0
arm                   randconfig-1003-20261012    gcc-8.5.0
arm                   randconfig-2000-20261011    gcc-8.5.0
arm                   randconfig-2001-20261011    gcc-8.5.0
arm                  randconfig-r2107-20261011    gcc-9.5.0  cocci
arm                  randconfig-r2109-20261011    clang-24   cocci
arm                  randconfig-r2200-20261011    gcc-11.5.0 smatch
arm                  randconfig-r2300-20261011    clang-17   sparse
arm                  randconfig-r2300-20261011    gcc-8.5.0  sparse
arm                  randconfig-r2301-20261011    gcc-16.1.0 sparse
arm                  randconfig-r2303-20261011    gcc-8.5.0  sparse
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261012    clang-24
arm64                 randconfig-1001-20261012    clang-24
arm64                 randconfig-1002-20261012    clang-24
arm64                 randconfig-1003-20261012    clang-24
arm64                 randconfig-2000-20261011    gcc-16.1.0
arm64                 randconfig-2001-20261011    gcc-16.1.0
arm64                randconfig-r2100-20261011    clang-21   cocci
arm64                randconfig-r2108-20261011    clang-24   cocci
arm64                randconfig-r2108-20261011    gcc-12.5.0 cocci
arm64                randconfig-r2110-20261011    clang-22   cocci
arm64                randconfig-r2111-20261011    clang-24   cocci
arm64                randconfig-r2303-20261011    clang-17   sparse
arm64                randconfig-r2303-20261011    gcc-8.5.0  sparse
arm64                randconfig-r2308-20261011    clang-19   sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261012    clang-24
csky                  randconfig-1001-20261012    clang-24
csky                  randconfig-2000-20261011    gcc-16.1.0
csky                  randconfig-2001-20261011    gcc-16.1.0
csky                 randconfig-r2101-20261011    gcc-12.5.0 cocci
csky                 randconfig-r2105-20261011    clang-24   cocci
csky                 randconfig-r2106-20261011    clang-22   cocci
csky                 randconfig-r2110-20261011    gcc-9.5.0  cocci
csky                 randconfig-r2201-20261011    gcc-11.5.0 smatch
csky                 randconfig-r2202-20261011    gcc-9.5.0  smatch
csky                 randconfig-r2301-20261011    gcc-8.5.0  sparse
csky                 randconfig-r2307-20261011    gcc-11.5.0 sparse
csky                 randconfig-r2309-20261011    clang-17   sparse
csky                 randconfig-r2309-20261011    gcc-8.5.0  sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261012    clang-17
hexagon               randconfig-1001-20261012    clang-17
hexagon               randconfig-2000-20261011    gcc-16.1.0
hexagon               randconfig-2001-20261011    gcc-16.1.0
hexagon              randconfig-r2100-20261011    clang-24   cocci
hexagon              randconfig-r2103-20261011    clang-24   cocci
hexagon              randconfig-r2104-20261011    clang-24   cocci
hexagon              randconfig-r2107-20261011    clang-24   cocci
hexagon              randconfig-r2108-20261011    clang-21   cocci
hexagon              randconfig-r2111-20261011    clang-24   cocci
hexagon              randconfig-r2200-20261011    clang-17   smatch
hexagon              randconfig-r2307-20261011    clang-19   sparse
hexagon              randconfig-r2311-20261011    clang-17   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261012    clang-22
i386        buildonly-randconfig-1001-20261012    clang-22
i386        buildonly-randconfig-1002-20261012    clang-22
i386        buildonly-randconfig-1003-20261012    clang-22
i386        buildonly-randconfig-1004-20261012    clang-22
i386        buildonly-randconfig-1005-20261012    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261012    gcc-14
i386                  randconfig-1001-20261012    gcc-14
i386                  randconfig-1002-20261012    gcc-14
i386                  randconfig-1003-20261012    gcc-14
i386                  randconfig-1004-20261012    gcc-14
i386                  randconfig-1005-20261012    gcc-14
i386                  randconfig-1006-20261012    gcc-14
i386                  randconfig-1007-20261012    clang-22
i386                  randconfig-1008-20261012    clang-22
i386                  randconfig-1009-20261012    clang-22
i386                  randconfig-1010-20261012    clang-22
i386                  randconfig-1011-20261012    clang-22
i386                  randconfig-1012-20261012    clang-22
i386                  randconfig-1013-20261012    clang-22
i386                  randconfig-2000-20261011    gcc-8.5.0
i386                  randconfig-2001-20261011    gcc-8.5.0
i386                  randconfig-2100-20261011    gcc-14     cocci
i386                  randconfig-2101-20261011    gcc-14     cocci
i386                  randconfig-2102-20261011    gcc-14     cocci
i386                  randconfig-2103-20261011    gcc-14     cocci
i386                  randconfig-2104-20261011    gcc-14     cocci
i386                  randconfig-2105-20261011    gcc-14     cocci
i386                  randconfig-2200-20261011    clang-22   smatch
i386                  randconfig-2300-20261011    gcc-14     sparse
i386                  randconfig-2301-20261011    gcc-14     sparse
i386                  randconfig-2302-20261011    gcc-14     sparse
i386                 randconfig-r2101-20261011    clang-24   cocci
i386                 randconfig-r2104-20261011    clang-24   cocci
i386                 randconfig-r2108-20261011    gcc-14     cocci
i386                 randconfig-r2110-20261011    gcc-11.5.0 cocci
i386                 randconfig-r2111-20261011    clang-22   cocci
i386                 randconfig-r2200-20261011    clang-22   smatch
i386                 randconfig-r2201-20261011    clang-22   smatch
i386                 randconfig-r2300-20261011    gcc-16.1.0 sparse
i386                 randconfig-r2300-20261011    gcc-8.5.0  sparse
i386                 randconfig-r2301-20261011    gcc-8.5.0  sparse
i386                 randconfig-r2302-20261011    gcc-8.5.0  sparse
i386                 randconfig-r2303-20261011    gcc-16.1.0 sparse
i386                 randconfig-r2311-20261011    gcc-11.5.0 sparse
i386                 randconfig-r2311-20261011    gcc-13     sparse
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261012    clang-17
loongarch             randconfig-1001-20261012    clang-17
loongarch             randconfig-2000-20261011    gcc-8.5.0
loongarch             randconfig-2001-20261011    gcc-8.5.0
loongarch            randconfig-r2102-20261011    gcc-14     cocci
loongarch            randconfig-r2301-20261011    gcc-8.5.0  sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                        m5329evb_defconfig    gcc-16.1.0
m68k                 randconfig-r2101-20261011    gcc-14     cocci
m68k                 randconfig-r2104-20261011    gcc-9.5.0  cocci
m68k                 randconfig-r2310-20261011    gcc-13     sparse
m68k                 randconfig-r2310-20261011    gcc-8.5.0  sparse
m68k                 randconfig-r2311-20261011    gcc-8.5.0  sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2103-20261011    gcc-14     cocci
microblaze           randconfig-r2105-20261011    clang-24   cocci
microblaze           randconfig-r2107-20261011    clang-22   cocci
microblaze           randconfig-r2108-20261011    clang-24   cocci
microblaze           randconfig-r2307-20261011    gcc-11.5.0 sparse
microblaze           randconfig-r2308-20261011    gcc-8.5.0  sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                            ip27_defconfig    gcc-16.1.0
mips                 randconfig-r2100-20261011    clang-24   cocci
mips                 randconfig-r2102-20261011    clang-24   cocci
mips                 randconfig-r2106-20261011    clang-24   cocci
mips                 randconfig-r2107-20261011    clang-24   cocci
mips                 randconfig-r2109-20261011    gcc-12.5.0 cocci
mips                 randconfig-r2202-20261011    gcc-15.2.0 smatch
mips                 randconfig-r2302-20261011    clang-17   sparse
mips                 randconfig-r2302-20261011    gcc-16.1.0 sparse
mips                 randconfig-r2302-20261011    gcc-8.5.0  sparse
mips                 randconfig-r2305-20261011    gcc-8.5.0  sparse
mips                 randconfig-r2306-20261011    gcc-11.5.0 sparse
mips                 randconfig-r2306-20261011    gcc-13     sparse
mips                 randconfig-r2307-20261011    gcc-8.5.0  sparse
mips                 randconfig-r2308-20261011    gcc-11.5.0 sparse
nios2                          10m50_defconfig    gcc-16.1.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261012    clang-17
nios2                 randconfig-1001-20261012    clang-17
nios2                 randconfig-2000-20261011    gcc-8.5.0
nios2                 randconfig-2001-20261011    gcc-8.5.0
nios2                randconfig-r2103-20261011    gcc-12.5.0 cocci
nios2                randconfig-r2104-20261011    gcc-9.5.0  cocci
nios2                randconfig-r2105-20261011    clang-24   cocci
nios2                randconfig-r2105-20261011    gcc-9.5.0  cocci
nios2                randconfig-r2107-20261011    clang-24   cocci
nios2                randconfig-r2200-20261011    gcc-8.5.0  smatch
nios2                randconfig-r2202-20261011    gcc-8.5.0  smatch
nios2                randconfig-r2301-20261011    gcc-16.1.0 sparse
nios2                randconfig-r2304-20261011    clang-17   sparse
nios2                randconfig-r2307-20261011    clang-17   sparse
nios2                randconfig-r2308-20261011    gcc-11.5.0 sparse
nios2                randconfig-r2311-20261011    clang-19   sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2100-20261011    gcc-12.5.0 cocci
openrisc             randconfig-r2105-20261011    clang-22   cocci
openrisc             randconfig-r2110-20261011    gcc-9.5.0  cocci
openrisc             randconfig-r2200-20261011    gcc-16.1.0 smatch
openrisc             randconfig-r2201-20261011    gcc-9.5.0  smatch
openrisc             randconfig-r2300-20261011    gcc-16.1.0 sparse
openrisc             randconfig-r2300-20261011    gcc-8.5.0  sparse
openrisc             randconfig-r2304-20261011    gcc-16.1.0 sparse
openrisc             randconfig-r2306-20261011    clang-17   sparse
openrisc             randconfig-r2306-20261011    gcc-8.5.0  sparse
openrisc             randconfig-r2310-20261011    gcc-11.5.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261012    gcc-8.5.0
parisc                randconfig-1001-20261012    gcc-8.5.0
parisc                randconfig-2000-20261011    gcc-8.5.0
parisc                randconfig-2001-20261011    gcc-8.5.0
parisc               randconfig-r2102-20261011    gcc-12.5.0 cocci
parisc               randconfig-r2104-20261011    clang-22   cocci
parisc               randconfig-r2108-20261011    gcc-12.5.0 cocci
parisc               randconfig-r2110-20261011    clang-24   cocci
parisc               randconfig-r2311-20261011    gcc-8.5.0  sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                     amigaone_defconfig    gcc-16.1.0
powerpc                       ep88xc_defconfig    gcc-16.1.0
powerpc                    motionpro_defconfig    gcc-16.1.0
powerpc                  mpc837x_rdb_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20261012    gcc-8.5.0
powerpc               randconfig-1001-20261012    gcc-8.5.0
powerpc               randconfig-2000-20261011    clang-22
powerpc               randconfig-2001-20261011    clang-22
powerpc              randconfig-r2102-20261011    gcc-12.5.0 cocci
powerpc              randconfig-r2109-20261011    gcc-14     cocci
powerpc              randconfig-r2109-20261011    gcc-14.3.0 cocci
powerpc              randconfig-r2304-20261011    gcc-8.5.0  sparse
powerpc              randconfig-r2308-20261011    gcc-8.5.0  sparse
powerpc              randconfig-r2311-20261011    gcc-11.5.0 sparse
powerpc64             randconfig-1000-20261012    gcc-8.5.0
powerpc64             randconfig-1001-20261012    gcc-8.5.0
powerpc64             randconfig-2000-20261011    clang-22
powerpc64             randconfig-2001-20261011    clang-22
powerpc64            randconfig-r2100-20261011    gcc-8.5.0  cocci
powerpc64            randconfig-r2105-20261011    clang-24   cocci
powerpc64            randconfig-r2109-20261011    clang-21   cocci
powerpc64            randconfig-r2202-20261011    gcc-10.5.0 smatch
powerpc64            randconfig-r2304-20261011    gcc-8.5.0  sparse
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261012    clang-24
riscv                 randconfig-1001-20261012    clang-24
riscv                 randconfig-2000-20261011    gcc-13.4.0
riscv                 randconfig-2001-20261011    gcc-13.4.0
riscv                randconfig-r2110-20261011    clang-24   cocci
riscv                randconfig-r2305-20261011    gcc-16.1.0 sparse
riscv                randconfig-r2305-20261011    gcc-8.5.0  sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261012    clang-24
s390                  randconfig-1001-20261012    clang-24
s390                  randconfig-2000-20261011    gcc-13.4.0
s390                  randconfig-2001-20261011    gcc-13.4.0
s390                 randconfig-r2101-20261011    clang-24   cocci
s390                 randconfig-r2103-20261011    gcc-14.3.0 cocci
s390                 randconfig-r2105-20261011    gcc-9.5.0  cocci
s390                 randconfig-r2109-20261011    gcc-12.5.0 cocci
s390                 randconfig-r2111-20261011    gcc-9.5.0  cocci
s390                 randconfig-r2308-20261011    clang-17   sparse
s390                 randconfig-r2310-20261011    gcc-8.5.0  sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261012    clang-24
sh                    randconfig-1001-20261012    clang-24
sh                    randconfig-2000-20261011    gcc-13.4.0
sh                    randconfig-2001-20261011    gcc-13.4.0
sh                   randconfig-r2100-20261011    gcc-14.3.0 cocci
sh                   randconfig-r2106-20261011    clang-24   cocci
sh                   randconfig-r2106-20261011    gcc-11.5.0 cocci
sh                   randconfig-r2200-20261011    gcc-12.5.0 smatch
sh                   randconfig-r2301-20261011    gcc-8.5.0  sparse
sh                   randconfig-r2303-20261011    gcc-16.1.0 sparse
sh                   randconfig-r2304-20261011    gcc-8.5.0  sparse
sh                   randconfig-r2305-20261011    clang-17   sparse
sh                           rsk7201_defconfig    gcc-16.1.0
sh                           rsk7203_defconfig    gcc-16.1.0
sh                           sdk7780_defconfig    gcc-16.1.0
sparc                             alldefconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261012    clang-20
sparc                 randconfig-1001-20261012    clang-20
sparc                 randconfig-2000-20261011    gcc-8.5.0
sparc                 randconfig-2001-20261011    gcc-8.5.0
sparc                randconfig-r2100-20261011    gcc-14     cocci
sparc                randconfig-r2101-20261011    gcc-12.5.0 cocci
sparc                randconfig-r2102-20261011    clang-24   cocci
sparc                randconfig-r2103-20261011    clang-24   cocci
sparc                randconfig-r2103-20261011    gcc-12.5.0 cocci
sparc                randconfig-r2106-20261011    gcc-9.5.0  cocci
sparc                randconfig-r2107-20261011    clang-24   cocci
sparc                randconfig-r2111-20261011    clang-24   cocci
sparc                randconfig-r2201-20261011    gcc-14.3.0 smatch
sparc                randconfig-r2300-20261011    gcc-8.5.0  sparse
sparc                randconfig-r2308-20261011    gcc-13     sparse
sparc                randconfig-r2309-20261011    gcc-11.5.0 sparse
sparc                randconfig-r2309-20261011    gcc-8.5.0  sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261012    clang-20
sparc64               randconfig-1001-20261012    clang-20
sparc64               randconfig-2000-20261011    gcc-8.5.0
sparc64               randconfig-2001-20261011    gcc-8.5.0
sparc64              randconfig-r2100-20261011    gcc-12.5.0 cocci
sparc64              randconfig-r2102-20261011    clang-21   cocci
sparc64              randconfig-r2103-20261011    clang-21   cocci
sparc64              randconfig-r2104-20261011    clang-24   cocci
sparc64              randconfig-r2108-20261011    gcc-14.3.0 cocci
sparc64              randconfig-r2109-20261011    gcc-8.5.0  cocci
sparc64              randconfig-r2301-20261011    clang-17   sparse
sparc64              randconfig-r2302-20261011    gcc-8.5.0  sparse
sparc64              randconfig-r2305-20261011    gcc-16.1.0 sparse
sparc64              randconfig-r2307-20261011    gcc-8.5.0  sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261012    clang-20
um                    randconfig-1001-20261012    clang-20
um                    randconfig-2000-20261011    gcc-8.5.0
um                    randconfig-2001-20261011    gcc-8.5.0
um                   randconfig-r2101-20261011    clang-21   cocci
um                   randconfig-r2101-20261011    gcc-8.5.0  cocci
um                   randconfig-r2106-20261011    gcc-9.5.0  cocci
um                   randconfig-r2200-20261011    gcc-14     smatch
um                   randconfig-r2202-20261011    gcc-14     smatch
um                   randconfig-r2302-20261011    gcc-16.1.0 sparse
um                   randconfig-r2302-20261011    gcc-8.5.0  sparse
um                   randconfig-r2305-20261011    gcc-8.5.0  sparse
um                   randconfig-r2306-20261011    gcc-11.5.0 sparse
um                   randconfig-r2310-20261011    clang-17   sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261012    clang-22
x86_64      buildonly-randconfig-1001-20261012    clang-22
x86_64      buildonly-randconfig-1002-20261012    clang-22
x86_64      buildonly-randconfig-1003-20261012    clang-22
x86_64      buildonly-randconfig-1004-20261012    clang-22
x86_64      buildonly-randconfig-1005-20261012    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261012    clang-22
x86_64                randconfig-1001-20261012    clang-22
x86_64                randconfig-1002-20261012    clang-22
x86_64                randconfig-1003-20261012    clang-22
x86_64                randconfig-1004-20261012    clang-22
x86_64                randconfig-1005-20261012    clang-22
x86_64                randconfig-1006-20261012    clang-22
x86_64                randconfig-1007-20261012    clang-22
x86_64                randconfig-1008-20261012    clang-22
x86_64                randconfig-1009-20261012    clang-22
x86_64                randconfig-1010-20261012    clang-22
x86_64                randconfig-1011-20261012    clang-22
x86_64                randconfig-1012-20261012    gcc-14
x86_64                randconfig-1013-20261012    gcc-14
x86_64                randconfig-1014-20261012    gcc-14
x86_64                randconfig-1015-20261012    gcc-14
x86_64                randconfig-1016-20261012    gcc-14
x86_64                randconfig-1017-20261012    gcc-14
x86_64                randconfig-2000-20261011    clang-22
x86_64                randconfig-2001-20261011    clang-22
x86_64                randconfig-2100-20261011    gcc-14     cocci
x86_64                randconfig-2101-20261011    gcc-14     cocci
x86_64                randconfig-2102-20261011    gcc-14     cocci
x86_64                randconfig-2103-20261011    gcc-14     cocci
x86_64                randconfig-2104-20261011    gcc-14     cocci
x86_64                randconfig-2105-20261011    gcc-14     cocci
x86_64                randconfig-2200-20261011    clang-22   smatch
x86_64                randconfig-2300-20261011    gcc-14     sparse
x86_64                randconfig-2301-20261011    gcc-14     sparse
x86_64                randconfig-2302-20261011    gcc-14     sparse
x86_64               randconfig-r2104-20261011    gcc-11.5.0 cocci
x86_64               randconfig-r2108-20261011    gcc-8.5.0  cocci
x86_64               randconfig-r2109-20261011    clang-24   cocci
x86_64               randconfig-r2110-20261011    clang-24   cocci
x86_64               randconfig-r2111-20261011    gcc-11.5.0 cocci
x86_64               randconfig-r2307-20261011    gcc-13     sparse
x86_64               randconfig-r2309-20261011    clang-19   sparse
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
xtensa                randconfig-1000-20261012    clang-20
xtensa                randconfig-1001-20261012    clang-20
xtensa                randconfig-2000-20261011    gcc-8.5.0
xtensa                randconfig-2001-20261011    gcc-8.5.0
xtensa               randconfig-r2102-20261011    gcc-8.5.0  cocci
xtensa               randconfig-r2104-20261011    clang-24   cocci
xtensa               randconfig-r2107-20261011    gcc-9.5.0  cocci
xtensa               randconfig-r2111-20261011    gcc-9.5.0  cocci
xtensa               randconfig-r2303-20261011    gcc-8.5.0  sparse
xtensa               randconfig-r2306-20261011    clang-19   sparse
xtensa               randconfig-r2309-20261011    gcc-11.5.0 sparse
xtensa                     xip_kc705_defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
