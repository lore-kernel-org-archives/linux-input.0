From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 5/8] Input: elan_i2c - do not query the info if they are provided
Date: Fri, 24 May 2019 15:50:43 +0200
Message-ID: <20190524135046.17710-6-benjamin.tissoires@redhat.com>
References: <20190524135046.17710-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190524135046.17710-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, KT Liao <kt.liao@emc.com.tw>, Rob Herring <robh+dt@kernel.org>, Aaron Ma <aaron.ma@canonical.com>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

See the previous patch for a long explanation.

TL;DR: the P52 and the t480s from Lenovo can't rely on I2C to fetch
the information, so we need it from PS/2.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

--

no changes in v3

changes in v2:
- updated accroding to previous patch
---
 drivers/input/mouse/elan_i2c_core.c | 56 ++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index f9525d6f0bfe..53cac610ba33 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -366,27 +366,59 @@ static unsigned int elan_convert_resolution(u8 val)
 
 static int elan_query_device_parameters(struct elan_tp_data *data)
 {
+	struct i2c_client *client = data->client;
 	unsigned int x_traces, y_traces;
+	u32 x_mm, y_mm;
 	u8 hw_x_res, hw_y_res;
 	int error;
 
-	error = data->ops->get_max(data->client, &data->max_x, &data->max_y);
-	if (error)
-		return error;
-
-	error = data->ops->get_num_traces(data->client, &x_traces, &y_traces);
-	if (error)
-		return error;
+	if (device_property_read_u32(&client->dev,
+				     "touchscreen-size-x", &data->max_x) ||
+	    device_property_read_u32(&client->dev,
+				     "touchscreen-size-y", &data->max_y)) {
+		error = data->ops->get_max(data->client,
+					   &data->max_x,
+					   &data->max_y);
+		if (error)
+			return error;
+	} else {
+		/* size is the maximum + 1 */
+		--data->max_x;
+		--data->max_y;
+	}
 
+	if (device_property_read_u32(&client->dev,
+				     "elan,x_traces",
+				     &x_traces) ||
+	    device_property_read_u32(&client->dev,
+				     "elan,y_traces",
+				     &y_traces)) {
+		error = data->ops->get_num_traces(data->client,
+						  &x_traces, &y_traces);
+		if (error)
+			return error;
+	}
 	data->width_x = data->max_x / x_traces;
 	data->width_y = data->max_y / y_traces;
 
-	error = data->ops->get_resolution(data->client, &hw_x_res, &hw_y_res);
-	if (error)
-		return error;
+	if (device_property_read_u32(&client->dev,
+				     "touchscreen-x-mm", &x_mm) ||
+	    device_property_read_u32(&client->dev,
+				     "touchscreen-y-mm", &y_mm)) {
+		error = data->ops->get_resolution(data->client,
+						  &hw_x_res, &hw_y_res);
+		if (error)
+			return error;
+
+		data->x_res = elan_convert_resolution(hw_x_res);
+		data->y_res = elan_convert_resolution(hw_y_res);
+	} else {
+		data->x_res = (data->max_x + 1) / x_mm;
+		data->y_res = (data->max_y + 1) / y_mm;
+	}
 
-	data->x_res = elan_convert_resolution(hw_x_res);
-	data->y_res = elan_convert_resolution(hw_y_res);
+	if (device_property_read_bool(&client->dev, "elan,clickpad"))
+		data->clickpad = 1;
 
 	return 0;
 }
-- 
2.21.0
