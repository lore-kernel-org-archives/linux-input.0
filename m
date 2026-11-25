Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598024;
	b=eFbPzoN7xz4Oi5iz6pK+FY3Fj26CtnElOXFLZH9B6AlVbWrqJzTBmP1GNvLHgZwhie5B
	 5NmMCnClxEE/aERpCPRh407/sugKbzSyS/XYM5GaGfkil5D7xHGGKNSpRMmuYWo2Utuq0
	 bRHG1sbJqYa5LWA0hhDtCryFTb1cyeReyh/EAP03pUJWUgMKdGCtDqPQINmWm2hHHRaOz
	 GxLZSYA33TTlYyDJiUG7x2KbVu8Tza24x3G2Ocz0BJM10WMMsra6AfhgwAubp9yK9gD4/
	 wjmlqZq24hgcABaZD/aTCSFWtcEQ6070RzGC22gwiGWaM+Mhcw4DMoTjaPdikBKlgEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598024;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=e0XjxSO/p0dlvgV4FZ/CNdebx2TbOP6sE31xhhDdmCE=;
	b=Ls/31SZKu7XMRvv+i98gcxQ+il5/cWCLPKQRj15ysMKc5ayI0Ke/iP/QYabqD7bMHMMp
	 Cecn/ACGlQIbLaMvrZg/knydX6YA85vt7UIZqj6gN7pvu9UT0hjnuEOj2MgOB/Y3lSguh
	 VnSZLt6x16gnsUyCkRs8Ftd+oTTQEDB96NDnfNzOwHIFxumkeGJQg7GanF141Bk1ve0uz
	 /xlMZw9s5nh9/8Jf6kInzzgtiI5yYNbVADxErMRL1q8+zTUcT88HQf2PiPvXbW4+7NIvv
	 3h3vK3iDU+fKph9xrbOKcB8tbSTlQOc7d0XOmZZrrA61gsNg9ghCC+JqUJYNZAnubuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=frCtcO6e;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE9606A32E
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 09:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FCE9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=frCtcO6e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795598023; x=1827134023;
  h=date:from:to:cc:subject:message-id;
  bh=FHp09/w81FQOwY2KBYe1Lqx1YWqomS7NsGUTz8V+iiU=;
  b=frCtcO6eNWF9jmMA5GTPrcG6mOpuZBvZMHftx7CqC/2vkZeJ6gm3QHmr
   Nexy3bQ1hNS1rTYm0afw172vxPy9q/boUTQ8/2vWW5SI7LvUrEIWrOK0i
   OqqTX1H74Ff/t54gRfoYN4BIeRFEDZV201qnMfypYFtXjbJmxXmMeIk9k
   FO0ZrpsIM6hH8JH7yIbVimYlK6+6EaO+7xoRFgFQpXMiNUCA8XEma4lPm
   yftMw7pk52odnIWHe7POvrhVcvSe4fWmOP9VxKU0ZBRUy4Qqhfq3y4C6E
   8PJnECErc5RJ7YzGuUQIYIzZ1BQjl9f82Vg4hbk2XOXjFlc61+K8VJu0m
   w==;
X-CSE-ConnectionGUID: rqYcEx6LTTC0pw85IiIKFQ==
X-CSE-MsgGUID: V718NaWzT9yzqPd4os7b9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4482552"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4482552"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 01:13:42 -0800
X-CSE-ConnectionGUID: za2V5FADScu6N2DmOf9Bog==
X-CSE-MsgGUID: JDhMnkVaThWQkz4jtXWb3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="12098522"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 25 Nov 2026 01:13:40 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xW94M-00000001REG-0YAL;
	Wed, 25 Nov 2026 09:13:38 +0000
Date: Wed, 25 Nov 2026 17:12:57 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [dtor-input:ib:7.4-rc2-soc-button-array] BUILD SUCCESS
 ca48817d0260530960d52abb8d7905306fef1715
Message-ID: <20261125171257.joT5nLCt-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git ib/7.4-rc2-soc-button-array
branch HEAD: ca48817d0260530960d52abb8d7905306fef1715  Input: soc_button_array - convert to software nodes

elapsed time: 958m

configs tested: 507
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261124    gcc-11.5.0
alpha                 randconfig-2001-20261124    gcc-11.5.0
alpha                 randconfig-2200-20261124    gcc-8.5.0  smatch
alpha                randconfig-r2108-20261124    clang-18   cocci
alpha                randconfig-r2111-20261125    gcc-13.5.0 cocci
alpha                randconfig-r2300-20261124    gcc-14.4.0 sparse
alpha                randconfig-r2300-20261124    gcc-16.2.0 sparse
alpha                randconfig-r2306-20261124    gcc-16.2.0 sparse
alpha                randconfig-r2307-20261124    gcc-8.5.0  sparse
alpha                randconfig-r2310-20261124    gcc-16.2.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                          haps_hs_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261125    gcc-8.5.0
arc                   randconfig-1001-20261125    gcc-8.5.0
arc                   randconfig-2000-20261124    gcc-11.5.0
arc                   randconfig-2000-20261125    gcc-10.5.0
arc                   randconfig-2001-20261124    gcc-11.5.0
arc                   randconfig-2001-20261125    gcc-10.5.0
arc                   randconfig-2002-20261124    gcc-11.5.0
arc                   randconfig-2002-20261125    gcc-10.5.0
arc                   randconfig-2003-20261124    gcc-11.5.0
arc                   randconfig-2003-20261125    gcc-10.5.0
arc                   randconfig-2004-20261124    gcc-11.5.0
arc                   randconfig-2004-20261125    gcc-10.5.0
arc                   randconfig-2005-20261124    gcc-11.5.0
arc                   randconfig-2005-20261125    gcc-10.5.0
arc                   randconfig-2200-20261124    gcc-8.5.0  smatch
arc                  randconfig-r2100-20261124    gcc-12.5.0 cocci
arc                  randconfig-r2106-20261124    gcc-10.5.0 cocci
arc                  randconfig-r2107-20261124    gcc-8.5.0  cocci
arc                  randconfig-r2107-20261125    gcc-13.5.0 cocci
arc                  randconfig-r2301-20261124    clang-24   sparse
arc                  randconfig-r2301-20261124    gcc-14.4.0 sparse
arc                  randconfig-r2303-20261124    clang-22   sparse
arc                  randconfig-r2304-20261124    gcc-14.4.0 sparse
arc                  randconfig-r2306-20261124    gcc-14     sparse
arc                  randconfig-r2308-20261124    gcc-14     sparse
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                          assabet_defconfig    gcc-16.2.0
arm                          axm55xx_defconfig    gcc-16.2.0
arm                          bcm2835_defconfig    clang-17
arm                         clps711x_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                          lpc18xx_defconfig    clang-17
arm                          lpc32xx_defconfig    clang-17
arm                           moxart_defconfig    clang-17
arm                           moxart_defconfig    clang-24
arm                          mv78xx0_defconfig    clang-17
arm                          mv78xx0_defconfig    gcc-16.2.0
arm                           pxa168_defconfig    clang-17
arm                           pxa168_defconfig    gcc-16.2.0
arm                           pxa3xx_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261125    gcc-8.5.0
arm                   randconfig-1001-20261125    gcc-8.5.0
arm                   randconfig-1002-20261125    gcc-8.5.0
arm                   randconfig-1003-20261125    gcc-8.5.0
arm                   randconfig-2000-20261124    clang-17
arm                   randconfig-2001-20261124    clang-17
arm                   randconfig-2002-20261124    clang-17
arm                   randconfig-2200-20261124    clang-17   smatch
arm                  randconfig-r2100-20261124    gcc-16.2.0 cocci
arm                  randconfig-r2102-20261124    gcc-14.4.0 cocci
arm                  randconfig-r2104-20261124    clang-24   cocci
arm                  randconfig-r2302-20261124    clang-24   sparse
arm                  randconfig-r2302-20261124    gcc-14.4.0 sparse
arm                  randconfig-r2306-20261124    clang-22   sparse
arm                            sama7_defconfig    clang-17
arm                          socfpga_defconfig    clang-17
arm                           sp7021_defconfig    clang-24
arm                           sp7021_defconfig    gcc-16.2.0
arm                            u8500_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261125    clang-24
arm64                 randconfig-1001-20261125    clang-24
arm64                 randconfig-1002-20261125    clang-24
arm64                 randconfig-1003-20261125    clang-24
arm64                 randconfig-2000-20261124    clang-17
arm64                 randconfig-2001-20261124    clang-17
arm64                 randconfig-2002-20261124    clang-17
arm64                 randconfig-2200-20261124    gcc-16.2.0 smatch
arm64                randconfig-r2102-20261124    gcc-8.5.0  cocci
arm64                randconfig-r2105-20261124    gcc-8.5.0  cocci
arm64                randconfig-r2107-20261124    clang-18   cocci
arm64                randconfig-r2111-20261124    gcc-15.3.0 cocci
arm64                randconfig-r2304-20261124    gcc-16.2.0 sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261125    clang-24
csky                  randconfig-1001-20261125    clang-24
csky                  randconfig-2000-20261124    gcc-16.2.0
csky                  randconfig-2001-20261124    gcc-16.2.0
csky                  randconfig-2200-20261124    gcc-15.3.0 smatch
csky                 randconfig-r2103-20261124    clang-24   cocci
csky                 randconfig-r2106-20261124    clang-18   cocci
csky                 randconfig-r2110-20261124    clang-18   cocci
csky                 randconfig-r2111-20261124    gcc-11.5.0 cocci
csky                 randconfig-r2301-20261124    gcc-14.4.0 sparse
csky                 randconfig-r2302-20261124    gcc-14.4.0 sparse
csky                 randconfig-r2303-20261124    gcc-14.4.0 sparse
csky                 randconfig-r2304-20261124    gcc-16.2.0 sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261125    gcc-11.5.0
hexagon               randconfig-1001-20261125    gcc-11.5.0
hexagon               randconfig-2000-20261124    gcc-16.2.0
hexagon               randconfig-2001-20261124    gcc-16.2.0
hexagon               randconfig-2200-20261124    clang-24   smatch
hexagon              randconfig-r2108-20261124    gcc-11.5.0 cocci
hexagon              randconfig-r2110-20261124    gcc-11.5.0 cocci
hexagon              randconfig-r2300-20261124    gcc-14.4.0 sparse
hexagon              randconfig-r2303-20261124    clang-24   sparse
hexagon              randconfig-r2305-20261124    clang-22   sparse
hexagon              randconfig-r2311-20261124    clang-22   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261125    clang-22
i386        buildonly-randconfig-1001-20261125    clang-22
i386        buildonly-randconfig-1002-20261125    clang-22
i386        buildonly-randconfig-1003-20261125    clang-22
i386        buildonly-randconfig-1004-20261125    clang-22
i386        buildonly-randconfig-1005-20261125    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261125    clang-22
i386                  randconfig-1001-20261125    clang-22
i386                  randconfig-1002-20261125    clang-22
i386                  randconfig-1003-20261125    clang-22
i386                  randconfig-1004-20261125    clang-22
i386                  randconfig-1005-20261125    clang-22
i386                  randconfig-1006-20261125    clang-22
i386                  randconfig-2000-20261124    gcc-14
i386                  randconfig-2001-20261124    gcc-14
i386                  randconfig-2002-20261124    gcc-14
i386                  randconfig-2003-20261124    gcc-14
i386                  randconfig-2004-20261124    gcc-14
i386                  randconfig-2005-20261124    gcc-14
i386                  randconfig-2100-20261124    gcc-14     cocci
i386                  randconfig-2101-20261124    gcc-14     cocci
i386                  randconfig-2102-20261124    gcc-14     cocci
i386                  randconfig-2103-20261124    gcc-14     cocci
i386                  randconfig-2104-20261124    gcc-14     cocci
i386                  randconfig-2105-20261124    gcc-14     cocci
i386                  randconfig-2200-20261124    clang-22   smatch
i386                  randconfig-2300-20261124    gcc-14     sparse
i386                  randconfig-2301-20261124    gcc-14     sparse
i386                  randconfig-2302-20261124    gcc-14     sparse
i386                 randconfig-r2102-20261124    gcc-8.5.0  cocci
i386                 randconfig-r2110-20261124    gcc-11.5.0 cocci
i386                 randconfig-r2111-20261124    gcc-11.5.0 cocci
i386                 randconfig-r2307-20261124    gcc-8.5.0  sparse
i386                 randconfig-r2308-20261124    gcc-16.2.0 sparse
i386                 randconfig-r2311-20261124    gcc-16.2.0 sparse
i386                 randconfig-r2311-20261124    gcc-8.5.0  sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261125    gcc-11.5.0
loongarch             randconfig-1001-20261125    gcc-11.5.0
loongarch             randconfig-2000-20261124    clang-18
loongarch             randconfig-2001-20261124    clang-18
loongarch             randconfig-2200-20261124    gcc-16.2.0 smatch
loongarch            randconfig-r2105-20261124    gcc-14.4.0 cocci
loongarch            randconfig-r2110-20261124    gcc-10.5.0 cocci
loongarch            randconfig-r2305-20261124    gcc-14.4.0 sparse
loongarch            randconfig-r2306-20261124    gcc-8.5.0  sparse
loongarch            randconfig-r2307-20261124    gcc-14     sparse
loongarch            randconfig-r2308-20261124    clang-22   sparse
loongarch            randconfig-r2309-20261124    gcc-16.2.0 sparse
loongarch            randconfig-r2309-20261124    gcc-8.5.0  sparse
loongarch            randconfig-r2310-20261124    clang-22   sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                        m5235evb_defconfig    gcc-16.2.0
m68k                  randconfig-2000-20261124    gcc-11.5.0
m68k                  randconfig-2001-20261124    gcc-11.5.0
m68k                  randconfig-2200-20261124    gcc-10.5.0 smatch
m68k                 randconfig-r2101-20261124    gcc-8.5.0  cocci
m68k                 randconfig-r2105-20261124    gcc-15.3.0 cocci
m68k                 randconfig-r2105-20261124    gcc-16.2.0 cocci
m68k                 randconfig-r2106-20261124    gcc-14.4.0 cocci
m68k                 randconfig-r2107-20261124    gcc-11.5.0 cocci
m68k                 randconfig-r2108-20261124    gcc-10.5.0 cocci
m68k                 randconfig-r2111-20261124    gcc-8.5.0  cocci
m68k                 randconfig-r2301-20261124    gcc-14.4.0 sparse
m68k                           sun3x_defconfig    clang-17
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261124    gcc-11.5.0
microblaze            randconfig-2001-20261124    gcc-11.5.0
microblaze            randconfig-2200-20261124    gcc-8.5.0  smatch
microblaze           randconfig-r2100-20261124    gcc-14.4.0 cocci
microblaze           randconfig-r2101-20261124    gcc-14.4.0 cocci
microblaze           randconfig-r2106-20261125    gcc-13.5.0 cocci
microblaze           randconfig-r2108-20261124    gcc-15.3.0 cocci
microblaze           randconfig-r2108-20261125    gcc-13.5.0 cocci
microblaze           randconfig-r2110-20261124    gcc-8.5.0  cocci
microblaze           randconfig-r2300-20261124    clang-24   sparse
microblaze           randconfig-r2303-20261124    gcc-16.2.0 sparse
microblaze           randconfig-r2307-20261124    gcc-12.5.0 sparse
microblaze           randconfig-r2308-20261124    gcc-8.5.0  sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                           ath79_defconfig    clang-17
mips                        bmips_be_defconfig    gcc-16.2.0
mips                      decstation_defconfig    clang-17
mips                  decstation_r4k_defconfig    clang-17
mips                            gcw0_defconfig    clang-24
mips                            ip30_defconfig    clang-17
mips                            ip30_defconfig    gcc-16.2.0
mips                       maltasmvp_defconfig    gcc-16.2.0
mips                       pic32mzda_defconfig    clang-24
mips                  randconfig-2000-20261124    gcc-16.2.0
mips                  randconfig-2001-20261124    gcc-16.2.0
mips                  randconfig-2002-20261124    gcc-16.2.0
mips                  randconfig-2200-20261124    clang-20   smatch
mips                 randconfig-r2100-20261124    gcc-8.5.0  cocci
mips                 randconfig-r2101-20261124    gcc-12.5.0 cocci
mips                 randconfig-r2101-20261124    gcc-15.3.0 cocci
mips                 randconfig-r2108-20261124    gcc-14.4.0 cocci
mips                 randconfig-r2109-20261124    gcc-14.4.0 cocci
mips                 randconfig-r2304-20261124    clang-22   sparse
mips                          rt305x_defconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261125    gcc-11.5.0
nios2                 randconfig-1001-20261125    gcc-11.5.0
nios2                 randconfig-2000-20261124    clang-18
nios2                 randconfig-2001-20261124    clang-18
nios2                 randconfig-2200-20261124    gcc-11.5.0 smatch
nios2                randconfig-r2103-20261124    gcc-8.5.0  cocci
nios2                randconfig-r2104-20261124    gcc-12.5.0 cocci
nios2                randconfig-r2108-20261124    gcc-8.5.0  cocci
nios2                randconfig-r2109-20261124    gcc-11.5.0 cocci
nios2                randconfig-r2109-20261125    gcc-13.5.0 cocci
nios2                randconfig-r2307-20261124    clang-20   sparse
nios2                randconfig-r2308-20261124    gcc-12.5.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261124    gcc-16.2.0
openrisc              randconfig-2001-20261124    gcc-16.2.0
openrisc              randconfig-2002-20261124    gcc-16.2.0
openrisc              randconfig-2200-20261124    gcc-11.5.0 smatch
openrisc             randconfig-r2101-20261124    clang-24   cocci
openrisc             randconfig-r2103-20261124    gcc-12.5.0 cocci
openrisc             randconfig-r2103-20261124    gcc-16.2.0 cocci
openrisc             randconfig-r2103-20261124    gcc-8.5.0  cocci
openrisc             randconfig-r2104-20261124    gcc-15.3.0 cocci
openrisc             randconfig-r2104-20261124    gcc-16.2.0 cocci
openrisc             randconfig-r2106-20261124    gcc-15.3.0 cocci
openrisc             randconfig-r2111-20261124    clang-18   cocci
openrisc             randconfig-r2300-20261124    gcc-14.4.0 sparse
openrisc             randconfig-r2300-20261124    gcc-16.2.0 sparse
openrisc             randconfig-r2304-20261124    gcc-14.4.0 sparse
openrisc             randconfig-r2310-20261124    gcc-8.5.0  sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261125    clang-24
parisc                randconfig-1001-20261125    clang-24
parisc                randconfig-2000-20261124    clang-18
parisc                randconfig-2001-20261124    clang-18
parisc                randconfig-2200-20261124    gcc-9.5.0  smatch
parisc               randconfig-r2100-20261124    gcc-8.5.0  cocci
parisc               randconfig-r2102-20261124    gcc-15.3.0 cocci
parisc               randconfig-r2106-20261124    gcc-10.5.0 cocci
parisc               randconfig-r2109-20261124    gcc-8.5.0  cocci
parisc               randconfig-r2303-20261124    gcc-16.2.0 sparse
parisc               randconfig-r2305-20261124    gcc-16.2.0 sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                      asp8347_defconfig    clang-24
powerpc                  canyonlands_defconfig    gcc-16.2.0
powerpc                  mpc836x_rdk_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261125    clang-24
powerpc               randconfig-1001-20261125    clang-24
powerpc               randconfig-2000-20261124    clang-24
powerpc               randconfig-2001-20261124    clang-24
powerpc               randconfig-2002-20261124    clang-24
powerpc               randconfig-2200-20261124    clang-21   smatch
powerpc              randconfig-r2104-20261124    gcc-8.5.0  cocci
powerpc              randconfig-r2107-20261124    gcc-11.5.0 cocci
powerpc              randconfig-r2109-20261124    clang-18   cocci
powerpc              randconfig-r2302-20261124    clang-22   sparse
powerpc              randconfig-r2306-20261124    gcc-12.5.0 sparse
powerpc                      tqm8555_defconfig    clang-17
powerpc                          wii_defconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261125    clang-24
powerpc64             randconfig-1001-20261125    clang-24
powerpc64             randconfig-2000-20261124    clang-24
powerpc64             randconfig-2001-20261124    clang-24
powerpc64             randconfig-2002-20261124    clang-24
powerpc64             randconfig-2200-20261124    gcc-12.5.0 smatch
powerpc64            randconfig-r2103-20261124    gcc-14.4.0 cocci
powerpc64            randconfig-r2105-20261124    gcc-8.5.0  cocci
powerpc64            randconfig-r2109-20261124    gcc-10.5.0 cocci
powerpc64            randconfig-r2111-20261124    gcc-10.5.0 cocci
powerpc64            randconfig-r2302-20261124    gcc-16.2.0 sparse
powerpc64            randconfig-r2305-20261124    gcc-16.2.0 sparse
powerpc64            randconfig-r2308-20261124    clang-20   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv              nommu_k210_sdcard_defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261125    gcc-8.5.0
riscv                 randconfig-1001-20261125    gcc-8.5.0
riscv                 randconfig-2000-20261124    gcc-16.2.0
riscv                 randconfig-2001-20261124    gcc-16.2.0
riscv                 randconfig-2002-20261124    gcc-16.2.0
riscv                 randconfig-2003-20261124    gcc-16.2.0
riscv                 randconfig-2004-20261124    gcc-16.2.0
riscv                 randconfig-2005-20261124    gcc-16.2.0
riscv                 randconfig-2200-20261124    gcc-14.4.0 smatch
riscv                randconfig-r2101-20261124    gcc-8.5.0  cocci
riscv                randconfig-r2102-20261124    gcc-16.2.0 cocci
riscv                randconfig-r2103-20261124    gcc-15.3.0 cocci
riscv                randconfig-r2105-20261124    gcc-12.5.0 cocci
riscv                randconfig-r2105-20261124    gcc-16.2.0 cocci
riscv                randconfig-r2111-20261124    gcc-10.5.0 cocci
riscv                randconfig-r2301-20261124    clang-22   sparse
riscv                randconfig-r2309-20261124    clang-22   sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261125    gcc-8.5.0
s390                  randconfig-1001-20261125    gcc-8.5.0
s390                  randconfig-2000-20261124    clang-24
s390                  randconfig-2001-20261124    clang-24
s390                  randconfig-2002-20261124    clang-24
s390                  randconfig-2003-20261124    clang-24
s390                  randconfig-2004-20261124    clang-24
s390                  randconfig-2005-20261124    clang-24
s390                  randconfig-2200-20261124    clang-24   smatch
s390                 randconfig-r2102-20261124    gcc-16.2.0 cocci
s390                 randconfig-r2106-20261124    gcc-11.5.0 cocci
s390                 randconfig-r2107-20261124    gcc-10.5.0 cocci
s390                 randconfig-r2110-20261124    gcc-14.4.0 cocci
s390                 randconfig-r2304-20261124    clang-24   sparse
s390                 randconfig-r2310-20261124    gcc-8.5.0  sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                              espt_defconfig    clang-24
sh                    randconfig-1000-20261125    gcc-8.5.0
sh                    randconfig-1001-20261125    gcc-8.5.0
sh                    randconfig-2000-20261124    gcc-11.5.0
sh                    randconfig-2001-20261124    gcc-11.5.0
sh                    randconfig-2002-20261124    gcc-11.5.0
sh                    randconfig-2003-20261124    gcc-11.5.0
sh                    randconfig-2004-20261124    gcc-11.5.0
sh                    randconfig-2005-20261124    gcc-11.5.0
sh                    randconfig-2200-20261124    gcc-16.2.0 smatch
sh                   randconfig-r2101-20261124    gcc-16.2.0 cocci
sh                   randconfig-r2105-20261124    clang-24   cocci
sh                   randconfig-r2107-20261124    gcc-15.3.0 cocci
sh                   randconfig-r2108-20261124    gcc-11.5.0 cocci
sh                   randconfig-r2109-20261124    gcc-11.5.0 cocci
sh                   randconfig-r2302-20261124    gcc-16.2.0 sparse
sh                   randconfig-r2303-20261124    gcc-14.4.0 sparse
sh                   randconfig-r2309-20261124    gcc-12.5.0 sparse
sh                   randconfig-r2311-20261124    gcc-8.5.0  sparse
sh                            se7343_defconfig    gcc-16.2.0
sh                            se7780_defconfig    gcc-16.2.0
sh                         sh7757lcr_defconfig    gcc-16.2.0
sh                             shmin_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261125    gcc-12
sparc                 randconfig-1001-20261125    gcc-12
sparc                 randconfig-2000-20261124    gcc-8.5.0
sparc                 randconfig-2001-20261124    gcc-8.5.0
sparc                 randconfig-2200-20261124    gcc-11.5.0 smatch
sparc                randconfig-r2100-20261124    gcc-16.2.0 cocci
sparc                randconfig-r2103-20261124    gcc-16.2.0 cocci
sparc                randconfig-r2109-20261124    gcc-10.5.0 cocci
sparc                randconfig-r2110-20261124    gcc-10.5.0 cocci
sparc                randconfig-r2111-20261124    gcc-14.4.0 cocci
sparc                randconfig-r2301-20261124    gcc-16.2.0 sparse
sparc                randconfig-r2304-20261124    gcc-14.4.0 sparse
sparc                randconfig-r2306-20261124    gcc-8.5.0  sparse
sparc                randconfig-r2307-20261124    gcc-16.2.0 sparse
sparc                randconfig-r2308-20261124    gcc-8.5.0  sparse
sparc                randconfig-r2309-20261124    clang-20   sparse
sparc                randconfig-r2311-20261124    clang-20   sparse
sparc64                           alldefconfig    clang-24
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261125    gcc-12
sparc64               randconfig-1001-20261125    gcc-12
sparc64               randconfig-2000-20261124    gcc-8.5.0
sparc64               randconfig-2001-20261124    gcc-8.5.0
sparc64               randconfig-2200-20261124    clang-24   smatch
sparc64              randconfig-r2104-20261124    gcc-16.2.0 cocci
sparc64              randconfig-r2104-20261124    gcc-8.5.0  cocci
sparc64              randconfig-r2106-20261124    gcc-11.5.0 cocci
sparc64              randconfig-r2109-20261124    gcc-15.3.0 cocci
sparc64              randconfig-r2310-20261124    clang-20   sparse
sparc64              randconfig-r2310-20261124    gcc-12.5.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261125    gcc-12
um                    randconfig-1001-20261125    gcc-12
um                    randconfig-2000-20261124    gcc-8.5.0
um                    randconfig-2001-20261124    gcc-8.5.0
um                    randconfig-2200-20261124    gcc-14     smatch
um                   randconfig-r2100-20261124    clang-24   cocci
um                   randconfig-r2101-20261124    gcc-16.2.0 cocci
um                   randconfig-r2107-20261124    gcc-14.4.0 cocci
um                   randconfig-r2108-20261124    gcc-10.5.0 cocci
um                   randconfig-r2301-20261124    gcc-16.2.0 sparse
um                   randconfig-r2303-20261124    gcc-14.4.0 sparse
um                   randconfig-r2305-20261124    gcc-14.4.0 sparse
um                   randconfig-r2306-20261124    clang-20   sparse
um                   randconfig-r2309-20261124    gcc-8.5.0  sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261125    clang-22
x86_64      buildonly-randconfig-1001-20261125    clang-22
x86_64      buildonly-randconfig-1002-20261125    clang-22
x86_64      buildonly-randconfig-1003-20261125    clang-22
x86_64      buildonly-randconfig-1004-20261125    clang-22
x86_64      buildonly-randconfig-1005-20261125    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261125    clang-22
x86_64                randconfig-1001-20261125    clang-22
x86_64                randconfig-1002-20261125    clang-22
x86_64                randconfig-1003-20261125    clang-22
x86_64                randconfig-1004-20261125    clang-22
x86_64                randconfig-1005-20261125    clang-22
x86_64                randconfig-2000-20261124    gcc-14
x86_64                randconfig-2001-20261124    gcc-14
x86_64                randconfig-2002-20261124    gcc-14
x86_64                randconfig-2003-20261124    gcc-14
x86_64                randconfig-2004-20261124    gcc-14
x86_64                randconfig-2005-20261124    gcc-14
x86_64                randconfig-2100-20261124    gcc-14     cocci
x86_64                randconfig-2101-20261124    gcc-14     cocci
x86_64                randconfig-2102-20261124    gcc-14     cocci
x86_64                randconfig-2103-20261124    gcc-14     cocci
x86_64                randconfig-2104-20261124    gcc-14     cocci
x86_64                randconfig-2105-20261124    gcc-14     cocci
x86_64                randconfig-2200-20261124    gcc-14     smatch
x86_64                randconfig-2300-20261124    gcc-14     sparse
x86_64                randconfig-2301-20261124    gcc-14     sparse
x86_64                randconfig-2302-20261124    gcc-14     sparse
x86_64               randconfig-r2100-20261124    gcc-15.3.0 cocci
x86_64               randconfig-r2102-20261124    clang-24   cocci
x86_64               randconfig-r2102-20261124    gcc-12.5.0 cocci
x86_64               randconfig-r2106-20261124    gcc-8.5.0  cocci
x86_64               randconfig-r2110-20261124    gcc-15.3.0 cocci
x86_64               randconfig-r2300-20261124    clang-22   sparse
x86_64               randconfig-r2307-20261124    clang-22   sparse
x86_64               randconfig-r2311-20261124    gcc-14     sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                   audio_kc705_defconfig    clang-17
xtensa                           iss_defconfig    gcc-16.2.0
xtensa                randconfig-1000-20261125    gcc-12
xtensa                randconfig-1001-20261125    gcc-12
xtensa                randconfig-2000-20261124    gcc-16.2.0
xtensa                randconfig-2001-20261124    gcc-16.2.0
xtensa                randconfig-2200-20261124    gcc-9.5.0  smatch
xtensa               randconfig-r2104-20261124    gcc-14.4.0 cocci
xtensa               randconfig-r2110-20261125    gcc-13.5.0 cocci
xtensa               randconfig-r2305-20261124    clang-24   sparse
xtensa               randconfig-r2309-20261124    gcc-14     sparse
xtensa               randconfig-r2310-20261124    gcc-14     sparse
xtensa               randconfig-r2311-20261124    gcc-12.5.0 sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
