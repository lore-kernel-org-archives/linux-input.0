Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072CA245012
	for <linux-input@vger.kernel.org>; Sun,  3 May 2026 03:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777779781; cv=none; b=cBweGnY5VfH9QEc4q1Qfg4g8MLCpZpjbmDoUkrfWN3yWZVStno1Zamz5bcGeRu4no+0uZ8fPuGShenknrPATVJ9dCw4KCVmQrS6+Zn61kdlUvGqY1AF8FshYIpQrA1QM2QP+b3D+ToSztQsAC3QYdsQlcdAAVSp+vaN+ms0TNGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777779781; c=relaxed/simple;
	bh=Qyi8P6u7o9nNMSSlDiAzJLopCpdQYpAavhwCG0lYa/g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CzCenXLnoAQa0QU5w/exGSmtXS+38o0qii33BbZwD1nkY2d7xeOPoRG7EyCIamXROecIpy9UGA7ePMnWmLmi4HGIcWpAC5XLzlRs+bgj4RBF3jOjL/Qg6fmZf6dYQ9wVNHsv2BESr+2BVbo+dmqn3CA3NfG6DeU8hon2JKSPimo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QF0gxl3l; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QF0gxl3l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777779779; x=1809315779;
  h=date:from:to:cc:subject:message-id;
  bh=Qyi8P6u7o9nNMSSlDiAzJLopCpdQYpAavhwCG0lYa/g=;
  b=QF0gxl3l+Wrad7OdIZuh/PWg6wqKBPkpvYdM/kW2Y7fvEIyNzIKurrV6
   5u4KgTFYqr0Vw5o+pApCx4RkLZLJxmgRcs4wG3Aqgmp5B2MDkeuQYXKmS
   7DB3WiJ3JbZvYiZ78uh2z/2VWpSIGbBCgNy5mp1IAv1eSRw6qG0+cFB8D
   DAJq+gbp0DwiTjvl9uc1SarbYGfMXfp5kvvKfzprL6Bdc2F4VjX9/HKH6
   +hPaKxI5Xu68lOZf3/5n5uKinjrWdy/0Vyhw5LQ7RbjVkeD/I5u4Px5Gu
   dLaTLipZpIatdz1Vn7TEWPQrVBxBfZh6KLOzNAsu168y1d3pqUfvryZCl
   g==;
X-CSE-ConnectionGUID: k8uQSVw3RemJfY+mw/hLoA==
X-CSE-MsgGUID: PtK/crM3RoextmWulIQPGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11774"; a="78615231"
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; 
   d="scan'208";a="78615231"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2026 20:42:58 -0700
X-CSE-ConnectionGUID: vzmWhyR7QHO0kfjZ9glF5Q==
X-CSE-MsgGUID: IjRV7QoCQOmQoU6oftbfOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; 
   d="scan'208";a="230606154"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 02 May 2026 20:42:57 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wJNjL-0000000026f-00gI;
	Sun, 03 May 2026 03:42:55 +0000
Date: Sun, 03 May 2026 11:42:30 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:master] BUILD SUCCESS
 cde5e7777f2e0b625d576b8725c65ec1f3b12b79
Message-ID: <202605031122.iyHCYxuH-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git master
branch HEAD: cde5e7777f2e0b625d576b8725c65ec1f3b12b79  Input: pcap_ts - remove unused driver

elapsed time: 2797m

configs tested: 227
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              alldefconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260503    gcc-10.5.0
arc                   randconfig-002-20260503    gcc-10.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260503    gcc-10.5.0
arm                   randconfig-002-20260503    gcc-10.5.0
arm                   randconfig-003-20260503    gcc-10.5.0
arm                   randconfig-004-20260503    gcc-10.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                          randconfig-001    gcc-10.5.0
arm64                 randconfig-001-20260502    gcc-10.5.0
arm64                 randconfig-001-20260503    gcc-15.2.0
arm64                          randconfig-002    gcc-10.5.0
arm64                 randconfig-002-20260502    gcc-10.5.0
arm64                 randconfig-002-20260503    gcc-15.2.0
arm64                          randconfig-003    gcc-10.5.0
arm64                 randconfig-003-20260502    gcc-10.5.0
arm64                 randconfig-003-20260503    gcc-15.2.0
arm64                          randconfig-004    gcc-10.5.0
arm64                 randconfig-004-20260502    gcc-10.5.0
arm64                 randconfig-004-20260503    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                           randconfig-001    gcc-10.5.0
csky                  randconfig-001-20260502    gcc-10.5.0
csky                  randconfig-001-20260503    gcc-15.2.0
csky                           randconfig-002    gcc-10.5.0
csky                  randconfig-002-20260502    gcc-10.5.0
csky                  randconfig-002-20260503    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260502    clang-23
hexagon               randconfig-001-20260503    clang-23
hexagon               randconfig-002-20260502    clang-23
hexagon               randconfig-002-20260503    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260502    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260502    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260502    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260502    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260502    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260502    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260502    clang-20
i386                  randconfig-002-20260502    clang-20
i386                  randconfig-003-20260502    clang-20
i386                  randconfig-004-20260502    clang-20
i386                  randconfig-005-20260502    clang-20
i386                  randconfig-006-20260502    clang-20
i386                  randconfig-007-20260502    clang-20
i386                  randconfig-011-20260502    clang-20
i386                  randconfig-012-20260502    clang-20
i386                  randconfig-013-20260502    clang-20
i386                  randconfig-014-20260502    clang-20
i386                  randconfig-015-20260502    clang-20
i386                  randconfig-016-20260502    clang-20
i386                  randconfig-017-20260502    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260502    clang-23
loongarch             randconfig-001-20260503    clang-23
loongarch             randconfig-002-20260502    clang-23
loongarch             randconfig-002-20260503    clang-23
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
nios2                 randconfig-001-20260502    clang-23
nios2                 randconfig-001-20260503    clang-23
nios2                 randconfig-002-20260502    clang-23
nios2                 randconfig-002-20260503    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260502    gcc-12.5.0
parisc                randconfig-001-20260503    gcc-15.2.0
parisc                randconfig-002-20260502    gcc-12.5.0
parisc                randconfig-002-20260503    gcc-15.2.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260502    gcc-12.5.0
powerpc               randconfig-001-20260503    gcc-15.2.0
powerpc               randconfig-002-20260502    gcc-12.5.0
powerpc               randconfig-002-20260503    gcc-15.2.0
powerpc64             randconfig-001-20260502    gcc-12.5.0
powerpc64             randconfig-001-20260503    gcc-15.2.0
powerpc64             randconfig-002-20260502    gcc-12.5.0
powerpc64             randconfig-002-20260503    gcc-15.2.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260502    gcc-14.3.0
riscv                 randconfig-001-20260503    clang-23
riscv                 randconfig-002-20260502    gcc-14.3.0
riscv                 randconfig-002-20260503    clang-23
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260502    gcc-14.3.0
s390                  randconfig-001-20260503    clang-23
s390                  randconfig-002-20260502    gcc-14.3.0
s390                  randconfig-002-20260503    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260502    gcc-14.3.0
sh                    randconfig-001-20260503    clang-23
sh                    randconfig-002-20260502    gcc-14.3.0
sh                    randconfig-002-20260503    clang-23
sh                      rts7751r2d1_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-8.5.0
sparc                 randconfig-001-20260502    gcc-8.5.0
sparc                 randconfig-001-20260503    gcc-15.2.0
sparc                          randconfig-002    gcc-8.5.0
sparc                 randconfig-002-20260502    gcc-8.5.0
sparc                 randconfig-002-20260503    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-8.5.0
sparc64               randconfig-001-20260502    gcc-8.5.0
sparc64               randconfig-001-20260503    gcc-15.2.0
sparc64                        randconfig-002    gcc-8.5.0
sparc64               randconfig-002-20260502    gcc-8.5.0
sparc64               randconfig-002-20260503    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-8.5.0
um                    randconfig-001-20260502    gcc-8.5.0
um                    randconfig-001-20260503    gcc-15.2.0
um                             randconfig-002    gcc-8.5.0
um                    randconfig-002-20260502    gcc-8.5.0
um                    randconfig-002-20260503    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260502    clang-20
x86_64      buildonly-randconfig-002-20260502    clang-20
x86_64      buildonly-randconfig-003-20260502    clang-20
x86_64      buildonly-randconfig-004-20260502    clang-20
x86_64      buildonly-randconfig-005-20260502    clang-20
x86_64      buildonly-randconfig-006-20260502    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260502    clang-20
x86_64                randconfig-001-20260503    clang-20
x86_64                randconfig-002-20260502    clang-20
x86_64                randconfig-002-20260503    clang-20
x86_64                randconfig-003-20260502    clang-20
x86_64                randconfig-003-20260503    clang-20
x86_64                randconfig-004-20260502    clang-20
x86_64                randconfig-004-20260503    clang-20
x86_64                randconfig-005-20260502    clang-20
x86_64                randconfig-005-20260503    clang-20
x86_64                randconfig-006-20260502    clang-20
x86_64                randconfig-006-20260503    clang-20
x86_64                randconfig-011-20260503    clang-20
x86_64                randconfig-012-20260503    clang-20
x86_64                randconfig-013-20260503    clang-20
x86_64                randconfig-014-20260503    clang-20
x86_64                randconfig-015-20260503    clang-20
x86_64                randconfig-016-20260503    clang-20
x86_64                randconfig-071-20260502    gcc-14
x86_64                randconfig-072-20260502    gcc-14
x86_64                randconfig-073-20260502    gcc-14
x86_64                randconfig-074-20260502    gcc-14
x86_64                randconfig-075-20260502    gcc-14
x86_64                randconfig-076-20260502    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260502    gcc-8.5.0
xtensa                randconfig-001-20260503    gcc-15.2.0
xtensa                         randconfig-002    gcc-8.5.0
xtensa                randconfig-002-20260502    gcc-8.5.0
xtensa                randconfig-002-20260503    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
