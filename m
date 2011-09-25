From: chris@cnpbagwell.com
Subject: [PATCH v2 1/3] Input: wacom - remove unneeded touch pressure init
Date: Sun, 25 Sep 2011 14:09:26 -0500
Message-ID: <1316977768-823-2-git-send-email-chris@cnpbagwell.com>
References: <1316977768-823-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56646 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411Ab1IYTJw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Sep 2011 15:09:52 -0400
Received: by gyg10 with SMTP id 10so3658428gyg.19
        for <linux-input@vger.kernel.org>; Sun, 25 Sep 2011 12:09:51 -0700 (PDT)
In-Reply-To: <1316977768-823-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

These were left in during removal of touch pressure reports
but not needed now.

Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
Reviewed-by: Ping Cheng <pingc@wacom.com>
Reviewed-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/tablet/wacom_wac.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index c1c2f7b..f4206b5 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1029,8 +1029,6 @@ void wacom_setup_device_quirks(struct wacom_features *features)
 		features->y_max <<= 5;
 		features->x_fuzz <<= 5;
 		features->y_fuzz <<= 5;
-		features->pressure_max = 256;
-		features->pressure_fuzz = 16;
 		features->quirks |= WACOM_QUIRK_BBTOUCH_LOWRES;
 	}
 }
@@ -1219,9 +1217,6 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 			input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
 					     0, features->y_max,
 					     features->y_fuzz, 0);
-			input_set_abs_params(input_dev, ABS_MT_PRESSURE,
-					     0, features->pressure_max,
-					     features->pressure_fuzz, 0);
 		} else if (features->device_type == BTN_TOOL_PEN) {
 			__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
 			__set_bit(BTN_TOOL_PEN, input_dev->keybit);
-- 
1.7.6

