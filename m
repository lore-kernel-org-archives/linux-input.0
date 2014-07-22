From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
Subject: Re: [PATCH 3/3] driver:gpio remove all usage of
 gpio_remove retval in driver
Date: Tue, 22 Jul 2014 17:17:04 +0200
Message-ID: <20140722171704.71e34e9e@wiggum>
References: <CACRpkda6mzVdaN0cvOxpbsxWyCv2nGyDXOjZg_5aT8u7SSQeUw@mail.gmail.com>
 <1405197014-25225-1-git-send-email-berthe.ab@gmail.com>
 <1405197014-25225-4-git-send-email-berthe.ab@gmail.com>
 <CACRpkdasp9bLULT7NJM9nYX58rRSsQKXFddOLz9Ah6kp-j-3=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2285203138184650228=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CACRpkdasp9bLULT7NJM9nYX58rRSsQKXFddOLz9Ah6kp-j-3=Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mips@linux-mips.org, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Matthew Garrett <matthew.garrett@nebula.com>, Samuel Ortiz <sameo@linux.intel.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, abdoulaye berthe <berthe.ab@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Bryan Wu <cooloney@gmail.com>, "arm@kernel.org" <arm@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Mark Brown <broonie@kernel.org>Greg KH <g>
List-Id: linux-input@vger.kernel.org

--===============2285203138184650228==
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/hrgAhs9Mivj2jERYWhjEYIr"; protocol="application/pgp-signature"

--Sig_/hrgAhs9Mivj2jERYWhjEYIr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Jul 2014 17:08:13 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> >  drivers/ssb/driver_gpio.c                      |  3 ++-
>=20
> Michael can you (A) ACK this and

Acked-by: Michael B=C3=BCsch <m@bues.ch>

> (B) think of moving this driver to drivers/gpio... Patches welcome.

This is not that easy, as it is not a driver on its own, but integral part =
of ssb.
I don't think it's a good idea to move it out.

I'll accept well tested patches, though.

--=20
Michael

--Sig_/hrgAhs9Mivj2jERYWhjEYIr
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTzoBwAAoJEPUyvh2QjYsOuF8QAKSf5P1KzGQpBDdHpy/lCXaV
R2TFv+8h2wn2BfjBh+lKc3WV2FvdFwXNO/5kM6g7Nlku2bdjfGNeFyXVvEnESF3n
bFvmgNEI0AA65zZoxsKGcEFRxz9iijewT+ZpkbwwS2uscmRhKUhSyoz58CiyARxS
KBedPNO3SV++34XI9Jfrn7wpZs4CIiGcMqKIFGTV756Gb0luSLeaH9ThvZVS0poV
adME8vN50KL2hYN72J6WXDaZlKlQ22tqrMDq8DyYbfSyis2rDQPin9PDtw52TF4q
YU+QiqxlSSHPP7LVh6mJCMjC6jtrcOvzebKw5N6qpYSaNUsa2geB6VWMRzzUiu4b
tXZTgJQjdpdAtafdJLDUs+EynykaTvcZYX8wgtfen6NfxvbjerxI6OOvi1j4H3Z/
wZmIO6olkR1KA3PGj9OcCmIZoY2fjOf4EApWYngFWMiPkaIFBn+OiCAGrQpZPBWU
rFGCM3BeslULWldG5VSwwURgp3dQS/kHegnrddD9M1WH7CInBmHsWxQwocyh0RMu
gP4yGTtAYcp2SjY35SMnw9+L9BjRzqmBd74fJRD8iR7Iw7++14QArX3JBaXfbtok
OAZDoMPWIZxemzvP7L+QYb5LS6+H4FoRkNhbDYvodI0WtAng6UF/QFKjrr6gqfoy
wyRrZ5RjRjp2yMo4qnNm
=qF+A
-----END PGP SIGNATURE-----

--Sig_/hrgAhs9Mivj2jERYWhjEYIr--

--===============2285203138184650228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2285203138184650228==--
