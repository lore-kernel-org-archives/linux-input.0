Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F263A31E838
	for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777019395; cv=none; b=nunLFrDdjXFAQczlFEukG4C8zPQ5W3O2Ci5vKdTUiajDyNf7Ik8jiJ/ymHWSmB/AXkAdWe2dgRTlxcBeVbWYAWm93LNkQOPvRRbUy0gnIBuOgqDXB7MeAZmfPqlBFH8stUQNlaw2H1RlZy4TDLK+uWyC+GU7MbtG0jtLJWKnisY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777019395; c=relaxed/simple;
	bh=W3ouNcqxQBfklGxVSnFwNuTqtaGFEb5c7aZTw2NUqqM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AfOb0B1kXoTCjC1/3p9tIi5VV+LmxAe7lT/v7ZOio3+ejVRYBWKUBlHbkM2LIkhErWSUWbZFgR3g4NGAM5q4XT22AJCxRsfvYbsSujmoZNMaC1PGOpuBMb99hyOQQIjbZomDC2EU2F3QWYfjRu967O85SgQObSb0e8PoNWyW8T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tfp8/XGJ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tfp8/XGJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777019393; x=1808555393;
  h=date:from:to:cc:subject:message-id;
  bh=W3ouNcqxQBfklGxVSnFwNuTqtaGFEb5c7aZTw2NUqqM=;
  b=Tfp8/XGJbBoPek9mmSs2q3bOqhPIc5fHDckrNxsln/JFNDDvJrQpDFR6
   9FGgbUjPn1HW6MjYOAXAt2lKsu2ITOyM4fLv9P4F219dEgVFSFk4KjBI0
   G8PCrV5faXkaseZCpFyrYfE+24mLYa85BtNYiuQC2zT2fUiSlUEOhRV3y
   enRZGmkinOYHv7gaTPXYWg0dXhf81qBm+YNqbhD+jekU8tzYiQG4JxZK1
   zXGmP/nI3wDsWu3SP2GxjpCOXUJqGKVj8/y50w5vqPW8JHDccxMJNQhhB
   RZz5fO9vOSqSBG3QzrBrLcHeLBAmsvgPn3Bj9KKObcbq/r/MkBwrjnNMG
   A==;
X-CSE-ConnectionGUID: x8kJFogWTeC2FZMVz2jiXA==
X-CSE-MsgGUID: 1XfOMXmwQF2ZKqokIjNE7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="100649582"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="100649582"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 01:29:52 -0700
X-CSE-ConnectionGUID: npFkGHZ5SKmRW1rhifa/Lw==
X-CSE-MsgGUID: Ecg9AmQVQseniYEJEifw7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="232749800"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 24 Apr 2026 01:29:52 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wGBv2-000000005QX-40iy;
	Fri, 24 Apr 2026 08:29:48 +0000
Date: Fri, 24 Apr 2026 16:28:53 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:for-linus] BUILD SUCCESS
 8f9d6cd6d3916add4c47a9dd1622e4fc057f877b
Message-ID: <202604241644.bW8zm7lp-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
branch HEAD: 8f9d6cd6d3916add4c47a9dd1622e4fc057f877b  Input: elan_i2c - increase device reset wait timeout after update FW

elapsed time: 829m

configs tested: 53
configs skipped: 2

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

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
