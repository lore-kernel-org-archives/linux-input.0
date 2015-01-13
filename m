From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 0/9] ARM: sunxi: Support cpufreq on sun[457]i
Date: Tue, 13 Jan 2015 14:53:12 +0100
Message-ID: <20150113135312.GX4891@lukather>
References: <1421037249-28461-1-git-send-email-wens@csie.org>
 <20150112091020.GA30908@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yKmnPmKxJBqIz68t"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150112091020.GA30908@lukather>
Sender: linux-pm-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: linux-pm@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org


--yKmnPmKxJBqIz68t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2015 at 10:10:20AM +0100, Maxime Ripard wrote:
> On Mon, Jan 12, 2015 at 12:34:00PM +0800, Chen-Yu Tsai wrote:
> > Hi,
> >=20
> > This is v3 of the cpufreq support series for sunxi. The series has been
> > rebased onto the latest sunxi-next. I've dropped all the patches Maxime
> > merged. This includes "ARM: sunxi: Register cpufreq-dt for sun[45678]i"
> > which was merged but not published yet.
> >=20
> > Individual changes since v2 are listed within each patch.
> >=20
> >=20
> > Original cover letter follows:
> >=20
> > This series adds support cpufreq support for sun[457]i using cpufreq-dt.
> > This also supports passive cpu cooling (thermal throttling) using therm=
al
> > zones with the temperature sensor in the SoC.
> >=20
> > The operating points for the supported platforms were taken from the
> > linux-sunxi FEX files repository. The majority of boards use the same
> > settings. Only with sun7i do we see slight variations, either disabling
> > some frequencies, or bumping up the voltage a bit. In either case this
> > can be done by limiting the constraints for the supply regulator, or=20
> > overriding the OPP table in the board dts file.
> >=20
> > On sun7i, there is an additional operating point not found in the FEX
> > files, 960 MHz @ 1.4V, which is the full speed setting in both u-boot-s=
unxi
> > and mainline u-boot.
> >=20
> > The series has been tested on the 4 boards I have. With cpufreq active,
> > the effects are visible as a decrease in SoC internal temperature.
> > Stability for the operating points has been tested using:
> >=20
> >   http://linux-sunxi.org/Hardware_Reliability_Tests#Reliability_of_cpuf=
req_voltage.2Ffrequency_settings
> >=20
> > More real world usage feedback is appreciated. Thermal throttling hasn't
> > been tested much, due to not being able to generate enough load without
> > the GPU for the SoC to heat up. Also on sun4i, the temperature sensor
> > still hasn't been calibrated, so the readings are highly inaccurate.
>=20
> Applied 2, 3, 6 and 8.

And I just applied 4, 5, 7 and 9.

Thanks!=20

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--yKmnPmKxJBqIz68t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtSNIAAoJEBx+YmzsjxAgh7EQAIoW+SXqQBoSbv4+yN9BTVkv
MDRbOWUuVzDSfjyOHtHSkPRmLUOY9QeWQ10Jlmliw57eqPSsUGrrw4VZm6k/jkZt
/2o7wVaOvinKCkUWLlKcbCW0tZLDh27XBVDMmVDzTg6kLVt3YeIBCcHAMB4bh9W4
AR5YIns+b89FWUP5aVqDIEZmjQLB2tpWw9kCslrnqu+o5qkjp3gSpyIbiZVpL+T8
owVLX8Jau44HXAhMB0dwrhaDeaybOv637wrDVnFBccTEMa1gfSv0mC2kB+aNz3d4
SVygt0d1CuuqfFLUS3iNtgqKHeWaGfFTlhAltAjiwzwbNL6hQG2LiT9UqeycQqel
X0jcJdtZY4llfzLFd39VdIvKwjgYuuvVTKqCjQrbCRCl3abA36jm6aNcXjzB4DU0
kr49arPX53Wgssl32Q4ay2olthrSQPfgrOOBQDgcy9U2D1uxiU23yjKo918HV8Rd
skyDHVbvZhK2EbtEpsP8mdYOU+zToSFKixGrw7a2M3GqzbxiilXig6dzBD77dRfB
K9qs3PVlntYRkYueaJ0Mkc8RO8e/rPkYs2WI4sGS03DdxIEIYAE1XQCWrz7TquTP
IRCsmILM9nDzsHZHjbTOHLlRJIQiyLEFx1eIMgaq+yoOgiDkXWR7+4fACeFqesTr
jjIdCHGgkFDb3iwhYZL4
=l8iC
-----END PGP SIGNATURE-----

--yKmnPmKxJBqIz68t--
