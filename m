From: Forest Bond <forest-B/PTSs0AgtP3p6jHtUh95NHuzzzSOjJt@public.gmane.org>
Subject: Re: [PATCH] Input: usbtouchscreen - initialize eGalax devices
Date: Fri, 31 Aug 2012 16:22:38 -0400
Message-ID: <20120831202238.GD24820@alittletooquiet.net>
References: <20120831192632.GA30202@core.coreip.homeip.net>
 <Pine.LNX.4.44L0.1208311555140.1328-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1208311555140.1328-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Daniel Ritz <daniel.ritz-OI3hZJvNYWs@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 31, 2012 at 04:04:58PM -0400, Alan Stern wrote:
> On Fri, 31 Aug 2012, Dmitry Torokhov wrote:
>=20
> > > > +		/* Send a "check active" packet. The response will be read
> > > > +		 * later and ignored. */
> > > > +		ret =3D usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
> > > > +				      0,
> > > > +				      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
> > > > +				      0, 0, "\x0A\x01A", 0,
> > >=20
> > >    You probably can't send data from the .const section (as well as o=
ff the
> > > stack) -- they can be DMA'ed and there'll be issues with cache consis=
tency on
> > > non-x86 arches. You should allocate the data with kmalloc().
> > >    Although, on the second thought, maybe I'm wrong in this case... n=
ot really
> > > sure about sending -- receiving (to the .data section) could certainl=
y be harmful...
> >=20
> > Hmm, do we actually send anything here? The "size" passed to
> > usb_control_msg() is 0 so I don't think we use that data at all...
>=20
> Good point.  Perhaps the 0 is a typo, in which case data does get sent
> and the buffer must be kmalloc'ed.  If the 0 is correct then the buffer
> should be NULL, not "\x0A\x01A" (and what's the purpose of the leading
> '0' in the second byte?).
>=20
> In addition, although the bRequestType specifies USB_DIR_OUT, the pipe
> value is usb_rcvctrlpipe.  Is this transfer meant to be IN or OUT?

The primary issue is that I'm a USB newb working on a deadline. ;)

My intention with this call was to send those three bytes out to the device=
=2E  I
tested this in Python using a libusb binding.  Oddly enough, the code as wr=
itten
does in fact work in the sense that the device talks to the driver correctly
after initialization (and without it it doesn't).

Anyway, thanks for the review and sorry for being a bonehead.  I'll resend.

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlBBHQ4ACgkQRO4fQQdv5Awb8wCgt8xr5Y1ykMNlNxpG+Mfwvzrl
UDUAniVqbaU5peACHNHTWWe5BCA9EQ/s
=kYkZ
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
