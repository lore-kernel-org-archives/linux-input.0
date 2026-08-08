Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C932434B697
	for <linux-input@vger.kernel.org>; Sat,  8 Aug 2026 16:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786208161; cv=none; b=ZikGGnXbjVKeiMtUvJ2Sry+CcFFar3C8CR97FjoBZnVY48igKWMkVdH74eXHNTFcNKmZfoJYD8770Aypqydy4UY3cREZ6YWNpHznYbNr+/iJ7pXYYUJmlj7TofeZ2gzt7fgTAO9HwYrW3ZCXq1bLSdi0pDv/z9gJcYdYop1GNOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786208161; c=relaxed/simple;
	bh=EUuGbzV1LWfLiDKD8MQIzvR1JNIJd5OYF1borFsN0ho=;
	h=Date:From:To:Cc:Subject:Message-ID; b=lmV2+87cTLuSoDRueleHxMadaCuvnLqEOWwyFunJa+fGY1A6q6amfHvjRndiQ9G1WG733h1VjkFHcYUCvpk6yHvXe/Zo6VFYXhvw8Lbde4J5RaioQYAc0N1JjpUkB2FQueJprht8hW4qe5YfHtGbDchWMRwxGfKdeCgL/zVrLaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cGHcwptG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cGHcwptG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786208160; x=1817744160;
  h=date:from:to:cc:subject:message-id;
  bh=EUuGbzV1LWfLiDKD8MQIzvR1JNIJd5OYF1borFsN0ho=;
  b=cGHcwptG5nR6+wIVdiQ9Oh9DW32+BDGqaZ4qbkSAMM0I73h5jzZ3r78C
   NJjeuc438N4mo8P/RT8ynRAGnZ/r3bYqMRHdyOunJzsT7IsM33a7PRn7Z
   tv/k017r6erruhLrbS9IT6xeqz5RXQF+DPHVeHwV+ck5lPwu/tZvR9qVP
   pIj+OGj9d+v9sidkAM1szXniqBXvIrAkJLWM9bKD1tiHWYblTcP1zjo41
   +IX7nf5GjWLwYKnus+wx/FUmqeZoMjnt3rI5KcekFgRXfOV3NPHm/uHUJ
   9O1EUT+cIthPjHh9PsxRnhPq0UYZBAvbkvYtJLb2vUZSv7f7cND0zDIuL
   Q==;
X-CSE-ConnectionGUID: PBcsS86ZTc+bvZyiLV9gDQ==
X-CSE-MsgGUID: dzfoQmd3R22lu3y3IFDknA==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="74325099"
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="74325099"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 09:55:59 -0700
X-CSE-ConnectionGUID: 3C9hu2BTTxqSzmjFavPDug==
X-CSE-MsgGUID: WMFuuyGERNSpqj6If9GQmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="260044328"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 08 Aug 2026 09:55:58 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wskKx-00000000KRt-1A7P;
	Sat, 08 Aug 2026 16:55:55 +0000
Date: Sun, 09 Aug 2026 00:55:36 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:master] BUILD SUCCESS
 8c3ff3164b6ec28f2977f71645a5e6d7fde06924
Message-ID: <202608090019.Kc25CfoH-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git master
branch HEAD: 8c3ff3164b6ec28f2977f71645a5e6d7fde06924  Input: reject inhibit and uninhibit requests on unregistering devices

elapsed time: 2968m

configs tested: 190
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260807    gcc-14.3.0
arc                  randconfig-001-20260808    gcc-9.5.0
arc                  randconfig-002-20260807    gcc-14.3.0
arc                  randconfig-002-20260808    gcc-9.5.0
arm                  randconfig-001-20260807    gcc-14.3.0
arm                  randconfig-001-20260808    gcc-9.5.0
arm                  randconfig-002-20260807    gcc-14.3.0
arm                  randconfig-002-20260808    gcc-9.5.0
arm                  randconfig-003-20260807    gcc-14.3.0
arm                  randconfig-003-20260808    gcc-9.5.0
arm                  randconfig-004-20260807    gcc-14.3.0
arm                  randconfig-004-20260808    gcc-9.5.0
arm64                         randconfig-001    gcc-11.5.0
arm64                randconfig-001-20260807    gcc-16.1.0
arm64                randconfig-001-20260808    gcc-11.5.0
arm64                randconfig-002-20260807    gcc-16.1.0
arm64                randconfig-002-20260808    gcc-11.5.0
arm64                randconfig-003-20260807    gcc-16.1.0
arm64                randconfig-003-20260808    gcc-11.5.0
arm64                randconfig-004-20260807    gcc-16.1.0
arm64                randconfig-004-20260808    gcc-11.5.0
csky                            alldefconfig    gcc-16.1.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260807    gcc-16.1.0
csky                 randconfig-001-20260808    gcc-11.5.0
csky                 randconfig-002-20260807    gcc-16.1.0
csky                 randconfig-002-20260808    gcc-11.5.0
hexagon              randconfig-001-20260807    clang-18
hexagon              randconfig-001-20260808    gcc-16.1.0
hexagon              randconfig-002-20260807    clang-18
hexagon              randconfig-002-20260808    gcc-16.1.0
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    clang-22
i386       buildonly-randconfig-001-20260807    gcc-13
i386       buildonly-randconfig-001-20260808    clang-22
i386       buildonly-randconfig-002-20260807    gcc-13
i386       buildonly-randconfig-002-20260808    clang-22
i386       buildonly-randconfig-003-20260807    gcc-13
i386       buildonly-randconfig-003-20260808    clang-22
i386       buildonly-randconfig-004-20260807    gcc-13
i386       buildonly-randconfig-004-20260808    clang-22
i386       buildonly-randconfig-005-20260807    gcc-13
i386       buildonly-randconfig-005-20260808    clang-22
i386       buildonly-randconfig-006-20260807    gcc-13
i386       buildonly-randconfig-006-20260808    clang-22
i386                 randconfig-001-20260807    gcc-14
i386                 randconfig-001-20260808    clang-22
i386                 randconfig-002-20260807    gcc-14
i386                 randconfig-002-20260808    clang-22
i386                 randconfig-003-20260807    gcc-14
i386                 randconfig-003-20260808    clang-22
i386                 randconfig-004-20260807    gcc-14
i386                 randconfig-004-20260808    clang-22
i386                 randconfig-005-20260807    gcc-14
i386                 randconfig-005-20260808    clang-22
i386                 randconfig-006-20260807    gcc-14
i386                 randconfig-006-20260808    clang-22
i386                 randconfig-007-20260807    gcc-14
i386                 randconfig-007-20260808    clang-22
i386                 randconfig-011-20260807    clang-22
i386                 randconfig-011-20260808    clang-22
i386                 randconfig-012-20260807    clang-22
i386                 randconfig-012-20260808    clang-22
i386                 randconfig-013-20260807    clang-22
i386                 randconfig-013-20260808    clang-22
i386                 randconfig-014-20260807    clang-22
i386                 randconfig-014-20260808    clang-22
i386                 randconfig-015-20260807    clang-22
i386                 randconfig-015-20260808    clang-22
i386                 randconfig-016-20260807    clang-22
i386                 randconfig-016-20260808    clang-22
i386                 randconfig-017-20260807    clang-22
i386                 randconfig-017-20260808    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260807    clang-18
loongarch            randconfig-001-20260808    gcc-16.1.0
loongarch            randconfig-002-20260807    clang-18
loongarch            randconfig-002-20260808    gcc-16.1.0
m68k                      m5275evb_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260807    clang-18
nios2                randconfig-001-20260808    gcc-16.1.0
nios2                randconfig-002-20260807    clang-18
nios2                randconfig-002-20260808    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260807    gcc-8.5.0
parisc               randconfig-001-20260808    gcc-8.5.0
parisc               randconfig-002-20260807    gcc-8.5.0
parisc               randconfig-002-20260808    gcc-8.5.0
powerpc              randconfig-001-20260807    gcc-8.5.0
powerpc              randconfig-001-20260808    gcc-8.5.0
powerpc              randconfig-002-20260807    gcc-8.5.0
powerpc              randconfig-002-20260808    gcc-8.5.0
powerpc64            randconfig-001-20260807    gcc-8.5.0
powerpc64            randconfig-001-20260808    gcc-8.5.0
powerpc64            randconfig-002-20260807    gcc-8.5.0
powerpc64            randconfig-002-20260808    gcc-8.5.0
riscv                         randconfig-001    gcc-12.5.0
riscv                randconfig-001-20260807    gcc-12.5.0
riscv                randconfig-001-20260808    clang-24
riscv                randconfig-002-20260807    gcc-12.5.0
riscv                randconfig-002-20260808    clang-24
s390                 randconfig-001-20260807    gcc-12.5.0
s390                 randconfig-001-20260808    clang-24
s390                 randconfig-002-20260807    gcc-12.5.0
s390                 randconfig-002-20260808    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260807    gcc-12.5.0
sh                   randconfig-001-20260808    clang-24
sh                   randconfig-002-20260807    gcc-12.5.0
sh                   randconfig-002-20260808    clang-24
sh                         urquell_defconfig    gcc-16.1.0
sparc                         randconfig-001    gcc-16.1.0
sparc                randconfig-001-20260807    gcc-16.1.0
sparc                randconfig-001-20260808    gcc-8.5.0
sparc                randconfig-002-20260807    gcc-16.1.0
sparc                randconfig-002-20260808    gcc-8.5.0
sparc64              randconfig-001-20260807    gcc-16.1.0
sparc64              randconfig-001-20260808    gcc-8.5.0
sparc64              randconfig-002-20260807    gcc-16.1.0
sparc64              randconfig-002-20260808    gcc-8.5.0
um                   randconfig-001-20260807    gcc-16.1.0
um                   randconfig-001-20260808    gcc-8.5.0
um                   randconfig-002-20260807    gcc-16.1.0
um                   randconfig-002-20260808    gcc-8.5.0
x86_64     buildonly-randconfig-001-20260807    clang-22
x86_64     buildonly-randconfig-001-20260808    gcc-14
x86_64     buildonly-randconfig-002-20260807    clang-22
x86_64     buildonly-randconfig-002-20260808    gcc-14
x86_64     buildonly-randconfig-003-20260807    clang-22
x86_64     buildonly-randconfig-003-20260808    gcc-14
x86_64     buildonly-randconfig-004-20260807    clang-22
x86_64     buildonly-randconfig-004-20260808    gcc-14
x86_64     buildonly-randconfig-005-20260807    clang-22
x86_64     buildonly-randconfig-005-20260808    gcc-14
x86_64     buildonly-randconfig-006-20260807    clang-22
x86_64     buildonly-randconfig-006-20260808    gcc-14
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    clang-22
x86_64               randconfig-001-20260807    clang-22
x86_64               randconfig-001-20260808    clang-22
x86_64               randconfig-002-20260807    clang-22
x86_64               randconfig-002-20260808    clang-22
x86_64               randconfig-003-20260807    clang-22
x86_64               randconfig-003-20260808    clang-22
x86_64               randconfig-004-20260807    clang-22
x86_64               randconfig-004-20260808    clang-22
x86_64               randconfig-005-20260807    clang-22
x86_64               randconfig-005-20260808    clang-22
x86_64               randconfig-006-20260807    clang-22
x86_64               randconfig-006-20260808    clang-22
x86_64               randconfig-011-20260807    clang-22
x86_64               randconfig-011-20260808    clang-22
x86_64               randconfig-012-20260807    clang-22
x86_64               randconfig-012-20260808    clang-22
x86_64               randconfig-013-20260807    clang-22
x86_64               randconfig-013-20260808    clang-22
x86_64               randconfig-014-20260807    clang-22
x86_64               randconfig-014-20260808    clang-22
x86_64               randconfig-015-20260807    clang-22
x86_64               randconfig-015-20260808    clang-22
x86_64               randconfig-016-20260807    clang-22
x86_64               randconfig-016-20260808    clang-22
x86_64                        randconfig-071    gcc-14
x86_64               randconfig-071-20260807    clang-22
x86_64               randconfig-071-20260808    gcc-14
x86_64               randconfig-072-20260807    clang-22
x86_64               randconfig-072-20260808    gcc-14
x86_64               randconfig-073-20260807    clang-22
x86_64               randconfig-073-20260808    gcc-14
x86_64               randconfig-074-20260807    clang-22
x86_64               randconfig-074-20260808    gcc-14
x86_64               randconfig-075-20260807    clang-22
x86_64               randconfig-075-20260808    gcc-14
x86_64               randconfig-076-20260807    clang-22
x86_64               randconfig-076-20260808    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa                 nommu_kc705_defconfig    gcc-16.1.0
xtensa               randconfig-001-20260807    gcc-16.1.0
xtensa               randconfig-001-20260808    gcc-8.5.0
xtensa               randconfig-002-20260807    gcc-16.1.0
xtensa               randconfig-002-20260808    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
