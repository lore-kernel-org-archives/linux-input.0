From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: mt: Augment the event semantics documentation
Date: Tue, 19 May 2009 19:59:57 -0700
Message-ID: <20090520025957.GE17649@dtor-d630.eng.vmware.com>
References: <1242593479-9238-1-git-send-email-rydberg@euromail.se> <1242593479-9238-2-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:30016 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbZETDAE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 May 2009 23:00:04 -0400
Content-Disposition: inline
In-Reply-To: <1242593479-9238-2-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Henrik,

On Sun, May 17, 2009 at 10:51:19PM +0200, Henrik Rydberg wrote:
> Through the collaboration to adapt the N-trig and Stantum HID
> drivers to the MT protocol, some semantic clarifications to the
> protocol have been made. This patch adds them to the MT documentation=
=2E
>=20
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> Tested-by: St=E9phane Chatty <chatty@enac.fr>

I was wondering if the following changes would not make the text a bit
better:

diff --git a/Documentation/input/multi-touch-protocol.txt b/Documentati=
on/input/multi-touch-protocol.txt
index dd755c2..12f98fb 100644
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
=20
 A set of ABS_MT events with the desired properties is defined. The eve=
nts
 are divided into categories, to allow for partial implementation.  The
@@ -79,8 +79,8 @@ ABS_MT_ORIENTATION
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
@@ -176,7 +176,7 @@ could be used to derive tilt.
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


--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
