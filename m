From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 3.2-rc7
Date: Fri, 30 Dec 2011 00:32:18 -0800
Message-ID: <20111230083218.GA21621@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Just a couple of fixups to
the Sentelic touchpad driver...

Changelog:
---------

Tai-hwa Liang (2):
      Input: sentelic - release mutex upon register write failure
      Input: sentelic - fix retrieving number of buttons


Diffstat:
--------

 drivers/input/mouse/sentelic.c |    8 ++++----
 drivers/input/mouse/sentelic.h |    3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

--=20
Dmitry


--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJO/XcRAAoJEH70+W8r6ZYqNO0QAJoYCnV9g1Ww0ZyUVOaPVrBb
sfMyC3oTI6SJVQJmMDW7iXXK+Z8ZBnped09XkMz14F44zHkD5Oe8aQDyMatm+c7i
lMK8nDQSitxna5URmGwTrUa5ObSPPoISBTVQg+dy5PnjiDsKebvHVMKmmsIypPU8
EWhSQGvWHW9qZYqn+xJXJmbRpNzrX3NBYg1L5ooyC63s6t2LXHRVog31O87Q361H
qJF+W0OsTY4rzXTWrlYCXU+tVHHcQhNxO1FvIsNXhOtWuBjOunscD9mP5B40ydkE
3/EExY1+G9gtHJA6Fy62byijx3+Q627jX1kvqCx4gAUpncVZrLDMo/0jl9VqjfDG
gB/faIhfqvGV2ajhuSzvxbo1u97HVsi6/o9kYoOShcCH1/unUKFulRP0q39g6GZG
z7Ideb7yxe8U+KkTYlg9gO7algGz/j2cxagccksbQJpjdtbWJpEhBmYREdC8gnDB
I7DRrUzVeoCFBJT4OffhLeUNuaU/+85yuI3q32DkydETABozzbJRtwrRth+x659z
vVeRctZQdwPax1LSzGonoP6znV+WOnXyM09/R6iwdNbdGnm7t/XtIu22HM3FI4uy
xDp7LoI/gubF1waT0V0s0oxxOtqTSqgXGSEO8jR0yY1hz8dEjvkp3YxNrYJFRt98
ttCkO8ZpNnHsznh7G8SU
=gfIV
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
