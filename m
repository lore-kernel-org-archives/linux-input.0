From: Rajat Jain <rajatja@google.com>
Subject: [PATCH v3] HID: i2c-hid: Allow ACPI systems to specify "post-power-on-delay-ms"
Date: Tue,  3 Oct 2017 11:19:21 -0700
Message-ID: <20171003181922.42827-1-rajatja@google.com>
References: <20171002213215.32201-1-rajatja@google.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:51886 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbdJCSTf (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 3 Oct 2017 14:19:35 -0400
Received: by mail-pg0-f43.google.com with SMTP id u144so2473778pgb.8
        for <linux-input@vger.kernel.org>; Tue, 03 Oct 2017 11:19:35 -0700 (PDT)
In-Reply-To: <20171002213215.32201-1-rajatja@google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Rajat Jain <rajatja@google.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Arcari <darcari@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, HungNien Chen <hn.chen@weidahitech.com>, Hans de Goede <hdegoede@redhat.com>, Brian Norris <briannorris@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@google.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rajatxjain@gmail.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The property "post-power-on-delay-ms" allows a platform to specify
the delay needed after power-on, but only via device trees currently.
Use device_property_* instead of of_* reads to allow ACPI systems to
also provide the same information. This is useful for Wacom hardware
on ACPI systems.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v3: introduce i2c_hid_fwnode_probe() to parse common device_properties.
    Also fixup the binding doc to indicate that regulator isn't a
    requirement for "post-power-on-delay-ms"
v2: Don't change any other existing logic, only read "post-power-on-delay-ms"
    in i2c_hid_acpi_pdata() also.
v1: Try to unify everything using device properties, convert i2c_hid_of_probe()
    to i2c_hid_fwnode_probe() and call i2c_hid_acpi_pdata() if can't get
    HID register address using device_property.

 .../devicetree/bindings/input/hid-over-i2c.txt         |  2 +-
 drivers/hid/i2c-hid/i2c-hid.c                          | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.txt b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
index 28e8bd8b7d64..4d3da9d91de4 100644
--- a/Documentation/devicetree/bindings/input/hid-over-i2c.txt
+++ b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
@@ -31,7 +31,7 @@ device-specific compatible properties, which should be used in addition to the
 
 - vdd-supply: phandle of the regulator that provides the supply voltage.
 - post-power-on-delay-ms: time required by the device after enabling its regulators
-  before it is ready for communication. Must be used with 'vdd-supply'.
+  or powering it on, before it is ready for communication.
 
 Example:
 
diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 77396145d2d0..741a457dfe61 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -928,11 +928,6 @@ static int i2c_hid_of_probe(struct i2c_client *client,
 	}
 	pdata->hid_descriptor_address = val;
 
-	ret = of_property_read_u32(dev->of_node, "post-power-on-delay-ms",
-				   &val);
-	if (!ret)
-		pdata->post_power_delay_ms = val;
-
 	return 0;
 }
 
@@ -949,6 +944,16 @@ static inline int i2c_hid_of_probe(struct i2c_client *client,
 }
 #endif
 
+static void i2c_hid_fwnode_probe(struct i2c_client *client,
+				 struct i2c_hid_platform_data *pdata)
+{
+	u32 val;
+
+	if (!device_property_read_u32(&client->dev, "post-power-on-delay-ms",
+				      &val))
+		pdata->post_power_delay_ms = val;
+}
+
 static int i2c_hid_probe(struct i2c_client *client,
 			 const struct i2c_device_id *dev_id)
 {
@@ -992,6 +997,9 @@ static int i2c_hid_probe(struct i2c_client *client,
 		ihid->pdata = *platform_data;
 	}
 
+	/* Parse platform agnostic common properties from ACPI / device tree */
+	i2c_hid_fwnode_probe(client, &ihid->pdata);
+
 	ihid->pdata.supply = devm_regulator_get(&client->dev, "vdd");
 	if (IS_ERR(ihid->pdata.supply)) {
 		ret = PTR_ERR(ihid->pdata.supply);
-- 
2.14.2.822.g60be5d43e6-goog

