From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] HID: i2c: Call acpi_device_fix_up_power for ACPI-enumerated devices
Date: Tue,  9 May 2017 10:04:36 +0200
Message-ID: <20170509080436.19233-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751764AbdEIIEl (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 9 May 2017 04:04:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

For ACPI devices which do not have a _PSC method, the ACPI subsys cannot
query their initial state at boot, so these devices are assumed to have
been put in D0 by the BIOS, but for touchscreens that is not always true.

This commit adds a call to acpi_device_fix_up_power to explicitly put
devices without a _PSC method into D0 state (for devices with a _PSC
method it is a nop). Note we only need to do this on probe, after a
resume the ACPI subsys knows the device is in D3 and will properly
put it in D0.

This fixes the SIS0817 i2c-hid touchscreen on a Peaq C1010 2-in-1
device failing to probe with a "hid_descr_cmd failed" error.

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Improve commit msg
-Add Benjamin's Acked-by
---
 drivers/hid/i2c-hid/i2c-hid.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index ea3c3546cef7..c716d9605940 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -960,6 +960,15 @@ static int i2c_hid_acpi_pdata(struct i2c_client *client,
 	return 0;
 }
 
+static void i2c_hid_acpi_fix_up_power(struct device *dev)
+{
+	acpi_handle handle = ACPI_HANDLE(dev);
+	struct acpi_device *adev;
+
+	if (handle && acpi_bus_get_device(handle, &adev) == 0)
+		acpi_device_fix_up_power(adev);
+}
+
 static const struct acpi_device_id i2c_hid_acpi_match[] = {
 	{"ACPI0C50", 0 },
 	{"PNP0C50", 0 },
@@ -972,6 +981,8 @@ static inline int i2c_hid_acpi_pdata(struct i2c_client *client,
 {
 	return -ENODEV;
 }
+
+static inline void i2c_hid_acpi_fix_up_power(struct device *dev) {}
 #endif
 
 #ifdef CONFIG_OF
@@ -1070,6 +1081,8 @@ static int i2c_hid_probe(struct i2c_client *client,
 	if (ret < 0)
 		goto err;
 
+	i2c_hid_acpi_fix_up_power(&client->dev);
+
 	pm_runtime_get_noresume(&client->dev);
 	pm_runtime_set_active(&client->dev);
 	pm_runtime_enable(&client->dev);
-- 
2.12.2

