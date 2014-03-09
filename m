From: Clinton Sprain <clintonsprain@gmail.com>
Subject: [PATCH v3 1/3] input: appletouch: dial back fuzz setting
Date: Sun, 09 Mar 2014 00:05:18 -0600
Message-ID: <531C049E.5010607@gmail.com>
References: <52D9DE7A.7040509@gmail.com> <531C042D.5090103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:37573 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbaCIGFV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 9 Mar 2014 01:05:21 -0500
Received: by mail-yk0-f177.google.com with SMTP id q200so15668265ykb.8
        for <linux-input@vger.kernel.org>; Sat, 08 Mar 2014 22:05:20 -0800 (PST)
In-Reply-To: <531C042D.5090103@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>

Dials back the default fuzz setting for most devices using this driver, based
on values from  user feedback from forums and bug reports.

Signed-off-by: Clinton Sprain <clintonsprain@gmail.com>
---
 drivers/input/mouse/appletouch.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index 800ca7d..2745832 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -48,6 +48,7 @@ struct atp_info {
 	int yfact;				/* Y multiplication factor */
 	int datalen;				/* size of USB transfers */
 	void (*callback)(struct urb *);		/* callback function */
+	int fuzz;				/* fuzz touchpad generates */
 };
 
 static void atp_complete_geyser_1_2(struct urb *urb);
@@ -61,6 +62,7 @@ static const struct atp_info fountain_info = {
 	.yfact		= 43,
 	.datalen	= 81,
 	.callback	= atp_complete_geyser_1_2,
+	.fuzz		= 16,
 };
 
 static const struct atp_info geyser1_info = {
@@ -71,6 +73,7 @@ static const struct atp_info geyser1_info = {
 	.yfact		= 43,
 	.datalen	= 81,
 	.callback	= atp_complete_geyser_1_2,
+	.fuzz		= 16,
 };
 
 static const struct atp_info geyser2_info = {
@@ -81,6 +84,7 @@ static const struct atp_info geyser2_info = {
 	.yfact		= 43,
 	.datalen	= 64,
 	.callback	= atp_complete_geyser_1_2,
+	.fuzz		= 0,
 };
 
 static const struct atp_info geyser3_info = {
@@ -90,6 +94,7 @@ static const struct atp_info geyser3_info = {
 	.yfact		= 64,
 	.datalen	= 64,
 	.callback	= atp_complete_geyser_3_4,
+	.fuzz		= 0,
 };
 
 static const struct atp_info geyser4_info = {
@@ -99,6 +104,7 @@ static const struct atp_info geyser4_info = {
 	.yfact		= 64,
 	.datalen	= 64,
 	.callback	= atp_complete_geyser_3_4,
+	.fuzz		= 0,
 };
 
 #define ATP_DEVICE(prod, info)					\
@@ -155,9 +161,6 @@ MODULE_DEVICE_TABLE(usb, atp_table);
 #define ATP_XSENSORS	26
 #define ATP_YSENSORS	16
 
-/* amount of fuzz this touchpad generates */
-#define ATP_FUZZ	16
-
 /* maximum pressure this driver will report */
 #define ATP_PRESSURE	300
 
@@ -455,7 +458,7 @@ static void atp_detect_size(struct atp *dev)
 			input_set_abs_params(dev->input, ABS_X, 0,
 					     (dev->info->xsensors_17 - 1) *
 							dev->info->xfact - 1,
-					     ATP_FUZZ, 0);
+					     dev->info->fuzz, 0);
 			break;
 		}
 	}
@@ -843,10 +846,10 @@ static int atp_probe(struct usb_interface *iface,
 
 	input_set_abs_params(input_dev, ABS_X, 0,
 			     (dev->info->xsensors - 1) * dev->info->xfact - 1,
-			     ATP_FUZZ, 0);
+			     dev->info->fuzz, 0);
 	input_set_abs_params(input_dev, ABS_Y, 0,
 			     (dev->info->ysensors - 1) * dev->info->yfact - 1,
-			     ATP_FUZZ, 0);
+			     dev->info->fuzz, 0);
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, ATP_PRESSURE, 0, 0);
 
 	set_bit(EV_KEY, input_dev->evbit);
-- 
1.7.9.5

