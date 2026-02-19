Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C10528DC4
	for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771507115; cv=none; b=LCCj7LftAoNbte0M37dtUm9MqbSiJoCuAaeMI6vVrCG0mbD4PYgJg2TheQatveucNY5lq9Vjcge/c/u0ZoGjSkoiMTgKTIOvN6hFJPy2oNc+b3YR+MDvGRAK+8S2urtDZOKlGWGrqknpzGPgL6XdyQwC/wYEaYNPGVaVjKoZqEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771507115; c=relaxed/simple;
	bh=F6j4eL5RooVSUik2DfS7YI5Skh3IC4KFn8wSqxdSz4Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QN70z0N7N0yVcyigDW8XWaV89juc+P+e0KPDvv0QUdg+1b8mzIaEqGPB3qVWqPSaccjqYOQzjOKz4gu9amqPNBF4NNeZc04SigngX8I89uqGT0zZRKXt09h4FZi3pXwnsmB78FVZAdw8gKsEgyv+X9RXp0sjBb6QQrt83AA241c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WggI1w38; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WggI1w38"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771507113; x=1803043113;
  h=date:from:to:cc:subject:message-id;
  bh=F6j4eL5RooVSUik2DfS7YI5Skh3IC4KFn8wSqxdSz4Q=;
  b=WggI1w38BylgsdaGAtVszQm5Lu+788hJGYBI0G1ogtGZyONOYeInPnyl
   ftj/TcDIe/rAyBPMc19mVR9EPUGI9Q4+6NO679HvbujPMGJZqX1FtDMu4
   QCuTl2A17E1wMSOQ6U2TOPiUoEVz5pMhrK4ZB0rKGs5X33C0cS7n1x6ps
   3uERihWcE/4Pdul+WmZkn14+6nQZqMDkYeS9pW7O5tlC8C7JJ5Yc9EyKx
   dw5UHr2z8O1RKhUcWSTDGzluYILlafsQlU/5VkHPcquFeBCg0/K9C/Hxc
   g99OQRd/CIuky9Oi6nDYc0j2usNZLbTl4sJMEtaDNzGSYeLZ3uhEWqMu1
   g==;
X-CSE-ConnectionGUID: bsil9akfTVSYxYju3Iw1Jg==
X-CSE-MsgGUID: TKZQEnJnR5iN/8HVywhBYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83310612"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="83310612"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 05:18:32 -0800
X-CSE-ConnectionGUID: PkJz6vqBTP+bCZFvBbL/gA==
X-CSE-MsgGUID: nlH6x4FMR92FtLhQBj8VaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="213181874"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 19 Feb 2026 05:18:32 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vt3vK-000000013DA-0u76;
	Thu, 19 Feb 2026 13:18:30 +0000
Date: Thu, 19 Feb 2026 21:18:15 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:for-linus] BUILD SUCCESS
 fc1e8a6f129d87c64ac8e58b50d9dfa66217cfda
Message-ID: <202602192107.SH7QeZNq-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
branch HEAD: fc1e8a6f129d87c64ac8e58b50d9dfa66217cfda  Input: bcm5974 - recover from failed mode switch

elapsed time: 842m

configs tested: 233
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                          axs101_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                 nsimosci_hs_smp_defconfig    clang-23
arc                   randconfig-001-20260219    clang-23
arc                   randconfig-002-20260219    clang-23
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                        clps711x_defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                           h3600_defconfig    clang-18
arm                       imx_v4_v5_defconfig    clang-18
arm                            mps2_defconfig    clang-23
arm                        multi_v5_defconfig    gcc-15.2.0
arm                         mv78xx0_defconfig    clang-18
arm                           omap1_defconfig    clang-23
arm                          pxa3xx_defconfig    gcc-15.2.0
arm                   randconfig-001-20260219    clang-23
arm                   randconfig-002-20260219    clang-23
arm                   randconfig-003-20260219    clang-23
arm                   randconfig-004-20260219    clang-23
arm                         s5pv210_defconfig    gcc-15.2.0
arm                         vf610m4_defconfig    clang-23
arm                    vt8500_v6_v7_defconfig    gcc-15.2.0
arm64                            alldefconfig    clang-23
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260219    gcc-8.5.0
arm64                 randconfig-002-20260219    gcc-8.5.0
arm64                 randconfig-003-20260219    gcc-8.5.0
arm64                 randconfig-004-20260219    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260219    gcc-8.5.0
csky                  randconfig-002-20260219    gcc-8.5.0
hexagon                          alldefconfig    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260219    clang-17
hexagon               randconfig-002-20260219    clang-17
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260219    gcc-14
i386        buildonly-randconfig-002-20260219    gcc-14
i386        buildonly-randconfig-003-20260219    gcc-14
i386        buildonly-randconfig-004-20260219    gcc-14
i386        buildonly-randconfig-005-20260219    gcc-14
i386        buildonly-randconfig-006-20260219    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260219    gcc-14
i386                  randconfig-002-20260219    gcc-14
i386                  randconfig-003-20260219    gcc-14
i386                  randconfig-004-20260219    gcc-14
i386                  randconfig-005-20260219    gcc-14
i386                  randconfig-006-20260219    gcc-14
i386                  randconfig-007-20260219    gcc-14
i386                  randconfig-011-20260219    clang-20
i386                  randconfig-012-20260219    clang-20
i386                  randconfig-013-20260219    clang-20
i386                  randconfig-014-20260219    clang-20
i386                  randconfig-015-20260219    clang-20
i386                  randconfig-016-20260219    clang-20
i386                  randconfig-017-20260219    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260219    clang-17
loongarch             randconfig-002-20260219    clang-17
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                          amiga_defconfig    clang-23
m68k                                defconfig    clang-19
m68k                        m5272c3_defconfig    gcc-15.2.0
m68k                       m5475evb_defconfig    gcc-15.2.0
m68k                          multi_defconfig    clang-23
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                         bigsur_defconfig    gcc-15.2.0
mips                      fuloong2e_defconfig    gcc-15.2.0
mips                           ip22_defconfig    clang-23
mips                          rb532_defconfig    clang-18
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260219    clang-17
nios2                 randconfig-002-20260219    clang-17
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260219    clang-23
parisc                randconfig-002-20260219    clang-23
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      cm5200_defconfig    clang-23
powerpc                   currituck_defconfig    gcc-15.2.0
powerpc                     ep8248e_defconfig    clang-23
powerpc                      ep88xc_defconfig    clang-18
powerpc                        fsp2_defconfig    gcc-15.2.0
powerpc                  iss476-smp_defconfig    clang-18
powerpc                      katmai_defconfig    gcc-15.2.0
powerpc                    mvme5100_defconfig    gcc-15.2.0
powerpc                      pasemi_defconfig    clang-23
powerpc                      ppc44x_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260219    clang-23
powerpc               randconfig-002-20260219    clang-23
powerpc64             randconfig-001-20260219    clang-23
powerpc64             randconfig-002-20260219    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260219    clang-17
riscv                 randconfig-002-20260219    clang-17
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260219    clang-17
s390                  randconfig-002-20260219    clang-17
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                         apsh4a3a_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                 kfr2r09-romimage_defconfig    clang-23
sh                          lboxre2_defconfig    gcc-15.2.0
sh                            migor_defconfig    gcc-15.2.0
sh                          r7785rp_defconfig    gcc-15.2.0
sh                    randconfig-001-20260219    clang-17
sh                    randconfig-002-20260219    clang-17
sh                          rsk7264_defconfig    gcc-15.2.0
sh                          rsk7269_defconfig    gcc-15.2.0
sh                           se7343_defconfig    gcc-15.2.0
sh                           se7705_defconfig    clang-18
sh                            titan_defconfig    clang-18
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260219    gcc-8.5.0
sparc                 randconfig-002-20260219    gcc-8.5.0
sparc64                          alldefconfig    clang-23
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260219    gcc-8.5.0
sparc64               randconfig-002-20260219    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260219    gcc-8.5.0
um                    randconfig-002-20260219    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260219    gcc-14
x86_64      buildonly-randconfig-002-20260219    gcc-14
x86_64      buildonly-randconfig-003-20260219    gcc-14
x86_64      buildonly-randconfig-004-20260219    gcc-14
x86_64      buildonly-randconfig-005-20260219    gcc-14
x86_64      buildonly-randconfig-006-20260219    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260219    clang-20
x86_64                randconfig-002-20260219    clang-20
x86_64                randconfig-003-20260219    clang-20
x86_64                randconfig-004-20260219    clang-20
x86_64                randconfig-005-20260219    clang-20
x86_64                randconfig-006-20260219    clang-20
x86_64                randconfig-011-20260219    gcc-14
x86_64                randconfig-012-20260219    gcc-14
x86_64                randconfig-013-20260219    gcc-14
x86_64                randconfig-014-20260219    gcc-14
x86_64                randconfig-015-20260219    gcc-14
x86_64                randconfig-016-20260219    gcc-14
x86_64                randconfig-071-20260219    clang-20
x86_64                randconfig-071-20260219    gcc-14
x86_64                randconfig-072-20260219    gcc-14
x86_64                randconfig-073-20260219    gcc-14
x86_64                randconfig-074-20260219    gcc-14
x86_64                randconfig-075-20260219    clang-20
x86_64                randconfig-075-20260219    gcc-14
x86_64                randconfig-076-20260219    clang-20
x86_64                randconfig-076-20260219    gcc-14
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
xtensa                       common_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260219    gcc-8.5.0
xtensa                randconfig-002-20260219    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
