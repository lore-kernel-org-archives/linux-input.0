From: Anshul Garg <aksgarg1989@gmail.com>
Subject: [PATCH] Input: Use for_each_set_bit where appropriate
Date: Thu,  9 Jul 2015 06:41:01 -0700
Message-ID: <1436449261-66742-1-git-send-email-aksgarg1989@gmail.com>
References: <aksgarg1989@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:32783 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbbGINlg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2015 09:41:36 -0400
Received: by pdbqm3 with SMTP id qm3so21941769pdb.0
        for <linux-input@vger.kernel.org>; Thu, 09 Jul 2015 06:41:36 -0700 (PDT)
In-Reply-To: <aksgarg1989@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: aksgarg1989@gmail.com

Use for_each_set_bit to check for set bits in bitmap
as it is more efficient and compact.
Also use bitwise and instead of expensive %
operation while fetching next event.

Signed-off-by: Anshul Garg <aksgarg1989@gmail.com>
---
 drivers/input/misc/uinput.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 421e29e..a3c15ad 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -319,11 +319,8 @@ static int uinput_validate_absbits(struct input_dev *dev)
 	/*
 	 * Check if absmin/absmax/absfuzz/absflat are sane.
 	 */
-
-	for (cnt = 0; cnt < ABS_CNT; cnt++) {
+	for_each_set_bit(cnt, dev->absbit, ABS_CNT) {
 		int min, max;
-		if (!test_bit(cnt, dev->absbit))
-			continue;
 
 		min = input_abs_get_min(dev, cnt);
 		max = input_abs_get_max(dev, cnt);
@@ -415,8 +412,8 @@ static int uinput_setup_device(struct uinput_device *udev,
 	dev->id.vendor	= user_dev->id.vendor;
 	dev->id.product	= user_dev->id.product;
 	dev->id.version	= user_dev->id.version;
-
-	for (i = 0; i < ABS_CNT; i++) {
+
+	for_each_set_bit(i, dev->absbit, ABS_CNT) {
 		input_abs_set_max(dev, i, user_dev->absmax[i]);
 		input_abs_set_min(dev, i, user_dev->absmin[i]);
 		input_abs_set_fuzz(dev, i, user_dev->absfuzz[i]);
@@ -493,7 +490,7 @@ static bool uinput_fetch_next_event(struct uinput_device *udev,
 	have_event = udev->head != udev->tail;
 	if (have_event) {
 		*event = udev->buff[udev->tail];
-		udev->tail = (udev->tail + 1) % UINPUT_BUFFER_SIZE;
+		udev->tail &= UINPUT_BUFFER_SIZE - 1;
 	}
 
 	spin_unlock_irq(&udev->dev->event_lock);
-- 
1.7.9.5


---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus

