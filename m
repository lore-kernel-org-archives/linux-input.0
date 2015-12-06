From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH] Input: xpad - fix input from Covert Forces Xbox One
 controller
Date: Sun, 6 Dec 2015 00:02:31 -0800
Message-ID: <5663EB97.7020103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36385 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbbLFICd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 6 Dec 2015 03:02:33 -0500
Received: by pacdm15 with SMTP id dm15so108538022pac.3
        for <linux-input@vger.kernel.org>; Sun, 06 Dec 2015 00:02:32 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

The Covert Forces edition of the Xbox One controller requires the full 5
byte initialization packet to work at all. The 5 byte packet was known to
be needed for proper rumble support, but it looks like it's needed even
without rumble on these controllers.

Signed-off-by: Cameron Gutman <aicommander@gmail.com>
---
  drivers/input/joystick/xpad.c | 5 ++++-
  1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index fd4100d..de89de0 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1052,7 +1052,10 @@ static int xpad_open(struct input_dev *dev)
  		/* Xbox one controller needs to be initialized. */
  		xpad->odata[0] = 0x05;
  		xpad->odata[1] = 0x20;
-		xpad->irq_out->transfer_buffer_length = 2;
+		xpad->odata[2] = 0x00;
+		xpad->odata[3] = 0x01;
+		xpad->odata[4] = 0x00;
+		xpad->irq_out->transfer_buffer_length = 5;
  		return usb_submit_urb(xpad->irq_out, GFP_KERNEL);
  	}

-- 
2.5.0
