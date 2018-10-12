From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 4/5] Input: elan_i2c - do not query the info if they are provided
Date: Fri, 12 Oct 2018 16:24:12 +0200
Message-ID: <20181012142413.26107-5-benjamin.tissoires@redhat.com>
References: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: KT Liao <kt.liao@emc.com.tw>, Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

See the previous patch for a long explanation.

TL;DR: the P52 and the t480s from Lenovo can't rely on I2C to fetch
the information, so we need it from PS/2.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1628715
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/elan_i2c_core.c | 49 +++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index f5ae24865355..5e7ba383f95c 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -366,27 +366,50 @@ static unsigned int elan_convert_resolution(u8 val)
 
 static int elan_query_device_parameters(struct elan_tp_data *data)
 {
+	struct i2c_client *client = data->client;
 	unsigned int x_traces, y_traces;
 	u8 hw_x_res, hw_y_res;
 	int error;
 
-	error = data->ops->get_max(data->client, &data->max_x, &data->max_y);
-	if (error)
-		return error;
+	if (device_property_read_u32(&client->dev,
+				     "elan,max_x", &data->max_x) ||
+	    device_property_read_u32(&client->dev,
+				     "elan,max_y", &data->max_y)) {
+		error = data->ops->get_max(data->client,
+					   &data->max_x,
+					   &data->max_y);
+		if (error)
+			return error;
+	}
 
-	error = data->ops->get_num_traces(data->client, &x_traces, &y_traces);
-	if (error)
-		return error;
+	if (device_property_read_u32(&client->dev,
+				     "elan,width", &data->width_x)) {
+		error = data->ops->get_num_traces(data->client,
+						  &x_traces, &y_traces);
+		if (error)
+			return error;
 
-	data->width_x = data->max_x / x_traces;
-	data->width_y = data->max_y / y_traces;
+		data->width_x = data->max_x / x_traces;
+		data->width_y = data->max_y / y_traces;
+	} else {
+		data->width_y = data->width_x;
+	}
 
-	error = data->ops->get_resolution(data->client, &hw_x_res, &hw_y_res);
-	if (error)
-		return error;
+	if (device_property_read_u32(&client->dev,
+				     "elan,x_res", &data->x_res) ||
+	    device_property_read_u32(&client->dev,
+				     "elan,y_res", &data->y_res)) {
+		error = data->ops->get_resolution(data->client,
+						  &hw_x_res, &hw_y_res);
+		if (error)
+			return error;
+
+		data->x_res = elan_convert_resolution(hw_x_res);
+		data->y_res = elan_convert_resolution(hw_y_res);
+	}
 
-	data->x_res = elan_convert_resolution(hw_x_res);
-	data->y_res = elan_convert_resolution(hw_y_res);
+	if (device_property_read_bool(&client->dev, "elan,clickpad"))
+		data->clickpad = 1;
 
 	return 0;
 }
-- 
2.14.3
