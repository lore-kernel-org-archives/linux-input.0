From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2 1/2] Input: edt-ft5x06 - Add support for regulator
Date: Sat, 30 Dec 2017 11:15:43 +0800
Message-ID: <201712301029.0opO7KPg%fengguang.wu@intel.com>
References: <20171228163336.28131-2-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:61432 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750741AbdL3DQZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 29 Dec 2017 22:16:25 -0500
Content-Disposition: inline
In-Reply-To: <20171228163336.28131-2-mylene.josserand@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: kbuild-all@01.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, wens@csie.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mylene.josserand@free-electrons.com, thomas.petazzoni@free-electrons.com, quentin.schulz@free-electrons.com

Hi Mylène,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.15-rc5 next-20171222]
[cannot apply to input/next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Myl-ne-Josserand/sun8i-a83t-Add-touchscreen-support-on-TBS-A711/20171230-091331
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/input/touchscreen/edt-ft5x06.c:1004:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
