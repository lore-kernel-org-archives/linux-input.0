From: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Subject: [Fwd: Re: MPX merge coming up]
Date: Fri, 09 May 2008 15:59:03 +0200
Message-ID: <1210341543.5088.3.camel@rousalka.okg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0881835700=="
Return-path: <xorg-bounces@lists.freedesktop.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Mime-version: 1.0
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
To: linux-input <linux-input@vger.kernel.org>
Cc: xorg <xorg@freedesktop.org>
List-Id: linux-input@vger.kernel.org


--===============0881835700==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ko0+OeZxnSlVSSJynuEa"


--=-ko0+OeZxnSlVSSJynuEa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi

The xorg devs want the kernel to quirk devices such as the following
one:
=EF=BB=BF
> I: Bus=3D0003 Vendor=3D045e Product=3D00db Version=3D0111
> N: Name=3D"Microsoft Natural=C2=AE Ergonomic Keyboard 4000"
> P: Phys=3Dusb-0000:00:02.1-8.3/input0
> S: Sysfs=3D/devices/pci0000:00/0000:00:02.1/usb1/1-8/1-8.3/1-8.3:1.0/inpu=
t/input2
> U: Uniq=3D
> H: Handlers=3Dkbd event2=20
> B: EV=3D120013
> B: KEY=3D1000000000007 ff800000000007ff febeffdff3cfffff fffffffffffffffe
> B: MSC=3D10
> B: LED=3D107
>=20
> I: Bus=3D0003 Vendor=3D045e Product=3D00db Version=3D0111
> N: Name=3D"Microsoft Natural=C2=AE Ergonomic Keyboard 4000"
> P: Phys=3Dusb-0000:00:02.1-8.3/input1
> S: Sysfs=3D/devices/pci0000:00/0000:00:02.1/usb1/1-8/1-8.3/1-8.3:1.1/inpu=
t/input3
> U: Uniq=3D
> H: Handlers=3Dkbd event3=20
> B: EV=3D10001f
> B: KEY=3D37fff002c3027 bf00444400000000 1 10f848a27c007 ff7f7bfad9415fff =
febeffdfffefffff fffffffffffffffe
> B: REL=3D40
> B: ABS=3D100000000
> B: MSC=3D10

I hope it's in the kernel plans too.

-------- Message transf=C3=A9r=C3=A9 --------
De: Daniel Stone=20
=C3=80: Nicolas Mailhot=20
Cc: Peter Hutterer, Colin Guthrie=20
Sujet: Re: MPX merge coming up
Date: Fri, 9 May 2008 16:24:24 +0300

On Fri, May 09, 2008 at 03:11:42PM +0200, Nicolas Mailhot wrote:
> Le vendredi 09 mai 2008 =C3=A0 19:01 +0930, Peter Hutterer a =C3=A9crit :
> > On Fri, May 09, 2008 at 09:46:53AM +0100, Colin Guthrie wrote:
> > > Your above comment immediately makes me think of laptops with=20
> > > mouse+trackpad. These would presumably count as multiple input device=
s,=20
> >=20
> > they do count as multiple input devices. except that we differ between
> > physical input devices (mouse + trackpad) and virtual input devices. Th=
e
> > latter are cursors and keyboard foci but NOT physical devices.
>=20
> BTW some keyboards (MS ones) expose two HID devices: one HID device for
> the standard part of the keyboard (pc105), another for extended
> multimedia keys. I hope MPX will be smart enough to keep both parts
> together.

Kernel quirk.

Daniel, rapidly becoming a parody of himself
--=20
Nicolas Mailhot

--=-ko0+OeZxnSlVSSJynuEa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkgkWKMACgkQI2bVKDsp8g2JbACfYsxY2aa8FWnrk9D/8xlNNRUr
Vs4An1O/wwYizErWSqwGW2dP8CzDU6Go
=5kKb
-----END PGP SIGNATURE-----

--=-ko0+OeZxnSlVSSJynuEa--


--===============0881835700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
xorg mailing list
xorg@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/xorg
--===============0881835700==--
