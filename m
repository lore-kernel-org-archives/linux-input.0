Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7CC2609EE
	for <linux-input@vger.kernel.org>; Wed, 24 Jun 2026 04:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782276087; cv=none; b=YLZlmvW2rIBYn1coa2ey6+hgD22y8vrATFoIaEzXG/zaSBLzQMpTky4mLICr0RVSygk5r/W9GHo6QvZsiL7AbyDIyrlJzvY9YP3nX85y4k85e+JBCWvVFkUwayMpGMpb6S1Ol1oEs75rul/YuyCB4bUrQkTVmDJ2H+omSC2I/bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782276087; c=relaxed/simple;
	bh=P4QxYIsHH43EUsY3QveWHeGrA8RQL9u59HhjsF16aiU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ShMrQh3mAxkYiEPDVUpv3hd2P7mACF5jrHePPce1g53fjF7pjO4gngG1c+fyg8OWGZPC9aJe+SldTZFSZE3bGjFBFpjyJaGblzleK3APEhXTm4MkkRnBKe4WVQuBJuzJR0JebvAc/9EwnWzVRfSzwGt2WfhLZL/NxjEacvtCSLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M2GKzfO6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M2GKzfO6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782276086; x=1813812086;
  h=date:from:to:cc:subject:message-id;
  bh=P4QxYIsHH43EUsY3QveWHeGrA8RQL9u59HhjsF16aiU=;
  b=M2GKzfO6sXZE1nImj8YabsfwnNVm5TJfi9I8n5B63MoIgm35gP83l0HS
   SlFEAGsPd0Iv03UH142mcDsnBJVFH7n/B1vrndqaoWQAKRzEvOB5X+q+g
   NGb0Wj2F3TlYfGu5j6vA1VjP/L1B1lxxMqMn1GSld5aQr8NlfELfucMCQ
   Eza3Ja+unCqVgL92n3SYz3zVINmPB20dZpx3yPmRkhJa8YyKNsEvP/mS2
   j6etiBMkhlVICMV0DFZImMr90/GEQ0Jmk3nzFSDXEoP/VsJKPwubYXgGW
   4Qy+poYg0MwH9JG+BBJ5ScFKnF6V5aGZ/MNE651d2DSDzfCyg8MEvkpZk
   Q==;
X-CSE-ConnectionGUID: FM7b9N5ZR3mEN4C/CN5Gtg==
X-CSE-MsgGUID: 9MT5YI8jR6qulwcWfw2Ffw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="108571099"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="108571099"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 21:41:25 -0700
X-CSE-ConnectionGUID: ytaIeiOtTXq3iyLUDRFb8g==
X-CSE-MsgGUID: HyLMzHqGTymnGJqdWxcnKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="247361856"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 23 Jun 2026 21:41:24 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wcFQH-0000000037L-1okg;
	Wed, 24 Jun 2026 04:41:16 +0000
Date: Wed, 24 Jun 2026 12:40:26 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:next] BUILD SUCCESS
 0c9245c455e809c8111cb60284328c79064df050
Message-ID: <202606241216.Ge3UVPYT-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
branch HEAD: 0c9245c455e809c8111cb60284328c79064df050  Input: cap11xx - add support for CAP1114

elapsed time: 722m

configs tested: 259
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260624    gcc-15.2.0
arc                   randconfig-001-20260624    gcc-9.5.0
arc                   randconfig-002-20260624    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260624    clang-19
arm                   randconfig-001-20260624    gcc-15.2.0
arm                   randconfig-002-20260624    gcc-15.2.0
arm                   randconfig-002-20260624    gcc-8.5.0
arm                   randconfig-003-20260624    gcc-15.2.0
arm                   randconfig-004-20260624    clang-16
arm                   randconfig-004-20260624    gcc-15.2.0
arm                           sama5_defconfig    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260624    clang-21
arm64                 randconfig-002-20260624    clang-21
arm64                 randconfig-003-20260624    clang-21
arm64                 randconfig-004-20260624    clang-21
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260624    clang-21
csky                  randconfig-002-20260624    clang-21
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260624    clang-20
hexagon               randconfig-001-20260624    gcc-11.5.0
hexagon               randconfig-001-20260624    gcc-9.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260624    clang-23
hexagon               randconfig-002-20260624    gcc-11.5.0
hexagon               randconfig-002-20260624    gcc-9.5.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260624    gcc-12
i386        buildonly-randconfig-001-20260624    gcc-14
i386        buildonly-randconfig-002-20260624    gcc-12
i386        buildonly-randconfig-002-20260624    gcc-14
i386        buildonly-randconfig-003-20260624    gcc-12
i386        buildonly-randconfig-004-20260624    gcc-12
i386        buildonly-randconfig-004-20260624    gcc-14
i386        buildonly-randconfig-005-20260624    gcc-12
i386        buildonly-randconfig-005-20260624    gcc-14
i386        buildonly-randconfig-006-20260624    gcc-12
i386        buildonly-randconfig-006-20260624    gcc-14
i386                                defconfig    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260624    clang-22
i386                  randconfig-002-20260624    clang-22
i386                  randconfig-003-20260624    clang-22
i386                  randconfig-004-20260624    clang-22
i386                  randconfig-005-20260624    clang-22
i386                  randconfig-006-20260624    clang-22
i386                  randconfig-007-20260624    clang-22
i386                  randconfig-011-20260624    clang-22
i386                  randconfig-012-20260624    clang-22
i386                  randconfig-012-20260624    gcc-14
i386                  randconfig-013-20260624    clang-22
i386                  randconfig-014-20260624    clang-22
i386                  randconfig-015-20260624    clang-22
i386                  randconfig-015-20260624    gcc-14
i386                  randconfig-016-20260624    clang-22
i386                  randconfig-017-20260624    clang-22
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260624    gcc-11.5.0
loongarch             randconfig-001-20260624    gcc-16.1.0
loongarch             randconfig-001-20260624    gcc-9.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260624    gcc-11.5.0
loongarch             randconfig-002-20260624    gcc-15.2.0
loongarch             randconfig-002-20260624    gcc-9.5.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                        stmark2_defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260624    gcc-11.5.0
nios2                 randconfig-001-20260624    gcc-9.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260624    gcc-11.5.0
nios2                 randconfig-002-20260624    gcc-9.5.0
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260624    gcc-16.1.0
parisc                randconfig-002-20260624    gcc-14.3.0
parisc                randconfig-002-20260624    gcc-16.1.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                     asp8347_defconfig    clang-23
powerpc                        fsp2_defconfig    gcc-16.1.0
powerpc               randconfig-001-20260624    clang-23
powerpc               randconfig-001-20260624    gcc-16.1.0
powerpc               randconfig-002-20260624    gcc-16.1.0
powerpc               randconfig-002-20260624    gcc-8.5.0
powerpc64             randconfig-001-20260624    gcc-16.1.0
powerpc64             randconfig-001-20260624    gcc-8.5.0
powerpc64             randconfig-002-20260624    gcc-11.5.0
powerpc64             randconfig-002-20260624    gcc-16.1.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    clang-18
riscv                 randconfig-001-20260624    clang-18
riscv                          randconfig-002    clang-18
riscv                 randconfig-002-20260624    clang-18
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    clang-18
s390                  randconfig-001-20260624    clang-18
s390                           randconfig-002    clang-18
s390                  randconfig-002-20260624    clang-18
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    clang-18
sh                    randconfig-001-20260624    clang-18
sh                             randconfig-002    clang-18
sh                    randconfig-002-20260624    clang-18
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260624    gcc-14.3.0
sparc                 randconfig-001-20260624    gcc-8.5.0
sparc                 randconfig-002-20260624    gcc-14.3.0
sparc                 randconfig-002-20260624    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260624    clang-20
sparc64               randconfig-001-20260624    gcc-14.3.0
sparc64               randconfig-002-20260624    clang-20
sparc64               randconfig-002-20260624    gcc-14.3.0
um                               allmodconfig    clang-17
um                               allmodconfig    clang-23
um                                allnoconfig    clang-16
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260624    clang-23
um                    randconfig-001-20260624    gcc-14.3.0
um                    randconfig-002-20260624    clang-16
um                    randconfig-002-20260624    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260624    clang-22
x86_64      buildonly-randconfig-002-20260624    clang-22
x86_64      buildonly-randconfig-003-20260624    clang-22
x86_64      buildonly-randconfig-004-20260624    clang-22
x86_64      buildonly-randconfig-005-20260624    clang-22
x86_64      buildonly-randconfig-006-20260624    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                         randconfig-001    clang-22
x86_64                randconfig-001-20260624    clang-22
x86_64                         randconfig-002    clang-22
x86_64                randconfig-002-20260624    clang-22
x86_64                         randconfig-003    clang-22
x86_64                randconfig-003-20260624    clang-22
x86_64                         randconfig-004    clang-22
x86_64                randconfig-004-20260624    clang-22
x86_64                         randconfig-005    clang-22
x86_64                randconfig-005-20260624    clang-22
x86_64                         randconfig-006    clang-22
x86_64                randconfig-006-20260624    clang-22
x86_64                randconfig-011-20260624    gcc-14
x86_64                randconfig-012-20260624    gcc-14
x86_64                randconfig-013-20260624    gcc-14
x86_64                randconfig-014-20260624    gcc-14
x86_64                randconfig-015-20260624    gcc-14
x86_64                randconfig-016-20260624    gcc-14
x86_64                randconfig-071-20260624    gcc-14
x86_64                randconfig-072-20260624    clang-22
x86_64                randconfig-072-20260624    gcc-14
x86_64                randconfig-073-20260624    gcc-14
x86_64                randconfig-074-20260624    clang-22
x86_64                randconfig-074-20260624    gcc-14
x86_64                randconfig-075-20260624    gcc-14
x86_64                randconfig-076-20260624    clang-22
x86_64                randconfig-076-20260624    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260624    gcc-14.3.0
xtensa                randconfig-002-20260624    gcc-14.3.0
xtensa                randconfig-002-20260624    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
