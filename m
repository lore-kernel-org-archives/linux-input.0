From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 3.10-rc4
Date: Tue, 4 Jun 2013 09:41:48 -0700
Message-ID: <20130604164148.GA26400@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:64857 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755373Ab3FDQlw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Jun 2013 12:41:52 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem: just a 2 small driver
fixups here.

Changelog:
---------

Eric Miao (1):
      Input: synaptics - fix sync lost after resume on some laptops

Ping Cheng (1):
      Input: wacom - fix a typo for Cintiq 22HDT


Diffstat:
--------

 drivers/input/mouse/synaptics.c  | 2 ++
 drivers/input/tablet/wacom_wac.c | 8 +++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

--=20
Dmitry


--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iQIcBAEBAgAGBQJRrhjMAAoJEH70+W8r6ZYqGcYQAKyHvdGxaOEXojTDxus49blq
4+ntd8OBxYt/tDG1AMFIj4mkPsg7gFj+66kQCzWxL9bTHKbCpxMlOYachZ+EPYD7
hObidSPnA7DFuBiqmEYWMpoqTzC1Bs7DTyEIzq6NcCQngcw9xXczRdl3hTvD89e7
fnrqwqU2jIc/udrH3VX0CwQhPJ7cDgxsxHKL/1gZwtCKWcaQdYZp6zgmaXBPwu+5
oNCpupe0EA+bataJ27jNU2V59OE1u2dxGKk4MYzLE46L+gLmsH0fnxvS7vlMwdD8
alGN5fJ51Zb5lrKEYJGYAgPKvOfJlUTAt3ue6wMFpntQFJ+gDvPtG2M9cs/s9GiI
wlDVbX+fhYrbptr2dDFBNmvRNIFcYYDrwAA6KMGCm/bhuAvHI6P4scpJ+Z1+HuwS
HIsIXCBg+0J7eF6P056v7M+J1r1Msy4rvRR7qk9ys3/siLVCYxxC+lZiF2JnPGqo
r2QpqljdzYl9pETb67lx80/iH+Dsn6aVvIoIj/Z06yYPc8ePqXxmOtddWEsb3pLP
E5rtZP2qhZzMWXVVxYAnyBVAOMqt6gIx5sMW77SRpXW5cmdBZPWPgl+kGI635V6/
TxEj2u+IgSC/f994ixlmhMxrjr7mUzAsIRJ3J3eRfkKx5d1VUEcdIG9YOyDbFe0P
yvcmRJNGmDlaPq0kUkxK
=JWT9
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
