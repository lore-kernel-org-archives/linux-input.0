From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [RFC] Input: MT - Include win8 support
Date: Sun, 6 May 2012 16:41:40 +0200
Message-ID: <CAN+gG=HqGmf77P6=7RMFT_Ez7Ysp4ZVJ6skfAoDcZ7JN1JtYnw@mail.gmail.com>
References: <1336230499-1450-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37551 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab2EFOtJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 6 May 2012 10:49:09 -0400
In-Reply-To: <1336230499-1450-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, chatty@enac.fr, peter.hutterer@who-t.net, chasedouglas@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Henrik,

On Sat, May 5, 2012 at 5:08 PM, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
> The newly released HID protocol for win8 input devices is capable of
> transmitting the same information found in the Apple HID and Linux MT
> protocols. In addition, it includes an extension useful for touch
> alignment. This patch completes the MT protocol with the
> ABS_MT_APPROACH_X/Y events, and documents how to map win8 devices.
>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> Hi all,
>
> In response to the win8 HID protocol and Benjamin's work on this, her=
e
> is a first draft of the needed extension to the MT protocol. I am
> cc:ing the usual suspects, as this will affect userland. Comments and
> criticism expected. :-)
>
> Cheers,
> Henrik
>
> =A0Documentation/input/multi-touch-protocol.txt | =A0 35 ++++++++++++=
+++++++++++++-
> =A0include/linux/input.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A04 ++-
> =A02 files changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/input/multi-touch-protocol.txt b/Documenta=
tion/input/multi-touch-protocol.txt
> index 543101c..504ca6d 100644
> --- a/Documentation/input/multi-touch-protocol.txt
> +++ b/Documentation/input/multi-touch-protocol.txt
> @@ -168,7 +168,9 @@ The TOUCH and WIDTH parameters have a geometrical=
 interpretation; imagine
> =A0looking through a window at someone gently holding a finger agains=
t the
> =A0glass. =A0You will see two regions, one inner region consisting of=
 the part
> =A0of the finger actually touching the glass, and one outer region fo=
rmed by
> -the perimeter of the finger. The diameter of the inner region is the
> +the perimeter of the finger. The center of the inner region is
> +ABS_MT_POSITION_X/Y. The center of the outer region may be different=
,
> +denoted by ABS_MT_APPROACH_X/Y. The diameter of the inner region is =
the
> =A0ABS_MT_TOUCH_MAJOR, the diameter of the outer region is
> =A0ABS_MT_WIDTH_MAJOR. Now imagine the person pressing the finger har=
der
> =A0against the glass. The inner region will increase, and in general,=
 the
> @@ -252,6 +254,9 @@ can distinguish between the two axis, but not (un=
iquely) any values in
> =A0between. In such cases, the range of ABS_MT_ORIENTATION should be =
[0, 1]
> =A0[4].
>
> +For devices capable of 360 degree orientation, the reported orientat=
ion
> +should be twice the given range.

Like Chase, I don't understand the necessity of that.

> +
> =A0ABS_MT_POSITION_X
>
> =A0The surface X coordinate of the center of the touching ellipse.
> @@ -260,6 +265,23 @@ ABS_MT_POSITION_Y
>
> =A0The surface Y coordinate of the center of the touching ellipse.
>
> +ABS_MT_APPROACH_X

Honestly, I think that ABS_MT_APPROACH_* is really confusing for
end-users (Xorg, Wayland, Qt, ...). I know that the explanation are
given, but looking at the mess we had with the use of the MT events
before it has been documented, I don't think this is the right term to
use. Without the doc, and with a little bit of bad faith, I would say
that approach refers to the T coordinate in Win8 doc (the approximate
position where the user wants to touch), whereas the POSITION_* is
more the center of the ellipse of the touch.... But it's the invert...
;-)

Thanks,
Benjamin

> +
> +The surface X coordinate of the center of the approaching ellipse. O=
mit if
> +the device cannot distinguish between the intended touching point an=
d the
> +center of the approaching contact.
> +
> +ABS_MT_APPROACH_Y
> +
> +The surface Y coordinate of the center of the approaching ellipse. O=
mit if
> +the device cannot distinguish between the intended touching point an=
d the
> +center of the approaching contact.
> +
> +The four position values can be used to separate the intended touch =
point
> +from the center of the approaching object. The difference also yield=
s an
> +approximation of the directed orientation of the approaching ellipse=
, with
> +ABS_MT_WIDTH_MAJOR pointing towards the touch center.
> +
> =A0ABS_MT_TOOL_TYPE
>
> =A0The type of approaching tool. A lot of kernel drivers cannot disti=
nguish
> @@ -305,6 +327,17 @@ The range of ABS_MT_ORIENTATION should be set to=
 [0, 1], to indicate that
> =A0the device can distinguish between a finger along the Y axis (0) a=
nd a
> =A0finger along the X axis (1).
>
> +For win8 devices with both T and C coordinates, the position mapping=
 is
> +
> + =A0 ABS_MT_POSITION_X :=3D T_X
> + =A0 ABS_MT_POSITION_Y :=3D T_Y
> + =A0 ABS_MT_APPROACH_X :=3D C_X
> + =A0 ABS_MT_APPROACH_X :=3D C_Y
> +
> +For win8 devices with Azimuth or Twist defined, the range max is the=
 value
> +for 90 degrees, and the orientation mapping is
> +
> + =A0 ABS_MT_ORIENTATION :=3D twist < 2 * max ? twist : twist - 4 * m=
ax
>
> =A0Finger Tracking
> =A0---------------
> diff --git a/include/linux/input.h b/include/linux/input.h
> index a816714..039234e 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -813,11 +813,13 @@ struct input_keymap_entry {
> =A0#define ABS_MT_TRACKING_ID =A0 =A0 0x39 =A0 =A0/* Unique ID of ini=
tiated contact */
> =A0#define ABS_MT_PRESSURE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x3a =A0 =A0=
/* Pressure on contact area */
> =A0#define ABS_MT_DISTANCE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x3b =A0 =A0=
/* Contact hover distance */
> +#define ABS_MT_APPROACH_X =A0 =A0 =A00x3c =A0 =A0/* Center X approac=
hing ellipse */
> +#define ABS_MT_APPROACH_Y =A0 =A0 =A00x3d =A0 =A0/* Center Y approac=
hing ellipse */
>
> =A0#ifdef __KERNEL__
> =A0/* Implementation details, userspace should not care about these *=
/
> =A0#define ABS_MT_FIRST =A0 =A0 =A0 =A0 =A0 ABS_MT_TOUCH_MAJOR
> -#define ABS_MT_LAST =A0 =A0 =A0 =A0 =A0 =A0ABS_MT_DISTANCE
> +#define ABS_MT_LAST =A0 =A0 =A0 =A0 =A0 =A0ABS_MT_APPROACH_Y
> =A0#endif
>
> =A0#define ABS_MAX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x3=
f
> --
> 1.7.10
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
