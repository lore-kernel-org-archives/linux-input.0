From: Stephen Just <stephenjust@gmail.com>
Subject: [PATCH 1/2] Input - surface3_spi: Prepare to add support for Surface Pen
Date: Mon, 23 May 2016 07:55:33 -0600
Message-ID: <1464011734-18657-2-git-send-email-stephenjust@gmail.com>
References: <1464011734-18657-1-git-send-email-stephenjust@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:34664 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428AbcEWUNU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 May 2016 16:13:20 -0400
Received: by mail-it0-f67.google.com with SMTP id k76so6212944ita.1
        for <linux-input@vger.kernel.org>; Mon, 23 May 2016 13:13:20 -0700 (PDT)
In-Reply-To: <1464011734-18657-1-git-send-email-stephenjust@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Stephen Just <stephenjust@gmail.com>, Bastien Nocera <hadesss@hadess.net>

Surface Pens can be supported by handling a second report type. Prepare
for this change.

Signed-off-by: Stephen Just <stephenjust@gmail.com>
---
 drivers/input/touchscreen/surface3_spi.c | 38 +++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/input/touchscreen/surface3_spi.c b/drivers/input/touchscreen/surface3_spi.c
index 58631d1..204a162 100644
--- a/drivers/input/touchscreen/surface3_spi.c
+++ b/drivers/input/touchscreen/surface3_spi.c
@@ -27,6 +27,8 @@
 
 #define SURFACE3_PACKET_SIZE	264
 
+#define SURFACE3_REPORT_TOUCH	0xd2
+
 struct surface3_ts_data {
 	struct spi_device *spi;
 	struct gpio_desc *gpiod_rst[2];
@@ -84,19 +86,10 @@ static void surface3_spi_report_touch(struct surface3_ts_data *ts_data,
 	}
 }
 
-static void surface3_spi_process(struct surface3_ts_data *ts_data)
+static void surface3_spi_process_touch(struct surface3_ts_data *ts_data, u8 *data)
 {
-	const char header[] = {0xff, 0xff, 0xff, 0xff, 0xa5, 0x5a, 0xe7, 0x7e,
-			       0x01, 0xd2, 0x00, 0x80, 0x01, 0x03, 0x03};
-	u8 *data = ts_data->rd_buf;
 	u16 timestamp;
 	unsigned int i;
-
-	if (memcmp(header, data, sizeof(header)))
-		dev_err(&ts_data->spi->dev,
-			"%s header error: %*ph, ignoring...\n",
-			__func__, (int)sizeof(header), data);
-
 	timestamp = get_unaligned_le16(&data[15]);
 
 	for (i = 0; i < 13; i++) {
@@ -121,6 +114,25 @@ static void surface3_spi_process(struct surface3_ts_data *ts_data)
 	input_sync(ts_data->input_dev);
 }
 
+static void surface3_spi_process(struct surface3_ts_data *ts_data)
+{
+	const char header[] = {0xff, 0xff, 0xff, 0xff, 0xa5, 0x5a, 0xe7, 0x7e, 0x01};
+
+	u8 *data = ts_data->rd_buf;
+
+	if (memcmp(header, data, sizeof(header)))
+		dev_err(&ts_data->spi->dev,
+			"%s header error: %*ph, ignoring...\n",
+			__func__, (int)sizeof(header), data);
+
+	if (data[9] == SURFACE3_REPORT_TOUCH)
+		surface3_spi_process_touch(ts_data, data);
+	else
+		dev_err(&ts_data->spi->dev,
+			"%s unknown packet type: %x, ignoring...\n",
+			__func__, data[9]);
+}
+
 static irqreturn_t surface3_spi_irq_handler(int irq, void *dev_id)
 {
 	struct surface3_ts_data *data = dev_id;
@@ -176,7 +188,7 @@ static int surface3_spi_get_gpio_config(struct surface3_ts_data *data)
 	return 0;
 }
 
-static int surface3_spi_create_input(struct surface3_ts_data *data)
+static int surface3_spi_create_touch_input(struct surface3_ts_data *data)
 {
 	struct input_dev *input;
 	int error;
@@ -199,7 +211,7 @@ static int surface3_spi_create_input(struct surface3_ts_data *data)
 	input->phys = "input/ts";
 	input->id.bustype = BUS_SPI;
 	input->id.vendor = 0x045e;	/* Microsoft */
-	input->id.product = 0x0000;
+	input->id.product = 0x0001;
 	input->id.version = 0x0000;
 
 	error = input_register_device(input);
@@ -239,7 +251,7 @@ static int surface3_spi_probe(struct spi_device *spi)
 	surface3_spi_power(data, false);
 	surface3_spi_power(data, true);
 
-	error = surface3_spi_create_input(data);
+	error = surface3_spi_create_touch_input(data);
 	if (error)
 		return error;
 
-- 
2.8.2

