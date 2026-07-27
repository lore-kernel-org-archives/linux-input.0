Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F26426401
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785175104; cv=none; b=nXku6q5fSZUjVeko3QF0FeIyz4hDkszhr8RiAl8FqmfyD5ntgokWKnarqFr5RGH5+4SGtLSYy56okDuYjVn2U/EpPljbpy1xtVY3rcv2OSVG2X74szv/LNmTzNRjNw42XmDQ8+meHy5XIvqhQi5KPUj3ydgSPXTeaXarhwQUcZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785175104; c=relaxed/simple;
	bh=io3ISvUQjF73OOMuQejnHjDjA5Mz9rLQ2Sqqqjby9Ow=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fr9RG1sWqf4roovy9UDdoVqJzeyH8M4x739EAy9w4SWlmZ8UekipG0wFSOiMHae9UIQzIMmkm1MZMNQEC7lbbg+Q0W7Nyc0Om3MER/LQxElL7BzZX/NyeCBvGhErEgXW8VhbYyWsy/kT8eStbYpLr9dqHLrnMqCXnf7L+bAuzAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLCM62h7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLCM62h7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785175102; x=1816711102;
  h=date:from:to:cc:subject:message-id;
  bh=io3ISvUQjF73OOMuQejnHjDjA5Mz9rLQ2Sqqqjby9Ow=;
  b=JLCM62h7t5MfJ0A6B/A/++dsaPcqpuS45swJBsfD11Rr5ZrNmFvKpyHj
   /DBzxAWDJD8PAxhr71L1FAnNo3U7PxacxFig5mA5q8pT3oLgrrMD+romf
   JBg1HMdNWQulC15o6oOQPyWXqtG2kz2q9HctHZ/HfIMuiPOy2rE35NIa8
   hRv5Q0lAUSohLRf8Jla8z7OdXofjmyjXzvICzzIxwGims4LT+9mx5j2A4
   vikDZj91UVmlLr7si/pGyNY/xHEDl8fT8rkc2VwO+GCzSn8gzWlmftMl+
   ieKytP/0Gc8jpbJ0V0lVx71ippdYk41sKFIX40Bo+vhnXXlu7dym4L9Sq
   Q==;
X-CSE-ConnectionGUID: x1xssRLsRQ2NhEQjcK5V2w==
X-CSE-MsgGUID: +bljMta0RCKgcNpDPtL7Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="84729625"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="84729625"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 10:58:21 -0700
X-CSE-ConnectionGUID: 4ux/nsryTXmeBWixYdbtpw==
X-CSE-MsgGUID: c7mKHdacRQC9BaotH68djg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="256802710"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 27 Jul 2026 10:58:19 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1woPaj-00000000dMK-0sGt;
	Mon, 27 Jul 2026 17:58:17 +0000
Date: Tue, 28 Jul 2026 01:58:13 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:for-linus] BUILD SUCCESS
 5751c781d3c97ab6ce0e2a966156ed882152c415
Message-ID: <202607280158.uBmqEuJj-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
branch HEAD: 5751c781d3c97ab6ce0e2a966156ed882152c415  Input: iforce - validate input packet lengths

elapsed time: 2955m

configs tested: 93
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260726    gcc-8.5.0
arc                  randconfig-002-20260726    gcc-10.5.0
arm                  randconfig-001-20260726    gcc-10.5.0
arm                  randconfig-002-20260726    clang-20
arm                  randconfig-003-20260726    clang-24
arm                  randconfig-004-20260726    clang-24
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260726    clang-24
arm64                randconfig-002-20260726    clang-24
arm64                randconfig-003-20260726    gcc-8.5.0
arm64                randconfig-004-20260726    gcc-8.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260726    gcc-16.1.0
csky                 randconfig-002-20260726    gcc-16.1.0
hexagon              randconfig-001-20260726    clang-24
hexagon              randconfig-002-20260726    clang-24
i386                            allmodconfig    gcc-14
i386                 randconfig-001-20260726    gcc-14
i386                 randconfig-002-20260726    gcc-14
i386                 randconfig-003-20260726    gcc-13
i386                 randconfig-004-20260726    gcc-14
i386                 randconfig-005-20260726    gcc-13
i386                 randconfig-006-20260726    gcc-14
i386                 randconfig-007-20260726    clang-22
i386                 randconfig-011-20260726    clang-22
i386                 randconfig-012-20260726    clang-22
i386                 randconfig-013-20260726    gcc-14
i386                 randconfig-014-20260726    clang-22
i386                 randconfig-015-20260726    clang-22
i386                 randconfig-016-20260726    gcc-14
i386                 randconfig-017-20260726    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260726    gcc-12.5.0
loongarch            randconfig-002-20260726    gcc-14.3.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260726    gcc-11.5.0
nios2                randconfig-002-20260726    gcc-11.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260726    gcc-8.5.0
parisc               randconfig-002-20260726    gcc-15.2.0
powerpc                     pmac32_defconfig    clang-24
powerpc              randconfig-001-20260726    gcc-10.5.0
powerpc              randconfig-002-20260726    gcc-16.1.0
powerpc64            randconfig-001-20260726    clang-16
powerpc64            randconfig-002-20260726    clang-24
riscv                randconfig-001-20260726    clang-24
riscv                randconfig-002-20260726    clang-24
s390                 randconfig-001-20260726    clang-24
s390                 randconfig-002-20260726    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260726    gcc-16.1.0
sh                   randconfig-002-20260726    gcc-16.1.0
sparc                         randconfig-001    gcc-16.1.0
sparc                randconfig-001-20260726    gcc-8.5.0
sparc                randconfig-002-20260726    gcc-8.5.0
sparc64              randconfig-001-20260726    gcc-8.5.0
sparc64              randconfig-002-20260726    clang-24
um                   randconfig-001-20260726    clang-24
um                   randconfig-002-20260726    gcc-14
x86_64     buildonly-randconfig-001-20260726    gcc-14
x86_64     buildonly-randconfig-002-20260726    clang-22
x86_64     buildonly-randconfig-003-20260726    gcc-14
x86_64     buildonly-randconfig-004-20260726    clang-22
x86_64     buildonly-randconfig-005-20260726    clang-22
x86_64     buildonly-randconfig-006-20260726    clang-22
x86_64               randconfig-001-20260726    gcc-14
x86_64               randconfig-002-20260726    gcc-12
x86_64               randconfig-003-20260726    gcc-14
x86_64               randconfig-004-20260726    clang-22
x86_64               randconfig-005-20260726    gcc-14
x86_64               randconfig-006-20260726    gcc-14
x86_64               randconfig-011-20260726    gcc-13
x86_64               randconfig-012-20260726    clang-22
x86_64               randconfig-013-20260726    gcc-14
x86_64               randconfig-014-20260726    gcc-13
x86_64               randconfig-015-20260726    gcc-14
x86_64               randconfig-016-20260726    clang-22
x86_64               randconfig-071-20260726    clang-22
x86_64               randconfig-072-20260726    gcc-14
x86_64               randconfig-073-20260726    gcc-14
x86_64               randconfig-074-20260726    clang-22
x86_64               randconfig-075-20260726    clang-22
x86_64               randconfig-076-20260726    clang-22
xtensa               randconfig-001-20260726    gcc-8.5.0
xtensa               randconfig-002-20260726    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
