From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Support for the eGalax dual-touch panel
Date: Sat, 10 Apr 2010 21:19:17 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004102116370.8345@pobox.suse.cz>
References: <20100410144308.9ABEE951F6@smtp.lii-enac.fr> <1270915489.3869.12.camel@lovely> <4E18664F-5C63-4A5B-AFC8-12CC9FD0FA3A@enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:54491 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050Ab0DJTTT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Apr 2010 15:19:19 -0400
In-Reply-To: <4E18664F-5C63-4A5B-AFC8-12CC9FD0FA3A@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Christoph Fritz <chf.fritz@googlemail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux@philmerk.de

On Sat, 10 Apr 2010, St=E9phane Chatty wrote:

> > Am Samstag, den 10.04.2010, 16:43 +0200 schrieb Stephane Chatty:
> > > Added support for the eGalax dual-touch panel, found on the Asus =
EeePC
> > > T101MT
> >=20
> > > +static void egalax_remove(struct hid_device *hdev)
> > > +{
> > > +	hid_hw_stop(hdev);
> > > +	kfree(hid_get_drvdata(hdev));
> > > +	hid_set_drvdata(hdev, NULL);
> > > +}
> >=20
> > Why not using hid_hw_stop() instead of hid_set_drvdata()?
> >=20
>=20
> Er, actually for a previous driver Dmitry suggested to add this line =
and=20
> I did it without trying to understand :-)

Currently no code should be relying on this, but it's always nice/safe =
to=20
do such initialization.=20

Using 'if (!hdev)' to check whether hdev is valid/initialized or not=20
should be always legitimate thing to do.

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
