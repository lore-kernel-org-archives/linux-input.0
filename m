Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793161569;
	b=uynbFshr7tg8scRLvR/2a+vS6MUAf0LISjCTAT+wiS+hjTnCO8QK+2vAokFbexXqFb3M
	 FuqQeyx5z6kugxvYaQhJ6aUVjG/tkEZe9or0+qOeNCs2InmfpOqe2N6Esywxv9goi40rN
	 gjbKxKQmeav2EtX8c5MzjwMIi6pzfPvGBLtbDCGPV2xpx6kLxWa8MQZZMB+MEsjh5ihNj
	 A0gb5KsCPw91WEXFk2o0BOTZ1OhDG/W2x0OHv0mmJXhIKPHNOFad8/5qLJu1EN9ZPsiQr
	 BCN7ska42R7VcDQObzj9TBaPvc/cqjS9bxPJx0tnetP4E6tP30Vh08LRxy/h2B8a+NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793161569;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=+a/3/XS3YgFOJ1rTHNOmW/SE0M3omw2CzcOMMWmkU0M=;
	b=4R+oyO418Xq8ERLguSAKqQmFHElrotzIwjpog63HSpDNlZPAYVta64ohtqm6xaDNdIrY
	 go9fcqNEzF1fwAD2OnupIu3zOFC6p33m03OsJ+V2QDxXQsN0tuXkXOHqbZY7N854Wu/xI
	 GaJ1/M6uNls/9tzJj/pwgIo7TWC61iVw57LlHbKojbHUxEEq71PHbU/Bu7BkmmHi1RNky
	 lTULxJmKEnfYasN9C0RXxyz9UWwk6r3jqTKrCAaa26FuThoBuN9h/CZG9lhQ1Z3TLTnLw
	 OhM1gKn2u5jpmE+5q0ZZMcdWWuZZqGtBNAWcXan5K9C8mIq4/gGzBtHJdZfLHBM+6gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KO6u1rRK;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1A5606A31E
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 04:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B1A5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KO6u1rRK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793161568; x=1824697568;
  h=date:from:to:cc:subject:message-id;
  bh=1dyGBnpihsCjOq2wvtsDQh8oAyC8AbFUuRMK3ZUUWC0=;
  b=KO6u1rRKfI+k7k/RysGnllUWg57FOTHZB5kBLmWQkGCHPQcJpq/2ZHij
   MkY4XttkYzLoVaDEQ4yxJ1761ghWeEXlBQDNVOewVbVOhmz2QkgAIx6qp
   0ilDtw0TvF7E3Mav1hzk0CRCxkfFhZKsCPT9QQqeMiKaqfA5XaE1ssEXy
   aCfYVntWnKxiB5TcPuNOUFyQoOZF9lYs3j6ESacJIqfRQvssWVKlbD29J
   /0B4L4mnEF7uZTio1+EQ4VMwgGfhw0ZQpQkGdRD5dn2RXbnAMsCdL3rr+
   wRWzlCxl2QDR1Kfi3h7Oc1u1RG73J+pSNWn3bo8MLturKusB+G0/sRjol
   w==;
X-CSE-ConnectionGUID: +8eiNCdMQGin226OdVclFQ==
X-CSE-MsgGUID: DS8DnvmqSY6KnRuZ8wqnDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1904405"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1904405"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 21:26:08 -0700
X-CSE-ConnectionGUID: 6uWpKVS8Qo6aYflrZ1UTEg==
X-CSE-MsgGUID: k5t07ICOQOiDf0mfVooHBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4593921"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 27 Oct 2026 21:26:07 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xLvEi-00000000YAu-1NpQ;
	Wed, 28 Oct 2026 04:26:04 +0000
Date: Wed, 28 Oct 2026 12:25:44 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:master] BUILD SUCCESS
 d0886ec2b6cffae3c1eaa24bd0bcc5bd03fe5610
Message-ID: <202610281240.HqPu2GIK-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git master
branch HEAD: d0886ec2b6cffae3c1eaa24bd0bcc5bd03fe5610  Input: drv260x - switch to using fsleep()

elapsed time: 3202m

configs tested: 408
configs skipped: 16

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    clang-24
alpha                                defconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.2.0
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                               allyesconfig    gcc-16.2.0
arc                           axs101_defconfig    gcc-16.2.0
arc                       axs103_smp_defconfig    clang-17
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261026    clang-24
arc                   randconfig-1000-20261027    gcc-10.5.0
arc                   randconfig-1000-20261028    gcc-8.5.0
arc                   randconfig-1001-20261026    clang-24
arc                   randconfig-1001-20261027    gcc-10.5.0
arc                   randconfig-1001-20261028    gcc-8.5.0
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                      am200epdkit_defconfig    gcc-16.2.0
arm                          assabet_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                             hisi_defconfig    gcc-16.2.0
arm                        imx_v4_v5_defconfig    clang-24
arm                            imxrt_defconfig    clang-17
arm                    milbeaut_m10v_defconfig    gcc-16.2.0
arm                             mmp2_defconfig    clang-24
arm                              mxs_defconfig    clang-17
arm                            omap1_defconfig    clang-24
arm                          orion5x_defconfig    clang-17
arm                   randconfig-1000-20261026    clang-24
arm                   randconfig-1000-20261027    gcc-10.5.0
arm                   randconfig-1000-20261028    gcc-8.5.0
arm                   randconfig-1001-20261026    clang-24
arm                   randconfig-1001-20261027    gcc-10.5.0
arm                   randconfig-1001-20261028    gcc-8.5.0
arm                   randconfig-1002-20261026    clang-24
arm                   randconfig-1002-20261027    gcc-10.5.0
arm                   randconfig-1002-20261028    gcc-8.5.0
arm                   randconfig-1003-20261026    clang-24
arm                   randconfig-1003-20261027    gcc-10.5.0
arm                   randconfig-1003-20261028    gcc-8.5.0
arm                          s5pv210_defconfig    clang-24
arm                            sama7_defconfig    clang-24
arm                        versatile_defconfig    gcc-16.2.0
arm                     vt8500_v6_v7_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261026    clang-24
arm64                 randconfig-1000-20261027    gcc-8.5.0
arm64                 randconfig-1000-20261028    clang-22
arm64                 randconfig-1001-20261026    clang-24
arm64                 randconfig-1001-20261027    gcc-8.5.0
arm64                 randconfig-1001-20261028    clang-22
arm64                 randconfig-1002-20261026    clang-24
arm64                 randconfig-1002-20261027    gcc-8.5.0
arm64                 randconfig-1002-20261028    clang-22
arm64                 randconfig-1003-20261026    clang-24
arm64                 randconfig-1003-20261027    gcc-8.5.0
arm64                 randconfig-1003-20261028    clang-22
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261026    clang-24
csky                  randconfig-1000-20261027    gcc-8.5.0
csky                  randconfig-1000-20261028    clang-22
csky                  randconfig-1001-20261026    clang-24
csky                  randconfig-1001-20261027    gcc-8.5.0
csky                  randconfig-1001-20261028    clang-22
hexagon                           alldefconfig    clang-17
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261026    clang-24
hexagon               randconfig-1000-20261027    clang-24
hexagon               randconfig-1000-20261028    clang-17
hexagon               randconfig-1001-20261026    clang-24
hexagon               randconfig-1001-20261027    clang-24
hexagon               randconfig-1001-20261028    clang-17
i386                              alldefconfig    clang-24
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261026    clang-22
i386        buildonly-randconfig-1000-20261027    clang-22
i386        buildonly-randconfig-1000-20261028    clang-22
i386        buildonly-randconfig-1001-20261026    clang-22
i386        buildonly-randconfig-1001-20261027    clang-22
i386        buildonly-randconfig-1001-20261028    clang-22
i386        buildonly-randconfig-1002-20261026    clang-22
i386        buildonly-randconfig-1002-20261027    clang-22
i386        buildonly-randconfig-1002-20261028    clang-22
i386        buildonly-randconfig-1003-20261026    clang-22
i386        buildonly-randconfig-1003-20261027    clang-22
i386        buildonly-randconfig-1003-20261028    clang-22
i386        buildonly-randconfig-1004-20261026    clang-22
i386        buildonly-randconfig-1004-20261027    clang-22
i386        buildonly-randconfig-1004-20261028    clang-22
i386        buildonly-randconfig-1005-20261026    clang-22
i386        buildonly-randconfig-1005-20261027    clang-22
i386        buildonly-randconfig-1005-20261028    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261026    gcc-14
i386                  randconfig-1000-20261027    gcc-14
i386                  randconfig-1001-20261026    gcc-14
i386                  randconfig-1001-20261027    gcc-14
i386                  randconfig-1002-20261026    gcc-14
i386                  randconfig-1002-20261027    gcc-14
i386                  randconfig-1003-20261026    gcc-14
i386                  randconfig-1003-20261027    gcc-14
i386                  randconfig-1004-20261026    gcc-14
i386                  randconfig-1004-20261027    gcc-14
i386                  randconfig-1005-20261026    gcc-14
i386                  randconfig-1005-20261027    gcc-14
i386                  randconfig-1006-20261026    gcc-14
i386                  randconfig-1006-20261027    gcc-14
i386                  randconfig-1007-20261026    clang-22
i386                  randconfig-1007-20261027    gcc-14
i386                  randconfig-1008-20261026    clang-22
i386                  randconfig-1008-20261027    gcc-14
i386                  randconfig-1009-20261026    clang-22
i386                  randconfig-1009-20261027    gcc-14
i386                  randconfig-1010-20261026    clang-22
i386                  randconfig-1010-20261027    gcc-14
i386                  randconfig-1011-20261026    clang-22
i386                  randconfig-1011-20261027    gcc-14
i386                  randconfig-1012-20261026    clang-22
i386                  randconfig-1012-20261027    gcc-14
i386                  randconfig-1013-20261026    clang-22
i386                  randconfig-1013-20261027    gcc-14
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261026    clang-24
loongarch             randconfig-1000-20261027    clang-24
loongarch             randconfig-1000-20261028    clang-17
loongarch             randconfig-1001-20261026    clang-24
loongarch             randconfig-1001-20261027    clang-24
loongarch             randconfig-1001-20261028    clang-17
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.2.0
m68k                           amiga_defconfig    clang-17
m68k                          apollo_defconfig    clang-17
m68k                          apollo_defconfig    clang-24
m68k                                 defconfig    clang-24
m68k                        m5275evb_defconfig    clang-17
m68k                        m5329evb_defconfig    clang-17
m68k                        m5329evb_defconfig    gcc-16.2.0
m68k                        m5475evb_defconfig    clang-24
m68k                         mvme147_defconfig    clang-17
m68k                          nettel_defconfig    gcc-16.2.0
m68k                            sun3_defconfig    clang-24
microblaze                        alldefconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                         bcm47xx_defconfig    clang-17
mips                          bigsur_defconfig    clang-24
mips                       bmips_stb_defconfig    clang-17
mips                       loongson1_defconfig    gcc-16.2.0
mips                       maltaaprp_defconfig    clang-17
mips                     maltaup_xpa_defconfig    gcc-16.2.0
mips                            mtx1_defconfig    gcc-16.2.0
mips                         qi_lb60_defconfig    clang-17
mips                           rb532_defconfig    clang-24
mips                    sb1250_swarm_defconfig    gcc-16.2.0
nios2                          3c120_defconfig    clang-24
nios2                             allmodconfig    clang-20
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261026    clang-24
nios2                 randconfig-1000-20261027    clang-24
nios2                 randconfig-1000-20261028    clang-17
nios2                 randconfig-1001-20261026    clang-24
nios2                 randconfig-1001-20261027    clang-24
nios2                 randconfig-1001-20261028    clang-17
openrisc                          allmodconfig    clang-20
openrisc                          allmodconfig    gcc-11.5.0
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc                        virt_defconfig    clang-24
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261026    gcc-14.4.0
parisc                randconfig-1000-20261027    clang-22
parisc                randconfig-1000-20261028    clang-19
parisc                randconfig-1001-20261026    gcc-14.4.0
parisc                randconfig-1001-20261027    clang-22
parisc                randconfig-1001-20261028    clang-19
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                     amigaone_defconfig    gcc-16.2.0
powerpc                      asp8347_defconfig    clang-24
powerpc                       bamboo_defconfig    clang-17
powerpc                       bamboo_defconfig    clang-24
powerpc                       bamboo_defconfig    gcc-16.2.0
powerpc                    currituck_defconfig    clang-17
powerpc                    currituck_defconfig    gcc-16.2.0
powerpc                        eiger_defconfig    clang-24
powerpc                      ep8248e_defconfig    gcc-16.2.0
powerpc                     ge_imp3a_defconfig    gcc-16.2.0
powerpc                        holly_defconfig    clang-24
powerpc                  linkstation_defconfig    clang-17
powerpc                    microwatt_defconfig    clang-24
powerpc                    microwatt_defconfig    gcc-16.2.0
powerpc                      mpc5200_defconfig    clang-24
powerpc                  mpc8313_rdb_defconfig    clang-24
powerpc                  mpc8315_rdb_defconfig    clang-17
powerpc                     mvme5100_defconfig    clang-24
powerpc                      powernv_defconfig    gcc-16.2.0
powerpc                       ppc64e_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261026    gcc-14.4.0
powerpc               randconfig-1000-20261027    clang-22
powerpc               randconfig-1000-20261028    clang-19
powerpc               randconfig-1001-20261026    gcc-14.4.0
powerpc               randconfig-1001-20261027    clang-22
powerpc               randconfig-1001-20261028    clang-19
powerpc                     sam440ep_defconfig    clang-17
powerpc                      skiroot_defconfig    clang-24
powerpc                      stx_gp3_defconfig    clang-17
powerpc                      tqm8540_defconfig    clang-24
powerpc                      tqm8548_defconfig    gcc-16.2.0
powerpc                      tqm8555_defconfig    clang-24
powerpc                      tqm8560_defconfig    clang-17
powerpc64             randconfig-1000-20261026    gcc-14.4.0
powerpc64             randconfig-1000-20261027    clang-22
powerpc64             randconfig-1000-20261028    clang-19
powerpc64             randconfig-1001-20261026    gcc-14.4.0
powerpc64             randconfig-1001-20261027    clang-22
powerpc64             randconfig-1001-20261028    clang-19
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261026    gcc-13.5.0
riscv                 randconfig-1000-20261027    gcc-16.2.0
riscv                 randconfig-1000-20261028    gcc-11.5.0
riscv                 randconfig-1001-20261026    gcc-13.5.0
riscv                 randconfig-1001-20261027    gcc-16.2.0
riscv                 randconfig-1001-20261028    gcc-11.5.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261026    gcc-13.5.0
s390                  randconfig-1000-20261027    gcc-16.2.0
s390                  randconfig-1000-20261028    gcc-11.5.0
s390                  randconfig-1001-20261026    gcc-13.5.0
s390                  randconfig-1001-20261027    gcc-16.2.0
s390                  randconfig-1001-20261028    gcc-11.5.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                         apsh4ad0a_defconfig    gcc-16.2.0
sh                                   defconfig    gcc-14
sh                         dreamcast_defconfig    gcc-16.2.0
sh                           r7780mp_defconfig    clang-24
sh                    randconfig-1000-20261026    gcc-13.5.0
sh                    randconfig-1000-20261027    gcc-16.2.0
sh                    randconfig-1000-20261028    gcc-11.5.0
sh                    randconfig-1001-20261026    gcc-13.5.0
sh                    randconfig-1001-20261027    gcc-16.2.0
sh                    randconfig-1001-20261028    gcc-11.5.0
sh                           rsk7201_defconfig    gcc-16.2.0
sh                           sdk7786_defconfig    gcc-16.2.0
sh                            se7705_defconfig    clang-24
sh                            se7712_defconfig    gcc-16.2.0
sh                            se7780_defconfig    clang-24
sh                            se7780_defconfig    gcc-16.2.0
sh                    secureedge5410_defconfig    clang-24
sh                            sh2007_defconfig    clang-17
sh                    sh7770_generic_defconfig    clang-17
sh                         sh7785lcr_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261026    gcc-14
sparc                 randconfig-1000-20261027    clang-20
sparc                 randconfig-1000-20261028    gcc-12
sparc                 randconfig-1001-20261026    gcc-14
sparc                 randconfig-1001-20261027    clang-20
sparc                 randconfig-1001-20261028    gcc-12
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261026    gcc-14
sparc64               randconfig-1000-20261027    clang-20
sparc64               randconfig-1000-20261028    gcc-12
sparc64               randconfig-1001-20261026    gcc-14
sparc64               randconfig-1001-20261027    clang-20
sparc64               randconfig-1001-20261028    gcc-12
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261026    gcc-14
um                    randconfig-1000-20261027    clang-20
um                    randconfig-1000-20261028    gcc-12
um                    randconfig-1001-20261026    gcc-14
um                    randconfig-1001-20261027    clang-20
um                    randconfig-1001-20261028    gcc-12
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261026    clang-22
x86_64      buildonly-randconfig-1000-20261027    gcc-14
x86_64      buildonly-randconfig-1000-20261028    clang-22
x86_64      buildonly-randconfig-1001-20261026    clang-22
x86_64      buildonly-randconfig-1001-20261027    gcc-14
x86_64      buildonly-randconfig-1001-20261028    clang-22
x86_64      buildonly-randconfig-1002-20261026    clang-22
x86_64      buildonly-randconfig-1002-20261027    gcc-14
x86_64      buildonly-randconfig-1002-20261028    clang-22
x86_64      buildonly-randconfig-1003-20261026    clang-22
x86_64      buildonly-randconfig-1003-20261027    gcc-14
x86_64      buildonly-randconfig-1003-20261028    clang-22
x86_64      buildonly-randconfig-1004-20261026    clang-22
x86_64      buildonly-randconfig-1004-20261027    gcc-14
x86_64      buildonly-randconfig-1004-20261028    clang-22
x86_64      buildonly-randconfig-1005-20261026    clang-22
x86_64      buildonly-randconfig-1005-20261027    gcc-14
x86_64      buildonly-randconfig-1005-20261028    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261026    clang-22
x86_64                randconfig-1000-20261027    gcc-14
x86_64                randconfig-1000-20261028    clang-22
x86_64                randconfig-1001-20261026    clang-22
x86_64                randconfig-1001-20261027    gcc-14
x86_64                randconfig-1001-20261028    clang-22
x86_64                randconfig-1002-20261026    clang-22
x86_64                randconfig-1002-20261027    gcc-14
x86_64                randconfig-1002-20261028    clang-22
x86_64                randconfig-1003-20261026    clang-22
x86_64                randconfig-1003-20261027    gcc-14
x86_64                randconfig-1003-20261028    clang-22
x86_64                randconfig-1004-20261026    clang-22
x86_64                randconfig-1004-20261027    gcc-14
x86_64                randconfig-1004-20261028    clang-22
x86_64                randconfig-1005-20261026    clang-22
x86_64                randconfig-1005-20261027    gcc-14
x86_64                randconfig-1005-20261028    clang-22
x86_64                randconfig-1006-20261026    gcc-14
x86_64                randconfig-1006-20261027    clang-22
x86_64                randconfig-1006-20261028    gcc-14
x86_64                randconfig-1007-20261026    gcc-14
x86_64                randconfig-1007-20261027    clang-22
x86_64                randconfig-1007-20261028    gcc-14
x86_64                randconfig-1008-20261026    gcc-14
x86_64                randconfig-1008-20261027    clang-22
x86_64                randconfig-1008-20261028    gcc-14
x86_64                randconfig-1009-20261026    gcc-14
x86_64                randconfig-1009-20261027    clang-22
x86_64                randconfig-1009-20261028    gcc-14
x86_64                randconfig-1010-20261026    gcc-14
x86_64                randconfig-1010-20261027    clang-22
x86_64                randconfig-1010-20261028    gcc-14
x86_64                randconfig-1011-20261026    gcc-14
x86_64                randconfig-1011-20261027    clang-22
x86_64                randconfig-1011-20261028    gcc-14
x86_64                randconfig-1012-20261026    gcc-14
x86_64                randconfig-1012-20261027    clang-22
x86_64                randconfig-1012-20261028    gcc-12
x86_64                randconfig-1013-20261026    gcc-14
x86_64                randconfig-1013-20261027    clang-22
x86_64                randconfig-1013-20261028    gcc-12
x86_64                randconfig-1014-20261026    gcc-14
x86_64                randconfig-1014-20261027    clang-22
x86_64                randconfig-1014-20261028    gcc-12
x86_64                randconfig-1015-20261026    gcc-14
x86_64                randconfig-1015-20261027    clang-22
x86_64                randconfig-1015-20261028    gcc-12
x86_64                randconfig-1016-20261026    gcc-14
x86_64                randconfig-1016-20261027    clang-22
x86_64                randconfig-1016-20261028    gcc-12
x86_64                randconfig-1017-20261026    gcc-14
x86_64                randconfig-1017-20261027    clang-22
x86_64                randconfig-1017-20261028    gcc-12
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                   audio_kc705_defconfig    gcc-16.2.0
xtensa                 generic_kc705_defconfig    gcc-16.2.0
xtensa                   nommu_kc705_defconfig    clang-24
xtensa                randconfig-1000-20261026    gcc-14
xtensa                randconfig-1000-20261027    clang-20
xtensa                randconfig-1000-20261028    gcc-12
xtensa                randconfig-1001-20261026    gcc-14
xtensa                randconfig-1001-20261027    clang-20
xtensa                randconfig-1001-20261028    gcc-12
xtensa                     xip_kc705_defconfig    gcc-16.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
