From: Shailendra Verma <shailendra.capricorn@gmail.com>
Subject: [PATCH] Input:mouse:synaptics_i2c - Use bool function return value
Date: Mon, 25 May 2015 23:03:04 +0530
Message-ID: <1432575184-3348-1-git-send-email-shailendra.capricorn@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jingoo Han <jg1.han@samsung.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shailendra Verma <shailendra.capricorn@gmail.com>
List-Id: linux-input@vger.kernel.org

The function synaptics_i2c_get_input() has bool return type.
So use bool value flase instead of 0 to return.

Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
---
 drivers/input/mouse/synaptics_i2c.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index 2c87a93..ffceedc 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -342,7 +342,7 @@ static bool synaptics_i2c_get_input(struct synaptics_i2c *touch)
 
 	/* Deal with spontaneous resets and errors */
 	if (synaptics_i2c_check_error(touch->client))
-		return 0;
+		return false;
 
 	/* Get Gesture Bit */
 	data = synaptics_i2c_reg_get(touch->client, DATA_REG0);
-- 
1.7.9.5
