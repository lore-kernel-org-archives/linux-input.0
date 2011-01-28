From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 1/2] hid-multitouch: work on default classes and renaming
 of classes
Date: Fri, 28 Jan 2011 19:43:26 +0100
Message-ID: <20110128184326.GB2553@polaris.bitmath.org>
References: <1296230680-2871-1-git-send-email-benjamin.tissoires@enac.fr>
 <20110128171852.GA2586@polaris.bitmath.org>
 <AANLkTimB2bA9JuhNox8UCsHkGEGyUQLBPnELBR0-=-ie@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:32931 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753199Ab1A1Smh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jan 2011 13:42:37 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimB2bA9JuhNox8UCsHkGEGyUQLBPnELBR0-=-ie@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> >> This patch introduce also MT_CLS_DUAL_DEFAULT which has the same p=
urpose
> >> than MT_CLS_DEFAULT, but for dual touch panels.
> >
> > But it is used anywhere?
>=20
> Hi Henrik,
>=20
> In it's current form, no. I often rely on it to make a quick patch
> (just adding the ids in hid-ids, hid-core and hid-multitouch) to test
> a new (dual touch) device. I thought it would be useful to be
> mainstream.

I see. However, it is just as easy to keep as a local patch. Quite
generally, there really is a difference between what we do in our
computers and what ends up in mainline, and it is almost always for a
good reason.

> >> @@ -65,10 +66,11 @@ struct mt_class {
> >> =A0};
> >>
> >> =A0/* classes of device behavior */
> >> -#define MT_CLS_DEFAULT =A0 =A0 =A0 1
> >> -#define MT_CLS_DUAL1 2
> >> -#define MT_CLS_DUAL2 3
> >> -#define MT_CLS_CYPRESS =A0 =A0 =A0 4
> >> +#define MT_CLS_DEFAULT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 1
> >> +#define MT_CLS_DUAL_DEFAULT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02
> >> +#define MT_CLS_DUAL_INRANGE_CONTACTID =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A03
> >> +#define MT_CLS_DUAL_INRANGE_CONTACTNUMBER =A0 =A04
> >> +#define MT_CLS_CYPRESS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 10
> >
> > There is no need to change the numbering for unchanged names.
>=20
> I just wanted to keep device-specific at the end of the list. Hence
> the 10 to keep a little space between generic and devices:
> MT_CLS_DUAL_CONFIDENCE_CONTACT* are coming...

It is very often the case that one would like to modify something to
keep to a certain aesthetic classification or idea, but there is a
very good reason not to do it. In order to maintain more than one
branch, for instance a stable tree and several distributions, having
simple patches makes a huge difference in maintenance burden. Not to
mention how hard it can be to merge trees with unrelated changes in
them. So please, keep patches short, sweet and to the point.

Thanks,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
