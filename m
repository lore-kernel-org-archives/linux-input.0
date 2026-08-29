Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C51D175A88
	for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 02:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787972027; cv=none; b=rz8VN9J0fBJ+7Egza9iecRS8jpQXLPHPcP5nBaVKVEVI/J+ps+HoKS7QVoxSzoeZQ+r9pXlezUZdBP9UAgQ2v4+Z/jHRBHwRJZIb+iLSmV/s6OwZ9W9/PvlOOlXB7AAzYZst1fgNN8O3OE6oKanQwHIAloe49TFUwebO1O+WtJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787972027; c=relaxed/simple;
	bh=ltzODRH4kahSbHvfV7vG9DUVLKySSAZ3jPzwr1dLl6Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KsPvrNesX1a/i+zBK56O2TgVGKzUdxpUGaEHrK2nFvPPFkQ3mmd5UYDk7ELpmvHOfX8TFYjoEsJNEWQeRYn2ccm94P3VZjXyJFWudCSBIbq3GOn7z7JPA5+Kz5Gq/TdgOCkgQ/D5f3yE93Ml0+MCeT6mG+OV9R0Sq7CDmxEm/wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E1Y0vLqF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E1Y0vLqF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787972025; x=1819508025;
  h=date:from:to:cc:subject:message-id;
  bh=ltzODRH4kahSbHvfV7vG9DUVLKySSAZ3jPzwr1dLl6Q=;
  b=E1Y0vLqFSRNa/acsyaKeneks7eo3BgxRQlwvJDcK238WmUq1OssLbh3u
   ff27R7qBHMk9sDPEfA0h49HBKVAKmnWtawlzSluIbk2Gy7/d70wqUx0Mh
   SG+oHrGgy35GpU65w5uMjzMrqC1kzCmXqfsF1og77dgwr80XzZaaAsah0
   +Iqgec01elAx2sbkCY8AeifXyw93kk7Yhs6qVGZlvDSGwSSoHuZnjgzFj
   e9PCfI1oyly2XVEAiQ5EXSDRNHa4uCf0ZjdnrGUvcfWkrwBDV5f3+0Qgm
   nAB7IhZWHVRcMejexMkG0klRpEuf2MpPlR8dXTJI9frnOoS8dUHmQ80W3
   g==;
X-CSE-ConnectionGUID: QZxXCmNgRTelLiYvsc8E9Q==
X-CSE-MsgGUID: oLoksAdfQRurBgDaFmvBag==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="99989343"
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="99989343"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 19:53:45 -0700
X-CSE-ConnectionGUID: a/QIEjFxSaeSzIlplx2CPw==
X-CSE-MsgGUID: s0p1tL2pTuKtTA1vq2ofoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="272128419"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 28 Aug 2026 19:53:43 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x09CP-00000000CI0-1GlR;
	Sat, 29 Aug 2026 02:53:41 +0000
Date: Sat, 29 Aug 2026 10:53:35 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:for-linus] BUILD SUCCESS
 aefbda23eeba234c3ff0f135dc5be6e294bd25a6
Message-ID: <202608291021.PRMpf4JQ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
branch HEAD: aefbda23eeba234c3ff0f135dc5be6e294bd25a6  Input: atkbd - skip deactivate for Xiaomi Redmi Book Pro 16 2026

elapsed time: 739m

configs tested: 112
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha               allnoconfig    gcc-16.1.0
alpha              allyesconfig    gcc-16.1.0
alpha                 defconfig    gcc-16.1.0
arc                allmodconfig    clang-24
arc                allmodconfig    gcc-16.1.0
arc                 allnoconfig    gcc-16.1.0
arc                allyesconfig    clang-24
arc                allyesconfig    gcc-16.1.0
arc                   defconfig    gcc-16.1.0
arm                 allnoconfig    clang-17
arm                 allnoconfig    gcc-16.1.0
arm                allyesconfig    clang-24
arm                allyesconfig    gcc-16.1.0
arm                   defconfig    gcc-16.1.0
arm64              allmodconfig    clang-24
arm64               allnoconfig    gcc-16.1.0
arm64                 defconfig    gcc-16.1.0
csky               allmodconfig    gcc-16.1.0
csky                allnoconfig    gcc-16.1.0
csky                  defconfig    gcc-16.1.0
hexagon            allmodconfig    clang-24
hexagon            allmodconfig    gcc-16.1.0
hexagon             allnoconfig    clang-24
hexagon             allnoconfig    gcc-16.1.0
hexagon               defconfig    gcc-16.1.0
i386               allmodconfig    clang-22
i386                allnoconfig    gcc-14
i386                allnoconfig    gcc-16.1.0
i386               allyesconfig    clang-22
i386                  defconfig    gcc-16.1.0
loongarch          allmodconfig    clang-19
loongarch          allmodconfig    clang-24
loongarch           allnoconfig    clang-20
loongarch           allnoconfig    gcc-16.1.0
loongarch             defconfig    clang-24
m68k               allmodconfig    gcc-16.1.0
m68k                allnoconfig    gcc-16.1.0
m68k               allyesconfig    clang-24
m68k               allyesconfig    gcc-16.1.0
m68k                  defconfig    clang-24
microblaze          allnoconfig    gcc-16.1.0
microblaze         allyesconfig    gcc-16.1.0
microblaze            defconfig    clang-24
mips               allmodconfig    gcc-16.1.0
mips                allnoconfig    gcc-16.1.0
mips               allyesconfig    gcc-16.1.0
nios2              allmodconfig    clang-20
nios2              allmodconfig    gcc-11.5.0
nios2               allnoconfig    clang-24
nios2               allnoconfig    gcc-11.5.0
nios2                 defconfig    clang-24
openrisc           allmodconfig    clang-20
openrisc           allmodconfig    gcc-16.1.0
openrisc            allnoconfig    clang-24
openrisc            allnoconfig    gcc-16.1.0
openrisc              defconfig    gcc-16.1.0
parisc             allmodconfig    gcc-16.1.0
parisc              allnoconfig    clang-24
parisc              allnoconfig    gcc-16.1.0
parisc             allyesconfig    clang-17
parisc             allyesconfig    gcc-16.1.0
parisc                defconfig    gcc-16.1.0
parisc64              defconfig    clang-24
powerpc            allmodconfig    gcc-16.1.0
powerpc             allnoconfig    clang-24
powerpc             allnoconfig    gcc-16.1.0
riscv              allmodconfig    clang-24
riscv               allnoconfig    clang-24
riscv               allnoconfig    gcc-16.1.0
riscv              allyesconfig    clang-24
riscv                 defconfig    gcc-16.1.0
s390               allmodconfig    clang-17
s390               allmodconfig    clang-24
s390                allnoconfig    clang-24
s390               allyesconfig    gcc-16.1.0
s390                  defconfig    gcc-16.1.0
sh                 allmodconfig    gcc-16.1.0
sh                  allnoconfig    clang-24
sh                  allnoconfig    gcc-16.1.0
sh                 allyesconfig    clang-17
sh                 allyesconfig    gcc-16.1.0
sh                    defconfig    gcc-14
sparc               allnoconfig    clang-24
sparc               allnoconfig    gcc-16.1.0
sparc                 defconfig    gcc-16.1.0
sparc64            allmodconfig    clang-20
sparc64               defconfig    gcc-14
um                 allmodconfig    clang-17
um                  allnoconfig    clang-17
um                  allnoconfig    clang-24
um                 allyesconfig    gcc-14
um                 allyesconfig    gcc-16.1.0
um                    defconfig    gcc-14
um               i386_defconfig    gcc-14
um             x86_64_defconfig    gcc-14
x86_64             allmodconfig    clang-22
x86_64              allnoconfig    clang-22
x86_64              allnoconfig    clang-24
x86_64             allyesconfig    clang-22
x86_64                defconfig    gcc-14
x86_64                    kexec    clang-22
x86_64                 rhel-9.4    clang-22
x86_64             rhel-9.4-bpf    gcc-14
x86_64            rhel-9.4-func    clang-22
x86_64      rhel-9.4-kselftests    clang-22
x86_64           rhel-9.4-kunit    gcc-14
x86_64             rhel-9.4-ltp    gcc-14
x86_64            rhel-9.4-rust    clang-22
xtensa              allnoconfig    clang-24
xtensa              allnoconfig    gcc-16.1.0
xtensa             allyesconfig    clang-20
xtensa             allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
