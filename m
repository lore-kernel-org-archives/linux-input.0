From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: Bug in i2c-core?
Date: Thu, 12 Mar 2015 10:35:50 +0100
Message-ID: <20150312093550.GB1000@katana>
References: <54F0507F.6030804@armadeus.com>
 <20150304082237.GA2955@katana>
 <20150308082617.GA1904@katana>
 <6018658.iFTJCkgHeH@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6018658.iFTJCkgHeH@avalon>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?Q?S=C3=A9bastien?= SZYMANSKI <sebastien.szymanski-d2DlULPkwbNWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > Adding Rob to CC as he wrote of_irq_get and put it into
> > > platform_get_irq. Rob, we use of_irq_get() in the I2C core and the
> > > question is now if we need to dispose the mapping and if so what would
> > > be a good place for it so managed devices will not have their mappings
> > > removed before the managed irq is removed.
> >=20
> > Ping. Just so you know: Without further information, I will revert the
> > patch in question around rc4/rc5. I'd still like to know if the
> > non-disposing of the mapping in platform_get_irq() is intentional.
>=20
> I'll defer that to Rob. I'm fine with the revert at the moment.

Added the revert to for-current now with your and Dmitry's ack.


--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVAV32AAoJEBQN5MwUoCm2pEIP/3Q5Y89DObt/7Dp2/RfOSMI/
xVDtI+F61tyOJ7MKe7tO8RF6STfsbvuPMST8JUhrCY1ejsWQwvkmbnjlIqAsdH5P
78Diqdl9h4isaqBW3MdQKml2tC4oWMriTr9Hn7R2hMWrAzHSjlKWDmpGHbN+VqS2
EUflu5ah/FD2+O8SUze8Xi4wQjGhu8iMROGdsxXnK5JqAsvWHoux5PXctCJjq3+o
DaSmBsEL7ctigc8ehJGAgr2BX6qmQvAZyhCSz6CjH9zSg+zWOUqvA/8C3VNxuKpJ
n9TM7ATJTEh/3xrt10+E6+3iE4SzsVeYT2x2QXw6Ayya0+XzpKkMVzTZlu64yQzV
J1+L9T8F4LENi/tWuevJF9kF6cPGexstxXIEhEy0O/4KaGmyk742dXgLdhYDFe/w
jh6JSrRoA2MZJsuD7KGkK01p1b7+70kKQTqJ4Jr1P8a4DpFIEow6/5MRUuu9hAgv
WzsMfqt03ES22bgEeBb8D/9dj0Ntv9McJyLgkG9GiZuEFpcp1u9EAfCBuqahMrqE
SI0mTQgD+2IzbAGH77Ib5fVLfgMSwtdY3fuB+68A3gIQ62JB6GXnGY4DbnMTHRC7
4DCIvl15PpnRKqc5Y6kbH5ioK4qera9HgNONZQ2lWr/zhUIstx2KhPIXMVaqsfF1
iv/NTou6r/0VtMSZ+YVP
=8Aov
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
