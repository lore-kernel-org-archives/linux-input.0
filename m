From: Daniel Walker <dwalker@mvista.com>
Subject: [PATCH] input: push down scancode negative checking
Date: Mon, 30 Jun 2008 12:33:46 -0700
Message-ID: <1214854426-20442-1-git-send-email-dwalker@mvista.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:59677 "EHLO
	dwalker1.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750797AbYF3Tgf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jun 2008 15:36:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Philippe Troin <phil@fifi.org>, "Adolfo R. Brandes" <arbrandes@gmail.com>, linux-input@vger.kernel.org

The getkeycode/setkeycode calls should be able to accept "negative" values.

The HID layer has some scan codes of the form 0xffbc0000 for logitech
devices, and they get ignored by these calls. I pushed the checking
into the input_default_* functions since they do need non-negative
values.

I also corrected a typo in the comment for input_set_keycode

Signed-off-by: Daniel Walker <dwalker@mvista.com>
---
 drivers/input/input.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 27006fc..e1af21f 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -526,7 +526,7 @@ static int input_default_getkeycode(struct input_dev *dev,
 	if (!dev->keycodesize)
 		return -EINVAL;
 
-	if (scancode >= dev->keycodemax)
+	if (scancode < 0 || scancode >= dev->keycodemax)
 		return -EINVAL;
 
 	*keycode = input_fetch_keycode(dev, scancode);
@@ -540,7 +540,7 @@ static int input_default_setkeycode(struct input_dev *dev,
 	int old_keycode;
 	int i;
 
-	if (scancode >= dev->keycodemax)
+	if (scancode < 0 || scancode >= dev->keycodemax)
 		return -EINVAL;
 
 	if (!dev->keycodesize)
@@ -595,15 +595,12 @@ static int input_default_setkeycode(struct input_dev *dev,
  */
 int input_get_keycode(struct input_dev *dev, int scancode, int *keycode)
 {
-	if (scancode < 0)
-		return -EINVAL;
-
 	return dev->getkeycode(dev, scancode, keycode);
 }
 EXPORT_SYMBOL(input_get_keycode);
 
 /**
- * input_get_keycode - assign new keycode to a given scancode
+ * input_set_keycode - assign new keycode to a given scancode
  * @dev: input device which keymap is being updated
  * @scancode: scancode (or its equivalent for device in question)
  * @keycode: new keycode to be assigned to the scancode
@@ -617,9 +614,6 @@ int input_set_keycode(struct input_dev *dev, int scancode, int keycode)
 	int old_keycode;
 	int retval;
 
-	if (scancode < 0)
-		return -EINVAL;
-
 	if (keycode < 0 || keycode > KEY_MAX)
 		return -EINVAL;
 
-- 
1.5.4.1.166.g6706d

