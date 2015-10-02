From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 14/18] Input: synaptics_i2c - simplify function return logic
Date: Fri,  2 Oct 2015 15:40:25 +0200
Message-ID: <1443793229-22363-15-git-send-email-javier@osg.samsung.com>
References: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Jingoo Han <jg1.han@samsung.com>, Shailendra Verma <shailendra.capricorn@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The invoked function already returns zero on success or a negative
errno code so there is no need to open code the logic in the caller.

This also fixes the following make coccicheck warnings:

drivers/input/mouse/synaptics_i2c.c:298:1-4: WARNING: end returns can be simplified

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/input/mouse/synaptics_i2c.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index aa7c5da60800..9f69ce3de2f3 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -295,11 +295,7 @@ static int synaptics_i2c_config(struct i2c_client *client)
 	control |= reduce_report ? 1 << REDUCE_REPORTING : 0;
 	/* No Filter */
 	control |= no_filter ? 1 << NO_FILTER : 0;
-	ret = synaptics_i2c_reg_set(client, GENERAL_2D_CONTROL_REG, control);
-	if (ret)
-		return ret;
-
-	return 0;
+	return synaptics_i2c_reg_set(client, GENERAL_2D_CONTROL_REG, control);
 }
 
 static int synaptics_i2c_reset_config(struct i2c_client *client)
-- 
2.4.3
