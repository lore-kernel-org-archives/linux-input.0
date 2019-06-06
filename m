From: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH v5 2/3] HID: quirks: Refactor ELAN 400 and 401 handling
Date: Thu,  6 Jun 2019 09:13:22 -0700
Message-ID: <20190606161322.47192-1-jeffrey.l.hugo@gmail.com>
References: <20190606161055.47089-1-jeffrey.l.hugo@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190606161055.47089-1-jeffrey.l.hugo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com, jikos@kernel.org
Cc: bjorn.andersson@linaro.org, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, agross@kernel.org, david.brown@linaro.org, hdegoede@redhat.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
List-Id: linux-input@vger.kernel.org

There needs to be coordination between hid-quirks and the elan_i2c driver
about which devices are handled by what drivers.  Currently, both use
whitelists, which results in valid devices being unhandled by default,
when they should not be rejected by hid-quirks.  This is quickly becoming
an issue.

Since elan_i2c has a maintained whitelist of what devices it will handle,
use that to implement a blacklist in hid-quirks so that only the devices
that need to be handled by elan_i2c get rejected by hid-quirks, and
everything else is handled by default.  The downside is the whitelist and
blacklist need to be kept in sync.

Suggested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
---
 drivers/hid/hid-quirks.c | 78 ++++++++++++++++++++++++++++++++++------
 1 file changed, 67 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index e5ca6fe2ca57..edebd0700e3d 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -912,8 +912,66 @@ static const struct hid_device_id hid_mouse_ignore_list[] = {
 	{ }
 };
 
+/* 
+ * List of device names that elan_i2c is handling and HID should ignore.  Must
+ * be kept in sync with elan_i2c
+ */
+static const char *hid_elan_i2c_ignore[] = {
+	"ELAN0000",
+	"ELAN0100",
+	"ELAN0600",
+	"ELAN0601",
+	"ELAN0602",
+	"ELAN0603",
+	"ELAN0604",
+	"ELAN0605",
+	"ELAN0606",
+	"ELAN0607",
+	"ELAN0608",
+	"ELAN0609",
+	"ELAN060B",
+	"ELAN060C",
+	"ELAN060F",
+	"ELAN0610",
+	"ELAN0611",
+	"ELAN0612",
+	"ELAN0613",
+	"ELAN0614",
+	"ELAN0615",
+	"ELAN0616",
+	"ELAN0617",
+	"ELAN0618",
+	"ELAN0619",
+	"ELAN061A",
+	"ELAN061B",
+	"ELAN061C",
+	"ELAN061D",
+	"ELAN061E",
+	"ELAN061F",
+	"ELAN0620",
+	"ELAN0621",
+	"ELAN0622",
+	"ELAN0623",
+	"ELAN0624",
+	"ELAN0625",
+	"ELAN0626",
+	"ELAN0627",
+	"ELAN0628",
+	"ELAN0629",
+	"ELAN062A",
+	"ELAN062B",
+	"ELAN062C",
+	"ELAN062D",
+	"ELAN0631",
+	"ELAN0632",
+	"ELAN1000",
+	"elan,ekth3000",
+	"" /* sentinel */
+};
 bool hid_ignore(struct hid_device *hdev)
 {
+	int i;
+
 	if (hdev->quirks & HID_QUIRK_NO_IGNORE)
 		return false;
 	if (hdev->quirks & HID_QUIRK_IGNORE)
@@ -978,18 +1036,16 @@ bool hid_ignore(struct hid_device *hdev)
 		break;
 	case USB_VENDOR_ID_ELAN:
 		/*
-		 * Many Elan devices have a product id of 0x0401 and are handled
-		 * by the elan_i2c input driver. But the ACPI HID ELAN0800 dev
-		 * is not (and cannot be) handled by that driver ->
-		 * Ignore all 0x0401 devs except for the ELAN0800 dev.
+		 * Blacklist of everything that gets handled by the elan_i2c
+		 * input driver.  This should be kept in sync with the whitelist
+		 * that exists in that driver.  This avoids disabling valid
+		 * touchpads and other ELAN devices.
 		 */
-		if (hdev->product == 0x0401 &&
-		    strncmp(hdev->name, "ELAN0800", 8) != 0)
-			return true;
-		/* Same with product id 0x0400 */
-		if (hdev->product == 0x0400 &&
-		    strncmp(hdev->name, "QTEC0001", 8) != 0)
-			return true;
+		if ((hdev->product == 0x0401 || hdev->product == 0x0400))
+			for (i = 0; strlen(hid_elan_i2c_ignore[i]); ++i)
+				if (!strncmp(hdev->name, hid_elan_i2c_ignore[i],
+					    strlen(hid_elan_i2c_ignore[i])))
+					return true;
 		break;
 	}
 
-- 
2.17.1
