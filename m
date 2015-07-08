From: Anshul Garg <aksgarg1989@gmail.com>
Subject: [PATCH] Input: Use for_each_set_bit where appropriate
Date: Wed,  8 Jul 2015 11:08:49 -0700
Message-ID: <1436378929-65748-1-git-send-email-aksgarg1989@gmail.com>
References: <aksgarg1989@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33184 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146AbbGHSJY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jul 2015 14:09:24 -0400
Received: by pdbqm3 with SMTP id qm3so6243505pdb.0
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2015 11:09:24 -0700 (PDT)
In-Reply-To: <aksgarg1989@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: aksgarg1989@gmail.com

Use for_each_set_bit to check for set bits in bitmap
as it is more efficient than checking individual bits.

Signed-off-by: Anshul Garg <aksgarg1989@gmail.com>
---
 drivers/input/ff-core.c |    5 ++---
 drivers/input/joydev.c  |   11 +++++------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
index 8f4a30fc..c642082 100644
--- a/drivers/input/ff-core.c
+++ b/drivers/input/ff-core.c
@@ -343,9 +343,8 @@ int input_ff_create(struct input_dev *dev, unsigned int max_effects)
 	__set_bit(EV_FF, dev->evbit);
 
 	/* Copy "true" bits into ff device bitmap */
-	for (i = 0; i <= FF_MAX; i++)
-		if (test_bit(i, dev->ffbit))
-			__set_bit(i, ff->ffbit);
+	for_each_set_bit(i, dev->ffbit, FF_CNT)
+		__set_bit(i, ff->ffbit);
 
 	/* we can emulate RUMBLE with periodic effects */
 	if (test_bit(FF_PERIODIC, ff->ffbit))
diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index f362883..4686260 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -798,12 +798,11 @@ static int joydev_connect(struct input_handler *handler, struct input_dev *dev,
 	joydev->handle.handler = handler;
 	joydev->handle.private = joydev;
 
-	for (i = 0; i < ABS_CNT; i++)
-		if (test_bit(i, dev->absbit)) {
-			joydev->absmap[i] = joydev->nabs;
-			joydev->abspam[joydev->nabs] = i;
-			joydev->nabs++;
-		}
+	for_each_set_bit(i, dev->absbit, ABS_CNT) {
+		joydev->absmap[i] = joydev->nabs;
+		joydev->abspam[joydev->nabs] = i;
+		joydev->nabs++;
+	}
 
 	for (i = BTN_JOYSTICK - BTN_MISC; i < KEY_MAX - BTN_MISC + 1; i++)
 		if (test_bit(i + BTN_MISC, dev->keybit)) {
-- 
1.7.9.5


---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus

