Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCBD1A5B84
	for <linux-input@vger.kernel.org>; Sun,  1 Feb 2026 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769977572; cv=none; b=dRWDU5+4XOZztD+r932mRVfG/OoKdisUe4j/Z7J2A6II9w28HpJ43fWtGfXkgvjeQT7oYse3WlNkt73Ewy7fXgw1ob+j+njKB7/dqHWLHO6iyYFKlKb2HOw7LG2QPp13f2HuhNwUdS6zWgIeu6U5PA5uZCmX/0USUW9bwivRmmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769977572; c=relaxed/simple;
	bh=MWOl8BfXm3KsqUC54xHZZMITX6NOUui+Ujp2S8S543c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nMAdQdZE7jtEXdq2FspRF/ai1tV0HmWM7pBzUeOOoIfO5TiIetyi+o32JX8ViRRu3DETD8DRbidy2STq5PTj806fkp42MN/w2uvSbROnBgBXjIyKCF2keKYKWVMmNKgsMHlsMEPswJlwaDI6uG8jAzZjYSba3Eyn+PUVpM//1Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AIVFQV2j; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AIVFQV2j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769977570; x=1801513570;
  h=date:from:to:cc:subject:message-id;
  bh=MWOl8BfXm3KsqUC54xHZZMITX6NOUui+Ujp2S8S543c=;
  b=AIVFQV2jGFII8sdC0hef4QL+QVaarFVAYXec0/+yoyC7ThWuPE6j9+vg
   lWOCswuMUByEO8uteBv97ZhHvrEvmRkr50EeXpFdq9x3j5htxFBwPxP4W
   TS9b5MVKED0ESXYzL+b6mITcwrXfwXYF6qyzPFqHNKkHYdztRhQzLksZf
   L3gNdmf897nXMirkUDM2r5unf7gI94aG01Z2mWRKi9krLo89OlpzUN3Lo
   rlJMFyDUPglGQQbsaq/QH5TUCUqEpy5NxkjcyEXEWEGeXKzfyZDWYwsJO
   84vrqDhwfLiXvzJ517jUHRa7uIer4A7HokV/IiMJulcbMpVwgCHPgtFFG
   g==;
X-CSE-ConnectionGUID: Aw3fpcs9R0usXSgee1LsBA==
X-CSE-MsgGUID: QwwruYNKQruqltJl2FrXMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="58730065"
X-IronPort-AV: E=Sophos;i="6.21,267,1763452800"; 
   d="scan'208";a="58730065"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2026 12:26:10 -0800
X-CSE-ConnectionGUID: ZtHFjmdfQTubG43O7mWxeQ==
X-CSE-MsgGUID: 3nz8b10TR3qNFQGvbWggWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,267,1763452800"; 
   d="scan'208";a="209416389"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 01 Feb 2026 12:26:09 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vme1G-00000000f1u-0Czr;
	Sun, 01 Feb 2026 20:26:06 +0000
Date: Mon, 02 Feb 2026 04:25:15 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:next] BUILD SUCCESS
 ed8a4ef29da3821ee3155d3b1925fa67fc92aae2
Message-ID: <202602020406.WI7Nr2fD-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
branch HEAD: ed8a4ef29da3821ee3155d3b1925fa67fc92aae2  Input: gpio_keys - fall back to platform_get_irq() for interrupt-only keys

elapsed time: 726m

configs tested: 293
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260201    gcc-10.5.0
arc                   randconfig-001-20260201    gcc-14.3.0
arc                   randconfig-001-20260202    gcc-14.3.0
arc                   randconfig-002-20260201    gcc-10.5.0
arc                   randconfig-002-20260202    gcc-14.3.0
arc                           tb10x_defconfig    clang-22
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                         lpc18xx_defconfig    clang-22
arm                         mv78xx0_defconfig    clang-22
arm                        mvebu_v5_defconfig    clang-22
arm                        mvebu_v7_defconfig    gcc-15.2.0
arm                   randconfig-001-20260201    gcc-10.5.0
arm                   randconfig-001-20260201    gcc-8.5.0
arm                   randconfig-001-20260202    gcc-14.3.0
arm                   randconfig-002-20260201    clang-22
arm                   randconfig-002-20260201    gcc-10.5.0
arm                   randconfig-002-20260202    gcc-14.3.0
arm                   randconfig-003-20260201    gcc-10.5.0
arm                   randconfig-003-20260201    gcc-8.5.0
arm                   randconfig-003-20260202    gcc-14.3.0
arm                   randconfig-004-20260201    clang-22
arm                   randconfig-004-20260201    gcc-10.5.0
arm                   randconfig-004-20260202    gcc-14.3.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260201    gcc-13.4.0
arm64                 randconfig-001-20260201    gcc-15.2.0
arm64                 randconfig-001-20260202    gcc-9.5.0
arm64                 randconfig-002-20260201    clang-20
arm64                 randconfig-002-20260201    gcc-15.2.0
arm64                 randconfig-002-20260202    gcc-9.5.0
arm64                 randconfig-003-20260201    gcc-15.2.0
arm64                 randconfig-003-20260201    gcc-8.5.0
arm64                 randconfig-003-20260202    gcc-9.5.0
arm64                 randconfig-004-20260201    gcc-12.5.0
arm64                 randconfig-004-20260201    gcc-15.2.0
arm64                 randconfig-004-20260202    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260201    gcc-11.5.0
csky                  randconfig-001-20260201    gcc-15.2.0
csky                  randconfig-001-20260202    gcc-9.5.0
csky                  randconfig-002-20260201    gcc-15.2.0
csky                  randconfig-002-20260202    gcc-9.5.0
hexagon                          alldefconfig    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260201    clang-22
hexagon               randconfig-001-20260201    gcc-15.2.0
hexagon               randconfig-001-20260202    clang-19
hexagon               randconfig-002-20260201    clang-22
hexagon               randconfig-002-20260201    gcc-15.2.0
hexagon               randconfig-002-20260202    clang-19
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260201    clang-20
i386        buildonly-randconfig-001-20260201    gcc-14
i386        buildonly-randconfig-002-20260201    clang-20
i386        buildonly-randconfig-003-20260201    clang-20
i386        buildonly-randconfig-003-20260201    gcc-14
i386        buildonly-randconfig-004-20260201    clang-20
i386        buildonly-randconfig-005-20260201    clang-20
i386        buildonly-randconfig-005-20260201    gcc-13
i386        buildonly-randconfig-006-20260201    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260201    clang-20
i386                  randconfig-002-20260201    clang-20
i386                  randconfig-003-20260201    clang-20
i386                  randconfig-004-20260201    clang-20
i386                  randconfig-005-20260201    clang-20
i386                  randconfig-006-20260201    clang-20
i386                  randconfig-007-20260201    clang-20
i386                  randconfig-011-20260201    gcc-14
i386                  randconfig-012-20260201    gcc-14
i386                  randconfig-013-20260201    gcc-14
i386                  randconfig-014-20260201    gcc-14
i386                  randconfig-015-20260201    gcc-14
i386                  randconfig-016-20260201    gcc-14
i386                  randconfig-017-20260201    gcc-14
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260201    clang-22
loongarch             randconfig-001-20260201    gcc-15.2.0
loongarch             randconfig-001-20260202    clang-19
loongarch             randconfig-002-20260201    gcc-15.2.0
loongarch             randconfig-002-20260202    clang-19
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                        m5407c3_defconfig    clang-22
m68k                       m5475evb_defconfig    clang-22
microblaze                       alldefconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          ath25_defconfig    clang-22
mips                  cavium_octeon_defconfig    gcc-15.2.0
mips                         db1xxx_defconfig    gcc-15.2.0
mips                  decstation_64_defconfig    gcc-15.2.0
mips                           ip30_defconfig    clang-22
mips                malta_qemu_32r6_defconfig    gcc-15.2.0
mips                      maltaaprp_defconfig    clang-22
mips                      maltasmvp_defconfig    gcc-15.2.0
mips                        maltaup_defconfig    clang-22
mips                        vocore2_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260201    gcc-10.5.0
nios2                 randconfig-001-20260201    gcc-15.2.0
nios2                 randconfig-001-20260202    clang-19
nios2                 randconfig-002-20260201    gcc-15.2.0
nios2                 randconfig-002-20260201    gcc-9.5.0
nios2                 randconfig-002-20260202    clang-19
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260201    gcc-14.3.0
parisc                randconfig-001-20260202    gcc-8.5.0
parisc                randconfig-002-20260201    gcc-14.3.0
parisc                randconfig-002-20260202    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      ep88xc_defconfig    clang-22
powerpc                   lite5200b_defconfig    gcc-15.2.0
powerpc                     powernv_defconfig    gcc-15.2.0
powerpc                      ppc6xx_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260201    gcc-14.3.0
powerpc               randconfig-001-20260202    gcc-8.5.0
powerpc               randconfig-002-20260201    gcc-14.3.0
powerpc               randconfig-002-20260202    gcc-8.5.0
powerpc                     skiroot_defconfig    gcc-15.2.0
powerpc                     tqm8560_defconfig    clang-22
powerpc64             randconfig-001-20260201    gcc-14.3.0
powerpc64             randconfig-001-20260202    gcc-8.5.0
powerpc64             randconfig-002-20260201    gcc-14.3.0
powerpc64             randconfig-002-20260202    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260201    clang-22
riscv                 randconfig-001-20260201    gcc-13.4.0
riscv                 randconfig-002-20260201    gcc-13.4.0
riscv                 randconfig-002-20260201    gcc-8.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260201    gcc-13.4.0
s390                  randconfig-002-20260201    gcc-12.5.0
s390                  randconfig-002-20260201    gcc-13.4.0
s390                       zfcpdump_defconfig    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                            migor_defconfig    clang-22
sh                    randconfig-001-20260201    gcc-11.5.0
sh                    randconfig-001-20260201    gcc-13.4.0
sh                    randconfig-002-20260201    gcc-13.4.0
sh                          sdk7780_defconfig    gcc-15.2.0
sh                     sh7710voipgw_defconfig    clang-22
sh                        sh7763rdp_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260201    gcc-8.5.0
sparc                 randconfig-001-20260202    gcc-12.5.0
sparc                 randconfig-002-20260201    gcc-8.5.0
sparc                 randconfig-002-20260202    gcc-12.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260201    gcc-8.5.0
sparc64               randconfig-001-20260202    gcc-12.5.0
sparc64               randconfig-002-20260201    gcc-8.5.0
sparc64               randconfig-002-20260202    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260201    gcc-8.5.0
um                    randconfig-001-20260202    gcc-12.5.0
um                    randconfig-002-20260201    gcc-8.5.0
um                    randconfig-002-20260202    gcc-12.5.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260201    clang-20
x86_64      buildonly-randconfig-002-20260201    clang-20
x86_64      buildonly-randconfig-003-20260201    clang-20
x86_64      buildonly-randconfig-004-20260201    clang-20
x86_64      buildonly-randconfig-004-20260201    gcc-14
x86_64      buildonly-randconfig-005-20260201    clang-20
x86_64      buildonly-randconfig-006-20260201    clang-20
x86_64      buildonly-randconfig-006-20260201    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260201    gcc-14
x86_64                randconfig-002-20260201    gcc-14
x86_64                randconfig-003-20260201    gcc-14
x86_64                randconfig-004-20260201    gcc-14
x86_64                randconfig-005-20260201    gcc-14
x86_64                randconfig-006-20260201    gcc-14
x86_64                randconfig-011-20260201    gcc-14
x86_64                randconfig-011-20260202    gcc-14
x86_64                randconfig-012-20260201    gcc-14
x86_64                randconfig-012-20260202    gcc-14
x86_64                randconfig-013-20260201    gcc-14
x86_64                randconfig-013-20260202    gcc-14
x86_64                randconfig-014-20260201    gcc-14
x86_64                randconfig-014-20260202    gcc-14
x86_64                randconfig-015-20260201    gcc-14
x86_64                randconfig-015-20260202    gcc-14
x86_64                randconfig-016-20260201    gcc-14
x86_64                randconfig-016-20260202    gcc-14
x86_64                randconfig-071-20260201    gcc-14
x86_64                randconfig-072-20260201    gcc-14
x86_64                randconfig-073-20260201    gcc-14
x86_64                randconfig-074-20260201    gcc-14
x86_64                randconfig-075-20260201    gcc-14
x86_64                randconfig-076-20260201    gcc-14
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
xtensa                           allyesconfig    gcc-15.2.0
xtensa                generic_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260201    gcc-8.5.0
xtensa                randconfig-001-20260202    gcc-12.5.0
xtensa                randconfig-002-20260201    gcc-8.5.0
xtensa                randconfig-002-20260202    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
