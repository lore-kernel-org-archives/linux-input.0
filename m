From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend fixes for 4.8 2/2] input: touchscreen: silead_gsl1680: Use "silead/" prefix for firmware loading
Date: Wed,  7 Sep 2016 22:09:57 +0200
Message-ID: <20160907200957.3341-3-hdegoede@redhat.com>
References: <20160907200957.3341-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932299AbcIGUKJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 7 Sep 2016 16:10:09 -0400
In-Reply-To: <20160907200957.3341-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>

The silead touch-controller ICs use a different firmware per digitizer /
tablet model. So there are going to be quite a few of then and they really
should be under a separate subdir.

This commit prefixes the default firmware names with "silead/" just like
we are already doing for devicetree specified firmware names.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
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

