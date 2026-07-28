Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD272FFF8B
	for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785234330; cv=none; b=WSa3II8PrIHNIhrnPavjvveF+z0X6T+nbLumAEV5M2IBQ+LClQNdgfqEjlXnUHb4iSENGzdLaXoP8L+/reUjLjsC31lt2Ed1P35aPqo/bnQl29Gv96CNnUl2V51brbxkR4DuYUtAa4XL47zRGXFnZuz+2pLXLX14zquf7e62zu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785234330; c=relaxed/simple;
	bh=RZpMRfMyP+h6lc081I18uAB6nddhd2h76WaPWH1qxnU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=J/LSehgdhptfNIvqVyB3XC5WL+rjqCFOmpi3K8DQXel3X0cNocCiY373HmInpSlgV8ZvexNxX4jiqv1i8oK5SvGmmrc+lmdB9ytx1fZxT8k3OS4qQDi2J/8ztbEhgO3X3TESlPZooKv8RpeiYx5oYtywue8YyRMK0up9EinwO0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ne7N4mR+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ne7N4mR+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785234328; x=1816770328;
  h=date:from:to:cc:subject:message-id;
  bh=RZpMRfMyP+h6lc081I18uAB6nddhd2h76WaPWH1qxnU=;
  b=ne7N4mR+DWp2DLd5KsfmqZ7TciqMjOhNmZfA9BwzznpXxD3xH/JLBi6P
   pQBZ6HUEQvPhKGugolYm2eaqmwIUhspSs9fxvmeSgS/Zt9RbYwEml8z/s
   oirlCdYJHiwt/qPhati8hY6bvU3UBe+UKDiLYjQ8ZpU2osq/iOOSR4MRA
   3NO7vLuUmW7NKIf9VoY871YAY/6KvR6Io67lLSv74GFG/6Kkx87gPO2OV
   tDH6V7zLdl1fwQ8r06A5hqdgbkrMpPPjSXNw5bJZogWWlcg7ic55ckhKo
   aTUSLIZyQkj52blXe+IBh81YOiBD36XShokuqcnCpI9gHnsmISCAoW3wg
   g==;
X-CSE-ConnectionGUID: 9zOYd4IPQyOAorcL8FIEeA==
X-CSE-MsgGUID: 4of0Z0noQmyxiuT4YUMeUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85932530"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="85932530"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 03:25:27 -0700
X-CSE-ConnectionGUID: FIpt9LWWSsqrDDpbUU1Nsg==
X-CSE-MsgGUID: 56rFENefQ328/fWsobL5Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="283012618"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 28 Jul 2026 03:25:27 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wof00-00000000eEx-1xIE;
	Tue, 28 Jul 2026 10:25:24 +0000
Date: Tue, 28 Jul 2026 18:25:05 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:test] BUILD SUCCESS
 ee9dccd3588c1e9cd3f0cec25f8cfb26e93ca093
Message-ID: <202607281854.bvryxts7-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git test
branch HEAD: ee9dccd3588c1e9cd3f0cec25f8cfb26e93ca093  Input: psmouse - use guard() for resource management

elapsed time: 877m

configs tested: 39
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                  allnoconfig    gcc-16.1.0
alpha                 allyesconfig    gcc-16.1.0
alpha                    defconfig    gcc-16.1.0
arc                   allmodconfig    gcc-16.1.0
arc                   allyesconfig    gcc-16.1.0
arm64      randconfig-001-20260728    gcc-8.5.0
arm64      randconfig-002-20260728    clang-17
arm64      randconfig-003-20260728    clang-24
arm64      randconfig-004-20260728    gcc-8.5.0
csky                  allmodconfig    gcc-16.1.0
csky       randconfig-001-20260728    gcc-16.1.0
csky       randconfig-002-20260728    gcc-10.5.0
hexagon             randconfig-001    clang-17
hexagon    randconfig-001-20260728    clang-24
hexagon    randconfig-002-20260728    clang-24
i386                  allmodconfig    gcc-14
loongarch                defconfig    clang-24
loongarch  randconfig-001-20260728    gcc-16.1.0
loongarch  randconfig-002-20260728    gcc-16.1.0
nios2                 allmodconfig    gcc-11.5.0
nios2                  allnoconfig    gcc-11.5.0
nios2      randconfig-001-20260728    gcc-11.5.0
nios2      randconfig-002-20260728    gcc-11.5.0
parisc                allmodconfig    gcc-16.1.0
parisc                allyesconfig    gcc-16.1.0
parisc                   defconfig    gcc-16.1.0
parisc     generic-64bit_defconfig    gcc-16.1.0
parisc     randconfig-001-20260728    gcc-8.5.0
powerpc    randconfig-001-20260728    clang-24
powerpc    randconfig-002-20260728    gcc-8.5.0
powerpc64  randconfig-001-20260728    gcc-10.5.0
powerpc64  randconfig-002-20260728    clang-24
riscv      randconfig-001-20260728    clang-20
riscv      randconfig-002-20260728    gcc-8.5.0
s390       randconfig-001-20260728    clang-22
s390       randconfig-002-20260728    gcc-8.5.0
sh                       defconfig    gcc-16.1.0
sh         randconfig-001-20260728    gcc-16.1.0
sh         randconfig-002-20260728    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
