From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 2/2] input: touchscreen: silead_gsl1680: Use "silead/" prefix for firmware loading
Date: Mon, 29 Aug 2016 21:29:37 +0200
Message-ID: <20160829192937.32129-3-hdegoede@redhat.com>
References: <20160829192937.32129-1-hdegoede@redhat.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160829192937.32129-1-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

The silead touch-controller ICs use a different firmware per digitizer /
tablet model. So there are going to be quite a few of then and they really
should be under a separate subdir.

This commit prefixes the default firmware names with "silead/" just like
we are already doing for devicetree specified firmware names.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/input/touchscreen/silead.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
index 7709f5b..c6a1ae9 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -414,14 +414,14 @@ static int silead_ts_set_default_fw_name(struct silead_ts_data *data,
 		if (!acpi_id)
 			return -ENODEV;
 
-		snprintf(data->fw_name, sizeof(data->fw_name), "%s.fw",
-			acpi_id->id);
+		snprintf(data->fw_name, sizeof(data->fw_name),
+			 "silead/%s.fw", acpi_id->id);
 
 		for (i = 0; i < strlen(data->fw_name); i++)
 			data->fw_name[i] = tolower(data->fw_name[i]);
 	} else {
-		snprintf(data->fw_name, sizeof(data->fw_name), "%s.fw",
-			id->name);
+		snprintf(data->fw_name, sizeof(data->fw_name),
+			 "silead/%s.fw", id->name);
 	}
 
 	return 0;
@@ -430,7 +430,8 @@ static int silead_ts_set_default_fw_name(struct silead_ts_data *data,
 static int silead_ts_set_default_fw_name(struct silead_ts_data *data,
 					 const struct i2c_device_id *id)
 {
-	snprintf(data->fw_name, sizeof(data->fw_name), "%s.fw", id->name);
+	snprintf(data->fw_name, sizeof(data->fw_name),
+		 "silead/%s.fw", id->name);
 	return 0;
 }
 #endif
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
