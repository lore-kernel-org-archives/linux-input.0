From: haarp <main.haarp@googlemail.com>
Subject: [PATCH] psmouse: Expose drift duration for IBM trackpoints
Date: Wed, 17 Dec 2014 18:09:47 +0100
Message-ID: <5491B8DB.6070102@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040902060507090304080601"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:60579 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbaLQRJw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Dec 2014 12:09:52 -0500
Received: by mail-wg0-f41.google.com with SMTP id y19so20894194wgg.28
        for <linux-input@vger.kernel.org>; Wed, 17 Dec 2014 09:09:51 -0800 (PST)
Received: from [192.168.1.13] (p5B3DF2EF.dip0.t-ipconnect.de. [91.61.242.239])
        by mx.google.com with ESMTPSA id iz19sm21663572wic.8.2014.12.17.09.09.49
        for <linux-input@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Dec 2014 09:09:50 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------040902060507090304080601
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello,

IBM Trackpoints have a feature to compensate for drift by
recalibrating themselves periodically. If for 0.5 seconds
there is no change in position, it uses this as the new zero.

This happens often when the trackpoint is in fact being used.
This is frustrating.

Raising the time solves the problem.
IBM's Trackpoint Engineering Specifications offer a
configuration register for this (rstdft1). It just needs to
be exposed by the driver, as others already are.

Cheers!
-Mike


IBM Trackpoints have a feature to compensate for drift by recalibrating
themselves periodically. By default, if for 0.5 seconds there is no change in
position, it's used as the new zero. This duration is too low. Often, the
calibration happens when the trackpoint is in fact being used.

IBM's Trackpoint Engineering Specifications show a configuration register that
allows changing this duration, rstdft1.

Expose it via sysfs among the other settings.

Signed-off-by: Mike Murdoch <main.haarp@gmail.com>

--- a/drivers/input/mouse/trackpoint.h	2014-12-06 13:12:34.167917741 +0100
+++ b/drivers/input/mouse/trackpoint.h	2014-12-08 19:17:46.241131557 +0100
@@ -70,6 +70,9 @@
 #define TP_UP_THRESH		0x5A	/* Used to generate a 'click' on Z-axis */
 #define TP_Z_TIME		0x5E	/* How sharp of a press */
 #define TP_JENKS_CURV		0x5D	/* Minimum curvature for double click */
+#define TP_DRIFT_TIME		0x5F	/* How long a 'hands off' condition */
+					/* must last (x*107ms) for drift */
+					/* correction to occur */
 
 /*
  * Toggling Flag bits
@@ -120,6 +123,7 @@
 #define TP_DEF_UP_THRESH	0xFF
 #define TP_DEF_Z_TIME		0x26
 #define TP_DEF_JENKS_CURV	0x87
+#define TP_DEF_DRIFT_TIME	0x05
 
 /* Toggles */
 #define TP_DEF_MB		0x00
@@ -137,6 +141,7 @@ struct trackpoint_data
 	unsigned char draghys, mindrag;
 	unsigned char thresh, upthresh;
 	unsigned char ztime, jenks;
+	unsigned char drift_time;
 
 	/* toggles */
 	unsigned char press_to_select;
--- a/drivers/input/mouse/trackpoint.c	2014-12-06 13:12:34.167917741 +0100
+++ b/drivers/input/mouse/trackpoint.c	2014-12-06 16:03:09.587952302 +0100
@@ -227,6 +227,7 @@ TRACKPOINT_INT_ATTR(thresh, TP_THRESH, T
 TRACKPOINT_INT_ATTR(upthresh, TP_UP_THRESH, TP_DEF_UP_THRESH);
 TRACKPOINT_INT_ATTR(ztime, TP_Z_TIME, TP_DEF_Z_TIME);
 TRACKPOINT_INT_ATTR(jenks, TP_JENKS_CURV, TP_DEF_JENKS_CURV);
+TRACKPOINT_INT_ATTR(drift_time, TP_DRIFT_TIME, TP_DEF_DRIFT_TIME);
 
 TRACKPOINT_BIT_ATTR(press_to_select, TP_TOGGLE_PTSON, TP_MASK_PTSON, 0,
 		    TP_DEF_PTSON);
@@ -249,6 +250,7 @@ static struct attribute *trackpoint_attr
 	&psmouse_attr_press_to_select.dattr.attr,
 	&psmouse_attr_skipback.dattr.attr,
 	&psmouse_attr_ext_dev.dattr.attr,
+	&psmouse_attr_drift_time.dattr.attr,
 	NULL
 };
 
@@ -312,6 +314,7 @@ static int trackpoint_sync(struct psmous
 	TRACKPOINT_UPDATE(in_power_on_state, psmouse, tp, upthresh);
 	TRACKPOINT_UPDATE(in_power_on_state, psmouse, tp, ztime);
 	TRACKPOINT_UPDATE(in_power_on_state, psmouse, tp, jenks);
+	TRACKPOINT_UPDATE(in_power_on_state, psmouse, tp, drift_time);
 
 	/* toggles */
 	TRACKPOINT_UPDATE(in_power_on_state, psmouse, tp, press_to_select);
@@ -333,6 +336,7 @@ static void trackpoint_defaults(struct t
 	TRACKPOINT_SET_POWER_ON_DEFAULT(tp, ztime);
 	TRACKPOINT_SET_POWER_ON_DEFAULT(tp, jenks);
 	TRACKPOINT_SET_POWER_ON_DEFAULT(tp, inertia);
+	TRACKPOINT_SET_POWER_ON_DEFAULT(tp, drift_time);
 
 	/* toggles */
 	TRACKPOINT_SET_POWER_ON_DEFAULT(tp, press_to_select);


--------------040902060507090304080601
Content-Type: text/x-patch;
 name="trackpoint_expose_drift_time.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="trackpoint_expose_drift_time.patch"

IBM Trackpoints have a feature to compensate for drift by recalibrating
themselves periodically. By default, if for 0.5 seconds there is no change in
position, it's used as the new zero. This duration is too low. Often, the
calibration happens when the trackpoint is in fact being used.

IBM's Trackpoint Engineering Specifications show a configuration register that
allows changing this duration, rstdft1.

Expose it via sysfs among the other settings.

Signed-off-by: Mike Murdoch <main.haarp@gmail.com>

--- a/drivers/input/mouse/trackpoint.h	2014-12-06 13:12:34.167917741 +0100
+++ b/drivers/input/mouse/trackpoint.h	2014-12-08 19:17:46.241131557 +0100
@@ -70,6 +70,9 @@
 #define TP_UP_THRESH		0x5A	/* Used to generate a 'click' on Z-axis */
 #define TP_Z_TIME		0x5E	/* How sharp of a press */
 #define TP_JENKS_CURV		0x5D	/* Minimum curvature for double click */
+#define TP_DRIFT_TIME		0x5F	/* How long a 'hands off' condition */
+					/* must last (x*107ms) for drift */
+					/* correction to occur */
 
 /*
  * Toggling Flag bits
@@ -120,6 +123,7 @@
 #define TP_DEF_UP_THRESH	0xFF
 #define TP_DEF_Z_TIME		0x26
 #define TP_DEF_JENKS_CURV	0x87
+#define TP_DEF_DRIFT_TIME	0x05
 
 /* Toggles */
 #define TP_DEF_MB		0x00
@@ -137,6 +141,7 @@ struct trackpoint_data
 	unsigned char draghys, mindrag;
 	unsigned char thresh, upthresh;
 	unsigned char ztime, jenks;
+	unsigned char drift_time;
 
 	/* toggles */
 	unsigned char press_to_select;
--- a/drivers/input/mouse/trackpoint.c	2014-12-06 13:12:34.167917741 +0100
+++ b/drivers/input/mouse/trackpoint.c	2014-12-06 16:03:09.587952302 +0100
@@ -227,6 +227,7 @@ TRACKPOINT_INT_ATTR(thresh, TP_THRESH, T
 TRACKPOINT_INT_ATTR(upthresh, TP_UP_THRESH, TP_DEF_UP_THRESH);
 TRACKPOINT_INT_ATTR(ztime, TP_Z_TIME, TP_DEF_Z_TIME);
 TRACKPOINT_INT_ATTR(jenks, TP_JENKS_CURV, TP_DEF_JENKS_CURV);
+TRACKPOINT_INT_ATTR(drift_time, TP_DRIFT_TIME, TP_DEF_DRIFT_TIME);
 
 TRACKPOINT_BIT_ATTR(press_to_select, TP_TOGGLE_PTSON, TP_MASK_PTSON, 0,
 		    TP_DEF_PTSON);
@@ -249,6 +250,7 @@ static struct attribute *trackpoint_attr
 	&psmouse_attr_press_to_select.dattr.attr,
 	&psmouse_attr_skipback.dattr.attr,
 	&psmouse_attr_ext_dev.dattr.attr,
+	&psmouse_attr_drift_time.dattr.attr,
 	NULL
 };
 
@@ -312,6 +314,7 @@ static int trackpoint_sync(struct psmous
 	TRACKPOINT_UPDATE(in_power_on_state, psmouse, tp, upthresh);
 	TRACKPOINT_UPDATE(in_power_on_state, psmouse, tp, ztime);
 	TRACKPOINT_UPDATE(in_power_on_state, psmouse, tp, jenks);
+	TRACKPOINT_UPDATE(in_power_on_state, psmouse, tp, drift_time);
 
 	/* toggles */
 	TRACKPOINT_UPDATE(in_power_on_state, psmouse, tp, press_to_select);
@@ -333,6 +336,7 @@ static void trackpoint_defaults(struct t
 	TRACKPOINT_SET_POWER_ON_DEFAULT(tp, ztime);
 	TRACKPOINT_SET_POWER_ON_DEFAULT(tp, jenks);
 	TRACKPOINT_SET_POWER_ON_DEFAULT(tp, inertia);
+	TRACKPOINT_SET_POWER_ON_DEFAULT(tp, drift_time);
 
 	/* toggles */
 	TRACKPOINT_SET_POWER_ON_DEFAULT(tp, press_to_select);

--------------040902060507090304080601--
