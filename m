From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH] input: mt: Augment the event semantics documentation
Date: Sun, 17 May 2009 22:51:19 +0200
Message-ID: <1242593479-9238-2-git-send-email-rydberg@euromail.se>
References: <1242593479-9238-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:37623 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754241AbZEQU6W (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 May 2009 16:58:22 -0400
In-Reply-To: <1242593479-9238-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

Through the collaboration to adapt the N-trig and Stantum HID
drivers to the MT protocol, some semantic clarifications to the
protocol have been made. This patch adds them to the MT documentation.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
Tested-by: St=C3=A9phane Chatty <chatty@enac.fr>
---
 Documentation/input/multi-touch-protocol.txt |   88 ++++++++++++++++++=
+-------
 1 files changed, 65 insertions(+), 23 deletions(-)

diff --git a/Documentation/input/multi-touch-protocol.txt b/Documentati=
on/input/multi-touch-protocol.txt
index 9f09557..dd755c2 100644
--- a/Documentation/input/multi-touch-protocol.txt
+++ b/Documentation/input/multi-touch-protocol.txt
@@ -18,8 +18,12 @@ Usage
 Anonymous finger details are sent sequentially as separate packets of =
ABS
 events. Only the ABS_MT events are recognized as part of a finger
 packet. The end of a packet is marked by calling the input_mt_sync()
-function, which generates a SYN_MT_REPORT event. The end of multi-touc=
h
-transfer is marked by calling the usual input_sync() function.
+function, which generates a SYN_MT_REPORT event. This instructs the
+receiver to accept the data for the current finger and prepare to rece=
ive
+another. The end of a multi-touch transfer is marked by calling the us=
ual
+input_sync() function. This instructs the receiver to perform actions =
based
+on the received packets, and prepare to receive a new set of finger
+packets.
=20
 A set of ABS_MT events with the desired properties is defined. The eve=
nts
 are divided into categories, to allow for partial implementation.  The
@@ -27,11 +31,13 @@ minimum set consists of ABS_MT_TOUCH_MAJOR, ABS_MT_=
POSITION_X and
 ABS_MT_POSITION_Y, which allows for multiple fingers to be tracked.  I=
f the
 device supports it, the ABS_MT_WIDTH_MAJOR may be used to provide the =
size
 of the approaching finger. Anisotropy and direction may be specified w=
ith
-ABS_MT_TOUCH_MINOR, ABS_MT_WIDTH_MINOR and ABS_MT_ORIENTATION. Devices=
 with
-more granular information may specify general shapes as blobs, i.e., a=
s a
-sequence of rectangular shapes grouped together by an
-ABS_MT_BLOB_ID. Finally, the ABS_MT_TOOL_TYPE may be used to specify
-whether the touching tool is a finger or a pen or something else.
+ABS_MT_TOUCH_MINOR, ABS_MT_WIDTH_MINOR and ABS_MT_ORIENTATION.  The
+ABS_MT_TOOL_TYPE may be used to specify whether the touching tool is a
+finger or a pen or something else.  Devices with more granular informa=
tion
+may specify general shapes as blobs, i.e., as a sequence of rectangula=
r
+shapes grouped together by an ABS_MT_BLOB_ID. Finally, for the few dev=
ices
+that currently support it, the ABS_MT_TRACKING_ID event may be used to
+report finger tracking from hardware [5].
=20
=20
 Event Semantics
@@ -44,24 +50,24 @@ ABS_MT_TOUCH_MAJOR
=20
 The length of the major axis of the contact. The length should be give=
n in
 surface units. If the surface has an X times Y resolution, the largest
-possible value of ABS_MT_TOUCH_MAJOR is sqrt(X^2 + Y^2), the diagonal.
+possible value of ABS_MT_TOUCH_MAJOR is sqrt(X^2 + Y^2), the diagonal =
[4].
=20
 ABS_MT_TOUCH_MINOR
=20
 The length, in surface units, of the minor axis of the contact. If the
-contact is circular, this event can be omitted.
+contact is circular, this event can be omitted [4].
=20
 ABS_MT_WIDTH_MAJOR
=20
 The length, in surface units, of the major axis of the approaching
 tool. This should be understood as the size of the tool itself. The
 orientation of the contact and the approaching tool are assumed to be =
the
-same.
+same [4].
=20
 ABS_MT_WIDTH_MINOR
=20
 The length, in surface units, of the minor axis of the approaching
-tool. Omit if circular.
+tool. Omit if circular [4].
=20
 The above four values can be used to derive additional information abo=
ut
 the contact. The ratio ABS_MT_TOUCH_MAJOR / ABS_MT_WIDTH_MAJOR approxi=
mates
@@ -70,14 +76,17 @@ different characteristic widths [1].
=20
 ABS_MT_ORIENTATION
=20
-The orientation of the ellipse. The value should describe half a revol=
ution
-clockwise around the touch center. The scale of the value is arbitrary=
, but
-zero should be returned for an ellipse aligned along the Y axis of the
-surface. As an example, an index finger placed straight onto the axis =
could
-return zero orientation, something negative when twisted to the left, =
and
-something positive when twisted to the right. This value can be omitte=
d if
-the touching object is circular, or if the information is not availabl=
e in
-the kernel driver.
+The orientation of the ellipse. The value should describe a signed qua=
rter
+of a revolution clockwise around the touch center. The signed value ra=
nge
+is arbitrary, but zero should be returned for a finger aligned along t=
he Y
+axis of the surface, something negative when twisted to the left, and
+something positive when twisted to the right. When completely aligned =
with
+the X axis, the range max should be returned.  Orientation can be omit=
ted
+if the touching object is circular, or if the information is not avail=
able
+in the kernel driver. Partial orientation support is possible if the d=
evice
+can distinguish between the two axis, but not (uniquely) any values in
+between. In such cases, the range of ABS_MT_ORIENTATION should be [0, =
1]
+[4].
=20
 ABS_MT_POSITION_X
=20
@@ -98,8 +107,35 @@ ABS_MT_BLOB_ID
=20
 The BLOB_ID groups several packets together into one arbitrarily shape=
d
 contact. This is a low-level anonymous grouping, and should not be con=
fused
-with the high-level contactID, explained below. Most kernel drivers wi=
ll
-not have this capability, and can safely omit the event.
+with the high-level trackingID [5]. Most kernel drivers will not have =
this
+capability, and can safely omit the event.
+
+ABS_MT_TRACKING_ID
+
+The TRACKING_ID identifies an initiated contact throughout its life cy=
cle
+[5]. There are currently only a few devices that support it, so this e=
vent
+should normally be omitted.
+
+
+Event Computation
+-----------------
+
+The flora of different hardware unavoidably leads to some devices fitt=
ing
+better to the MT protocol than others. To simplify and unify the mappi=
ng,
+this section gives recipes for how to compute certain events.
+
+For devices reporting contacts as rectangular shapes, signed orientati=
on
+cannot be obtained. Assuming X and Y are the lengths of the sides of t=
he
+touching rectangle, here is a simple formula that retains the most
+information possible:
+
+   ABS_MT_TOUCH_MAJOR :=3D max(X, Y)
+   ABS_MT_TOUCH_MINOR :=3D min(X, Y)
+   ABS_MT_ORIENTATION :=3D bool(X > Y)
+
+The range of ABS_MT_ORIENTATION should be set to [0, 1], to indicate t=
hat
+the device can distinguish between a finger along the Y axis (0) and a
+finger along the X axis (1).
=20
=20
 Finger Tracking
@@ -109,14 +145,18 @@ The kernel driver should generate an arbitrary en=
umeration of the set of
 anonymous contacts currently on the surface. The order in which the pa=
ckets
 appear in the event stream is not important.
=20
-The process of finger tracking, i.e., to assign a unique contactID to =
each
+The process of finger tracking, i.e., to assign a unique trackingID to=
 each
 initiated contact on the surface, is left to user space; preferably th=
e
-multi-touch X driver [3]. In that driver, the contactID stays the same=
 and
+multi-touch X driver [3]. In that driver, the trackingID stays the sam=
e and
 unique until the contact vanishes (when the finger leaves the surface)=
=2E The
 problem of assigning a set of anonymous fingers to a set of identified
 fingers is a euclidian bipartite matching problem at each event update=
, and
 relies on a sufficiently rapid update rate.
=20
+There are a few devices that support trackingID in hardware. The X dri=
ver
+can make use of these native identifiers to reduce evdev bandwidth and=
 cpu
+usage.
+
 Notes
 -----
=20
@@ -138,3 +178,5 @@ prototype implements finger matching, basic mouse s=
upport and two-finger
 scrolling. The project aims at improving the quality of current multi-=
touch
 functionality available in the synaptics X driver, and in addition
 implement more advanced gestures.
+[4] See the section on event computation.
+[5] See the section on finger tracking.
--=20
1.5.6.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
