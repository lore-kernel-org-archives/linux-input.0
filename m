Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90918175A5
	for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 04:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784261674; cv=none; b=O80EDvnh5sQvrPKEFI3wvUMbAdAE64CVpPhO4pXl/ZzhAxL4WTLlZ87Yt+xxrmRDrb5Wu6JAtFGjb8Y8g0oS4e7E8VpMjiBawsiNtnp3n80/mJjz37GQgyR6RBs85iBtwbrLXWxKEs91czDC8MntwWxoCet3O10khzJQMS7xWOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784261674; c=relaxed/simple;
	bh=tiMEi8rUOY7GpyNwIgKjUwbTASy6RkpqTd0CDQUHYOA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=D9fIu1o47JB46nVf4TkM4p3yQWSeh+jSFGeEq2MwdNenI09iT0GCXVME0MFUZbSTVfocdfqCRPyJUvvvCf3noPaCTVaSF2Bpn4y90rlvaw0rpAld7iD7bnLi/tiH2DkhQx8DBO6b48QUHbT/0cSXr9EFwN9SkBG3KKvaBp+y/vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IKbYgggJ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IKbYgggJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784261672; x=1815797672;
  h=date:from:to:cc:subject:message-id;
  bh=tiMEi8rUOY7GpyNwIgKjUwbTASy6RkpqTd0CDQUHYOA=;
  b=IKbYgggJiOyUSsMkY4MqLTXT6qlk+KVHGlEpaORdzOUd0DHBdeIuyBtu
   BNZMXldyk65xUCT8mSC6W4nIh8K36+d5RHXB9MqWX2fXCNZ8++NiWEGKO
   1t6n+ZVgasnuQtJXjObSHwEuKYjEx8GR0xfzWTEil/bwJd2WPJi0JXtw0
   7cN2/trlMXGws8wqh7oV4OlL4XrIRa6jOUoBEMWxzYUb30kxsUZGUGbqY
   5GU9nfKJXKegqSyYBdb6ZeuJZXx9GsTX1rFJu9V2bFeL7B4X1+qw9Gt6b
   7EOtG4VqYAZzYfqj0ZutVbHgc5wZ5yzMIDVyqsrnHsSs/HiooHtZNJ+uc
   Q==;
X-CSE-ConnectionGUID: y8gd13wsR6upJEwwKJjydg==
X-CSE-MsgGUID: BVA4W1lVRjqBdT1zV/SfPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="102354822"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="102354822"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 21:14:32 -0700
X-CSE-ConnectionGUID: AN3o7S5xSU2u+IUxTgY+bw==
X-CSE-MsgGUID: 6Uj9NWM7TzaCD8pY09kv+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="252273966"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 16 Jul 2026 21:14:30 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wkZxi-00000000SQ8-0ef6;
	Fri, 17 Jul 2026 04:14:14 +0000
Date: Fri, 17 Jul 2026 12:13:35 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:next] BUILD SUCCESS
 3ed4ba919eb35860ee1867e2851ee3e6f9fe37f5
Message-ID: <202607171223.VrRfGwbX-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
branch HEAD: 3ed4ba919eb35860ee1867e2851ee3e6f9fe37f5  Input: wacom_w8001 - replace strlcat() with a strscpy() helper

elapsed time: 1703m

configs tested: 118
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    gcc-16.1.0
arc                   randconfig-001-20260717    gcc-11.5.0
arc                   randconfig-002-20260717    gcc-11.5.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-16.1.0
arm                          exynos_defconfig    clang-17
arm                   randconfig-001-20260717    gcc-11.5.0
arm                   randconfig-002-20260717    gcc-11.5.0
arm                   randconfig-003-20260717    gcc-11.5.0
arm                   randconfig-004-20260717    gcc-11.5.0
arm64                            allmodconfig    clang-24
arm64                             allnoconfig    gcc-16.1.0
arm64                 randconfig-001-20260717    gcc-13.4.0
arm64                 randconfig-002-20260717    gcc-13.4.0
arm64                 randconfig-003-20260717    gcc-13.4.0
arm64                 randconfig-004-20260717    gcc-13.4.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                  randconfig-001-20260717    gcc-13.4.0
csky                  randconfig-002-20260717    gcc-13.4.0
hexagon                           allnoconfig    clang-24
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20260717    gcc-14
i386        buildonly-randconfig-002-20260717    gcc-14
i386        buildonly-randconfig-003-20260717    gcc-14
i386        buildonly-randconfig-004-20260717    gcc-14
i386        buildonly-randconfig-005-20260717    gcc-14
i386        buildonly-randconfig-006-20260717    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-20
loongarch                           defconfig    clang-24
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    gcc-16.1.0
m68k                        mvme147_defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260717    gcc-11.5.0
parisc                randconfig-002-20260717    gcc-11.5.0
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-001-20260717    gcc-11.5.0
powerpc               randconfig-002-20260717    gcc-11.5.0
powerpc64             randconfig-001-20260717    gcc-11.5.0
powerpc64             randconfig-002-20260717    gcc-11.5.0
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-24
riscv                 randconfig-001-20260717    clang-24
riscv                 randconfig-002-20260717    clang-24
s390                             allmodconfig    clang-24
s390                              allnoconfig    clang-24
s390                             allyesconfig    gcc-16.1.0
s390                  randconfig-001-20260717    clang-24
s390                  randconfig-002-20260717    clang-24
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-16.1.0
sh                    randconfig-001-20260717    clang-24
sh                    randconfig-002-20260717    clang-24
sparc                             allnoconfig    gcc-16.1.0
sparc                 randconfig-001-20260717    gcc-8.5.0
sparc                 randconfig-002-20260717    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64               randconfig-001-20260717    gcc-8.5.0
sparc64               randconfig-002-20260717    gcc-8.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-14
um                    randconfig-001-20260717    gcc-8.5.0
um                    randconfig-002-20260717    gcc-8.5.0
x86_64                            allnoconfig    clang-22
x86_64      buildonly-randconfig-001-20260717    gcc-14
x86_64      buildonly-randconfig-002-20260717    gcc-14
x86_64      buildonly-randconfig-003-20260717    gcc-14
x86_64      buildonly-randconfig-004-20260717    gcc-14
x86_64      buildonly-randconfig-005-20260717    gcc-14
x86_64      buildonly-randconfig-006-20260717    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260717    gcc-14
x86_64                randconfig-002-20260717    gcc-14
x86_64                randconfig-003-20260717    gcc-14
x86_64                randconfig-004-20260717    gcc-14
x86_64                randconfig-005-20260717    gcc-14
x86_64                randconfig-006-20260717    gcc-14
x86_64                randconfig-011-20260717    gcc-12
x86_64                randconfig-012-20260717    gcc-12
x86_64                randconfig-013-20260717    gcc-12
x86_64                randconfig-014-20260717    gcc-12
x86_64                randconfig-015-20260717    gcc-12
x86_64                randconfig-016-20260717    gcc-12
x86_64                randconfig-071-20260717    clang-22
x86_64                randconfig-072-20260717    clang-22
x86_64                randconfig-073-20260717    clang-22
x86_64                randconfig-074-20260717    clang-22
x86_64                randconfig-075-20260717    clang-22
x86_64                randconfig-076-20260717    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260717    gcc-8.5.0
xtensa                randconfig-002-20260717    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
