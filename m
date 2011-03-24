From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v4] hid-multitouch: migrate 3M PCT touch screens to
 hid-multitouch
Date: Thu, 24 Mar 2011 12:46:14 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1103241244500.19969@pobox.suse.cz>
References: <AANLkTimFF3pgMMgOcEhYnRm5adgsCL5S6Hjkz+GFcpCT@mail.gmail.com> <1300811641-3327-1-git-send-email-benjamin.tissoires@enac.fr> <20110322165815.GA6706@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49797 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474Ab1CXLqR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Mar 2011 07:46:17 -0400
In-Reply-To: <20110322165815.GA6706@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Benjamin Tissoires <benjamin.tissoires@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 22 Mar 2011, Henrik Rydberg wrote:

> On Tue, Mar 22, 2011 at 05:34:01PM +0100, Benjamin Tissoires wrote:
> > This patch merges the hid-3m-pct driver into hid-multitouch.
> > To keep devices working the same way they used to with hid-3m-pct,
> > we need to add two signal/noise ratios for width and height.
> > We also need to work on width/height to send proper
> > ABS_MT_ORIENTATION flag.
> >=20
> > Importing 3M into hid-multitouch also solved the bug in which
> > devices handling width and height in their report descriptors
> > did not show ABS_MT_TOUCH_MAJOR and ABS_MT_TOUCH_MINOR.
> >=20
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
> > Reviewed-by: St=E9phane Chatty <chatty@enac.fr>
> > ---
> [...]
> > Henrik, do I still have your Reviewed-and-tested-by ?
>=20
> Yep, looks good. One more thing, though:
>=20
> > @@ -332,11 +351,18 @@ static void mt_emit_event(struct mt_device *t=
d, struct input_dev *input)
> >  		input_mt_report_slot_state(input, MT_TOOL_FINGER,
> >  			s->touch_state);
> >  		if (s->touch_state) {
> > +			/* this finger is on the screen */
> > +			int wide =3D (s->w > s->h);
> > +			/* divided by two to match visual scale of touch */
> > +			int major =3D max(s->w, s->h) >> 1;
> > +			int minor =3D min(s->w, s->h) >> 1;
>=20
> This scaling is most likely not correct for all devices. I went
> through a set of devices some time ago, running mtview on all of them=
,
> visually inspecting the touch size. Some were low by a factor of two,
> some were high by a factor of two. A confirmation that the other
> devices supported by this driver seem right would be good. If not, a
> quirk should probably be added here.

Okay, thanks a lot for the review. This can be handled later during=20
-rc phase if needed. So please proceed with confirming with the existin=
g=20
devices, and meanwhile I have applied the patch.

> > +
> >  			input_event(input, EV_ABS, ABS_MT_POSITION_X, s->x);
> >  			input_event(input, EV_ABS, ABS_MT_POSITION_Y, s->y);
> > +			input_event(input, EV_ABS, ABS_MT_ORIENTATION, wide);
> >  			input_event(input, EV_ABS, ABS_MT_PRESSURE, s->p);
> > -			input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, s->w);
> > -			input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, s->h);
> > +			input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
> > +			input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
> >  		}
> >  		s->seen_in_this_frame =3D false;

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
