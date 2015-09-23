From: kbuild test robot <fengguang.wu@intel.com>
Subject: [hid:for-4.4/debugfs-fixes 1/1] drivers/hid/hid-debug.c:1281:2-26:
 WARNING: NULL check before freeing functions like kfree, debugfs_remove,
 debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider
 reorganizing relevant code to avoid passing NULL values.
Date: Wed, 23 Sep 2015 18:56:15 +0800
Message-ID: <201509231813.MV4pJSrW%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35491 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751887AbbIWK5i (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Sep 2015 06:57:38 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
Cc: kbuild-all@01.org, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-4.4/debugfs-fixes
head:   9c537bf6cad4782573d873674a267c7cdc842ac9
commit: 9c537bf6cad4782573d873674a267c7cdc842ac9 [1/1] HID: debug: Check result of debugfs_create_dir() and debugfs_create_file()


coccinelle warnings: (new ones prefixed by >>)

>> drivers/hid/hid-debug.c:1281:2-26: WARNING: NULL check before freeing functions like kfree, debugfs_remove, debugfs_remove_recursive or usb_free_urb is not needed. Maybe consider reorganizing relevant code to avoid passing NULL values.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
