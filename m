Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CA633F5B0
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788380398; cv=none; b=t9gxjzbfGwQJRIpTCdQpcQWVA5b6hOBsdAvGUVM3t3+kuPDWhGRBFnUySFOYGnP2bS6rYCsNerRJ6I6l+4lgOvxDFoXGrHrgLSLHCUD/aDceUC0H8LbH1fFGT12gRAGHNbrDS5JeaEgrjfaIzbqQb7aiWQ0TRd8EI7Ik/gfcvwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788380398; c=relaxed/simple;
	bh=AL97nv0JMzM8IVQ8S0VNQXtT1KvUDpy14GU+FgyJHdg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Jr8/+ww6/e3y4bhZ5Y3RJGzihpdalRlB1Z9YXFFdRQTAreQA1XYOmWUlebbqEJEmBYx16x9EF7h87R8nIUiy8PRAZn+gEk586oriUs6DHeaEbAqxTN71jGC1VmXlcL4yg5YHOA/Bzo7tTWcv8dBRmRpGvGBggHYiJIrbPU/ss2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nQWDU53C; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nQWDU53C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788380396; x=1819916396;
  h=date:from:to:cc:subject:message-id;
  bh=AL97nv0JMzM8IVQ8S0VNQXtT1KvUDpy14GU+FgyJHdg=;
  b=nQWDU53CtijAd9KN8C+wMuCzrWlOr4JSZV1Z6xxNypvMsvbntz9POJPi
   m4mxooPuncycsDuMYKaMgjD247TELqyVnvvtIYZFr4oKAoYCFsLkm+VQ6
   TwL05CLVGlJVGyH8IuAjVD7pMq2Z+qfYYqLM2y/0zNY3/KNoUEUwb2J6n
   j/K2iIf5mEZ5v5PS3tmsz+5zQcPRaQLBOGOXBrk0f5+C0uI6A9Ykxdpjo
   oQEHLNKUq2YhXysxoScBrDvUZagcjZR5K8P1QQXukp/2ViTElR41uXxEY
   Tnp0c2yfo5083NFxh+UFzGOZcZHVHa5VbcynjvVzoJGMy5r4fHDOZm9EN
   A==;
X-CSE-ConnectionGUID: KcjOm5MqTxiCwCeJEAooDw==
X-CSE-MsgGUID: CFjydK8lSkGYRN8f02ucOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="111625866"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="111625866"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 13:19:56 -0700
X-CSE-ConnectionGUID: 6AnKN5qBTsypWc5nGx4UHw==
X-CSE-MsgGUID: 6woyJ+D5TDaCz9wdf3qa6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="265191214"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 02 Sep 2026 13:19:55 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1rR2-000000003Ig-28jS;
	Wed, 02 Sep 2026 20:19:52 +0000
Date: Thu, 03 Sep 2026 04:18:53 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:for-linus] BUILD SUCCESS
 85f080fb87ed5cd3e46121be677f52c82f26a0ab
Message-ID: <202609030448.ZKRWTghZ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
branch HEAD: 85f080fb87ed5cd3e46121be677f52c82f26a0ab  Input: cyttsp5 - clamp the HID report size before memcpy

elapsed time: 1731m

configs tested: 72
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    clang-24
arc          allmodconfig    gcc-16.1.0
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arm           allnoconfig    clang-17
arm           allnoconfig    gcc-16.1.0
arm          allyesconfig    clang-24
arm          allyesconfig    gcc-16.1.0
arm64        allmodconfig    clang-24
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    gcc-16.1.0
hexagon       allnoconfig    clang-24
hexagon       allnoconfig    gcc-16.1.0
i386         allmodconfig    clang-22
i386          allnoconfig    gcc-14
i386          allnoconfig    gcc-16.1.0
i386         allyesconfig    clang-22
loongarch    allmodconfig    clang-24
loongarch     allnoconfig    clang-20
loongarch     allnoconfig    gcc-16.1.0
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
m68k         allyesconfig    clang-24
m68k         allyesconfig    gcc-16.1.0
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips         allmodconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    clang-24
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-16.1.0
openrisc      allnoconfig    clang-24
openrisc      allnoconfig    gcc-16.1.0
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    clang-24
parisc        allnoconfig    gcc-16.1.0
parisc       allyesconfig    clang-17
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    clang-24
powerpc       allnoconfig    gcc-16.1.0
riscv        allmodconfig    clang-24
riscv         allnoconfig    clang-24
riscv         allnoconfig    gcc-16.1.0
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-17
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    clang-24
sh            allnoconfig    gcc-16.1.0
sh           allyesconfig    clang-17
sparc         allnoconfig    clang-24
sparc         allnoconfig    gcc-16.1.0
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-17
um            allnoconfig    clang-24
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-22
x86_64        allnoconfig    clang-24
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    clang-24
xtensa        allnoconfig    gcc-16.1.0
xtensa       allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
