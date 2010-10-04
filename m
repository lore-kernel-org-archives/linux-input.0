From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH] HID: hidraw, fix a NULL pointer dereference in
 hidraw_ioctl
Date: Mon, 4 Oct 2010 16:11:10 +0200
Message-ID: <20101004161110.10f6925a.ospite@studenti.unina.it>
References: <1286018724-7484-1-git-send-email-ospite@studenti.unina.it>
	<alpine.LNX.2.00.1010041548580.29535@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__4_Oct_2010_16_11_10_+0200_xs4vWIQ0of/CGkZr"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:46291 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753693Ab0JDOLY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Oct 2010 10:11:24 -0400
In-Reply-To: <alpine.LNX.2.00.1010041548580.29535@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Alan Ott <alan@signal11.us>, Oliver Neukum <oliver@neukum.name>, linux-kernel@vger.kernel.org

--Signature=_Mon__4_Oct_2010_16_11_10_+0200_xs4vWIQ0of/CGkZr
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Oct 2010 15:50:31 +0200 (CEST)
Jiri Kosina <jkosina@suse.cz> wrote:

> On Sat, 2 Oct 2010, Antonio Ospite wrote:
>=20
> > BUG: unable to handle kernel NULL pointer dereference at 00000000000000=
28
> > IP: [<ffffffffa02c66b4>] hidraw_ioctl+0xfc/0x32c [hid]
> > [...]
> >=20
[...]
> >=20
> > Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
> > ---
> > Should this be applied to older stable kernels too?
>=20
> Yes, I will be adding (or feel free to do so yourself with another respin=
)=20
> "Cc: stable@kernel.org" line.
>

Ok, I am resending it along with the other fix.

> > there is a similar problem when _writing_ to the device, but Alan's
> > changes in that area are shuffling the code a bit, should I send a patch
> > [to hidraw_send_report()] on top of Alan's work for that, or a fix for
> > current mainline [in hidraw_write()] on which Alan should rebase his
> > work would be better?
>=20
> Please send me the fix for current mainline for now, i.e. respin with the=
=20
> write path covered as well. We are struggling to get feedback on Alan's=20
> patches from Bluetooth maintainer, so we'd rather have this race fixed in=
=20
> any case.
>

Ok, I hope having Alan to resend his changes again rebased on these
fixes will bring the discussion on that up again.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Mon__4_Oct_2010_16_11_10_+0200_xs4vWIQ0of/CGkZr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyp4H4ACgkQ5xr2akVTsAGjTgCgj5Cwys3ZdORbNB84ktSD/qGg
kjUAn3mUWvc9GLQAnf5tNdeohCNsFdIh
=1sBp
-----END PGP SIGNATURE-----

--Signature=_Mon__4_Oct_2010_16_11_10_+0200_xs4vWIQ0of/CGkZr--
