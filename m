Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778C637C90E
	for <linux-input@vger.kernel.org>; Mon,  8 Jun 2026 05:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780898153; cv=none; b=SSD0UMTzPtkovANN/2yLdmVtde08OAWr/GZH9QStGcxmCni5DEp6G2W4I38VCpnH/k77ZouKStpQbWUbxoYafCrE/4JEA4Eo7er9ffAjZi19TIUB4pvWDheG8qI0zjT9NjsuNw0sUy6K2eZbOFHYMvCjPx7lR92RoeZxMzRTw3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780898153; c=relaxed/simple;
	bh=Ab550vrCYR29fsxMb5hp8V+897Qo8y1/PhnsJuMd8Ig=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rOSggD2C/yr/3Bj+jxWiFuHjvV/bBKr5r9L/rAB1shgUQmUwnoEGZYPBrSISD7Ty6YmkRPe14J/IZpEKpcVp5YaXfxRIBXo9Zvq4t/0ohTsFZ9a4vIJcoCypcz2Lb6wuCgiv4fUH6db0YRQqCZxcYtdPn4RcHUlTUMg24NMC7+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SG9ZYBHJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SG9ZYBHJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780898152; x=1812434152;
  h=date:from:to:cc:subject:message-id;
  bh=Ab550vrCYR29fsxMb5hp8V+897Qo8y1/PhnsJuMd8Ig=;
  b=SG9ZYBHJ5hnOl+nI0hmumJr9RKUNOOqCrm0j0qsX3+14FtFi2V0gBQIv
   7LkKcD/9f6zWQzf+Gb48ZP/GfBbXFqQQEKsPJ+x4BpQY0ID7/dZjtNPgZ
   TiU1fEjckQmN7d5ceThK/1SSzcDp1iKreueWdTLYAgOAFkCdDFotgYqmD
   aHo0w0t0HUcmEuxJb8McZni92tMj2nXs7vJHzqdZhDB3RuOJip5rnoJ3b
   NJVDJdh+xbbCtxd5DgntrHKqFJVSql49JLmJNWLgh1KRFggQOJ4uGKAqp
   E8Bix0aD2EZquvzLaBCq6HW4BfGKSCus4d7v7aEp1CxPXg0aFs6JuAfUm
   A==;
X-CSE-ConnectionGUID: Jkn/qvGGRq2ttteUtwef7Q==
X-CSE-MsgGUID: yK+V3AV+Q9m+gS9K27y3Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="84200506"
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="84200506"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 22:55:51 -0700
X-CSE-ConnectionGUID: Rgpp2c8RR3StHyW4B51paA==
X-CSE-MsgGUID: ztZLGXmzSa2GfIGcwtAAGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="245556599"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 07 Jun 2026 22:55:49 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wWSxe-00000000IRy-35he;
	Mon, 08 Jun 2026 05:55:46 +0000
Date: Mon, 08 Jun 2026 13:54:56 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:master] BUILD SUCCESS
 d4579af29e67ca8722db0a1194227f8015c8981d
Message-ID: <202606081347.Id2CTjNy-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git master
branch HEAD: d4579af29e67ca8722db0a1194227f8015c8981d  Input: ims-pcu - fix potential infinite loop in CDC union descriptor parsing

elapsed time: 1528m

configs tested: 192
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260608    gcc-8.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260608    gcc-12.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                            randconfig-001    gcc-16.1.0
arm                   randconfig-001-20260608    gcc-8.5.0
arm                            randconfig-002    gcc-15.2.0
arm                   randconfig-002-20260608    gcc-8.5.0
arm                            randconfig-003    clang-23
arm                   randconfig-003-20260608    clang-23
arm                            randconfig-004    gcc-13.4.0
arm                   randconfig-004-20260608    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    gcc-14.3.0
arm64                 randconfig-001-20260608    gcc-8.5.0
arm64                          randconfig-002    gcc-8.5.0
arm64                 randconfig-002-20260608    gcc-12.5.0
arm64                          randconfig-003    clang-20
arm64                 randconfig-003-20260608    clang-23
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260608    gcc-12.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    gcc-13.4.0
csky                  randconfig-001-20260608    gcc-12.5.0
csky                           randconfig-002    gcc-14.3.0
csky                  randconfig-002-20260608    gcc-16.1.0
hexagon                          allmodconfig    clang-23
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon                        randconfig-001    clang-23
hexagon               randconfig-001-20260608    clang-23
hexagon                        randconfig-002    clang-23
hexagon               randconfig-002-20260608    clang-17
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260608    gcc-14
i386        buildonly-randconfig-002-20260608    clang-22
i386        buildonly-randconfig-003-20260608    gcc-14
i386        buildonly-randconfig-004-20260608    clang-22
i386        buildonly-randconfig-005-20260608    gcc-14
i386        buildonly-randconfig-006-20260608    clang-22
i386                                defconfig    clang-22
i386                  randconfig-012-20260608    gcc-14
i386                           randconfig-014    clang-22
i386                           randconfig-015    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260608    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-20
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    clang-23
loongarch             randconfig-001-20260608    clang-23
loongarch                      randconfig-002    gcc-16.1.0
loongarch             randconfig-002-20260608    clang-18
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260608    gcc-11.5.0
nios2                          randconfig-002    gcc-8.5.0
nios2                 randconfig-002-20260608    gcc-11.5.0
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-8.5.0
parisc                randconfig-001-20260608    gcc-8.5.0
parisc                         randconfig-002    gcc-12.5.0
parisc                randconfig-002-20260608    gcc-8.5.0
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    gcc-16.1.0
powerpc                        randconfig-001    gcc-10.5.0
powerpc               randconfig-001-20260608    clang-17
powerpc                        randconfig-002    gcc-8.5.0
powerpc               randconfig-002-20260608    clang-16
powerpc64                      randconfig-001    clang-16
powerpc64             randconfig-001-20260608    gcc-14.3.0
powerpc64                      randconfig-002    clang-23
powerpc64             randconfig-002-20260608    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260608    clang-23
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                  randconfig-001-20260608    gcc-15.2.0
s390                  randconfig-002-20260608    clang-20
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-16.1.0
sh                          kfr2r09_defconfig    gcc-16.1.0
sh                    randconfig-001-20260608    gcc-12.5.0
sh                    randconfig-002-20260608    gcc-10.5.0
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-16.1.0
sparc                 randconfig-001-20260608    gcc-13.4.0
sparc                          randconfig-002    gcc-11.5.0
sparc                 randconfig-002-20260608    gcc-15.2.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64                        randconfig-001    gcc-12.5.0
sparc64               randconfig-001-20260608    clang-20
sparc64                        randconfig-002    clang-20
sparc64               randconfig-002-20260608    gcc-15.2.0
um                               allmodconfig    clang-23
um                                allnoconfig    clang-16
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                             randconfig-001    clang-23
um                    randconfig-001-20260608    gcc-14
um                             randconfig-002    clang-23
um                    randconfig-002-20260608    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260608    gcc-14
x86_64      buildonly-randconfig-002-20260608    clang-22
x86_64      buildonly-randconfig-003-20260608    gcc-13
x86_64      buildonly-randconfig-004-20260608    gcc-14
x86_64      buildonly-randconfig-005-20260608    clang-22
x86_64      buildonly-randconfig-006-20260608    gcc-14
x86_64                              defconfig    gcc-14
x86_64                         randconfig-001    gcc-14
x86_64                randconfig-001-20260608    clang-22
x86_64                         randconfig-002    gcc-14
x86_64                randconfig-002-20260608    gcc-14
x86_64                         randconfig-003    clang-22
x86_64                randconfig-003-20260608    gcc-14
x86_64                         randconfig-004    clang-22
x86_64                         randconfig-005    gcc-14
x86_64                randconfig-005-20260608    clang-22
x86_64                randconfig-006-20260608    gcc-14
x86_64                         randconfig-011    gcc-14
x86_64                randconfig-011-20260608    gcc-14
x86_64                         randconfig-012    gcc-14
x86_64                randconfig-012-20260608    clang-22
x86_64                         randconfig-013    clang-22
x86_64                randconfig-013-20260608    clang-22
x86_64                         randconfig-014    gcc-14
x86_64                randconfig-014-20260608    gcc-14
x86_64                         randconfig-015    gcc-14
x86_64                randconfig-015-20260608    gcc-14
x86_64                         randconfig-016    clang-22
x86_64                randconfig-016-20260608    gcc-14
x86_64                randconfig-071-20260608    gcc-14
x86_64                randconfig-072-20260608    gcc-14
x86_64                randconfig-073-20260608    clang-22
x86_64                randconfig-074-20260608    clang-22
x86_64                randconfig-075-20260608    clang-22
x86_64                randconfig-076-20260608    clang-22
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    gcc-16.1.0
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260608    gcc-9.5.0
xtensa                         randconfig-002    gcc-13.4.0
xtensa                randconfig-002-20260608    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
