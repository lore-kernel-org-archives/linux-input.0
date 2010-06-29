From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 2/2] Input: ads7846 - extend the driver for ads7845 controller support
Date: Tue, 29 Jun 2010 11:29:53 +0200
Message-ID: <1277803793-15077-1-git-send-email-agust@denx.de>
References: <1272630181-5364-2-git-send-email-agust@denx.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:40279 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab0F2JaL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jun 2010 05:30:11 -0400
In-Reply-To: <1272630181-5364-2-git-send-email-agust@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Detlev Zundel <dzu@denx.de>, Anatolij Gustschin <agust@denx.de>

ADS7845 is a controller for 5-wire touch screens and
somewhat different from 7846. It requires three serial
communications to accomplish one complete conversion.
Unlike 7846 it doesn't allow Z1-/Z2- position measurement.

The patch extends the ads7846 driver to also support
ads7845. The packet struct is extended to contain
needed command and conversion buffers. ads7846_rx()
and ads7846_rx_val() now differentiate between 7845
and 7846 case. ads7846_probe() is modified to setup
ads7845 specific command and conversion messages and
to switch ads7845 into power-down mode, since this is
needed to be prepared to respond to pendown interrupts.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
Changes since first version:
 - provide better changelog as requested by Dmitry
 - fix to long comment line (it was over 80 characters)
 
 drivers/input/touchscreen/ads7846.c |  173 +++++++++++++++++++++++++++--------
 1 files changed, 136 insertions(+), 37 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 69210cb..8ab90dd 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -68,6 +68,8 @@ struct ts_event {
 	u16	y;
 	u16	z1, z2;
 	int	ignore;
+	u8	x_buf[3];
+	u8	y_buf[3];
 };
 
 /*
@@ -79,6 +81,8 @@ struct ads7846_packet {
 	u8			read_x, read_y, read_z1, read_z2, pwrdown;
 	u16			dummy;		/* for the pwrdown read */
 	struct ts_event		tc;
+	/* for ads7845 with mpc5121 psc spi we use 3-byte buffers */
+	u8			read_x_cmd[3], read_y_cmd[3], pwrdown_cmd[3];
 };
 
 struct ads7846 {
@@ -207,6 +211,14 @@ struct ser_req {
 	struct spi_transfer	xfer[6];
 };
 
+struct ads7845_ser_req {
+	u8			command[3];
+	u8			pwrdown[3];
+	u8			sample[3];
+	struct spi_message	msg;
+	struct spi_transfer	xfer[2];
+};
+
 static void ads7846_enable(struct ads7846 *ts);
 static void ads7846_disable(struct ads7846 *ts);
 
@@ -287,6 +299,41 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
 	return status;
 }
 
+static int ads7845_read12_ser(struct device *dev, unsigned command)
+{
+	struct spi_device	*spi = to_spi_device(dev);
+	struct ads7846		*ts = dev_get_drvdata(dev);
+	struct ads7845_ser_req	*req = kzalloc(sizeof *req, GFP_KERNEL);
+	int			status;
+
+	if (!req)
+		return -ENOMEM;
+
+	spi_message_init(&req->msg);
+
+	req->command[0] = (u8) command;
+	req->xfer[0].tx_buf = req->command;
+	req->xfer[0].rx_buf = req->sample;
+	req->xfer[0].len = 3;
+	spi_message_add_tail(&req->xfer[0], &req->msg);
+
+	ts->irq_disabled = 1;
+	disable_irq(spi->irq);
+	status = spi_sync(spi, &req->msg);
+	ts->irq_disabled = 0;
+	enable_irq(spi->irq);
+
+	if (status == 0) {
+		/* BE12 value, then padding */
+		status = be16_to_cpu(*((u16 *)&req->sample[1]));
+		status = status >> 3;
+		status &= 0x0fff;
+	}
+
+	kfree(req);
+	return status;
+}
+
 #if defined(CONFIG_HWMON) || defined(CONFIG_HWMON_MODULE)
 
 #define SHOW(name, var, adjust) static ssize_t \
@@ -540,10 +587,17 @@ static void ads7846_rx(void *ads)
 	/* ads7846_rx_val() did in-place conversion (including byteswap) from
 	 * on-the-wire format as part of debouncing to get stable readings.
 	 */
-	x = packet->tc.x;
-	y = packet->tc.y;
-	z1 = packet->tc.z1;
-	z2 = packet->tc.z2;
+	if (ts->model == 7845) {
+		x = *(u16 *)packet->tc.x_buf;
+		y = *(u16 *)packet->tc.y_buf;
+		z1 = 0;
+		z2 = 0;
+	} else {
+		x = packet->tc.x;
+		y = packet->tc.y;
+		z1 = packet->tc.z1;
+		z2 = packet->tc.z2;
+	}
 
 	/* range filtering */
 	if (x == MAX_12BIT)
@@ -551,6 +605,12 @@ static void ads7846_rx(void *ads)
 
 	if (ts->model == 7843) {
 		Rt = ts->pressure_max / 2;
+	} else if (ts->model == 7845) {
+		if (get_pendown_state(ts))
+			Rt = ts->pressure_max / 2;
+		else
+			Rt = 0;
+		dev_vdbg(&ts->spi->dev, "x/y: %d/%d, PD %d\n", x, y, Rt);
 	} else if (likely(x && z1)) {
 		/* compute touch pressure resistance using equation #2 */
 		Rt = z2;
@@ -671,10 +731,14 @@ static void ads7846_rx_val(void *ads)
 	m = &ts->msg[ts->msg_idx];
 	t = list_entry(m->transfers.prev, struct spi_transfer, transfer_list);
 
-	/* adjust:  on-wire is a must-ignore bit, a BE12 value, then padding;
-	 * built from two 8 bit values written msb-first.
-	 */
-	val = be16_to_cpup((__be16 *)t->rx_buf) >> 3;
+	if (ts->model == 7845) {
+		val = be16_to_cpup((__be16 *)&(((char*)t->rx_buf)[1])) >> 3;
+	} else {
+		/* adjust:  on-wire is a must-ignore bit, a BE12 value, then
+		 * padding; built from two 8 bit values written msb-first.
+		 */
+		val = be16_to_cpup((__be16 *)t->rx_buf) >> 3;
+	}
 
 	action = ts->filter(ts->filter_data, ts->msg_idx, &val);
 	switch (action) {
@@ -1008,16 +1072,26 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 
 	spi_message_init(m);
 
-	/* y- still on; turn on only y+ (and ADC) */
-	packet->read_y = READ_Y(vref);
-	x->tx_buf = &packet->read_y;
-	x->len = 1;
-	spi_message_add_tail(x, m);
+	if (ts->model == 7845) {
+		packet->read_y_cmd[0] = READ_Y(vref);
+		packet->read_y_cmd[1] = 0;
+		packet->read_y_cmd[2] = 0;
+		x->tx_buf = &packet->read_y_cmd[0];
+		x->rx_buf = &packet->tc.y_buf[0];
+		x->len = 3;
+		spi_message_add_tail(x, m);
+	} else {
+		/* y- still on; turn on only y+ (and ADC) */
+		packet->read_y = READ_Y(vref);
+		x->tx_buf = &packet->read_y;
+		x->len = 1;
+		spi_message_add_tail(x, m);
 
-	x++;
-	x->rx_buf = &packet->tc.y;
-	x->len = 2;
-	spi_message_add_tail(x, m);
+		x++;
+		x->rx_buf = &packet->tc.y;
+		x->len = 2;
+		spi_message_add_tail(x, m);
+	}
 
 	/* the first sample after switching drivers can be low quality;
 	 * optionally discard it, using a second one after the signals
@@ -1043,17 +1117,28 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 	m++;
 	spi_message_init(m);
 
-	/* turn y- off, x+ on, then leave in lowpower */
-	x++;
-	packet->read_x = READ_X(vref);
-	x->tx_buf = &packet->read_x;
-	x->len = 1;
-	spi_message_add_tail(x, m);
+	if (ts->model == 7845) {
+		x++;
+		packet->read_x_cmd[0] = READ_X(vref);
+		packet->read_x_cmd[1] = 0;
+		packet->read_x_cmd[2] = 0;
+		x->tx_buf = &packet->read_x_cmd[0];
+		x->rx_buf = &packet->tc.x_buf[0];
+		x->len = 3;
+		spi_message_add_tail(x, m);
+	} else {
+		/* turn y- off, x+ on, then leave in lowpower */
+		x++;
+		packet->read_x = READ_X(vref);
+		x->tx_buf = &packet->read_x;
+		x->len = 1;
+		spi_message_add_tail(x, m);
 
-	x++;
-	x->rx_buf = &packet->tc.x;
-	x->len = 2;
-	spi_message_add_tail(x, m);
+		x++;
+		x->rx_buf = &packet->tc.x;
+		x->len = 2;
+		spi_message_add_tail(x, m);
+	}
 
 	/* ... maybe discard first sample ... */
 	if (pdata->settle_delay_usecs) {
@@ -1144,15 +1229,25 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 	m++;
 	spi_message_init(m);
 
-	x++;
-	packet->pwrdown = PWRDOWN;
-	x->tx_buf = &packet->pwrdown;
-	x->len = 1;
-	spi_message_add_tail(x, m);
+	if (ts->model == 7845) {
+		x++;
+		packet->pwrdown_cmd[0] = PWRDOWN;
+		packet->pwrdown_cmd[1] = 0;
+		packet->pwrdown_cmd[2] = 0;
+		x->tx_buf = &packet->pwrdown_cmd[0];
+		x->len = 3;
+	} else {
+		x++;
+		packet->pwrdown = PWRDOWN;
+		x->tx_buf = &packet->pwrdown;
+		x->len = 1;
+		spi_message_add_tail(x, m);
+
+		x++;
+		x->rx_buf = &packet->dummy;
+		x->len = 2;
+	}
 
-	x++;
-	x->rx_buf = &packet->dummy;
-	x->len = 2;
 	CS_CHANGE(*x);
 	spi_message_add_tail(x, m);
 
@@ -1199,8 +1294,12 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 	/* take a first sample, leaving nPENIRQ active and vREF off; avoid
 	 * the touchscreen, in case it's not connected.
 	 */
-	(void) ads7846_read12_ser(&spi->dev,
-			  READ_12BIT_SER(vaux) | ADS_PD10_ALL_ON);
+	if (ts->model == 7845) {
+		ads7845_read12_ser(&spi->dev, PWRDOWN);
+	} else {
+		(void) ads7846_read12_ser(&spi->dev,
+				READ_12BIT_SER(vaux) | ADS_PD10_ALL_ON);
+	}
 
 	err = sysfs_create_group(&spi->dev.kobj, &ads784x_attr_group);
 	if (err)
-- 
1.7.0.4

