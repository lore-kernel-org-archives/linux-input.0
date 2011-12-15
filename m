From: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] input: signedness bug in cma3000_thread_irq()
Date: Wed, 14 Dec 2011 21:27:15 -0500
Message-ID: <12775.1323916035@turing-police.cc.vt.edu>
References: <1323672566-16738-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1323916035_2907P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lennier.cc.vt.edu ([198.82.162.213]:50891 "EHLO
	lennier.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755863Ab1LOC1S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Dec 2011 21:27:18 -0500
In-Reply-To: Your message of "Mon, 12 Dec 2011 01:49:26 EST."
             <1323672566-16738-1-git-send-email-xi.wang@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

--==_Exmh_1323916035_2907P
Content-Type: text/plain; charset=us-ascii

On Mon, 12 Dec 2011 01:49:26 EST, Xi Wang said:
> The error check (intr_status < 0) didn't work because intr_status is
> a u8.  Change its type to signed int.
>
> Signed-off-by: Xi Wang <xi.wang@gmail.com>
> ---
>  drivers/input/misc/cma3000_d0x.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/misc/cma3000_d0x.c b/drivers/input/misc/cma3000_d0x.c

That will fix the signed/unsigned issue.  However, was there a reason
the field was an 8-bit-wide to begin with?

--==_Exmh_1323916035_2907P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFO6VsDcC3lWbTT17ARAn69AJ96UuKJDzCv61DL5GyNr1/V+n1LCgCgiFlq
lNcRNQJ1S3082GWov4TpFBk=
=f98b
-----END PGP SIGNATURE-----

--==_Exmh_1323916035_2907P--

