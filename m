From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: [patch 2/7, rev2] xpad: fix inverted Y and RY axes
Date: Fri, 28 Mar 2008 20:07:45 +0200
Message-ID: <47ED33F1.4060606@gmail.com>
References: <20080317192250.208635026@gmail.com> <20080317192844.411623453@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:59146 "EHLO
	pne-smtpout4-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756693AbYC1SHs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Mar 2008 14:07:48 -0400
In-Reply-To: <20080317192844.411623453@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Brian Magnuson <bdmagnuson@gmail.com>

The commit ae91d10aab2762f81733e9194cb56eff99c8d808 inverted Y and RY
axes on xbox360 so that up is positive and down is negative.
This is wrong, as axes on game controllers have up as negative per
convention. Also, even xpad itself reports HAT0X with up as negative.

Fix that by inverting them again.

Also, according to http://bugzilla.kernel.org/show_bug.cgi?id=10337 the
original xbox controllers also have the Y and RY axes inverted.
Fix that by inverting them as well.

Cc: Brian Magnuson <bdmagnuson@gmail.com>
Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---

Updated this patch according to info from
http://bugzilla.kernel.org/show_bug.cgi?id=10337


 drivers/input/joystick/xpad.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.25-rc3-mm1-xpad/drivers/input/joystick/xpad.c
===================================================================
--- linux-2.6.25-rc3-mm1-xpad.orig/drivers/input/joystick/xpad.c	2008-03-05 01:52:52.000000000 +0200
+++ linux-2.6.25-rc3-mm1-xpad/drivers/input/joystick/xpad.c	2008-03-28 19:59:19.000000000 +0200
@@ -236,13 +236,13 @@ static void xpad_process_packet(struct u
 	input_report_abs(dev, ABS_X,
 			 (__s16) le16_to_cpup((__le16 *)(data + 12)));
 	input_report_abs(dev, ABS_Y,
-			 (__s16) le16_to_cpup((__le16 *)(data + 14)));
+			 ~(__s16) le16_to_cpup((__le16 *)(data + 14)));
 
 	/* right stick */
 	input_report_abs(dev, ABS_RX,
 			 (__s16) le16_to_cpup((__le16 *)(data + 16)));
 	input_report_abs(dev, ABS_RY,
-			 (__s16) le16_to_cpup((__le16 *)(data + 18)));
+			 ~(__s16) le16_to_cpup((__le16 *)(data + 18)));
 
 	/* triggers left/right */
 	input_report_abs(dev, ABS_Z, data[10]);
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

