From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] HID: i2c-hid: Do not fail probing if gpiolib is not enabled
Date: Tue, 14 Apr 2015 17:35:12 +0300
Message-ID: <1429022112-231578-1-git-send-email-mika.westerberg@linux.intel.com>
References: <7007524.JGeOHMMZVW@xps13>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19931 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753852AbbDNOfs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Apr 2015 10:35:48 -0400
In-Reply-To: <7007524.JGeOHMMZVW@xps13>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Gabriele Mazzotta <gabriele.mzt@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Using GPIOs and gpiolib is optional. If the kernel is compiled without GPIO
support the driver should not fail if it finds the interrupt using normal
methods.

However, commit a485923efbb8 ("HID: i2c-hid: Add support for ACPI GPIO
interrupts") did not take into account that acpi_dev_add_driver_gpios()
returns -ENXIO when !CONFIG_GPIOLIB.

Fix this by checking the return value against -ENXIO and 0 and only in that
case fail the probe.

Reported-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index ab4dd952b6ba..92d6cdf02460 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -862,6 +862,7 @@ static int i2c_hid_acpi_pdata(struct i2c_client *client,
 	union acpi_object *obj;
 	struct acpi_device *adev;
 	acpi_handle handle;
+	int ret;
 
 	handle = ACPI_HANDLE(&client->dev);
 	if (!handle || acpi_bus_get_device(handle, &adev))
@@ -877,7 +878,9 @@ static int i2c_hid_acpi_pdata(struct i2c_client *client,
 	pdata->hid_descriptor_address = obj->integer.value;
 	ACPI_FREE(obj);
 
-	return acpi_dev_add_driver_gpios(adev, i2c_hid_acpi_gpios);
+	/* GPIOs are optional */
+	ret = acpi_dev_add_driver_gpios(adev, i2c_hid_acpi_gpios);
+	return ret < 0 && ret != -ENXIO ? ret : 0;
 }
 
 static const struct acpi_device_id i2c_hid_acpi_match[] = {
-- 
2.1.4

