From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: [PATCH 2/2] input: touchscreen: ar1021_i2c: replace magic number with definition
Date: Thu, 27 Apr 2017 14:22:36 +0200
Message-ID: <1493295756-17812-2-git-send-email-martin.kepplinger@ginzinger.com>
References: <1493295756-17812-1-git-send-email-martin.kepplinger@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493295756-17812-1-git-send-email-martin.kepplinger@ginzinger.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Kepplinger <martin.kepplinger@ginzinger.com>
List-Id: linux-input@vger.kernel.org

We now have a few of this device's definitions. Let's avoid magic numbers
and use them.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---
 drivers/input/touchscreen/ar1021_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
index 2a76231..edd5268 100644
--- a/drivers/input/touchscreen/ar1021_i2c.c
+++ b/drivers/input/touchscreen/ar1021_i2c.c
@@ -44,7 +44,7 @@ static irqreturn_t ar1021_i2c_irq(int irq, void *dev_id)
 		goto out;
 
 	/* sync bit set ? */
-	if ((data[0] & 0x80) == 0)
+	if ((data[0] & AR1021_TOUCH) == 0)
 		goto out;
 
 	button = data[0] & BIT(0);
-- 
2.1.4
