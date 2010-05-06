From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [TRIVIAL, PATCH] hid/hidraw: indent with tabs, not spaces
Date: Thu, 6 May 2010 11:02:14 +0200
Message-ID: <20100506110214.0c6cbb48.ospite@studenti.unina.it>
References: <1272656998-29307-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__6_May_2010_11_02_14_+0200_5Xd19sLcACEFl.xl"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out20.alice.it ([85.33.2.20]:1079 "EHLO
	smtp-out20.alice.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188Ab0EFJMl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 May 2010 05:12:41 -0400
In-Reply-To: <1272656998-29307-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <trivial@kernel.org>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

--Signature=_Thu__6_May_2010_11_02_14_+0200_5Xd19sLcACEFl.xl
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Apr 2010 21:49:58 +0200
Antonio Ospite <ospite@studenti.unina.it> wrote:

> Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
> ---
>  drivers/hid/hidraw.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
> index 6eadf1a..a9becf9 100644
> --- a/drivers/hid/hidraw.c
> +++ b/drivers/hid/hidraw.c
> @@ -311,7 +311,7 @@ static long hidraw_ioctl(struct file *file, unsigned =
int cmd,
>  						-EFAULT : len;
>  					break;
>  				}
> -                }
> +		}
> =20
>  		ret =3D -ENOTTY;
>  	}
> --=20
> 1.7.1

Ping.

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

--Signature=_Thu__6_May_2010_11_02_14_+0200_5Xd19sLcACEFl.xl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvihZYACgkQ5xr2akVTsAFLMwCgn+DtMdVaRt5j3SBN5Tu3x5R/
VmUAn2Vun6Xwbg52vGhbOeHwaj8r+kxQ
=hvTQ
-----END PGP SIGNATURE-----

--Signature=_Thu__6_May_2010_11_02_14_+0200_5Xd19sLcACEFl.xl--
