From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH] Input: xpad - validate USB endpoint count during probe
Date: Wed, 29 Jun 2016 00:55:51 -0500
Message-ID: <577362E7.2000508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34122 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbcF2F5J (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jun 2016 01:57:09 -0400
Received: by mail-pf0-f195.google.com with SMTP id 66so3655042pfy.1
        for <linux-input@vger.kernel.org>; Tue, 28 Jun 2016 22:55:53 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

This prevents a malicious USB device from causing an oops.

Signed-off-by: Cameron Gutman <aicommander@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/input/joystick/xpad.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 3438e98..a529a45 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1431,6 +1431,9 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	int ep_irq_in_idx;
 	int i, error;
 
+	if (intf->cur_altsetting->desc.bNumEndpoints != 2)
+		return -ENODEV;
+
 	for (i = 0; xpad_device[i].idVendor; i++) {
 		if ((le16_to_cpu(udev->descriptor.idVendor) == xpad_device[i].idVendor) &&
 		    (le16_to_cpu(udev->descriptor.idProduct) == xpad_device[i].idProduct))
-- 
2.7.4
