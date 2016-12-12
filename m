From: Jingkui Wang <jkwang@google.com>
Subject: [PATCH] Input: Driver drv260x.c - fix bug of adding wrong device parent
Date: Mon, 12 Dec 2016 13:37:07 -0800
Message-ID: <1481578627-56391-1-git-send-email-jkwang@google.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33852 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751710AbcLLVh3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 12 Dec 2016 16:37:29 -0500
Received: by mail-pg0-f51.google.com with SMTP id x23so39457857pgx.1
        for <linux-input@vger.kernel.org>; Mon, 12 Dec 2016 13:37:29 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Dan Murphy <dmurphy@ti.com>, Jingkui Wang <jkwang@google.com>

Fix the bug of adding wrong parent to the input_dev created by the
driver. The bug will be triggered if rmmod is called for this driver
module.

Signed-off-by: Jingkui Wang <jkwang@google.com>
---
 drivers/input/misc/drv260x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 4f448ba..885c140 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -565,7 +565,6 @@ static int drv260x_probe(struct i2c_client *client,
 	}
 
 	haptics->input_dev->name = "drv260x:haptics";
-	haptics->input_dev->dev.parent = client->dev.parent;
 	haptics->input_dev->close = drv260x_close;
 	input_set_drvdata(haptics->input_dev, haptics);
 	input_set_capability(haptics->input_dev, EV_FF, FF_RUMBLE);
-- 
2.6.6

