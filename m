Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBE31B87C9
	for <linux-input@vger.kernel.org>; Sun, 16 Aug 2026 01:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786845204; cv=none; b=Ccr6mT+aN7tdO5/OxEqqyVoSbQyh5bF+ZQc94PNouov01G8RWBjaNHikCTaO+g9LewMzH3mBdk7Q6Cv/yxbRPfb+VcrteLoAZteL6A2tozylmQfYFTwpe2VXBjo7NHWbbPBrcjhPHPP04cSfBPZY2N3PEZcDFuqqH/w0c7/sL+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786845204; c=relaxed/simple;
	bh=PQF9p1dzA8sHUmN2QYFWFY/psHn/iCrUyK8SoXRh7ZY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hWLlgzlX148546TkeiNSrdpxw1R7ayfUtvxkqR905//AOhAJ1vENRaudkl99TAaGk7CTTYZ36N10kFxFpNVyT3VsFyMM7xYyv42HRDBMQ00y1tPrAejaO07kImESmLgU6Eva0xjgtsk51Mluq0YeCHU28PRkkgoLNlTtMcF0I/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KxNMynQa; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KxNMynQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786845203; x=1818381203;
  h=date:from:to:cc:subject:message-id;
  bh=PQF9p1dzA8sHUmN2QYFWFY/psHn/iCrUyK8SoXRh7ZY=;
  b=KxNMynQaVN34kRSVVRJ3foDYM4vaLcnwU9RMtgWNnHuLLYba1hVfQVTi
   xlw1w+O4eltj3zR7tHNj3HpxdbV7GXVQWhASE4qkD2HRFWvbMx0S0Mk77
   sWHJXFNnTkvJSxU1Cp7R+JslzvJ++ahvGlAFI7OguzX+CoKJK5VUQu8ro
   BL8oAJfwMcR1/EYnyX8mR2ve+LOBi5RhJpVBAU8IbfXic6+q36kBUyy4S
   LQ0Bbia8Bv3mlB5/T+pggbrlqfyGwZk1LduivN/24vNnB5d9ggjG7SJxF
   6EeRv43qpyAM5Zzkt1MTWgQgzlksdLQ5E5fqJUq45rDAlG/Xu81C5mYqQ
   w==;
X-CSE-ConnectionGUID: CUZiNLm4QTiBdGpDuuXR0Q==
X-CSE-MsgGUID: aZUnI485SLWqyTIQ3lOapw==
X-IronPort-AV: E=McAfee;i="6800,10657,11876"; a="87226688"
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="87226688"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 18:53:22 -0700
X-CSE-ConnectionGUID: iqtKWbDKQxu3gKMq6pappA==
X-CSE-MsgGUID: Zh5dlYWYSqCkODlw7WOSEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="258362594"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 15 Aug 2026 18:53:20 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wvQ3q-00000000cew-0GOp;
	Sun, 16 Aug 2026 01:53:18 +0000
Date: Sun, 16 Aug 2026 09:52:25 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:for-linus] BUILD SUCCESS
 062dc4693e2c10d77de06f61e6f3faf37c0a8383
Message-ID: <202608160912.eEuiyhYx-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
branch HEAD: 062dc4693e2c10d77de06f61e6f3faf37c0a8383  Input: sur40 - fix V4L error path cleanup

elapsed time: 885m

configs tested: 15
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha            allnoconfig    gcc-16.1.0
alpha           allyesconfig    gcc-16.1.0
alpha              defconfig    gcc-16.1.0
arc             allmodconfig    gcc-16.1.0
arc             allyesconfig    gcc-16.1.0
csky            allmodconfig    gcc-16.1.0
i386            allmodconfig    gcc-14
loongarch          defconfig    clang-24
nios2           allmodconfig    gcc-11.5.0
nios2            allnoconfig    gcc-11.5.0
parisc          allmodconfig    gcc-16.1.0
parisc          allyesconfig    gcc-16.1.0
parisc             defconfig    gcc-16.1.0
sh                 defconfig    gcc-16.1.0
sh         sdk7780_defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
