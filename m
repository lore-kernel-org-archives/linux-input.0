From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: [patch 2/7] xpad: fix inverted Y and RY axes on xbox360 devices
Date: Mon, 17 Mar 2008 21:22:52 +0200
Message-ID: <20080317192844.411623453@gmail.com>
References: <20080317192250.208635026@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:43377 "EHLO
	pne-smtpout3-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754176AbYCQT3A (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Mar 2008 15:29:00 -0400
Content-Disposition: inline; filename=xpad-flip-xbox360-stick-y-axis.diff
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Brian Magnuson <bdmagnuson@gmail.com>, Anssi Hannula <anssi.hannula@gmail.com>

The commit ae91d10aab2762f81733e9194cb56eff99c8d808 inverted Y and RY
axes so that up is positive and down is negative.
This is wrong, as axes on game controllers have up as negative per
convention. Also, even xpad itself reports HAT0X with up as negative.

Fix that by inverting them again.

Cc: Brian Magnuson <bdmagnuson@gmail.com>
Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---
 drivers/input/joystick/xpad.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.25-rc3-mm1-xpad/drivers/input/joystick/xpad.c
===================================================================
--- linux-2.6.25-rc3-mm1-xpad.orig/drivers/input/joystick/xpad.c	2008-03-05 01:52:52.000000000 +0200
+++ linux-2.6.25-rc3-mm1-xpad/drivers/input/joystick/xpad.c	2008-03-05 15:24:14.000000000 +0200
@@ -330,13 +330,13 @@ static void xpad360_process_packet(struc
 	input_report_abs(dev, ABS_X,
 			 (__s16) le16_to_cpup((__le16 *)(data + 6)));
 	input_report_abs(dev, ABS_Y,
-			 (__s16) le16_to_cpup((__le16 *)(data + 8)));
+			 ~(__s16) le16_to_cpup((__le16 *)(data + 8)));
 
 	/* right stick */
 	input_report_abs(dev, ABS_RX,
 			 (__s16) le16_to_cpup((__le16 *)(data + 10)));
 	input_report_abs(dev, ABS_RY,
-			 (__s16) le16_to_cpup((__le16 *)(data + 12)));
+			 ~(__s16) le16_to_cpup((__le16 *)(data + 12)));
 
 	/* triggers left/right */
 	input_report_abs(dev, ABS_Z, data[4]);

--
Anssi Hannula
