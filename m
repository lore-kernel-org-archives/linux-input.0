From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/5] Input: mpr121 - set missing event capability
Date: Thu, 12 Jan 2017 02:42:26 +0900
Message-ID: <1484156549-26585-3-git-send-email-akinobu.mita@gmail.com>
References: <1484156549-26585-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1484156549-26585-1-git-send-email-akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This driver reports misc scan input events on the sensor's status
register changes.  But the event capability for them was not set in the
device initialization, so these events were ignored.

This change adds the missing event capability.

Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/input/keyboard/mpr121_touchkey.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
index d40e0d1..a2c5305 100644
--- a/drivers/input/keyboard/mpr121_touchkey.c
+++ b/drivers/input/keyboard/mpr121_touchkey.c
@@ -230,6 +230,7 @@ static int mpr_touchkey_probe(struct i2c_client *client,
 	input_dev->id.bustype = BUS_I2C;
 	input_dev->dev.parent = &client->dev;
 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
+	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
 
 	input_dev->keycode = mpr121->keycodes;
 	input_dev->keycodesize = sizeof(mpr121->keycodes[0]);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
