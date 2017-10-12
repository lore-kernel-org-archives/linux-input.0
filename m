From: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Subject: [PATCH 2/2] Input: goodix - add more entries in i2c_device_id
Date: Thu, 12 Oct 2017 17:04:43 +0200
Message-ID: <20171012150443.27542-2-m.niestroj@grinn-global.com>
References: <20171012150443.27542-1-m.niestroj@grinn-global.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171012150443.27542-1-m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add corresponding entry in i2c_device_id table for each of_device_id
entry. This makes it possible to autoload module for goodix
touchscreen device-tree entry, based on modalias (which is generated
by stripping manufacturer prefix from compatible string).

Signed-off-by: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
---
 drivers/input/touchscreen/goodix.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 9d50d9688975..4b702b363677 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -902,7 +902,15 @@ static int __maybe_unused goodix_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(goodix_pm_ops, goodix_suspend, goodix_resume);
 
 static const struct i2c_device_id goodix_ts_id[] = {
-	{ "GDIX1001:00", 0 },
+	{ "GDIX1001:00" },
+	{ "gt1151" },
+	{ "gt911" },
+	{ "gt9110" },
+	{ "gt912" },
+	{ "gt927" },
+	{ "gt9271" },
+	{ "gt928" },
+	{ "gt967" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, goodix_ts_id);
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
