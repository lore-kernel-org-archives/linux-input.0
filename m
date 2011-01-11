From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC v3 0/5] hid-multitouch: a first step towards multitouch
 unification
Date: Tue, 11 Jan 2011 11:37:23 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101111136220.26685@pobox.suse.cz>
References: <1294425762-29730-1-git-send-email-benjamin.tissoires@enac.fr> <alpine.LNX.2.00.1101072355200.26685@pobox.suse.cz> <alpine.LNX.2.00.1101072359450.26685@pobox.suse.cz> <alpine.LNX.2.00.1101082224130.26685@pobox.suse.cz>
 <alpine.LNX.2.00.1101101931200.26685@pobox.suse.cz> <AANLkTi=BoBPZ-KxAn9NSECVv+7FB9DBTu5nchS3TN-rT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52477 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755608Ab1AKKhZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Jan 2011 05:37:25 -0500
In-Reply-To: <AANLkTi=BoBPZ-KxAn9NSECVv+7FB9DBTu5nchS3TN-rT@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Stephane Chatty <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 10 Jan 2011, Benjamin Tissoires wrote:

> > we are now slowly aproaching the point in time in which I would lik=
e=20
> > to prepare second round of HID tree merge with Linus.
> >
> > Have you finished your testing / fixing the minor issues raised by =
Henrik
> > please?
> >
> > Thanks,
> >
>=20
> Hi Jiri,
>=20
> I'm still waiting for one tester (the generaltouch one).
>=20
> I hope he will be able to test it tomorrow (he told me he was busy un=
til=20
> today).
>
>=20
> I'm sure the driver works for two of the three devices (we have them
> at the lab). The generaltouch is less important as there is a conflic=
t
> in the naming of the vendorID/deviceID:
> GeneralTouch sells two different devices with the same deviceID, and
> the older is handled by usbtouchscreen.
> St=E9phane explained to me today that people that want to use multito=
uch
> features will have to do some manipulations to enable it.
>
> I'll send the diff between v3-v4 tomorrow if you want or before if yo=
u
> really need.

Good, thanks for the update.

We still have the whole development cycle to fix potential problems in =
the=20
driver found later by the testers, but the skeleton should rather reall=
y=20
be there in a few days from now, otherwise we'll have to postpone it fo=
r=20
=2E39.

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
