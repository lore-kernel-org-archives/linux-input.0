Return-Path: <SRS0=80SW=3J=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77063C33CA1
	for <linux-input@archiver.kernel.org>; Mon, 20 Jan 2020 18:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5362121835
	for <linux-input@archiver.kernel.org>; Mon, 20 Jan 2020 18:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgATSFx (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 20 Jan 2020 13:05:53 -0500
Received: from mga18.intel.com ([134.134.136.126]:38720 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgATSFx (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 20 Jan 2020 13:05:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 10:05:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,342,1574150400"; 
   d="scan'208";a="250031229"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jan 2020 10:05:49 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1itbQr-0007B1-CE; Tue, 21 Jan 2020 02:05:49 +0800
Date:   Tue, 21 Jan 2020 02:05:39 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Rishi Gupta <gupt21@gmail.com>
Cc:     kbuild-all@lists.01.org, jikos@kernel.org,
        benjamin.tissoires@redhat.com, wsa+renesas@sang-engineering.com,
        gregkh@linuxfoundation.org, linux-i2c@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rishi Gupta <gupt21@gmail.com>
Subject: Re: [PATCH v1 1/1] HID: mcp2221: add usb to i2c-smbus host bridge
 driver
Message-ID: <202001210143.iPz2kWmQ%lkp@intel.com>
References: <7b81210829dabdc96257084ff5b4cc97f2f2ebec.1579497275.git.gupt21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b81210829dabdc96257084ff5b4cc97f2f2ebec.1579497275.git.gupt21@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi Rishi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.5-rc7 next-20200117]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Rishi-Gupta/HID-mcp2221-add-usb-to-i2c-smbus-host-bridge-driver/20200120-133043
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git def9d2780727cec3313ed3522d0123158d87224d
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-131-g22978b6b-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/hid/hid-mcp2221.c:397:5: sparse: sparse: symbol 'mcp_smbus_xfer' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
