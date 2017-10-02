From: Rajat Jain <rajatja@google.com>
Subject: [PATCH] HID: i2c-hid: Allow ACPI systems to specify "post-power-on-delay-ms"
Date: Mon,  2 Oct 2017 14:32:15 -0700
Message-ID: <20171002213215.32201-1-rajatja@google.com>
References: <1506874730.16112.194.camel@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1506874730.16112.194.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Arcari <darcari@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, HungNien Chen <hn.chen@weidahitech.com>, Hans de Goede <hdegoede@redhat.com>, Brian Norris <briannorris@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@google.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rajatxjain@gmail.com
Cc: Rajat Jain <rajatja@google.com>
List-Id: linux-input@vger.kernel.org

The property "post-power-on-delay-ms"" allows a platform to specify
the delay needed after power-on, but only via device trees. Thus
allow ACPI systems to also provide the same information.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 77396145d2d0..97405156315a 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -865,6 +865,7 @@ static int i2c_hid_acpi_pdata(struct i2c_client *client,
 	union acpi_object *obj;
 	struct acpi_device *adev;
 	acpi_handle handle;
+	u32 val;
 
 	handle = ACPI_HANDLE(&client->dev);
 	if (!handle || acpi_bus_get_device(handle, &adev))
@@ -880,6 +881,10 @@ static int i2c_hid_acpi_pdata(struct i2c_client *client,
 	pdata->hid_descriptor_address = obj->integer.value;
 	ACPI_FREE(obj);
 
+	if (!device_property_read_u32(&client->dev, "post-power-on-delay-ms",
+				      &val))
+		pdata->post_power_delay_ms = val;
+
 	return 0;
 }
 
-- 
2.14.2.822.g60be5d43e6-goog
