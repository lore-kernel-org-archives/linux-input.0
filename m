From: =?ISO-8859-1?Q?Ortwin_Gl=FCck?= <odi@odi.ch>
Subject: [PATCH] HID: re-add support for apple mighty mouse
Date: Wed, 15 Jul 2009 00:14:24 +0200
Message-ID: <4A5D0340.1050201@odi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from viefep21-int.chello.at ([62.179.121.41]:17277 "EHLO
	viefep21-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756191AbZGNWea (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jul 2009 18:34:30 -0400
Received: from edge01.upc.biz ([192.168.13.236]) by viefep16-int.chello.at
          (InterMail vM.7.09.01.00 201-2219-108-20080618) with ESMTP
          id <20090714221426.YRSO16750.viefep16-int.chello.at@edge01.upc.biz>
          for <linux-input@vger.kernel.org>;
          Wed, 15 Jul 2009 00:14:26 +0200
Received: from [192.168.111.10] (mithril [192.168.111.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by gollum.odi.ch (Postfix) with ESMTPSA id 427F590AB8
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2009 00:14:24 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

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
