From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 4/4] input - wacom: Support 2FGT in MT format
Date: Fri, 11 Feb 2011 21:47:42 +0100
Message-ID: <20110211204742.GD2287@polaris.bitmath.org>
References: <1297387983-13761-1-git-send-email-pinglinux@gmail.com>
 <20110211202010.GB2287@polaris.bitmath.org>
 <AANLkTimBPBDCBzw0fbDpLf8F7N_zG+ceKJAC9Li15g5P@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:44263 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758103Ab1BKUrb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Feb 2011 15:47:31 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimBPBDCBzw0fbDpLf8F7N_zG+ceKJAC9Li15g5P@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org

> >> +static int wacom_tpc_mt_touch(struct wacom_wac *wacom)
> >> +{
> >> + =A0 =A0 struct input_dev *input =3D wacom->input;
> >> + =A0 =A0 unsigned char *data =3D wacom->data;
> >> + =A0 =A0 int i;
> >> +
> >> + =A0 =A0 if (wacom->shared->stylus_in_proximity && !wacom->shared=
->touch_down)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> >
> > Seeing one case handled out of four possible always makes me nervou=
s.
>=20
> The above statement is to avoid going through the input_mt_slot and
> input_mt_report_slot_state routines without posting any meaningful
> events. I guess it could be considered as a performance enhancement?

It won't be posting events unless something changed.

> Which case makes you nervous? I'll take care of it ;).

Well, removing the logic above would suffice. :-)

> > So only false->true is possible here.
>=20
> Yeah, both are bools. What else can they take?

Only the transition false-to-true, that is.

> > What I can see from the patchset, only wacom_tpc_single_touch() wil=
l ever set touch_down to
> > false. Is that sufficient?
>=20
> No,  wacom_tpc_mt_touch can set touch_down to false too. When touch i=
s
> false, touch_down will be false. This happens when pen in prox or whe=
n
> both fingers are up.

Now, that is what cannot happen, because of the max() function.
=20
> Where else do you see it can be changed? tpc_pen() can not do that
> since it is on a different port, that's the reason of touch_down.

Thanks,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
