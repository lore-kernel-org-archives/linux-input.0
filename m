From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 6/8] Input: elantech/SMBus - export all capabilities from the PS/2 node
Date: Fri, 24 May 2019 15:50:44 +0200
Message-ID: <20190524135046.17710-7-benjamin.tissoires@redhat.com>
References: <20190524135046.17710-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190524135046.17710-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, KT Liao <kt.liao@emc.com.tw>, Rob Herring <robh+dt@kernel.org>, Aaron Ma <aaron.ma@canonical.com>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

The recent touchpads might not have all the information regarding the
characteristics through the I2C port.
On some Lenovo t480s, this results in the touchpad not being detected
as a clickpad, and on the Lenovo P52, this results in a failure while
fetching the resolution through I2C.

We need to imitate the Windows behavior: fetch the data under PS/2, and
limit the querries under I2C.

This patch prepares this by exporting the info from PS/2.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

--

no changes in v3

changes in v2:
- updated according to the 2 previous patches
---
 drivers/input/mouse/elantech.c | 47 ++++++++++++++++++++++++++++++----
 drivers/input/mouse/elantech.h |  2 ++
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 057a3cf01eec..ca10fd97d9d5 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1736,6 +1736,15 @@ static int elantech_query_info(struct psmouse *psmouse,
 			return -EINVAL;
 
 		info->width = info->x_max / (traces - 1);
+
+		/* column number of traces */
+		info->x_traces = traces;
+
+		/* row number of traces */
+		traces = info->capabilities[2];
+		if ((traces >= 2) && (traces <= info->y_max))
+			info->y_traces = traces;
+
 		break;
 	}
 
@@ -1781,17 +1790,45 @@ static int elantech_create_smbus(struct psmouse *psmouse,
 				 struct elantech_device_info *info,
 				 bool leave_breadcrumbs)
 {
-	const struct property_entry i2c_properties[] = {
-		PROPERTY_ENTRY_BOOL("elan,trackpoint"),
-		{ },
-	};
+	struct property_entry i2c_props[11] = {};
 	struct i2c_board_info smbus_board = {
 		I2C_BOARD_INFO("elan_i2c", 0x15),
 		.flags = I2C_CLIENT_HOST_NOTIFY,
 	};
+	unsigned int idx = 0;
+
+	smbus_board.properties = i2c_props;
+
+	i2c_props[idx++] = PROPERTY_ENTRY_U32("touchscreen-size-x",
+						   info->x_max + 1);
+	i2c_props[idx++] = PROPERTY_ENTRY_U32("touchscreen-size-y",
+						   info->y_max + 1);
+	i2c_props[idx++] = PROPERTY_ENTRY_U32("touchscreen-min-x",
+						   info->x_min);
+	i2c_props[idx++] = PROPERTY_ENTRY_U32("touchscreen-min-y",
+						   info->y_min);
+	if (info->x_res)
+		i2c_props[idx++] = PROPERTY_ENTRY_U32("touchscreen-x-mm",
+						      (info->x_max + 1) / info->x_res);
+	if (info->y_res)
+		i2c_props[idx++] = PROPERTY_ENTRY_U32("touchscreen-y-mm",
+						      (info->y_max + 1) / info->y_res);
 
 	if (info->has_trackpoint)
-		smbus_board.properties = i2c_properties;
+		i2c_props[idx++] = PROPERTY_ENTRY_BOOL("elan,trackpoint");
+
+	if (info->has_middle_button)
+		i2c_props[idx++] = PROPERTY_ENTRY_BOOL("elan,middle-button");
+
+	if (info->x_traces)
+		i2c_props[idx++] = PROPERTY_ENTRY_U32("elan,x_traces",
+						      info->x_traces);
+	if (info->y_traces)
+		i2c_props[idx++] = PROPERTY_ENTRY_U32("elan,y_traces",
+						      info->y_traces);
+
+	if (elantech_is_buttonpad(info))
+		i2c_props[idx++] = PROPERTY_ENTRY_BOOL("elan,clickpad");
 
 	return psmouse_smbus_init(psmouse, &smbus_board, NULL, 0, false,
 				  leave_breadcrumbs);
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
index 16174b54ffc3..a7eaa62af6a0 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -150,6 +150,8 @@ struct elantech_device_info {
 	unsigned int y_max;
 	unsigned int x_res;
 	unsigned int y_res;
+	unsigned int x_traces;
+	unsigned int y_traces;
 	unsigned int width;
 	unsigned int bus;
 	bool paritycheck;
-- 
2.21.0
