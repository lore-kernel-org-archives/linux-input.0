From: Tom Rini <trini@konsulko.com>
Subject: [PATCH] Revert "Input: atmel_mxt_ts - disable interrupt for 50ms after reset"
Date: Thu,  7 Apr 2016 18:52:25 -0400
Message-ID: <1460069545-10322-1-git-send-email-trini@konsulko.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36259 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbcDGWu5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Apr 2016 18:50:57 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Olof Johansson <olof@lixom.net>, Nick Dyer <nick.dyer@itdev.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>

This reverts commit 885f3fb9fa1f9e185e8a4e905157087495734349 due to this
change breaking the touchpad on the Chromebook Pixel 2015 on resume from
sleep or warm resets.

Cc: Olof Johansson <olof@lixom.net>
Cc: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 2160512..9b92b60 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1098,9 +1098,7 @@ static int mxt_soft_reset(struct mxt_data *data)
 	struct device *dev = &data->client->dev;
 	int ret = 0;
 
-	dev_info(dev, "Resetting device\n");
-
-	disable_irq(data->irq);
+	dev_info(dev, "Resetting chip\n");
 
 	reinit_completion(&data->reset_completion);
 
@@ -1108,11 +1106,6 @@ static int mxt_soft_reset(struct mxt_data *data)
 	if (ret)
 		return ret;
 
-	/* Ignore CHG line for 100ms after reset */
-	msleep(100);
-
-	enable_irq(data->irq);
-
 	ret = mxt_wait_for_completion(data, &data->reset_completion,
 				      MXT_RESET_TIMEOUT);
 	if (ret)
-- 
1.7.9.5

