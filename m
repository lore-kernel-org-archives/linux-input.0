From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: 2.6.22-rc2 built on ppc
Date: Sun, 20 May 2007 12:59:28 +0200
Message-ID: <20070520105928.GA3253@aragorn.home.lxtec.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: dmitry.torokhov@gmail.com
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

FYI, building the kernel with
gcc (GCC) 4.1.3 20070514 (prerelease) (Debian 4.1.2-7)
on my powerbook (PPC) gives:

=2E..
drivers/input/keyboard/Kconfig:170:warning: 'select' used by config symbol =
'KEYBOARD_ATARI' refers to undefined symbol 'ATARI_KBD_CORE'
drivers/input/mouse/Kconfig:182:warning: 'select' used by config symbol 'MO=
USE_ATARI' refers to undefined symbol 'ATARI_KBD_CORE'
drivers/input/keyboard/Kconfig:170:warning: 'select' used by config symbol =
'KEYBOARD_ATARI' refers to undefined symbol 'ATARI_KBD_CORE'
drivers/input/mouse/Kconfig:182:warning: 'select' used by config symbol 'MO=
USE_ATARI' refers to undefined symbol 'ATARI_KBD_CORE'
=2E..

If more info is needed, please contact me via PM, as I am not
subscribed.

Thanks for your patience
Elimar

--=20
  Never make anything simple and efficient when a way=20
  can be found to make it complex and wonderful ;-)

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGUCoP3Ig8bsVPf7ARAisIAJ42AtnMrRwufqy166Ak4U16UbXWzwCgmIHm
uJcQ0CSIkqIlrYqTzUm5ppg=
=d5/2
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
