Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27CE17BED0
	for <linux-input@vger.kernel.org>; Mon, 16 Mar 2026 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773646360; cv=none; b=daRRmlgHy5Ilxtb1zqMm0VqqSC9Tz/43ZFOn+wvo8NAFi+AGU06eizCromJNwOi0wcnojcGn/4jaFnVWmtQPs2z++3vEBaUkWv80Y7RIdPddhbAcNCrRNTf3n5b598lOoelObKl89A1IdusmWTqKQJeRsZlcowb5akvyIxIZ6eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773646360; c=relaxed/simple;
	bh=ZWSH10osJM4At5V9QOSPmcmGBv2LPcFR3huV2+C7rx4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TBRC4XqU9MTUfGC8o1+7Ow1caQNf9KmvZsiwvel289QJFY8OcI8AtmQEUCitWCnRDuD4gUIJ0UhzgUuB27zX0hFhkOfUh24pac25kPztFwpA8znN+s3z3BFOdod4OS0F6vf+3ZWNEvh10Gar+oKt1Lihf7C0kwaP3Z5GW4Z5mXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XiJojWx8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XiJojWx8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773646359; x=1805182359;
  h=date:from:to:cc:subject:message-id;
  bh=ZWSH10osJM4At5V9QOSPmcmGBv2LPcFR3huV2+C7rx4=;
  b=XiJojWx86BqVB3xynjsXp60bpqyj2929q+OAedNKiFOMg0ozmCCw8tFz
   yDysBP3Hdux83RrsxEjwRok4/Wlt7jlvEb5wCu5HQaYiscwKDF4Wm22Iu
   QfKz5U0/OkYeRr65uZpGtaxQcaw04Kq9ffFLoOpdLctl55m4giYU4WyhQ
   S+EYQ4jKqYlzg7ktOuy6ze0iewcaP1ZMnHprYf+QcbmCYefu6gxmTWPKy
   SD+KAJG7e+g97LjFjnkjVPnTCiiTfLNhE0cyEkhl7U3KeYwcyFV8tLkqw
   P0W07INxYm5Y19ZKgPijsn0tELl5nLhiVN1zEt3+mzsUlYjeEdlE6/Xj5
   A==;
X-CSE-ConnectionGUID: tDzfunNrTSWYUBdFkD1Y5g==
X-CSE-MsgGUID: i0WDKv/BRDu9Dz9wFDAlvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="73670451"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="73670451"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:32:38 -0700
X-CSE-ConnectionGUID: QaN2CtvJQqGpmmr4odPpsw==
X-CSE-MsgGUID: f5D3zB01RBOo/ACmXjuU2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="224071160"
Received: from lkp-server01.sh.intel.com (HELO 892944969b78) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 16 Mar 2026 00:32:37 -0700
Received: from kbuild by 892944969b78 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w22RG-000000000Ik-3kkV;
	Mon, 16 Mar 2026 07:32:34 +0000
Date: Mon, 16 Mar 2026 15:32:03 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:next] BUILD SUCCESS
 beb2b0a26c3a1021421e8db40154c3b6687b6621
Message-ID: <202603161557.m9nyfkQn-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
branch HEAD: beb2b0a26c3a1021421e8db40154c3b6687b6621  Input: psmouse - remove dedicated kpsmoused workqueue

elapsed time: 736m

configs tested: 233
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
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260316    clang-23
arc                   randconfig-002-20260316    clang-23
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260316    clang-23
arm                   randconfig-002-20260316    clang-23
arm                   randconfig-003-20260316    clang-23
arm                   randconfig-004-20260316    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260316    clang-23
arm64                 randconfig-001-20260316    gcc-11.5.0
arm64                 randconfig-002-20260316    clang-23
arm64                 randconfig-003-20260316    clang-23
arm64                 randconfig-004-20260316    clang-19
arm64                 randconfig-004-20260316    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260316    clang-23
csky                  randconfig-001-20260316    gcc-15.2.0
csky                  randconfig-002-20260316    clang-23
csky                  randconfig-002-20260316    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260316    clang-23
hexagon               randconfig-001-20260316    gcc-11.5.0
hexagon               randconfig-002-20260316    clang-23
hexagon               randconfig-002-20260316    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260316    gcc-14
i386        buildonly-randconfig-002-20260316    gcc-14
i386        buildonly-randconfig-003-20260316    gcc-14
i386        buildonly-randconfig-004-20260316    gcc-14
i386        buildonly-randconfig-005-20260316    gcc-14
i386        buildonly-randconfig-006-20260316    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260316    gcc-14
i386                  randconfig-002-20260316    gcc-14
i386                  randconfig-003-20260316    gcc-14
i386                  randconfig-004-20260316    gcc-14
i386                  randconfig-005-20260316    gcc-14
i386                  randconfig-006-20260316    gcc-14
i386                  randconfig-007-20260316    gcc-14
i386                  randconfig-011-20260316    clang-20
i386                  randconfig-011-20260316    gcc-13
i386                  randconfig-012-20260316    gcc-13
i386                  randconfig-012-20260316    gcc-14
i386                  randconfig-013-20260316    clang-20
i386                  randconfig-013-20260316    gcc-13
i386                  randconfig-014-20260316    gcc-13
i386                  randconfig-015-20260316    clang-20
i386                  randconfig-015-20260316    gcc-13
i386                  randconfig-016-20260316    gcc-13
i386                  randconfig-016-20260316    gcc-14
i386                  randconfig-017-20260316    clang-20
i386                  randconfig-017-20260316    gcc-13
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260316    gcc-11.5.0
loongarch             randconfig-001-20260316    gcc-14.3.0
loongarch             randconfig-002-20260316    clang-18
loongarch             randconfig-002-20260316    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260316    gcc-11.5.0
nios2                 randconfig-002-20260316    gcc-11.5.0
nios2                 randconfig-002-20260316    gcc-8.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260316    gcc-13.4.0
parisc                randconfig-001-20260316    gcc-8.5.0
parisc                randconfig-002-20260316    gcc-12.5.0
parisc                randconfig-002-20260316    gcc-13.4.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260316    clang-23
powerpc               randconfig-001-20260316    gcc-13.4.0
powerpc               randconfig-002-20260316    clang-23
powerpc               randconfig-002-20260316    gcc-13.4.0
powerpc64             randconfig-001-20260316    gcc-13.4.0
powerpc64             randconfig-002-20260316    gcc-13.4.0
powerpc64             randconfig-002-20260316    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260316    gcc-12.5.0
riscv                 randconfig-001-20260316    gcc-15.2.0
riscv                 randconfig-002-20260316    gcc-12.5.0
riscv                 randconfig-002-20260316    gcc-8.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260316    clang-18
s390                  randconfig-001-20260316    gcc-12.5.0
s390                  randconfig-002-20260316    gcc-12.5.0
s390                  randconfig-002-20260316    gcc-14.3.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260316    gcc-12.5.0
sh                    randconfig-001-20260316    gcc-15.2.0
sh                    randconfig-002-20260316    gcc-12.5.0
sh                          rsk7203_defconfig    gcc-15.2.0
sh                           sh2007_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260316    gcc-12.5.0
sparc                 randconfig-001-20260316    gcc-8.5.0
sparc                 randconfig-002-20260316    gcc-12.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260316    gcc-12.5.0
sparc64               randconfig-001-20260316    gcc-8.5.0
sparc64               randconfig-002-20260316    gcc-12.5.0
sparc64               randconfig-002-20260316    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260316    gcc-12.5.0
um                    randconfig-001-20260316    gcc-14
um                    randconfig-002-20260316    clang-23
um                    randconfig-002-20260316    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260316    clang-20
x86_64      buildonly-randconfig-001-20260316    gcc-14
x86_64      buildonly-randconfig-002-20260316    clang-20
x86_64      buildonly-randconfig-003-20260316    clang-20
x86_64      buildonly-randconfig-004-20260316    clang-20
x86_64      buildonly-randconfig-004-20260316    gcc-14
x86_64      buildonly-randconfig-005-20260316    clang-20
x86_64      buildonly-randconfig-005-20260316    gcc-14
x86_64      buildonly-randconfig-006-20260316    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260316    clang-20
x86_64                randconfig-001-20260316    gcc-14
x86_64                randconfig-002-20260316    clang-20
x86_64                randconfig-003-20260316    clang-20
x86_64                randconfig-004-20260316    clang-20
x86_64                randconfig-004-20260316    gcc-14
x86_64                randconfig-005-20260316    clang-20
x86_64                randconfig-006-20260316    clang-20
x86_64                randconfig-011-20260316    gcc-14
x86_64                randconfig-012-20260316    gcc-14
x86_64                randconfig-013-20260316    gcc-14
x86_64                randconfig-014-20260316    gcc-14
x86_64                randconfig-015-20260316    clang-20
x86_64                randconfig-015-20260316    gcc-14
x86_64                randconfig-016-20260316    gcc-14
x86_64                randconfig-071-20260316    gcc-12
x86_64                randconfig-072-20260316    gcc-12
x86_64                randconfig-072-20260316    gcc-14
x86_64                randconfig-073-20260316    gcc-12
x86_64                randconfig-073-20260316    gcc-14
x86_64                randconfig-074-20260316    gcc-12
x86_64                randconfig-074-20260316    gcc-14
x86_64                randconfig-075-20260316    clang-20
x86_64                randconfig-075-20260316    gcc-12
x86_64                randconfig-076-20260316    clang-20
x86_64                randconfig-076-20260316    gcc-12
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
xtensa                randconfig-001-20260316    gcc-12.5.0
xtensa                randconfig-001-20260316    gcc-15.2.0
xtensa                randconfig-002-20260316    gcc-12.5.0
xtensa                randconfig-002-20260316    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
