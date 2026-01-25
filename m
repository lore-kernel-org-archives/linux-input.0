Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CD63EBF09
	for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769375041; cv=none; b=kS91v3Rj0y1ApwxkMRVQ+mxRWbfK8TiTThj2tzWGrfPKCuDUO+XRQle7i/auVKOr5LY29mNSBKWHBqKv1Ca6fk8PxRsH1rROHwaNMlD34eUAqBMhYL05BwjjO89uAY8MukdpskVSd8a9XR/5kXT5UG/szqvNa4AkEAPOXE3u4LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769375041; c=relaxed/simple;
	bh=0WSA8IyHuwCNdXPCpw9PJ/O/Ip5ZyAkhHFfA9PAFP/g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=G26ou1JEpS3WEXEG4GiK32Q9MjQWbfEJ9gT/6mULM02vwKA9msvwwDiJXZGIsOXacCze+mR4ZLzUmxEB296RGIlU3boaetW0okleJebHoS8N8U9OL+KO2cOSBxKFCBMn8rvEumWdxIBvNXyTh/9Gx88RLytJrj4MHpvgz6xq3xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ko8TZs5f; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ko8TZs5f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769375039; x=1800911039;
  h=date:from:to:cc:subject:message-id;
  bh=0WSA8IyHuwCNdXPCpw9PJ/O/Ip5ZyAkhHFfA9PAFP/g=;
  b=Ko8TZs5fjpdc+C6V0z+4ArnnYha1vRfOZcOmK2mNS5u2Mqt4QpPwyyCm
   cHiVAtaCYpCFMWkO3Z0WTb55zOcK376sbRllr4Iw0UhMEMsM/Ygp1811W
   gJRLTIjEK+xVI27unMZwdykToBH1jkdyTFeBpmOkmNEkSqPhfa7UuLjq1
   RJL34yp+XUeDYzOdx+a50pi5IR3HcBV40CUhiAde55t4LNHbYGWl4E6qN
   WhTz9xfa8oD7UBBnI9pyQZJqX/qbBJhIrYeI2Pl4wnQwKo9r0WKOoDKpf
   l3sI5XSfu/JFsZzYc8nFA/CHfMNoi3Xed9/xqTKoeoUdbiXFAk52dodrG
   A==;
X-CSE-ConnectionGUID: 8Dyh+KY9TM6WZXezCNrgVg==
X-CSE-MsgGUID: ivav0piWQw6PLzzhlZUIpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="73145832"
X-IronPort-AV: E=Sophos;i="6.21,253,1763452800"; 
   d="scan'208";a="73145832"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2026 13:03:58 -0800
X-CSE-ConnectionGUID: Cv1tY/CQTvWGu2ii6vg7vw==
X-CSE-MsgGUID: zhxoJLMoS6KOtGOD5BzUfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,253,1763452800"; 
   d="scan'208";a="207332295"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 25 Jan 2026 13:03:56 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vk7Gz-00000000WfG-2jsM;
	Sun, 25 Jan 2026 21:03:53 +0000
Date: Mon, 26 Jan 2026 05:03:45 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:for-linus] BUILD SUCCESS
 19a5d9ba6208e9006a2a9d5962aea4d6e427d8ab
Message-ID: <202601260540.ynneoBts-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
branch HEAD: 19a5d9ba6208e9006a2a9d5962aea4d6e427d8ab  Input: i8042 - add quirks for MECHREVO Wujie 15X Pro

elapsed time: 890m

configs tested: 295
configs skipped: 5

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
arc                   randconfig-001-20260125    gcc-10.5.0
arc                   randconfig-001-20260126    gcc-10.5.0
arc                   randconfig-002-20260125    gcc-10.5.0
arc                   randconfig-002-20260126    gcc-10.5.0
arc                        vdk_hs38_defconfig    gcc-15.2.0
arm                              alldefconfig    gcc-15.2.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                       imx_v6_v7_defconfig    gcc-11.5.0
arm                        multi_v5_defconfig    gcc-15.2.0
arm                        multi_v7_defconfig    gcc-15.2.0
arm                         orion5x_defconfig    gcc-15.2.0
arm                          pxa168_defconfig    clang-22
arm                   randconfig-001-20260125    gcc-10.5.0
arm                   randconfig-001-20260126    gcc-10.5.0
arm                   randconfig-002-20260125    gcc-10.5.0
arm                   randconfig-002-20260126    gcc-10.5.0
arm                   randconfig-003-20260125    gcc-10.5.0
arm                   randconfig-003-20260126    gcc-10.5.0
arm                   randconfig-004-20260125    gcc-10.5.0
arm                   randconfig-004-20260126    gcc-10.5.0
arm                        shmobile_defconfig    gcc-11.5.0
arm                          sp7021_defconfig    clang-22
arm                        spear3xx_defconfig    gcc-15.2.0
arm                           spitz_defconfig    gcc-15.2.0
arm                         wpcm450_defconfig    gcc-11.5.0
arm                         wpcm450_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260125    gcc-11.5.0
arm64                 randconfig-001-20260126    gcc-15.2.0
arm64                 randconfig-002-20260125    gcc-11.5.0
arm64                 randconfig-002-20260126    gcc-15.2.0
arm64                 randconfig-003-20260125    gcc-11.5.0
arm64                 randconfig-003-20260126    gcc-15.2.0
arm64                 randconfig-004-20260125    gcc-11.5.0
arm64                 randconfig-004-20260126    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260125    gcc-11.5.0
csky                  randconfig-001-20260126    gcc-15.2.0
csky                  randconfig-002-20260125    gcc-11.5.0
csky                  randconfig-002-20260126    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260125    clang-22
hexagon               randconfig-001-20260126    gcc-15.2.0
hexagon               randconfig-002-20260125    clang-20
hexagon               randconfig-002-20260125    clang-22
hexagon               randconfig-002-20260126    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260125    gcc-14
i386        buildonly-randconfig-001-20260126    clang-20
i386        buildonly-randconfig-002-20260125    gcc-14
i386        buildonly-randconfig-002-20260126    clang-20
i386        buildonly-randconfig-003-20260125    gcc-14
i386        buildonly-randconfig-003-20260126    clang-20
i386        buildonly-randconfig-004-20260125    gcc-14
i386        buildonly-randconfig-004-20260126    clang-20
i386        buildonly-randconfig-005-20260125    gcc-14
i386        buildonly-randconfig-005-20260126    clang-20
i386        buildonly-randconfig-006-20260125    gcc-14
i386        buildonly-randconfig-006-20260126    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260125    clang-20
i386                  randconfig-002-20260125    clang-20
i386                  randconfig-003-20260125    clang-20
i386                  randconfig-004-20260125    clang-20
i386                  randconfig-005-20260125    clang-20
i386                  randconfig-006-20260125    clang-20
i386                  randconfig-007-20260125    clang-20
i386                  randconfig-011-20260125    gcc-14
i386                  randconfig-012-20260125    gcc-14
i386                  randconfig-013-20260125    gcc-14
i386                  randconfig-014-20260125    gcc-14
i386                  randconfig-015-20260125    gcc-14
i386                  randconfig-016-20260125    gcc-14
i386                  randconfig-017-20260125    gcc-14
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260125    clang-22
loongarch             randconfig-001-20260126    gcc-15.2.0
loongarch             randconfig-002-20260125    clang-22
loongarch             randconfig-002-20260125    gcc-14.3.0
loongarch             randconfig-002-20260126    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    gcc-15.2.0
m68k                        m5407c3_defconfig    gcc-11.5.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                      mmu_defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                         bigsur_defconfig    clang-22
mips                     cu1000-neo_defconfig    gcc-15.2.0
mips                      fuloong2e_defconfig    gcc-15.2.0
mips                     loongson2k_defconfig    gcc-15.2.0
mips                           mtx1_defconfig    clang-22
nios2                         3c120_defconfig    gcc-11.5.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260125    clang-22
nios2                 randconfig-001-20260125    gcc-8.5.0
nios2                 randconfig-001-20260126    gcc-15.2.0
nios2                 randconfig-002-20260125    clang-22
nios2                 randconfig-002-20260125    gcc-8.5.0
nios2                 randconfig-002-20260126    gcc-15.2.0
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
parisc                generic-32bit_defconfig    gcc-15.2.0
parisc                randconfig-001-20260125    gcc-8.5.0
parisc                randconfig-001-20260126    gcc-8.5.0
parisc                randconfig-002-20260125    gcc-8.5.0
parisc                randconfig-002-20260126    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                     ep8248e_defconfig    clang-22
powerpc                      ep88xc_defconfig    gcc-11.5.0
powerpc                  iss476-smp_defconfig    clang-22
powerpc                 mpc836x_rdk_defconfig    clang-22
powerpc               randconfig-001-20260125    clang-22
powerpc               randconfig-001-20260125    gcc-8.5.0
powerpc               randconfig-001-20260126    gcc-8.5.0
powerpc               randconfig-002-20260125    clang-22
powerpc               randconfig-002-20260125    gcc-8.5.0
powerpc               randconfig-002-20260126    gcc-8.5.0
powerpc                     redwood_defconfig    gcc-11.5.0
powerpc                    socrates_defconfig    gcc-15.2.0
powerpc                  storcenter_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260125    gcc-12.5.0
powerpc64             randconfig-001-20260125    gcc-8.5.0
powerpc64             randconfig-001-20260126    gcc-8.5.0
powerpc64             randconfig-002-20260125    clang-17
powerpc64             randconfig-002-20260125    gcc-8.5.0
powerpc64             randconfig-002-20260126    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260125    clang-22
riscv                 randconfig-001-20260126    gcc-9.5.0
riscv                 randconfig-002-20260125    clang-16
riscv                 randconfig-002-20260125    clang-22
riscv                 randconfig-002-20260126    gcc-9.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                          debug_defconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260125    clang-22
s390                  randconfig-001-20260125    gcc-11.5.0
s390                  randconfig-001-20260126    gcc-9.5.0
s390                  randconfig-002-20260125    clang-22
s390                  randconfig-002-20260125    gcc-9.5.0
s390                  randconfig-002-20260126    gcc-9.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260125    clang-22
sh                    randconfig-001-20260125    gcc-15.2.0
sh                    randconfig-001-20260126    gcc-9.5.0
sh                    randconfig-002-20260125    clang-22
sh                    randconfig-002-20260125    gcc-14.3.0
sh                    randconfig-002-20260126    gcc-9.5.0
sh                          rsk7203_defconfig    clang-22
sh                          rsk7264_defconfig    gcc-11.5.0
sh                      rts7751r2d1_defconfig    gcc-15.2.0
sh                           se7722_defconfig    gcc-15.2.0
sh                           sh2007_defconfig    gcc-15.2.0
sh                             shx3_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260125    gcc-8.5.0
sparc                 randconfig-002-20260125    gcc-15.2.0
sparc                 randconfig-002-20260125    gcc-8.5.0
sparc                       sparc64_defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260125    gcc-12.5.0
sparc64               randconfig-001-20260125    gcc-8.5.0
sparc64               randconfig-002-20260125    clang-20
sparc64               randconfig-002-20260125    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260125    gcc-14
um                    randconfig-001-20260125    gcc-8.5.0
um                    randconfig-002-20260125    clang-16
um                    randconfig-002-20260125    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260125    clang-20
x86_64      buildonly-randconfig-002-20260125    clang-20
x86_64      buildonly-randconfig-002-20260125    gcc-14
x86_64      buildonly-randconfig-003-20260125    clang-20
x86_64      buildonly-randconfig-004-20260125    clang-20
x86_64      buildonly-randconfig-005-20260125    clang-20
x86_64      buildonly-randconfig-005-20260125    gcc-14
x86_64      buildonly-randconfig-006-20260125    clang-20
x86_64      buildonly-randconfig-006-20260125    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260125    gcc-14
x86_64                randconfig-002-20260125    gcc-14
x86_64                randconfig-003-20260125    gcc-14
x86_64                randconfig-004-20260125    gcc-14
x86_64                randconfig-005-20260125    gcc-14
x86_64                randconfig-006-20260125    gcc-14
x86_64                randconfig-011-20260125    clang-20
x86_64                randconfig-011-20260126    gcc-14
x86_64                randconfig-012-20260125    clang-20
x86_64                randconfig-012-20260126    gcc-14
x86_64                randconfig-013-20260125    clang-20
x86_64                randconfig-013-20260126    gcc-14
x86_64                randconfig-014-20260125    clang-20
x86_64                randconfig-014-20260126    gcc-14
x86_64                randconfig-015-20260125    gcc-14
x86_64                randconfig-015-20260126    gcc-14
x86_64                randconfig-016-20260125    gcc-13
x86_64                randconfig-016-20260126    gcc-14
x86_64                randconfig-071-20260125    clang-20
x86_64                randconfig-072-20260125    clang-20
x86_64                randconfig-072-20260125    gcc-14
x86_64                randconfig-073-20260125    clang-20
x86_64                randconfig-074-20260125    clang-20
x86_64                randconfig-074-20260125    gcc-14
x86_64                randconfig-075-20260125    clang-20
x86_64                randconfig-075-20260125    gcc-14
x86_64                randconfig-076-20260125    clang-20
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
xtensa                randconfig-001-20260125    gcc-12.5.0
xtensa                randconfig-001-20260125    gcc-8.5.0
xtensa                randconfig-002-20260125    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
