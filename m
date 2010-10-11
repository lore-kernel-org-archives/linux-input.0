From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] Input: synaptics - remove touches over button click
 area
Date: Mon, 11 Oct 2010 10:30:16 -0700
Message-ID: <20101011173015.GB27304@core.coreip.homeip.net>
References: <1286549880-32580-1-git-send-email-chase.douglas@canonical.com>
 <1286549880-32580-2-git-send-email-chase.douglas@canonical.com>
 <1286549880-32580-3-git-send-email-chase.douglas@canonical.com>
 <1286549880-32580-4-git-send-email-chase.douglas@canonical.com>
 <AANLkTi=QA5zgn=u39RyordViWw1CgpK9gy8kE_MdrpN3@mail.gmail.com>
 <s5h7hho3bau.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35532 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755593Ab0JKRa0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Oct 2010 13:30:26 -0400
Content-Disposition: inline
In-Reply-To: <s5h7hho3bau.wl%tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Chase Douglas <chase.douglas@canonical.com>, linux-input@vger.kernel.org, xorg-devel@lists.x.org, Andy Whitcroft <apw@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, linux-kernel@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>, Duncan McGreggor <duncan.mcgreggor@canonical.com>

On Mon, Oct 11, 2010 at 07:10:33PM +0200, Takashi Iwai wrote:
> At Mon, 11 Oct 2010 11:24:04 -0500,
> Chris Bagwell wrote:
> >=20
> > On Fri, Oct 8, 2010 at 9:58 AM, Chase Douglas
> > <chase.douglas@canonical.com> wrote:
> > > Now that we have proper multitouch support, we can handle integra=
ted
> > > buttons better. If we know the top of the buttons on the touchpad=
, we
> > > can ignore any touches that occur within the touchpad area while =
a
> > > button is clicked. It may be possible to get the button area by q=
uerying
> > > the device, but for now allow the user to manually set it.
> > >
> > > A note on why this works: the Synaptics touchpads have pseudo tou=
ch
> > > tracking. When two touches are on the touchpad, an MT touch packe=
t with
> > > just the X, Y, and pressure values is sent before a normal Synapt=
ics
> > > touch packet. When one touch is obviously in motion and the other=
 is
> > > stationary, the touchpad controller sends the touch in motion in =
the
> > > normal packet and the stationary touch in the MT packet. Single t=
ouch
> > > emulation is provided by the normal packet, so an action like cli=
cking
> > > a button and dragging with another finger still works as expected=
=2E
> > >
> > > Tested on a Dell Mini 1012 with synaptics_multitouch=3D1 and
> > > synaptics_button_thresh=3D4100.
> > >
> > > Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> > > ---
> > > =A0drivers/input/mouse/synaptics.c | =A0 16 +++++++++++++++-
> > > =A01 files changed, 15 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mous=
e/synaptics.c
> > > index 7289d88..e67778d 100644
> > > --- a/drivers/input/mouse/synaptics.c
> > > +++ b/drivers/input/mouse/synaptics.c
> > > @@ -49,6 +49,12 @@ module_param(synaptics_multitouch, bool, 0644)=
;
> > > =A0MODULE_PARM_DESC(synaptics_multitouch,
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Enable multitouch mode on Synapt=
ics devices");
> > >
> > > +static int synaptics_button_thresh =3D YMIN_NOMINAL + YMAX_NOMIN=
AL;
> > > +module_param(synaptics_button_thresh, int, 0644);
> > > +MODULE_PARM_DESC(synaptics_button_thres,
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Y coordinate threshold of integ=
rated buttons on Synaptics "
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"devices");
> > > +
> > > =A0/*************************************************************=
****************
> > > =A0* =A0 =A0 Stuff we need even when we do not want native Synapt=
ics support
> > > =A0**************************************************************=
**************/
> > > @@ -463,6 +469,10 @@ static void synaptics_parse_hw_state(unsigne=
d char buf[], struct synaptics_data
> > > =A0 =A0 =A0 =A0}
> > > =A0}
> > >
> > > +#define TOUCH_OVER_BUTTON(hw) (((hw).left || (hw).middle || (hw)=
=2Eright) && \
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(YMA=
X_NOMINAL + YMIN_NOMINAL - (hw).y > \
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 syn=
aptics_button_thresh))
> > > +
> > > =A0/*
> > > =A0* =A0called for each full received packet from the touchpad
> > > =A0*/
> > > @@ -477,7 +487,7 @@ static void synaptics_process_packet(struct p=
smouse *psmouse)
> > > =A0 =A0 =A0 =A0synaptics_parse_hw_state(psmouse->packet, priv, &h=
w);
> > >
> > > =A0 =A0 =A0 =A0if (SYN_MULTITOUCH(priv, &hw)) {
> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hw.z > 0) {
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hw.z > 0 && !TOUCH_OVER_BUTTON(=
hw)) {
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(d=
ev, ABS_MT_POSITION_X, hw.x);
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(d=
ev, ABS_MT_POSITION_Y,
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 YMAX_NOMINAL + YMIN_NOMINAL - hw.y);
> > > @@ -509,6 +519,10 @@ static void synaptics_process_packet(struct =
psmouse *psmouse)
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> > > =A0 =A0 =A0 =A0}
> > >
> > > + =A0 =A0 =A0 /* If touch occurs over depressed button, ignore it=
 */
> > > + =A0 =A0 =A0 if (TOUCH_OVER_BUTTON(hw))
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hw.z =3D 0;
> > > +
> > > =A0 =A0 =A0 =A0if (hw.z > 0) {
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->num_fingers++;
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0finger_width =3D 5;
> > > --
> > > 1.7.1
> > >
> > >
> >=20
> > I'm convinced now that clickpad style touchpads can't work without
> > multi-touch and something like logic in xf86-input-multitouch.
>=20
> Actually Clickpad works without multi-touch patch.  With my patches t=
o
> synaptics, it worked in some level.  There are many restrictions (e.g=
=2E
> pushing the button first then drag), though.
>=20

I am OK with devices not working perfectly with default/existing
drivers, but we should allow enough functionality (movement, primary
- left - click and so on) so that user can go through install and/or
upgrade of  userpsace component.

This also mean that we need to have userspace component available befor=
e
changing the behavior that will cause adverse effect for older setups.
Of course if we could avoid degrading older setups that would be even
better.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
