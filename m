Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E51533F8B1
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 22:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795063; cv=none; b=uGJP9mxwqFnhohqlihq+fNoqjadBvmMC38cQzge0EMvj/X7fSZyYBQxL9HZc5WGU6nRXSpwrhBXaYdBK5yQszCiAZcD3rzSreGkFp2Y0S9XPkxPQJExcU61GFzHeQ9PlOamqDmjftashfTUHote5vJ5IlxXUnqflKad+Sx90bKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795063; c=relaxed/simple;
	bh=8o3LEl1daZFrm0imCL3ISDe/Jr2fKSQ9eWJAHZMilIs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=T9IsoLWuUDAVGnaxFBP9u10KjHHdka655jYBzky9DRZTMEghSrl9a2awwYQ2B254usIWcWQdpXpJLiNlQPjPzfZOjDNXRcAeYQFa7W+AtXywFqsl4tFnxgxjg6aKUkH8CjlVFO/eurcLGMpKpdgsC67gW8zwPfL/XgVUI3ZMLY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RnS342s0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RnS342s0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785795060; x=1817331060;
  h=date:from:to:cc:subject:message-id;
  bh=8o3LEl1daZFrm0imCL3ISDe/Jr2fKSQ9eWJAHZMilIs=;
  b=RnS342s0hZmTg5A88G3giuaCzrKmiG48G6UKPzLJqUV3klNi8tR9VQcE
   CvSZK8VtBtTGhuJV7ghkyWi10AzzCR2M3tEjAzTiP6AUOenWkkSVCkv1Z
   fzX/Phu60AMF/A6W6An8IAxDLkWHMpqcHxgM44CtKwglYAEAt/dlqnHP/
   qLzc5wkix0bImM7x3f/VDKylgGq+b00R9vHddLnwEKLhpohv77FS1fZw7
   QGzFr/heUxXVHKIuVmN+/j+pOQ2gquJ2jh2wsQ3Psg5C9y75ONUPLUs2E
   8m1+h9Rd8e3gqFUwcrFeaQhVQTvtn/HA2qVp1jgOy0r5ceWys3qL21Ljq
   A==;
X-CSE-ConnectionGUID: kR/CSIc5TQyfR5fkYELhTA==
X-CSE-MsgGUID: bxm7mfbHQ4ioJc6/yOCxKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="96703032"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="96703032"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 15:10:58 -0700
X-CSE-ConnectionGUID: euaHZJhAQzavgZLpDXnuCw==
X-CSE-MsgGUID: YCw5BmS/Q9qFO+IG/b5CbA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 03 Aug 2026 15:10:57 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wr0s3-0000000085i-0PWH;
	Mon, 03 Aug 2026 22:10:55 +0000
Date: Tue, 04 Aug 2026 06:09:55 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:for-linus] BUILD SUCCESS
 4c77b45fa23015d41d7401f684bc22ca585b41fe
Message-ID: <202608040636.yMzK2ojR-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
branch HEAD: 4c77b45fa23015d41d7401f684bc22ca585b41fe  fixp-arith: convert comments to kernel-doc format

elapsed time: 734m

configs tested: 178
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260803    gcc-8.5.0
arc                  randconfig-001-20260804    gcc-8.5.0
arc                  randconfig-002-20260803    gcc-8.5.0
arc                  randconfig-002-20260804    gcc-8.5.0
arm                  randconfig-001-20260803    gcc-8.5.0
arm                  randconfig-001-20260804    gcc-8.5.0
arm                  randconfig-002-20260803    gcc-8.5.0
arm                  randconfig-002-20260804    gcc-8.5.0
arm                  randconfig-003-20260803    gcc-8.5.0
arm                  randconfig-003-20260804    gcc-8.5.0
arm                  randconfig-004-20260803    gcc-8.5.0
arm                  randconfig-004-20260804    gcc-8.5.0
arm                          stm32_defconfig    gcc-16.1.0
arm64                randconfig-001-20260803    gcc-12.5.0
arm64                randconfig-001-20260804    gcc-11.5.0
arm64                randconfig-002-20260803    gcc-12.5.0
arm64                randconfig-002-20260804    gcc-11.5.0
arm64                randconfig-003-20260803    gcc-12.5.0
arm64                randconfig-003-20260804    gcc-11.5.0
arm64                randconfig-004-20260803    gcc-12.5.0
arm64                randconfig-004-20260804    gcc-11.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260803    gcc-12.5.0
csky                 randconfig-001-20260804    gcc-11.5.0
csky                 randconfig-002-20260803    gcc-12.5.0
csky                 randconfig-002-20260804    gcc-11.5.0
hexagon              randconfig-001-20260803    clang-18
hexagon              randconfig-001-20260804    gcc-16.1.0
hexagon              randconfig-002-20260803    clang-18
hexagon              randconfig-002-20260804    gcc-16.1.0
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    clang-22
i386       buildonly-randconfig-001-20260803    clang-22
i386       buildonly-randconfig-001-20260804    gcc-14
i386       buildonly-randconfig-002-20260803    clang-22
i386       buildonly-randconfig-002-20260804    gcc-14
i386       buildonly-randconfig-003-20260803    clang-22
i386       buildonly-randconfig-003-20260804    gcc-14
i386       buildonly-randconfig-004-20260803    clang-22
i386       buildonly-randconfig-004-20260804    gcc-14
i386       buildonly-randconfig-005-20260803    clang-22
i386       buildonly-randconfig-005-20260804    gcc-14
i386       buildonly-randconfig-006-20260803    clang-22
i386       buildonly-randconfig-006-20260804    gcc-14
i386                          randconfig-001    gcc-13
i386                 randconfig-001-20260803    gcc-13
i386                 randconfig-001-20260804    clang-22
i386                 randconfig-002-20260803    gcc-13
i386                 randconfig-002-20260804    clang-22
i386                 randconfig-003-20260803    gcc-13
i386                 randconfig-003-20260804    clang-22
i386                 randconfig-004-20260803    gcc-13
i386                 randconfig-004-20260804    clang-22
i386                 randconfig-005-20260803    gcc-13
i386                 randconfig-005-20260804    clang-22
i386                 randconfig-006-20260803    gcc-13
i386                 randconfig-006-20260804    clang-22
i386                 randconfig-007-20260803    gcc-13
i386                 randconfig-007-20260804    clang-22
i386                 randconfig-011-20260803    clang-22
i386                 randconfig-011-20260803    gcc-14
i386                 randconfig-011-20260804    gcc-13
i386                 randconfig-012-20260803    clang-22
i386                 randconfig-012-20260804    gcc-13
i386                 randconfig-013-20260803    clang-22
i386                 randconfig-013-20260803    gcc-14
i386                 randconfig-013-20260804    gcc-13
i386                 randconfig-014-20260803    clang-22
i386                 randconfig-014-20260803    gcc-14
i386                 randconfig-014-20260804    gcc-13
i386                 randconfig-015-20260803    clang-22
i386                 randconfig-015-20260803    gcc-14
i386                 randconfig-015-20260804    gcc-13
i386                 randconfig-016-20260803    clang-22
i386                 randconfig-016-20260804    gcc-13
i386                 randconfig-017-20260803    clang-22
i386                 randconfig-017-20260803    gcc-14
i386                 randconfig-017-20260804    gcc-13
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260803    clang-18
loongarch            randconfig-001-20260804    gcc-16.1.0
loongarch            randconfig-002-20260803    clang-18
loongarch            randconfig-002-20260804    gcc-16.1.0
mips                      bmips_be_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260803    clang-18
nios2                randconfig-001-20260804    gcc-16.1.0
nios2                randconfig-002-20260803    clang-18
nios2                randconfig-002-20260804    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-15.2.0
parisc               randconfig-001-20260803    gcc-15.2.0
parisc               randconfig-001-20260804    gcc-8.5.0
parisc               randconfig-002-20260803    gcc-15.2.0
parisc               randconfig-002-20260804    gcc-8.5.0
powerpc                      eiger_defconfig    clang-24
powerpc              randconfig-001-20260803    gcc-15.2.0
powerpc              randconfig-001-20260804    gcc-8.5.0
powerpc              randconfig-002-20260803    gcc-15.2.0
powerpc              randconfig-002-20260804    gcc-8.5.0
powerpc                    redwood_defconfig    clang-24
powerpc                    taishan_defconfig    clang-21
powerpc64            randconfig-001-20260803    gcc-15.2.0
powerpc64            randconfig-001-20260804    gcc-8.5.0
powerpc64            randconfig-002-20260803    gcc-15.2.0
powerpc64            randconfig-002-20260804    gcc-8.5.0
riscv                         randconfig-001    gcc-8.5.0
riscv                randconfig-001-20260803    gcc-8.5.0
riscv                randconfig-002-20260803    gcc-8.5.0
s390                 randconfig-001-20260803    gcc-8.5.0
s390                 randconfig-002-20260803    gcc-8.5.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260803    gcc-8.5.0
sh                   randconfig-002-20260803    gcc-8.5.0
sparc                randconfig-001-20260803    gcc-16.1.0
sparc                randconfig-001-20260804    gcc-16.1.0
sparc                randconfig-002-20260803    gcc-16.1.0
sparc                randconfig-002-20260804    gcc-16.1.0
sparc64              randconfig-001-20260803    gcc-16.1.0
sparc64              randconfig-001-20260804    gcc-16.1.0
sparc64              randconfig-002-20260803    gcc-16.1.0
sparc64              randconfig-002-20260804    gcc-16.1.0
um                   randconfig-001-20260803    gcc-16.1.0
um                   randconfig-001-20260804    gcc-16.1.0
um                   randconfig-002-20260803    gcc-16.1.0
um                   randconfig-002-20260804    gcc-16.1.0
x86_64     buildonly-randconfig-001-20260803    clang-22
x86_64     buildonly-randconfig-001-20260804    gcc-14
x86_64     buildonly-randconfig-002-20260803    clang-22
x86_64     buildonly-randconfig-002-20260804    gcc-14
x86_64     buildonly-randconfig-003-20260803    clang-22
x86_64     buildonly-randconfig-003-20260804    gcc-14
x86_64     buildonly-randconfig-004-20260803    clang-22
x86_64     buildonly-randconfig-004-20260804    gcc-14
x86_64     buildonly-randconfig-005-20260803    clang-22
x86_64     buildonly-randconfig-005-20260804    gcc-14
x86_64     buildonly-randconfig-006-20260803    clang-22
x86_64     buildonly-randconfig-006-20260804    gcc-14
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    gcc-14
x86_64               randconfig-001-20260803    gcc-14
x86_64               randconfig-002-20260803    gcc-14
x86_64               randconfig-003-20260803    gcc-14
x86_64               randconfig-004-20260803    gcc-14
x86_64               randconfig-005-20260803    gcc-14
x86_64               randconfig-006-20260803    gcc-14
x86_64               randconfig-011-20260803    gcc-14
x86_64               randconfig-011-20260804    clang-22
x86_64               randconfig-012-20260803    gcc-14
x86_64               randconfig-012-20260804    clang-22
x86_64               randconfig-013-20260803    gcc-14
x86_64               randconfig-013-20260804    clang-22
x86_64               randconfig-014-20260803    gcc-14
x86_64               randconfig-014-20260804    clang-22
x86_64               randconfig-015-20260803    gcc-14
x86_64               randconfig-015-20260804    clang-22
x86_64               randconfig-016-20260803    gcc-14
x86_64               randconfig-016-20260804    clang-22
x86_64                        randconfig-071    clang-22
x86_64               randconfig-071-20260803    clang-22
x86_64               randconfig-072-20260803    clang-22
x86_64               randconfig-073-20260803    clang-22
x86_64               randconfig-074-20260803    clang-22
x86_64               randconfig-075-20260803    clang-22
x86_64               randconfig-076-20260803    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260803    gcc-16.1.0
xtensa               randconfig-001-20260804    gcc-16.1.0
xtensa               randconfig-002-20260803    gcc-16.1.0
xtensa               randconfig-002-20260804    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
