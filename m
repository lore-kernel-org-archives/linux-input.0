Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEDE3B0AE6
	for <linux-input@vger.kernel.org>; Mon, 27 Apr 2026 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283859; cv=none; b=CtgW4JaqIWGBH9RQqt4P0K0V7Cc3eYm2cYHMI+UT7ldPb3E+25dNq4lK8/2tPygXPQHjZR5lIBkhgk29q3jsuxMzZkOlO+KPB504ozhqSzf59Kf/jwI46w9zrKrOV/roy9BEMWrW/Aw3nxvGiiiebZNNzNauXReFn7jB8eDykOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283859; c=relaxed/simple;
	bh=wL7CELzpxhag55gqWVHhyI9GDqJHQC/DtAKzvIxnv/k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=V33WTcmm04xaXG0R+Ed+dzRB8zh/dNbxX1YUUEN1HsK4/QpUY71UxuADIpdLmTlGVYIIRgR53iNHRg76P1FzeIvyUP7cXHP+bdH/uDCzY7SCv5n8dcPXCyD5z4v1AixHCoQwUXwyld1gS+894Q0IZweozNB/jJGUnakz4KdnOhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mbLVtfss; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mbLVtfss"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777283858; x=1808819858;
  h=date:from:to:cc:subject:message-id;
  bh=wL7CELzpxhag55gqWVHhyI9GDqJHQC/DtAKzvIxnv/k=;
  b=mbLVtfssvvvzA2nUjMseVeixtYq1DqtWq94RS92VqXYg+GKBmpxFVB5I
   Aau1rF0G/sMrr/rwdwDS84RUDrg60VCtm9p4NIlhuGCrnBTfFBOVlB1Jo
   3elGnJxzp6C1u6+ev2DQIfwuXMlM82eATpgJYvEHddH2fbQE6WGudNJE2
   DbZ9vm5KTY4CPXyEVQmspuq/4qSvBsjzuIvrCJWYBiweaSIlf4HPTov2e
   9A2ynQ+OXcRHtLBTPWCaZ72rbeIRObY9RKFWK7KKmeOHlFDBobvsYAJJX
   PaZzauXbs++3Rl6Z9uinLNPzZHrgrC/JJdoYevfGA+wmj7pF8sF8jc7Nh
   A==;
X-CSE-ConnectionGUID: cSwI4mwQT8aUJOZtlAHvsA==
X-CSE-MsgGUID: ozZEbh2sQROPrDVsmyZkBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="78084650"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="78084650"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 02:57:38 -0700
X-CSE-ConnectionGUID: FYqs0G9aQz6etD1kIjF3jA==
X-CSE-MsgGUID: pmUAgfftTzW+hKuPzgRv4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="227064598"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 27 Apr 2026 02:57:36 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wHIic-000000008gH-1hns;
	Mon, 27 Apr 2026 09:57:34 +0000
Date: Mon, 27 Apr 2026 17:56:57 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:next] BUILD SUCCESS
 26b760d0f8148e4ee73936577b8b3be51dbb64d7
Message-ID: <202604271747.0jdgLGNs-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
branch HEAD: 26b760d0f8148e4ee73936577b8b3be51dbb64d7  Input: stmfts - fix formatting issues

elapsed time: 736m

configs tested: 55
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.2.0
alpha        allyesconfig    gcc-15.2.0
arc          allmodconfig    gcc-15.2.0
arc           allnoconfig    gcc-15.2.0
arc          allyesconfig    gcc-15.2.0
arm           allnoconfig    clang-23
arm          allyesconfig    gcc-15.2.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.2.0
csky         allmodconfig    gcc-15.2.0
csky          allnoconfig    gcc-15.2.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-23
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-23
m68k         allmodconfig    gcc-15.2.0
m68k          allnoconfig    gcc-15.2.0
m68k         allyesconfig    gcc-15.2.0
microblaze    allnoconfig    gcc-15.2.0
microblaze   allyesconfig    gcc-15.2.0
mips         allmodconfig    gcc-15.2.0
mips          allnoconfig    gcc-15.2.0
mips         allyesconfig    gcc-15.2.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.2.0
openrisc      allnoconfig    gcc-15.2.0
parisc       allmodconfig    gcc-15.2.0
parisc        allnoconfig    gcc-15.2.0
parisc       allyesconfig    gcc-15.2.0
powerpc      allmodconfig    gcc-15.2.0
powerpc       allnoconfig    gcc-15.2.0
riscv        allmodconfig    clang-23
riscv         allnoconfig    gcc-15.2.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390          allnoconfig    clang-23
s390         allyesconfig    gcc-15.2.0
sh           allmodconfig    gcc-15.2.0
sh            allnoconfig    gcc-15.2.0
sh           allyesconfig    gcc-15.2.0
sparc         allnoconfig    gcc-15.2.0
sparc64      allmodconfig    clang-23
um           allmodconfig    clang-19
um            allnoconfig    clang-23
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.2.0
xtensa       allyesconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
