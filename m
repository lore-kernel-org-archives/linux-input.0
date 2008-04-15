From: Michael Gruber <dmitry.torokhov@gmail.com>
Subject: [PATCH 25/37] Input: xpad - set proper buffer length for outgoing requests
Date: Tue, 15 Apr 2008 01:31:47 -0400
Message-ID: <04021e4e401d7ac2051839dd5b00a701c9119dd9.1208783694.git.dmitry.torokhov@gmail.com>
References: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:9129 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757653AbYDUNTi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 09:19:38 -0400
Received: by wa-out-1112.google.com with SMTP id m16so3106316waf.23
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2008 06:19:37 -0700 (PDT)
In-Reply-To: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jkosina@suse.cz, akpm@linux-foundation.org

The messages for led/rumble are exactly 3 and 8 bytes respectively.
Hence set up the transfer_buffer_length accordingly.

Signed-off-by: Michael Gruber <lists.mg@googlemail.com>
Acked-by: Anssi Hannula <anssi.hannula@gmail.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/joystick/xpad.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index d4d289e..52ddb04 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -558,6 +558,7 @@ static int xpad_play_effect(struct input_dev *dev, void *data,
 		xpad->odata[5] = 0x00;
 		xpad->odata[6] = 0x00;
 		xpad->odata[7] = 0x00;
+		xpad->irq_out->transfer_buffer_length = 8;
 		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
 	}
 
@@ -594,6 +595,7 @@ static void xpad_send_led_command(struct usb_xpad *xpad, int command)
 		xpad->odata[0] = 0x01;
 		xpad->odata[1] = 0x03;
 		xpad->odata[2] = command;
+		xpad->irq_out->transfer_buffer_length = 3;
 		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
 		mutex_unlock(&xpad->odata_mutex);
 	}
-- 
1.5.5.rc2.6.gf58d


