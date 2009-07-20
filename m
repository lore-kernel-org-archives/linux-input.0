From: =?ISO-8859-1?Q?Ortwin_Gl=FCck?= <odi@odi.ch>
Subject: Regression 2.6.31: Mighty Mouse no longer works
Date: Mon, 20 Jul 2009 22:51:52 +0200
Message-ID: <4A64D8E8.1060007@odi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from viefep20-int.chello.at ([62.179.121.40]:15936 "EHLO
	viefep20-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbZGTUwA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jul 2009 16:52:00 -0400
Received: from edge01.upc.biz ([192.168.13.236]) by viefep20-int.chello.at
          (InterMail vM.7.09.01.00 201-2219-108-20080618) with ESMTP
          id <20090720205155.LZBZ21978.viefep20-int.chello.at@edge01.upc.biz>
          for <linux-input@vger.kernel.org>;
          Mon, 20 Jul 2009 22:51:55 +0200
Received: from [192.168.111.10] (mithril [192.168.111.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by gollum.odi.ch (Postfix) with ESMTPSA id 13F05200FB6
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2009 22:51:53 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This was caused by commit fa047e4f6fa63a6e9d0ae4d7749538830d14a343 which removed
the whole mighty mouse support. The Mighty Mouse was working fine before that
change. What's really unnecessary is that axes quirk. The patch below restores
the entry partially and makes it work again.

Cheers,

Ortwin



>From 9b59854782833766f1e10bf3363f9d7c320dff78 Mon Sep 17 00:00:00 2001
From: Ortwin Glueck <odi@odi.ch>
Date: Wed, 15 Jul 2009 00:08:09 +0200
Subject: HID: re-add support for apple mighty mouse

commit fa047e4f6fa63a6e9d0ae4d7749538830d14a343 removed the whole mighty mouse
support instead of just removing a single quirk.

Signed-of-by: Ortwin Glueck <odi@odi.ch>
---
 drivers/hid/hid-apple.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 303ccce..b0d9bbb 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -436,6 +436,10 @@ static const struct hid_device_id apple_devices[] = {
        { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY),
                .driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },

+       /* Apple wireless Mighty Mouse */
+       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, 0x030c),
+               .driver_data = APPLE_MIGHTYMOUSE },
+
        { }
 };
 MODULE_DEVICE_TABLE(hid, apple_devices);
--
1.6.3.3

