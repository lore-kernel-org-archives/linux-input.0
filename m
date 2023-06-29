Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797A7EB64D9
	for <linux-input@archiver.kernel.org>; Thu, 29 Jun 2023 19:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjF2Tuo (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 29 Jun 2023 15:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjF2Tun (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 29 Jun 2023 15:50:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9059B212C;
        Thu, 29 Jun 2023 12:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688068241; x=1719604241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pu2E/ANiZKrmpINz8MZ20SMOBjaaOcCaQ22Kk3xNhbE=;
  b=fSndCD84LqHYuAnt9DOQdLyQ/ms3CEetDtokpy+g7vkYkd01P9eIGz+r
   nS//jrzgudqX3SXP5V6KsB46QTJvHz5WmorgBzoLz9aTjJHeNoncoNLMK
   zkHXr7+xub0xGwoWIw4Ae0uc161krl+R9hYVJZrc06tu+atrX4zdSGLFR
   EfEabSVLWZfK3imkrhpFpxANb9vups53QnkWcWi2DI1RiVR8IjZA0o9PE
   QMzQoLFmUaBNwcmLamwYrXXFwIz6klRdwn5MW5qQDGd8RoXXQNooRU58H
   8BDU87TIrFjGMv/UTZTS9295vYheSBXglA1v1qvcifLI4sGPW2EFjvdNP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="365701532"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="365701532"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 12:50:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="667687546"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="667687546"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 29 Jun 2023 12:50:39 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qExf4-000EMX-0Q;
        Thu, 29 Jun 2023 19:50:38 +0000
Date:   Fri, 30 Jun 2023 03:49:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: steelseries: Add support for Arctis 1 XBox
Message-ID: <202306300309.WEpmiIaW-lkp@intel.com>
References: <20230629172041.3771-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629172041.3771-1-hadess@hadess.net>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi Bastien,

kernel test robot noticed the following build errors:

[auto build test ERROR on hid/for-next]
[also build test ERROR on v6.4 next-20230629]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bastien-Nocera/HID-steelseries-Add-support-for-Arctis-1-XBox/20230630-012252
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20230629172041.3771-1-hadess%40hadess.net
patch subject: [PATCH] HID: steelseries: Add support for Arctis 1 XBox
config: parisc-randconfig-r015-20230629 (https://download.01.org/0day-ci/archive/20230630/202306300309.WEpmiIaW-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230630/202306300309.WEpmiIaW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306300309.WEpmiIaW-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "usb_set_wireless_status" [drivers/hid/hid-steelseries.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
