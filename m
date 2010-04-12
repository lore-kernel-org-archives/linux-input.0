From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Support for the eGalax dual-touch panel
Date: Sun, 11 Apr 2010 20:18:56 -0700
Message-ID: <20100412031856.GD29292@core.coreip.homeip.net>
References: <20100410144308.9ABEE951F6@smtp.lii-enac.fr>
 <1270915489.3869.12.camel@lovely>
 <4E18664F-5C63-4A5B-AFC8-12CC9FD0FA3A@enac.fr>
 <alpine.LNX.2.00.1004102116370.8345@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59352 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363Ab0DLDTE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Apr 2010 23:19:04 -0400
Received: by gyg13 with SMTP id 13so2630359gyg.19
        for <linux-input@vger.kernel.org>; Sun, 11 Apr 2010 20:19:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1004102116370.8345@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>, Christoph Fritz <chf.fritz@googlemail.com>, linux-input@vger.kernel.org, linux@philmerk.de

On Sat, Apr 10, 2010 at 09:19:17PM +0200, Jiri Kosina wrote:
> On Sat, 10 Apr 2010, St=E9phane Chatty wrote:
>=20
> > > Am Samstag, den 10.04.2010, 16:43 +0200 schrieb Stephane Chatty:
> > > > Added support for the eGalax dual-touch panel, found on the Asu=
s EeePC
> > > > T101MT
> > >=20
> > > > +static void egalax_remove(struct hid_device *hdev)
> > > > +{
> > > > +	hid_hw_stop(hdev);
> > > > +	kfree(hid_get_drvdata(hdev));
> > > > +	hid_set_drvdata(hdev, NULL);
> > > > +}
> > >=20
> > > Why not using hid_hw_stop() instead of hid_set_drvdata()?
> > >=20
> >=20
> > Er, actually for a previous driver Dmitry suggested to add this lin=
e and=20
> > I did it without trying to understand :-)
>=20
> Currently no code should be relying on this, but it's always nice/saf=
e to=20
> do such initialization.=20
>=20
> Using 'if (!hdev)' to check whether hdev is valid/initialized or not=20
> should be always legitimate thing to do.

How can hdev be NULL? You did you mean hid_get_drvdata(hdev) !=3D NULL?
In general as a driver writer I'd expect data structiures passed to me
by the core (in this case hid core) be initialized and useable...

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
