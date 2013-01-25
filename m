From: kbuild test robot <fengguang.wu@intel.com>
Subject: [input:synaptics-rmi4 25/25] WARNING:
 drivers/input/built-in.o(.init.text+0x2c11): Section mismatch in reference
 from the function rmi_bus_init() to the function
 .exit.text:rmi_unregister_f01_handler()
Date: Fri, 25 Jan 2013 20:40:22 +0800
Message-ID: <51027d36.TedHXBiqMUUJq8p5%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:6616 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755813Ab3AYMoM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Jan 2013 07:44:12 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git synaptics-rmi4
head:   6c8adf701fb9e00e16fd3aa330995c4863c4fd9a
commit: 6c8adf701fb9e00e16fd3aa330995c4863c4fd9a [25/25] Input: RMI4 - correct a few function names to fix build
config: make ARCH=i386 allyesconfig

All warnings:

>> WARNING: drivers/input/built-in.o(.init.text+0x2c11): Section mismatch in reference from the function rmi_bus_init() to the function .exit.text:rmi_unregister_f01_handler()
   The function __init rmi_bus_init() references
   a function __exit rmi_unregister_f01_handler().
   This is often seen when error handling in the init function
   uses functionality in the exit path.
   The fix is often to remove the __exit annotation of
   rmi_unregister_f01_handler() so it may be used outside an exit section.

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
