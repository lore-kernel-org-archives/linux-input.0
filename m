From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] input: mt: Augment the event semantics documentation
Date: Wed, 20 May 2009 10:58:16 +0200
Message-ID: <4A13C628.7030402@euromail.se>
References: <1242593479-9238-1-git-send-email-rydberg@euromail.se> <20090520025957.GE17649@dtor-d630.eng.vmware.com> <4A13BC50.4010705@euromail.se> <200905200144.22454.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:59539 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753980AbZETI60 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 May 2009 04:58:26 -0400
In-Reply-To: <200905200144.22454.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Wednesday 20 May 2009 01:16:16 Henrik Rydberg wrote:
>> Dmitry Torokhov wrote:
>>> Hi Henrik,
>>>
>>> On Sun, May 17, 2009 at 10:51:19PM +0200, Henrik Rydberg wrote:
>>>> Through the collaboration to adapt the N-trig and Stantum HID
>>>> drivers to the MT protocol, some semantic clarifications to the
>>>> protocol have been made. This patch adds them to the MT documentat=
ion.
>>>>
>>>> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
>>>> Tested-by: St=C3=A9phane Chatty <chatty@enac.fr>
>>> I was wondering if the following changes would not make the text a =
bit
>>> better:
>> They do, thanks. I got more comments on the text, perhaps it is easi=
est
>> if I send an additional patch on top of this one, with your changes
>> included? It seems folding a patch is easier than to find out what
>> changes were made to the changes.
>>
>
> Sure, send it along.
>

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

diff --git a/Documentation/input/multi-touch-protocol.txt b/Documentati=
on/input/multi-touch-protocol.txt
index dd755c2..a12ea3b 100644
--- a/Documentation/input/multi-touch-protocol.txt
+++ b/Documentation/input/multi-touch-protocol.txt
@@ -21,9 +21,9 @@ packet. The end of a packet is marked by calling the =
input_mt_sync()
 function, which generates a SYN_MT_REPORT event. This instructs the
 receiver to accept the data for the current finger and prepare to rece=
ive
 another. The end of a multi-touch transfer is marked by calling the us=
ual
-input_sync() function. This instructs the receiver to perform actions =
based
-on the received packets, and prepare to receive a new set of finger
-packets.
+input_sync() function. This instructs the receiver to act upon events
+accumulated since last EV_SYN/SYN_REPORT and prepare to receive a new
+set of events/packets.

 A set of ABS_MT events with the desired properties is defined. The eve=
nts
 are divided into categories, to allow for partial implementation.  The
@@ -39,6 +39,19 @@ shapes grouped together by an ABS_MT_BLOB_ID. Finall=
y, for the few devices
 that currently support it, the ABS_MT_TRACKING_ID event may be used to
 report finger tracking from hardware [5].

+Here is what a minimal event sequence for a two-finger touch would loo=
k
+like:
+
+   ABS_MT_TOUCH_MAJOR
+   ABS_MT_POSITION_X
+   ABS_MT_POSITION_Y
+   SYN_MT_REPORT
+   ABS_MT_TOUCH_MAJOR
+   ABS_MT_POSITION_X
+   ABS_MT_POSITION_Y
+   SYN_MT_REPORT
+   SYN_REPORT
+

 Event Semantics
 ---------------
@@ -79,8 +92,8 @@ ABS_MT_ORIENTATION
 The orientation of the ellipse. The value should describe a signed qua=
rter
 of a revolution clockwise around the touch center. The signed value ra=
nge
 is arbitrary, but zero should be returned for a finger aligned along t=
he Y
-axis of the surface, something negative when twisted to the left, and
-something positive when twisted to the right. When completely aligned =
with
+axis of the surface, a negative value when finger is turned to the lef=
t, and
+a positive value when finger turned to the right. When completely alig=
ned with
 the X axis, the range max should be returned.  Orientation can be omit=
ted
 if the touching object is circular, or if the information is not avail=
able
 in the kernel driver. Partial orientation support is possible if the d=
evice
@@ -107,7 +120,7 @@ ABS_MT_BLOB_ID

 The BLOB_ID groups several packets together into one arbitrarily shape=
d
 contact. This is a low-level anonymous grouping, and should not be con=
fused
-with the high-level trackingID [5]. Most kernel drivers will not have =
this
+with the high-level trackingID [5]. Most kernel drivers will not have =
blob
 capability, and can safely omit the event.

 ABS_MT_TRACKING_ID
@@ -153,9 +166,9 @@ problem of assigning a set of anonymous fingers to =
a set of identified
 fingers is a euclidian bipartite matching problem at each event update=
, and
 relies on a sufficiently rapid update rate.

-There are a few devices that support trackingID in hardware. The X dri=
ver
-can make use of these native identifiers to reduce evdev bandwidth and=
 cpu
-usage.
+There are a few devices that support trackingID in hardware. User spac=
e can
+make use of these native identifiers to reduce bandwidth and cpu usage=
=2E
+

 Notes
 -----
@@ -176,7 +189,7 @@ could be used to derive tilt.
 time of writing (April 2009), the MT protocol is not yet merged, and t=
he
 prototype implements finger matching, basic mouse support and two-fing=
er
 scrolling. The project aims at improving the quality of current multi-=
touch
-functionality available in the synaptics X driver, and in addition
+functionality available in the Synaptics X driver, and in addition
 implement more advanced gestures.
 [4] See the section on event computation.
 [5] See the section on finger tracking.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
