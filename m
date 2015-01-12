From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 0/9] ARM: sunxi: Support cpufreq on sun[457]i
Date: Mon, 12 Jan 2015 10:10:20 +0100
Message-ID: <20150112091020.GA30908@lukather>
References: <1421037249-28461-1-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421037249-28461-1-git-send-email-wens@csie.org>
Sender: linux-pm-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2015 at 12:34:00PM +0800, Chen-Yu Tsai wrote:
> Hi,
>=20
> This is v3 of the cpufreq support series for sunxi. The series has been
> rebased onto the latest sunxi-next. I've dropped all the patches Maxime
> merged. This includes "ARM: sunxi: Register cpufreq-dt for sun[45678]i"
> which was merged but not published yet.
>=20
> Individual changes since v2 are listed within each patch.
>=20
>=20
> Original cover letter follows:
>=20
> This series adds support cpufreq support for sun[457]i using cpufreq-dt.
> This also supports passive cpu cooling (thermal throttling) using thermal
> zones with the temperature sensor in the SoC.
>=20
> The operating points for the supported platforms were taken from the
> linux-sunxi FEX files repository. The majority of boards use the same
> settings. Only with sun7i do we see slight variations, either disabling
> some frequencies, or bumping up the voltage a bit. In either case this
> can be done by limiting the constraints for the supply regulator, or=20
> overriding the OPP table in the board dts file.
>=20
> On sun7i, there is an additional operating point not found in the FEX
> files, 960 MHz @ 1.4V, which is the full speed setting in both u-boot-sun=
xi
> and mainline u-boot.
>=20
> The series has been tested on the 4 boards I have. With cpufreq active,
> the effects are visible as a decrease in SoC internal temperature.
> Stability for the operating points has been tested using:
>=20
>   http://linux-sunxi.org/Hardware_Reliability_Tests#Reliability_of_cpufre=
q_voltage.2Ffrequency_settings
>=20
> More real world usage feedback is appreciated. Thermal throttling hasn't
> been tested much, due to not being able to generate enough load without
> the GPU for the SoC to heat up. Also on sun4i, the temperature sensor
> still hasn't been calibrated, so the readings are highly inaccurate.

Applied 2, 3, 6 and 8.

There's still some discussions about the boards regulators, that apply
to all of them, even though I commented on one in particular.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUs498AAoJEBx+YmzsjxAg4KYP/3P9GTDdT5So25vX0gHotk54
MNPBMAxnP88DkrI65cpG9v935VVV2YqlEM/vwI/m0hOCFzNxlzrAGgbTCBKczr0S
PFk4s++wubxtwRHolheRuUDdR/dS8ADd2PEwW4wVkIAUZpQayPZFoq5m3wu+UwhH
MMwYHjFaSh82TjuS2ko+mq2io8YFw1AgGDBAPmjbkJZZugXXTQYDtHd9f78g91KN
C8DXk3LwiZe8mM06DzHzru6qFgN8sVSNEx/8xWD4dgT7teGC/MFMMw5yZiP60C4u
sE0hGC0IbL0G3jJ9IZq/ydrAAnqQRoUwM1vcr1qYA7OokN6+wXoa4MHulSiYIPQN
0JVWvF0nLZPPfUVKa2xKNuahsRmAsRumegp9EkjbqmUqiTUs4WK2ZHiZaklESMcB
kWrOdsTzVXeim1WySKIIk54V1f4lDukHfBf9IHgmybR/8dw2kRfveWdPd04uH8FO
tweO+AKgEgak0FO0nNV/XNax+mipo0lHFI7kEfGCY4Q8woljYJwzj0xSTEGN1Ra+
0gGB5+JlW+9XbX3fFv0GyO72Gv9T/Dxqyymm78Q68kVPGwtizBDkY73OVUPJggrT
2oNl8Cq4PtAQPb2NXbux9M7a7uGBR5hzq1RWZgHlXkK9mlXfpnPGeTetS4wAvRWE
ab7gH3nCDScrb/KP5STO
=kEvG
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
