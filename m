From: Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH v2 1/2] platform: Fix device check for surfacepro3_button
Date: Tue,  2 Jul 2019 02:37:39 +0200
Message-ID: <20190702003740.75970-2-luzmaximilian@gmail.com>
References: <20190702003740.75970-1-luzmaximilian@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702003740.75970-1-luzmaximilian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Chen Yu <yu.c.chen@intel.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Maximilian Luz <luzmaximilian@gmail.com>
List-Id: linux-input@vger.kernel.org

Do not use the surfacepro3_button driver on newer Microsoft Surface
models, only use it on the Surface Pro 3 and 4. Newer models (5th, 6th
and possibly future generations) use the same device as the Surface Pro
4 to represent their volume and power buttons (MSHW0040), but their
acutal implementation is significantly different. This patch ensures
that the surfacepro3_button driver is only used on the Pro 3 and 4
models, allowing a different driver to bind on other models.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/x86/surfacepro3_button.c | 38 +++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/platform/x86/surfacepro3_button.c b/drivers/platform/x86/surfacepro3_button.c
index 47c6d000465a..0e2c7dfafd9f 100644
--- a/drivers/platform/x86/surfacepro3_button.c
+++ b/drivers/platform/x86/surfacepro3_button.c
@@ -20,6 +20,12 @@
 #define SURFACE_BUTTON_OBJ_NAME		"VGBI"
 #define SURFACE_BUTTON_DEVICE_NAME	"Surface Pro 3/4 Buttons"
 
+#define MSHW0040_DSM_REVISION		0x01
+#define MSHW0040_DSM_GET_OMPR		0x02	// get OEM Platform Revision
+static const guid_t MSHW0040_DSM_UUID =
+	GUID_INIT(0x6fd05c69, 0xcde3, 0x49f4, 0x95, 0xed, 0xab, 0x16, 0x65,
+		  0x49, 0x80, 0x35);
+
 #define SURFACE_BUTTON_NOTIFY_TABLET_MODE	0xc8
 
 #define SURFACE_BUTTON_NOTIFY_PRESS_POWER	0xc6
@@ -142,6 +148,34 @@ static int surface_button_resume(struct device *dev)
 }
 #endif
 
+/*
+ * Surface Pro 4 and Surface Book 2 / Surface Pro 2017 use the same device
+ * ID (MSHW0040) for the power/volume buttons. Make sure this is the right
+ * device by checking for the _DSM method and OEM Platform Revision.
+ */
+static int surface_button_check_MSHW0040(struct acpi_device *dev)
+{
+	acpi_handle handle = dev->handle;
+	union acpi_object *result;
+	u64 oem_platform_rev = 0;
+
+	// get OEM platform revision
+	result = acpi_evaluate_dsm_typed(handle, &MSHW0040_DSM_UUID,
+					 MSHW0040_DSM_REVISION,
+					 MSHW0040_DSM_GET_OMPR,
+					 NULL, ACPI_TYPE_INTEGER);
+
+	if (result) {
+		oem_platform_rev = result->integer.value;
+		ACPI_FREE(result);
+	}
+
+	dev_dbg(&dev->dev, "OEM Platform Revision %llu\n", oem_platform_rev);
+
+	return oem_platform_rev == 0 ? 0 : -ENODEV;
+}
+
+
 static int surface_button_add(struct acpi_device *device)
 {
 	struct surface_button *button;
@@ -154,6 +188,10 @@ static int surface_button_add(struct acpi_device *device)
 	    strlen(SURFACE_BUTTON_OBJ_NAME)))
 		return -ENODEV;
 
+	error = surface_button_check_MSHW0040(device);
+	if (error)
+		return error;
+
 	button = kzalloc(sizeof(struct surface_button), GFP_KERNEL);
 	if (!button)
 		return -ENOMEM;
-- 
2.22.0
