From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 3/3] Input: synaptics - remove touches over button click area
Date: Mon, 11 Oct 2010 11:24:04 -0500
Message-ID: <AANLkTi=QA5zgn=u39RyordViWw1CgpK9gy8kE_MdrpN3@mail.gmail.com>
References: <1286549880-32580-1-git-send-email-chase.douglas@canonical.com>
	<1286549880-32580-2-git-send-email-chase.douglas@canonical.com>
	<1286549880-32580-3-git-send-email-chase.douglas@canonical.com>
	<1286549880-32580-4-git-send-email-chase.douglas@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60206 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755183Ab0JKQYF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Oct 2010 12:24:05 -0400
In-Reply-To: <1286549880-32580-4-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: linux-input@vger.kernel.org, xorg-devel@lists.x.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Takashi Iwai <tiwai@suse.de>, Andy Whitcroft <apw@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, linux-kernel@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>, Duncan McGreggor <duncan.mcgreggor@canonical.com>

On Fri, Oct 8, 2010 at 9:58 AM, Chase Douglas
<chase.douglas@canonical.com> wrote:
> Now that we have proper multitouch support, we can handle integrated
> buttons better. If we know the top of the buttons on the touchpad, we
> can ignore any touches that occur within the touchpad area while a
> button is clicked. It may be possible to get the button area by query=
ing
> the device, but for now allow the user to manually set it.
>
> A note on why this works: the Synaptics touchpads have pseudo touch
> tracking. When two touches are on the touchpad, an MT touch packet wi=
th
> just the X, Y, and pressure values is sent before a normal Synaptics
> touch packet. When one touch is obviously in motion and the other is
> stationary, the touchpad controller sends the touch in motion in the
> normal packet and the stationary touch in the MT packet. Single touch
> emulation is provided by the normal packet, so an action like clickin=
g
> a button and dragging with another finger still works as expected.
>
> Tested on a Dell Mini 1012 with synaptics_multitouch=3D1 and
> synaptics_button_thresh=3D4100.
>
> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> ---
> =A0drivers/input/mouse/synaptics.c | =A0 16 +++++++++++++++-
> =A01 files changed, 15 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/sy=
naptics.c
> index 7289d88..e67778d 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -49,6 +49,12 @@ module_param(synaptics_multitouch, bool, 0644);
> =A0MODULE_PARM_DESC(synaptics_multitouch,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Enable multitouch mode on Synaptics =
devices");
>
> +static int synaptics_button_thresh =3D YMIN_NOMINAL + YMAX_NOMINAL;
> +module_param(synaptics_button_thresh, int, 0644);
> +MODULE_PARM_DESC(synaptics_button_thres,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Y coordinate threshold of integrate=
d buttons on Synaptics "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"devices");
> +
> =A0/*****************************************************************=
************
> =A0* =A0 =A0 Stuff we need even when we do not want native Synaptics =
support
> =A0******************************************************************=
**********/
> @@ -463,6 +469,10 @@ static void synaptics_parse_hw_state(unsigned ch=
ar buf[], struct synaptics_data
> =A0 =A0 =A0 =A0}
> =A0}
>
> +#define TOUCH_OVER_BUTTON(hw) (((hw).left || (hw).middle || (hw).rig=
ht) && \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(YMAX_NO=
MINAL + YMIN_NOMINAL - (hw).y > \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 synapti=
cs_button_thresh))
> +
> =A0/*
> =A0* =A0called for each full received packet from the touchpad
> =A0*/
> @@ -477,7 +487,7 @@ static void synaptics_process_packet(struct psmou=
se *psmouse)
> =A0 =A0 =A0 =A0synaptics_parse_hw_state(psmouse->packet, priv, &hw);
>
> =A0 =A0 =A0 =A0if (SYN_MULTITOUCH(priv, &hw)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hw.z > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hw.z > 0 && !TOUCH_OVER_BUTTON(hw))=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(dev, =
ABS_MT_POSITION_X, hw.x);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(dev, =
ABS_MT_POSITION_Y,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 YMAX_NOMINAL + YMIN_NOMINAL - hw.y);
> @@ -509,6 +519,10 @@ static void synaptics_process_packet(struct psmo=
use *psmouse)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 /* If touch occurs over depressed button, ignore it */
> + =A0 =A0 =A0 if (TOUCH_OVER_BUTTON(hw))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hw.z =3D 0;
> +
> =A0 =A0 =A0 =A0if (hw.z > 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->num_fingers++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0finger_width =3D 5;
> --
> 1.7.1
>
>

I'm convinced now that clickpad style touchpads can't work without
multi-touch and something like logic in xf86-input-multitouch.  So now
I'd like to just consider how the MT-enabled touchpad interface can
best work with non-multitouch aware applications since thats what
users will need to deal with on fresh installs for a while.  I believe
the above approach of setting hw.z to zero would cause havoc on
non-multi-touch aware applications.

I see three main choices:

1) Do not report any button presses when in click area and report
ABS_X/ABS_Y based on first finger touch always.  Something like
xf86-input-synaptics RBCornerButton feature would be responsible for
button presses and can support left/middle/right concepts easily.

The downside is a mis-configured box will not be able to use GUI since
no button presses will work.  Also, there is no clear way to
auto-enable RBCornerButton-like features in user land in the same way
is being done in some patches that consider single button touchpads as
clickpads.

2.1) Send BTN_LEFT when in click area and ABS_X/ABS_Y tracks 1st
finger during 1 touch and 2nd finger during multi-touch.
xf86-input-synaptics needs change to detect left/middle/right based on
ABS_X/ABS_Y values right at report of BTN_LEFT for clickpads.
Touching drag finger before click finger breaks click-and-drag.

2.2) Send BTN_LEFT when in click area and ABS_X/ABS_Y tracks 1st
finger during 1 touch and middle point of 2 fingers during
multi-touch.  Touching drag finger before click finger breaks
click-and-drag and left/middle/right detection.

2.3) Send BTN_LEFT when in click area and ABS_X/ABS_Y indicates first
finger always. I'm sure this is behavior of synaptics touchpad before
we enable MT-packets.  Touching drag finger first will break
left/middle/right detection.  Touching click finger first breaks
click-and-drag.

3) A version of finger tracking in #2.1 could be done by detecting
which touch of two touches is in click area (as patch does) and
preferring non-click area data when it exists.  This has same issues
as #2.1 and has down side that we need to query hw or hard code click
areas.

Nothing ideal.  I'd probably pick #2.1 (or #3 if we can auto-detect
click area) since it at least allows consistent detecting of
left/middle/right.  I believe #2.1 is approach that bcm 5974 takes but
not sure from only quick review.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
