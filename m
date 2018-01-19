From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] i2c-hid: Use ACPI_COMPANION() directly
Date: Fri, 19 Jan 2018 16:35:04 +0200
Message-ID: <20180119143504.16684-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7434 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754809AbeASOfH (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Jan 2018 09:35:07 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Instead of doing additional checks and functional calls,
just get ACPI companion device directly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 7230243b94d3..0d3ca542e987 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -891,10 +891,10 @@ static int i2c_hid_acpi_pdata(struct i2c_client *client,
 
 static void i2c_hid_acpi_fix_up_power(struct device *dev)
 {
-	acpi_handle handle = ACPI_HANDLE(dev);
 	struct acpi_device *adev;
 
-	if (handle && acpi_bus_get_device(handle, &adev) == 0)
+	adev = ACPI_COMPANION(dev);
+	if (adev)
 		acpi_device_fix_up_power(adev);
 }
 
-- 
2.15.1

