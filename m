Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9984A39B962
	for <linux-input@vger.kernel.org>; Mon, 27 Apr 2026 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777313832; cv=none; b=oHJiPJOqks8g0AbnCbNu9D2FN55eZ/SegxC3d1+nS8mzoPVZaW1vwWTfZKF7yBq3vgPUqfieQ05xKVLSZZ7960I7GS+iDClEINuOCdg1pRNrckgQYGbKQcUFymMoD4DL6bKliCTTDT44E5I2QbYdXsiyBlhapmYH1RcJ8L++eeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777313832; c=relaxed/simple;
	bh=3i9ntAefwlzT/+h2qlgTILFeqMERzAfzz3KmwT4R6Tc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=W3agQQtlGOwNjMZayJXj9CAVhMvUTUudUi/FngHgbI7FZhWy6zRBqN7ThZL2YpE1XIZVBaz+BwPGS3Im651Z6sIkEwLU8oyokcgZyrxA0TyG0k9Mk4TehNGI/PUc6NQumMPWgoxdLEE8l2m0Enf53vzUKCZ/CTRorBF36i+yzi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LvAUTVfJ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LvAUTVfJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777313830; x=1808849830;
  h=date:from:to:cc:subject:message-id;
  bh=3i9ntAefwlzT/+h2qlgTILFeqMERzAfzz3KmwT4R6Tc=;
  b=LvAUTVfJwfXIzv2zLAhqt1eijo48rFCbjiTnCokgmlrBnNotUIjdJWrz
   O85leZ7BR4spZAke7PnidhBzQEM3U5E8uuXKW8+5UI2LQrlmqTN3VuI9V
   U8R5jKy46ZWTh2hUGScI6FamjN0+KiU4Mo1RdJ0Jsmjj8NEGum9upZiE1
   7VW2Yv0toPjAwjArWa7ZXrtcVyhF96bh/0BUjWoATPCJcK7gPjG5ZtmZJ
   H6YUbEGmOkm5nN49/GuTNc9PRSbPONV22+cNbj5nrnGSVeQAZJkZ3D4ke
   cJ8FjAIjjFDCP4/b3flHqjz35KQo3XapGlKzdUhhjJEW56v5tIWfBspoz
   A==;
X-CSE-ConnectionGUID: VVq8oOMNRrKDEKzZGpzYyw==
X-CSE-MsgGUID: cqIQuyY/RqimY2jK6xJOpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="88813208"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="88813208"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 11:17:10 -0700
X-CSE-ConnectionGUID: 9mIlLnfERiKwdEPw58HXrA==
X-CSE-MsgGUID: UuK+6syzSdiYoHCmSx0PbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="229372406"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 27 Apr 2026 11:17:08 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wHQW2-00000000961-1gwD;
	Mon, 27 Apr 2026 18:17:06 +0000
Date: Tue, 28 Apr 2026 02:16:55 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:for-linus] BUILD SUCCESS
 6cdc46b38cf146ce81d4831b6472dbf7731849a2
Message-ID: <202604280245.8MMNdRdF-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
branch HEAD: 6cdc46b38cf146ce81d4831b6472dbf7731849a2  Input: xpad - fix out-of-bounds access for Share button

elapsed time: 812m

configs tested: 188
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260428    gcc-9.5.0
arc                   randconfig-002-20260428    gcc-14.3.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260428    gcc-7.5.0
arm                   randconfig-002-20260428    clang-23
arm                   randconfig-003-20260428    gcc-7.5.0
arm                   randconfig-004-20260428    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                          randconfig-001    gcc-8.5.0
arm64                 randconfig-001-20260427    clang-23
arm64                          randconfig-002    gcc-14.3.0
arm64                 randconfig-002-20260427    clang-23
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260427    clang-23
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260427    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                           randconfig-001    gcc-10.5.0
csky                  randconfig-001-20260427    gcc-12.5.0
csky                           randconfig-002    gcc-10.5.0
csky                  randconfig-002-20260427    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260427    clang-23
hexagon               randconfig-002-20260427    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260428    gcc-14
i386        buildonly-randconfig-002-20260428    clang-23
i386        buildonly-randconfig-003-20260428    gcc-14
i386        buildonly-randconfig-004-20260428    gcc-14
i386        buildonly-randconfig-005-20260428    gcc-14
i386        buildonly-randconfig-006-20260428    gcc-12
i386                           randconfig-001    clang-23
i386                  randconfig-001-20260427    gcc-14
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260427    clang-23
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260427    gcc-13
i386                           randconfig-004    clang-23
i386                  randconfig-004-20260427    clang-23
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260427    clang-23
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260427    gcc-14
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260427    clang-23
i386                  randconfig-011-20260427    gcc-14
i386                  randconfig-012-20260427    gcc-14
i386                  randconfig-013-20260427    clang-23
i386                  randconfig-014-20260427    gcc-14
i386                  randconfig-015-20260427    clang-23
i386                  randconfig-016-20260427    gcc-14
i386                  randconfig-017-20260427    clang-23
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260427    clang-23
loongarch             randconfig-002-20260427    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260427    gcc-6.5.0
nios2                 randconfig-002-20260427    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-13.4.0
parisc                randconfig-001-20260427    gcc-5.5.0
parisc                         randconfig-002    gcc-6.5.0
parisc                randconfig-002-20260427    gcc-5.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                        randconfig-001    gcc-13.4.0
powerpc               randconfig-001-20260427    clang-23
powerpc                        randconfig-002    gcc-10.5.0
powerpc               randconfig-002-20260427    clang-23
powerpc64                      randconfig-001    clang-23
powerpc64             randconfig-001-20260427    clang-23
powerpc64                      randconfig-002    clang-23
powerpc64             randconfig-002-20260427    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260427    gcc-12.5.0
riscv                 randconfig-002-20260427    gcc-14.3.0
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260427    clang-23
s390                  randconfig-002-20260427    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260427    gcc-7.5.0
sh                    randconfig-002-20260427    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-6.5.0
sparc                 randconfig-001-20260427    gcc-6.5.0
sparc                          randconfig-002    gcc-15.2.0
sparc                 randconfig-002-20260427    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                        randconfig-001    gcc-8.5.0
sparc64               randconfig-001-20260427    gcc-7.5.0
sparc64                        randconfig-002    clang-23
sparc64               randconfig-002-20260427    gcc-13.4.0
um                               allmodconfig    clang-19
um                               allmodconfig    clang-23
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                             randconfig-001    clang-23
um                    randconfig-001-20260427    gcc-14
um                             randconfig-002    clang-23
um                    randconfig-002-20260427    gcc-14
x86_64                           allmodconfig    clang-23
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-23
x86_64               buildonly-randconfig-001    gcc-12
x86_64      buildonly-randconfig-001-20260427    clang-23
x86_64               buildonly-randconfig-002    clang-23
x86_64      buildonly-randconfig-002-20260427    clang-23
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260427    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260427    clang-23
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260427    clang-23
x86_64               buildonly-randconfig-006    clang-23
x86_64      buildonly-randconfig-006-20260427    clang-23
x86_64                randconfig-001-20260427    clang-23
x86_64                randconfig-002-20260427    clang-23
x86_64                randconfig-003-20260427    gcc-14
x86_64                randconfig-004-20260427    clang-23
x86_64                randconfig-005-20260427    clang-23
x86_64                randconfig-006-20260427    clang-23
x86_64                randconfig-011-20260428    gcc-14
x86_64                randconfig-012-20260428    gcc-14
x86_64                randconfig-013-20260428    gcc-14
x86_64                randconfig-014-20260428    gcc-14
x86_64                randconfig-015-20260428    clang-23
x86_64                randconfig-016-20260428    clang-23
x86_64                randconfig-071-20260427    gcc-14
x86_64                randconfig-072-20260427    clang-23
x86_64                randconfig-073-20260427    clang-23
x86_64                randconfig-074-20260427    gcc-14
x86_64                randconfig-075-20260427    clang-23
x86_64                randconfig-076-20260427    gcc-14
x86_64                          rhel-9.4-rust    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                         randconfig-001    gcc-7.5.0
xtensa                randconfig-001-20260427    gcc-10.5.0
xtensa                         randconfig-002    gcc-15.2.0
xtensa                randconfig-002-20260427    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
