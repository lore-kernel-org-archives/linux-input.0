Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960EE3DE449
	for <linux-input@vger.kernel.org>; Thu, 23 Apr 2026 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933201; cv=none; b=Z+xYZHdRfgGW2Jjp066OUrRsnfJy4jgnZ19a4OSPjmhQJvnJpqB2xujz3uKzrVPklDKqH7/2gBmK3/R4rurlnbFV89oZk93QqegFkVAf7n/XIm+YkVcib/fz1Dx4sQ1+N6e4hKbJLZcWgLAstZywDzOd7XjADUz4qV5qFSNpJlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933201; c=relaxed/simple;
	bh=GCeKWe2hG2/6wVbKPGjrNPmZSWIo3fOll1OrFeeoKwI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bwoUI+pr1kI++NfH/bW+Gu7fToe5UtrwreGzLwUzybax9LYjAc+0QVswRvIqRRmfixBuImmHXe+FYKwLcBrQN/O6Rt8GvXPDL7XPg/3tpfkEfv/BZGl/pQXQxqUfvMp81wJJUBC+Mr+GuYiWBAI/mpOHzMPnnLdUp0iQA6VgMYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PbAuo4Vy; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PbAuo4Vy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776933199; x=1808469199;
  h=date:from:to:cc:subject:message-id;
  bh=GCeKWe2hG2/6wVbKPGjrNPmZSWIo3fOll1OrFeeoKwI=;
  b=PbAuo4VyHlJtSbzgW7AqFG+bzizhS6IowYovRyBHYwNcNSF0HRYj6kbr
   LJRZ3M9ph/so0mXu3edn51IUEPQ+2onQVMzuvttmKOyoS7BmY4uIp0OEf
   g2bUpSbisLROh/w1OKm4FI28ChhAp7wfeFEzSPhd5Jg+71IyGwT0SZmQY
   ge5YYrUGT22lriRb29GCkN6vNCxUbX6s21WhGf0A+hWbDHscZUCg94lnm
   V3Au3jSo7pmlEkZArkNGUZmACGt18lg8yF625N6xquyR4X7h2ynQt2Bx1
   C3f566uowcdowHcniE6AThooA77I5vK1jqLS+/hDYfyibH07ASKG3fIKP
   A==;
X-CSE-ConnectionGUID: kj9b+r1RSj2ur6FbWZvSDw==
X-CSE-MsgGUID: SF3M4va3Q/mJidJQf/J02A==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77914829"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="77914829"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 01:33:19 -0700
X-CSE-ConnectionGUID: +UOmvaRyTieKLDU7XVbt3A==
X-CSE-MsgGUID: TkpyBRkET5yx5yIMKoyhgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="234383909"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 23 Apr 2026 01:33:18 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wFpUp-000000002Bx-1hMs;
	Thu, 23 Apr 2026 08:33:15 +0000
Date: Thu, 23 Apr 2026 16:32:28 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:for-linus] BUILD SUCCESS
 f4b369c6fe0ceaba2da2daff8c9eb415f85926dd
Message-ID: <202604231619.2YEvs2dA-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
branch HEAD: f4b369c6fe0ceaba2da2daff8c9eb415f85926dd  Merge branch 'next' into for-linus

elapsed time: 1022m

configs tested: 88
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.2.0
alpha                  allyesconfig    gcc-15.2.0
arc                    allmodconfig    gcc-15.2.0
arc                     allnoconfig    gcc-15.2.0
arc                    allyesconfig    gcc-15.2.0
arc                  hsdk_defconfig    gcc-15.2.0
arc         randconfig-001-20260423    gcc-15.2.0
arc         randconfig-002-20260423    gcc-8.5.0
arm                     allnoconfig    clang-23
arm                    allyesconfig    gcc-15.2.0
arm         randconfig-001-20260423    gcc-10.5.0
arm         randconfig-003-20260423    clang-23
arm64                  allmodconfig    clang-19
arm64                   allnoconfig    gcc-15.2.0
arm64       randconfig-003-20260423    gcc-14.3.0
csky                   allmodconfig    gcc-15.2.0
csky                    allnoconfig    gcc-15.2.0
csky        randconfig-001-20260423    gcc-10.5.0
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-23
hexagon     randconfig-001-20260423    clang-16
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                   allyesconfig    gcc-14
i386        randconfig-011-20260423    gcc-14
i386        randconfig-012-20260423    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-23
m68k                   allmodconfig    gcc-15.2.0
m68k                    allnoconfig    gcc-15.2.0
m68k                   allyesconfig    gcc-15.2.0
microblaze              allnoconfig    gcc-15.2.0
microblaze             allyesconfig    gcc-15.2.0
mips                    allnoconfig    gcc-15.2.0
mips                   allyesconfig    gcc-15.2.0
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
openrisc               allmodconfig    gcc-15.2.0
openrisc                allnoconfig    gcc-15.2.0
parisc                  allnoconfig    gcc-15.2.0
parisc                 allyesconfig    gcc-15.2.0
parisc      randconfig-001-20260423    gcc-9.5.0
parisc      randconfig-002-20260423    gcc-13.4.0
powerpc                allmodconfig    gcc-15.2.0
powerpc                 allnoconfig    gcc-15.2.0
powerpc     randconfig-001-20260423    clang-23
powerpc     randconfig-002-20260423    clang-23
powerpc64   randconfig-001-20260423    clang-23
powerpc64   randconfig-002-20260423    gcc-10.5.0
riscv                  allmodconfig    clang-23
riscv                   allnoconfig    gcc-15.2.0
riscv                  allyesconfig    clang-16
riscv       randconfig-001-20260423    clang-17
riscv       randconfig-002-20260423    gcc-12.5.0
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-23
s390                   allyesconfig    gcc-15.2.0
s390        randconfig-001-20260423    clang-23
s390        randconfig-002-20260423    gcc-10.5.0
sh                     allmodconfig    gcc-15.2.0
sh                      allnoconfig    gcc-15.2.0
sh                     allyesconfig    gcc-15.2.0
sh                        defconfig    gcc-15.2.0
sh          randconfig-001-20260423    gcc-15.2.0
sh          randconfig-002-20260423    gcc-15.2.0
sparc                   allnoconfig    gcc-15.2.0
sparc       randconfig-001-20260423    gcc-11.5.0
sparc       randconfig-002-20260423    gcc-8.5.0
sparc64                allmodconfig    clang-23
sparc64                   defconfig    clang-20
sparc64     randconfig-001-20260423    clang-23
sparc64     randconfig-002-20260423    gcc-10.5.0
um                     allmodconfig    clang-19
um                      allnoconfig    clang-23
um                     allyesconfig    gcc-14
um                        defconfig    clang-23
um                   i386_defconfig    gcc-14
um          randconfig-001-20260423    clang-18
um          randconfig-002-20260423    gcc-14
um                 x86_64_defconfig    clang-23
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64                    defconfig    gcc-14
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.2.0
xtensa      randconfig-001-20260423    gcc-8.5.0
xtensa      randconfig-002-20260423    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
