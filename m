Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0943321420
	for <linux-input@vger.kernel.org>; Thu,  2 Apr 2026 06:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775112522; cv=none; b=tgZrfPvQDwUqzL1RVzBqngHd5CbBMNZdbhr9EWW6u0HupCRIKMtIColoT66tpvPtfQxbGlSiOxHu0mze/0jr7SkQcd9nMH0TVAVvKR9y6UBMAPeeuTKhAkFcjw3Irbf/XJy/xmvOPL7LAp1QqTfZUDlszyVhGNHj4d78o+COBpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775112522; c=relaxed/simple;
	bh=q0BQkU/giQCY4t/6uCK68Izi6DXC5TyrdR7ZGFidpNg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WWBhpbPmulPM3/ofLA1SThTcP5ich9ONZ+xl7ujQAA6HsPe1MaQjb6JBiCFDriEpY7tQTo3HVHmu6938+ILo4E2ZG/DOQ8MrIsd9zQASaG46iSc+DFNGdBOlHKYNenb9oDydi4wyNdlbQWPWCx1qXlqyuDKkn40PK1B+fEmo3NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kl9WHofI; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kl9WHofI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775112522; x=1806648522;
  h=date:from:to:cc:subject:message-id;
  bh=q0BQkU/giQCY4t/6uCK68Izi6DXC5TyrdR7ZGFidpNg=;
  b=kl9WHofIZUHirFCjFZaEPbRUBYoyyCFcR8SvcXX1sMNSsIKNFyrcHA2w
   HKbzGdqpGLn9xfLmbYMIYKiUx0OqhD8dUJWi1zg/tbHXp117G8uiYnfnY
   tPgWrR8RqGc4hjH2AiGk1QwjhnBT2YsWN8iTbA2Uk4yyGcnvCZm71YTSf
   w057x6Vyq0tfbRizJ0k50IYyR7WHIM34JGBEbcTDuqBfykwseUmCdZH6L
   iJ68hE+DbVO5Xy2jkINfBeYaWEwEYVwHub8OFy6JcajqBIO+Lfu8xPQDI
   QFZf0pw3AFyJO+ENPQ/ZoNaGpM89IpcfP99Lg7BUFoH+8z4LSiR+jhCkr
   Q==;
X-CSE-ConnectionGUID: 2b2FHKPYSPWZbWN2NC47Ng==
X-CSE-MsgGUID: sIgA+5n7RLWTHbi+2B8/Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="63715202"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="63715202"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 23:48:41 -0700
X-CSE-ConnectionGUID: c3A7TQc2ScW9vxq2g+YXjA==
X-CSE-MsgGUID: DAscUoatRIiv48DkL2AJjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="226059509"
Received: from lkp-server02.sh.intel.com (HELO cedfeeed6c12) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 01 Apr 2026 23:48:39 -0700
Received: from kbuild by cedfeeed6c12 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w8Bqp-000000000GP-1KVS;
	Thu, 02 Apr 2026 06:48:27 +0000
Date: Thu, 02 Apr 2026 10:01:50 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:next] BUILD SUCCESS
 4decd8f4ae06a6d82079186b6ad3fe51d4654a1d
Message-ID: <202604021044.B7ojJ7uY-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
branch HEAD: 4decd8f4ae06a6d82079186b6ad3fe51d4654a1d  Input: synaptics_usb - refactor endpoint lookup

elapsed time: 1533m

configs tested: 157
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                   randconfig-001-20260401    clang-23
arc                   randconfig-002-20260401    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                   randconfig-001-20260401    clang-23
arm                   randconfig-002-20260401    clang-23
arm                   randconfig-003-20260401    clang-23
arm                   randconfig-004-20260401    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260401    gcc-15.2.0
arm64                 randconfig-002-20260401    gcc-15.2.0
arm64                 randconfig-003-20260401    gcc-15.2.0
arm64                 randconfig-004-20260401    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260401    gcc-15.2.0
csky                  randconfig-002-20260401    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon               randconfig-001-20260401    gcc-15.2.0
hexagon               randconfig-002-20260401    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260401    gcc-14
i386        buildonly-randconfig-002-20260401    gcc-14
i386        buildonly-randconfig-003-20260401    gcc-14
i386        buildonly-randconfig-004-20260401    gcc-14
i386        buildonly-randconfig-005-20260401    gcc-14
i386        buildonly-randconfig-006-20260401    gcc-14
i386                  randconfig-001-20260401    gcc-14
i386                  randconfig-002-20260401    gcc-14
i386                  randconfig-003-20260401    gcc-14
i386                  randconfig-004-20260401    gcc-14
i386                  randconfig-005-20260401    gcc-14
i386                  randconfig-006-20260401    gcc-14
i386                  randconfig-007-20260401    gcc-14
i386                  randconfig-011-20260401    clang-20
i386                  randconfig-012-20260401    clang-20
i386                  randconfig-013-20260401    clang-20
i386                  randconfig-014-20260401    clang-20
i386                  randconfig-015-20260401    clang-20
i386                  randconfig-016-20260401    clang-20
i386                  randconfig-017-20260401    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260401    gcc-15.2.0
loongarch             randconfig-002-20260401    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260401    gcc-15.2.0
nios2                 randconfig-002-20260401    gcc-15.2.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260401    gcc-8.5.0
parisc                randconfig-002-20260401    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                           allnoconfig    clang-23
powerpc                       holly_defconfig    clang-23
powerpc               randconfig-001-20260401    gcc-8.5.0
powerpc               randconfig-002-20260401    gcc-8.5.0
powerpc64             randconfig-001-20260401    gcc-8.5.0
powerpc64             randconfig-002-20260401    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260401    gcc-9.5.0
riscv                 randconfig-002-20260401    gcc-9.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260401    gcc-9.5.0
s390                  randconfig-002-20260401    gcc-9.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260401    gcc-9.5.0
sh                    randconfig-002-20260401    gcc-9.5.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260401    clang-16
sparc                 randconfig-002-20260401    clang-16
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260401    clang-16
sparc64               randconfig-002-20260401    clang-16
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260401    clang-16
um                    randconfig-002-20260401    clang-16
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260401    gcc-12
x86_64      buildonly-randconfig-002-20260401    gcc-12
x86_64      buildonly-randconfig-003-20260401    gcc-12
x86_64      buildonly-randconfig-004-20260401    gcc-12
x86_64      buildonly-randconfig-005-20260401    gcc-12
x86_64      buildonly-randconfig-006-20260401    gcc-12
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260401    clang-20
x86_64                randconfig-002-20260401    clang-20
x86_64                randconfig-003-20260401    clang-20
x86_64                randconfig-004-20260401    clang-20
x86_64                randconfig-005-20260401    clang-20
x86_64                randconfig-006-20260401    clang-20
x86_64                randconfig-011-20260401    gcc-14
x86_64                randconfig-012-20260401    gcc-14
x86_64                randconfig-013-20260401    gcc-14
x86_64                randconfig-014-20260401    gcc-14
x86_64                randconfig-015-20260401    gcc-14
x86_64                randconfig-016-20260401    gcc-14
x86_64                randconfig-071-20260401    gcc-14
x86_64                randconfig-072-20260401    gcc-14
x86_64                randconfig-073-20260401    gcc-14
x86_64                randconfig-074-20260401    gcc-14
x86_64                randconfig-075-20260401    gcc-14
x86_64                randconfig-076-20260401    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260401    clang-16
xtensa                randconfig-002-20260401    clang-16

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
