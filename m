Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C09C353A7A
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 07:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926110; cv=none; b=alCv/oTP49ldU+tDSG42xiQEvp21HCxA684+buWsgNAOcfo7FhEHDKUeQ2UzGTEh/pt+DtT3arEzh2LiYkHVRb8cEwYN8TmDRbfuoimw8KEEl4zvf3umbWityXsrHBkgk6gJl75SiPx9F8r7FXu/+sqGm15M8aJ0m+TatSzitnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926110; c=relaxed/simple;
	bh=slL/B5j1eXmGkobRjAzfw/1VYKztlOirU2HOAojTVVM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hfrHULKulReT3MptrhPMQpWHMw9tjz9iVZmWb/Q86pyaq98p04SFE3r8sIn1J4J0EH1ArII0vfyNY+m138UXX8w97ovnFPoxbMfeHA2o5UXb2p8LQQtLtpEgWFG7Hbnz61kAswGO7lgsyM1R1NwCEb3jM+9HoINLSwVDUsZU/wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DXwzGgdc; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DXwzGgdc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783926108; x=1815462108;
  h=date:from:to:cc:subject:message-id;
  bh=slL/B5j1eXmGkobRjAzfw/1VYKztlOirU2HOAojTVVM=;
  b=DXwzGgdcmTyoW3Co/fn9XkNmhWTlZL7XEazdxPYSVVhEBwBpet/gAq07
   m/fQkA0FainsQsPEVL0u8Pcd2BksTRLz0GGqb5nl1as+JLva63Mdcw5+T
   6VDvoAYgCSnUTMfihtNqTD47Cs+fyRwGpj1Iz6H6NVeQgOyYH0nz16SBT
   1juLxY0Tp0g3z7DLJCvMdTd3colADqFHs3CGFmuEibmHFvT04/RKbdKAz
   7UMeZjf+0BOAiYlJ056K81vxpov+W0yk/+N081H5HRNIoScOIQtO0dr/O
   64I91BJfOKyS9LyrMbXQZfdLcOXHPxCWBTxhBZVQn8+loTbGoxBQjpTZZ
   w==;
X-CSE-ConnectionGUID: s3nebSRPT+W8eXMoowU94w==
X-CSE-MsgGUID: xoDZzl5ZTkmr342yHr/Cpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="102077711"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="102077711"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 00:01:47 -0700
X-CSE-ConnectionGUID: SGZRf5BsTdafsJWG85OTbQ==
X-CSE-MsgGUID: L+O0uRyOR7u/1QiB9Osf+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="260352074"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 13 Jul 2026 00:01:45 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wjAfY-00000000LTg-1kCf;
	Mon, 13 Jul 2026 07:01:39 +0000
Date: Mon, 13 Jul 2026 15:01:21 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:next] BUILD SUCCESS
 79d7a453c79e818b8059b1aa6d6a7ad53d9d4f72
Message-ID: <202607131510.4uY7pljE-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
branch HEAD: 79d7a453c79e818b8059b1aa6d6a7ad53d9d4f72  Input: i8042 - replace strlcat() with seq_buf and scnprintf()

elapsed time: 729m

configs tested: 193
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260713    gcc-8.5.0
arc                   randconfig-002-20260713    gcc-8.5.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260713    gcc-8.5.0
arm                   randconfig-002-20260713    gcc-8.5.0
arm                   randconfig-003-20260713    gcc-8.5.0
arm                   randconfig-004-20260713    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    clang-23
arm64                 randconfig-001-20260713    clang-23
arm64                 randconfig-001-20260713    gcc-13.4.0
arm64                          randconfig-002    clang-23
arm64                 randconfig-002-20260713    clang-23
arm64                 randconfig-002-20260713    gcc-13.4.0
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260713    clang-23
arm64                 randconfig-003-20260713    gcc-13.4.0
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260713    clang-23
arm64                 randconfig-004-20260713    gcc-13.4.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    clang-23
csky                  randconfig-001-20260713    clang-23
csky                  randconfig-001-20260713    gcc-13.4.0
csky                           randconfig-002    clang-23
csky                  randconfig-002-20260713    clang-23
csky                  randconfig-002-20260713    gcc-13.4.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260713    clang-23
hexagon               randconfig-002-20260713    clang-23
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260713    gcc-14
i386        buildonly-randconfig-002-20260713    gcc-14
i386        buildonly-randconfig-003-20260713    gcc-14
i386        buildonly-randconfig-004-20260713    gcc-14
i386        buildonly-randconfig-005-20260713    gcc-14
i386        buildonly-randconfig-006-20260713    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260713    clang-22
i386                  randconfig-002-20260713    clang-22
i386                  randconfig-003-20260713    clang-22
i386                  randconfig-004-20260713    clang-22
i386                  randconfig-005-20260713    clang-22
i386                  randconfig-006-20260713    clang-22
i386                  randconfig-007-20260713    clang-22
i386                  randconfig-011-20260713    clang-22
i386                  randconfig-012-20260713    clang-22
i386                  randconfig-013-20260713    clang-22
i386                  randconfig-014-20260713    clang-22
i386                  randconfig-015-20260713    clang-22
i386                  randconfig-016-20260713    clang-22
i386                  randconfig-017-20260713    clang-22
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260713    clang-23
loongarch             randconfig-002-20260713    clang-23
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                  maltasmvp_eva_defconfig    gcc-16.1.0
mips                        omega2p_defconfig    clang-17
mips                          rm200_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260713    clang-23
nios2                 randconfig-002-20260713    clang-23
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260713    clang-23
parisc                randconfig-002-20260713    clang-23
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260713    clang-23
powerpc               randconfig-002-20260713    clang-23
powerpc64             randconfig-001-20260713    clang-23
powerpc64             randconfig-002-20260713    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    clang-19
riscv                 randconfig-001-20260713    clang-19
riscv                          randconfig-002    clang-19
riscv                 randconfig-002-20260713    clang-19
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    clang-19
s390                  randconfig-001-20260713    clang-19
s390                           randconfig-002    clang-19
s390                  randconfig-002-20260713    clang-19
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    clang-19
sh                    randconfig-001-20260713    clang-19
sh                             randconfig-002    clang-19
sh                    randconfig-002-20260713    clang-19
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260713    gcc-12.5.0
sparc                 randconfig-002-20260713    gcc-12.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260713    gcc-12.5.0
sparc64               randconfig-002-20260713    gcc-12.5.0
um                               allmodconfig    clang-17
um                               allmodconfig    clang-23
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260713    gcc-12.5.0
um                    randconfig-002-20260713    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260713    clang-22
x86_64      buildonly-randconfig-002-20260713    clang-22
x86_64      buildonly-randconfig-003-20260713    clang-22
x86_64      buildonly-randconfig-004-20260713    clang-22
x86_64      buildonly-randconfig-005-20260713    clang-22
x86_64      buildonly-randconfig-006-20260713    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260713    gcc-13
x86_64                randconfig-002-20260713    gcc-13
x86_64                randconfig-003-20260713    gcc-13
x86_64                randconfig-004-20260713    gcc-13
x86_64                randconfig-005-20260713    gcc-13
x86_64                randconfig-006-20260713    gcc-13
x86_64                randconfig-011-20260713    gcc-14
x86_64                randconfig-012-20260713    gcc-14
x86_64                randconfig-013-20260713    gcc-14
x86_64                randconfig-014-20260713    gcc-14
x86_64                randconfig-015-20260713    gcc-14
x86_64                randconfig-016-20260713    gcc-14
x86_64                randconfig-071-20260713    gcc-14
x86_64                randconfig-072-20260713    gcc-14
x86_64                randconfig-073-20260713    gcc-14
x86_64                randconfig-074-20260713    gcc-14
x86_64                randconfig-075-20260713    gcc-14
x86_64                randconfig-076-20260713    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260713    gcc-12.5.0
xtensa                randconfig-002-20260713    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
