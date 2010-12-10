From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: mt: Interface and MT_TOOL documentation updates
Date: Fri, 10 Dec 2010 10:13:06 -0800
Message-ID: <20101210181306.GB1630@core.coreip.homeip.net>
References: <1291929732-5989-1-git-send-email-rydberg@euromail.se>
 <AANLkTi=mqMY_VG=0RdN5O0fDh6wpTRb5Z59L6440hvX6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50803 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab0LJSNQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Dec 2010 13:13:16 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=mqMY_VG=0RdN5O0fDh6wpTRb5Z59L6440hvX6@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Dec 10, 2010 at 09:55:12AM -0800, Ping Cheng wrote:
> On Thu, Dec 9, 2010 at 1:22 PM, Henrik Rydberg <rydberg@euromail.se> =
wrote:
> > The recent input-mt interface changes together with
> > recent discussions about pen and touch and support
> > for legacy multitouch pads suggest that the documentation
> > on MT tool types be expanded. This patch adds references
> > to the new interface, and adds a section for MT_TOOL types,
> > in particular documenting the use of MT_TOOL_ENVELOPE.
> >
> > Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> > ---
> > =A0Documentation/input/multi-touch-protocol.txt | =A0 37 ++++++++++=
++++++++-------
> > =A01 files changed, 26 insertions(+), 11 deletions(-)
> >
> > diff --git a/Documentation/input/multi-touch-protocol.txt b/Documen=
tation/input/multi-touch-protocol.txt
> > index 351fab8..e190943 100644
> > --- a/Documentation/input/multi-touch-protocol.txt
> > +++ b/Documentation/input/multi-touch-protocol.txt
> > @@ -169,12 +169,14 @@ described by adding the MINOR parameters, suc=
h that MAJOR and MINOR are the
> > =A0major and minor axis of an ellipse. Finally, the orientation of =
the oval
> > =A0shape can be describe with the ORIENTATION parameter.
> >
> > +For type A devices, further specification of the touch shape is po=
ssible
> > +via ABS_MT_BLOB_ID.
> > +
> > =A0The ABS_MT_TOOL_TYPE may be used to specify whether the touching=
 tool is a
> > -contact or a pen or something else. =A0Devices with more granular =
information
> > -may specify general shapes as blobs, i.e., as a sequence of rectan=
gular
> > -shapes grouped together by an ABS_MT_BLOB_ID. Finally, for the few=
 devices
> > -that currently support it, the ABS_MT_TRACKING_ID event may be use=
d to
> > -report contact tracking from hardware [5].
> > +contact or a pen or something else. Finally, the ABS_MT_TRACKING_I=
D event
> > +may be used to track identified contacts over time [5]. In the typ=
e B
> > +protocol, the use of ABS_MT_TOOL_TYPE and ABS_MT_TRACKING_ID is im=
plicit
> > +via the input_mt_report_slot_state() function.
> >
> >
> > =A0Event Semantics
> > @@ -247,21 +249,34 @@ ABS_MT_TOOL_TYPE
> > =A0The type of approaching tool. A lot of kernel drivers cannot dis=
tinguish
> > =A0between different tool types, such as a finger or a pen. In such=
 cases, the
> > =A0event should be omitted. The protocol currently supports MT_TOOL=
_FINGER and
> > -MT_TOOL_PEN and MT_TOOL_ENVELOPE [2].
> > +MT_TOOL_PEN and MT_TOOL_ENVELOPE [2]. For type B devices, this eve=
nt is
> > +handled by input core, via the input_mt interface.
> > +
> > +- The MT_TOOL_FINGER type is the default, and represents a finger =
touch.
> > +
> > +- The MT_TOOL_PEN type represents a pen, and the list of related t=
ools is
> > +expected to grow with time.
> > +
> > +- The MT_TOOL_ENVELOPE type is used to indicate that the contact p=
osition
> > +is not well-defined, and is only used for legacy hardware. The rea=
l contact
> > +positions are to be found within the bounding rectangle formed by =
the
> > +envelope contact positions.
>=20
> Can we make MT_TOOL_ENVELOPE cover a bit more cases by:
>=20
> 1. Removing ", and is only used for legacy hardware";
> 2. Adding "Or the number of contacts inside the bounding rectangle is
> reported if hardware provides the number but not the real contact
> positions" to the end of the paragraph.

Are you saying that there is upcoming hardware models that do not repor=
t
individual contacts?

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
