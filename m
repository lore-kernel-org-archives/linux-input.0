From: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
Subject: Re: [PATCH v2 2/5] platform/x86: intel-vbtn: Support separate press/release events
Date: Fri, 8 Dec 2017 21:33:29 +0100
Message-ID: <1632152.oGNe5Yk2uo@pebbles>
References: <20171109224436.16472-1-stefan.bruens@rwth-aachen.de> <024c7574-12f2-4708-9f90-1192856df401@rwthex-w2-a.rwth-ad.de> <20171110021555.GF9783@fury>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1852755.jDx2VezjqG";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out-1.itc.rwth-aachen.de ([134.130.5.46]:30515 "EHLO
        mail-out-1.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751474AbdLHUdh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 8 Dec 2017 15:33:37 -0500
In-Reply-To: <20171110021555.GF9783@fury>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andy Shevchenko <andy@infradead.org>, linux-kernel@vger.kernel.org

--nextPart1852755.jDx2VezjqG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, November 10, 2017 3:15:55 AM CET Darren Hart wrote:
> On Thu, Nov 09, 2017 at 11:44:33PM +0100, Stefan Br=FCns wrote:
> > Currently all key events use autorelease, but this forbids use as a
> > modifier key.
> >=20
> > As all event codes come in even/odd pairs, we can lookup the key type
> > (KE_KEY/KE_IGNORE) for the key up event corresponding to the currently
> > handled key down event. If the key up is ignored, we keep setting the
> > autorelease flag for the key down.
> >=20
> > Signed-off-by: Stefan Br=FCns <stefan.bruens@rwth-aachen.de>
>=20
> +Dmitry, curious for your take on this approach.

Any response would be appreciated. This is required to make Volume keys wor=
k=20
properly.
=20
> > ---
> >=20
> > Changes in v2:
> > - New patch, add support for seperate key up/down in intel-vbtn
> >=20
> >  drivers/platform/x86/intel-vbtn.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/intel-vbtn.c
> > b/drivers/platform/x86/intel-vbtn.c index ae55be91a64b..e3f6375af85c
> > 100644
> > --- a/drivers/platform/x86/intel-vbtn.c
> > +++ b/drivers/platform/x86/intel-vbtn.c
> > @@ -76,14 +76,27 @@ static void notify_handler(acpi_handle handle, u32
> > event, void *context)>=20
> >  {
> > =20
> >  	struct platform_device *device =3D context;
> >  	struct intel_vbtn_priv *priv =3D dev_get_drvdata(&device->dev);
> >=20
> > +	const struct key_entry *ke_rel;
> > +	bool autorelease;
> >=20
> >  	if (priv->wakeup_mode) {
> >  =09
> >  		if (sparse_keymap_entry_from_scancode(priv->input_dev, event)) {
> >  	=09
> >  			pm_wakeup_hard_event(&device->dev);
> >  			return;
> >  	=09
> >  		}
> >=20
> > -	} else if (sparse_keymap_report_event(priv->input_dev, event, 1, true=
))
> > {
> > -		return;
> > +	} else {
> > +		/* Use the fact press/release come in even/odd pairs */
> > +		if ((event & 1) && sparse_keymap_report_event(priv->input_dev,
> > +							      event, 0, false))
> > +			return;
> > +
> > +		ke_rel =3D sparse_keymap_entry_from_scancode(priv->input_dev,
> > +							   event | 1);
> > +		autorelease =3D !ke_rel || ke_rel->type =3D=3D KE_IGNORE;
> > +
> > +		if (sparse_keymap_report_event(priv->input_dev, event, 1,
> > +					       autorelease))
> > +			return;
> >=20
> >  	}
> >  	dev_dbg(&device->dev, "unknown event index 0x%x\n", event);
> > =20
> >  }


=2D-=20
Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
--nextPart1852755.jDx2VezjqG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSwWRWIpJbl0W4DemNvf0o9jP6qUwUCWir3GQAKCRBvf0o9jP6q
U+I6AJ0QXDLlzd+h9bCga/9/KU776W7i5gCfYIGsfRCuDv+fbDPjvTNj3gLiQho=
=LngH
-----END PGP SIGNATURE-----

--nextPart1852755.jDx2VezjqG--
