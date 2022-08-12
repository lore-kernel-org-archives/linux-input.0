Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A81BC00140
	for <linux-input@archiver.kernel.org>; Fri, 12 Aug 2022 11:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbiHLLtn (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 12 Aug 2022 07:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbiHLLtm (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 12 Aug 2022 07:49:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75844AFAF7
        for <linux-input@vger.kernel.org>; Fri, 12 Aug 2022 04:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660304982; x=1691840982;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jWJCRYC824Sg2Suo2vCCYM7Np9VzoDt6r7z1Y/W0MrQ=;
  b=d8ztds2prsd8LOt0772ciUvRt7ktIQcBTNGG5BfUzFiF7d8FrYiyxF7h
   pGd+yREUSs7HPQ1cQDHw9fY4n+RhTOblynnosWvK6b4/ApgdZ5+MZNLpz
   ZYYU25pV6+Dey2NKjGrusFTM17pbktqcWXo8iqPwN0J7mqC5FXu7IgTeD
   SRuZDk702oTG1J+ggt/x6P3IhhTXqnHpUlsCVjzdTvqyJdmVLmswgL0ma
   //ihIe+z9iwMM+FKIEtCTLlOUCj5EFiQ5D3xsR4WiM8IFXnkPZXTPl6ni
   eiX7qCqDQwgp9z8g6hRPwF0o/XzNjT6V8DMChMgzAolDkbTbXvyWr2ZgM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="289149707"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="289149707"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 04:49:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="933693642"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 12 Aug 2022 04:49:40 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMTAa-0000U3-1H;
        Fri, 12 Aug 2022 11:49:40 +0000
Date:   Fri, 12 Aug 2022 19:49:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org
Subject: [dtor-input:for-linus] BUILD SUCCESS
 425fe4709c76e35f93f4c0e50240f0b61b2a2e54
Message-ID: <62f63e4e.hJ38oA3QB57CQLIl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
branch HEAD: 425fe4709c76e35f93f4c0e50240f0b61b2a2e54  Input: goodix - add support for GT1158

elapsed time: 717m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arm                                 defconfig
i386                          randconfig-a001
powerpc                          allmodconfig
i386                                defconfig
sh                               allmodconfig
i386                          randconfig-a003
arm64                            allyesconfig
i386                          randconfig-a014
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                           allyesconfig
i386                          randconfig-a005
arm                              allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220811
mips                             allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a015
x86_64                              defconfig
powerpc                           allnoconfig
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a006
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a013
x86_64                          rhel-8.3-func
x86_64                        randconfig-a011
x86_64                         rhel-8.3-kunit
i386                             allyesconfig
ia64                             allmodconfig

clang tested configs:
i386                          randconfig-a013
hexagon              randconfig-r045-20220811
i386                          randconfig-a015
riscv                randconfig-r042-20220811
i386                          randconfig-a002
hexagon              randconfig-r041-20220811
i386                          randconfig-a011
i386                          randconfig-a004
x86_64                        randconfig-a005
i386                          randconfig-a006
s390                 randconfig-r044-20220811
x86_64                        randconfig-a001
x86_64                        randconfig-a014
x86_64                        randconfig-a003
x86_64                        randconfig-a012
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
