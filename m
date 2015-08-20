From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: PROBLEM: Missing events on thinkpad trackpoint buttons
Date: Thu, 20 Aug 2015 15:56:33 -0700
Message-ID: <20150820225633.GA12900@localhost>
References: <CAMmwwr-7fQcMa=DiiCO+GU7R1ZLgh6o2SD40q+gTPmcu=A_8uA@mail.gmail.com>
 <20150820213526.GA10980@localhost>
 <CAMmwwr-uYWurxAQnDdy9hVO-A3PGK92uSmHjYagp5eTXmPnZ_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36613 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbbHTW4g (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2015 18:56:36 -0400
Received: by pdbmi9 with SMTP id mi9so19050202pdb.3
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2015 15:56:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMmwwr-uYWurxAQnDdy9hVO-A3PGK92uSmHjYagp5eTXmPnZ_Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabor Balla <gaborwho@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Stephen Chandler Paul <thatslyude@gmail.com>, Nick Bowler <nbowler@draconx.ca>, Andrew Duggan <andrew.duggan@gmail.com>

On Fri, Aug 21, 2015 at 12:24:59AM +0200, Gabor Balla wrote:
> Hi Dmitry,
>=20
> On Thu, Aug 20, 2015 at 11:35 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Thu, Aug 20, 2015 at 10:50:27PM +0200, Gabor Balla wrote:
> [...]
> >> At some point a new PS/2 mode was introduced by Synaptics, called =
EWmode. This
> >> can be enabled by setting bit 2 of the mode byte. But previously t=
his bit was
> >> used for 'Disable Gesture', whatever that stands for, and it was r=
eused for
> >> selecting EWmode. Now if plain Wmode is selected, with bit 0 of th=
e mode byte,
> >> than disable gesture is on by default and bit 2 selects EWmode ins=
tead.
> >>
> >> Reference:
> >> http://www.synaptics.com/sites/default/files/511-000275-01_RevB.pd=
f
> [...]
> >> A quick fix follows:
> [...]
> >
> > It looks like the patch "direction" is reverted. Also, the presence=
 of
> > extended capabilities is not the indication that gesture mode shoul=
d not
> > be used: in relative mode bit 2 disables gesture reporting, in abso=
lute
> > mode it enables Extended W-mode.
> >
> > Does the patch below also work for you?
>=20
> If I'm not mistaken, the function of bit 2 depends on the state of W =
mode rather
> than absolute vs relative mode. From page 40 of the PDF:
>=20
> "If the Wmode bit is not set (0), then Gesture is reported and bit 2 =
refers to
> DisGest. (..) When this bit is 1, the Relative mode mouse packet repo=
rts the
> true physical button states, and the Absolute mode packet=E2=80=99s G=
esture bit always
> reports as zero."
>=20
> So it still has a meaning in absolute mode, when Wmode is disabled.
> I've tried the patch, it works, but I don't believe it's correct.

Yes, you are right, the bot does have meaning on Absolute mode, however
we want to give option to enable gestures only when in relative mode;
I've adjusted the description accordingly.

By the way, I re-read the spec and it says that when in Relative mode w=
e
should not touch W-mode bit at all so I adjusted it as well.

Thanks.

--=20
Dmitry

Input: synaptics - fix handling of disabling gesture mode

=46rom: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Bit 2 of the mode byte has dual meaning: it can disable reporting of
gestures when touchpad works in Relative mode or normal Absolute mode,
or it can enable so called Extended W-Mode when touchpad uses enhanced
Absolute mode (W-mode). The extended W-Mode confuses our driver and
causes missing button presses on some Thinkpads (x250, T450s). Given th=
at
we only want to give option of enabling gestures when touchpad works in
relative mode let's adjust synaptics_set_mode() so that we do not touch
that bit in absolute mode.

Also, according to the spec W mode "... bit is defined only in Absolute
mode on pads whose capExtended capability bit is set. In Relative mode =
and
in TouchPads without this capability, the bit is reserved and should be
left at 0.", so let's make sure we respect this requirement as well.

Reported-by: Nick Bowler <nbowler@draconx.ca>
Suggested-by: Gabor Balla <gaborwho@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/synaptics.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/syna=
ptics.c
index 28daca1..298f65d 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -519,14 +519,17 @@ static int synaptics_set_mode(struct psmouse *psm=
ouse)
 	struct synaptics_data *priv =3D psmouse->private;
=20
 	priv->mode =3D 0;
-	if (priv->absolute_mode)
+
+	if (priv->absolute_mode) {
 		priv->mode |=3D SYN_BIT_ABSOLUTE_MODE;
-	if (priv->disable_gesture)
+		if (SYN_CAP_EXTENDED(priv->capabilities))
+			priv->mode |=3D SYN_BIT_W_MODE;
+	} else if (priv->disable_gesture) {
 		priv->mode |=3D SYN_BIT_DISABLE_GESTURE;
+	}
+
 	if (psmouse->rate >=3D 80)
 		priv->mode |=3D SYN_BIT_HIGH_RATE;
-	if (SYN_CAP_EXTENDED(priv->capabilities))
-		priv->mode |=3D SYN_BIT_W_MODE;
=20
 	if (synaptics_mode_cmd(psmouse, priv->mode))
 		return -1;
@@ -1482,7 +1485,7 @@ static int __synaptics_init(struct psmouse *psmou=
se, bool absolute_mode)
 	}
=20
 	priv->absolute_mode =3D absolute_mode;
-	if (SYN_ID_DISGEST_SUPPORTED(priv->identity))
+	if (!absolute_mode && SYN_ID_DISGEST_SUPPORTED(priv->identity))
 		priv->disable_gesture =3D true;
=20
 	/*
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
