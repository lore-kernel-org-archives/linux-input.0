From: Stephen Just <stephenjust@gmail.com>
Subject: [PATCH v2 2/2] Input - surface3_spi: add surface pen support for Surface 3
Date: Tue, 24 May 2016 07:43:53 -0600
Message-ID: <1464097434-10063-3-git-send-email-stephenjust@gmail.com>
References: <1464011734-18657-1-git-send-email-stephenjust@gmail.com>
 <1464097434-10063-1-git-send-email-stephenjust@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:33976 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389AbcEXTsP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 May 2016 15:48:15 -0400
Received: by mail-io0-f193.google.com with SMTP id d197so3075296ioe.1
        for <linux-input@vger.kernel.org>; Tue, 24 May 2016 12:48:14 -0700 (PDT)
In-Reply-To: <1464097434-10063-1-git-send-email-stephenjust@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Stephen Just <stephenjust@gmail.com>, Bastien Nocera <hadess@hadess.net>

This change creates a second input device which will handle input from
a Surface Pen. The Surface Pen supplies a different packet header than
touch events, so it is simple to handle one or the other.

This patch handles both the newer Surface Pen with one button, and the
older variant with a second button to switch to Eraser mode.

Signed-off-by: Stephen Just <stephenjust@gmail.com>
---
 drivers/input/touchscreen/surface3_spi.c | 111 ++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/surface3_spi.c b/drivers/input/touchscreen/surface3_spi.c
index 204a162..665b02c 100644
--- a/drivers/input/touchscreen/surface3_spi.c
+++ b/drivers/input/touchscreen/surface3_spi.c
@@ -28,11 +28,13 @@
 #define SURFACE3_PACKET_SIZE	264
 
 #define SURFACE3_REPORT_TOUCH	0xd2
+#define SURFACE3_REPORT_PEN	0x16
 
 struct surface3_ts_data {
 	struct spi_device *spi;
 	struct gpio_desc *gpiod_rst[2];
 	struct input_dev *input_dev;
+	struct input_dev *pen_input_dev;
 
 	u8 rd_buf[SURFACE3_PACKET_SIZE]		____cacheline_aligned;
 };
@@ -49,6 +51,14 @@ struct surface3_ts_data_finger {
 	u32 padding;
 } __packed;
 
+struct surface3_ts_data_pen {
+	u8 status;
+	__le16 x;
+	__le16 y;
+	__le16 pressure;
+	u8 padding;
+} __packed;
+
 static int surface3_spi_read(struct surface3_ts_data *ts_data)
 {
 	struct spi_device *spi = ts_data->spi;
@@ -114,6 +124,52 @@ static void surface3_spi_process_touch(struct surface3_ts_data *ts_data, u8 *dat
 	input_sync(ts_data->input_dev);
 }
 
+static void surface3_spi_report_pen(struct surface3_ts_data *ts_data,
+				    struct surface3_ts_data_pen *pen)
+{
+	int st = pen->status;
+	int prox = st & 0x01;
+	int rubber = st & 0x18;
+
+	input_report_key(ts_data->pen_input_dev,
+			 BTN_TOUCH,
+			 (st & 0x12));
+
+	input_report_key(ts_data->pen_input_dev,
+			 BTN_TOOL_PEN,
+			 prox && !rubber);
+
+	input_report_key(ts_data->pen_input_dev,
+			 BTN_TOOL_RUBBER,
+			 prox && rubber);
+
+	if (st) {
+		input_report_key(ts_data->pen_input_dev,
+				 BTN_STYLUS,
+				 st & 0x04);
+
+		input_report_abs(ts_data->pen_input_dev,
+				 ABS_X,
+				 get_unaligned_le16(&pen->x));
+		input_report_abs(ts_data->pen_input_dev,
+				 ABS_Y,
+				 get_unaligned_le16(&pen->y));
+		input_report_abs(ts_data->pen_input_dev,
+				 ABS_PRESSURE,
+				 get_unaligned_le16(&pen->pressure));
+	}
+}
+
+static void surface3_spi_process_pen(struct surface3_ts_data *ts_data, u8 *data)
+{
+	struct surface3_ts_data_pen *pen;
+
+	pen = (struct surface3_ts_data_pen *)&data[15];
+
+	surface3_spi_report_pen(ts_data, pen);
+	input_sync(ts_data->pen_input_dev);
+}
+
 static void surface3_spi_process(struct surface3_ts_data *ts_data)
 {
 	const char header[] = {0xff, 0xff, 0xff, 0xff, 0xa5, 0x5a, 0xe7, 0x7e, 0x01};
@@ -125,12 +181,19 @@ static void surface3_spi_process(struct surface3_ts_data *ts_data)
 			"%s header error: %*ph, ignoring...\n",
 			__func__, (int)sizeof(header), data);
 
-	if (data[9] == SURFACE3_REPORT_TOUCH)
+	switch (data[9]) {
+	case SURFACE3_REPORT_TOUCH:
 		surface3_spi_process_touch(ts_data, data);
-	else
+		break;
+	case SURFACE3_REPORT_PEN:
+		surface3_spi_process_pen(ts_data, data);
+		break;
+	default:
 		dev_err(&ts_data->spi->dev,
 			"%s unknown packet type: %x, ignoring...\n",
 			__func__, data[9]);
+		break;
+	}
 }
 
 static irqreturn_t surface3_spi_irq_handler(int irq, void *dev_id)
@@ -224,6 +287,46 @@ static int surface3_spi_create_touch_input(struct surface3_ts_data *data)
 	return 0;
 }
 
+static int surface3_spi_create_pen_input(struct surface3_ts_data *data)
+{
+	struct input_dev *input;
+	int error;
+
+	input = devm_input_allocate_device(&data->spi->dev);
+	if (!input)
+		return -ENOMEM;
+
+	data->pen_input_dev = input;
+
+	__set_bit(INPUT_PROP_DIRECT, input->propbit);
+	__set_bit(INPUT_PROP_POINTER, input->propbit);
+	input_set_abs_params(input, ABS_X, 0, 9600, 0, 0);
+	input_abs_set_res(input, ABS_X, 40);
+	input_set_abs_params(input, ABS_Y, 0, 7200, 0, 0);
+	input_abs_set_res(input, ABS_Y, 48);
+	input_set_abs_params(input, ABS_PRESSURE, 0, 1024, 0, 0);
+	input_set_capability(input, EV_KEY, BTN_TOUCH);
+	input_set_capability(input, EV_KEY, BTN_STYLUS);
+	input_set_capability(input, EV_KEY, BTN_TOOL_PEN);
+	input_set_capability(input, EV_KEY, BTN_TOOL_RUBBER);
+
+	input->name = "Surface3 SPI Pen Input";
+	input->phys = "input/ts";
+	input->id.bustype = BUS_SPI;
+	input->id.vendor = 0x045e;     /* Microsoft */
+	input->id.product = 0x0002;
+	input->id.version = 0x0000;
+
+	error = input_register_device(input);
+	if (error) {
+		dev_err(&data->spi->dev,
+			"Failed to register input device: %d", error);
+		return error;
+	}
+
+	return 0;
+}
+
 static int surface3_spi_probe(struct spi_device *spi)
 {
 	struct surface3_ts_data *data;
@@ -255,6 +358,10 @@ static int surface3_spi_probe(struct spi_device *spi)
 	if (error)
 		return error;
 
+	error = surface3_spi_create_pen_input(data);
+	if (error)
+		return error;
+
 	error = devm_request_threaded_irq(&spi->dev, spi->irq,
 					  NULL, surface3_spi_irq_handler,
 					  IRQF_ONESHOT,
-- 
2.8.2

