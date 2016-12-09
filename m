From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/4] Input: silead_gsl1680: Allow silead_ts_read_props to override default resolution
Date: Fri,  9 Dec 2016 11:35:21 +0100
Message-ID: <20161209103522.3833-3-hdegoede@redhat.com>
References: <20161209103522.3833-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932349AbcLIKf2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 9 Dec 2016 05:35:28 -0500
In-Reply-To: <20161209103522.3833-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Set the default max_x / max_y in prop.max_? before calling
silead_ts_read_props, so that silead_ts_read_props can override
them. This will be used to fill in DMI based touchscreen info on
ACPI based tablets, since the APCI touchscreen node does not
contain resolution info.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/touchscreen/silead.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
index 4387cd8..d6593bb 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -99,8 +99,10 @@ static int silead_ts_request_input_dev(struct silead_ts_data *data)
 		return -ENOMEM;
 	}
 
-	input_set_abs_params(data->input, ABS_MT_POSITION_X, 0, 4095, 0, 0);
-	input_set_abs_params(data->input, ABS_MT_POSITION_Y, 0, 4095, 0, 0);
+	input_set_abs_params(data->input, ABS_MT_POSITION_X, 0,
+			     data->prop.max_x, 0, 0);
+	input_set_abs_params(data->input, ABS_MT_POSITION_Y, 0,
+			     data->prop.max_y, 0, 0);
 	touchscreen_parse_properties(data->input, true, &data->prop);
 
 	input_mt_init_slots(data->input, data->max_fingers,
@@ -454,6 +456,8 @@ static int silead_ts_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, data);
 	data->client = client;
+	data->prop.max_x = 4095;
+	data->prop.max_y = 4095;
 
 	error = silead_ts_set_default_fw_name(data, id);
 	if (error)
-- 
2.9.3

