Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5071A262D
	for <linux-input@vger.kernel.org>; Sun,  7 Jun 2026 19:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780861960; cv=none; b=jJxLZ82YT01OUKQu0eEYxs/9QcIYTTw6ZSdX0Qa9Cl9j7+MLl6WjY1/PUJd+3xRBCGT/hxt9lde+1Ro7beJCcXJYYoPCVCyxN2Sl6TPaqDrqdK62MG+qSFZNvL51D1VdpPtr2OyXeJrjm0FMXOVsa0c/Jger3+f6lEd8J149reE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780861960; c=relaxed/simple;
	bh=R/uY9VZnl+lU4NJYikMEMgBUnWDukvX6fDP1kl8C6Qg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=C9jmx34n0tpz7eVAp0GKyp/CLR5s08W2EmcZLcha8Goy3hAun/K8T6Zll+Iha1U49RnGGf0R8ExFDMGli2ic3Bplj+HL+U13ZUfj89nLxIJC/cF/fBqWHv70pP8Kfo74fHoh1r2pPFL3bBNSss1hWaw/1Q+FDy7eMftpWgP/XD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cSbgenMX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cSbgenMX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780861959; x=1812397959;
  h=date:from:to:cc:subject:message-id;
  bh=R/uY9VZnl+lU4NJYikMEMgBUnWDukvX6fDP1kl8C6Qg=;
  b=cSbgenMXC7nqH0jktqrTj5S6G/uIdgR/B8W7STOc1TkCVUpE54p17mCw
   h/bIAD0agQ2oLmk4CfdcIvD47PChdh0Q9mlGA64uyYlUYjLW2NH+ab50v
   0Ig8ybY0Niply88pESDT+ba9JXw3IyJg7Lww7EdYHAaC8NKG389LHGLg3
   h5ctmcnLgtijrlgc69wuvEUDuM4d10kExOTJDcy4n7FIkJ+6IelXchXoy
   hOuHHgAqUT76ssqOI5sKH6+aqKn8zjpmoSDFvBdpo9lZ8B+M0IAijCJZQ
   msNaFXBomQ5RzN9uLegM2L8FG2slut0eVjWghornVfe8M47uoqfrhGIAA
   Q==;
X-CSE-ConnectionGUID: 3dA7+VggRI6D1kcx5Yqe6w==
X-CSE-MsgGUID: ACwWxOtqSTWu2KwwKjWsKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="99018993"
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="99018993"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 12:52:38 -0700
X-CSE-ConnectionGUID: kAd2YC/YTpuJ3XYEXBCfsA==
X-CSE-MsgGUID: hwBCE+DcQFOY9/rHIkA7xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="241164935"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 07 Jun 2026 12:52:36 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wWJXu-00000000I5u-3COD;
	Sun, 07 Jun 2026 19:52:34 +0000
Date: Mon, 08 Jun 2026 03:52:11 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:for-linus] BUILD SUCCESS
 fb402386af4cdce108ff991a796386de55439735
Message-ID: <202606080303.kY1TCnUj-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
branch HEAD: fb402386af4cdce108ff991a796386de55439735  Input: atkbd - skip deactivate for HONOR BCC-N's internal keyboard

elapsed time: 1254m

configs tested: 54
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    gcc-16.1.0
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    gcc-16.1.0
arm           allnoconfig    clang-23
arm          allyesconfig    gcc-16.1.0
arm64        allmodconfig    clang-23
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    clang-23
hexagon       allnoconfig    clang-23
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-20
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
m68k         allyesconfig    gcc-16.1.0
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips         allmodconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-16.1.0
openrisc      allnoconfig    gcc-16.1.0
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    gcc-16.1.0
parisc       allyesconfig    gcc-16.1.0
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    gcc-16.1.0
riscv        allmodconfig    clang-23
riscv         allnoconfig    gcc-16.1.0
riscv        allyesconfig    clang-23
s390         allmodconfig    clang-23
s390          allnoconfig    clang-23
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    gcc-16.1.0
sh           allyesconfig    gcc-16.1.0
sparc         allnoconfig    gcc-16.1.0
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-23
um            allnoconfig    clang-16
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-22
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
