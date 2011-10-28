From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: BUG: hid-multitouch causes 10 second delay and error
Date: Fri, 28 Oct 2011 16:00:33 +0200
Message-ID: <20111028140033.GA2155@polaris.bitmath.org>
References: <20111026213705.GA32664@pequod.mess.org>
 <CAN+gG=E0sUd3WOzAuT1LOTz_U9jLrGg2Bq_jRjha8Dcptk6Zcw@mail.gmail.com>
 <4EA9466F.4000508@gmail.com>
 <20111028111605.GA23693@polaris.bitmath.org>
 <CAN+gG=EiJJR464q_eoJuJYpWOPMsk61W6sAKD18SdT+2tQfmQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:57701 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938Ab1J1OAh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Oct 2011 10:00:37 -0400
Received: from iph2.telenor.se (iph2.telenor.se [195.54.127.133])
	by smtprelay-h21.telenor.se (Postfix) with ESMTP id 0F5CDCC7C
	for <linux-input@vger.kernel.org>; Fri, 28 Oct 2011 16:00:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAN+gG=EiJJR464q_eoJuJYpWOPMsk61W6sAKD18SdT+2tQfmQA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Sean Young <sean@mess.org>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>

Hi Benjamin,

> well, most of the comments you in-lined addressed the fact that I
> tried to make the smallest patch possible.

Admittedly, HID_QUIRK_HIDINPUT_DROP makes the patch larger, but all
other comments make it smaller.

> > + =A0 =A0 =A0 /* This allows the driver to correctly support device=
s
> > + =A0 =A0 =A0 =A0* that emit events over several HID messages.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 hdev->quirks |=3D HID_QUIRK_NO_INPUT_SYNC;
> > +
> > =A0 =A0 =A0 =A0td->slots =3D kzalloc(td->maxcontacts * sizeof(struc=
t mt_slot),
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GFP_=
KERNEL);
> > =A0 =A0 =A0 =A0if (!td->slots) {
> >
> > In addition to not needing to be moved, this line introduces a race
> > with hid-input, since the device has already started when this line=
 is
> > executed.
>=20
> Well, we should use instead the new input_register callback to avoid
> any races.  I've got the patch, I've tested it, but I never sent
> it.... shame on me.

I guess it is moot now anyways.

> Except a comment in the second patch, I've tested it, and it worked
> without any surprises ;-)

The code still mainly follows your initial idea, so of course it
works. ;-)

> But I'm not sure we can rewind the tree as those patches are in
> for-next since nearly a month.
> I'll let you do the reverts, because on my local trees, it was quite
> difficult (and I'm still on a 3.0.x, so I can not test against
> for-next)

Ok, let's see how Jiri wants to play it, and I can prepare either a
rewind-and-patch or a revert-and-patch or a keep-and-patch set.

> > Subject: [PATCH 2/3] hid-input: Drop generic handling of hid-mt mul=
titouch
> > =A0devices
> >
> > The hid-mt devices are recognized by the ContactID field. This patc=
h
> > sets HID_QUIRK_MULTITOUCH accordingly, and leaves the device to be
> > picked up by any driver which intercepts the ContactID field.
> >
> > All in-tree hid-mt drivers intercept the ContactID, so this patch h=
as
> > no other effect than to skip generic handling of hid-mt devices.
>=20
> Please add here the link to
> http://www.microsoft.com/whdc/device/input/DigitizerDrvs_touch.mspx
> to keep the origin of this statement: ContactID means multitouch

Thanks, I will also make sure authorship is preserved where appropriate=
=2E

Cheers,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
