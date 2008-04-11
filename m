From: David Brownell <david-b@pacbell.net>
Subject: [RESEND patch 2.6.25-rc8] ads7846 vref support (ads7843)
Date: Fri, 11 Apr 2008 00:36:33 -0700
Message-ID: <200804110036.34408.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:26400 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757502AbYDKHpY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Apr 2008 03:45:24 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, dtor@mail.ru, linux-input@atrey.karlin.mff.cuni.cz

From: David Brownell <dbrownell@users.sourceforge.net>

This updates the ads7846 driver to handle external vREF (required
on boards using ads7843 chips) without module parameters.

Switch keep_vref_on flag to "bool"; signed bitfields are bogus.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
Updated since the version sent 5-January (evidently bounced from
list archives) ... to remove the warning fix that was merged (from
someone else) on 10-March.

MAINTAINERS says "linux-input@vger" but the only archives
I could find seems to say "@atrey.karlin.mff.cuni.cz"...

 drivers/input/touchscreen/ads7846.c |   13 ++++++-------
 include/linux/spi/ads7846.h         |    3 ++-
 2 files changed, 8 insertions(+), 8 deletions(-)

--- g26.orig/drivers/input/touchscreen/ads7846.c	2008-03-19 02:09:23.000000000 -0700
+++ g26/drivers/input/touchscreen/ads7846.c	2008-03-19 02:41:42.000000000 -0700
@@ -87,6 +87,7 @@ struct ads7846 {
 #endif
 
 	u16			model;
+	u16			vref_mv;
 	u16			vref_delay_usecs;
 	u16			x_plate_ohms;
 	u16			pressure_max;
@@ -184,9 +185,6 @@ struct ads7846 {
  * The range is GND..vREF. The ads7843 and ads7835 must use external vREF;
  * ads7846 lets that pin be unconnected, to use internal vREF.
  */
-static unsigned vREF_mV;
-module_param(vREF_mV, uint, 0);
-MODULE_PARM_DESC(vREF_mV, "external vREF voltage, in milliVolts");
 
 struct ser_req {
 	u8			ref_on;
@@ -317,7 +315,7 @@ static inline unsigned vaux_adjust(struc
 	unsigned retval = v;
 
 	/* external resistors may scale vAUX into 0..vREF */
-	retval *= vREF_mV;
+	retval *= ts->vref_mv;
 	retval = retval >> 12;
 	return retval;
 }
@@ -375,14 +373,14 @@ static int ads784x_hwmon_register(struct
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
@@ -875,6 +873,7 @@ static int __devinit ads7846_probe(struc
 
 	ts->spi = spi;
 	ts->input = input_dev;
+	ts->vref_mv = pdata->vref_mv;
 
 	hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	ts->timer.function = ads7846_timer;
--- g26.orig/include/linux/spi/ads7846.h	2008-03-19 01:53:06.000000000 -0700
+++ g26/include/linux/spi/ads7846.h	2008-03-19 02:41:42.000000000 -0700
@@ -14,7 +14,8 @@ enum ads7846_filter {
 struct ads7846_platform_data {
 	u16	model;			/* 7843, 7845, 7846. */
 	u16	vref_delay_usecs;	/* 0 for external vref; etc */
-	int	keep_vref_on:1;		/* set to keep vref on for differential
+	u16	vref_mv;		/* external vref value, milliVolts */
+	bool	keep_vref_on;		/* set to keep vref on for differential
 					 * measurements as well */
 
 	/* Settling time of the analog signals; a function of Vcc and the
