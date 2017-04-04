From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v2 21/37] docs: input/multi-touch-protocol: convert it to ReST format
Date: Tue,  4 Apr 2017 09:22:21 -0300
Message-ID: <e297fc785d72be336c2e4a85705c24eedb16cf7d.1491308444.git.mchehab@s-opensource.com>
References: <cover.1491302719.git.mchehab@s-opensource.com>
 <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
 <8e64d13bfc6952bc9370593ddc556a539f589654.1491308444.git.mchehab@s-opensource.com>
 <781a89b410f25a2fb39d081d1ebd696317b6d2c2.1491308444.git.mchehab@s-opensource.com>
 <6800b2c4e8f67b699c22533f7574d380b37cb6d6.1491308444.git.mchehab@s-opensource.com>
 <9f6ae6ca543f4aa294afd000b7c8a8f49b2e8382.1491308444.git.mchehab@s-opensource.com>
 <b1d2cca45a3704e3cb8e2c9030d8c1044fee7720.1491308444.git.mchehab@s-opensource.com>
 <00ec4ed3ae000ee03c3fd725a5fadf33c1353d16.1491308444.git.mchehab@s-opensource.com>
 <e67db9bffc4a93a93b8559ed85d6e77045a99157.1491308444.git.mchehab@s-opensource.com>
 <9794ec8a2147f66e9e183f612fa7e834c9245dd9.1491308444.git.mchehab@s-opensource.com>
 <3bb792c867ec11d1e5b998b2d44e99fbd654ff95.1491308444.git.mchehab@s-opensource.com>
 <f3c0d0286d93d05416ce501ce3ef668d5fd9cc8f.1491308444.git.mchehab@s-opensource.com>
 <95dd0d035385dac833029e1db56846f02b3ae69c.1491308444.git.mchehab@s-opensource.com>
 <3efc02b3379dc908bfc0ade34185469295fee2bc.1491308444.git.mchehab@s-opensource.com>
 <9b1b818d7cde485713aced6b077f0e276a24bddd.1491308444.git.mchehab@s-opensource.com>
 <b46575603db084d1b32b83a4fc455551207f11ad.1491308444.git.mchehab@s-opensource.com>
 <8e0ef882aa235e4e6e758662dc434567266fb541.1491308444.git.mchehab@s-opensource.com>
 <daebe3de3017721f77bdf11680796042bd05fe53.1491308444.git.mchehab@s-opensource.com>
 <c4d96be24099f525b771369e2c0dd9bdfd376fa0.1491308444.git.mchehab@s-opensource.com>
 <23b1473a9202301d9fdb8f07564467e3091e9810.1491308444.git.mchehab@s-opensource.com>
 <8606760958a9fbf4cd032f66003d6074e0463584.1491308444.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <8606760958a9fbf4cd032f66003d6074e0463584.1491308444.git.mchehab@s-opensource.com>
In-Reply-To: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
References: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Henrik Rydberg <rydberg@bitmath.org>
List-Id: linux-input@vger.kernel.org

This file require minimum adjustments to be a valid ReST file.
Do it, in order to be able to parse it with Sphinx

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/multi-touch-protocol.txt | 196 +++++++++++++--------------
 1 file changed, 94 insertions(+), 102 deletions(-)

diff --git a/Documentation/input/multi-touch-protocol.txt b/Documentation/input/multi-touch-protocol.txt
index c51f1146f3bd..81775d7c1997 100644
--- a/Documentation/input/multi-touch-protocol.txt
+++ b/Documentation/input/multi-touch-protocol.txt
@@ -1,6 +1,10 @@
+.. include:: <isonum.txt>
+
+=========================
 Multi-touch (MT) Protocol
--------------------------
-	Copyright (C) 2009-2010	Henrik Rydberg <rydberg@euromail.se>
+=========================
+
+:Copyright: |copy| 2009-2010	Henrik Rydberg <rydberg@euromail.se>
 
 
 Introduction
@@ -47,12 +51,12 @@ The main difference between the stateless type A protocol and the stateful
 type B slot protocol lies in the usage of identifiable contacts to reduce
 the amount of data sent to userspace. The slot protocol requires the use of
 the ABS_MT_TRACKING_ID, either provided by the hardware or computed from
-the raw data [5].
+the raw data [#f5]_.
 
 For type A devices, the kernel driver should generate an arbitrary
 enumeration of the full set of anonymous contacts currently on the
 surface. The order in which the packets appear in the event stream is not
-important.  Event filtering and finger tracking is left to user space [3].
+important.  Event filtering and finger tracking is left to user space [#f3]_.
 
 For type B devices, the kernel driver should associate a slot with each
 identified contact, and use that slot to propagate changes for the contact.
@@ -86,7 +90,7 @@ Protocol Example A
 ------------------
 
 Here is what a minimal event sequence for a two-contact touch would look
-like for a type A device:
+like for a type A device::
 
    ABS_MT_POSITION_X x[0]
    ABS_MT_POSITION_Y y[0]
@@ -100,14 +104,14 @@ The sequence after moving one of the contacts looks exactly the same; the
 raw data for all present contacts are sent between every synchronization
 with SYN_REPORT.
 
-Here is the sequence after lifting the first contact:
+Here is the sequence after lifting the first contact::
 
    ABS_MT_POSITION_X x[1]
    ABS_MT_POSITION_Y y[1]
    SYN_MT_REPORT
    SYN_REPORT
 
-And here is the sequence after lifting the second contact:
+And here is the sequence after lifting the second contact::
 
    SYN_MT_REPORT
    SYN_REPORT
@@ -122,7 +126,7 @@ Protocol Example B
 ------------------
 
 Here is what a minimal event sequence for a two-contact touch would look
-like for a type B device:
+like for a type B device::
 
    ABS_MT_SLOT 0
    ABS_MT_TRACKING_ID 45
@@ -134,13 +138,13 @@ like for a type B device:
    ABS_MT_POSITION_Y y[1]
    SYN_REPORT
 
-Here is the sequence after moving contact 45 in the x direction:
+Here is the sequence after moving contact 45 in the x direction::
 
    ABS_MT_SLOT 0
    ABS_MT_POSITION_X x[0]
    SYN_REPORT
 
-Here is the sequence after lifting the contact in slot 0:
+Here is the sequence after lifting the contact in slot 0::
 
    ABS_MT_TRACKING_ID -1
    SYN_REPORT
@@ -149,7 +153,7 @@ The slot being modified is already 0, so the ABS_MT_SLOT is omitted.  The
 message removes the association of slot 0 with contact 45, thereby
 destroying contact 45 and freeing slot 0 to be reused for another contact.
 
-Finally, here is the sequence after lifting the second contact:
+Finally, here is the sequence after lifting the second contact::
 
    ABS_MT_SLOT 1
    ABS_MT_TRACKING_ID -1
@@ -181,6 +185,8 @@ ABS_MT_PRESSURE may be used to provide the pressure on the contact area
 instead. Devices capable of contact hovering can use ABS_MT_DISTANCE to
 indicate the distance between the contact and the surface.
 
+::
+
 
 	  Linux MT                               Win8
          __________                     _______________________
@@ -212,7 +218,7 @@ via ABS_MT_BLOB_ID.
 
 The ABS_MT_TOOL_TYPE may be used to specify whether the touching tool is a
 finger or a pen or something else. Finally, the ABS_MT_TRACKING_ID event
-may be used to track identified contacts over time [5].
+may be used to track identified contacts over time [#f5]_.
 
 In the type B protocol, ABS_MT_TOOL_TYPE and ABS_MT_TRACKING_ID are
 implicitly handled by input core; drivers should instead call
@@ -223,117 +229,103 @@ Event Semantics
 ---------------
 
 ABS_MT_TOUCH_MAJOR
-
-The length of the major axis of the contact. The length should be given in
-surface units. If the surface has an X times Y resolution, the largest
-possible value of ABS_MT_TOUCH_MAJOR is sqrt(X^2 + Y^2), the diagonal [4].
+    The length of the major axis of the contact. The length should be given in
+    surface units. If the surface has an X times Y resolution, the largest
+    possible value of ABS_MT_TOUCH_MAJOR is sqrt(X^2 + Y^2), the diagonal [#f4]_.
 
 ABS_MT_TOUCH_MINOR
-
-The length, in surface units, of the minor axis of the contact. If the
-contact is circular, this event can be omitted [4].
+    The length, in surface units, of the minor axis of the contact. If the
+    contact is circular, this event can be omitted [#f4]_.
 
 ABS_MT_WIDTH_MAJOR
-
-The length, in surface units, of the major axis of the approaching
-tool. This should be understood as the size of the tool itself. The
-orientation of the contact and the approaching tool are assumed to be the
-same [4].
+    The length, in surface units, of the major axis of the approaching
+    tool. This should be understood as the size of the tool itself. The
+    orientation of the contact and the approaching tool are assumed to be the
+    same [#f4]_.
 
 ABS_MT_WIDTH_MINOR
+    The length, in surface units, of the minor axis of the approaching
+    tool. Omit if circular [#f4]_.
 
-The length, in surface units, of the minor axis of the approaching
-tool. Omit if circular [4].
-
-The above four values can be used to derive additional information about
-the contact. The ratio ABS_MT_TOUCH_MAJOR / ABS_MT_WIDTH_MAJOR approximates
-the notion of pressure. The fingers of the hand and the palm all have
-different characteristic widths.
+    The above four values can be used to derive additional information about
+    the contact. The ratio ABS_MT_TOUCH_MAJOR / ABS_MT_WIDTH_MAJOR approximates
+    the notion of pressure. The fingers of the hand and the palm all have
+    different characteristic widths.
 
 ABS_MT_PRESSURE
-
-The pressure, in arbitrary units, on the contact area. May be used instead
-of TOUCH and WIDTH for pressure-based devices or any device with a spatial
-signal intensity distribution.
+    The pressure, in arbitrary units, on the contact area. May be used instead
+    of TOUCH and WIDTH for pressure-based devices or any device with a spatial
+    signal intensity distribution.
 
 ABS_MT_DISTANCE
-
-The distance, in surface units, between the contact and the surface. Zero
-distance means the contact is touching the surface. A positive number means
-the contact is hovering above the surface.
+    The distance, in surface units, between the contact and the surface. Zero
+    distance means the contact is touching the surface. A positive number means
+    the contact is hovering above the surface.
 
 ABS_MT_ORIENTATION
+    The orientation of the touching ellipse. The value should describe a signed
+    quarter of a revolution clockwise around the touch center. The signed value
+    range is arbitrary, but zero should be returned for an ellipse aligned with
+    the Y axis of the surface, a negative value when the ellipse is turned to
+    the left, and a positive value when the ellipse is turned to the
+    right. When completely aligned with the X axis, the range max should be
+    returned.
 
-The orientation of the touching ellipse. The value should describe a signed
-quarter of a revolution clockwise around the touch center. The signed value
-range is arbitrary, but zero should be returned for an ellipse aligned with
-the Y axis of the surface, a negative value when the ellipse is turned to
-the left, and a positive value when the ellipse is turned to the
-right. When completely aligned with the X axis, the range max should be
-returned.
+    Touch ellipsis are symmetrical by default. For devices capable of true 360
+    degree orientation, the reported orientation must exceed the range max to
+    indicate more than a quarter of a revolution. For an upside-down finger,
+    range max * 2 should be returned.
 
-Touch ellipsis are symmetrical by default. For devices capable of true 360
-degree orientation, the reported orientation must exceed the range max to
-indicate more than a quarter of a revolution. For an upside-down finger,
-range max * 2 should be returned.
-
-Orientation can be omitted if the touch area is circular, or if the
-information is not available in the kernel driver. Partial orientation
-support is possible if the device can distinguish between the two axis, but
-not (uniquely) any values in between. In such cases, the range of
-ABS_MT_ORIENTATION should be [0, 1] [4].
+    Orientation can be omitted if the touch area is circular, or if the
+    information is not available in the kernel driver. Partial orientation
+    support is possible if the device can distinguish between the two axis, but
+    not (uniquely) any values in between. In such cases, the range of
+    ABS_MT_ORIENTATION should be [0, 1] [#f4]_.
 
 ABS_MT_POSITION_X
-
-The surface X coordinate of the center of the touching ellipse.
+    The surface X coordinate of the center of the touching ellipse.
 
 ABS_MT_POSITION_Y
-
-The surface Y coordinate of the center of the touching ellipse.
+    The surface Y coordinate of the center of the touching ellipse.
 
 ABS_MT_TOOL_X
-
-The surface X coordinate of the center of the approaching tool. Omit if
-the device cannot distinguish between the intended touch point and the
-tool itself.
+    The surface X coordinate of the center of the approaching tool. Omit if
+    the device cannot distinguish between the intended touch point and the
+    tool itself.
 
 ABS_MT_TOOL_Y
+    The surface Y coordinate of the center of the approaching tool. Omit if the
+    device cannot distinguish between the intended touch point and the tool
+    itself.
 
-The surface Y coordinate of the center of the approaching tool. Omit if the
-device cannot distinguish between the intended touch point and the tool
-itself.
-
-The four position values can be used to separate the position of the touch
-from the position of the tool. If both positions are present, the major
-tool axis points towards the touch point [1]. Otherwise, the tool axes are
-aligned with the touch axes.
+    The four position values can be used to separate the position of the touch
+    from the position of the tool. If both positions are present, the major
+    tool axis points towards the touch point [#f1]_. Otherwise, the tool axes are
+    aligned with the touch axes.
 
 ABS_MT_TOOL_TYPE
-
-The type of approaching tool. A lot of kernel drivers cannot distinguish
-between different tool types, such as a finger or a pen. In such cases, the
-event should be omitted. The protocol currently supports MT_TOOL_FINGER,
-MT_TOOL_PEN, and MT_TOOL_PALM [2]. For type B devices, this event is handled
-by input core; drivers should instead use input_mt_report_slot_state().
-A contact's ABS_MT_TOOL_TYPE may change over time while still touching the
-device, because the firmware may not be able to determine which tool is being
-used when it first appears.
+    The type of approaching tool. A lot of kernel drivers cannot distinguish
+    between different tool types, such as a finger or a pen. In such cases, the
+    event should be omitted. The protocol currently supports MT_TOOL_FINGER,
+    MT_TOOL_PEN, and MT_TOOL_PALM [#f2]_. For type B devices, this event is
+    handled by input core; drivers should instead use
+    input_mt_report_slot_state(). A contact's ABS_MT_TOOL_TYPE may change over
+    time while still touching the device, because the firmware may not be able
+    to determine which tool is being used when it first appears.
 
 ABS_MT_BLOB_ID
-
-The BLOB_ID groups several packets together into one arbitrarily shaped
-contact. The sequence of points forms a polygon which defines the shape of
-the contact. This is a low-level anonymous grouping for type A devices, and
-should not be confused with the high-level trackingID [5]. Most type A
-devices do not have blob capability, so drivers can safely omit this event.
+    The BLOB_ID groups several packets together into one arbitrarily shaped
+    contact. The sequence of points forms a polygon which defines the shape of
+    the contact. This is a low-level anonymous grouping for type A devices, and
+    should not be confused with the high-level trackingID [#f5]_. Most type A
+    devices do not have blob capability, so drivers can safely omit this event.
 
 ABS_MT_TRACKING_ID
-
-The TRACKING_ID identifies an initiated contact throughout its life cycle
-[5]. The value range of the TRACKING_ID should be large enough to ensure
-unique identification of a contact maintained over an extended period of
-time. For type B devices, this event is handled by input core; drivers
-should instead use input_mt_report_slot_state().
+    The TRACKING_ID identifies an initiated contact throughout its life cycle
+    [#f5]_. The value range of the TRACKING_ID should be large enough to ensure
+    unique identification of a contact maintained over an extended period of
+    time. For type B devices, this event is handled by input core; drivers
+    should instead use input_mt_report_slot_state().
 
 
 Event Computation
@@ -346,7 +338,7 @@ this section gives recipes for how to compute certain events.
 For devices reporting contacts as rectangular shapes, signed orientation
 cannot be obtained. Assuming X and Y are the lengths of the sides of the
 touching rectangle, here is a simple formula that retains the most
-information possible:
+information possible::
 
    ABS_MT_TOUCH_MAJOR := max(X, Y)
    ABS_MT_TOUCH_MINOR := min(X, Y)
@@ -356,7 +348,7 @@ The range of ABS_MT_ORIENTATION should be set to [0, 1], to indicate that
 the device can distinguish between a finger along the Y axis (0) and a
 finger along the X axis (1).
 
-For win8 devices with both T and C coordinates, the position mapping is
+For win8 devices with both T and C coordinates, the position mapping is::
 
    ABS_MT_POSITION_X := T_X
    ABS_MT_POSITION_Y := T_Y
@@ -365,7 +357,7 @@ For win8 devices with both T and C coordinates, the position mapping is
 
 Unfortunately, there is not enough information to specify both the touching
 ellipse and the tool ellipse, so one has to resort to approximations.  One
-simple scheme, which is compatible with earlier usage, is:
+simple scheme, which is compatible with earlier usage, is::
 
    ABS_MT_TOUCH_MAJOR := min(X, Y)
    ABS_MT_TOUCH_MINOR := <not used>
@@ -386,7 +378,7 @@ The process of finger tracking, i.e., to assign a unique trackingID to each
 initiated contact on the surface, is a Euclidian Bipartite Matching
 problem.  At each event synchronization, the set of actual contacts is
 matched to the set of contacts from the previous synchronization. A full
-implementation can be found in [3].
+implementation can be found in [#f3]_.
 
 
 Gestures
@@ -411,8 +403,8 @@ subsequent events of the same type refer to different fingers.
 For example usage of the type A protocol, see the bcm5974 driver. For
 example usage of the type B protocol, see the hid-egalax driver.
 
-[1] Also, the difference (TOOL_X - POSITION_X) can be used to model tilt.
-[2] The list can of course be extended.
-[3] The mtdev project: http://bitmath.org/code/mtdev/.
-[4] See the section on event computation.
-[5] See the section on finger tracking.
+.. [#f1] Also, the difference (TOOL_X - POSITION_X) can be used to model tilt.
+.. [#f2] The list can of course be extended.
+.. [#f3] The mtdev project: http://bitmath.org/code/mtdev/.
+.. [#f4] See the section on event computation.
+.. [#f5] See the section on finger tracking.
-- 
2.9.3

