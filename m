Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5290B3CB2DF
	for <linux-input@vger.kernel.org>; Thu, 23 Apr 2026 03:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776915305; cv=none; b=S2kKDmqgc0nflf2livdKNETztNlG3rc/p2g3U1oqTeUICE/rThRXDK0xIx9q9h1W8kJHusbIHd+vm5PMTUHSMSfkLEzOqNxG3JsU3YQn4VYHP4Ld+HCvMeqWhYmWe8dUAKqNN+DAFq26H5Vh6lhf7WCK4aymjwUqyUj8tdiD2Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776915305; c=relaxed/simple;
	bh=TD8lhRbUOKSr1lCfQwzhCoAWJ6KmREujROsLhU9ylWw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IQYzG+PJhkLkkHg7ssQgsBFQ7N9Wqt0GrfQ4w0kG6Q2+v6SbWPg8CmuSjpENcJ4RK5rivGXDEqshAYteo8ehV+ascnkxOCBRP5w1Ya9wECJ5kyCzpwImhKY+w7DYei+3fnVZJFK89WV6cKvzVOtZ2acfjhFBXVQ3BGbKTMKu2V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCp9tHaP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCp9tHaP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776915303; x=1808451303;
  h=date:from:to:cc:subject:message-id;
  bh=TD8lhRbUOKSr1lCfQwzhCoAWJ6KmREujROsLhU9ylWw=;
  b=MCp9tHaP3AwukBL6nH/gM1X9vmqX/pglkEUK5b54isRlcPP9iWWVIdAb
   ww8Ba7dEkhMO9OBPXgRIT+TJmhG4ACD+H36GPueIum67sFWSfxXi0CTuK
   MjcPOrfIgXfxdkhecpJGzJDj0jBiRBcmLdQ14nFjbXcNbVSifGKI+1+/n
   LdDB11gjBCZYF9wR21stdBdkaILXhuNdyVkNlItb/NaaEy/2ycg2L9Ghq
   5puKCd9fkKhYivMevZRHozbCHctD/vYEl7w1xlQ2WBMg3wWiZJL/v7We7
   YpYishTsVnCHxbBSTCS9fZo2Mk8j6PoQLOScQhbWO3lV3ax/zEnTL0/ua
   Q==;
X-CSE-ConnectionGUID: 1TtQh6zyTpuYn64eAVdKAQ==
X-CSE-MsgGUID: rVXNBBdtRb6KzjcMbT7NVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77754591"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="77754591"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 20:35:02 -0700
X-CSE-ConnectionGUID: Aofxa3q4TxeTqfvd2nG5gg==
X-CSE-MsgGUID: /WxeNsxHS/ynI8CblpBeUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="236528870"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 22 Apr 2026 20:35:02 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wFkqB-000000001Q7-0BPO;
	Thu, 23 Apr 2026 03:34:59 +0000
Date: Thu, 23 Apr 2026 11:34:46 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:next] BUILD SUCCESS
 fc59cad7e896fdb7a07bd91f7c0952e2a0e12b36
Message-ID: <202604231137.Wdpj8WO1-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
branch HEAD: fc59cad7e896fdb7a07bd91f7c0952e2a0e12b36  Input: lm8323 - remove space before newline

elapsed time: 724m

configs tested: 56
configs skipped: 0

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
loongarch    allmodconfig    clang-19
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
s390         alldefconfig    gcc-15.2.0
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
xtensa       allyesconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
