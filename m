From: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Subject: [PATCH] input: mt: Add MT Events reporting to evtest
Date: Tue, 19 May 2009 23:42:45 +0100
Message-ID: <45cc95260905191542x557a88ect8563eb25937b5dae@mail.gmail.com>
References: <45cc95260905191520w7d834124k2c8f970d82981809@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:59592 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026AbZESWnF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 May 2009 18:43:05 -0400
Received: by ewy24 with SMTP id 24so130647ewy.37
        for <linux-input@vger.kernel.org>; Tue, 19 May 2009 15:43:05 -0700 (PDT)
In-Reply-To: <45cc95260905191520w7d834124k2c8f970d82981809@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: USB list <linux-input@vger.kernel.org>

This patch adds new MT events reporting capabilities to evtest tool.
New multi-touch events were added by Henrik Rydberg in the kernel-2.6.3=
0-rc5.


=46rom: Mohamed-Ikbel Boulabiar <ikbel.boulabiar@enac.fr>
Tested-by: St=E9phane Chatty <chatty@enac.fr>



diff -rupN a/utils/evtest.c b/utils/evtest.c
--- a/utils/evtest.c =A0 =A02009-05-19 23:42:18.000000000 +0100
+++ b/utils/evtest.c =A0 =A02009-05-19 23:37:11.000000000 +0100
@@ -2,7 +2,7 @@
=A0* $Id$
=A0*
=A0* =A0Copyright (c) 1999-2000 Vojtech Pavlik
- *
+ * =A0 =A0 =A0 =A0 =A0 =A0 =A0 2009 Mohamed-Ikbel Boulabiar
=A0* =A0Event device test program
=A0*/

@@ -49,6 +49,21 @@ char *events[EV_MAX + 1] =3D {
=A0 =A0 =A0 =A0[EV_FF_STATUS] =3D "ForceFeedbackStatus",
=A0};

+int ev_max[EV_MAX + 1] =3D {
+ =A0 =A0 =A0 [EV_SYN] =3D 2, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 [EV_KEY] =3D KEY_MAX,
+ =A0 =A0 =A0 [EV_REL] =3D REL_MAX, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 [EV_ABS] =3D ABS_MAX,
+ =A0 =A0 =A0 [EV_MSC] =3D MSC_MAX, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 [EV_LED] =3D LED_MAX,
+ =A0 =A0 =A0 [EV_SND] =3D SND_MAX, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 [EV_REP] =3D REP_MAX,
+ =A0 =A0 =A0 [EV_FF] =3D FF_MAX, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 [EV_PWR] =3D -1,
+ =A0 =A0 =A0 [EV_FF_STATUS] =3D FF_STATUS_MAX,
+};
+
+char *syncs[3] =3D {
+ =A0 =A0 =A0 [SYN_REPORT] =3D "Report Sync", =A0 =A0 =A0 =A0 =A0 [SYN_=
CONFIG] =3D "Config Sync",
+ =A0 =A0 =A0 [SYN_MT_REPORT] =3D "MT Report Sync"
+};
+
+
=A0char *keys[KEY_MAX + 1] =3D {
=A0 =A0 =A0 =A0[0 ... KEY_MAX] =3D NULL,
=A0 =A0 =A0 =A0[KEY_RESERVED] =3D "Reserved", =A0 =A0 =A0 =A0 =A0 =A0[K=
EY_ESC] =3D "Esc",
@@ -239,19 +254,24 @@ char *relatives[REL_MAX + 1] =3D {

=A0char *absolutes[ABS_MAX + 1] =3D {
=A0 =A0 =A0 =A0[0 ... ABS_MAX] =3D NULL,
- =A0 =A0 =A0 [ABS_X] =3D "X", =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ABS_=
Y] =3D "Y",
- =A0 =A0 =A0 [ABS_Z] =3D "Z", =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ABS_=
RX] =3D "Rx",
- =A0 =A0 =A0 [ABS_RY] =3D "Ry", =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ABS_RZ=
] =3D "Rz",
- =A0 =A0 =A0 [ABS_THROTTLE] =3D "Throttle", =A0 =A0[ABS_RUDDER] =3D "R=
udder",
- =A0 =A0 =A0 [ABS_WHEEL] =3D "Wheel", =A0 =A0 =A0 =A0 =A0[ABS_GAS] =3D=
 "Gas",
- =A0 =A0 =A0 [ABS_BRAKE] =3D "Brake", =A0 =A0 =A0 =A0 =A0[ABS_HAT0X] =3D=
 "Hat0X",
- =A0 =A0 =A0 [ABS_HAT0Y] =3D "Hat0Y", =A0 =A0 =A0 =A0 =A0[ABS_HAT1X] =3D=
 "Hat1X",
- =A0 =A0 =A0 [ABS_HAT1Y] =3D "Hat1Y", =A0 =A0 =A0 =A0 =A0[ABS_HAT2X] =3D=
 "Hat2X",
- =A0 =A0 =A0 [ABS_HAT2Y] =3D "Hat2Y", =A0 =A0 =A0 =A0 =A0[ABS_HAT3X] =3D=
 "Hat3X",
- =A0 =A0 =A0 [ABS_HAT3Y] =3D "Hat 3Y", =A0 =A0 =A0 =A0 [ABS_PRESSURE] =
=3D "Pressure",
- =A0 =A0 =A0 [ABS_DISTANCE] =3D "Distance", =A0 =A0[ABS_TILT_X] =3D "X=
Tilt",
- =A0 =A0 =A0 [ABS_TILT_Y] =3D "YTilt", =A0 =A0 =A0 =A0 [ABS_TOOL_WIDTH=
] =3D "Tool Width",
- =A0 =A0 =A0 [ABS_VOLUME] =3D "Volume", =A0 =A0 =A0 =A0[ABS_MISC] =3D =
"Misc",
+ =A0 =A0 =A0 [ABS_X] =3D "X", =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0[ABS_Y] =3D "Y",
+ =A0 =A0 =A0 [ABS_Z] =3D "Z", =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0[ABS_RX] =3D "Rx",
+ =A0 =A0 =A0 [ABS_RY] =3D "Ry", =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0[ABS_RZ] =3D "Rz",
+ =A0 =A0 =A0 [ABS_THROTTLE] =3D "Throttle", =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0[ABS_RUDDER] =3D "Rudder",
+ =A0 =A0 =A0 [ABS_WHEEL] =3D "Wheel", =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0[ABS_GAS] =3D "Gas",
+ =A0 =A0 =A0 [ABS_BRAKE] =3D "Brake", =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0[ABS_HAT0X] =3D "Hat0X",
+ =A0 =A0 =A0 [ABS_HAT0Y] =3D "Hat0Y", =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0[ABS_HAT1X] =3D "Hat1X",
+ =A0 =A0 =A0 [ABS_HAT1Y] =3D "Hat1Y", =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0[ABS_HAT2X] =3D "Hat2X",
+ =A0 =A0 =A0 [ABS_HAT2Y] =3D "Hat2Y", =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0[ABS_HAT3X] =3D "Hat3X",
+ =A0 =A0 =A0 [ABS_HAT3Y] =3D "Hat 3Y", =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 [ABS_PRESSURE]
=3D "Pressure",
+ =A0 =A0 =A0 [ABS_DISTANCE] =3D "Distance", =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0[ABS_TILT_X] =3D "XTilt",
+ =A0 =A0 =A0 [ABS_TILT_Y] =3D "YTilt",
[ABS_TOOL_WIDTH] =3D "Tool Width",
+ =A0 =A0 =A0 [ABS_VOLUME] =3D "Volume", =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0[ABS_MISC] =3D "Misc",
+ =A0 =A0 =A0 [ABS_MT_TOUCH_MAJOR] =3D "MT Touch Major",
[ABS_MT_TOUCH_MINOR] =3D "MT
Touch Minor",
+ =A0 =A0 =A0 [ABS_MT_WIDTH_MAJOR] =3D "MT Major Width",
[ABS_MT_WIDTH_MINOR] =3D "MT
Minor Width",
+ =A0 =A0 =A0 [ABS_MT_POSITION_X] =3D "MT Position X",
[ABS_MT_POSITION_Y] =3D "MT Position Y",
+ =A0 =A0 =A0 [ABS_MT_TOOL_TYPE] =3D "MT Tool Type",
[ABS_MT_BLOB_ID] =3D "MT Blob Id",
+ =A0 =A0 =A0 [ABS_MT_ORIENTATION] =3D "MT Orientation",
=A0};

=A0char *misc[MSC_MAX + 1] =3D {
@@ -283,7 +303,7 @@ char *sounds[SND_MAX + 1] =3D {

=A0char **names[EV_MAX + 1] =3D {
=A0 =A0 =A0 =A0[0 ... EV_MAX] =3D NULL,
- =A0 =A0 =A0 [EV_SYN] =3D events, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0[EV_KEY] =3D keys,
+ =A0 =A0 =A0 [EV_SYN] =3D syncs, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 [EV_KEY] =3D keys,
=A0 =A0 =A0 =A0[EV_REL] =3D relatives, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 [EV_ABS] =3D absolutes,
=A0 =A0 =A0 =A0[EV_MSC] =3D misc, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0[EV_LED] =3D leds,
=A0 =A0 =A0 =A0[EV_SND] =3D sounds, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0[EV_REP] =3D repeats,
@@ -339,9 +359,9 @@ int main (int argc, char **argv)
=A0 =A0 =A0 =A0for (i =3D 0; i < EV_MAX; i++)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (test_bit(i, bit[0])) {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf(" =A0Event type %=
d (%s)\n", i, events[i] ?
events[i] : "?");
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!i) continue;
+// =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!i) continue;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ioctl(fd, EVIOCGBIT(i, K=
EY_MAX), bit[i]);
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < KEY_MAX=
; j++)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j <=3D ev_m=
ax[i]; j++)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (test=
_bit(j, bit[i])) {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0printf(" =A0 =A0Event code %d
(%s)\n", j, names[i] ? (names[i][j] ?
names[i][j] : "?") : "?");
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0if (i =3D=3D EV_ABS) {
@@ -369,7 +389,8 @@ int main (int argc, char **argv)

=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ev[i].type =3D=3D EV=
_SYN) {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("=
Event: time %ld.%06ld,
-------------- %s ------------\n",
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ev[i].time.tv_sec,
ev[i].time.tv_usec, ev[i].code ? "Config
Sync" : "Report Sync" );
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ev[i].time.tv_sec, ev[i].time.tv_usec,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 names[ev[i].type] ?
(names[ev[i].type][ev[i].code] ?
names[ev[i].type][ev[i].code] : "?") : "?");
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if (ev[i].type =3D=
=3D EV_MSC && (ev[i].code
=3D=3D MSC_RAW ||
ev[i].code =3D=3D MSC_SCAN)) {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("=
Event: time %ld.%06ld, type %d
(%s), code %d (%s), value %02x\n",
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0ev[i].time.tv_sec,
ev[i].time.tv_usec, ev[i].type,
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
