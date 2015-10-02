From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 03/18] Input: cyttsp - use PTR_ERR_OR_ZERO()
Date: Fri,  2 Oct 2015 15:40:14 +0200
Message-ID: <1443793229-22363-4-git-send-email-javier@osg.samsung.com>
References: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Ferruh Yigit <fery@cypress.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The PTR_ERR_OR_ZERO() helper function checks if a pointer contains an
errno code and returns it or return 0 if that's not the case. Use the
helper instead of open coding the same logic in the driver. This was
found with make coccicheck that complains with the following warning:

drivers/input/touchscreen/cyttsp4_i2c.c:53:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/input/touchscreen/cyttsp4_i2c.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp4_i2c.c b/drivers/input/touchscreen/cyttsp4_i2c.c
index a9f95c7d3c00..564e49002d5d 100644
--- a/drivers/input/touchscreen/cyttsp4_i2c.c
+++ b/drivers/input/touchscreen/cyttsp4_i2c.c
@@ -50,10 +50,7 @@ static int cyttsp4_i2c_probe(struct i2c_client *client,
 	ts = cyttsp4_probe(&cyttsp4_i2c_bus_ops, &client->dev, client->irq,
 			  CYTTSP4_I2C_DATA_SIZE);
 
-	if (IS_ERR(ts))
-		return PTR_ERR(ts);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(ts);
 }
 
 static int cyttsp4_i2c_remove(struct i2c_client *client)
-- 
2.4.3
