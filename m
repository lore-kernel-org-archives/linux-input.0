Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714D0E55A
	for <linux-input@vger.kernel.org>; Fri, 10 Apr 2026 05:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775797722; cv=none; b=d3Cja/7QE+OCvKwS7MgfDP5y3vKP/7IxIOK6sddbWeh+vL8uNSxd9gcLvFvU96NdDrNAA7A6b3sUSnRB5frhPMX4vw91EtjUzHBFYLGji4NEe7DlhEf2QJuHysz5R91A0n1WHHn+SI0nAc97vygsTkS55+sCDXuBCTe5wb/gPkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775797722; c=relaxed/simple;
	bh=Qvp5mXddzJ3Qwi+UtqwYg7yJFXM/Fo2giydAPVm4rqg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LKWoEfmNblTshQdggoTJ8ByQo4zreq4S/57+tF2keLEWmjYtA4gOG5asSEuTwUKVo+pSD5o4fIYZz8jh2VYQLxl9pzNeZ+7uyd8xTrZdAs9T/SA/zt6q+hnkmRaNv+hk8dfi4whiBjqy2w+4OauvdjqritTStpsIryU9zvab7wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ug6YrYAp; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ug6YrYAp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775797722; x=1807333722;
  h=date:from:to:cc:subject:message-id;
  bh=Qvp5mXddzJ3Qwi+UtqwYg7yJFXM/Fo2giydAPVm4rqg=;
  b=Ug6YrYApAwjUtG6EaYGoeXq8uFFIHQJTJpOKhOhqiOTtAsN9R79sed+/
   DDoSHn6H/sSUHlX/+1+vge7kBJZh55KSYfQoGvRDLVldTt9BBrEyF20Lr
   MHu/8fARB1Z4sljdbRiJDKC0ANHLo1cyGH9jK5rwX2gmM8yen3rtbwrOG
   jfSeyIhv+u7zyu7d1lNfkXsBP/6OsaOORzLFazaiJA0Klxiwldv4pURE3
   bhjpKFpL0Pzs28oMt01HHF79tmQvaMG6jA5Dg+RDfpAH79Lgjdr3CNzWg
   Fvftmli6pJJS3Sz9SeFKUsIfFMvCRRdqegQpV9Pa80CV8VtpdkDMhHZjm
   w==;
X-CSE-ConnectionGUID: 52a0aNs9TlC4xzjNj9o/Qg==
X-CSE-MsgGUID: mxXI4y6NSbirIOz2oP1kAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="87890462"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="87890462"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 22:08:42 -0700
X-CSE-ConnectionGUID: Vhfbk/6WR7OzghePG2u52g==
X-CSE-MsgGUID: kkOysufuS+yvd7GV2Rj9eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="224244953"
Received: from lkp-server01.sh.intel.com (HELO 6449335cace3) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 09 Apr 2026 22:08:40 -0700
Received: from kbuild by 6449335cace3 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wB46f-000000000qS-1USf;
	Fri, 10 Apr 2026 05:08:37 +0000
Date: Fri, 10 Apr 2026 13:07:34 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:for-linus] BUILD SUCCESS
 4cda78d6f8bf2b700529f2fbccb994c3e826d7c2
Message-ID: <202604101329.uwXDewLX-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
branch HEAD: 4cda78d6f8bf2b700529f2fbccb994c3e826d7c2  Input: uinput - fix circular locking dependency with ff-core

elapsed time: 2870m

configs tested: 174
configs skipped: 18

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260408    clang-23
arc                   randconfig-001-20260408    gcc-8.5.0
arc                   randconfig-002-20260408    clang-23
arc                   randconfig-002-20260408    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                         lpc18xx_defconfig    clang-23
arm                   randconfig-001-20260408    clang-23
arm                   randconfig-001-20260408    gcc-8.5.0
arm                   randconfig-002-20260408    clang-23
arm                   randconfig-003-20260408    clang-23
arm                   randconfig-004-20260408    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260408    gcc-14.3.0
arm64                 randconfig-002-20260408    gcc-14.3.0
arm64                 randconfig-003-20260408    gcc-14.3.0
arm64                 randconfig-004-20260408    gcc-14.3.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260408    gcc-14.3.0
csky                  randconfig-002-20260408    gcc-14.3.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260408    clang-23
hexagon               randconfig-002-20260408    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260408    clang-20
i386                  randconfig-002-20260408    clang-20
i386                  randconfig-003-20260408    clang-20
i386                  randconfig-004-20260408    clang-20
i386                  randconfig-005-20260408    clang-20
i386                  randconfig-006-20260408    clang-20
i386                  randconfig-007-20260408    clang-20
i386                  randconfig-011-20260408    gcc-14
i386                  randconfig-012-20260408    gcc-14
i386                  randconfig-013-20260408    gcc-14
i386                  randconfig-014-20260408    gcc-14
i386                  randconfig-015-20260408    gcc-14
i386                  randconfig-016-20260408    gcc-14
i386                  randconfig-017-20260408    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-002-20260408    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260408    clang-23
nios2                 randconfig-002-20260408    clang-23
openrisc                         allmodconfig    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260408    gcc-8.5.0
parisc                randconfig-002-20260408    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                   motionpro_defconfig    clang-23
powerpc               randconfig-001-20260408    gcc-8.5.0
powerpc               randconfig-002-20260408    gcc-8.5.0
powerpc64             randconfig-001-20260408    gcc-8.5.0
powerpc64             randconfig-002-20260408    gcc-8.5.0
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260408    gcc-15.2.0
riscv                 randconfig-002-20260408    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260408    gcc-15.2.0
sh                    randconfig-002-20260408    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260408    gcc-14
sparc                 randconfig-002-20260408    gcc-14
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260408    gcc-14
sparc64               randconfig-002-20260408    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260408    gcc-14
um                    randconfig-002-20260408    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260408    clang-20
x86_64      buildonly-randconfig-002-20260408    clang-20
x86_64      buildonly-randconfig-003-20260408    clang-20
x86_64      buildonly-randconfig-004-20260408    clang-20
x86_64      buildonly-randconfig-005-20260408    clang-20
x86_64      buildonly-randconfig-006-20260408    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260408    gcc-12
x86_64                randconfig-002-20260408    gcc-12
x86_64                randconfig-003-20260408    gcc-12
x86_64                randconfig-004-20260408    gcc-12
x86_64                randconfig-005-20260408    gcc-12
x86_64                randconfig-006-20260408    gcc-12
x86_64                randconfig-011-20260408    clang-20
x86_64                randconfig-012-20260408    clang-20
x86_64                randconfig-013-20260408    clang-20
x86_64                randconfig-014-20260408    clang-20
x86_64                randconfig-015-20260408    clang-20
x86_64                randconfig-016-20260408    clang-20
x86_64                randconfig-071-20260408    clang-20
x86_64                randconfig-072-20260408    clang-20
x86_64                randconfig-073-20260408    clang-20
x86_64                randconfig-074-20260408    clang-20
x86_64                randconfig-075-20260408    clang-20
x86_64                randconfig-076-20260408    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    gcc-11.5.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260408    gcc-14
xtensa                randconfig-002-20260408    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
