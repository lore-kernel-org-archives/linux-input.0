From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] drivers/input/tablet/aiptek.c: adjust error-handling code label
Date: Mon, 16 Apr 2012 22:44:52 +0200
Message-ID: <1334609092-15338-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

At the point of this error-handling code, aiptek->urb has been allocated,
and it does not appear to be less necessary to free it here than in the
error-handling code just below.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/input/tablet/aiptek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index 205d16a..a33d347 100644
--- a/drivers/input/tablet/aiptek.c
+++ b/drivers/input/tablet/aiptek.c
@@ -1856,7 +1856,7 @@ aiptek_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	if (i == ARRAY_SIZE(speeds)) {
 		dev_info(&intf->dev,
 			 "Aiptek tried all speeds, no sane response\n");
-		goto fail2;
+		goto fail3;
 	}
 
 	/* Associate this driver's struct with the usb interface.
