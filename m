From: Shailendra Verma <shailendra.capricorn@gmail.com>
Subject: [PATCH 14/14] Input: ff-core - Fix typo in comment.
Date: Mon, 18 May 2015 22:50:42 +0530
Message-ID: <1431969642-3598-1-git-send-email-shailendra.capricorn@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34531 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbbERRU5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 May 2015 13:20:57 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shailendra Verma <shailendra.capricorn@gmail.com>


Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
---
 drivers/input/ff-core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
index b81c88c..8f4a30fc 100644
--- a/drivers/input/ff-core.c
+++ b/drivers/input/ff-core.c
@@ -70,7 +70,7 @@ static int compat_effect(struct ff_device *ff, struct ff_effect *effect)
 			return -EINVAL;
 
 		/*
-		 * calculate manginude of sine wave as average of rumble's
+		 * calculate magnitude of sine wave as average of rumble's
 		 * 2/3 of strong magnitude and 1/3 of weak magnitude
 		 */
 		magnitude = effect->u.rumble.strong_magnitude / 3 +
@@ -213,7 +213,7 @@ static int erase_effect(struct input_dev *dev, int effect_id,
 /**
  * input_ff_erase - erase a force-feedback effect from device
  * @dev: input device to erase effect from
- * @effect_id: id of the ffect to be erased
+ * @effect_id: id of the effect to be erased
  * @file: purported owner of the request
  *
  * This function erases a force-feedback effect from specified device.
-- 
1.7.9.5

