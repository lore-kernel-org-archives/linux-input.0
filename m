From: Mohamed Ikbel Boulabiar <medikbel@lii-enac.fr>
Subject: [PATCH] input: mt: Add MT Events reporting to evtest
Date: Tue, 19 May 2009 23:20:08 +0100
Message-ID: <45cc95260905191520w7d834124k2c8f970d82981809@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:4696 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218AbZESWU2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 May 2009 18:20:28 -0400
Received: by ey-out-2122.google.com with SMTP id 9so37657eyd.37
        for <linux-input@vger.kernel.org>; Tue, 19 May 2009 15:20:28 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, USB list <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>
Cc: boulabiar@gmail.com, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, vojtech@suse.cz

This patch adds new MT events reporting capabilities to evtest tool.
New multi-touch events were added by Henrik Rydberg in the kernel-2.6.3=
0-rc5.


=46rom: Mohamed-Ikbel Boulabiar <ikbel.boulabiar@enac.fr>
Tested-by: St=E9phane Chatty <chatty@enac.fr>



diff -rupN a/utils/evtest.c b/utils/evtest.c
--- a/utils/evtest.c	2009-05-19 23:42:18.000000000 +0100
+++ b/utils/evtest.c	2009-05-19 23:37:11.000000000 +0100
@@ -2,7 +2,7 @@
  * $Id$
  *
  *  Copyright (c) 1999-2000 Vojtech Pavlik
- *
+ *  		  2009 Mohamed-Ikbel Boulabiar
  *  Event device test program
  */

@@ -49,6 +49,21 @@ char *events[EV_MAX + 1] =3D {
 	[EV_FF_STATUS] =3D "ForceFeedbackStatus",
 };

+int ev_max[EV_MAX + 1] =3D {
+	[EV_SYN] =3D 2,				[EV_KEY] =3D KEY_MAX,
+	[EV_REL] =3D REL_MAX,			[EV_ABS] =3D ABS_MAX,
+	[EV_MSC] =3D MSC_MAX,			[EV_LED] =3D LED_MAX,
+	[EV_SND] =3D SND_MAX,			[EV_REP] =3D REP_MAX,
+	[EV_FF] =3D FF_MAX,			[EV_PWR] =3D -1,
+	[EV_FF_STATUS] =3D FF_STATUS_MAX,
+};
+
+char *syncs[3] =3D {
+	[SYN_REPORT] =3D "Report Sync",		[SYN_CONFIG] =3D "Config Sync",
+	[SYN_MT_REPORT] =3D "MT Report Sync"
+};
+
+
 char *keys[KEY_MAX + 1] =3D {
 	[0 ... KEY_MAX] =3D NULL,
 	[KEY_RESERVED] =3D "Reserved",		[KEY_ESC] =3D "Esc",
@@ -239,19 +254,24 @@ char *relatives[REL_MAX + 1] =3D {

 char *absolutes[ABS_MAX + 1] =3D {
 	[0 ... ABS_MAX] =3D NULL,
-	[ABS_X] =3D "X",			[ABS_Y] =3D "Y",
-	[ABS_Z] =3D "Z",			[ABS_RX] =3D "Rx",
-	[ABS_RY] =3D "Ry",		[ABS_RZ] =3D "Rz",
-	[ABS_THROTTLE] =3D "Throttle",	[ABS_RUDDER] =3D "Rudder",
-	[ABS_WHEEL] =3D "Wheel",		[ABS_GAS] =3D "Gas",
-	[ABS_BRAKE] =3D "Brake",		[ABS_HAT0X] =3D "Hat0X",
-	[ABS_HAT0Y] =3D "Hat0Y",		[ABS_HAT1X] =3D "Hat1X",
-	[ABS_HAT1Y] =3D "Hat1Y",		[ABS_HAT2X] =3D "Hat2X",
-	[ABS_HAT2Y] =3D "Hat2Y",		[ABS_HAT3X] =3D "Hat3X",
-	[ABS_HAT3Y] =3D "Hat 3Y",		[ABS_PRESSURE] =3D "Pressure",
-	[ABS_DISTANCE] =3D "Distance",	[ABS_TILT_X] =3D "XTilt",
-	[ABS_TILT_Y] =3D "YTilt",		[ABS_TOOL_WIDTH] =3D "Tool Width",
-	[ABS_VOLUME] =3D "Volume",	[ABS_MISC] =3D "Misc",
+	[ABS_X] =3D "X",					[ABS_Y] =3D "Y",
+	[ABS_Z] =3D "Z",					[ABS_RX] =3D "Rx",
+	[ABS_RY] =3D "Ry",				[ABS_RZ] =3D "Rz",
+	[ABS_THROTTLE] =3D "Throttle",			[ABS_RUDDER] =3D "Rudder",
+	[ABS_WHEEL] =3D "Wheel",				[ABS_GAS] =3D "Gas",
+	[ABS_BRAKE] =3D "Brake",				[ABS_HAT0X] =3D "Hat0X",
+	[ABS_HAT0Y] =3D "Hat0Y",				[ABS_HAT1X] =3D "Hat1X",
+	[ABS_HAT1Y] =3D "Hat1Y",				[ABS_HAT2X] =3D "Hat2X",
+	[ABS_HAT2Y] =3D "Hat2Y",				[ABS_HAT3X] =3D "Hat3X",
+	[ABS_HAT3Y] =3D "Hat 3Y",				[ABS_PRESSURE] =3D "Pressure",
+	[ABS_DISTANCE] =3D "Distance",			[ABS_TILT_X] =3D "XTilt",
+	[ABS_TILT_Y] =3D "YTilt",				[ABS_TOOL_WIDTH] =3D "Tool Width",
+	[ABS_VOLUME] =3D "Volume",			[ABS_MISC] =3D "Misc",
+	[ABS_MT_TOUCH_MAJOR] =3D "MT Touch Major",	[ABS_MT_TOUCH_MINOR] =3D "=
MT
Touch Minor",
+	[ABS_MT_WIDTH_MAJOR] =3D "MT Major Width",	[ABS_MT_WIDTH_MINOR] =3D "=
MT
Minor Width",
+	[ABS_MT_POSITION_X] =3D "MT Position X",		[ABS_MT_POSITION_Y] =3D "MT=
 Position Y",
+	[ABS_MT_TOOL_TYPE] =3D "MT Tool Type",		[ABS_MT_BLOB_ID] =3D "MT Blob=
 Id",
+	[ABS_MT_ORIENTATION] =3D "MT Orientation",
 };

 char *misc[MSC_MAX + 1] =3D {
@@ -283,7 +303,7 @@ char *sounds[SND_MAX + 1] =3D {

 char **names[EV_MAX + 1] =3D {
 	[0 ... EV_MAX] =3D NULL,
-	[EV_SYN] =3D events,			[EV_KEY] =3D keys,
+	[EV_SYN] =3D syncs,			[EV_KEY] =3D keys,
 	[EV_REL] =3D relatives,			[EV_ABS] =3D absolutes,
 	[EV_MSC] =3D misc,			[EV_LED] =3D leds,
 	[EV_SND] =3D sounds,			[EV_REP] =3D repeats,
@@ -339,9 +359,9 @@ int main (int argc, char **argv)
 	for (i =3D 0; i < EV_MAX; i++)
 		if (test_bit(i, bit[0])) {
 			printf("  Event type %d (%s)\n", i, events[i] ? events[i] : "?");
-			if (!i) continue;
+//			if (!i) continue;
 			ioctl(fd, EVIOCGBIT(i, KEY_MAX), bit[i]);
-			for (j =3D 0; j < KEY_MAX; j++)
+			for (j =3D 0; j <=3D ev_max[i]; j++)
 				if (test_bit(j, bit[i])) {
 					printf("    Event code %d (%s)\n", j, names[i] ? (names[i][j] ?
names[i][j] : "?") : "?");
 					if (i =3D=3D EV_ABS) {
@@ -369,7 +389,8 @@ int main (int argc, char **argv)

 			if (ev[i].type =3D=3D EV_SYN) {
 				printf("Event: time %ld.%06ld, -------------- %s ------------\n",
-					ev[i].time.tv_sec, ev[i].time.tv_usec, ev[i].code ? "Config
Sync" : "Report Sync" );
+					ev[i].time.tv_sec, ev[i].time.tv_usec,
+					names[ev[i].type] ? (names[ev[i].type][ev[i].code] ?
names[ev[i].type][ev[i].code] : "?") : "?");
 			} else if (ev[i].type =3D=3D EV_MSC && (ev[i].code =3D=3D MSC_RAW |=
|
ev[i].code =3D=3D MSC_SCAN)) {
 				printf("Event: time %ld.%06ld, type %d (%s), code %d (%s), value %=
02x\n",
 					ev[i].time.tv_sec, ev[i].time.tv_usec, ev[i].type,
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
