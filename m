From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCHv3 3/3] Add sixaxis plugin: USB pairing and LEDs settings
Date: Thu, 9 Jun 2011 15:57:31 +0200
Message-ID: <20110609155731.bd2c5a8b.ospite@studenti.unina.it>
References: <1307538557-9287-1-git-send-email-ospite@studenti.unina.it>
	<1307538557-9287-4-git-send-email-ospite@studenti.unina.it>
	<20110608175251.GC20343@piper>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__9_Jun_2011_15_57_31_+0200_vNat+MQ1GVySrAsm"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:41609 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758122Ab1FIN5r (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Jun 2011 09:57:47 -0400
In-Reply-To: <20110608175251.GC20343@piper>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, "Pascal A . Brisset" <pascal44973@pabr.org>, Marcin Tolysz <tolysz@gmail.com>, Christian Birchinger <joker@netswarm.net>, Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>, Mikko Virkkila <virkkila@kapsi.fi>, Simon Wood <simon@mungewell.org>

--Signature=_Thu__9_Jun_2011_15_57_31_+0200_vNat+MQ1GVySrAsm
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Jun 2011 14:52:51 -0300
Vinicius Costa Gomes <vinicius.gomes@openbossa.org> wrote:

> Hi Antonio,
>=20
> On 15:09 Wed 08 Jun, Antonio Ospite wrote:
> > Add a plugin which handles the connection of a Sixaxis device, when a
> > new hidraw device is connected the plugin:
> >  - Filters udev events, and select the Sixaxis device
> >  - Sets LEDs to match the joystick system number (for USB and BT)
> >  - Sets the Master bluetooth address in the Sixaxis (USB pairing)
> >  - Adds the device to the database of the current default
> >    adapter (BT association)
>=20
> Just a few (mostly cosmetic) comments.
>

OK, it's the classic indentation/alignment issue, I used spaces for
_alignment_ not indentation (not very consistently, I have to admit),
but I am just going to comply to BLueZ style, we don't need any more
time wasted on these debates :)

And I am going to keep lines shorter than 78 chars as requested.
Basically this is what checkpatch.pl from linux complains about.

About the double newlines, I used them to separate logical sections of
the code:
 0. Preamble (license header, includes, defines, etc.)
 1. BT association
 2. Usb cable pairing
 3. Led setting (That's also why some defines were here, I considered
    them "local" to this section)
 4. Udev loop
 5. Plugin framework stuff

They are more visible when the editor folds functions bodies, but I
have no problem about removing them if you like so.

Some further comments below, I left out all the parts where I agree and
I have nothing more to say.

> > +{
> > +	DBusConnection *conn;
> > +	sdp_record_t *rec;
> > +	struct btd_device *device;
> > +	bdaddr_t src, dst;
> > +	char srcaddr[18];
> > +	int ret =3D 0;
>=20
> The most common idiom is to call this kind of variable 'err'.
>

OK on that too, just for the records I tend to use 'err' when I
check !=3D 0 [like in if (err) {...] I use 'ret' when I check for < 0.

[...]
> > +	buf =3D calloc(len, sizeof(*buf));
>=20
> Usually in BlueZ code we try to use the allocations function provided by
> GLib, g_malloc0() in this case.
>

[...]
> > +
> > +	address =3D calloc(BDADDR_STR_SIZE, sizeof(*address));
>=20
> Same here.
>

[...]
> > +		error("%s:%s() Parsing the bt address failed", __FILE__, __func__);
> > +		return FALSE;
> > +	}
> > +
> > +	report =3D malloc(8);
>=20
> g_malloc0()?
>=20

Would you mind if I keep these three stdlib ones in? I use this code
verbatim in another program which does not link against Glib.

> > +{
> > +	struct udev_device *udevice;
> > +
> > +	udevice =3D udev_monitor_receive_device(monitor);
> > +	if (udevice =3D=3D NULL)
> > +		goto out;
> > +	if (g_strcmp0(udev_device_get_action(udevice), "add") !=3D 0) {
> > +		udev_device_unref(udevice);
> > +		goto out;
> > +	}
> > +
> > +	g_timeout_add_seconds(1, (GSourceFunc) device_event_idle, udevice);
>=20
> Just a question: why is this delay between finding the device and plug'in=
g it
> is needed? Perhaps a short comment explaining why it is needed would be n=
ice.
>=20

/* Give UDEV some time to load kernel modules */
I guess this is the main reason, fact is that without that it does not
always work: we may get a null ID_USB_DRIVER.

> Cheers,
> --=20
> Vinicius
>=20

Thanks for the review,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Thu__9_Jun_2011_15_57_31_+0200_vNat+MQ1GVySrAsm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3w0UsACgkQ5xr2akVTsAELKgCfSL7Oosx4aB2PWb8nRiQa1B8S
/pcAoJhRv4+aLHFwevmoPN8SIzrO9Y+O
=0Cyp
-----END PGP SIGNATURE-----

--Signature=_Thu__9_Jun_2011_15_57_31_+0200_vNat+MQ1GVySrAsm--
