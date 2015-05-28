From: Martin Herkt <lachs0r@srsfckn.biz>
Subject: Re: [PATCH] input: elantech.c: add more exceptions to fw version signature check
Date: Thu, 28 May 2015 18:50:10 +0200
Message-ID: <1463627.FQDSaQ0v44@sakuya>
References: <1432830570-31406-1-git-send-email-lachs0r@srsfckn.biz> <5567445D.6070700@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10485110.rU8mNpo2hz"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from srsfckn.biz ([148.251.137.227]:48232 "EHLO srsfckn.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932258AbbE1QuM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 28 May 2015 12:50:12 -0400
In-Reply-To: <5567445D.6070700@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulrik De Bie <ulrik.debie-os@e2big.org>, George Moutsopoulos <gmoutso@yahoo.co.uk>


--nextPart10485110.rU8mNpo2hz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday 28 May 2015 18:37:49 you wrote:
> This is wrong, the bits of param[0] which define the hw version of
> the touchpads are in the low nibble, so your check will also match
> older touchpads where we do not want to skip the rare check.

Oh, sorry about that. Should have paid more attention.
First time poking the kernel after all :)

> I've attached my patch, which actually checks the low nibble of
> param[0]. It has already been tested on an Asus PU551LA laptop,
> so it should work for your laptop too.

Yes, this works. Thanks!

--nextPart10485110.rU8mNpo2hz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EABYIAAYFAlVnR0IACgkQwkuc0E3Grn+gqAEA4ohyR51FYU6el2VboZLg9p+L
3KCnzBF7aMVKTJRJ+B4BAJl5GtPT1Rv0G6et6mtX2SIhPYYm0ylfTZDvB9id7HkG
=H3+n
-----END PGP SIGNATURE-----

--nextPart10485110.rU8mNpo2hz--

