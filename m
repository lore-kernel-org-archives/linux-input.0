From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] Input: ads7846 - modificatons of _stop()/_disable()
 conditions
Date: Tue, 12 Oct 2010 09:00:55 -0700
Message-ID: <20101012160055.GA6355@core.coreip.homeip.net>
References: <1284634286-8871-1-git-send-email-jason77.wang@gmail.com>
 <1284634286-8871-4-git-send-email-jason77.wang@gmail.com>
 <1284634286-8871-5-git-send-email-jason77.wang@gmail.com>
 <201009162339.06395.dmitry.torokhov@gmail.com>
 <4C9332CE.6040905@gmail.com>
 <20100917160709.GC14186@core.coreip.homeip.net>
 <4C9718E9.5040104@gmail.com>
 <4CB4314C.7050308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:57244 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757625Ab0JLQBE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Oct 2010 12:01:04 -0400
Received: by pxi16 with SMTP id 16so567227pxi.19
        for <linux-input@vger.kernel.org>; Tue, 12 Oct 2010 09:01:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CB4314C.7050308@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Wang <jason77.wang@gmail.com>
Cc: notasas@gmail.com, vapier@gentoo.org, linux-input@vger.kernel.org

Hi Jason.

On Tue, Oct 12, 2010 at 05:58:36PM +0800, Jason Wang wrote:
> Hi Dmitry,
> 
> Still remember the thread irq modificition for the ads7846.c? I sent
> 4 patches,
> you pointed out that the last patch(the 4th one) seems not right, i think it
> over and find i was wrong because i mingled two independent flags(
> disabled/suspended). Then i gave my understanding and two plans to
> be chosen 3 weeks ago, but by now don't get feedback.

Sorry about that.

> @@ -253,9 +253,10 @@ static void ads7846_enable(struct ads7846 *ts)
> {
> mutex_lock(&ts->lock);
> 
> - if (ts->disabled && !ts->suspended)
> + if (ts->disabled && !ts->suspended) {
> + ts->disabled = false;
> __ads7846_enable(ts);

If the device was both disabled and suspended then enable will never
succeed.

I actually was looking over the patches yesterday and I believe I
corrected the problem you mentioned. I rolled all patches together (no
reason to keep them separate - they have not been yet applied to
non-rebasing branch and they are simple fix-ups to the issues introduced
by the fisrt patch). Could you please try the patch below and if it
still works I'll queue for .37.

Thanks!

-- 
Dmitry

Input: ads7846 - switch to using threaded IRQ

From: Jason Wang <jason77.wang@gmail.com>

Commit 9114337 introduces regulator operations in ads7846 touchscreen
driver. Among these operations, some are called while holding a
spinlock. On many platforms regulators reside on slow buses, such as
I2C/SPI and require sleep while accessing them.

The touchscreen itself is also a SPI device and currently relies on
asynchronous SPI access to avoid sleeping in interrupt context. Let's
switch to using threaded IRQ to be able to access SPI bus
synchronously (which simplifies driver a bit); it also allows safe
access to the regulators as well.

This has been tested on the ti_omap3530evm board:
 1) using ts_lib after normal boot
 2) using ts_lib after "#echo 1/0 > /sys/bus/spi/devices/spi0.1/disable"
 3) using ts_lib after "#echo mem > /sys/power/state" and "wake up"

Based on original patch by Dmitry Torokhov.

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/ads7846.c |  886 ++++++++++++++++++-----------------
 1 files changed, 456 insertions(+), 430 deletions(-)


diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 1603193..14ea54b 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -17,9 +17,11 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */
+#include <linux/types.h>
 #include <linux/hwmon.h>
 #include <linux/init.h>
 #include <linux/err.h>
+#include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
@@ -52,22 +54,23 @@
  * files.
  */
 
-#define TS_POLL_DELAY	(1 * 1000000)	/* ns delay before the first sample */
-#define TS_POLL_PERIOD	(5 * 1000000)	/* ns delay between samples */
+#define TS_POLL_DELAY	1	/* ms delay before the first sample */
+#define TS_POLL_PERIOD	5	/* ms delay between samples */
 
 /* this driver doesn't aim at the peak continuous sample rate */
 #define	SAMPLE_BITS	(8 /*cmd*/ + 16 /*sample*/ + 2 /* before, after */)
 
 struct ts_event {
-	/* For portability, we can't read 12 bit values using SPI (which
-	 * would make the controller deliver them as native byteorder u16
+	/*
+	 * For portability, we can't read 12 bit values using SPI (which
+	 * would make the controller deliver them as native byte order u16
 	 * with msbs zeroed).  Instead, we read them as two 8-bit values,
 	 * *** WHICH NEED BYTESWAPPING *** and range adjustment.
 	 */
 	u16	x;
 	u16	y;
 	u16	z1, z2;
-	int	ignore;
+	bool	ignore;
 	u8	x_buf[3];
 	u8	y_buf[3];
 };
@@ -110,8 +113,11 @@ struct ads7846 {
 
 	struct spi_transfer	xfer[18];
 	struct spi_message	msg[5];
-	struct spi_message	*last_msg;
-	int			msg_idx;
+	int			msg_count;
+	wait_queue_head_t	wait;
+
+	bool			pendown;
+
 	int			read_cnt;
 	int			read_rep;
 	int			last_read;
@@ -122,14 +128,10 @@ struct ads7846 {
 
 	u16			penirq_recheck_delay_usecs;
 
-	spinlock_t		lock;
-	struct hrtimer		timer;
-	unsigned		pendown:1;	/* P: lock */
-	unsigned		pending:1;	/* P: lock */
-// FIXME remove "irq_disabled"
-	unsigned		irq_disabled:1;	/* P: lock */
-	unsigned		disabled:1;
-	unsigned		is_suspended:1;
+	struct mutex		lock;
+	bool			stopped;	/* P: lock */
+	bool			disabled;	/* P: lock */
+	bool			suspended;	/* P: lock */
 
 	int			(*filter)(void *data, int data_idx, int *val);
 	void			*filter_data;
@@ -165,7 +167,7 @@ struct ads7846 {
 #define	ADS_12_BIT		(0 << 3)
 #define	ADS_SER			(1 << 2)	/* non-differential */
 #define	ADS_DFR			(0 << 2)	/* differential */
-#define	ADS_PD10_PDOWN		(0 << 0)	/* lowpower mode + penirq */
+#define	ADS_PD10_PDOWN		(0 << 0)	/* low power mode + penirq */
 #define	ADS_PD10_ADC_ON		(1 << 0)	/* ADC on */
 #define	ADS_PD10_REF_ON		(2 << 0)	/* vREF on + penirq */
 #define	ADS_PD10_ALL_ON		(3 << 0)	/* ADC + vREF on */
@@ -193,6 +195,78 @@ struct ads7846 {
 #define	REF_ON	(READ_12BIT_DFR(x, 1, 1))
 #define	REF_OFF	(READ_12BIT_DFR(y, 0, 0))
 
+/* Must be called with ts->lock held */
+static void ads7846_stop(struct ads7846 *ts)
+{
+	if (!ts->disabled && !ts->suspended) {
+		/* Signal IRQ thread to stop polling and disable the handler. */
+		ts->stopped = true;
+		mb();
+		wake_up(&ts->wait);
+		disable_irq(ts->spi->irq);
+	}
+}
+
+/* Must be called with ts->lock held */
+static void ads7846_restart(struct ads7846 *ts)
+{
+	if (!ts->disabled && !ts->suspended) {
+		/* Tell IRQ thread that it may poll the device. */
+		ts->stopped = false;
+		mb();
+		enable_irq(ts->spi->irq);
+	}
+}
+
+/* Must be called with ts->lock held */
+static void __ads7846_disable(struct ads7846 *ts)
+{
+	ads7846_stop(ts);
+	regulator_disable(ts->reg);
+
+	/*
+	 * We know the chip's in low power mode since we always
+	 * leave it that way after every request
+	 */
+}
+
+/* Must be called with ts->lock held */
+static void __ads7846_enable(struct ads7846 *ts)
+{
+	regulator_enable(ts->reg);
+	ads7846_restart(ts);
+}
+
+static void ads7846_disable(struct ads7846 *ts)
+{
+	mutex_lock(&ts->lock);
+
+	if (!ts->disabled) {
+
+		if  (!ts->suspended)
+			__ads7846_disable(ts);
+
+		ts->disabled = true;
+	}
+
+	mutex_unlock(&ts->lock);
+}
+
+static void ads7846_enable(struct ads7846 *ts)
+{
+	mutex_lock(&ts->lock);
+
+	if (ts->disabled) {
+
+		ts->disabled = false;
+
+		if (!ts->suspended)
+			__ads7846_enable(ts);
+	}
+
+	mutex_unlock(&ts->lock);
+}
+
 /*--------------------------------------------------------------------------*/
 
 /*
@@ -219,23 +293,15 @@ struct ads7845_ser_req {
 	struct spi_transfer	xfer[2];
 };
 
-static void ads7846_enable(struct ads7846 *ts);
-static void ads7846_disable(struct ads7846 *ts);
-
-static int device_suspended(struct device *dev)
-{
-	struct ads7846 *ts = dev_get_drvdata(dev);
-	return ts->is_suspended || ts->disabled;
-}
-
 static int ads7846_read12_ser(struct device *dev, unsigned command)
 {
-	struct spi_device	*spi = to_spi_device(dev);
-	struct ads7846		*ts = dev_get_drvdata(dev);
-	struct ser_req		*req = kzalloc(sizeof *req, GFP_KERNEL);
-	int			status;
-	int			use_internal;
+	struct spi_device *spi = to_spi_device(dev);
+	struct ads7846 *ts = dev_get_drvdata(dev);
+	struct ser_req *req;
+	int status;
+	int use_internal;
 
+	req = kzalloc(sizeof *req, GFP_KERNEL);
 	if (!req)
 		return -ENOMEM;
 
@@ -282,11 +348,11 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
 	CS_CHANGE(req->xfer[5]);
 	spi_message_add_tail(&req->xfer[5], &req->msg);
 
-	ts->irq_disabled = 1;
-	disable_irq(spi->irq);
+	mutex_lock(&ts->lock);
+	ads7846_stop(ts);
 	status = spi_sync(spi, &req->msg);
-	ts->irq_disabled = 0;
-	enable_irq(spi->irq);
+	ads7846_restart(ts);
+	mutex_unlock(&ts->lock);
 
 	if (status == 0) {
 		/* on-wire is a must-ignore bit, a BE12 value, then padding */
@@ -301,11 +367,12 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
 
 static int ads7845_read12_ser(struct device *dev, unsigned command)
 {
-	struct spi_device	*spi = to_spi_device(dev);
-	struct ads7846		*ts = dev_get_drvdata(dev);
-	struct ads7845_ser_req	*req = kzalloc(sizeof *req, GFP_KERNEL);
-	int			status;
+	struct spi_device *spi = to_spi_device(dev);
+	struct ads7846 *ts = dev_get_drvdata(dev);
+	struct ads7845_ser_req *req;
+	int status;
 
+	req = kzalloc(sizeof *req, GFP_KERNEL);
 	if (!req)
 		return -ENOMEM;
 
@@ -317,11 +384,11 @@ static int ads7845_read12_ser(struct device *dev, unsigned command)
 	req->xfer[0].len = 3;
 	spi_message_add_tail(&req->xfer[0], &req->msg);
 
-	ts->irq_disabled = 1;
-	disable_irq(spi->irq);
+	mutex_lock(&ts->lock);
+	ads7846_stop(ts);
 	status = spi_sync(spi, &req->msg);
-	ts->irq_disabled = 0;
-	enable_irq(spi->irq);
+	ads7846_restart(ts);
+	mutex_unlock(&ts->lock);
 
 	if (status == 0) {
 		/* BE12 value, then padding */
@@ -374,6 +441,7 @@ static inline unsigned vaux_adjust(struct ads7846 *ts, ssize_t v)
 	/* external resistors may scale vAUX into 0..vREF */
 	retval *= ts->vref_mv;
 	retval = retval >> 12;
+
 	return retval;
 }
 
@@ -384,13 +452,13 @@ static inline unsigned vbatt_adjust(struct ads7846 *ts, ssize_t v)
 	/* ads7846 has a resistor ladder to scale this signal down */
 	if (ts->model == 7846)
 		retval *= 4;
+
 	return retval;
 }
 
 SHOW(in0_input, vaux, vaux_adjust)
 SHOW(in1_input, vbatt, vbatt_adjust)
 
-
 static struct attribute *ads7846_attributes[] = {
 	&dev_attr_temp0.attr,
 	&dev_attr_temp1.attr,
@@ -498,17 +566,12 @@ static inline void ads784x_hwmon_unregister(struct spi_device *spi,
 }
 #endif
 
-static int is_pen_down(struct device *dev)
-{
-	struct ads7846	*ts = dev_get_drvdata(dev);
-
-	return ts->pendown;
-}
-
 static ssize_t ads7846_pen_down_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%u\n", is_pen_down(dev));
+	struct ads7846 *ts = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", ts->pendown);
 }
 
 static DEVICE_ATTR(pen_down, S_IRUGO, ads7846_pen_down_show, NULL);
@@ -516,7 +579,7 @@ static DEVICE_ATTR(pen_down, S_IRUGO, ads7846_pen_down_show, NULL);
 static ssize_t ads7846_disable_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	struct ads7846	*ts = dev_get_drvdata(dev);
+	struct ads7846 *ts = dev_get_drvdata(dev);
 
 	return sprintf(buf, "%u\n", ts->disabled);
 }
@@ -531,15 +594,11 @@ static ssize_t ads7846_disable_store(struct device *dev,
 	if (strict_strtoul(buf, 10, &i))
 		return -EINVAL;
 
-	spin_lock_irq(&ts->lock);
-
 	if (i)
 		ads7846_disable(ts);
 	else
 		ads7846_enable(ts);
 
-	spin_unlock_irq(&ts->lock);
-
 	return count;
 }
 
@@ -569,23 +628,141 @@ static void null_wait_for_sync(void)
 {
 }
 
-/*
- * PENIRQ only kicks the timer.  The timer only reissues the SPI transfer,
- * to retrieve touchscreen status.
- *
- * The SPI transfer completion callback does the real work.  It reports
- * touchscreen events and reactivates the timer (or IRQ) as appropriate.
- */
+static int ads7846_debounce_filter(void *ads, int data_idx, int *val)
+{
+	struct ads7846 *ts = ads;
+
+	if (!ts->read_cnt || (abs(ts->last_read - *val) > ts->debounce_tol)) {
+		/* Start over collecting consistent readings. */
+		ts->read_rep = 0;
+		/*
+		 * Repeat it, if this was the first read or the read
+		 * wasn't consistent enough.
+		 */
+		if (ts->read_cnt < ts->debounce_max) {
+			ts->last_read = *val;
+			ts->read_cnt++;
+			return ADS7846_FILTER_REPEAT;
+		} else {
+			/*
+			 * Maximum number of debouncing reached and still
+			 * not enough number of consistent readings. Abort
+			 * the whole sample, repeat it in the next sampling
+			 * period.
+			 */
+			ts->read_cnt = 0;
+			return ADS7846_FILTER_IGNORE;
+		}
+	} else {
+		if (++ts->read_rep > ts->debounce_rep) {
+			/*
+			 * Got a good reading for this coordinate,
+			 * go for the next one.
+			 */
+			ts->read_cnt = 0;
+			ts->read_rep = 0;
+			return ADS7846_FILTER_OK;
+		} else {
+			/* Read more values that are consistent. */
+			ts->read_cnt++;
+			return ADS7846_FILTER_REPEAT;
+		}
+	}
+}
+
+static int ads7846_no_filter(void *ads, int data_idx, int *val)
+{
+	return ADS7846_FILTER_OK;
+}
+
+static int ads7846_get_value(struct ads7846 *ts, struct spi_message *m)
+{
+	struct spi_transfer *t =
+		list_entry(m->transfers.prev, struct spi_transfer, transfer_list);
+
+	if (ts->model == 7845) {
+		return be16_to_cpup((__be16 *)&(((char*)t->rx_buf)[1])) >> 3;
+	} else {
+		/*
+		 * adjust:  on-wire is a must-ignore bit, a BE12 value, then
+		 * padding; built from two 8 bit values written msb-first.
+		 */
+		return be16_to_cpup((__be16 *)t->rx_buf) >> 3;
+	}
+}
+
+static void ads7846_update_value(struct spi_message *m, int val)
+{
+	struct spi_transfer *t =
+		list_entry(m->transfers.prev, struct spi_transfer, transfer_list);
+
+	*(u16 *)t->rx_buf = val;
+}
+
+static void ads7846_read_state(struct ads7846 *ts)
+{
+	struct ads7846_packet *packet = ts->packet;
+	struct spi_message *m;
+	int msg_idx = 0;
+	int val;
+	int action;
+	int error;
+
+	while (msg_idx < ts->msg_count) {
+
+		ts->wait_for_sync();
+
+		m = &ts->msg[msg_idx];
+		error = spi_sync(ts->spi, m);
+		if (error) {
+			dev_err(&ts->spi->dev, "spi_async --> %d\n", error);
+			packet->tc.ignore = true;
+			return;
+		}
+
+		/*
+		 * Last message is power down request, no need to convert
+		 * or filter the value.
+		 */
+		if (msg_idx < ts->msg_count - 1) {
 
-static void ads7846_rx(void *ads)
+			val = ads7846_get_value(ts, m);
+
+			action = ts->filter(ts->filter_data, msg_idx, &val);
+			switch (action) {
+			case ADS7846_FILTER_REPEAT:
+				continue;
+
+			case ADS7846_FILTER_IGNORE:
+				packet->tc.ignore = true;
+				msg_idx = ts->msg_count - 1;
+				continue;
+
+			case ADS7846_FILTER_OK:
+				ads7846_update_value(m, val);
+				packet->tc.ignore = false;
+				msg_idx++;
+				break;
+
+			default:
+				BUG();
+			}
+		} else {
+			msg_idx++;
+		}
+	}
+}
+
+static void ads7846_report_state(struct ads7846 *ts)
 {
-	struct ads7846		*ts = ads;
-	struct ads7846_packet	*packet = ts->packet;
-	unsigned		Rt;
-	u16			x, y, z1, z2;
+	struct ads7846_packet *packet = ts->packet;
+	unsigned int Rt;
+	u16 x, y, z1, z2;
 
-	/* ads7846_rx_val() did in-place conversion (including byteswap) from
-	 * on-the-wire format as part of debouncing to get stable readings.
+	/*
+	 * ads7846_get_value() does in-place conversion (including byte swap)
+	 * from on-the-wire format as part of debouncing to get stable
+	 * readings.
 	 */
 	if (ts->model == 7845) {
 		x = *(u16 *)packet->tc.x_buf;
@@ -623,19 +800,19 @@ static void ads7846_rx(void *ads)
 		Rt = 0;
 	}
 
-	/* Sample found inconsistent by debouncing or pressure is beyond
+	/*
+	 * Sample found inconsistent by debouncing or pressure is beyond
 	 * the maximum. Don't report it to user space, repeat at least
 	 * once more the measurement
 	 */
 	if (packet->tc.ignore || Rt > ts->pressure_max) {
 		dev_vdbg(&ts->spi->dev, "ignored %d pressure %d\n",
 			 packet->tc.ignore, Rt);
-		hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD),
-			      HRTIMER_MODE_REL);
 		return;
 	}
 
-	/* Maybe check the pendown state before reporting. This discards
+	/*
+	 * Maybe check the pendown state before reporting. This discards
 	 * false readings when the pen is lifted.
 	 */
 	if (ts->penirq_recheck_delay_usecs) {
@@ -644,8 +821,9 @@ static void ads7846_rx(void *ads)
 			Rt = 0;
 	}
 
-	/* NOTE: We can't rely on the pressure to determine the pen down
-	 * state, even this controller has a pressure sensor.  The pressure
+	/*
+	 * NOTE: We can't rely on the pressure to determine the pen down
+	 * state, even this controller has a pressure sensor. The pressure
 	 * value can fluctuate for quite a while after lifting the pen and
 	 * in some cases may not even settle at the expected value.
 	 *
@@ -655,15 +833,15 @@ static void ads7846_rx(void *ads)
 	if (Rt) {
 		struct input_dev *input = ts->input;
 
+		if (ts->swap_xy)
+			swap(x, y);
+
 		if (!ts->pendown) {
 			input_report_key(input, BTN_TOUCH, 1);
-			ts->pendown = 1;
+			ts->pendown = true;
 			dev_vdbg(&ts->spi->dev, "DOWN\n");
 		}
 
-		if (ts->swap_xy)
-			swap(x, y);
-
 		input_report_abs(input, ABS_X, x);
 		input_report_abs(input, ABS_Y, y);
 		input_report_abs(input, ABS_PRESSURE, ts->pressure_max - Rt);
@@ -671,246 +849,94 @@ static void ads7846_rx(void *ads)
 		input_sync(input);
 		dev_vdbg(&ts->spi->dev, "%4d/%4d/%4d\n", x, y, Rt);
 	}
-
-	hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD),
-			HRTIMER_MODE_REL);
-}
-
-static int ads7846_debounce(void *ads, int data_idx, int *val)
-{
-	struct ads7846		*ts = ads;
-
-	if (!ts->read_cnt || (abs(ts->last_read - *val) > ts->debounce_tol)) {
-		/* Start over collecting consistent readings. */
-		ts->read_rep = 0;
-		/* Repeat it, if this was the first read or the read
-		 * wasn't consistent enough. */
-		if (ts->read_cnt < ts->debounce_max) {
-			ts->last_read = *val;
-			ts->read_cnt++;
-			return ADS7846_FILTER_REPEAT;
-		} else {
-			/* Maximum number of debouncing reached and still
-			 * not enough number of consistent readings. Abort
-			 * the whole sample, repeat it in the next sampling
-			 * period.
-			 */
-			ts->read_cnt = 0;
-			return ADS7846_FILTER_IGNORE;
-		}
-	} else {
-		if (++ts->read_rep > ts->debounce_rep) {
-			/* Got a good reading for this coordinate,
-			 * go for the next one. */
-			ts->read_cnt = 0;
-			ts->read_rep = 0;
-			return ADS7846_FILTER_OK;
-		} else {
-			/* Read more values that are consistent. */
-			ts->read_cnt++;
-			return ADS7846_FILTER_REPEAT;
-		}
-	}
 }
 
-static int ads7846_no_filter(void *ads, int data_idx, int *val)
+static irqreturn_t ads7846_hard_irq(int irq, void *handle)
 {
-	return ADS7846_FILTER_OK;
-}
-
-static void ads7846_rx_val(void *ads)
-{
-	struct ads7846 *ts = ads;
-	struct ads7846_packet *packet = ts->packet;
-	struct spi_message *m;
-	struct spi_transfer *t;
-	int val;
-	int action;
-	int status;
-
-	m = &ts->msg[ts->msg_idx];
-	t = list_entry(m->transfers.prev, struct spi_transfer, transfer_list);
-
-	if (ts->model == 7845) {
-		val = be16_to_cpup((__be16 *)&(((char*)t->rx_buf)[1])) >> 3;
-	} else {
-		/* adjust:  on-wire is a must-ignore bit, a BE12 value, then
-		 * padding; built from two 8 bit values written msb-first.
-		 */
-		val = be16_to_cpup((__be16 *)t->rx_buf) >> 3;
-	}
+	struct ads7846 *ts = handle;
 
-	action = ts->filter(ts->filter_data, ts->msg_idx, &val);
-	switch (action) {
-	case ADS7846_FILTER_REPEAT:
-		break;
-	case ADS7846_FILTER_IGNORE:
-		packet->tc.ignore = 1;
-		/* Last message will contain ads7846_rx() as the
-		 * completion function.
-		 */
-		m = ts->last_msg;
-		break;
-	case ADS7846_FILTER_OK:
-		*(u16 *)t->rx_buf = val;
-		packet->tc.ignore = 0;
-		m = &ts->msg[++ts->msg_idx];
-		break;
-	default:
-		BUG();
-	}
-	ts->wait_for_sync();
-	status = spi_async(ts->spi, m);
-	if (status)
-		dev_err(&ts->spi->dev, "spi_async --> %d\n",
-				status);
+	return get_pendown_state(ts) ? IRQ_WAKE_THREAD : IRQ_HANDLED;
 }
 
-static enum hrtimer_restart ads7846_timer(struct hrtimer *handle)
-{
-	struct ads7846	*ts = container_of(handle, struct ads7846, timer);
-	int		status = 0;
-
-	spin_lock(&ts->lock);
-
-	if (unlikely(!get_pendown_state(ts) ||
-		     device_suspended(&ts->spi->dev))) {
-		if (ts->pendown) {
-			struct input_dev *input = ts->input;
-
-			input_report_key(input, BTN_TOUCH, 0);
-			input_report_abs(input, ABS_PRESSURE, 0);
-			input_sync(input);
-
-			ts->pendown = 0;
-			dev_vdbg(&ts->spi->dev, "UP\n");
-		}
-
-		/* measurement cycle ended */
-		if (!device_suspended(&ts->spi->dev)) {
-			ts->irq_disabled = 0;
-			enable_irq(ts->spi->irq);
-		}
-		ts->pending = 0;
-	} else {
-		/* pen is still down, continue with the measurement */
-		ts->msg_idx = 0;
-		ts->wait_for_sync();
-		status = spi_async(ts->spi, &ts->msg[0]);
-		if (status)
-			dev_err(&ts->spi->dev, "spi_async --> %d\n", status);
-	}
-
-	spin_unlock(&ts->lock);
-	return HRTIMER_NORESTART;
-}
 
 static irqreturn_t ads7846_irq(int irq, void *handle)
 {
 	struct ads7846 *ts = handle;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ts->lock, flags);
-	if (likely(get_pendown_state(ts))) {
-		if (!ts->irq_disabled) {
-			/* The ARM do_simple_IRQ() dispatcher doesn't act
-			 * like the other dispatchers:  it will report IRQs
-			 * even after they've been disabled.  We work around
-			 * that here.  (The "generic irq" framework may help...)
-			 */
-			ts->irq_disabled = 1;
-			disable_irq_nosync(ts->spi->irq);
-			ts->pending = 1;
-			hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_DELAY),
-					HRTIMER_MODE_REL);
-		}
-	}
-	spin_unlock_irqrestore(&ts->lock, flags);
 
-	return IRQ_HANDLED;
-}
+	/* Start with a small delay before checking pendown state */
+	msleep(TS_POLL_DELAY);
 
-/*--------------------------------------------------------------------------*/
+	while (!ts->stopped && get_pendown_state(ts)) {
 
-/* Must be called with ts->lock held */
-static void ads7846_disable(struct ads7846 *ts)
-{
-	if (ts->disabled)
-		return;
+		/* pen is down, continue with the measurement */
+		ads7846_read_state(ts);
 
-	ts->disabled = 1;
+		if (!ts->stopped)
+			ads7846_report_state(ts);
 
-	/* are we waiting for IRQ, or polling? */
-	if (!ts->pending) {
-		ts->irq_disabled = 1;
-		disable_irq(ts->spi->irq);
-	} else {
-		/* the timer will run at least once more, and
-		 * leave everything in a clean state, IRQ disabled
-		 */
-		while (ts->pending) {
-			spin_unlock_irq(&ts->lock);
-			msleep(1);
-			spin_lock_irq(&ts->lock);
-		}
+		wait_event_timeout(ts->wait, ts->stopped,
+				   msecs_to_jiffies(TS_POLL_PERIOD));
 	}
 
-	regulator_disable(ts->reg);
-
-	/* we know the chip's in lowpower mode since we always
-	 * leave it that way after every request
-	 */
-}
+	if (ts->pendown) {
+		struct input_dev *input = ts->input;
 
-/* Must be called with ts->lock held */
-static void ads7846_enable(struct ads7846 *ts)
-{
-	if (!ts->disabled)
-		return;
+		input_report_key(input, BTN_TOUCH, 0);
+		input_report_abs(input, ABS_PRESSURE, 0);
+		input_sync(input);
 
-	regulator_enable(ts->reg);
+		ts->pendown = false;
+		dev_vdbg(&ts->spi->dev, "UP\n");
+	}
 
-	ts->disabled = 0;
-	ts->irq_disabled = 0;
-	enable_irq(ts->spi->irq);
+	return IRQ_HANDLED;
 }
 
 static int ads7846_suspend(struct spi_device *spi, pm_message_t message)
 {
 	struct ads7846 *ts = dev_get_drvdata(&spi->dev);
 
-	spin_lock_irq(&ts->lock);
+	mutex_lock(&ts->lock);
 
-	ts->is_suspended = 1;
-	ads7846_disable(ts);
+	if (!ts->suspended) {
 
-	spin_unlock_irq(&ts->lock);
+		if (!ts->disabled)
+			__ads7846_disable(ts);
 
-	if (device_may_wakeup(&ts->spi->dev))
-		enable_irq_wake(ts->spi->irq);
+		if (device_may_wakeup(&ts->spi->dev))
+			enable_irq_wake(ts->spi->irq);
 
-	return 0;
+		ts->suspended = true;
+	}
+
+	mutex_unlock(&ts->lock);
 
+	return 0;
 }
 
 static int ads7846_resume(struct spi_device *spi)
 {
 	struct ads7846 *ts = dev_get_drvdata(&spi->dev);
 
-	if (device_may_wakeup(&ts->spi->dev))
-		disable_irq_wake(ts->spi->irq);
+	mutex_lock(&ts->lock);
+
+	if (ts->suspended) {
 
-	spin_lock_irq(&ts->lock);
+		ts->suspended = false;
 
-	ts->is_suspended = 0;
-	ads7846_enable(ts);
+		if (device_may_wakeup(&ts->spi->dev))
+			disable_irq_wake(ts->spi->irq);
 
-	spin_unlock_irq(&ts->lock);
+		if (!ts->disabled)
+			__ads7846_enable(ts);
+	}
+
+	mutex_unlock(&ts->lock);
 
 	return 0;
 }
 
-static int __devinit setup_pendown(struct spi_device *spi, struct ads7846 *ts)
+static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads7846 *ts)
 {
 	struct ads7846_platform_data *pdata = spi->dev.platform_data;
 	int err;
@@ -932,146 +958,40 @@ static int __devinit setup_pendown(struct spi_device *spi, struct ads7846 *ts)
 	err = gpio_request(pdata->gpio_pendown, "ads7846_pendown");
 	if (err) {
 		dev_err(&spi->dev, "failed to request pendown GPIO%d\n",
-				pdata->gpio_pendown);
+			pdata->gpio_pendown);
 		return err;
 	}
 
 	ts->gpio_pendown = pdata->gpio_pendown;
+
 	return 0;
 }
 
-static int __devinit ads7846_probe(struct spi_device *spi)
+/*
+ * Set up the transfers to read touchscreen state; this assumes we
+ * use formula #2 for pressure, not #3.
+ */
+static void __devinit ads7846_setup_spi_msg(struct ads7846 *ts,
+				const struct ads7846_platform_data *pdata)
 {
-	struct ads7846 *ts;
-	struct ads7846_packet *packet;
-	struct input_dev *input_dev;
-	const struct ads7846_platform_data *pdata = spi->dev.platform_data;
-	struct spi_message *m;
-	struct spi_transfer *x;
-	unsigned long irq_flags;
-	int vref;
-	int err;
-
-	if (!spi->irq) {
-		dev_dbg(&spi->dev, "no IRQ?\n");
-		return -ENODEV;
-	}
-
-	if (!pdata) {
-		dev_dbg(&spi->dev, "no platform data?\n");
-		return -ENODEV;
-	}
-
-	/* don't exceed max specified sample rate */
-	if (spi->max_speed_hz > (125000 * SAMPLE_BITS)) {
-		dev_dbg(&spi->dev, "f(sample) %d KHz?\n",
-				(spi->max_speed_hz/SAMPLE_BITS)/1000);
-		return -EINVAL;
-	}
-
-	/* We'd set TX wordsize 8 bits and RX wordsize to 13 bits ... except
-	 * that even if the hardware can do that, the SPI controller driver
-	 * may not.  So we stick to very-portable 8 bit words, both RX and TX.
-	 */
-	spi->bits_per_word = 8;
-	spi->mode = SPI_MODE_0;
-	err = spi_setup(spi);
-	if (err < 0)
-		return err;
-
-	ts = kzalloc(sizeof(struct ads7846), GFP_KERNEL);
-	packet = kzalloc(sizeof(struct ads7846_packet), GFP_KERNEL);
-	input_dev = input_allocate_device();
-	if (!ts || !packet || !input_dev) {
-		err = -ENOMEM;
-		goto err_free_mem;
-	}
-
-	dev_set_drvdata(&spi->dev, ts);
-
-	ts->packet = packet;
-	ts->spi = spi;
-	ts->input = input_dev;
-	ts->vref_mv = pdata->vref_mv;
-	ts->swap_xy = pdata->swap_xy;
-
-	hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	ts->timer.function = ads7846_timer;
-
-	spin_lock_init(&ts->lock);
-
-	ts->model = pdata->model ? : 7846;
-	ts->vref_delay_usecs = pdata->vref_delay_usecs ? : 100;
-	ts->x_plate_ohms = pdata->x_plate_ohms ? : 400;
-	ts->pressure_max = pdata->pressure_max ? : ~0;
-
-	if (pdata->filter != NULL) {
-		if (pdata->filter_init != NULL) {
-			err = pdata->filter_init(pdata, &ts->filter_data);
-			if (err < 0)
-				goto err_free_mem;
-		}
-		ts->filter = pdata->filter;
-		ts->filter_cleanup = pdata->filter_cleanup;
-	} else if (pdata->debounce_max) {
-		ts->debounce_max = pdata->debounce_max;
-		if (ts->debounce_max < 2)
-			ts->debounce_max = 2;
-		ts->debounce_tol = pdata->debounce_tol;
-		ts->debounce_rep = pdata->debounce_rep;
-		ts->filter = ads7846_debounce;
-		ts->filter_data = ts;
-	} else
-		ts->filter = ads7846_no_filter;
-
-	err = setup_pendown(spi, ts);
-	if (err)
-		goto err_cleanup_filter;
-
-	if (pdata->penirq_recheck_delay_usecs)
-		ts->penirq_recheck_delay_usecs =
-				pdata->penirq_recheck_delay_usecs;
-
-	ts->wait_for_sync = pdata->wait_for_sync ? : null_wait_for_sync;
-
-	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(&spi->dev));
-	snprintf(ts->name, sizeof(ts->name), "ADS%d Touchscreen", ts->model);
-
-	input_dev->name = ts->name;
-	input_dev->phys = ts->phys;
-	input_dev->dev.parent = &spi->dev;
-
-	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
-	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
-	input_set_abs_params(input_dev, ABS_X,
-			pdata->x_min ? : 0,
-			pdata->x_max ? : MAX_12BIT,
-			0, 0);
-	input_set_abs_params(input_dev, ABS_Y,
-			pdata->y_min ? : 0,
-			pdata->y_max ? : MAX_12BIT,
-			0, 0);
-	input_set_abs_params(input_dev, ABS_PRESSURE,
-			pdata->pressure_min, pdata->pressure_max, 0, 0);
-
-	vref = pdata->keep_vref_on;
+	struct spi_message *m = &ts->msg[0];
+	struct spi_transfer *x = ts->xfer;
+	struct ads7846_packet *packet = ts->packet;
+	int vref = pdata->keep_vref_on;
 
 	if (ts->model == 7873) {
-		/* The AD7873 is almost identical to the ADS7846
+		/*
+		 * The AD7873 is almost identical to the ADS7846
 		 * keep VREF off during differential/ratiometric
-		 * conversion modes
+		 * conversion modes.
 		 */
 		ts->model = 7846;
 		vref = 0;
 	}
 
-	/* set up the transfers to read touchscreen state; this assumes we
-	 * use formula #2 for pressure, not #3.
-	 */
-	m = &ts->msg[0];
-	x = ts->xfer;
-
+	ts->msg_count = 1;
 	spi_message_init(m);
+	m->context = ts;
 
 	if (ts->model == 7845) {
 		packet->read_y_cmd[0] = READ_Y(vref);
@@ -1094,7 +1014,8 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 		spi_message_add_tail(x, m);
 	}
 
-	/* the first sample after switching drivers can be low quality;
+	/*
+	 * The first sample after switching drivers can be low quality;
 	 * optionally discard it, using a second one after the signals
 	 * have had enough time to stabilize.
 	 */
@@ -1112,11 +1033,10 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 		spi_message_add_tail(x, m);
 	}
 
-	m->complete = ads7846_rx_val;
-	m->context = ts;
-
+	ts->msg_count++;
 	m++;
 	spi_message_init(m);
+	m->context = ts;
 
 	if (ts->model == 7845) {
 		x++;
@@ -1156,13 +1076,12 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 		spi_message_add_tail(x, m);
 	}
 
-	m->complete = ads7846_rx_val;
-	m->context = ts;
-
 	/* turn y+ off, x- on; we'll use formula #2 */
 	if (ts->model == 7846) {
+		ts->msg_count++;
 		m++;
 		spi_message_init(m);
+		m->context = ts;
 
 		x++;
 		packet->read_z1 = READ_Z1(vref);
@@ -1190,11 +1109,10 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 			spi_message_add_tail(x, m);
 		}
 
-		m->complete = ads7846_rx_val;
-		m->context = ts;
-
+		ts->msg_count++;
 		m++;
 		spi_message_init(m);
+		m->context = ts;
 
 		x++;
 		packet->read_z2 = READ_Z2(vref);
@@ -1221,14 +1139,13 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 			x->len = 2;
 			spi_message_add_tail(x, m);
 		}
-
-		m->complete = ads7846_rx_val;
-		m->context = ts;
 	}
 
 	/* power down */
+	ts->msg_count++;
 	m++;
 	spi_message_init(m);
+	m->context = ts;
 
 	if (ts->model == 7845) {
 		x++;
@@ -1251,11 +1168,119 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 
 	CS_CHANGE(*x);
 	spi_message_add_tail(x, m);
+}
 
-	m->complete = ads7846_rx;
-	m->context = ts;
+static int __devinit ads7846_probe(struct spi_device *spi)
+{
+	struct ads7846 *ts;
+	struct ads7846_packet *packet;
+	struct input_dev *input_dev;
+	struct ads7846_platform_data *pdata = spi->dev.platform_data;
+	unsigned long irq_flags;
+	int err;
+
+	if (!spi->irq) {
+		dev_dbg(&spi->dev, "no IRQ?\n");
+		return -ENODEV;
+	}
+
+	if (!pdata) {
+		dev_dbg(&spi->dev, "no platform data?\n");
+		return -ENODEV;
+	}
+
+	/* don't exceed max specified sample rate */
+	if (spi->max_speed_hz > (125000 * SAMPLE_BITS)) {
+		dev_dbg(&spi->dev, "f(sample) %d KHz?\n",
+				(spi->max_speed_hz/SAMPLE_BITS)/1000);
+		return -EINVAL;
+	}
+
+	/* We'd set TX word size 8 bits and RX word size to 13 bits ... except
+	 * that even if the hardware can do that, the SPI controller driver
+	 * may not.  So we stick to very-portable 8 bit words, both RX and TX.
+	 */
+	spi->bits_per_word = 8;
+	spi->mode = SPI_MODE_0;
+	err = spi_setup(spi);
+	if (err < 0)
+		return err;
 
-	ts->last_msg = m;
+	ts = kzalloc(sizeof(struct ads7846), GFP_KERNEL);
+	packet = kzalloc(sizeof(struct ads7846_packet), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!ts || !packet || !input_dev) {
+		err = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	dev_set_drvdata(&spi->dev, ts);
+
+	ts->packet = packet;
+	ts->spi = spi;
+	ts->input = input_dev;
+	ts->vref_mv = pdata->vref_mv;
+	ts->swap_xy = pdata->swap_xy;
+
+	mutex_init(&ts->lock);
+	init_waitqueue_head(&ts->wait);
+
+	ts->model = pdata->model ? : 7846;
+	ts->vref_delay_usecs = pdata->vref_delay_usecs ? : 100;
+	ts->x_plate_ohms = pdata->x_plate_ohms ? : 400;
+	ts->pressure_max = pdata->pressure_max ? : ~0;
+
+	if (pdata->filter != NULL) {
+		if (pdata->filter_init != NULL) {
+			err = pdata->filter_init(pdata, &ts->filter_data);
+			if (err < 0)
+				goto err_free_mem;
+		}
+		ts->filter = pdata->filter;
+		ts->filter_cleanup = pdata->filter_cleanup;
+	} else if (pdata->debounce_max) {
+		ts->debounce_max = pdata->debounce_max;
+		if (ts->debounce_max < 2)
+			ts->debounce_max = 2;
+		ts->debounce_tol = pdata->debounce_tol;
+		ts->debounce_rep = pdata->debounce_rep;
+		ts->filter = ads7846_debounce_filter;
+		ts->filter_data = ts;
+	} else {
+		ts->filter = ads7846_no_filter;
+	}
+
+	err = ads7846_setup_pendown(spi, ts);
+	if (err)
+		goto err_cleanup_filter;
+
+	if (pdata->penirq_recheck_delay_usecs)
+		ts->penirq_recheck_delay_usecs =
+				pdata->penirq_recheck_delay_usecs;
+
+	ts->wait_for_sync = pdata->wait_for_sync ? : null_wait_for_sync;
+
+	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(&spi->dev));
+	snprintf(ts->name, sizeof(ts->name), "ADS%d Touchscreen", ts->model);
+
+	input_dev->name = ts->name;
+	input_dev->phys = ts->phys;
+	input_dev->dev.parent = &spi->dev;
+
+	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+	input_set_abs_params(input_dev, ABS_X,
+			pdata->x_min ? : 0,
+			pdata->x_max ? : MAX_12BIT,
+			0, 0);
+	input_set_abs_params(input_dev, ABS_Y,
+			pdata->y_min ? : 0,
+			pdata->y_max ? : MAX_12BIT,
+			0, 0);
+	input_set_abs_params(input_dev, ABS_PRESSURE,
+			pdata->pressure_min, pdata->pressure_max, 0, 0);
+
+	ads7846_setup_spi_msg(ts, pdata);
 
 	ts->reg = regulator_get(&spi->dev, "vcc");
 	if (IS_ERR(ts->reg)) {
@@ -1271,16 +1296,17 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 	}
 
 	irq_flags = pdata->irq_flags ? : IRQF_TRIGGER_FALLING;
+	irq_flags |= IRQF_ONESHOT;
 
-	err = request_irq(spi->irq, ads7846_irq, irq_flags,
-			  spi->dev.driver->name, ts);
-
+	err = request_threaded_irq(spi->irq, ads7846_hard_irq, ads7846_irq,
+				   irq_flags, spi->dev.driver->name, ts);
 	if (err && !pdata->irq_flags) {
 		dev_info(&spi->dev,
 			"trying pin change workaround on irq %d\n", spi->irq);
-		err = request_irq(spi->irq, ads7846_irq,
-				  IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
-				  spi->dev.driver->name, ts);
+		irq_flags |= IRQF_TRIGGER_RISING;
+		err = request_threaded_irq(spi->irq,
+				  ads7846_hard_irq, ads7846_irq,
+				  irq_flags, spi->dev.driver->name, ts);
 	}
 
 	if (err) {
@@ -1294,7 +1320,8 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 
 	dev_info(&spi->dev, "touchscreen, irq %d\n", spi->irq);
 
-	/* take a first sample, leaving nPENIRQ active and vREF off; avoid
+	/*
+	 * Take a first sample, leaving nPENIRQ active and vREF off; avoid
 	 * the touchscreen, in case it's not connected.
 	 */
 	if (ts->model == 7845)
@@ -1340,20 +1367,18 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 
 static int __devexit ads7846_remove(struct spi_device *spi)
 {
-	struct ads7846		*ts = dev_get_drvdata(&spi->dev);
+	struct ads7846 *ts = dev_get_drvdata(&spi->dev);
 
 	device_init_wakeup(&spi->dev, false);
 
-	ads784x_hwmon_unregister(spi, ts);
-	input_unregister_device(ts->input);
-
-	ads7846_suspend(spi, PMSG_SUSPEND);
-
 	sysfs_remove_group(&spi->dev.kobj, &ads784x_attr_group);
 
+	ads7846_disable(ts);
 	free_irq(ts->spi->irq, ts);
-	/* suspend left the IRQ disabled */
-	enable_irq(ts->spi->irq);
+
+	input_unregister_device(ts->input);
+
+	ads784x_hwmon_unregister(spi, ts);
 
 	regulator_disable(ts->reg);
 	regulator_put(ts->reg);
@@ -1368,6 +1393,7 @@ static int __devexit ads7846_remove(struct spi_device *spi)
 	kfree(ts);
 
 	dev_dbg(&spi->dev, "unregistered touchscreen\n");
+
 	return 0;
 }
 
