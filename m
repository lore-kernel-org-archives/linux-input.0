From: "Michael Gruber" <lists.mg@googlemail.com>
Subject: [PATCH] xpad - Set buffer length for outgoing requests
Date: Tue, 8 Apr 2008 13:05:27 +0200
Message-ID: <74d457500804080405x50098dcfi6dfe965da2a962ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:9700 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbYDHLFd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Apr 2008 07:05:33 -0400
Received: by ti-out-0910.google.com with SMTP id 28so673731tif.23
        for <linux-input@vger.kernel.org>; Tue, 08 Apr 2008 04:05:29 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

From: Michael Gruber <lists.mg@googlemail.com>

The messages for led/rumble are exactly 3 and 8 bytes respectively.
Hence set up the transfer_buffer_length accordingly.

Signed-off-by: Michael Gruber <lists.mg@googlemail.com>

---

Hi, my Xbox360 Controller will not work at all unless this is set up correctly.
I am new to linux kernel programming and would appreciate any kinds of comments.

 drivers/input/joystick/xpad.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/input/joystick/xpad.c	2008-04-05 15:18:37.000000000 +0200
+++ b/drivers/input/joystick/xpad.c	2008-04-05 15:18:25.000000000 +0200
@@ -558,6 +558,7 @@ static int xpad_play_effect(struct input
 		xpad->odata[5] = 0x00;
 		xpad->odata[6] = 0x00;
 		xpad->odata[7] = 0x00;
+		xpad->irq_out->transfer_buffer_length = 8;
 		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
 	}

@@ -594,6 +595,7 @@ static void xpad_send_led_command(struct
 		xpad->odata[0] = 0x01;
 		xpad->odata[1] = 0x03;
 		xpad->odata[2] = command;
+		xpad->irq_out->transfer_buffer_length = 3;
 		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
 		mutex_unlock(&xpad->odata_mutex);
 	}
