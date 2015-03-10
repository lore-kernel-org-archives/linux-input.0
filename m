From: Anshul Garg <aksgarg1989@gmail.com>
Subject: [PATCH] Input : Optimize joydev_connect function
Date: Tue, 10 Mar 2015 11:36:17 -0700
Message-ID: <1426012577-921-1-git-send-email-aksgarg1989@gmail.com>
References: <aksgarg1989@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34046 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbbCJShS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Mar 2015 14:37:18 -0400
Received: by pdno5 with SMTP id o5so4344596pdn.1
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2015 11:37:18 -0700 (PDT)
In-Reply-To: <aksgarg1989@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org
Cc: aksgarg1989@gmail.com, anshul.g@samsung.com

From: Anshul Garg <aksgarg1989@gmail.com>

In joydev_connect function added check for event type before
setting properties for that event. This will avoid dummy
loop iterations which checks for event code even if event type
is not set.

Signed-off-by: Anshul Garg <aksgarg1989@gmail.com>
---
 drivers/input/joydev.c |   44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index f362883..a37a26c 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -797,27 +797,31 @@ static int joydev_connect(struct input_handler *handler, struct input_dev *dev,
 	joydev->handle.name = dev_name(&joydev->dev);
 	joydev->handle.handler = handler;
 	joydev->handle.private = joydev;
+
+	if (test_bit(EV_ABS, dev->evbit)) {
+		for (i = 0; i < ABS_CNT; i++)
+			if (test_bit(i, dev->absbit)) {
+				joydev->absmap[i] = joydev->nabs;
+				joydev->abspam[joydev->nabs] = i;
+				joydev->nabs++;
+			}
+	}
 
-	for (i = 0; i < ABS_CNT; i++)
-		if (test_bit(i, dev->absbit)) {
-			joydev->absmap[i] = joydev->nabs;
-			joydev->abspam[joydev->nabs] = i;
-			joydev->nabs++;
-		}
-
-	for (i = BTN_JOYSTICK - BTN_MISC; i < KEY_MAX - BTN_MISC + 1; i++)
-		if (test_bit(i + BTN_MISC, dev->keybit)) {
-			joydev->keymap[i] = joydev->nkey;
-			joydev->keypam[joydev->nkey] = i + BTN_MISC;
-			joydev->nkey++;
-		}
-
-	for (i = 0; i < BTN_JOYSTICK - BTN_MISC; i++)
-		if (test_bit(i + BTN_MISC, dev->keybit)) {
-			joydev->keymap[i] = joydev->nkey;
-			joydev->keypam[joydev->nkey] = i + BTN_MISC;
-			joydev->nkey++;
-		}
+	if (test_bit(EV_KEY, dev->evbit)) {
+		for (i = BTN_JOYSTICK - BTN_MISC; i < KEY_MAX - BTN_MISC + 1; i++)
+			if (test_bit(i + BTN_MISC, dev->keybit)) {
+				joydev->keymap[i] = joydev->nkey;
+				joydev->keypam[joydev->nkey] = i + BTN_MISC;
+				joydev->nkey++;
+			}
+
+		for (i = 0; i < BTN_JOYSTICK - BTN_MISC; i++)
+			if (test_bit(i + BTN_MISC, dev->keybit)) {
+				joydev->keymap[i] = joydev->nkey;
+				joydev->keypam[joydev->nkey] = i + BTN_MISC;
+				joydev->nkey++;
+			}
+	}
 
 	for (i = 0; i < joydev->nabs; i++) {
 		j = joydev->abspam[i];
-- 
1.7.9.5


---
This email has been checked for viruses by Avast antivirus software.
http://www.avast.com

