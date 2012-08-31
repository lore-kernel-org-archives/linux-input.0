From: Forest Bond <forest-B/PTSs0AgtP3p6jHtUh95NHuzzzSOjJt@public.gmane.org>
Subject: Re: [PATCH] Input: usbtouchscreen - initialize eGalax devices
Date: Fri, 31 Aug 2012 19:23:38 -0400
Message-ID: <20120831232338.GF24820@alittletooquiet.net>
References: <20120831192632.GA30202@core.coreip.homeip.net>
 <Pine.LNX.4.44L0.1208311555140.1328-100000@iolanthe.rowland.org>
 <20120831225353.GE24820@alittletooquiet.net>
 <20120831231047.GA22142@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120831231047.GA22142-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Daniel Ritz <daniel.ritz-OI3hZJvNYWs@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Fri, Aug 31, 2012 at 04:10:47PM -0700, Dmitry Torokhov wrote:
> On Fri, Aug 31, 2012 at 06:53:53PM -0400, Forest Bond wrote:
> > Hi,
> >=20
> > On Fri, Aug 31, 2012 at 04:04:58PM -0400, Alan Stern wrote:
> > > On Fri, 31 Aug 2012, Dmitry Torokhov wrote:
> > >=20
> > > > > > +		/* Send a "check active" packet. The response will be read
> > > > > > +		 * later and ignored. */
> > > > > > +		ret =3D usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
> > > > > > +				      0,
> > > > > > +				      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
> > > > > > +				      0, 0, "\x0A\x01A", 0,
> > > > >=20
> > > > >    You probably can't send data from the .const section (as well =
as off the
> > > > > stack) -- they can be DMA'ed and there'll be issues with cache co=
nsistency on
> > > > > non-x86 arches. You should allocate the data with kmalloc().
> > > > >    Although, on the second thought, maybe I'm wrong in this case.=
=2E. not really
> > > > > sure about sending -- receiving (to the .data section) could cert=
ainly be harmful...
> > > >=20
> > > > Hmm, do we actually send anything here? The "size" passed to
> > > > usb_control_msg() is 0 so I don't think we use that data at all...
> > >=20
> > > Good point.  Perhaps the 0 is a typo, in which case data does get sent
> > > and the buffer must be kmalloc'ed.  If the 0 is correct then the buff=
er
> > > should be NULL, not "\x0A\x01A" (and what's the purpose of the leading
> > > '0' in the second byte?).
> > >=20
> > > In addition, although the bRequestType specifies USB_DIR_OUT, the pipe
> > > value is usb_rcvctrlpipe.  Is this transfer meant to be IN or OUT?
> >=20
> > Thanks again to all for the review.  My theory for why the previous pat=
ch worked
> > in spite of its wrongness is that the device actually switches modes wh=
en it
> > receives a control message with USB_TYPE_VENDOR even though the documen=
tation
> > suggests an actual diagnostic packet must be received.
> >=20
> > Does this (untested) patch look more reasonable?
>=20
> Yes, but we still need it tested, please.

Great, I'll test it later this evening when I am back in front of the hardw=
are
and follow up with a properly submitted patch.

Thanks again,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlBBR3oACgkQRO4fQQdv5AyTuwCffZE9f3QXEG9pAT/MKk2zJfAR
Eu4AoKOGKcYrg8tJrf6VHJtfP3iVRm4D
=GE7K
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
