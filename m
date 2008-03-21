From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: [patch] hid: only dump report traffic with debug level 2
Date: Fri, 21 Mar 2008 22:52:29 +0200
Message-ID: <47E4200D.9080904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:59071 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755406AbYCUUwb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Mar 2008 16:52:31 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Currently using debug=1 with hid module prints out all sent and received
reports to the kernel log, while in many cases we only want to see the
report descriptors and hid-input mappings that are printed when a device
is probed.

Add new level debug=2, and only dump the report traffic with that level.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---

Index: linux-2.6.24-verbosehid/drivers/hid/hid-core.c
===================================================================
--- linux-2.6.24-verbosehid/drivers/hid/hid-core.c
+++ linux-2.6.24-verbosehid/drivers/hid/hid-core.c	2008-03-21 13:03:29.000000000 +0200
@@ -43,8 +43,8 @@
 
 #ifdef CONFIG_HID_DEBUG
 int hid_debug = 0;
-module_param_named(debug, hid_debug, bool, 0600);
-MODULE_PARM_DESC(debug, "Turn HID debugging mode on and off");
+module_param_named(debug, hid_debug, int, 0600);
+MODULE_PARM_DESC(debug, "HID debugging (0=off, 1=probing info, 2=continuous data dumping)");
 EXPORT_SYMBOL_GPL(hid_debug);
 #endif
 
Index: linux-2.6.24-verbosehid/drivers/hid/hid-debug.c
===================================================================
--- linux-2.6.24-verbosehid/drivers/hid/hid-debug.c
+++ linux-2.6.24-verbosehid/drivers/hid/hid-debug.c	2008-03-21 13:01:21.000000000 +0200
@@ -498,7 +498,7 @@
 EXPORT_SYMBOL_GPL(hid_dump_device);
 
 void hid_dump_input(struct hid_usage *usage, __s32 value) {
-	if (!hid_debug)
+	if (hid_debug < 2)
 		return;
 
 	printk(KERN_DEBUG "hid-debug: input ");


-- Anssi Hannula


