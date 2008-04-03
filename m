From: Oliver Neukum <dmitry.torokhov@gmail.com>
Subject: [PATCH 19/37] Input: xpad - don't use GFP_ATOMIC
Date: Thu, 3 Apr 2008 16:19:33 -0400
Message-ID: <6eae9b0acdb6f03ed87ef882760e0ef8f440dc1a.1208783694.git.dmitry.torokhov@gmail.com>
References: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.183]:25531 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759571AbYDUNTc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 09:19:32 -0400
Received: by el-out-1112.google.com with SMTP id n30so388761elf.21
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2008 06:19:31 -0700 (PDT)
In-Reply-To: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jkosina@suse.cz, akpm@linux-foundation.org

GFP_ATOMIC should not be used when GFP_KERNEL can be used.

Signed-off-by: Oliver Neukum <oneukum@suse.de>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/joystick/xpad.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index ebf8303..d4d289e 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -497,7 +497,7 @@ static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
 		return 0;
 
 	xpad->odata = usb_buffer_alloc(xpad->udev, XPAD_PKT_LEN,
-				       GFP_ATOMIC, &xpad->odata_dma );
+				       GFP_KERNEL, &xpad->odata_dma);
 	if (!xpad->odata)
 		goto fail1;
 
@@ -729,7 +729,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		goto fail1;
 
 	xpad->idata = usb_buffer_alloc(udev, XPAD_PKT_LEN,
-				       GFP_ATOMIC, &xpad->idata_dma);
+				       GFP_KERNEL, &xpad->idata_dma);
 	if (!xpad->idata)
 		goto fail1;
 
-- 
1.5.5.rc2.6.gf58d


