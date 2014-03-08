From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] input: synaptics add manual min/max quirk for ThinkPad X240
Date: Sat,  8 Mar 2014 12:35:21 +0100
Message-ID: <1394278521-6870-2-git-send-email-hdegoede@redhat.com>
References: <1394278521-6870-1-git-send-email-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1394278521-6870-1-git-send-email-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>, Stephen Chandler Paul <thatslyude@gmail.com>, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This extends Benjamin Tissoires manual min/max quirk table with support for
the ThinkPad X240.

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/synaptics.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index ff6a4cf..b522bdc 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1505,6 +1505,14 @@ static const struct dmi_system_id min_max_dmi_table[] __initconst = {
 		.driver_data = (int []){1024, 5052, 2258, 4832},
 	},
 	{
+		/* Lenovo ThinkPad X240 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X240"),
+		},
+		.driver_data = (int []){1232, 5710, 1156, 4696},
+	},
+	{
 		/* Lenovo ThinkPad T440s */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-- 
1.8.4.2
