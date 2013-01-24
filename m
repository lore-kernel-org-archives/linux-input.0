From: kbuild test robot <fengguang.wu@intel.com>
Subject: [input:synaptics-rmi4 24/24]
 drivers/input/rmi4/rmi_driver.c:1194:8: error: 'rmi_driver_suspend'
 undeclared here (not in a function)
Date: Thu, 24 Jan 2013 13:33:45 +0800
Message-ID: <5100c7b9.UbyxnRjwqNXfmD1Q%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31433 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709Ab3AXFdr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Jan 2013 00:33:47 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git synaptics-rmi4
head:   fc30f2265940e9f48a3b4afa7dde45d096dd835b
commit: fc30f2265940e9f48a3b4afa7dde45d096dd835b [24/24] Input: RMI4 - bus code reshuffle
config: make ARCH=ia64 allmodconfig

All error/warnings:

   In file included from drivers/input/rmi4/rmi_driver.c:33:0:
   drivers/input/rmi4/rmi_f01.h:95:1: note: offset of packed bit-field 'month' has changed in GCC 4.4
>> drivers/input/rmi4/rmi_driver.c:1194:8: error: 'rmi_driver_suspend' undeclared here (not in a function)
>> drivers/input/rmi4/rmi_driver.c:1194:8: error: 'rmi_driver_resume' undeclared here (not in a function)

vim +/rmi_driver_suspend +1194 drivers/input/rmi4/rmi_driver.c

  1188		return 0;
  1189	
  1190	 err_free_data:
  1191		return retval;
  1192	}
  1193	
> 1194	static UNIVERSAL_DEV_PM_OPS(rmi_driver_pm, rmi_driver_suspend,
  1195				    rmi_driver_resume, NULL);
  1196	
  1197	struct rmi_driver rmi_physical_driver = {

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
