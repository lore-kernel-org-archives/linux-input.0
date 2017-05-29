From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] Input: Add driver for Cypress Generation 5
 touchscreen
Date: Tue, 30 May 2017 01:16:20 +0800
Message-ID: <201705300154.RtG0si2X%fengguang.wu@intel.com>
References: <20170529144538.29187-2-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:38938 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbdE2RRG (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 29 May 2017 13:17:06 -0400
Content-Disposition: inline
In-Reply-To: <20170529144538.29187-2-mylene.josserand@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: kbuild-all@01.org, dmitry.torokhov@gmail.com, fery@cypress.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, mylene.josserand@free-electrons.com, thomas.petazzoni@free-electrons.com, maxime.ripard@free-electrons.com

Hi Mylène,

[auto build test WARNING on input/next]
[also build test WARNING on v4.12-rc3 next-20170529]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Myl-ne-Josserand/Input-Add-Cypress-Gen5-Touchscreen-driver/20170529-230006
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/input/touchscreen/cyttsp5.c:1162:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
