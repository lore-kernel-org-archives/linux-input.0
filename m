Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A219223DFF
	for <linux-input@vger.kernel.org>; Sat, 27 Jun 2026 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782584943; cv=none; b=RcSTo1YL/+VXtoqbMGpFrl1mz7AsLfV/mvoYfslFdWRLf/6ImJD9fSqDb7fD7RdoH2200YaESZEOx9SrdS5R7zWxsCF+ZgDsxywkKTX7037tlCzfmfZbwtt/oKfq1QsjhmsnDwJt8EnrU4DZ7XeF4PUvWGS1j+u1UZKRStTkElM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782584943; c=relaxed/simple;
	bh=KiweuY6nuUeg7KPzzaa+Tz5nJusQb1SeoMEeAQ6FeKc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=D0cpFx/1erXqDo7+nVNdY7jxOsp0ZNfS97J/QEV4y7KqJftOHwcQDuzdiPqscOT+lAdzb3On2RPOJesd0v19D87rmorAvvViBlMDzBkvKsrsw2EBfgFDfNcOosLX0dwXRr5e7+KqKrmRpzgG0CaJWuXChKWATJp2YPEN41dHwVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j8N5gmn3; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j8N5gmn3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782584942; x=1814120942;
  h=date:from:to:cc:subject:message-id;
  bh=KiweuY6nuUeg7KPzzaa+Tz5nJusQb1SeoMEeAQ6FeKc=;
  b=j8N5gmn3wc8ubU+fcjOIqn9YkFx68qOMrcGBGdwqIdWzFwUHmY4pNMOf
   zIgzUC6BvQgbI9nnRu6Wkjh6Gm27CEr/pYCPodInmbuxYRI3vQflnjGIo
   UDZvW1SlagHJRLxBukYDPlK3wzTjACXv3AsM7oqvTzlME+R/zs2VwgYA1
   /4YZTSTL2OVugdUjlzpn0y6FJcgNlTUSp/PcPpT7HUjEyvxIiOuVPWrRM
   j1wM4Fyvk3Vnxe7ThsyPScDVwBRxlD/S39wU1Rdz4ElWpyvrXZfu9WCXm
   pJ9egZaWM9jRzaPRvDw5hEm+AeFqCattVPiKaX4bzvBRN2ooYEZSMG3aJ
   g==;
X-CSE-ConnectionGUID: pfE2MRiEQCGLr1SiufaUFA==
X-CSE-MsgGUID: hongj4ubTTqL6abvwTGVsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11830"; a="94486370"
X-IronPort-AV: E=Sophos;i="6.24,228,1774335600"; 
   d="scan'208";a="94486370"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2026 11:29:01 -0700
X-CSE-ConnectionGUID: E2fehXC+QJy9EwDM0Gjb8g==
X-CSE-MsgGUID: jj6SOdp4RoCbZG28xe5wVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,228,1774335600"; 
   d="scan'208";a="274792424"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 27 Jun 2026 11:29:00 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wdXlx-0000000060f-1aKF;
	Sat, 27 Jun 2026 18:28:57 +0000
Date: Sun, 28 Jun 2026 02:28:25 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:for-linus] BUILD SUCCESS
 d86d4f8cbb5a55a3b9b86f7b5ab8c4cdda600a3f
Message-ID: <202606280214.JCRJsUBJ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
branch HEAD: d86d4f8cbb5a55a3b9b86f7b5ab8c4cdda600a3f  Input: gscps2 - advance receive buffer write index

elapsed time: 737m

configs tested: 166
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260627    gcc-8.5.0
arc                   randconfig-002-20260627    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260627    gcc-16.1.0
arm                   randconfig-002-20260627    clang-23
arm                   randconfig-003-20260627    gcc-16.1.0
arm                   randconfig-004-20260627    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260627    gcc-10.5.0
arm64                 randconfig-002-20260627    clang-23
arm64                 randconfig-003-20260627    gcc-10.5.0
arm64                 randconfig-004-20260627    gcc-16.1.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260627    gcc-16.1.0
csky                  randconfig-002-20260627    gcc-14.3.0
hexagon                          allmodconfig    clang-23
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260627    clang-23
hexagon               randconfig-002-20260627    clang-18
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260627    clang-22
i386        buildonly-randconfig-002-20260627    clang-22
i386        buildonly-randconfig-003-20260627    clang-22
i386        buildonly-randconfig-004-20260627    clang-22
i386        buildonly-randconfig-005-20260627    gcc-13
i386        buildonly-randconfig-006-20260627    clang-22
i386                                defconfig    clang-22
i386                  randconfig-001-20260627    clang-22
i386                  randconfig-002-20260627    clang-22
i386                  randconfig-003-20260627    gcc-13
i386                  randconfig-004-20260627    clang-22
i386                  randconfig-005-20260627    clang-22
i386                  randconfig-006-20260627    gcc-14
i386                  randconfig-007-20260627    clang-22
i386                  randconfig-011-20260627    clang-22
i386                  randconfig-012-20260627    clang-22
i386                  randconfig-013-20260627    gcc-14
i386                  randconfig-014-20260627    clang-22
i386                  randconfig-015-20260627    gcc-14
i386                  randconfig-016-20260627    clang-22
i386                  randconfig-017-20260627    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-20
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260627    clang-23
loongarch             randconfig-002-20260627    gcc-16.1.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260627    gcc-11.5.0
nios2                 randconfig-002-20260627    gcc-11.5.0
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260627    gcc-8.5.0
parisc                randconfig-002-20260627    gcc-8.5.0
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-001-20260627    clang-23
powerpc               randconfig-002-20260627    clang-17
powerpc                     stx_gp3_defconfig    gcc-16.1.0
powerpc64             randconfig-001-20260627    clang-20
powerpc64             randconfig-002-20260627    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                          randconfig-001    gcc-13.4.0
riscv                 randconfig-001-20260627    clang-22
riscv                          randconfig-002    clang-23
riscv                 randconfig-002-20260627    clang-23
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                           randconfig-001    gcc-15.2.0
s390                  randconfig-001-20260627    clang-23
s390                           randconfig-002    clang-18
s390                  randconfig-002-20260627    clang-23
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-16.1.0
sh                             randconfig-001    gcc-14.3.0
sh                    randconfig-001-20260627    gcc-16.1.0
sh                             randconfig-002    gcc-9.5.0
sh                    randconfig-002-20260627    gcc-10.5.0
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-16.1.0
sparc                 randconfig-001-20260627    gcc-13.4.0
sparc                          randconfig-002    gcc-11.5.0
sparc                 randconfig-002-20260627    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64                        randconfig-001    gcc-12.5.0
sparc64                        randconfig-002    clang-20
sparc64               randconfig-002-20260627    gcc-15.2.0
um                               allmodconfig    clang-23
um                                allnoconfig    clang-16
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                             randconfig-002    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260627    gcc-13
x86_64      buildonly-randconfig-002-20260627    clang-22
x86_64      buildonly-randconfig-003-20260627    clang-22
x86_64      buildonly-randconfig-004-20260627    gcc-14
x86_64      buildonly-randconfig-005-20260627    clang-22
x86_64      buildonly-randconfig-006-20260627    clang-22
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260627    clang-22
x86_64                randconfig-002-20260627    gcc-12
x86_64                randconfig-003-20260627    clang-22
x86_64                randconfig-004-20260627    gcc-14
x86_64                randconfig-005-20260627    gcc-14
x86_64                randconfig-006-20260627    clang-22
x86_64                randconfig-011-20260627    clang-22
x86_64                randconfig-012-20260627    clang-22
x86_64                randconfig-013-20260627    gcc-14
x86_64                randconfig-014-20260627    gcc-14
x86_64                randconfig-015-20260627    gcc-14
x86_64                randconfig-016-20260627    gcc-14
x86_64                randconfig-071-20260627    clang-22
x86_64                randconfig-072-20260627    clang-22
x86_64                randconfig-073-20260627    clang-22
x86_64                randconfig-074-20260627    gcc-14
x86_64                randconfig-075-20260627    gcc-14
x86_64                randconfig-076-20260627    clang-22
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    gcc-16.1.0
xtensa                         randconfig-001    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
