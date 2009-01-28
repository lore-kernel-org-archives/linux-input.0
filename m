From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] Input: scan pci_bus_type
Date: Wed, 28 Jan 2009 22:53:58 +0100
Message-ID: <4980D3F6.3050409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f21.google.com ([209.85.219.21]:48319 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbZA1Vx7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Jan 2009 16:53:59 -0500
Received: by ewy14 with SMTP id 14so3600680ewy.13
        for <linux-input@vger.kernel.org>; Wed, 28 Jan 2009 13:53:56 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

scan pci_bus_type rather then a get/put

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/input/mouse/pc110pad.c b/drivers/input/mouse/pc110pad.c
index fd09c8d..f63995f 100644
--- a/drivers/input/mouse/pc110pad.c
+++ b/drivers/input/mouse/pc110pad.c
@@ -111,11 +111,8 @@ static int __init pc110pad_init(void)
 	struct pci_dev *dev;
 	int err;
 
-	dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, NULL);
-	if (dev) {
-		pci_dev_put(dev);
+	if (!no_pci_devices())
 		return -ENODEV;
-	}
 
 	if (!request_region(pc110pad_io, 4, "pc110pad")) {
 		printk(KERN_ERR "pc110pad: I/O area %#x-%#x in use.\n",
