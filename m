Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5C6287268
	for <linux-input@vger.kernel.org>; Sat,  4 Apr 2026 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775326131; cv=none; b=HE1ish/zrxh9KJoSKcaYX79uRZCHPFwoGt7HGpGKwOdJ8chIOC0+iVWZ71dre3pUqRMcr5WDDiN44bbjBcszor1UFWJt4035ZQ3DlKxFv4zZrqeXNiTUHk/6wBxS/AC8KYMLNKBzHbtpDvs6LReBo8p1R41y6Hi6qaW09lnNK08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775326131; c=relaxed/simple;
	bh=Qb5zb0459eL+9nPXlJyxw9a3vBGLMcyQ4FH2KOj3GgY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QxompLgzTN2+kPFkde4Wp1oxiqCXJR1mjvpKlbs7ASAiIxejrKNmaB3OKT3kOWxJ1gxAE1RnSNke3VQ42kW51gaCFaUQRghwQ/o3FvFDv4DDl4nUO0U9fgoB1iP6ZyMniRn28guAPI0u4sHzipr9HSwCT5XPrDZyXEmrkG0R4YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hRQlGqEJ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hRQlGqEJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775326128; x=1806862128;
  h=date:from:to:cc:subject:message-id;
  bh=Qb5zb0459eL+9nPXlJyxw9a3vBGLMcyQ4FH2KOj3GgY=;
  b=hRQlGqEJgMygnoE4NvrTRmM6w1aIWeAg0lHkcywKAXL7SAXYZJV6+JPf
   /vFtIC2qZylNVveLCicvNgZDLdf048nq3Pi2RfN8UotbLSuGgmp6uWK4x
   IjJbSlK/JY8WWqxrUFqtOPtlxPA7Slb6t21OgNId2wewlXsahk1YBVnDL
   1TYrQ1t9MiL7nraCFWCrHrvn8vVxgZPyv/51uhzoAVKlDfEz0g0PbWbFy
   nUyxrQwaphiRLuAQ8L/v1UYZ+YrZtkt6ajtr+r8I/gWv8kzyyiJpI/vM9
   HScGrEfw22wI//xh+cTD53aNn0gMvnQ8YSwPeyWgiEoGfiJ700kMLcYrP
   w==;
X-CSE-ConnectionGUID: /oMXWRk5RvecY/CSBLaV5w==
X-CSE-MsgGUID: QK6sKUkZRl2wFJyxVFS6vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11749"; a="87737668"
X-IronPort-AV: E=Sophos;i="6.23,160,1770624000"; 
   d="scan'208";a="87737668"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2026 11:08:48 -0700
X-CSE-ConnectionGUID: XTO1oLo4TqWlkFhgVKxqFQ==
X-CSE-MsgGUID: kC2NkM+fSa+7yebdcAzd/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,160,1770624000"; 
   d="scan'208";a="232329873"
Received: from lkp-server01.sh.intel.com (HELO 3afb7d003cac) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 04 Apr 2026 11:08:46 -0700
Received: from kbuild by 3afb7d003cac with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w95QK-000000001H9-1Be1;
	Sat, 04 Apr 2026 18:08:44 +0000
Date: Sun, 05 Apr 2026 02:08:05 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:for-linus] BUILD SUCCESS
 0d9363a764d9d601a05591f9695cea8b429e9be3
Message-ID: <202604050256.W192wTwR-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
branch HEAD: 0d9363a764d9d601a05591f9695cea8b429e9be3  Input: xpad - add support for BETOP BTP-KP50B/C controller's wireless mode

elapsed time: 735m

configs tested: 195
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260404    gcc-15.2.0
arc                   randconfig-002-20260404    gcc-15.2.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260404    gcc-15.2.0
arm                   randconfig-002-20260404    gcc-15.2.0
arm                   randconfig-003-20260404    gcc-15.2.0
arm                   randconfig-004-20260404    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260404    gcc-15.2.0
arm64                 randconfig-001-20260404    gcc-8.5.0
arm64                 randconfig-002-20260404    gcc-15.2.0
arm64                 randconfig-002-20260404    gcc-8.5.0
arm64                 randconfig-003-20260404    clang-23
arm64                 randconfig-003-20260404    gcc-15.2.0
arm64                 randconfig-004-20260404    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260404    gcc-15.2.0
csky                  randconfig-001-20260404    gcc-9.5.0
csky                  randconfig-002-20260404    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260404    gcc-15.2.0
hexagon               randconfig-002-20260404    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260404    clang-20
i386        buildonly-randconfig-001-20260404    gcc-14
i386        buildonly-randconfig-002-20260404    clang-20
i386        buildonly-randconfig-003-20260404    clang-20
i386        buildonly-randconfig-003-20260404    gcc-14
i386        buildonly-randconfig-004-20260404    clang-20
i386        buildonly-randconfig-005-20260404    clang-20
i386        buildonly-randconfig-006-20260404    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260404    clang-20
i386                  randconfig-002-20260404    clang-20
i386                  randconfig-003-20260404    clang-20
i386                  randconfig-004-20260404    clang-20
i386                  randconfig-005-20260404    clang-20
i386                  randconfig-006-20260404    clang-20
i386                  randconfig-007-20260404    clang-20
i386                  randconfig-011-20260404    clang-20
i386                  randconfig-012-20260404    clang-20
i386                  randconfig-013-20260404    clang-20
i386                  randconfig-014-20260404    clang-20
i386                  randconfig-015-20260404    clang-20
i386                  randconfig-016-20260404    clang-20
i386                  randconfig-017-20260404    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260404    gcc-15.2.0
loongarch             randconfig-002-20260404    gcc-15.2.0
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
mips                        omega2p_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260404    gcc-15.2.0
nios2                 randconfig-002-20260404    gcc-15.2.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260404    gcc-13.4.0
parisc                randconfig-002-20260404    gcc-15.2.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                     ksi8560_defconfig    gcc-15.2.0
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc               randconfig-001-20260404    gcc-8.5.0
powerpc               randconfig-002-20260404    clang-23
powerpc64             randconfig-001-20260404    clang-23
powerpc64             randconfig-002-20260404    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260404    clang-19
riscv                 randconfig-001-20260404    clang-20
riscv                 randconfig-002-20260404    clang-20
riscv                 randconfig-002-20260404    clang-23
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260404    clang-20
s390                  randconfig-002-20260404    clang-20
s390                  randconfig-002-20260404    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260404    clang-20
sh                    randconfig-001-20260404    gcc-15.2.0
sh                    randconfig-002-20260404    clang-20
sh                    randconfig-002-20260404    gcc-9.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260404    clang-20
sparc                 randconfig-002-20260404    clang-20
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260404    clang-20
sparc64               randconfig-002-20260404    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260404    clang-20
um                    randconfig-002-20260404    clang-20
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260404    gcc-13
x86_64      buildonly-randconfig-002-20260404    gcc-13
x86_64      buildonly-randconfig-003-20260404    gcc-13
x86_64      buildonly-randconfig-004-20260404    gcc-13
x86_64      buildonly-randconfig-005-20260404    gcc-13
x86_64      buildonly-randconfig-006-20260404    gcc-13
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260404    gcc-14
x86_64                randconfig-002-20260404    gcc-14
x86_64                randconfig-003-20260404    gcc-14
x86_64                randconfig-004-20260404    gcc-14
x86_64                randconfig-005-20260404    gcc-14
x86_64                randconfig-006-20260404    gcc-14
x86_64                randconfig-011-20260404    clang-20
x86_64                randconfig-011-20260404    gcc-14
x86_64                randconfig-012-20260404    gcc-14
x86_64                randconfig-013-20260404    clang-20
x86_64                randconfig-013-20260404    gcc-14
x86_64                randconfig-014-20260404    clang-20
x86_64                randconfig-014-20260404    gcc-14
x86_64                randconfig-015-20260404    clang-20
x86_64                randconfig-015-20260404    gcc-14
x86_64                randconfig-016-20260404    clang-20
x86_64                randconfig-016-20260404    gcc-14
x86_64                randconfig-071-20260404    gcc-14
x86_64                randconfig-072-20260404    gcc-14
x86_64                randconfig-073-20260404    gcc-14
x86_64                randconfig-074-20260404    gcc-14
x86_64                randconfig-075-20260404    gcc-14
x86_64                randconfig-076-20260404    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260404    clang-20
xtensa                randconfig-002-20260404    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
