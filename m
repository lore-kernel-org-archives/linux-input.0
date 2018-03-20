From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 03/14] Input: atmel_mxt_ts - switch ChromeOS ACPI devices to generic props
Date: Tue, 20 Mar 2018 15:31:27 -0700
Message-ID: <20180320223138.234724-4-dmitry.torokhov@gmail.com>
References: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Move older ChromeOS devices describing Atmel controllers in ACPI, but not
providing enough details to configure the controllers properly, from
platform data over to generic device properties. This will allow us
remove support for platform data later on, leaving only generic device
properties in place.

Acked-by: Nick Dyer <nick@shmanahar.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 63 +++++++++++++++---------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 73d9c0254ad76..799d2ac35787b 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2974,7 +2974,7 @@ mxt_parse_device_properties(struct i2c_client *client)
 
 struct mxt_acpi_platform_data {
 	const char *hid;
-	struct mxt_platform_data pdata;
+	const struct property_entry *props;
 };
 
 static unsigned int samus_touchpad_buttons[] = {
@@ -2984,14 +2984,16 @@ static unsigned int samus_touchpad_buttons[] = {
 	BTN_LEFT
 };
 
+static const struct property_entry samus_touchpad_props[] = {
+	PROPERTY_ENTRY_U32_ARRAY("linux,gpio-keymap", samus_touchpad_buttons),
+	{ }
+};
+
 static struct mxt_acpi_platform_data samus_platform_data[] = {
 	{
 		/* Touchpad */
 		.hid	= "ATML0000",
-		.pdata	= {
-			.t19_num_keys	= ARRAY_SIZE(samus_touchpad_buttons),
-			.t19_keymap	= samus_touchpad_buttons,
-		},
+		.props	= samus_touchpad_props,
 	},
 	{
 		/* Touchscreen */
@@ -3009,14 +3011,16 @@ static unsigned int chromebook_tp_buttons[] = {
 	BTN_LEFT
 };
 
+static const struct property_entry chromebook_tp_props[] = {
+	PROPERTY_ENTRY_U32_ARRAY("linux,gpio-keymap", chromebook_tp_buttons),
+	{ }
+};
+
 static struct mxt_acpi_platform_data chromebook_platform_data[] = {
 	{
 		/* Touchpad */
 		.hid	= "ATML0000",
-		.pdata	= {
-			.t19_num_keys	= ARRAY_SIZE(chromebook_tp_buttons),
-			.t19_keymap	= chromebook_tp_buttons,
-		},
+		.props	= chromebook_tp_props,
 	},
 	{
 		/* Touchscreen */
@@ -3046,7 +3050,7 @@ static const struct dmi_system_id mxt_dmi_table[] = {
 	{ }
 };
 
-static const struct mxt_platform_data *mxt_parse_acpi(struct i2c_client *client)
+static int mxt_acpi_probe(struct i2c_client *client)
 {
 	struct acpi_device *adev;
 	const struct dmi_system_id *system_id;
@@ -3063,33 +3067,46 @@ static const struct mxt_platform_data *mxt_parse_acpi(struct i2c_client *client)
 	 * as a threshold.
 	 */
 	if (client->addr < 0x40)
-		return ERR_PTR(-ENXIO);
+		return -ENXIO;
 
 	adev = ACPI_COMPANION(&client->dev);
 	if (!adev)
-		return ERR_PTR(-ENOENT);
+		return -ENOENT;
 
 	system_id = dmi_first_match(mxt_dmi_table);
 	if (!system_id)
-		return ERR_PTR(-ENOENT);
+		return -ENOENT;
 
 	acpi_pdata = system_id->driver_data;
 	if (!acpi_pdata)
-		return ERR_PTR(-ENOENT);
+		return -ENOENT;
 
 	while (acpi_pdata->hid) {
-		if (!strcmp(acpi_device_hid(adev), acpi_pdata->hid))
-			return &acpi_pdata->pdata;
+		if (!strcmp(acpi_device_hid(adev), acpi_pdata->hid)) {
+			/*
+			 * Remove previously installed properties if we
+			 * are probing this device not for the very first
+			 * time.
+			 */
+			device_remove_properties(&client->dev);
+
+			/*
+			 * Now install the platform-specific properties
+			 * that are missing from ACPI.
+			 */
+			device_add_properties(&client->dev, acpi_pdata->props);
+			break;
+		}
 
 		acpi_pdata++;
 	}
 
-	return ERR_PTR(-ENOENT);
+	return 0;
 }
 #else
-static const struct mxt_platform_data *mxt_parse_acpi(struct i2c_client *client)
+static int mxt_acpi_probe(struct i2c_client *client)
 {
-	return ERR_PTR(-ENOENT);
+	return -ENOENT;
 }
 #endif
 
@@ -3102,10 +3119,6 @@ mxt_get_platform_data(struct i2c_client *client)
 	if (pdata)
 		return pdata;
 
-	pdata = mxt_parse_acpi(client);
-	if (!IS_ERR(pdata) || PTR_ERR(pdata) != -ENOENT)
-		return pdata;
-
 	return mxt_parse_device_properties(client);
 }
 
@@ -3130,6 +3143,10 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	const struct mxt_platform_data *pdata;
 	int error;
 
+	error = mxt_acpi_probe(client);
+	if (error && error != -ENOENT)
+		return error;
+
 	pdata = mxt_get_platform_data(client);
 	if (IS_ERR(pdata))
 		return PTR_ERR(pdata);
-- 
2.16.2.804.g6dcf76e118-goog
