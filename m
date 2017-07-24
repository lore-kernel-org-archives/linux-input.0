From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: v4.13-rc2: usb mouse stopped working?
Date: Mon, 24 Jul 2017 22:29:56 +0200
Message-ID: <20170724202956.GA4253@amd>
References: <20170724200056.GA3997@amd>
 <alpine.LSU.2.20.1707242203510.4705@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1707242203510.4705-YHPUNQjx9ReKbouaWp301Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > On thinkpad x220, USB mouse stopped working in v4.13-rc2. v4.12 was
> > ok, iirc.
> >=20
> > Now, USB mouse is so common hw that I may have something wrong in my
> > config...? But I did not change anything there.
>=20
> Well, your particular USB mouse requires an always-poll quirk, so it's no=
t=20
> *that* common; therefore ...

Aha, was not aware of that brokennes.

> > [   88.027825] hid-generic 0003:046D:C05A.0005: input,hidraw1: USB HID
> > v1.11 Mouse [Logitech USB Optical Mouse] on
> > usb-0000:00:1d.0-1.1.1.1/input0
>=20
> ... this is most likely caused by e399396a6b0, and fix for that is queued=
=20
> in hid.git as cf601774c9f ("HID: usbhid: fix "always poll" quirk"); I'm=
=20
> planning to send it to Linus' tomorrow, but if you can double-check that=
=20
> it does fix your issue as well, that'd be appreciated.

Thanks for very quick reply. You saved me from some debugging.

I guess I can wait for tommorows' pull. Should be sleeping not
debugging kernels at the moment.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAll2WMMACgkQMOfwapXb+vLJ6QCgv94wf2oDgjHxRlFlFLq1c9Od
6G0Anjz2hJGnmDZaKEL+JyPTPCnxPZNz
=/WYR
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
