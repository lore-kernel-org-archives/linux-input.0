From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH] uhid: Pad short UHID_CREATE writes from compat tasks
Date: Tue, 26 Nov 2013 07:02:10 +0000
Message-ID: <1385449330.23855.46.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-fdUB8xjS7BXCczRvKa4O"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33300 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753007Ab3KZHCS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Nov 2013 02:02:18 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org


--=-fdUB8xjS7BXCczRvKa4O
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Short event writes are normally padded with zeroes, but the compat
fixup for UHID_CREATE didn't ensure this.  This appears to allow an
information leak.

Compile-tested only.

Fixes: befde0226a59 ('HID: uhid: make creating devices work on 64/32 system=
s')
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: stable@vger.kernel.org
---
I have no familiarity with uhid so I haven't written a test for this.
It looks like it would be possible to write a UHID_CREATE event that
only covers fields up to rd_size, and the following data on the heap
would be copied to the HID device metadata and be readable that way.

Ben.

 drivers/hid/uhid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 5bf2fb7..579a7115 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -298,6 +298,9 @@ static int uhid_event_from_user(const char __user *buff=
er, size_t len,
 				kfree(compat);
 				return -EFAULT;
 			}
+			if (len < sizeof(*compat))
+				memset((char *)buffer + len, 0,
+				       sizeof(*compat) - len);
=20
 			/* Shuffle the data over to proper structure */
 			event->type =3D type;

--=20
Ben Hutchings
Usenet is essentially a HUGE group of people passing notes in class.
                      - Rachel Kadel, `A Quick Guide to Newsgroup Etiquette=
'

--=-fdUB8xjS7BXCczRvKa4O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIVAwUAUpRHcue/yOyVhhEJAQpQhxAAgoo7bqfBBH1YgeUFOHOEuXx/lBqalXs8
qalCfDE42vW2CQ/FSGksGodrodeBdcKLp8wGpdZ+OPdk1TBqri41Mj60Y6+PnxkC
1BxwUml4broKRMHiJqOZ+CHTqyM89NCpX3tZJe8OSrbtgbfzo3tecG50+U+hX5zf
L4EkRFeC2ulUkKcA/TEwevleOmHhpNfcNUVMQKDG507yDfj/n8sz8FEVgssedF6D
jFg7I9DTEyg1NDi8itgKsWqvhhhQ9TsWIyLVSIUY1sYDREUv1oDW8jbT66IP6YWF
RvRUss8mfc8C953f3fNnjQjv1E3tQ/pRUiHLMo99hBlTkpbpTYjB/tgFMhZQ2srn
xpvARHm06eag+afmQTVFra0DAlgmUm60Oq+zW9inYAgAYfpRzAdV0pKsMDw/z2UP
F3X+HixjAOdV/DNjcwFcE6xVb8cdQ3C6pUb3CbfFKy7XggHK+hBs1cOzl8iPj8Xr
7ezaAlWiBjpaGzmqznMS9OeFdhh5J4S/T2HCym2vFkqaMiHPC8jcQTl8zqvmropW
qNghslfZo0yBFsg/14vKIDqe7Iy+fizXDsx8Zt6DsDDgXoJGparbHB6Vm+RWKA/+
Gg+roVTp12cq86ZRB/bSt3mIZD/hV+ldKgua7PFm6Ra4zaO6X/oyX/BanYBZD4vE
7zrerDIrp2A=
=c2OV
-----END PGP SIGNATURE-----

--=-fdUB8xjS7BXCczRvKa4O--
