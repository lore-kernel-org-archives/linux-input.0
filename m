From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 5/6] Driver for WM97xx touchscreens in streaming mode
 on PXA2xx systems
Date: Mon, 14 Jan 2008 16:06:46 +0100
Message-ID: <478B7A86.7010207@pengutronix.de>
References: <1199965870-4629-1-git-send-email-broonie@opensource.wolfsonmicro.com> <1199965870-4629-2-git-send-email-broonie@opensource.wolfsonmicro.com> <1199965870-4629-3-git-send-email-broonie@opensource.wolfsonmicro.com> <1199965870-4629-4-git-send-email-broonie@opensource.wolfsonmicro.com> <1199965870-4629-5-git-send-email-broonie@opensource.wolfsonmicro.com> <478B31B6.3050406@pengutronix.de> <20080114144250.GA7443@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBF29A3972656F1D70799EB13"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752954AbYANPHh@vger.kernel.org>
In-Reply-To: <20080114144250.GA7443@rakim.wolfsonmicro.main>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, Dmitry Torokhov <dtor@mail.ru>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, Liam Girdwood <liam.girdwood@wolfsonmicro.c>
List-Id: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBF29A3972656F1D70799EB13
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Mark Brown wrote:
> On Mon, Jan 14, 2008 at 10:56:06AM +0100, Marc Kleine-Budde wrote:
>> reMark Brown wrote:
>=20
>>> Cc: Marc Kleine-Budde <mkl@penugtronix.de>
>>                                 ^^
>> it's mkl@pengutronix.de
>=20
> Fixed, sorry about that.
>=20
>>> +			/* use PEN_DOWN GPIO 13 to assert IRQ on GPIO line 2 */
>>> +			wm->pen_irq =3D MAINSTONE_AC97_IRQ;
>=20
>> I'm missing some kind of abstraction here, what about non mainstone
>> boards with the pen irq wired to some other gpio?
>=20
> The driver really isn't intended to cope with them.  As you say, other
> boards may have things wired up differently and therefore require
> different configuration of the wm97xx and other bits of the system.  Th=
e
> expectation is that other systems will have their own driver.

What bits have to setup in a different way? Only the stuff in
wm97xx_acc_startup() or other things aswell. An irq can be put as utual
into a device's resouce, Setting up bits may be done like other stuff on
pxa, too. e.g. pxa_set_ohci_info.

> My initial thought is that the most straightforward way of handling thi=
s
> would be to rename the driver to mainstone-wm97xx or similar to make it=

> clear that the driver is only intended to handle Mainstone as-is.  Does=

> that seem reasonable?

With my limited understanding of the pxa-wm97xx.c file, the only board
dependent stuff is done in wm97xx_acc_startup() so a different "driver"
for other boards would result in code duplication.

regards - Marc

--=20
 Marc Kleine-Budde              Phone: +49-231-2826-924
 Pengutronix - Linux Solutions for Science and Industry
 Vertretung West/Dortmund     http://www.pengutronix.de


--------------enigBF29A3972656F1D70799EB13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHi3qLjTAFq1RaXHMRApikAJ0Sn14UyJglVm/uKOQ+B3Smfbh8fwCfQxXo
kZml/x1VjD19jHWI9IMuECY=
=Y2kb
-----END PGP SIGNATURE-----

--------------enigBF29A3972656F1D70799EB13--
