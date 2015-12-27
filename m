From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 2/3] Input: cyttsp - add device tree support
Date: Mon, 28 Dec 2015 01:33:12 +0800
Message-ID: <201512280113.AVgpxiIx%fengguang.wu@intel.com>
References: <942d2d3ba128ee9597e02144cc913273433d42d5.1451231697.git.oreste.salerno@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43893 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648AbbL0Re3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 27 Dec 2015 12:34:29 -0500
Content-Disposition: inline
In-Reply-To: <942d2d3ba128ee9597e02144cc913273433d42d5.1451231697.git.oreste.salerno@tomtom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, fery@cypress.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, oreste.salerno@tomtom.com

[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
Hi Oreste,

[auto build test WARNING on input/next]
[also build test WARNING on v4.4-rc6 next-20151223]

url:    https://github.com/0day-ci/linux/commits/Oreste-Salerno/Add-device-tree-support-to-the-cyttsp-driver/20151228-002949
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/input/touchscreen/cyttsp_core.c:637:9-16: WARNING: ERR_CAST can be used with pdata

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
