Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59FF3A5C18
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769116292; cv=none; b=aIOpA2KqKliIo9AmJQp/wLEjaQJ/BCLiZAsufJozWTFwFwOXMwATDpMQxN8CoLWaVVyDYvjRYFh6TlU95CATMUeqD6/CvCA1s2xrFgi7AhjitoCboqG7jJvGQS2yXfKQVVnEEfKGTqJooJ1yBncgnf57K2FDpuqGZw7gliJyUk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769116292; c=relaxed/simple;
	bh=kzAiMrKN0iTW9P9C1+TCrjpbbBTVb7gVkG62teFUNjA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aCwFwKAPdHNRQsb8e5PF5V4sWnYTjAILbwUj+2xj12ktOE07hL8da9+ZUvT1JsqyFj63j0e/B0LI34BlLYb8SrDbFf7JYMxLwoI2sKoeG2YYek19Exvsqsk3xWdaamd/Va8h+pir6TJ6B3UXVqhdMJmei4u+XgXp1XXUugOFU2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UyQtfm54; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UyQtfm54"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769116287; x=1800652287;
  h=date:from:to:cc:subject:message-id;
  bh=kzAiMrKN0iTW9P9C1+TCrjpbbBTVb7gVkG62teFUNjA=;
  b=UyQtfm54T22MGgOZ11irNnTZUkeXUKT8JsQ8shmiL8J//x3lim9Z2Gn3
   JT1bFZMYyBZ5WOTsdZlHIgHtc85FBEDJ557GPcGBTsZZ8NBnLStObcJfx
   SBLGHOrbLFEl0LxnGNBNTQH/vFsJgliVuAKMvcBcU/Wed5vb6nymRJ7x+
   24a5mmSxUrmJJvW96DNsNl3zPhjHqykWv+h+IjrwyAvAPjGXSyxo4xYyy
   wPgIDtim+u0CbUVqfbiDslNrI73iz936nfO+VUQwyY3mW0/zU7MptDp6F
   rgxUGqaXVRA6Y9VbeuYrjIS7Iqkd/5HRqQhlazEgfBetH6wWXt4Jmr9LH
   Q==;
X-CSE-ConnectionGUID: BxA1zBRST+eQnLL1kpwiig==
X-CSE-MsgGUID: jx712pXATnarBcsOUgHwpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="87946872"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="87946872"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 13:11:22 -0800
X-CSE-ConnectionGUID: dtJi4uyJTVuu82Isc9fSow==
X-CSE-MsgGUID: YRgry0CSQXmTu+qyZj5vNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="206895732"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 22 Jan 2026 13:11:21 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vj1xW-00000000TF8-0pGg;
	Thu, 22 Jan 2026 21:11:18 +0000
Date: Fri, 23 Jan 2026 05:10:43 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:next] BUILD SUCCESS
 8a8e63fedbe433b888143fcb7ff55b7a87fa3163
Message-ID: <202601230538.vyJ0Y54N-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
branch HEAD: 8a8e63fedbe433b888143fcb7ff55b7a87fa3163  Input: appletouch - fix potential race between resume and open

elapsed time: 1319m

configs tested: 289
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                     nsimosci_hs_defconfig    gcc-15.2.0
arc                   randconfig-001-20260122    gcc-15.2.0
arc                   randconfig-001-20260123    gcc-10.5.0
arc                   randconfig-002-20260122    gcc-15.2.0
arc                   randconfig-002-20260123    gcc-10.5.0
arc                           tb10x_defconfig    gcc-15.2.0
arc                    vdk_hs38_smp_defconfig    gcc-15.2.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                          gemini_defconfig    clang-22
arm                            mmp2_defconfig    clang-22
arm                         mv78xx0_defconfig    gcc-15.2.0
arm                         nhk8815_defconfig    clang-22
arm                           omap1_defconfig    clang-22
arm                          pxa910_defconfig    gcc-15.2.0
arm                   randconfig-001-20260122    gcc-15.2.0
arm                   randconfig-001-20260123    gcc-10.5.0
arm                   randconfig-002-20260122    gcc-15.2.0
arm                   randconfig-002-20260123    gcc-10.5.0
arm                   randconfig-003-20260122    gcc-15.2.0
arm                   randconfig-003-20260123    gcc-10.5.0
arm                   randconfig-004-20260122    gcc-15.2.0
arm                   randconfig-004-20260123    gcc-10.5.0
arm                           sama7_defconfig    clang-22
arm                       versatile_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260122    gcc-15.2.0
arm64                 randconfig-001-20260123    gcc-15.2.0
arm64                 randconfig-002-20260122    gcc-15.2.0
arm64                 randconfig-002-20260123    gcc-15.2.0
arm64                 randconfig-003-20260122    gcc-15.2.0
arm64                 randconfig-003-20260123    gcc-15.2.0
arm64                 randconfig-004-20260122    gcc-15.2.0
arm64                 randconfig-004-20260123    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260122    gcc-15.2.0
csky                  randconfig-001-20260123    gcc-15.2.0
csky                  randconfig-002-20260122    gcc-15.2.0
csky                  randconfig-002-20260123    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260122    gcc-15.2.0
hexagon               randconfig-001-20260123    gcc-12.5.0
hexagon               randconfig-002-20260122    gcc-15.2.0
hexagon               randconfig-002-20260123    gcc-12.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260122    clang-20
i386        buildonly-randconfig-001-20260123    clang-20
i386        buildonly-randconfig-002-20260122    clang-20
i386        buildonly-randconfig-002-20260123    clang-20
i386        buildonly-randconfig-003-20260122    clang-20
i386        buildonly-randconfig-003-20260123    clang-20
i386        buildonly-randconfig-004-20260122    clang-20
i386        buildonly-randconfig-004-20260123    clang-20
i386        buildonly-randconfig-005-20260122    clang-20
i386        buildonly-randconfig-005-20260123    clang-20
i386        buildonly-randconfig-006-20260122    clang-20
i386        buildonly-randconfig-006-20260123    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260122    gcc-14
i386                  randconfig-002-20260122    gcc-14
i386                  randconfig-003-20260122    gcc-14
i386                  randconfig-004-20260122    gcc-14
i386                  randconfig-005-20260122    gcc-14
i386                  randconfig-006-20260122    gcc-14
i386                  randconfig-007-20260122    gcc-14
i386                  randconfig-011-20260122    clang-20
i386                  randconfig-011-20260123    clang-20
i386                  randconfig-012-20260122    clang-20
i386                  randconfig-012-20260123    clang-20
i386                  randconfig-013-20260122    clang-20
i386                  randconfig-013-20260123    clang-20
i386                  randconfig-014-20260122    clang-20
i386                  randconfig-014-20260123    clang-20
i386                  randconfig-015-20260122    clang-20
i386                  randconfig-015-20260123    clang-20
i386                  randconfig-016-20260122    clang-20
i386                  randconfig-016-20260123    clang-20
i386                  randconfig-017-20260122    clang-20
i386                  randconfig-017-20260123    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260122    gcc-15.2.0
loongarch             randconfig-001-20260123    gcc-12.5.0
loongarch             randconfig-002-20260122    gcc-15.2.0
loongarch             randconfig-002-20260123    gcc-12.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                          amiga_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                       m5275evb_defconfig    clang-22
m68k                        mvme147_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          ath25_defconfig    clang-22
mips                     cu1000-neo_defconfig    gcc-15.2.0
mips                     cu1830-neo_defconfig    gcc-15.2.0
mips                     decstation_defconfig    gcc-15.2.0
mips                          eyeq5_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260122    gcc-15.2.0
nios2                 randconfig-001-20260123    gcc-12.5.0
nios2                 randconfig-002-20260122    gcc-15.2.0
nios2                 randconfig-002-20260123    gcc-12.5.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           alldefconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260122    gcc-10.5.0
parisc                randconfig-001-20260123    gcc-12.5.0
parisc                randconfig-002-20260122    gcc-10.5.0
parisc                randconfig-002-20260123    gcc-12.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                       eiger_defconfig    gcc-15.2.0
powerpc                        fsp2_defconfig    gcc-15.2.0
powerpc                   lite5200b_defconfig    gcc-15.2.0
powerpc                     mpc5200_defconfig    clang-22
powerpc                 mpc834x_itx_defconfig    gcc-15.2.0
powerpc                     powernv_defconfig    clang-22
powerpc                         ps3_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260122    gcc-10.5.0
powerpc               randconfig-001-20260123    gcc-12.5.0
powerpc               randconfig-002-20260122    gcc-10.5.0
powerpc               randconfig-002-20260123    gcc-12.5.0
powerpc                     tqm8541_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260122    gcc-10.5.0
powerpc64             randconfig-001-20260123    gcc-12.5.0
powerpc64             randconfig-002-20260122    gcc-10.5.0
powerpc64             randconfig-002-20260123    gcc-12.5.0
riscv                            alldefconfig    gcc-15.2.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260122    clang-18
riscv                 randconfig-001-20260123    clang-22
riscv                 randconfig-002-20260122    clang-18
riscv                 randconfig-002-20260123    clang-22
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260122    clang-18
s390                  randconfig-001-20260123    clang-22
s390                  randconfig-002-20260122    clang-18
s390                  randconfig-002-20260123    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                        dreamcast_defconfig    gcc-15.2.0
sh                          r7780mp_defconfig    clang-22
sh                    randconfig-001-20260122    clang-18
sh                    randconfig-001-20260123    clang-22
sh                    randconfig-002-20260122    clang-18
sh                    randconfig-002-20260123    clang-22
sh                          sdk7786_defconfig    clang-22
sh                           se7206_defconfig    clang-22
sh                           se7343_defconfig    gcc-15.2.0
sh                           se7721_defconfig    gcc-15.2.0
sh                             sh03_defconfig    clang-22
sh                   sh7724_generic_defconfig    gcc-15.2.0
sparc                            alldefconfig    clang-22
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260122    gcc-8.5.0
sparc                 randconfig-001-20260123    gcc-13.4.0
sparc                 randconfig-002-20260122    gcc-8.5.0
sparc                 randconfig-002-20260123    gcc-13.4.0
sparc64                          alldefconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260122    gcc-8.5.0
sparc64               randconfig-001-20260123    gcc-13.4.0
sparc64               randconfig-002-20260122    gcc-8.5.0
sparc64               randconfig-002-20260123    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260122    gcc-8.5.0
um                    randconfig-001-20260123    gcc-13.4.0
um                    randconfig-002-20260122    gcc-8.5.0
um                    randconfig-002-20260123    gcc-13.4.0
um                           x86_64_defconfig    gcc-14
x86_64                           alldefconfig    gcc-15.2.0
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260122    clang-20
x86_64      buildonly-randconfig-002-20260122    clang-20
x86_64      buildonly-randconfig-003-20260122    clang-20
x86_64      buildonly-randconfig-004-20260122    clang-20
x86_64      buildonly-randconfig-005-20260122    clang-20
x86_64      buildonly-randconfig-006-20260122    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260122    clang-20
x86_64                randconfig-002-20260122    clang-20
x86_64                randconfig-003-20260122    clang-20
x86_64                randconfig-004-20260122    clang-20
x86_64                randconfig-005-20260122    clang-20
x86_64                randconfig-006-20260122    clang-20
x86_64                randconfig-011-20260122    clang-20
x86_64                randconfig-011-20260123    gcc-14
x86_64                randconfig-012-20260122    clang-20
x86_64                randconfig-012-20260123    gcc-14
x86_64                randconfig-013-20260122    clang-20
x86_64                randconfig-013-20260123    gcc-14
x86_64                randconfig-014-20260122    clang-20
x86_64                randconfig-014-20260123    gcc-14
x86_64                randconfig-015-20260122    clang-20
x86_64                randconfig-015-20260123    gcc-14
x86_64                randconfig-016-20260122    clang-20
x86_64                randconfig-016-20260123    gcc-14
x86_64                randconfig-071-20260122    clang-20
x86_64                randconfig-072-20260122    clang-20
x86_64                randconfig-073-20260122    clang-20
x86_64                randconfig-074-20260122    clang-20
x86_64                randconfig-075-20260122    clang-20
x86_64                randconfig-076-20260122    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                  cadence_csp_defconfig    gcc-15.2.0
xtensa                          iss_defconfig    gcc-15.2.0
xtensa                  nommu_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260122    gcc-8.5.0
xtensa                randconfig-001-20260123    gcc-13.4.0
xtensa                randconfig-002-20260122    gcc-8.5.0
xtensa                randconfig-002-20260123    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
