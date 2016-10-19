From: Ben Hutchings <ben@decadent.org.uk>
Subject: Bug#841275: linux: Logitech Unifying Receiver shows devices that aren't connected
Date: Wed, 19 Oct 2016 16:05:03 +0100
Message-ID: <1476889503.2709.42.camel@decadent.org.uk>
References: <9a2d81a4-fd6f-5653-3f04-7a4ed3312ca1@gamblin.ca>
Reply-To: Ben Hutchings <ben@decadent.org.uk>, 841275@bugs.debian.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-4rLN9y1kQngaKHujkRDs"
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.841275.B841275.14768895105505@bugs.debian.org>
In-Reply-To: <9a2d81a4-fd6f-5653-3f04-7a4ed3312ca1@gamblin.ca>
List-URL: <https://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/1476889503.2709.42.camel@decadent.org.uk
To: linux-input@vger.kernel.org
Cc: 841275@bugs.debian.org, Trent Gamblin <trent@gamblin.ca>
List-Id: linux-input@vger.kernel.org


--=-4rLN9y1kQngaKHujkRDs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Oct 2016 02:42:40 -0600 Trent Gamblin <trent@gamblin.ca> wrote:
> Source: linux
> Severity: normal
>=C2=A0
> Dear Maintainer,
>=C2=A0
> I have a PC with a mouse connected by a Logitech Unifying Receiver, and
> an Android TV box with a keyboard connected by a separate Unifying
> Receiver.=C2=A0=C2=A0The keyboard shows up on the Linux box with a messag=
e in
> dmesg:
>=C2=A0
> [=C2=A0=C2=A0=C2=A0=C2=A03.120080] usb 5-2.1: new high-speed USB device n=
umber 5 using xhci_hcd
> [=C2=A0=C2=A0=C2=A0=C2=A03.124336] usb 5-1.2: New USB device found, idVen=
dor=3D046d, idProduct=3Dc52b
> [=C2=A0=C2=A0=C2=A0=C2=A03.124340] usb 5-1.2: New USB device strings: Mfr=
=3D1, Product=3D2, SerialNumber=3D0
> [=C2=A0=C2=A0=C2=A0=C2=A03.124343] usb 5-1.2: Product: USB Receiver
> [=C2=A0=C2=A0=C2=A0=C2=A03.124345] usb 5-1.2: Manufacturer: Logitech
> [=C2=A0=C2=A0=C2=A0=C2=A03.136292] logitech-djreceiver 0003:046D:C52B.000=
4: hiddev0,hidraw1: USB HID v1.11 Device [Logitech USB Receiver] on usb-000=
0:0e:00.0-1.2/input2
> [=C2=A0=C2=A0=C2=A0=C2=A03.160384] usb 2-3: new SuperSpeed USB device num=
ber 3 using xhci_hcd
> [=C2=A0=C2=A0=C2=A0=C2=A03.190438] usb 2-3: device descriptor read/8, err=
or -71
> [=C2=A0=C2=A0=C2=A0=C2=A03.221096] usb 5-2.1: New USB device found, idVen=
dor=3D03f0, idProduct=3D7317
> [=C2=A0=C2=A0=C2=A0=C2=A03.221099] usb 5-2.1: New USB device strings: Mfr=
=3D1, Product=3D2, SerialNumber=3D3
> [=C2=A0=C2=A0=C2=A0=C2=A03.221102] usb 5-2.1: Product: HP LaserJet P3005
> [=C2=A0=C2=A0=C2=A0=C2=A03.221104] usb 5-2.1: Manufacturer: Hewlett-Packa=
rd
> [=C2=A0=C2=A0=C2=A0=C2=A03.221106] usb 5-2.1: SerialNumber: CNR1N17173
> [=C2=A0=C2=A0=C2=A0=C2=A03.266438] input: Logitech Performance MX as /dev=
ices/pci0000:00/0000:00:1c.4/0000:0e:00.0/usb5/5-1/5-1.2/5-1.2:1.2/0003:046=
D:C52B.0004/0003:046D:101A.0005/input/input3
> [=C2=A0=C2=A0=C2=A0=C2=A03.266819] logitech-hidpp-device 0003:046D:101A.0=
005: input,hidraw2: USB HID v1.11 Mouse [Logitech Performance MX] on usb-00=
00:0e:00.0-1.2:1
> [=C2=A0=C2=A0=C2=A0=C2=A03.272667] input: Logitech K400 Plus as /devices/=
pci0000:00/0000:00:1c.4/0000:0e:00.0/usb5/5-1/5-1.2/5-1.2:1.2/0003:046D:C52=
B.0004/0003:046D:404D.0006/input/input4
> [=C2=A0=C2=A0=C2=A0=C2=A03.273252] logitech-hidpp-device 0003:046D:404D.0=
006: input,hidraw3: USB HID v1.11 Keyboard [Logitech K400 Plus] on usb-0000=
:0e:00.0-1.2:2
>=C2=A0
> It also shows up in the battery applet in Mate.
>=C2=A0
> I think either the kernel or the applet should ignore it since it's not
> plugged into the PC (it doesn't actually work BTW.)
>=C2=A0
> Problem exists in 4.7.0 and up to the latest kernel I could find which=C2=
=A0
> was 4.8.0-rc8.

Trent also stated that under Windows the keyboard is *not* shown as
connected, so it seems the receiver does provide enough information to
tell that it's not currently connected.

Ben.

--=20
Ben Hutchings
I'm always amazed by the number of people who take up solipsism because
they heard someone else explain it. - E*Borg on alt.fan.pratchett


--=-4rLN9y1kQngaKHujkRDs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYB4ufAAoJEOe/yOyVhhEJeDsP/3smLyNXMOFrhxSFFoSE2F4h
Bv0A43tNEkGL0FdUJSPRzotKJEO/yHBNnDSOhub9c1nRArbBYERI88Lva1I038mW
3YJQRgg6y2NLjV+UByH9xEBxs+QkyJVLnn6i5006ZayyLaTypPz4d4p9ixf5mstt
dhOsAXLSVvXswgNJooJh2ZNEN+ONP4H4g8rZWQm2yog8/i8uGE82Y1UplYv4SDVf
9DKR9QatqxdpyKksdN/qwTNhOfj6bqfVra5HKhQ0uIyj/2sulu8FMFIgvgVToK9z
nP9NhvCenKDgkulaMtcs/FwADjeSQj48O1rZ5Qa0ozIbhhuunU7OB+gwSYxXHfVp
UniG7+CHCVXvlVQZE+cBlzK+VHX9LupCU9AhimXEN0SZzWpgP9qVwkrSUGQ2zXG0
y4n2USMA2iyvbmRIGLfRYgQbalzCBKYSEEkBP4MVNm1tCcpJwOG4LHWNyj1auPC2
c0sUsDYR5Iy+lRf4WRszzBmMYKN750fFw3MZiSsMJuDz9bub8b+CxTpPukQBXb6S
BEwEjSRvggUDXx+aDRbidD/WKxlgUkuOTjZVX5OK06EzQ0AVenrY6XxLO+drwyFd
+BAMK20BgM5Kam+gJvT39l5+gqlLFvlEXWBzXfpcW/X5sVPa4I2dfwy0tgTxPHLC
kEAPN69sKcp4DBH1Rrky
=qRy6
-----END PGP SIGNATURE-----

--=-4rLN9y1kQngaKHujkRDs--
