From: kbuild test robot <fengguang.wu@intel.com>
Subject: [hid:for-4.8/alps 1/2] drivers/hid/hid-alps.c:139:3-9: ERROR:
 application of sizeof to pointer
Date: Sat, 18 Jun 2016 20:13:14 +0800
Message-ID: <201606182012.7NLmbFhz%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36739 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015AbcFRMN7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Jun 2016 08:13:59 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: kbuild-all@01.org, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Masaki Ota <masaki.ota@jp.alps.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-4.8/alps
head:   41f61ecc501ca970ae8d9955c57405dc4abfab5a
commit: 2562756dde550901c224e3805102bdfc17e7d13a [1/2] HID: add Alps I2C HID Touchpad-Stick support


coccinelle warnings: (new ones prefixed by >>)

>> drivers/hid/hid-alps.c:139:3-9: ERROR: application of sizeof to pointer
   drivers/hid/hid-alps.c:148:4-10: ERROR: application of sizeof to pointer

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
