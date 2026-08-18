Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5750389455
	for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 01:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787018267; cv=none; b=WeZBxPj8wIgw603bHwjSJJazJhIz3z0wCK2F2riUowX3SrNQ+Rwe4g8KZ6HJcpH8eLv72ko1/HBKYuAeJG0Ohf56gbxQ1vRfqNGFLx80Q5Xz/cdJDyD4WXSPGuyaYWma5Rgan37uo59/dxVjU4iXIZSrTSl91gSUNkA/Is7SuLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787018267; c=relaxed/simple;
	bh=f00o76BiMjqj1Q8LrqvckvVajorWfR57sUZO9ppSboo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hbDSuw5tIp19ugJzDjJvSFPYLqiS2LPuAJvax06x9KRsF5A9qULKmkj/14wyRxw8IY1oL1qS/eFnUZiM16/creQ7OMPRPNHkYl+uXZcxtihi0c1CDDWWCJnb14qcUh/+uZzYIFFGEaGb7trcznsh8TF7RidOrkWgJa9NFXL+YfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f88r1E98; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f88r1E98"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787018263; x=1818554263;
  h=date:from:to:cc:subject:message-id;
  bh=f00o76BiMjqj1Q8LrqvckvVajorWfR57sUZO9ppSboo=;
  b=f88r1E98jbpEZZLA5TfQG5Qluxc2cdr6Ft/hH/OsMtGb+QeuoMeeaoGj
   XLjMLOFGMJg3SbzUtAkZa1v0hmm4eDTEa5b9Dhkf+2W2zLaNJb/SMPkkV
   5CQXBuiJTVdrssCwOBBdyEDY1LAWv1J9zfn4QsdZ1NHR6U9GWdpfn9uQd
   zD7nAnBPXXuV4YHm960bzdNZf38c6JVBrnIEPvaME3tb71PG9fqizzmEi
   8Weuj+G6gkwUdvcRophJuWxF+lY3Sq/WhVVbaHyPq5ptqK5lVKqyhrB2G
   BOW8RsZi2RcBiMW8GE/bP2TIztxlWhFyKc98fnfFub4Ntu8Z6vfBMmtY3
   Q==;
X-CSE-ConnectionGUID: w/68RdUoS22cxhrwp5QfcA==
X-CSE-MsgGUID: Csk0/QKRSuKDdDICqNzeXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="110284966"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="110284966"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 18:57:41 -0700
X-CSE-ConnectionGUID: ckhzzqmXQxiA6z3D7+IMIQ==
X-CSE-MsgGUID: SXf1GZiWSq6IKpuRRu7Ryw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="268915312"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 17 Aug 2026 18:57:40 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1ww957-00000000e1W-3auL;
	Tue, 18 Aug 2026 01:57:37 +0000
Date: Tue, 18 Aug 2026 09:56:51 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:for-linus] BUILD SUCCESS
 b4d85f863e5a6f1fa01b186001af0f68f4f5239e
Message-ID: <202608180939.UjiyTvAk-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
branch HEAD: b4d85f863e5a6f1fa01b186001af0f68f4f5239e  Merge branch 'next' into for-linus

elapsed time: 1927m

configs tested: 126
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                           randconfig-001    gcc-8.5.0
arc                  randconfig-001-20260817    gcc-8.5.0
arc                  randconfig-002-20260817    gcc-8.5.0
arc                          tb10x_defconfig    gcc-16.1.0
arm                  randconfig-001-20260817    gcc-8.5.0
arm                  randconfig-002-20260817    gcc-8.5.0
arm                  randconfig-003-20260817    gcc-8.5.0
arm                  randconfig-004-20260817    gcc-8.5.0
arm64                randconfig-001-20260817    gcc-11.5.0
arm64                randconfig-001-20260818    gcc-12.5.0
arm64                randconfig-002-20260817    gcc-11.5.0
arm64                randconfig-002-20260818    gcc-12.5.0
arm64                randconfig-003-20260817    gcc-11.5.0
arm64                randconfig-003-20260818    gcc-12.5.0
arm64                randconfig-004-20260817    gcc-11.5.0
arm64                randconfig-004-20260818    gcc-12.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260817    gcc-11.5.0
csky                 randconfig-001-20260818    gcc-12.5.0
csky                 randconfig-002-20260817    gcc-11.5.0
csky                 randconfig-002-20260818    gcc-12.5.0
hexagon              randconfig-001-20260817    gcc-8.5.0
hexagon              randconfig-002-20260817    gcc-8.5.0
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    gcc-12
i386       buildonly-randconfig-001-20260817    gcc-12
i386       buildonly-randconfig-002-20260817    gcc-12
i386       buildonly-randconfig-003-20260817    gcc-12
i386       buildonly-randconfig-004-20260817    gcc-12
i386       buildonly-randconfig-005-20260817    gcc-12
i386       buildonly-randconfig-006-20260817    gcc-12
i386                 randconfig-001-20260817    gcc-14
i386                 randconfig-002-20260817    gcc-14
i386                 randconfig-003-20260817    gcc-14
i386                 randconfig-004-20260817    gcc-14
i386                 randconfig-005-20260817    gcc-14
i386                 randconfig-006-20260817    gcc-14
i386                 randconfig-007-20260817    gcc-14
i386                 randconfig-011-20260817    clang-22
i386                 randconfig-012-20260817    clang-22
i386                 randconfig-013-20260817    clang-22
i386                 randconfig-014-20260817    clang-22
i386                 randconfig-015-20260817    clang-22
i386                 randconfig-016-20260817    clang-22
i386                 randconfig-017-20260817    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260817    gcc-8.5.0
loongarch            randconfig-002-20260817    gcc-8.5.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260817    gcc-8.5.0
nios2                randconfig-002-20260817    gcc-8.5.0
openrisc                  de0_nano_defconfig    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-13.4.0
parisc               randconfig-001-20260817    gcc-13.4.0
parisc               randconfig-001-20260818    clang-24
parisc               randconfig-002-20260817    gcc-13.4.0
parisc               randconfig-002-20260818    clang-24
powerpc                     arches_defconfig    gcc-16.1.0
powerpc                  microwatt_defconfig    gcc-16.1.0
powerpc              randconfig-001-20260817    gcc-13.4.0
powerpc              randconfig-001-20260818    clang-24
powerpc              randconfig-002-20260817    gcc-13.4.0
powerpc              randconfig-002-20260818    clang-24
powerpc64            randconfig-001-20260817    gcc-13.4.0
powerpc64            randconfig-001-20260818    clang-24
powerpc64            randconfig-002-20260817    gcc-13.4.0
powerpc64            randconfig-002-20260818    clang-24
riscv                         randconfig-001    clang-18
riscv                         randconfig-001    gcc-10.5.0
riscv                randconfig-001-20260817    gcc-10.5.0
riscv                randconfig-001-20260818    clang-18
riscv                randconfig-002-20260817    gcc-10.5.0
riscv                randconfig-002-20260818    clang-18
s390                 randconfig-001-20260817    gcc-10.5.0
s390                 randconfig-001-20260818    clang-18
s390                 randconfig-002-20260817    gcc-10.5.0
s390                 randconfig-002-20260818    clang-18
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260817    gcc-10.5.0
sh                   randconfig-001-20260818    clang-18
sh                   randconfig-002-20260817    gcc-10.5.0
sh                   randconfig-002-20260818    clang-18
sh                          se7619_defconfig    gcc-16.1.0
sparc                randconfig-001-20260818    gcc-11.5.0
sparc                randconfig-002-20260818    gcc-11.5.0
sparc64              randconfig-001-20260818    gcc-11.5.0
sparc64              randconfig-002-20260818    gcc-11.5.0
um                   randconfig-001-20260818    gcc-11.5.0
um                   randconfig-002-20260818    gcc-11.5.0
x86_64     buildonly-randconfig-001-20260817    gcc-14
x86_64     buildonly-randconfig-002-20260817    gcc-14
x86_64     buildonly-randconfig-003-20260817    gcc-14
x86_64     buildonly-randconfig-004-20260817    gcc-14
x86_64     buildonly-randconfig-005-20260817    gcc-14
x86_64     buildonly-randconfig-006-20260817    gcc-14
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260817    clang-22
x86_64               randconfig-002-20260817    clang-22
x86_64               randconfig-003-20260817    clang-22
x86_64               randconfig-004-20260817    clang-22
x86_64               randconfig-005-20260817    clang-22
x86_64               randconfig-006-20260817    clang-22
x86_64               randconfig-011-20260817    clang-22
x86_64               randconfig-012-20260817    clang-22
x86_64               randconfig-013-20260817    clang-22
x86_64               randconfig-014-20260817    clang-22
x86_64               randconfig-015-20260817    clang-22
x86_64               randconfig-016-20260817    clang-22
x86_64               randconfig-071-20260817    clang-22
x86_64               randconfig-072-20260817    clang-22
x86_64               randconfig-073-20260817    clang-22
x86_64               randconfig-074-20260817    clang-22
x86_64               randconfig-075-20260817    clang-22
x86_64               randconfig-076-20260817    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260818    gcc-11.5.0
xtensa               randconfig-002-20260818    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
