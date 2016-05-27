From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 1/7] Input: xpad: move pending clear to the correct location
Date: Fri, 27 May 2016 02:12:49 +0200
Message-ID: <1464307975-25890-2-git-send-email-rojtberg@gmail.com>
References: <1464307975-25890-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35761 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755336AbcE0ANL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 May 2016 20:13:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id e3so9942604wme.2
        for <linux-input@vger.kernel.org>; Thu, 26 May 2016 17:13:11 -0700 (PDT)
In-Reply-To: <1464307975-25890-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>

otherwise we lose ff commands: https://github.com/paroj/xpad/issues/27

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 1142a93..39cc52f 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -756,6 +756,7 @@ static bool xpad_prepare_next_out_packet(struct usb_xpad *xpad)
 	if (packet) {
 		memcpy(xpad->odata, packet->data, packet->len);
 		xpad->irq_out->transfer_buffer_length = packet->len;
+		packet->pending = false;
 		return true;
 	}
 
@@ -797,7 +798,6 @@ static void xpad_irq_out(struct urb *urb)
 	switch (status) {
 	case 0:
 		/* success */
-		xpad->out_packets[xpad->last_out_packet].pending = false;
 		xpad->irq_out_active = xpad_prepare_next_out_packet(xpad);
 		break;
 
-- 
2.7.4

