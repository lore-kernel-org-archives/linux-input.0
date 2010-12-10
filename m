From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] input: mt: Interface and MT_TOOL documentation updates
Date: Fri, 10 Dec 2010 09:55:12 -0800
Message-ID: <AANLkTi=mqMY_VG=0RdN5O0fDh6wpTRb5Z59L6440hvX6@mail.gmail.com>
References: <1291929732-5989-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291929732-5989-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Dec 9, 2010 at 1:22 PM, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
> The recent input-mt interface changes together with
> recent discussions about pen and touch and support
> for legacy multitouch pads suggest that the documentation
> on MT tool types be expanded. This patch adds references
> to the new interface, and adds a section for MT_TOOL types,
> in particular documenting the use of MT_TOOL_ENVELOPE.
>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> =A0Documentation/input/multi-touch-protocol.txt | =A0 37 ++++++++++++=
++++++-------
> =A01 files changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/input/multi-touch-protocol.txt b/Documenta=
tion/input/multi-touch-protocol.txt
> index 351fab8..e190943 100644
> --- a/Documentation/input/multi-touch-protocol.txt
> +++ b/Documentation/input/multi-touch-protocol.txt
> @@ -169,12 +169,14 @@ described by adding the MINOR parameters, such =
that MAJOR and MINOR are the
> =A0major and minor axis of an ellipse. Finally, the orientation of th=
e oval
> =A0shape can be describe with the ORIENTATION parameter.
>
> +For type A devices, further specification of the touch shape is poss=
ible
> +via ABS_MT_BLOB_ID.
> +
> =A0The ABS_MT_TOOL_TYPE may be used to specify whether the touching t=
ool is a
> -contact or a pen or something else. =A0Devices with more granular in=
formation
> -may specify general shapes as blobs, i.e., as a sequence of rectangu=
lar
> -shapes grouped together by an ABS_MT_BLOB_ID. Finally, for the few d=
evices
> -that currently support it, the ABS_MT_TRACKING_ID event may be used =
to
> -report contact tracking from hardware [5].
> +contact or a pen or something else. Finally, the ABS_MT_TRACKING_ID =
event
> +may be used to track identified contacts over time [5]. In the type =
B
> +protocol, the use of ABS_MT_TOOL_TYPE and ABS_MT_TRACKING_ID is impl=
icit
> +via the input_mt_report_slot_state() function.
>
>
> =A0Event Semantics
> @@ -247,21 +249,34 @@ ABS_MT_TOOL_TYPE
> =A0The type of approaching tool. A lot of kernel drivers cannot disti=
nguish
> =A0between different tool types, such as a finger or a pen. In such c=
ases, the
> =A0event should be omitted. The protocol currently supports MT_TOOL_F=
INGER and
> -MT_TOOL_PEN and MT_TOOL_ENVELOPE [2].
> +MT_TOOL_PEN and MT_TOOL_ENVELOPE [2]. For type B devices, this event=
 is
> +handled by input core, via the input_mt interface.
> +
> +- The MT_TOOL_FINGER type is the default, and represents a finger to=
uch.
> +
> +- The MT_TOOL_PEN type represents a pen, and the list of related too=
ls is
> +expected to grow with time.
> +
> +- The MT_TOOL_ENVELOPE type is used to indicate that the contact pos=
ition
> +is not well-defined, and is only used for legacy hardware. The real =
contact
> +positions are to be found within the bounding rectangle formed by th=
e
> +envelope contact positions.

Can we make MT_TOOL_ENVELOPE cover a bit more cases by:

1. Removing ", and is only used for legacy hardware";
2. Adding "Or the number of contacts inside the bounding rectangle is
reported if hardware provides the number but not the real contact
positions" to the end of the paragraph.

Ping

> =A0ABS_MT_BLOB_ID
>
> =A0The BLOB_ID groups several packets together into one arbitrarily s=
haped
> -contact. This is a low-level anonymous grouping for type A devices, =
and
> +contact. The sequence of points forms a polygon which defines the sh=
ape of
> +the contact. This is a low-level anonymous grouping for type A devic=
es, and
> =A0should not be confused with the high-level trackingID [5]. Most ty=
pe A
> =A0devices do not have blob capability, so drivers can safely omit th=
is event.
>
> =A0ABS_MT_TRACKING_ID
>
> =A0The TRACKING_ID identifies an initiated contact throughout its lif=
e cycle
> -[5]. This event is mandatory for type B devices. The value range of =
the
> -TRACKING_ID should be large enough to ensure unique identification o=
f a
> -contact maintained over an extended period of time.
> +[5]. The value range of the TRACKING_ID should be large enough to en=
sure
> +unique identification of a contact maintained over an extended perio=
d of
> +time. For type B devices, this event is handled by input core, via t=
he
> +input_mt interface.
>
>
> =A0Event Computation
> @@ -321,6 +336,6 @@ difference between the contact position and the a=
pproaching tool position
> =A0could be used to derive tilt.
> =A0[2] ABS_MT_ENVELOPE contacts represent an envelope of the contacts=
 rather
> =A0than the actual contacts. Used with older, not fully MT capable, d=
evices.
> -[3] Multitouch X driver project: http://bitmath.org/code/multitouch/=
=2E
> +[3] The mtdev project: http://bitmath.org/code/mtdev/.
> =A0[4] See the section on event computation.
> =A0[5] See the section on finger tracking.
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
