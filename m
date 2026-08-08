Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D356371D10
	for <linux-input@vger.kernel.org>; Sat,  8 Aug 2026 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786208098; cv=none; b=SPpdbyevVJ/22T6SV+Q1qiJcU17f7Ow1jTEm3UUIzAlPFwAGmaEarVNem421BGWeRtBZjL76vC8262PlFcY0SKA12Vu0SBfUCX/VUiJO6paE+q+Y3VOR0slan/vHp7KTHSPgi9YYDIZuyNGAaK7HvSaODqRp8KhO0c3E0WIXJho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786208098; c=relaxed/simple;
	bh=AmNm/ns4OPFbtnUbz5Mm2d54wsFVaDZ05EwVX61PoQ0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=arx5dmgHkG/wqlUhWowNxieJ2ojrMoS8OO29FzHsysbb3M9KCeg3cCVvlNyff3hjMneZgCXxB1EzWqC67q8PSRHTRbAoCosaJHgyuGrnZDwYK8XUBOkch4aV5t3oXNMRmwg48pBNDIAwwV6loIHc0XLqd0W2m9zFNLzuJ25EngQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UgDGoIeV; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UgDGoIeV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786208096; x=1817744096;
  h=date:from:to:cc:subject:message-id;
  bh=AmNm/ns4OPFbtnUbz5Mm2d54wsFVaDZ05EwVX61PoQ0=;
  b=UgDGoIeV26HPDjK2H/sEq5lDpehQm4WF4zJbn5tjoPL8KGZFgXt3liP1
   UL51KLUvb2grScycBRAV68WGRRP17zR1tX/xDvCVEjvPnR0G7S2lGFSha
   QaBWOeXdjSrZi/2LeaeQWLtpDIQ8mDQY1B3KmtbEYgOl28l9wcGbu5SuQ
   P7ejHiPlN5FT0iFq0IUBK5lsZQ2jRQtnfAqtP2iTCVuYv2cJD75R3KWl0
   pPRCKJwZbFFrwRhqAImecUbBV3/hIr3FNslN2x0tLqQItcxCb0rGymljm
   oSTu9PwzMXlK5Gt41BHejOHV1m8qrqCljLtCceziqW98ZUriQiI4jygdY
   A==;
X-CSE-ConnectionGUID: zZ92BwfzQH2mUPA6AMETAg==
X-CSE-MsgGUID: EX7zs9LJSPKZdsPEY3Hmxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="74325064"
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="74325064"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 09:54:56 -0700
X-CSE-ConnectionGUID: mX+LUSx5QjWzgR/f0zOKfQ==
X-CSE-MsgGUID: 5dFfJquKTDKvX/1cxTZdBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="287347092"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 08 Aug 2026 09:54:54 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wskJv-00000000KRp-49Ef;
	Sat, 08 Aug 2026 16:54:51 +0000
Date: Sun, 09 Aug 2026 00:54:00 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:for-linus] BUILD SUCCESS
 3abd29c61d2ef37c4102cf755b18be53bb9dbea6
Message-ID: <202608090041.h5Q1cjrj-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
branch HEAD: 3abd29c61d2ef37c4102cf755b18be53bb9dbea6  Input: evdev - sanitize event type index when fetching event masks

elapsed time: 2968m

configs tested: 166
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260807    gcc-14.3.0
arc                  randconfig-001-20260807    gcc-8.5.0
arc                  randconfig-001-20260808    gcc-9.5.0
arc                  randconfig-002-20260807    gcc-14.3.0
arc                  randconfig-002-20260808    gcc-9.5.0
arm                      aspeed_g5_defconfig    gcc-16.1.0
arm                  randconfig-001-20260807    clang-24
arm                  randconfig-001-20260807    gcc-14.3.0
arm                  randconfig-001-20260808    gcc-9.5.0
arm                  randconfig-002-20260807    gcc-12.5.0
arm                  randconfig-002-20260807    gcc-14.3.0
arm                  randconfig-002-20260808    gcc-9.5.0
arm                  randconfig-003-20260807    gcc-10.5.0
arm                  randconfig-003-20260807    gcc-14.3.0
arm                  randconfig-003-20260808    gcc-9.5.0
arm                  randconfig-004-20260807    gcc-14.3.0
arm                  randconfig-004-20260807    gcc-16.1.0
arm                  randconfig-004-20260808    gcc-9.5.0
arm64                         randconfig-001    gcc-11.5.0
arm64                randconfig-001-20260807    gcc-16.1.0
arm64                randconfig-001-20260808    gcc-11.5.0
arm64                randconfig-002-20260807    gcc-16.1.0
arm64                randconfig-002-20260808    gcc-11.5.0
arm64                randconfig-003-20260807    gcc-16.1.0
arm64                randconfig-003-20260808    gcc-11.5.0
arm64                randconfig-004-20260807    gcc-16.1.0
arm64                randconfig-004-20260808    gcc-11.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260807    gcc-16.1.0
csky                 randconfig-001-20260808    gcc-11.5.0
csky                 randconfig-002-20260807    gcc-16.1.0
csky                 randconfig-002-20260808    gcc-11.5.0
hexagon                       randconfig-001    clang-24
hexagon              randconfig-001-20260807    clang-18
hexagon              randconfig-001-20260807    clang-24
hexagon              randconfig-001-20260808    gcc-16.1.0
hexagon              randconfig-002-20260807    clang-18
hexagon              randconfig-002-20260807    clang-24
hexagon              randconfig-002-20260808    gcc-16.1.0
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    clang-22
i386       buildonly-randconfig-001-20260807    gcc-13
i386       buildonly-randconfig-001-20260808    clang-22
i386       buildonly-randconfig-002-20260807    gcc-13
i386       buildonly-randconfig-002-20260808    clang-22
i386       buildonly-randconfig-003-20260807    gcc-13
i386       buildonly-randconfig-003-20260808    clang-22
i386       buildonly-randconfig-004-20260807    gcc-13
i386       buildonly-randconfig-004-20260808    clang-22
i386       buildonly-randconfig-005-20260807    gcc-13
i386       buildonly-randconfig-005-20260808    clang-22
i386       buildonly-randconfig-006-20260807    gcc-13
i386       buildonly-randconfig-006-20260808    clang-22
i386                 randconfig-001-20260808    clang-22
i386                 randconfig-002-20260808    clang-22
i386                 randconfig-003-20260808    clang-22
i386                 randconfig-004-20260808    clang-22
i386                 randconfig-005-20260808    clang-22
i386                 randconfig-006-20260808    clang-22
i386                 randconfig-007-20260808    clang-22
i386                 randconfig-011-20260807    clang-22
i386                 randconfig-011-20260808    clang-22
i386                 randconfig-012-20260807    clang-22
i386                 randconfig-012-20260808    clang-22
i386                 randconfig-013-20260807    clang-22
i386                 randconfig-013-20260808    clang-22
i386                 randconfig-014-20260807    clang-22
i386                 randconfig-014-20260808    clang-22
i386                 randconfig-015-20260807    clang-22
i386                 randconfig-015-20260808    clang-22
i386                 randconfig-016-20260807    clang-22
i386                 randconfig-016-20260808    clang-22
i386                 randconfig-017-20260807    clang-22
i386                 randconfig-017-20260808    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260807    clang-18
loongarch            randconfig-001-20260807    clang-24
loongarch            randconfig-001-20260808    gcc-16.1.0
loongarch            randconfig-002-20260807    clang-18
loongarch            randconfig-002-20260808    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260807    clang-18
nios2                randconfig-001-20260807    gcc-8.5.0
nios2                randconfig-001-20260808    gcc-16.1.0
nios2                randconfig-002-20260807    clang-18
nios2                randconfig-002-20260807    gcc-8.5.0
nios2                randconfig-002-20260808    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260808    gcc-8.5.0
parisc               randconfig-002-20260808    gcc-8.5.0
powerpc              randconfig-001-20260808    gcc-8.5.0
powerpc              randconfig-002-20260808    gcc-8.5.0
powerpc64            randconfig-001-20260808    gcc-8.5.0
powerpc64            randconfig-002-20260808    gcc-8.5.0
riscv                randconfig-001-20260807    gcc-12.5.0
riscv                randconfig-001-20260808    clang-24
riscv                randconfig-002-20260807    gcc-10.5.0
riscv                randconfig-002-20260808    clang-24
s390                 randconfig-001-20260807    gcc-9.5.0
s390                 randconfig-001-20260808    clang-24
s390                 randconfig-002-20260807    gcc-15.2.0
s390                 randconfig-002-20260808    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260807    gcc-16.1.0
sh                   randconfig-001-20260808    clang-24
sh                   randconfig-002-20260807    gcc-16.1.0
sh                   randconfig-002-20260808    clang-24
sparc                randconfig-001-20260808    gcc-8.5.0
sparc                randconfig-002-20260808    gcc-8.5.0
sparc64              randconfig-001-20260808    gcc-8.5.0
sparc64              randconfig-002-20260808    gcc-8.5.0
um                   randconfig-001-20260808    gcc-8.5.0
um                   randconfig-002-20260808    gcc-8.5.0
x86_64     buildonly-randconfig-001-20260807    clang-22
x86_64     buildonly-randconfig-001-20260808    gcc-14
x86_64     buildonly-randconfig-002-20260807    clang-22
x86_64     buildonly-randconfig-002-20260807    gcc-14
x86_64     buildonly-randconfig-002-20260808    gcc-14
x86_64     buildonly-randconfig-003-20260807    clang-22
x86_64     buildonly-randconfig-003-20260807    gcc-14
x86_64     buildonly-randconfig-003-20260808    gcc-14
x86_64     buildonly-randconfig-004-20260807    clang-22
x86_64     buildonly-randconfig-004-20260808    gcc-14
x86_64     buildonly-randconfig-005-20260807    clang-22
x86_64     buildonly-randconfig-005-20260808    gcc-14
x86_64     buildonly-randconfig-006-20260807    clang-22
x86_64     buildonly-randconfig-006-20260808    gcc-14
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    clang-22
x86_64               randconfig-001-20260808    clang-22
x86_64               randconfig-002-20260808    clang-22
x86_64               randconfig-003-20260808    clang-22
x86_64               randconfig-004-20260808    clang-22
x86_64               randconfig-005-20260808    clang-22
x86_64               randconfig-006-20260808    clang-22
x86_64               randconfig-011-20260808    clang-22
x86_64               randconfig-012-20260808    clang-22
x86_64               randconfig-013-20260808    clang-22
x86_64               randconfig-014-20260808    clang-22
x86_64               randconfig-015-20260808    clang-22
x86_64               randconfig-016-20260808    clang-22
x86_64                        randconfig-071    gcc-14
x86_64               randconfig-071-20260807    clang-22
x86_64               randconfig-071-20260808    gcc-14
x86_64               randconfig-072-20260807    clang-22
x86_64               randconfig-072-20260808    gcc-14
x86_64               randconfig-073-20260807    clang-22
x86_64               randconfig-073-20260808    gcc-14
x86_64               randconfig-074-20260807    clang-22
x86_64               randconfig-074-20260808    gcc-14
x86_64               randconfig-075-20260807    clang-22
x86_64               randconfig-075-20260808    gcc-14
x86_64               randconfig-076-20260807    clang-22
x86_64               randconfig-076-20260808    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa                 nommu_kc705_defconfig    gcc-16.1.0
xtensa               randconfig-001-20260808    gcc-8.5.0
xtensa               randconfig-002-20260808    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
