From: kbuild test robot <fengguang.wu@intel.com>
Subject: [input:next 1341/1344] drivers/input/touchscreen/ft6236.c:316:3-8:
 No need to set .owner here. The core will do it.
Date: Tue, 6 Oct 2015 09:35:30 +0800
Message-ID: <201510060921.YCPWmDCt%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:10074 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751265AbbJFBgN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 5 Oct 2015 21:36:13 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc: kbuild-all@01.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
head:   c65cf815653ec64e73d40819806c2d1aed91681e
commit: 92deea1350f9fa97a841d45cd1f8228d5e8aa667 [1341/1344] Input: add support for FocalTech FT6236 touchscreen controller


coccinelle warnings: (new ones prefixed by >>)

>> drivers/input/touchscreen/ft6236.c:316:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
