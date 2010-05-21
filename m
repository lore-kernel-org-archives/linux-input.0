From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 2/2] input: mt: Document the MT event slot protocol (rev3)
Date: Fri, 21 May 2010 09:30:06 -0700
Message-ID: <AANLkTikBWzgRmso0oQNXcTxeExdKZORXYbIwK9CcMl85@mail.gmail.com>
References: <1274457354-5570-1-git-send-email-rydberg@euromail.se>
	 <1274457354-5570-2-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46319 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758172Ab0EUQaH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 May 2010 12:30:07 -0400
In-Reply-To: <1274457354-5570-2-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <tissoire@cena.fr>, Stephane Chatty <chatty@enac.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Michael Poole <mdpoole@troilus.org>

Hi Henrik,

Thank you for your quick turnaround. Two minor comments in line.

Ping

On Fri, May 21, 2010 at 8:55 AM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> This patch adds documentation for the SYN_MT_SLOT event and gives

You mean ABS_SLOT instead of SYN_MT_SLOT, I guess.

> examples of how to use the event slot protocol.
>
> Reviewed-by: Ping Cheng <pingc@wacom.com>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> Revision 3 incorporates the following changes:
> =A0 =A0 =A0 =A0 - SYN_MT_SLOT changed to ABS_SLOT
> =A0 =A0 =A0 =A0 - Elaboration on the usage of tracking id
> =A0 =A0 =A0 =A0 - Minor typo, thanks to Fernando Carrijo
>
> =A0Documentation/input/multi-touch-protocol.txt | =A0204 ++++++++++++=
++++++--------
> =A01 files changed, 140 insertions(+), 64 deletions(-)
>
> diff --git a/Documentation/input/multi-touch-protocol.txt b/Documenta=
tion/input/multi-touch-protocol.txt
> index c0fc1c7..54fffe0 100644
> --- a/Documentation/input/multi-touch-protocol.txt
> +++ b/Documentation/input/multi-touch-protocol.txt
> @@ -6,31 +6,146 @@ Multi-touch (MT) Protocol
> =A0Introduction
> =A0------------
>
> -In order to utilize the full power of the new multi-touch devices, a=
 way to
> -report detailed finger data to user space is needed. This document
> -describes the multi-touch (MT) protocol which allows kernel drivers =
to
> -report details for an arbitrary number of fingers.
> +In order to utilize the full power of the new multi-touch and multi-=
user
> +devices, a way to report detailed data from multiple contacts, i.e.,
> +objects in direct contact with the device surface, is needed. =A0Thi=
s
> +document describes the multi-touch (MT) protocol which allows kernel
> +drivers to report details for an arbitrary number of contacts.
> +
> +The protocol is divided into two types, depending on the capabilitie=
s of the
> +hardware. For devices handling anonymous contacts (type A), the prot=
ocol
> +describes how to send the raw data for all contacts to the receiver.=
 For
> +devices capable of tracking identifiable contacts (type B), the prot=
ocol
> +describes how to send updates for individual contacts via event slot=
s.
> +
> +
> +Protocol Usage
> +--------------
> +
> +Contact details are sent sequentially as separate packets of ABS_MT
> +events. Only the ABS_MT events are recognized as part of a contact
> +packet. Since these events are ignored by current single-touch (ST)
> +applications, the MT protocol can be implemented on top of the ST pr=
otocol
> +in an existing driver.
> +
> +Drivers for type A devices mark the end of a packet by calling the
> +input_mt_sync() function, which generates a SYN_MT_REPORT event. Thi=
s
> +instructs the receiver to accept the data for the current contact an=
d
> +prepare to receive another. Drivers for type B devices mark the begi=
nning
> +of a packet by calling the input_mt_slot() function with a slot as
> +argument, which generates an ABS_SLOT event. This instructs the rece=
iver
> +to prepare for updates of the given slot.
> +
> +The end of a multi-touch transfer is marked by calling the usual
> +input_sync() function. This instructs the receiver to act upon event=
s
> +accumulated since last EV_SYN/SYN_REPORT and prepare to receive a ne=
w set
> +of events/packets.
> +
> +The main difference between the raw type A protocol and the higher l=
evel
> +type B slot protocol lies in the usage of identifiable contacts. The=
 slot
> +protocol requires the use of the ABS_MT_TRACKING_ID, either provided=
 by the
> +hardware of computed from the raw data [5].

"hardware or computed" instead of "hardware of computed "?

> +
> +For type A devices, the kernel driver should generate an arbitrary
> +enumeration of the set of anonymous contacts currently on the surfac=
e. The
> +order in which the packets appear in the event stream is not importa=
nt.
> +Event filtering and finger tracking is left to user space [3].
> +
> +For type B devices, the kernel driver should associate a slot with e=
ach
> +identified contact, and use that slot to propagate changes for the c=
ontact.
> +Creation, replacement and destruction of contacts is achieved by mod=
ifying
> +the ABS_MT_TRACKING_ID of the associated slot. =A0A tracking id with=
in the
> +specified value range is interpreted as a contact, all other values =
are
> +interpreted as an unused slot. =A0A tracking id not previously prese=
nt is
> +considered new, and a tracking id no longer present is considered re=
moved.
> +Since only changes are propagated, the full state of each initiated =
contact
> +has to reside in the receiving end. =A0Upon receiving an MT event, o=
ne simply
> +updates the appropriate attribute of the current slot.
> +
> +
> +Protocol Example A
> +------------------
> +
> +Here is what a minimal event sequence for a two-contact touch would =
look
> +like for a type A device:
> +
> + =A0 ABS_MT_POSITION_X x[0]
> + =A0 ABS_MT_POSITION_Y y[0]
> + =A0 SYN_MT_REPORT
> + =A0 ABS_MT_POSITION_X x[1]
> + =A0 ABS_MT_POSITION_Y y[1]
> + =A0 SYN_MT_REPORT
> + =A0 SYN_REPORT
>
> +The sequence after moving one of the contacts looks exactly the same=
; the
> +raw data for all present contacts are sent between every synchroniza=
tion
> +with SYN_REPORT.
>
> -Usage
> ------
> +Here is the sequence after lifting the first contact:
> +
> + =A0 ABS_MT_POSITION_X x[1]
> + =A0 ABS_MT_POSITION_Y y[1]
> + =A0 SYN_MT_REPORT
> + =A0 SYN_REPORT
> +
> +And here is the sequence after lifting the second contact:
> +
> + =A0 SYN_MT_REPORT
> + =A0 SYN_REPORT
> +
> +If the driver reports one of BTN_TOUCH or ABS_PRESSURE in addition t=
o the
> +ABS_MT events, the last SYN_MT_REPORT event may be omitted. Otherwis=
e, the
> +last SYN_REPORT will be dropped by the input core, resulting in no
> +zero-contact event reaching userland.
>
> -Anonymous finger details are sent sequentially as separate packets o=
f ABS
> -events. Only the ABS_MT events are recognized as part of a finger
> -packet. The end of a packet is marked by calling the input_mt_sync()
> -function, which generates a SYN_MT_REPORT event. This instructs the
> -receiver to accept the data for the current finger and prepare to re=
ceive
> -another. The end of a multi-touch transfer is marked by calling the =
usual
> -input_sync() function. This instructs the receiver to act upon event=
s
> -accumulated since last EV_SYN/SYN_REPORT and prepare to receive a ne=
w
> -set of events/packets.
> +
> +Protocol Example B
> +------------------
> +
> +Here is what a minimal event sequence for a two-contact touch would =
look
> +like for a type B device:
> +
> + =A0 ABS_SLOT 0
> + =A0 ABS_MT_TRACKING_ID 45
> + =A0 ABS_MT_POSITION_X x[0]
> + =A0 ABS_MT_POSITION_Y y[0]
> + =A0 ABS_SLOT 1
> + =A0 ABS_MT_TRACKING_ID 46
> + =A0 ABS_MT_POSITION_X x[1]
> + =A0 ABS_MT_POSITION_Y y[1]
> + =A0 SYN_REPORT
> +
> +Here is the sequence after moving contact 45 in the x direction:
> +
> + =A0 ABS_SLOT 0
> + =A0 ABS_MT_POSITION_X x[0]
> + =A0 SYN_REPORT
> +
> +Here is the sequence after lifting the contact in slot 0:
> +
> + =A0 ABS_MT_TRACKING_ID 0
> + =A0 SYN_REPORT
> +
> +The slot being modified is already 0, so the ABS_SLOT is omitted. =A0=
The
> +message removes the association of slot 0 with contact 45, thereby
> +destroying contact 45 and freeing slot 0 to be reused for another co=
ntact.
> +
> +Finally, here is the sequence after lifting the second contact:
> +
> + =A0 ABS_SLOT 1
> + =A0 ABS_MT_TRACKING_ID 0
> + =A0 SYN_REPORT
> +
> +
> +Event Usage
> +-----------
>
> =A0A set of ABS_MT events with the desired properties is defined. The=
 events
> =A0are divided into categories, to allow for partial implementation. =
=A0The
> =A0minimum set consists of ABS_MT_POSITION_X and ABS_MT_POSITION_Y, w=
hich
> -allows for multiple fingers to be tracked. =A0If the device supports=
 it, the
> +allows for multiple contacts to be tracked. =A0If the device support=
s it, the
> =A0ABS_MT_TOUCH_MAJOR and ABS_MT_WIDTH_MAJOR may be used to provide t=
he size
> -of the contact area and approaching finger, respectively.
> +of the contact area and approaching contact, respectively.
>
> =A0The TOUCH and WIDTH parameters have a geometrical interpretation; =
imagine
> =A0looking through a window at someone gently holding a finger agains=
t the
> @@ -41,56 +156,26 @@ ABS_MT_TOUCH_MAJOR, the diameter of the outer re=
gion is
> =A0ABS_MT_WIDTH_MAJOR. Now imagine the person pressing the finger har=
der
> =A0against the glass. The inner region will increase, and in general,=
 the
> =A0ratio ABS_MT_TOUCH_MAJOR / ABS_MT_WIDTH_MAJOR, which is always sma=
ller than
> -unity, is related to the finger pressure. For pressure-based devices=
,
> +unity, is related to the contact pressure. For pressure-based device=
s,
> =A0ABS_MT_PRESSURE may be used to provide the pressure on the contact=
 area
> =A0instead.
>
> -In addition to the MAJOR parameters, the oval shape of the finger ca=
n be
> +In addition to the MAJOR parameters, the oval shape of the contact c=
an be
> =A0described by adding the MINOR parameters, such that MAJOR and MINO=
R are the
> =A0major and minor axis of an ellipse. Finally, the orientation of th=
e oval
> =A0shape can be describe with the ORIENTATION parameter.
>
> =A0The ABS_MT_TOOL_TYPE may be used to specify whether the touching t=
ool is a
> -finger or a pen or something else. =A0Devices with more granular inf=
ormation
> +contact or a pen or something else. =A0Devices with more granular in=
formation
> =A0may specify general shapes as blobs, i.e., as a sequence of rectan=
gular
> =A0shapes grouped together by an ABS_MT_BLOB_ID. Finally, for the few=
 devices
> =A0that currently support it, the ABS_MT_TRACKING_ID event may be use=
d to
> -report finger tracking from hardware [5].
> +report contact tracking from hardware [5].
>
> -Here is what a minimal event sequence for a two-finger touch would l=
ook
> -like:
> -
> - =A0 ABS_MT_POSITION_X
> - =A0 ABS_MT_POSITION_Y
> - =A0 SYN_MT_REPORT
> - =A0 ABS_MT_POSITION_X
> - =A0 ABS_MT_POSITION_Y
> - =A0 SYN_MT_REPORT
> - =A0 SYN_REPORT
> -
> -Here is the sequence after lifting one of the fingers:
> -
> - =A0 ABS_MT_POSITION_X
> - =A0 ABS_MT_POSITION_Y
> - =A0 SYN_MT_REPORT
> - =A0 SYN_REPORT
> -
> -And here is the sequence after lifting the remaining finger:
> -
> - =A0 SYN_MT_REPORT
> - =A0 SYN_REPORT
> -
> -If the driver reports one of BTN_TOUCH or ABS_PRESSURE in addition t=
o the
> -ABS_MT events, the last SYN_MT_REPORT event may be omitted. Otherwis=
e, the
> -last SYN_REPORT will be dropped by the input core, resulting in no
> -zero-finger event reaching userland.
>
> =A0Event Semantics
> =A0---------------
>
> -The word "contact" is used to describe a tool which is in direct con=
tact
> -with the surface. A finger, a pen or a rubber all classify as contac=
ts.
> -
> =A0ABS_MT_TOUCH_MAJOR
>
> =A0The length of the major axis of the contact. The length should be =
given in
> @@ -192,20 +277,11 @@ finger along the X axis (1).
> =A0Finger Tracking
> =A0---------------
>
> -The kernel driver should generate an arbitrary enumeration of the se=
t of
> -anonymous contacts currently on the surface. The order in which the =
packets
> -appear in the event stream is not important.
> -
> =A0The process of finger tracking, i.e., to assign a unique trackingI=
D to each
> -initiated contact on the surface, is left to user space; preferably =
the
> -multi-touch X driver [3]. In that driver, the trackingID stays the s=
ame and
> -unique until the contact vanishes (when the finger leaves the surfac=
e). The
> -problem of assigning a set of anonymous fingers to a set of identifi=
ed
> -fingers is a euclidian bipartite matching problem at each event upda=
te, and
> -relies on a sufficiently rapid update rate.
> -
> -There are a few devices that support trackingID in hardware. User sp=
ace can
> -make use of these native identifiers to reduce bandwidth and cpu usa=
ge.
> +initiated contact on the surface, is a Euclidian Bipartite Matching
> +problem. =A0At each event synchronization, the set of actual contact=
s are
> +matched to the set of contacts from the previous synchronization. A =
full
> +implementation can be found in [3].
>
>
> =A0Gestures
> --
> 1.6.3.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
