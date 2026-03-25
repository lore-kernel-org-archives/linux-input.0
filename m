Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA1C3FB05A
	for <linux-input@vger.kernel.org>; Wed, 25 Mar 2026 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457903; cv=none; b=KPNLOtwspSnQVVGPpmsu5y98GfPsKRdpr2xitFd2uTjGrcapPlkGDN4H4Tdg5+ICo3ys2OOW/Dz6kxewIKZbr3zzHYNdFD9VSO7jNziuIm5c7nEFXw8ojudgb//WHOQDJbqi1vlCeYTiRaaGDqgwFkObj20qvWVc4xvAP+t/LeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457903; c=relaxed/simple;
	bh=yBtblwKtwPk8EhQMFF2wyxjQq4VjCTCNZY9jsQu2kB8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=c3yZIGO0Yw8n/lqHG+vOFGHOlHimkUK81tFPxdksH7h+JSp5mYiyJUWSP5r1Z2AnrFoPR8eb19fNMYfcYIjpRzTacrIhw2dHrU0KAKEdrtQbr0fr8I2ajolxfmXV3fl884vhyfvdtPkW9ase2Cml7uIm5DOpmckvCXMHkV2yn7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=COL0Yj6o; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="COL0Yj6o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774457899; x=1805993899;
  h=date:from:to:cc:subject:message-id;
  bh=yBtblwKtwPk8EhQMFF2wyxjQq4VjCTCNZY9jsQu2kB8=;
  b=COL0Yj6oybw1AByjd9ZYApVo7Dnt22YEdF0F39KdY2Qu0V16NfFCPkqw
   HtAi2miLCMI4wJRSsUtgHglwFD8lrwER5sSyXOGFiZXacYtksz2UC4WOc
   2XVdhOS3aOYqPO5kFWfqCv0VrOO1s/CyN5u0w7kWCtOxOUuz8YYNdReDq
   dKzrd6cCIa6Bwlp+dUGroeEi7yr/bfwjh4oHKUXmriEsYJFM4mqE5En6O
   Cj6JmQr8C/gt08V/zGN0u6J3B60WMiFhiCLjXcIDU4nCbKEidM4I812A/
   Lq6gXdI6SHNfiGOPGg4+ZwHIZNkbz/U0uiFmhN5CPeCwNrCvTd9Ni86Ck
   g==;
X-CSE-ConnectionGUID: vydn/Wl3TfaN+UEYkHIHAg==
X-CSE-MsgGUID: 9b1WRUzgS+upVAginF0bxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75522374"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75522374"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 09:58:14 -0700
X-CSE-ConnectionGUID: l44niLfMSsiHE/K6G1MYOA==
X-CSE-MsgGUID: hjvAyXvcSqePUkYbOyJU3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="220335265"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 25 Mar 2026 09:58:12 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5RYX-000000007Jj-1mvh;
	Wed, 25 Mar 2026 16:58:09 +0000
Date: Thu, 26 Mar 2026 00:57:28 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:next] BUILD REGRESSION
 303cdff39cdb1895a6d2b08e8946cc89feaf405c
Message-ID: <202603260011.j4APQxUV-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
branch HEAD: 303cdff39cdb1895a6d2b08e8946cc89feaf405c  Input: zinitix - use guard notation when acquiring mutex

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202603252030.fwSlmiBx-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202603252057.JgSqGyIe-lkp@intel.com

    drivers/input/touchscreen/mxs-lradc-ts.c:508:1: error: macro "class_spinlock_irqsave_constructor" passed 2 arguments, but takes just 1
    drivers/input/touchscreen/mxs-lradc-ts.c:508:3: error: initializing 'class_spinlock_irqsave_t' with an expression of incompatible type 'class_spinlock_irqsave_t (spinlock_t *)' (aka 'class_spinlock_irqsave_t (struct spinlock *)')
    drivers/input/touchscreen/mxs-lradc-ts.c:508:45: error: too many arguments provided to function-like macro invocation
    drivers/input/touchscreen/mxs-lradc-ts.c:508:8: error: macro "class_spinlock_irqsave_constructor" passed 2 arguments, but takes just 1
    drivers/input/touchscreen/mxs-lradc-ts.c:508:8: error: macro 'class_spinlock_irqsave_constructor' passed 2 arguments, but takes just 1
    include/linux/cleanup.h:300:17: error: invalid initializer
    include/linux/cleanup.h:303:17: error: invalid initializer
    include/linux/cleanup.h:303:3: error: invalid initializer

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- arc-allmodconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- arc-allyesconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- arm-allyesconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- arm-randconfig-003-20260325
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:initializing-class_spinlock_irqsave_t-with-an-expression-of-incompatible-type-class_spinlock_irqsave_t-(spinlock_t-)-(aka-class_spinlock_irqsave_t-(struc
|   `-- drivers-input-touchscreen-mxs-lradc-ts.c:error:too-many-arguments-provided-to-function-like-macro-invocation
|-- arm64-allmodconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:initializing-class_spinlock_irqsave_t-with-an-expression-of-incompatible-type-class_spinlock_irqsave_t-(spinlock_t-)-(aka-class_spinlock_irqsave_t-(struc
|   `-- drivers-input-touchscreen-mxs-lradc-ts.c:error:too-many-arguments-provided-to-function-like-macro-invocation
|-- arm64-randconfig-002-20260325
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- arm64-randconfig-r122-20260325
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- csky-allmodconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- csky-randconfig-002-20260325
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- hexagon-allmodconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:initializing-class_spinlock_irqsave_t-with-an-expression-of-incompatible-type-class_spinlock_irqsave_t-(spinlock_t-)-(aka-class_spinlock_irqsave_t-(struc
|   `-- drivers-input-touchscreen-mxs-lradc-ts.c:error:too-many-arguments-provided-to-function-like-macro-invocation
|-- i386-allmodconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- i386-allyesconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- i386-buildonly-randconfig-005-20260325
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:initializing-class_spinlock_irqsave_t-with-an-expression-of-incompatible-type-class_spinlock_irqsave_t-(spinlock_t-)-(aka-class_spinlock_irqsave_t-(struc
|   `-- drivers-input-touchscreen-mxs-lradc-ts.c:error:too-many-arguments-provided-to-function-like-macro-invocation
|-- loongarch-allmodconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:initializing-class_spinlock_irqsave_t-with-an-expression-of-incompatible-type-class_spinlock_irqsave_t-(spinlock_t-)-(aka-class_spinlock_irqsave_t-(struc
|   `-- drivers-input-touchscreen-mxs-lradc-ts.c:error:too-many-arguments-provided-to-function-like-macro-invocation
|-- loongarch-allyesconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:initializing-class_spinlock_irqsave_t-with-an-expression-of-incompatible-type-class_spinlock_irqsave_t-(spinlock_t-)-(aka-class_spinlock_irqsave_t-(struc
|   `-- drivers-input-touchscreen-mxs-lradc-ts.c:error:too-many-arguments-provided-to-function-like-macro-invocation
|-- loongarch-randconfig-002-20260325
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:initializing-class_spinlock_irqsave_t-with-an-expression-of-incompatible-type-class_spinlock_irqsave_t-(spinlock_t-)-(aka-class_spinlock_irqsave_t-(struc
|   `-- drivers-input-touchscreen-mxs-lradc-ts.c:error:too-many-arguments-provided-to-function-like-macro-invocation
|-- m68k-allmodconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- m68k-allyesconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- mips-allmodconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- mips-allyesconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- nios2-allmodconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- nios2-randconfig-r133-20260325
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- openrisc-allmodconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- openrisc-randconfig-r071-20260325
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- parisc-allmodconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- parisc-allyesconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- powerpc-allmodconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- powerpc-randconfig-002-20260325
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:initializing-class_spinlock_irqsave_t-with-an-expression-of-incompatible-type-class_spinlock_irqsave_t-(spinlock_t-)-(aka-class_spinlock_irqsave_t-(struc
|   `-- drivers-input-touchscreen-mxs-lradc-ts.c:error:too-many-arguments-provided-to-function-like-macro-invocation
|-- riscv-allmodconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:initializing-class_spinlock_irqsave_t-with-an-expression-of-incompatible-type-class_spinlock_irqsave_t-(spinlock_t-)-(aka-class_spinlock_irqsave_t-(struc
|   `-- drivers-input-touchscreen-mxs-lradc-ts.c:error:too-many-arguments-provided-to-function-like-macro-invocation
|-- riscv-allyesconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:initializing-class_spinlock_irqsave_t-with-an-expression-of-incompatible-type-class_spinlock_irqsave_t-(spinlock_t-)-(aka-class_spinlock_irqsave_t-(struc
|   `-- drivers-input-touchscreen-mxs-lradc-ts.c:error:too-many-arguments-provided-to-function-like-macro-invocation
|-- riscv-randconfig-001-20260325
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:initializing-class_spinlock_irqsave_t-with-an-expression-of-incompatible-type-class_spinlock_irqsave_t-(spinlock_t-)-(aka-class_spinlock_irqsave_t-(struc
|   `-- drivers-input-touchscreen-mxs-lradc-ts.c:error:too-many-arguments-provided-to-function-like-macro-invocation
|-- s390-allmodconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:initializing-class_spinlock_irqsave_t-with-an-expression-of-incompatible-type-class_spinlock_irqsave_t-(spinlock_t-)-(aka-class_spinlock_irqsave_t-(struc
|   `-- drivers-input-touchscreen-mxs-lradc-ts.c:error:too-many-arguments-provided-to-function-like-macro-invocation
|-- s390-allyesconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- sh-allmodconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- sh-allyesconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- sparc-randconfig-r134-20260325
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- sparc64-allmodconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:initializing-class_spinlock_irqsave_t-with-an-expression-of-incompatible-type-class_spinlock_irqsave_t-(spinlock_t-)-(aka-class_spinlock_irqsave_t-(struc
|   `-- drivers-input-touchscreen-mxs-lradc-ts.c:error:too-many-arguments-provided-to-function-like-macro-invocation
|-- um-allmodconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:initializing-class_spinlock_irqsave_t-with-an-expression-of-incompatible-type-class_spinlock_irqsave_t-(spinlock_t-)-(aka-class_spinlock_irqsave_t-(struc
|   `-- drivers-input-touchscreen-mxs-lradc-ts.c:error:too-many-arguments-provided-to-function-like-macro-invocation
|-- um-allyesconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
|   `-- include-linux-cleanup.h:error:invalid-initializer
|-- x86_64-allmodconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:initializing-class_spinlock_irqsave_t-with-an-expression-of-incompatible-type-class_spinlock_irqsave_t-(spinlock_t-)-(aka-class_spinlock_irqsave_t-(struc
|   `-- drivers-input-touchscreen-mxs-lradc-ts.c:error:too-many-arguments-provided-to-function-like-macro-invocation
|-- x86_64-allyesconfig
|   |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:initializing-class_spinlock_irqsave_t-with-an-expression-of-incompatible-type-class_spinlock_irqsave_t-(spinlock_t-)-(aka-class_spinlock_irqsave_t-(struc
|   `-- drivers-input-touchscreen-mxs-lradc-ts.c:error:too-many-arguments-provided-to-function-like-macro-invocation
`-- xtensa-allyesconfig
    |-- drivers-input-touchscreen-mxs-lradc-ts.c:error:macro-class_spinlock_irqsave_constructor-passed-arguments-but-takes-just
    `-- include-linux-cleanup.h:error:invalid-initializer

elapsed time: 740m

configs tested: 170
configs skipped: 2

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260325    gcc-8.5.0
arc                   randconfig-002-20260325    gcc-8.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                       netwinder_defconfig    gcc-15.2.0
arm                   randconfig-001-20260325    gcc-8.5.0
arm                   randconfig-002-20260325    gcc-8.5.0
arm                   randconfig-003-20260325    gcc-8.5.0
arm                   randconfig-004-20260325    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260325    clang-23
arm64                 randconfig-002-20260325    clang-23
arm64                 randconfig-003-20260325    clang-23
arm64                 randconfig-004-20260325    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260325    clang-23
csky                  randconfig-002-20260325    clang-23
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260325    gcc-11.5.0
hexagon               randconfig-002-20260325    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260325    gcc-14
i386        buildonly-randconfig-002-20260325    gcc-14
i386        buildonly-randconfig-003-20260325    gcc-14
i386        buildonly-randconfig-004-20260325    gcc-14
i386        buildonly-randconfig-005-20260325    gcc-14
i386        buildonly-randconfig-006-20260325    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260325    clang-20
i386                  randconfig-002-20260325    clang-20
i386                  randconfig-003-20260325    clang-20
i386                  randconfig-004-20260325    clang-20
i386                  randconfig-005-20260325    clang-20
i386                  randconfig-006-20260325    clang-20
i386                  randconfig-007-20260325    clang-20
i386                  randconfig-011-20260325    clang-20
i386                  randconfig-012-20260325    clang-20
i386                  randconfig-013-20260325    clang-20
i386                  randconfig-014-20260325    clang-20
i386                  randconfig-015-20260325    clang-20
i386                  randconfig-016-20260325    clang-20
i386                  randconfig-017-20260325    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260325    gcc-11.5.0
loongarch             randconfig-002-20260325    gcc-11.5.0
m68k                             alldefconfig    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260325    gcc-11.5.0
nios2                 randconfig-002-20260325    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
openrisc                       virt_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260325    clang-23
parisc                randconfig-002-20260325    clang-23
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260325    clang-23
powerpc               randconfig-002-20260325    clang-23
powerpc64             randconfig-001-20260325    clang-23
powerpc64             randconfig-002-20260325    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260325    gcc-8.5.0
riscv                 randconfig-002-20260325    gcc-8.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260325    gcc-8.5.0
s390                  randconfig-002-20260325    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260325    gcc-8.5.0
sh                    randconfig-002-20260325    gcc-8.5.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260325    gcc-13
sparc                 randconfig-002-20260325    gcc-13
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260325    gcc-13
sparc64               randconfig-002-20260325    gcc-13
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260325    gcc-13
um                    randconfig-002-20260325    gcc-13
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260325    gcc-14
x86_64      buildonly-randconfig-002-20260325    gcc-14
x86_64      buildonly-randconfig-003-20260325    gcc-14
x86_64      buildonly-randconfig-004-20260325    gcc-14
x86_64      buildonly-randconfig-005-20260325    gcc-14
x86_64      buildonly-randconfig-006-20260325    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260325    gcc-12
x86_64                randconfig-002-20260325    gcc-12
x86_64                randconfig-003-20260325    gcc-12
x86_64                randconfig-004-20260325    gcc-12
x86_64                randconfig-005-20260325    gcc-12
x86_64                randconfig-006-20260325    gcc-12
x86_64                randconfig-011-20260325    clang-20
x86_64                randconfig-012-20260325    clang-20
x86_64                randconfig-013-20260325    clang-20
x86_64                randconfig-014-20260325    clang-20
x86_64                randconfig-015-20260325    clang-20
x86_64                randconfig-016-20260325    clang-20
x86_64                randconfig-071-20260325    gcc-14
x86_64                randconfig-072-20260325    gcc-14
x86_64                randconfig-073-20260325    gcc-14
x86_64                randconfig-074-20260325    gcc-14
x86_64                randconfig-075-20260325    gcc-14
x86_64                randconfig-076-20260325    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260325    gcc-13
xtensa                randconfig-002-20260325    gcc-13

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
