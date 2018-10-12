From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 5/5] Input: elantech/SMBus - export all capabilities from the PS/2 node
Date: Fri, 12 Oct 2018 16:24:13 +0200
Message-ID: <20181012142413.26107-6-benjamin.tissoires@redhat.com>
References: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: KT Liao <kt.liao@emc.com.tw>, Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

The recent touchpads might not have all the information regarding the
characteristics through the I2C port.
On some Lenovo t480s, this results in the touchpad not being detected
as a clickpad, and on the Lenovo P52, this results in a failure while
fetching the resolution through I2C.

We need to imitate the Windows behavior: fetch the data under PS/2, and
limit the querries under I2C.

This patch exports the needed info from PS/2.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1628715
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/elantech.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 78ac732e8188..f597b5d14de8 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1764,17 +1764,30 @@ static int elantech_create_smbus(struct psmouse *psmouse,
 				 struct elantech_device_info *info,
 				 bool leave_breadcrumbs)
 {
-	const struct property_entry i2c_properties[] = {
-		PROPERTY_ENTRY_BOOL("elan,trackpoint"),
-		{ },
-	};
+	struct property_entry i2c_props[10] = {};
 	struct i2c_board_info smbus_board = {
 		I2C_BOARD_INFO("elan_i2c", 0x15),
 		.flags = I2C_CLIENT_HOST_NOTIFY,
 	};
+	unsigned int prop_idx = 0;
+
+	smbus_board.properties = i2c_props;
+
+	i2c_props[prop_idx++] = PROPERTY_ENTRY_U32("elan,max_x", info->x_max);
+	i2c_props[prop_idx++] = PROPERTY_ENTRY_U32("elan,max_y", info->y_max);
+	i2c_props[prop_idx++] = PROPERTY_ENTRY_U32("elan,min_x", info->x_min);
+	i2c_props[prop_idx++] = PROPERTY_ENTRY_U32("elan,min_y", info->y_min);
+	i2c_props[prop_idx++] = PROPERTY_ENTRY_U32("elan,x_res", info->x_res);
+	i2c_props[prop_idx++] = PROPERTY_ENTRY_U32("elan,y_res", info->y_res);
 
 	if (info->has_trackpoint)
-		smbus_board.properties = i2c_properties;
+		i2c_props[prop_idx++] = PROPERTY_ENTRY_BOOL("elan,trackpoint");
+
+	if (info->width)
+		i2c_props[prop_idx++] = PROPERTY_ENTRY_U32("elan,width", info->width);
+
+	if (elantech_is_buttonpad(info))
+		i2c_props[prop_idx++] = PROPERTY_ENTRY_BOOL("elan,clickpad");
 
 	return psmouse_smbus_init(psmouse, &smbus_board, NULL, 0, false,
 				  leave_breadcrumbs);
-- 
2.14.3
