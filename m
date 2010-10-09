From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH 0/2] HID: hidraw, fix two NULL pointer dereferences
Date: Sat, 9 Oct 2010 14:40:26 +0200
Message-ID: <20101009144026.c37f8d25.ospite@studenti.unina.it>
References: <alpine.LNX.2.00.1010041548580.29535@pobox.suse.cz>
	<1286292017-6746-1-git-send-email-ospite@studenti.unina.it>
	<4CAB94A0.8040402@gmail.com>
	<20101006120129.52da81d3.ospite@studenti.unina.it>
	<4CAC4AC3.60507@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__9_Oct_2010_14_40_26_+0200_huzKpfoGAnXCecf+"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:58386 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753715Ab0JIMkj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 9 Oct 2010 08:40:39 -0400
In-Reply-To: <4CAC4AC3.60507@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Alan Ott <alan@signal11.us>, Oliver Neukum <oliver@neukum.name>, linux-kernel@vger.kernel.org, stable@kernel.org

--Signature=_Sat__9_Oct_2010_14_40_26_+0200_huzKpfoGAnXCecf+
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 06 Oct 2010 12:09:07 +0200
Jiri Slaby <jirislaby@gmail.com> wrote:

> On 10/06/2010 12:01 PM, Antonio Ospite wrote:
> > On Tue, 05 Oct 2010 23:12:00 +0200
> > Jiri Slaby <jirislaby@gmail.com> wrote:
[...]
> >> Hi, please fix also the window in hidraw_release.
> >>
> >=20
> > I am not sure I get what you mean, can you please add more details?
>=20
> Sure. Look at the code:
> if (!hidraw_table[minor])
>         return -ENODEV;
> ...
> dev =3D hidraw_table[minor];
> if (!--dev->open) {
> ...
>=20
> This is done without minors_lock, so you can easily have dev being NULL
> even though the first if.
>

Jiri (Slaby) I think it makes more sense if you send a patch about this
as it is you who has raised the issue.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Sat__9_Oct_2010_14_40_26_+0200_huzKpfoGAnXCecf+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkywYroACgkQ5xr2akVTsAFb5QCfeUKQ5Wi4iSDBGMj3dZbCF3jF
ozgAoJS/S/r/qjrQvQ6MxNJHbtsFzcgO
=e80J
-----END PGP SIGNATURE-----

--Signature=_Sat__9_Oct_2010_14_40_26_+0200_huzKpfoGAnXCecf+--
