From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] Input: acecad - fix a memory leak in usb_acecad_probe
	error path
Date: Thu, 11 Nov 2010 11:21:55 +0800
Message-ID: <1289445715.3183.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64837 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104Ab0KKDR7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Nov 2010 22:17:59 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephane VOLTZ <svoltz@numericable.fr>, Edouard TISSERANT <edouard.tisserant@wanadoo.fr>, linux-input@vger.kernel.org

Add a missing usb_free_urb() in usb_acecad_probe() error path.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/tablet/acecad.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/input/tablet/acecad.c b/drivers/input/tablet/acecad.c
index aea9a93..d94f7e9 100644
--- a/drivers/input/tablet/acecad.c
+++ b/drivers/input/tablet/acecad.c
@@ -229,12 +229,13 @@ static int usb_acecad_probe(struct usb_interface *intf, const struct usb_device_
 
 	err = input_register_device(acecad->input);
 	if (err)
-		goto fail2;
+		goto fail3;
 
 	usb_set_intfdata(intf, acecad);
 
 	return 0;
 
+ fail3:	usb_free_urb(acecad->irq);
  fail2:	usb_free_coherent(dev, 8, acecad->data, acecad->data_dma);
  fail1: input_free_device(input_dev);
 	kfree(acecad);
-- 
1.7.2



