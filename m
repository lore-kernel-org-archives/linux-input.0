From: Michael Gruber <lists.mg@googlemail.com>
Subject: [PATCH] xpad: If the outgoing request was sent successfully don't try
	to send it again
Date: Wed, 1 Jul 2009 00:56:32 +0200
Message-ID: <74d457500906301556y7aacdf12haacc749fc0f883d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f193.google.com ([209.85.221.193]:44400 "EHLO
	mail-qy0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757581AbZF3W43 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Jun 2009 18:56:29 -0400
Received: by qyk31 with SMTP id 31so604985qyk.33
        for <linux-input@vger.kernel.org>; Tue, 30 Jun 2009 15:56:32 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

From: Michael Gruber <lists.mg@googlemail.com>

This avoids an infinite loop.

Signed-off-by: Michael Gruber <lists.mg@googlemail.com>

---

Now my LED will finally stop blinking...

 drivers/input/joystick/xpad.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index b868b8d..e5239ec 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -472,7 +472,7 @@ static void xpad_irq_out(struct urb *urb)
 	switch (status) {
 		case 0:
 		/* success */
-		break;
+		return;
 		case -ECONNRESET:
 		case -ENOENT:
 		case -ESHUTDOWN:
