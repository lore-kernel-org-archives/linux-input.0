From: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 01/14] HID: i2c-hid: change I2C name
Date: Tue,  4 Dec 2012 16:27:42 +0100
Message-ID: <1354634875-5182-2-git-send-email-benjamin.tissoires@gmail.com>
References: <1354634875-5182-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354634875-5182-1-git-send-email-benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

no I2C driver has "i2c" in its name. It makes more sense to call this
i2c driver "hid".

Signed-off-by: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/hid/i2c-hid/i2c-hid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 67ab5b7..0fbb229 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -949,7 +949,7 @@ static int i2c_hid_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(i2c_hid_pm, i2c_hid_suspend, i2c_hid_resume);
 
 static const struct i2c_device_id i2c_hid_id_table[] = {
-	{ "i2c_hid", 0 },
+	{ "hid", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, i2c_hid_id_table);
-- 
1.8.0.1
