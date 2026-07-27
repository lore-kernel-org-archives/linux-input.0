Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6C141BA77
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164569; cv=none; b=u+Z6/uITXNXXEe/vNv3RxV/enBCNTx7NrtvJXdxql7gUnvkW6AH8ZOOHKs8ytp+iC/Q5HuH14+0FjrPKzYX+BQKkEbLRohDHLpy+6vICQJwWolHZdkEVlG9/yM0DMQ8wD63sVIby5tJ5Q1qg43lscNo04xJwKXvmmunw8ba57ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164569; c=relaxed/simple;
	bh=yAzIa1uVY3j4b0mTkp0iTSv3HKwnj15K0Zw0mSWhScQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SB03umJqslY4Yg8J/atgi1SQa9YiOnlT7gkLTJbPLqXFUwffz2PqrbpybLS87Ai6PIQeE2yASqnIKp6M3zEvd6aWepGq668Gj7Nx6FJ9xbL31l+QFlEIOCmGtUFctWNBqxLXnyyItJMRFyzeMTHMtNYXJvv9kJ0NlIU2oKJhThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJ13CZDF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJ13CZDF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785164567; x=1816700567;
  h=date:from:to:cc:subject:message-id;
  bh=yAzIa1uVY3j4b0mTkp0iTSv3HKwnj15K0Zw0mSWhScQ=;
  b=IJ13CZDFqPfI34R2f9EjjgH0hJVn5yFP0kV/m5s0uaKuWKt79C3dvibn
   Aprca43HGLt2re4D0IZww/kavfUCdUd63OtLJQNfY+NsyUt3C/TpTVLya
   OwnLD9UxESeq2R553LHsNavy4Bc84CGQvj4OVwZUwZVi66zHpgq1jEKdd
   ys4zs9EhqZLKkHoqDPsS1mS5VSGihF7PTOhtIZEi7tvW/4EqWfavG2ULw
   ZFwpEOcoR3D9euKqFq7YNR5O83uXg7wwlGobVrdmLNf7G/Ix648Ac82h6
   +PMR99+y3pZU3cFMJ9bF2DGYdqRhqzhHZoPvMdv0sT9e/F1tcbBYCjQPM
   g==;
X-CSE-ConnectionGUID: zF/DlZ06Rj2fX4YDeeOeVw==
X-CSE-MsgGUID: DyNMoOuRRaumucSVK0+bag==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="88271719"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="88271719"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 08:02:46 -0700
X-CSE-ConnectionGUID: 55f8CGttRWao+fYhp0njkg==
X-CSE-MsgGUID: eAWjPBzISgO0W1w6aFShvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="256072348"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 27 Jul 2026 08:02:45 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1woMql-00000000dFS-0lFu;
	Mon, 27 Jul 2026 15:02:40 +0000
Date: Mon, 27 Jul 2026 23:01:59 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:next] BUILD SUCCESS
 337e5910dcbc38a656e446a6c8a7b37bd496f476
Message-ID: <202607272319.5QGs8fvB-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
branch HEAD: 337e5910dcbc38a656e446a6c8a7b37bd496f476  Input: inexio - replace printk with dev_dbg and fix missing space

elapsed time: 798m

configs tested: 98
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260727    gcc-8.5.0
arc                  randconfig-002-20260727    gcc-8.5.0
arm                      imx_v4_v5_defconfig    clang-24
arm                  randconfig-001-20260727    gcc-8.5.0
arm                  randconfig-002-20260727    gcc-8.5.0
arm                  randconfig-003-20260727    gcc-8.5.0
arm                  randconfig-004-20260727    clang-20
arm64                randconfig-001-20260727    gcc-9.5.0
arm64                randconfig-002-20260727    gcc-8.5.0
arm64                randconfig-003-20260727    gcc-8.5.0
arm64                randconfig-004-20260727    gcc-15.2.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260727    gcc-11.5.0
csky                 randconfig-002-20260727    gcc-9.5.0
hexagon              randconfig-001-20260727    clang-22
hexagon              randconfig-002-20260727    clang-24
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260727    gcc-14
i386       buildonly-randconfig-002-20260727    gcc-14
i386       buildonly-randconfig-003-20260727    gcc-14
i386       buildonly-randconfig-004-20260727    clang-22
i386       buildonly-randconfig-005-20260727    clang-22
i386       buildonly-randconfig-006-20260727    gcc-14
i386                 randconfig-001-20260727    clang-22
i386                 randconfig-002-20260727    gcc-14
i386                 randconfig-003-20260727    clang-22
i386                 randconfig-004-20260727    gcc-14
i386                 randconfig-005-20260727    gcc-12
i386                 randconfig-006-20260727    clang-22
i386                 randconfig-007-20260727    clang-22
i386                 randconfig-011-20260727    clang-22
i386                 randconfig-012-20260727    clang-22
i386                 randconfig-013-20260727    clang-22
i386                 randconfig-014-20260727    clang-22
i386                 randconfig-015-20260727    clang-22
i386                 randconfig-016-20260727    gcc-14
i386                 randconfig-017-20260727    gcc-13
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260727    gcc-16.1.0
loongarch            randconfig-002-20260727    gcc-15.2.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260727    gcc-8.5.0
nios2                randconfig-002-20260727    gcc-11.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260727    gcc-12.5.0
parisc               randconfig-002-20260727    gcc-8.5.0
powerpc              randconfig-001-20260727    gcc-11.5.0
powerpc              randconfig-002-20260727    gcc-8.5.0
powerpc64            randconfig-001-20260727    gcc-8.5.0
powerpc64            randconfig-002-20260727    clang-18
riscv                randconfig-001-20260727    gcc-9.5.0
riscv                randconfig-002-20260727    gcc-11.5.0
s390                 randconfig-001-20260727    clang-24
s390                 randconfig-002-20260727    gcc-8.5.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260727    gcc-15.2.0
sh                   randconfig-002-20260727    gcc-16.1.0
sparc                randconfig-001-20260727    gcc-16.1.0
sparc                randconfig-002-20260727    gcc-8.5.0
sparc64              randconfig-001-20260727    gcc-10.5.0
sparc64              randconfig-002-20260727    gcc-12.5.0
um                   randconfig-001-20260727    gcc-14
um                   randconfig-002-20260727    clang-21
x86_64     buildonly-randconfig-001-20260727    gcc-14
x86_64     buildonly-randconfig-002-20260727    gcc-14
x86_64     buildonly-randconfig-003-20260727    clang-22
x86_64     buildonly-randconfig-004-20260727    clang-22
x86_64     buildonly-randconfig-005-20260727    gcc-14
x86_64     buildonly-randconfig-006-20260727    gcc-14
x86_64               randconfig-001-20260727    gcc-13
x86_64               randconfig-002-20260727    clang-22
x86_64               randconfig-003-20260727    gcc-14
x86_64               randconfig-004-20260727    clang-22
x86_64               randconfig-005-20260727    clang-22
x86_64               randconfig-006-20260727    clang-22
x86_64               randconfig-011-20260727    gcc-14
x86_64               randconfig-012-20260727    gcc-14
x86_64               randconfig-013-20260727    clang-22
x86_64               randconfig-014-20260727    clang-22
x86_64               randconfig-015-20260727    gcc-14
x86_64               randconfig-016-20260727    clang-22
x86_64                        randconfig-071    gcc-14
x86_64               randconfig-071-20260727    gcc-12
x86_64               randconfig-072-20260727    gcc-14
x86_64               randconfig-073-20260727    gcc-14
x86_64               randconfig-074-20260727    clang-22
x86_64               randconfig-075-20260727    gcc-12
x86_64               randconfig-076-20260727    gcc-14
xtensa               randconfig-001-20260727    gcc-14.3.0
xtensa               randconfig-002-20260727    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
