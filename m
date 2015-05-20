From: Evgeniy Dushistov <dushistov@mail.ru>
Subject: [PATCH][v2] ads7846: fix ads7846 driver for work with ads7845
Date: Wed, 20 May 2015 09:52:04 +0300
Message-ID: <20150520065204.GA8770@fifteen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp42.i.mail.ru ([94.100.177.102]:43464 "EHLO smtp42.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155AbbETGwL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 20 May 2015 02:52:11 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Anatolij Gustschin <agust@denx.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Current ads7846 driver do not work with ads7845 device,
it gives completly wrong coordinates. With this fix,
it works as expected. As explained by Anatolij Gustschin,
the main changes in ads7846 driver for support ads7845 device,
was introduced due:

>this was tested, but if I remember correctly, on some ppc board were
>multi-segment SPI transfers didn't work (SPI chip-select disabled by
>controller after first SPI command byte). I do not know any more if it
>was the only reason for this ads7845 specific handling in my commit
>and unfortunately I do not have this board to check it again.

This patch was tested on beagleboard-xm<-SPI->ads7845

Signed-off-by: Evgneiy A. Dushistov <dushistov@mail.ru>
---
 drivers/input/touchscreen/ads7846.c | 148 +++++++++---------------------------
 1 file changed, 36 insertions(+), 112 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index e4eb8a6..76728d4 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -88,8 +88,6 @@ struct ads7846_packet {
 	u8			read_x, read_y, read_z1, read_z2, pwrdown;
 	u16			dummy;		/* for the pwrdown read */
 	struct ts_event		tc;
-	/* for ads7845 with mpc5121 psc spi we use 3-byte buffers */
-	u8			read_x_cmd[3], read_y_cmd[3], pwrdown_cmd[3];
 };
 
 struct ads7846 {
@@ -383,42 +381,6 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
 	return status;
 }
 
-static int ads7845_read12_ser(struct device *dev, unsigned command)
-{
-	struct spi_device *spi = to_spi_device(dev);
-	struct ads7846 *ts = dev_get_drvdata(dev);
-	struct ads7845_ser_req *req;
-	int status;
-
-	req = kzalloc(sizeof *req, GFP_KERNEL);
-	if (!req)
-		return -ENOMEM;
-
-	spi_message_init(&req->msg);
-
-	req->command[0] = (u8) command;
-	req->xfer[0].tx_buf = req->command;
-	req->xfer[0].rx_buf = req->sample;
-	req->xfer[0].len = 3;
-	spi_message_add_tail(&req->xfer[0], &req->msg);
-
-	mutex_lock(&ts->lock);
-	ads7846_stop(ts);
-	status = spi_sync(spi, &req->msg);
-	ads7846_restart(ts);
-	mutex_unlock(&ts->lock);
-
-	if (status == 0) {
-		/* BE12 value, then padding */
-		status = be16_to_cpu(*((u16 *)&req->sample[1]));
-		status = status >> 3;
-		status &= 0x0fff;
-	}
-
-	kfree(req);
-	return status;
-}
-
 #if IS_ENABLED(CONFIG_HWMON)
 
 #define SHOW(name, var, adjust) static ssize_t \
@@ -671,15 +633,12 @@ static int ads7846_get_value(struct ads7846 *ts, struct spi_message *m)
 	struct spi_transfer *t =
 		list_entry(m->transfers.prev, struct spi_transfer, transfer_list);
 
-	if (ts->model == 7845) {
-		return be16_to_cpup((__be16 *)&(((char*)t->rx_buf)[1])) >> 3;
-	} else {
-		/*
-		 * adjust:  on-wire is a must-ignore bit, a BE12 value, then
-		 * padding; built from two 8 bit values written msb-first.
-		 */
-		return be16_to_cpup((__be16 *)t->rx_buf) >> 3;
-	}
+
+	/*
+	 * adjust:  on-wire is a must-ignore bit, a BE12 value, then
+	 * padding; built from two 8 bit values written msb-first.
+	 */
+	return (be16_to_cpup((__be16 *)t->rx_buf) >> 3) & 0xfff;
 }
 
 static void ads7846_update_value(struct spi_message *m, int val)
@@ -755,14 +714,12 @@ static void ads7846_report_state(struct ads7846 *ts)
 	 * from on-the-wire format as part of debouncing to get stable
 	 * readings.
 	 */
+	x = packet->tc.x;
+	y = packet->tc.y;
 	if (ts->model == 7845) {
-		x = *(u16 *)packet->tc.x_buf;
-		y = *(u16 *)packet->tc.y_buf;
 		z1 = 0;
 		z2 = 0;
 	} else {
-		x = packet->tc.x;
-		y = packet->tc.y;
 		z1 = packet->tc.z1;
 		z2 = packet->tc.z2;
 	}
@@ -993,26 +950,16 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
 	spi_message_init(m);
 	m->context = ts;
 
-	if (ts->model == 7845) {
-		packet->read_y_cmd[0] = READ_Y(vref);
-		packet->read_y_cmd[1] = 0;
-		packet->read_y_cmd[2] = 0;
-		x->tx_buf = &packet->read_y_cmd[0];
-		x->rx_buf = &packet->tc.y_buf[0];
-		x->len = 3;
-		spi_message_add_tail(x, m);
-	} else {
-		/* y- still on; turn on only y+ (and ADC) */
-		packet->read_y = READ_Y(vref);
-		x->tx_buf = &packet->read_y;
-		x->len = 1;
-		spi_message_add_tail(x, m);
+	/* y- still on; turn on only y+ (and ADC) */
+	packet->read_y = READ_Y(vref);
+	x->tx_buf = &packet->read_y;
+	x->len = 1;
+	spi_message_add_tail(x, m);
 
-		x++;
-		x->rx_buf = &packet->tc.y;
-		x->len = 2;
-		spi_message_add_tail(x, m);
-	}
+	x++;
+	x->rx_buf = &packet->tc.y;
+	x->len = 2;
+	spi_message_add_tail(x, m);
 
 	/*
 	 * The first sample after switching drivers can be low quality;
@@ -1038,28 +985,17 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
 	spi_message_init(m);
 	m->context = ts;
 
-	if (ts->model == 7845) {
-		x++;
-		packet->read_x_cmd[0] = READ_X(vref);
-		packet->read_x_cmd[1] = 0;
-		packet->read_x_cmd[2] = 0;
-		x->tx_buf = &packet->read_x_cmd[0];
-		x->rx_buf = &packet->tc.x_buf[0];
-		x->len = 3;
-		spi_message_add_tail(x, m);
-	} else {
-		/* turn y- off, x+ on, then leave in lowpower */
-		x++;
-		packet->read_x = READ_X(vref);
-		x->tx_buf = &packet->read_x;
-		x->len = 1;
-		spi_message_add_tail(x, m);
+	/* turn y- off, x+ on, then leave in lowpower */
+	x++;
+	packet->read_x = READ_X(vref);
+	x->tx_buf = &packet->read_x;
+	x->len = 1;
+	spi_message_add_tail(x, m);
 
-		x++;
-		x->rx_buf = &packet->tc.x;
-		x->len = 2;
-		spi_message_add_tail(x, m);
-	}
+	x++;
+	x->rx_buf = &packet->tc.x;
+	x->len = 2;
+	spi_message_add_tail(x, m);
 
 	/* ... maybe discard first sample ... */
 	if (pdata->settle_delay_usecs) {
@@ -1147,24 +1083,15 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
 	spi_message_init(m);
 	m->context = ts;
 
-	if (ts->model == 7845) {
-		x++;
-		packet->pwrdown_cmd[0] = PWRDOWN;
-		packet->pwrdown_cmd[1] = 0;
-		packet->pwrdown_cmd[2] = 0;
-		x->tx_buf = &packet->pwrdown_cmd[0];
-		x->len = 3;
-	} else {
-		x++;
-		packet->pwrdown = PWRDOWN;
-		x->tx_buf = &packet->pwrdown;
-		x->len = 1;
-		spi_message_add_tail(x, m);
+	x++;
+	packet->pwrdown = PWRDOWN;
+	x->tx_buf = &packet->pwrdown;
+	x->len = 1;
+	spi_message_add_tail(x, m);
 
-		x++;
-		x->rx_buf = &packet->dummy;
-		x->len = 2;
-	}
+	x++;
+	x->rx_buf = &packet->dummy;
+	x->len = 2;
 
 	CS_CHANGE(*x);
 	spi_message_add_tail(x, m);
@@ -1408,10 +1335,7 @@ static int ads7846_probe(struct spi_device *spi)
 	 * Take a first sample, leaving nPENIRQ active and vREF off; avoid
 	 * the touchscreen, in case it's not connected.
 	 */
-	if (ts->model == 7845)
-		ads7845_read12_ser(&spi->dev, PWRDOWN);
-	else
-		(void) ads7846_read12_ser(&spi->dev, READ_12BIT_SER(vaux));
+	(void) ads7846_read12_ser(&spi->dev, READ_12BIT_SER(vaux));
 
 	err = sysfs_create_group(&spi->dev.kobj, &ads784x_attr_group);
 	if (err)
-- 
2.3.6

-- 
/Evgeniy
