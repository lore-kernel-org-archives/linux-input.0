From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2 1/2] Input: touchscreen: ads7846: keep copy of pdata in private struct
Date: Sun, 12 May 2013 18:50:06 +0200
Message-ID: <1368377407-7133-1-git-send-email-zonque@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:54835 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754293Ab3ELQuL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 12 May 2013 12:50:11 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: broonie@kernel.org, grant.likely@linaro.org, dmitry.torokhov@gmail.com, agust@denx.de, chf@fritzc.com, Daniel Mack <zonque@gmail.com>

Allocate a copy of the pdata, and keep a pointer to it in the private
struct ads7846. Also, kill some members that used to be in both structs.

This is needed for the upcoming DT support.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---

Hi Dmitry,

this is the alternative approach, as described eariler in our email
thread. It works equally well.

Thanks for having another look.


Daniel


 drivers/input/touchscreen/ads7846.c | 78 ++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 35 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 84ccf14..198677d 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -104,12 +104,8 @@ struct ads7846 {
 #endif
 
 	u16			model;
-	u16			vref_mv;
 	u16			vref_delay_usecs;
-	u16			x_plate_ohms;
-	u16			pressure_max;
 
-	bool			swap_xy;
 	bool			use_internal;
 
 	struct ads7846_packet	*packet;
@@ -143,6 +139,9 @@ struct ads7846 {
 	int			gpio_pendown;
 
 	void			(*wait_for_sync)(void);
+
+	/* platform data from board file or DT */
+	struct ads7846_platform_data *pdata;
 };
 
 /* leave chip selected when we're done, for quicker re-select? */
@@ -456,7 +455,7 @@ static inline unsigned vaux_adjust(struct ads7846 *ts, ssize_t v)
 	unsigned retval = v;
 
 	/* external resistors may scale vAUX into 0..vREF */
-	retval *= ts->vref_mv;
+	retval *= ts->pdata->vref_mv;
 	retval = retval >> 12;
 
 	return retval;
@@ -515,25 +514,25 @@ static int ads784x_hwmon_register(struct spi_device *spi, struct ads7846 *ts)
 	/* hwmon sensors need a reference voltage */
 	switch (ts->model) {
 	case 7846:
-		if (!ts->vref_mv) {
+		if (!ts->pdata->vref_mv) {
 			dev_dbg(&spi->dev, "assuming 2.5V internal vREF\n");
-			ts->vref_mv = 2500;
+			ts->pdata->vref_mv = 2500;
 			ts->use_internal = true;
 		}
 		break;
 	case 7845:
 	case 7843:
-		if (!ts->vref_mv) {
+		if (!ts->pdata->vref_mv) {
 			dev_warn(&spi->dev,
 				"external vREF for ADS%d not specified\n",
-				ts->model);
+				ts->pdata->model);
 			return 0;
 		}
 		break;
 	}
 
 	/* different chips have different sensor groups */
-	switch (ts->model) {
+	switch (ts->pdata->model) {
 	case 7846:
 		ts->attr_group = &ads7846_attr_group;
 		break;
@@ -544,7 +543,7 @@ static int ads784x_hwmon_register(struct spi_device *spi, struct ads7846 *ts)
 		ts->attr_group = &ads7843_attr_group;
 		break;
 	default:
-		dev_dbg(&spi->dev, "ADS%d not recognized\n", ts->model);
+		dev_dbg(&spi->dev, "ADS%d not recognized\n", ts->pdata->model);
 		return 0;
 	}
 
@@ -700,7 +699,7 @@ static int ads7846_get_value(struct ads7846 *ts, struct spi_message *m)
 	struct spi_transfer *t =
 		list_entry(m->transfers.prev, struct spi_transfer, transfer_list);
 
-	if (ts->model == 7845) {
+	if (ts->pdata->model == 7845) {
 		return be16_to_cpup((__be16 *)&(((char*)t->rx_buf)[1])) >> 3;
 	} else {
 		/*
@@ -776,6 +775,7 @@ static void ads7846_read_state(struct ads7846 *ts)
 static void ads7846_report_state(struct ads7846 *ts)
 {
 	struct ads7846_packet *packet = ts->packet;
+	struct ads7846_platform_data *pdata = ts->pdata;
 	unsigned int Rt;
 	u16 x, y, z1, z2;
 
@@ -784,7 +784,7 @@ static void ads7846_report_state(struct ads7846 *ts)
 	 * from on-the-wire format as part of debouncing to get stable
 	 * readings.
 	 */
-	if (ts->model == 7845) {
+	if (pdata->model == 7845) {
 		x = *(u16 *)packet->tc.x_buf;
 		y = *(u16 *)packet->tc.y_buf;
 		z1 = 0;
@@ -800,11 +800,11 @@ static void ads7846_report_state(struct ads7846 *ts)
 	if (x == MAX_12BIT)
 		x = 0;
 
-	if (ts->model == 7843) {
-		Rt = ts->pressure_max / 2;
-	} else if (ts->model == 7845) {
+	if (pdata->model == 7843) {
+		Rt = pdata->pressure_max / 2;
+	} else if (pdata->model == 7845) {
 		if (get_pendown_state(ts))
-			Rt = ts->pressure_max / 2;
+			Rt = pdata->pressure_max / 2;
 		else
 			Rt = 0;
 		dev_vdbg(&ts->spi->dev, "x/y: %d/%d, PD %d\n", x, y, Rt);
@@ -813,7 +813,7 @@ static void ads7846_report_state(struct ads7846 *ts)
 		Rt = z2;
 		Rt -= z1;
 		Rt *= x;
-		Rt *= ts->x_plate_ohms;
+		Rt *= pdata->x_plate_ohms;
 		Rt /= z1;
 		Rt = (Rt + 2047) >> 12;
 	} else {
@@ -825,7 +825,7 @@ static void ads7846_report_state(struct ads7846 *ts)
 	 * the maximum. Don't report it to user space, repeat at least
 	 * once more the measurement
 	 */
-	if (packet->tc.ignore || Rt > ts->pressure_max) {
+	if (packet->tc.ignore || Rt > pdata->pressure_max) {
 		dev_vdbg(&ts->spi->dev, "ignored %d pressure %d\n",
 			 packet->tc.ignore, Rt);
 		return;
@@ -853,7 +853,7 @@ static void ads7846_report_state(struct ads7846 *ts)
 	if (Rt) {
 		struct input_dev *input = ts->input;
 
-		if (ts->swap_xy)
+		if (pdata->swap_xy)
 			swap(x, y);
 
 		if (!ts->pendown) {
@@ -864,7 +864,7 @@ static void ads7846_report_state(struct ads7846 *ts)
 
 		input_report_abs(input, ABS_X, x);
 		input_report_abs(input, ABS_Y, y);
-		input_report_abs(input, ABS_PRESSURE, ts->pressure_max - Rt);
+		input_report_abs(input, ABS_PRESSURE, pdata->pressure_max - Rt);
 
 		input_sync(input);
 		dev_vdbg(&ts->spi->dev, "%4d/%4d/%4d\n", x, y, Rt);
@@ -963,7 +963,7 @@ static SIMPLE_DEV_PM_OPS(ads7846_pm, ads7846_suspend, ads7846_resume);
 static int ads7846_setup_pendown(struct spi_device *spi,
 					   struct ads7846 *ts)
 {
-	struct ads7846_platform_data *pdata = spi->dev.platform_data;
+	struct ads7846_platform_data *pdata = ts->pdata;
 	int err;
 
 	/*
@@ -1003,20 +1003,20 @@ static int ads7846_setup_pendown(struct spi_device *spi,
  * use formula #2 for pressure, not #3.
  */
 static void ads7846_setup_spi_msg(struct ads7846 *ts,
-				const struct ads7846_platform_data *pdata)
+				  struct ads7846_platform_data *pdata)
 {
 	struct spi_message *m = &ts->msg[0];
 	struct spi_transfer *x = ts->xfer;
 	struct ads7846_packet *packet = ts->packet;
 	int vref = pdata->keep_vref_on;
 
-	if (ts->model == 7873) {
+	if (pdata->model == 7873) {
 		/*
 		 * The AD7873 is almost identical to the ADS7846
 		 * keep VREF off during differential/ratiometric
 		 * conversion modes.
 		 */
-		ts->model = 7846;
+		pdata->model = 7846;
 		vref = 0;
 	}
 
@@ -1024,7 +1024,7 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
 	spi_message_init(m);
 	m->context = ts;
 
-	if (ts->model == 7845) {
+	if (pdata->model == 7845) {
 		packet->read_y_cmd[0] = READ_Y(vref);
 		packet->read_y_cmd[1] = 0;
 		packet->read_y_cmd[2] = 0;
@@ -1069,7 +1069,7 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
 	spi_message_init(m);
 	m->context = ts;
 
-	if (ts->model == 7845) {
+	if (pdata->model == 7845) {
 		x++;
 		packet->read_x_cmd[0] = READ_X(vref);
 		packet->read_x_cmd[1] = 0;
@@ -1108,7 +1108,7 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
 	}
 
 	/* turn y+ off, x- on; we'll use formula #2 */
-	if (ts->model == 7846) {
+	if (pdata->model == 7846) {
 		ts->msg_count++;
 		m++;
 		spi_message_init(m);
@@ -1178,7 +1178,7 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
 	spi_message_init(m);
 	m->context = ts;
 
-	if (ts->model == 7845) {
+	if (pdata->model == 7845) {
 		x++;
 		packet->pwrdown_cmd[0] = PWRDOWN;
 		packet->pwrdown_cmd[1] = 0;
@@ -1247,19 +1247,27 @@ static int ads7846_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, ts);
 
+	ts->pdata = pdata;
 	ts->packet = packet;
 	ts->spi = spi;
 	ts->input = input_dev;
-	ts->vref_mv = pdata->vref_mv;
-	ts->swap_xy = pdata->swap_xy;
 
 	mutex_init(&ts->lock);
 	init_waitqueue_head(&ts->wait);
 
-	ts->model = pdata->model ? : 7846;
-	ts->vref_delay_usecs = pdata->vref_delay_usecs ? : 100;
-	ts->x_plate_ohms = pdata->x_plate_ohms ? : 400;
-	ts->pressure_max = pdata->pressure_max ? : ~0;
+	/* pdata fallback defaults */
+
+	if (!pdata->model)
+		pdata->model = 7846;
+
+	if (!pdata->vref_delay_usecs)
+		pdata->vref_delay_usecs = 100;
+
+	if (!pdata->x_plate_ohms)
+		pdata->x_plate_ohms = 400;
+
+	if (!pdata->pressure_max)
+		pdata->pressure_max = ~0;
 
 	if (pdata->filter != NULL) {
 		if (pdata->filter_init != NULL) {
-- 
1.8.1.4

