From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.24-rc6] ads7846:  simplify support of external vREF (and ads7843)
Date: Sat, 5 Jan 2008 14:10:19 -0800
Message-ID: <200801051410.19925.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:34458 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757439AbYAEWKX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 5 Jan 2008 17:10:23 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

This updates the ads7846 driver to handle external vREF (required
on boards using ads7843 chips) without module parameters, and also
removes a needless variable with its associated bogus gcc warning.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -87,6 +87,7 @@ struct ads7846 {
 #endif
 
 	u16			model;
+	u16			vref_mv;
 	u16			vref_delay_usecs;
 	u16			x_plate_ohms;
 	u16			pressure_max;
@@ -183,9 +184,6 @@ struct ads7846 {
  * The range is GND..vREF. The ads7843 and ads7835 must use external vREF;
  * ads7846 lets that pin be unconnected, to use internal vREF.
  */
-static unsigned vREF_mV;
-module_param(vREF_mV, uint, 0);
-MODULE_PARM_DESC(vREF_mV, "external vREF voltage, in milliVolts");
 
 struct ser_req {
 	u8			ref_on;
@@ -212,7 +210,6 @@ static int ads7846_read12_ser(struct dev
 	struct ads7846		*ts = dev_get_drvdata(dev);
 	struct ser_req		*req = kzalloc(sizeof *req, GFP_KERNEL);
 	int			status;
-	int			sample;
 	int			use_internal;
 
 	if (!req)
@@ -269,13 +266,13 @@ static int ads7846_read12_ser(struct dev
 
 	if (status == 0) {
 		/* on-wire is a must-ignore bit, a BE12 value, then padding */
-		sample = be16_to_cpu(req->sample);
-		sample = sample >> 3;
-		sample &= 0x0fff;
+		status = be16_to_cpu(req->sample);
+		status = status >> 3;
+		status &= 0x0fff;
 	}
 
 	kfree(req);
-	return status ? status : sample;
+	return status;
 }
 
 #if defined(CONFIG_HWMON) || defined(CONFIG_HWMON_MODULE)
@@ -316,7 +313,7 @@ static inline unsigned vaux_adjust(struc
 	unsigned retval = v;
 
 	/* external resistors may scale vAUX into 0..vREF */
-	retval *= vREF_mV;
+	retval *= ts->vref_mv;
 	retval = retval >> 12;
 	return retval;
 }
@@ -374,14 +371,14 @@ static int ads784x_hwmon_register(struct
 	/* hwmon sensors need a reference voltage */
 	switch (ts->model) {
 	case 7846:
-		if (!vREF_mV) {
+		if (!ts->vref_mv) {
 			dev_dbg(&spi->dev, "assuming 2.5V internal vREF\n");
-			vREF_mV = 2500;
+			ts->vref_mv = 2500;
 		}
 		break;
 	case 7845:
 	case 7843:
-		if (!vREF_mV) {
+		if (!ts->vref_mv) {
 			dev_warn(&spi->dev,
 				"external vREF for ADS%d not specified\n",
 				ts->model);
@@ -875,6 +872,7 @@ static int __devinit ads7846_probe(struc
 
 	ts->spi = spi;
 	ts->input = input_dev;
+	ts->vref_mv = pdata->vref_mv;
 
 	hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	ts->timer.function = ads7846_timer;
--- a/include/linux/spi/ads7846.h
+++ b/include/linux/spi/ads7846.h
@@ -14,7 +14,8 @@ enum ads7846_filter {
 struct ads7846_platform_data {
 	u16	model;			/* 7843, 7845, 7846. */
 	u16	vref_delay_usecs;	/* 0 for external vref; etc */
-	int	keep_vref_on:1;		/* set to keep vref on for differential
+	u16	vref_mv;		/* external vref value, milliVolts */
+	bool	keep_vref_on;		/* set to keep vref on for differential
 					 * measurements as well */
 
 	/* Settling time of the analog signals; a function of Vcc and the
