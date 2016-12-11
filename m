From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: drv260x - fix initializing overdrive voltage
Date: Sat, 10 Dec 2016 22:59:56 -0800
Message-ID: <20161211065956.GA17809@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33310 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbcLKG77 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 11 Dec 2016 01:59:59 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

We were accidentally initializing haptics->rated_voltage twice, and did not
initialize overdrive voltage.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/drv260x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 2adfd86c..9789d4f 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -521,7 +521,7 @@ static int drv260x_probe(struct i2c_client *client,
 	if (!haptics)
 		return -ENOMEM;
 
-	haptics->rated_voltage = DRV260X_DEF_OD_CLAMP_VOLT;
+	haptics->overdrive_voltage = DRV260X_DEF_OD_CLAMP_VOLT;
 	haptics->rated_voltage = DRV260X_DEF_RATED_VOLT;
 
 	if (pdata) {
-- 
2.8.0.rc3.226.g39d4020


-- 
Dmitry
