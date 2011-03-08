From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v2] [input-hid] Add hid-egalax driver to the unified
 hid-multitouch framework.
Date: Tue, 8 Mar 2011 10:14:34 +0100
Message-ID: <20110308091434.GA3282@polaris.bitmath.org>
References: <1299417912.9645.495.camel@itzy>
 <AANLkTimkYHPvn0PqcVyJv1rPTn3F7F8p3+3Y0-4F=MwW@mail.gmail.com>
 <1299564524.2306.18.camel@itzy>
 <20110308080414.GA2888@polaris.bitmath.org>
 <AANLkTimT9q8mo3uW0P7T0B=D4kkE83OB9ycgdJ_muZ2W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:47547 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750769Ab1CHJMe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Mar 2011 04:12:34 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimT9q8mo3uW0P7T0B=D4kkE83OB9ycgdJ_muZ2W@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Richard Nauber <richard.nauber@googlemail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>

> >> =A0struct mt_slot {
> >> =A0 =A0 =A0 __s32 x, y, p, w, h;
> >> @@ -63,6 +64,9 @@ struct mt_class {
> >> =A0 =A0 =A0 __s32 sn_move; =A0/* Signal/noise ratio for move event=
s */
> >> =A0 =A0 =A0 __s32 sn_pressure; =A0 =A0 =A0/* Signal/noise ratio fo=
r pressure events */
> >> =A0 =A0 =A0 __u8 maxcontacts;
> >> + =A0 =A0 __u8 override_logical_limits; =A0/* correct the reported=
 X/Y range */
> >> + =A0 =A0 __u32 logical_min[2];
> >> + =A0 =A0 __u32 logical_max[2];
> >
> > Please think about byte alignment here, keeping elements of the sam=
e
> > size together. Also, the override needs a specific name, given that=
 it
> > applies to the whole class, not just the x and y positions. Perhaps
> > the override should be triggered with a quirk instead?
>=20
> I'm not in favor of a quirk in this particular case: the information
> is already here: max > 0.

Only if min =3D=3D 0, which is far from always the case. And setting a
special value for a special hardware does what a quirk does, so maybe
it is a quirk after all.

Thanks,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
