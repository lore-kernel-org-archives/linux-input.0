Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D5838837F
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 12:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779540222; cv=none; b=IS8mH/CD4w5i0ShoP4OJbGGOYpyxu4sPMtOeKzxLtcXv5Tzni4p++Lt8YtaVhIfJ8pv2YMEWiLvFbck9zDNkedKyKo/tc4FAi/CItEPAlmxPdVJbWCXNrKOw1EQaR78lyGLY+PSxFKsiAu+zZRzo3ceAwlr0oY5BvKIPhYwPPM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779540222; c=relaxed/simple;
	bh=Zi0gb7ZfgYJeZkCmOtKahmvu7Ds8mK/tekHc9TmMxiw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EGDx5eEMOxQUo4y9LZXx7mGZI1lCyn3BiTSlJ88daY+QxS2hvXcK8lK7IhmjTRZeCD96roFzYOWk/3nHF9oBL9UtJHxjOafvF79YkaGtGFmnsm9ppGzENriC7EQ3G0LeefcRVJt0uFBTs+SOODsdkff3B1JGNmkxsD84Lqyljp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RgoykbQB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RgoykbQB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779540221; x=1811076221;
  h=date:from:to:cc:subject:message-id;
  bh=Zi0gb7ZfgYJeZkCmOtKahmvu7Ds8mK/tekHc9TmMxiw=;
  b=RgoykbQBSFBfVgwK1lGKfhqqCE1aa63OKvLVx5E2Pu1YNO8SGcsDg/ak
   +AHF5zSbMxnc674JZtk4aHyl8DYIlGZdCR59REqRqhT3t/PLKKkIgE7/P
   tINOgIeJ2QPXslP1x5hkAh1jUWTQl2+BbC9mvhDyG4ylzLbsvkY1cxZMC
   dDPLGB+L8pCZqDS2ltvPxz+WjI2i8Qgdgdlci2Hs5rq06ZdE3C2jGyOEY
   GqzQxEwns3V2keZ06Z61Ga/6SHTppcT/Hr+0tosTT7G/0Pbsm+Ri1BGzz
   d1+yYBJou0EfSf6DpZL3+BSIfOX4djLgkb9rAnMRx28RD4IVqoiNnzFGR
   A==;
X-CSE-ConnectionGUID: 8qQIJ3bjSzylFaUFrLhfVg==
X-CSE-MsgGUID: 2m7GlSdgTDex/c/FCG+Q5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="84063539"
X-IronPort-AV: E=Sophos;i="6.24,164,1774335600"; 
   d="scan'208";a="84063539"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2026 05:43:40 -0700
X-CSE-ConnectionGUID: +CWuv5GtRFKx+mc/wY2g+g==
X-CSE-MsgGUID: NbhqKCsWQ6KuvO+vJ+zdZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,164,1774335600"; 
   d="scan'208";a="245194666"
Received: from lkp-server02.sh.intel.com (HELO 4bc6da68457b) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 23 May 2026 05:43:39 -0700
Received: from kbuild by 4bc6da68457b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wQlh4-000000000Ie-0uX1;
	Sat, 23 May 2026 12:43:15 +0000
Date: Sat, 23 May 2026 20:42:41 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:for-linus] BUILD SUCCESS
 dab48a7e74e6a394f3aa0461a2b1fb0c7b38fcb8
Message-ID: <202605232032.GtKtgcm2-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
branch HEAD: dab48a7e74e6a394f3aa0461a2b1fb0c7b38fcb8  Input: ims-pcu - fix usb_free_coherent() size in ims_pcu_buffers_free()

elapsed time: 1166m

configs tested: 69
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.2.0
arc                    allmodconfig    gcc-15.2.0
arc                     allnoconfig    gcc-15.2.0
arc                    allyesconfig    gcc-15.2.0
arm                     allnoconfig    clang-23
arm                    allyesconfig    gcc-15.2.0
arm64                  allmodconfig    clang-19
arm64                   allnoconfig    gcc-15.2.0
csky                   allmodconfig    gcc-15.2.0
csky                    allnoconfig    gcc-15.2.0
hexagon                 allnoconfig    clang-23
hexagon     randconfig-001-20260523    clang-23
hexagon     randconfig-002-20260523    clang-23
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                   allyesconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-23
loongarch   randconfig-001-20260523    gcc-15.2.0
loongarch   randconfig-002-20260523    gcc-15.2.0
m68k                   allmodconfig    gcc-15.2.0
m68k                    allnoconfig    gcc-15.2.0
m68k                   allyesconfig    gcc-15.2.0
microblaze              allnoconfig    gcc-15.2.0
microblaze             allyesconfig    gcc-15.2.0
mips                   allmodconfig    gcc-15.2.0
mips                    allnoconfig    gcc-15.2.0
mips                   allyesconfig    gcc-15.2.0
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
nios2       randconfig-001-20260523    gcc-11.5.0
nios2       randconfig-002-20260523    gcc-9.5.0
openrisc                allnoconfig    gcc-15.2.0
parisc                 allmodconfig    gcc-15.2.0
parisc                  allnoconfig    gcc-15.2.0
parisc                 allyesconfig    gcc-15.2.0
parisc      randconfig-002-20260523    gcc-9.5.0
powerpc                allmodconfig    gcc-15.2.0
powerpc                 allnoconfig    gcc-15.2.0
powerpc64   randconfig-002-20260523    clang-20
riscv                  allmodconfig    clang-23
riscv                   allnoconfig    gcc-15.2.0
riscv                  allyesconfig    clang-16
riscv       randconfig-001-20260523    gcc-8.5.0
riscv       randconfig-002-20260523    gcc-8.5.0
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-23
s390                   allyesconfig    gcc-15.2.0
s390        randconfig-001-20260523    clang-23
s390        randconfig-002-20260523    clang-23
sh                      allnoconfig    gcc-15.2.0
sh                     allyesconfig    gcc-15.2.0
sh                        defconfig    gcc-15.2.0
sh          randconfig-001-20260523    gcc-15.2.0
sh          randconfig-002-20260523    gcc-11.5.0
sparc                   allnoconfig    gcc-15.2.0
sparc64                allmodconfig    clang-23
sparc64                   defconfig    clang-20
um                     allmodconfig    clang-19
um                      allnoconfig    clang-23
um                        defconfig    clang-23
um                   i386_defconfig    gcc-14
um                 x86_64_defconfig    clang-23
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64                    defconfig    gcc-14
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
