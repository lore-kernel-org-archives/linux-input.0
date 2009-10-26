From: Pascal Bach <pascal.bach@nextrem.ch>
Subject: Patch to fix Volume keys on AMILO 1848+u (Kernel 2.6.32-rc5)
Date: Mon, 26 Oct 2009 11:35:04 +0100
Message-ID: <AAD0C341-7536-4D53-86B4-C9ADCEB6A407@nextrem.ch>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mxout004.mail.hostpoint.ch ([217.26.49.183]:49427 "EHLO
	mxout004.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755570AbZJZLEj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Oct 2009 07:04:39 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

The Fn+F7 and Fn+F8 Keys to change the Volume don't work as the don't  
send a key release event.

The patch I appended adds the Amilo 1848+u to the special handling  
list of the atkbd.c driver.

The patch is for 2.6.32-rc5.

--- atkbd.c.orig	2009-10-26 11:23:07.000000000 +0100
+++ atkbd.c	2009-10-26 11:24:03.000000000 +0100
@@ -901,6 +901,13 @@ static unsigned int atkbd_amilo_pi3525_f
  };

  /*
+ * Amilo Si 1848 key release for Fn+Volume keys not working
+ */
+static unsigned int atkbd_amilo_si1848_forced_release_keys[] = {
+	0xa0, 0xae, 0xb0, -1U
+};
+
+/*
   * Amilo Xi 3650 key release for light touch bar not working
   */
  static unsigned int atkbd_amilo_xi3650_forced_release_keys[] = {
@@ -1637,6 +1644,15 @@ static struct dmi_system_id atkbd_dmi_qu
  		.driver_data = atkbd_volume_forced_release_keys,
  	},
  	{
+		.ident = "Fujitsu Amilo Si 1848+u",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Si 1848+u"),
+		},
+		.callback = atkbd_setup_forced_release,
+		.driver_data = atkbd_amilo_si1848_forced_release_keys,
+	},
+	{
  		.ident = "Fujitsu Amilo Pi 3525",
  		.matches = {
  			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),

