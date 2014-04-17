From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3] synaptics: Add min/max quirk for ThinkPad T431s, L440, L540, S1 Yoga and X1
Date: Thu, 17 Apr 2014 13:41:43 +0200
Message-ID: <1397734903-26088-2-git-send-email-hdegoede@redhat.com>
References: <1397734903-26088-1-git-send-email-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1397734903-26088-1-git-send-email-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

We expect that all the Haswell series will need such quirks, sigh.

The T431s seems to be T430 hardware in a T440s case, using the T440s touchpad,
with the same min/max issue.

The X1 Carbon 3rd generation name says 2nd while it is a 3rd generation.

The X1 and T431s share a PnPID with the T540p, but the reported ranges are
closer to those of the T440s.

HdG: Squashed 5 quirk patches into one. T431s + L440 + L540 are written by me,
S1 Yoga and X1 are written by Benjamin Tissoires.

Hdg: Standardized S1 Yoga and X1 values, Yoga uses the same touchpad as the
X240, X1 uses the same touchpad as the T440.

Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/synaptics.c | 42 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index a8b57d7..7c9f509 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1566,6 +1566,14 @@ static const struct dmi_system_id min_max_dmi_table[] __initconst = {
 		.driver_data = (int []){1232, 5710, 1156, 4696},
 	},
 	{
+		/* Lenovo ThinkPad T431s */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T431"),
+		},
+		.driver_data = (int []){1024, 5112, 2024, 4832},
+	},
+	{
 		/* Lenovo ThinkPad T440s */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
@@ -1574,6 +1582,14 @@ static const struct dmi_system_id min_max_dmi_table[] __initconst = {
 		.driver_data = (int []){1024, 5112, 2024, 4832},
 	},
 	{
+		/* Lenovo ThinkPad L440 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L440"),
+		},
+		.driver_data = (int []){1024, 5112, 2024, 4832},
+	},
+	{
 		/* Lenovo ThinkPad T540p */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
@@ -1581,6 +1597,32 @@ static const struct dmi_system_id min_max_dmi_table[] __initconst = {
 		},
 		.driver_data = (int []){1024, 5056, 2058, 4832},
 	},
+	{
+		/* Lenovo ThinkPad L540 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L540"),
+		},
+		.driver_data = (int []){1024, 5112, 2024, 4832},
+	},
+	{
+		/* Lenovo Yoga S1 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
+					"ThinkPad S1 Yoga"),
+		},
+		.driver_data = (int []){1232, 5710, 1156, 4696},
+	},
+	{
+		/* Lenovo ThinkPad X1 Carbon Haswell (3rd generation) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION,
+					"ThinkPad X1 Carbon 2nd"),
+		},
+		.driver_data = (int []){1024, 5112, 2024, 4832},
+	},
 #endif
 	{ }
 };
-- 
1.9.0
