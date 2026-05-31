Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD7030FF08
	for <linux-input@vger.kernel.org>; Sun, 31 May 2026 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780252980; cv=none; b=B4hDH/qq15cOr6v9SybKeekIwSRxClDP5dVge3uLkttcv296pSb3Tl4aW6/oH8/y31hHLOhCx/bbAcPn6csTgnMQPXvkLmcuEFo71/KjAtfInkUoCkzv6HmYBCqwvq7w1+5+LMe+Zsc5tMMgBTox1OhZwE+zZ4pWw/fs0TOWAgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780252980; c=relaxed/simple;
	bh=P+xyKAnyc3JBPKowlk2VrZp7BjrJoKJT4ClW5J0Af7U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EFbtkU3f2lSknkChmi25E9jn4v13cJLL3lG1H0SRHRP5BlTcSaPE3Qs3O0OQeKLxv++eJsW0N+Dce9uFMPH9YIdZCapeLHKUbQatr7pD00QtvYWAhaLYEjNil7CaNrTLyKLqXdEImrfXd5h94PIBTqzrYkG4zfaKSx5Vc+UcbdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FhcX7Mto; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FhcX7Mto"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780252978; x=1811788978;
  h=date:from:to:cc:subject:message-id;
  bh=P+xyKAnyc3JBPKowlk2VrZp7BjrJoKJT4ClW5J0Af7U=;
  b=FhcX7MtonkLmJh3pUjcA+H0NJFdHB2+FTwTbzed3qyfniCGeiY/c0J2G
   hLb5qT+eEw9EsuTdg4V0os/dA3yJ+gIMVaw3TSF1nbHVKIK75udL+3UyF
   W2NSAIiTUJk6TXS2p42BNu0FXOI8TJsycNcy/HREgthLF9qNn6mo6nblS
   V7o9L6yTNjhTiB3gF0bya21DjZJ3oRdn3zgbF3g7xyl0B4ssvIjc36eMv
   gz4MGsyiRtt5ia1rdxGpfXyocMfNA2F8OaWfLyIuMY4jGKKAFFmqP8RgB
   Lr8ZUlX55Y2YIETbzJDLFJxvMDGmft2y6+7frwlssr7puyOO8KoIJE7Xy
   w==;
X-CSE-ConnectionGUID: ILupEChXQNuxN5IQyZVEAA==
X-CSE-MsgGUID: yPWtzRVsRPOJMUiBV7fZag==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="106470800"
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="106470800"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 11:42:57 -0700
X-CSE-ConnectionGUID: DVz+7RicRd2+AUxKUXGa4w==
X-CSE-MsgGUID: ryx1aphSR4GlY3rL4uAcAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="267242020"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 31 May 2026 11:42:56 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wTl7e-000000009eg-0zGE;
	Sun, 31 May 2026 18:42:54 +0000
Date: Mon, 01 Jun 2026 02:42:46 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:next] BUILD SUCCESS
 332fbc03e1a8cb4c0ce6891cae2c286ddf031aca
Message-ID: <202606010235.PLPZFYNl-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
branch HEAD: 332fbc03e1a8cb4c0ce6891cae2c286ddf031aca  Input: iqs5xx - drop unused i2c driver_data

elapsed time: 800m

configs tested: 252
configs skipped: 43

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260531    gcc-11.5.0
arc                   randconfig-001-20260531    gcc-8.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260531    gcc-11.5.0
arc                   randconfig-002-20260531    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                          collie_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                            hisi_defconfig    gcc-15.2.0
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260531    gcc-11.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260531    gcc-11.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260531    gcc-11.5.0
arm                   randconfig-003-20260531    gcc-8.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260531    gcc-11.5.0
arm                   randconfig-004-20260531    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260531    clang-23
arm64                 randconfig-001-20260531    gcc-13.4.0
arm64                 randconfig-002-20260531    clang-23
arm64                 randconfig-002-20260531    gcc-13.4.0
arm64                 randconfig-003-20260531    clang-23
arm64                 randconfig-003-20260531    gcc-13.4.0
arm64                 randconfig-004-20260531    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260531    clang-23
csky                  randconfig-001-20260531    gcc-13.4.0
csky                  randconfig-002-20260531    clang-23
csky                  randconfig-002-20260531    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260531    clang-23
hexagon               randconfig-001-20260601    gcc-8.5.0
hexagon               randconfig-002-20260531    clang-23
hexagon               randconfig-002-20260601    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260531    clang-20
i386        buildonly-randconfig-002-20260531    clang-20
i386        buildonly-randconfig-003-20260531    clang-20
i386        buildonly-randconfig-003-20260531    gcc-13
i386        buildonly-randconfig-003-20260531    gcc-14
i386        buildonly-randconfig-004-20260531    clang-20
i386        buildonly-randconfig-005-20260531    clang-20
i386        buildonly-randconfig-005-20260531    gcc-14
i386        buildonly-randconfig-006-20260531    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260531    clang-20
i386                  randconfig-001-20260531    gcc-13
i386                  randconfig-002-20260531    clang-20
i386                  randconfig-002-20260531    gcc-13
i386                  randconfig-003-20260531    clang-20
i386                  randconfig-003-20260531    gcc-13
i386                  randconfig-004-20260531    gcc-13
i386                  randconfig-005-20260531    clang-20
i386                  randconfig-005-20260531    gcc-13
i386                  randconfig-006-20260531    gcc-13
i386                  randconfig-006-20260531    gcc-14
i386                  randconfig-007-20260531    clang-20
i386                  randconfig-007-20260531    gcc-13
i386                  randconfig-011-20260531    gcc-14
i386                  randconfig-012-20260531    gcc-14
i386                  randconfig-013-20260531    gcc-14
i386                  randconfig-014-20260531    clang-20
i386                  randconfig-014-20260531    gcc-14
i386                  randconfig-015-20260531    gcc-14
i386                  randconfig-016-20260531    gcc-14
i386                  randconfig-017-20260531    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260531    clang-23
loongarch             randconfig-001-20260601    gcc-8.5.0
loongarch             randconfig-002-20260531    clang-23
loongarch             randconfig-002-20260601    gcc-8.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                       alldefconfig    gcc-15.2.0
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
nios2                               defconfig    gcc-15.2.0
nios2                 randconfig-001-20260531    clang-23
nios2                 randconfig-001-20260601    gcc-8.5.0
nios2                 randconfig-002-20260531    clang-23
nios2                 randconfig-002-20260601    gcc-8.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                       virt_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    clang-23
parisc                randconfig-001-20260531    clang-23
parisc                randconfig-001-20260531    gcc-8.5.0
parisc                         randconfig-002    clang-23
parisc                randconfig-002-20260531    clang-23
parisc                randconfig-002-20260531    gcc-12.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                        randconfig-001    clang-23
powerpc               randconfig-001-20260531    clang-17
powerpc               randconfig-001-20260531    clang-23
powerpc                        randconfig-002    clang-23
powerpc               randconfig-002-20260531    clang-23
powerpc                     redwood_defconfig    clang-23
powerpc                     tqm8548_defconfig    clang-23
powerpc64                      randconfig-001    clang-23
powerpc64             randconfig-001-20260531    clang-23
powerpc64                      randconfig-002    clang-23
powerpc64             randconfig-002-20260531    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260531    gcc-8.5.0
riscv                 randconfig-002-20260531    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260531    gcc-8.5.0
s390                  randconfig-002-20260531    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260531    gcc-8.5.0
sh                    randconfig-002-20260531    gcc-8.5.0
sh                           sh2007_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260531    gcc-8.5.0
sparc                 randconfig-002-20260531    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260531    gcc-8.5.0
sparc64               randconfig-002-20260531    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260531    gcc-8.5.0
um                    randconfig-002-20260531    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260531    clang-20
x86_64      buildonly-randconfig-001-20260531    gcc-13
x86_64      buildonly-randconfig-002-20260531    clang-20
x86_64      buildonly-randconfig-003-20260531    clang-20
x86_64      buildonly-randconfig-004-20260531    clang-20
x86_64      buildonly-randconfig-005-20260531    clang-20
x86_64      buildonly-randconfig-006-20260531    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260531    gcc-14
x86_64                randconfig-002-20260531    gcc-14
x86_64                randconfig-003-20260531    gcc-14
x86_64                randconfig-004-20260531    gcc-14
x86_64                randconfig-005-20260531    gcc-14
x86_64                randconfig-006-20260531    gcc-14
x86_64                randconfig-011-20260531    gcc-14
x86_64                randconfig-012-20260531    gcc-14
x86_64                randconfig-013-20260531    gcc-14
x86_64                randconfig-014-20260531    gcc-14
x86_64                randconfig-015-20260531    gcc-14
x86_64                randconfig-016-20260531    gcc-14
x86_64                randconfig-071-20260531    clang-20
x86_64                randconfig-072-20260531    clang-20
x86_64                randconfig-072-20260531    gcc-14
x86_64                randconfig-073-20260531    clang-20
x86_64                randconfig-074-20260531    clang-20
x86_64                randconfig-075-20260531    clang-20
x86_64                randconfig-075-20260531    gcc-14
x86_64                randconfig-076-20260531    clang-20
x86_64                randconfig-076-20260531    gcc-13
x86_64                               rhel-9.4    clang-20
x86_64                               rhel-9.4    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                          rhel-9.4-func    gcc-14
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                    rhel-9.4-kselftests    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260531    gcc-8.5.0
xtensa                randconfig-002-20260531    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
