From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 1/4] hid-multitouch: Auto detection of maxcontacts
Date: Wed, 9 Mar 2011 14:16:44 +0100
Message-ID: <20110309131643.GA10925@polaris.bitmath.org>
References: <1299601979-4871-1-git-send-email-benjamin.tissoires@enac.fr>
 <1299601979-4871-2-git-send-email-benjamin.tissoires@enac.fr>
 <20110309112255.GA9020@polaris.bitmath.org>
 <AANLkTimU0dt_XJVvnD+-JxEhVXMb0pzar0kip56zs11u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:47203 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932144Ab1CINOK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Mar 2011 08:14:10 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimU0dt_XJVvnD+-JxEhVXMb0pzar0kip56zs11u@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> > if (td->mtclass->maxcontacts > td->maxcontacts)
> >
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* check if the maxconta=
cts is given by the class */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->maxcontacts =3D td->=
mtclass->maxcontacts;
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (!td->maxcontacts)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->maxcontacts =3D MT_C=
ONTACTMAX_DEFAULT;
> >
> > this part can be then dropped
>=20
> Well, it works the way you are suggesting. BTW this let the corner
> case where someone adds a device (MT_CLS) that does not send the
> contact max and does not initialize the .maxcontact field.

Yes, the patch changes the current, perfectly reasonable assumption
that maxcontact is set. If that change is removed from the patch, it
makes the logic simpler, without changing the semantics of the current
code.

> >> + =A0 =A0 td->slots =3D kzalloc(td->maxcontacts * sizeof(struct mt=
_slot),
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERN=
EL);
> >> +
> >
> > Don't we have a race problem here? =A0It seems the device is starte=
d at
> > this point, so I worry that events will be handled when slots is st=
ill
> > NULL.
>=20
> I tried again yesterday: if I put this line above the hid_hw_start ->
> kernel oops at first touch.
> The point is that hid_hw_start calls hid_connect that do the actual
> calls to input_mapping and feature_mapping.

Yes, that is clear, but the urbs are running, and as fas as I can see,
irqs can be delivered to mt_event(). Minute time window, testing is
not likely to hit this. Adding a test for completed initialization in
mt_event() would make sure.

Oh, and there is no test for failed memory allocation.

Thanks.
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
