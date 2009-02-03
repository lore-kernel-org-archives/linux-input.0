From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] sh: maple: Add support for VMU devices (v3) [1/3]
Date: Tue, 3 Feb 2009 11:30:42 -0500
Message-ID: <200902031130.45507.vapier@gentoo.org>
References: <1233671486.6512.8.camel@localhost.localdomain> <1233671742.6512.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2196167.7PJLGleKEi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:42206 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751572AbZBCQas (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 3 Feb 2009 11:30:48 -0500
In-Reply-To: <1233671742.6512.11.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: greg KH <greg@kroah.com>, dwmw2 <dwmw2@infradead.org>, Paul Mundt <lethal@linux-sh.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, MTD <linux-mtd@lists.infradead.org>, linux-sh <linux-sh@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>

--nextPart2196167.7PJLGleKEi
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 03 February 2009 09:35:42 Adrian McMenamin wrote:
> +static int __init vmu_flash_map_init(void)
> +{
> +	maple_driver_register(&vmu_flash_driver);
> +	return 0;
> +}

still not returning maple_driver_register() ?
-mike

--nextPart2196167.7PJLGleKEi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iQIcBAABAgAGBQJJiHE1AAoJEEFjO5/oN/WBMqwQANgUvI9w4Ne/Wg2XdblbSIit
fAtudm7MfopAisRVG/L5sE5UirD65kZe9G96HBifR9WZweJz1sETQn9bJ4Jtr8iR
6TXAmLEDEGHKwUG4gL+PnF31HSONmpolP/P3V7loS4wLxoRUFcHVdrU6bTQD3vuY
Y8A61iO8e7yAj7l/wXsHRsZTrliTLQGLZ7Tw8dcaJYmGdaOj/hAgqgSROpY7Mecc
+otbQ1vZg00cCWceqnZoM2JV40PwnhfPZgSnLA8IDanWc5cH4n6OHxExJ10cZjx9
Q5r9pgTLxYucPjyJ2Obr32aiPQOL6jjCbJXqFOk4iWdliOmUKvHpZvX1s3gnl8Uy
/lbd+2CNKwI8tfCPJGo8B4DRfzM8oB1f7JcIMGiXIdkrHxuDHHDEUjMiBkaChlsW
sgcYHSa5nTLknS5C9w5Hb4v1jabDGbMru6LBWo04cxrnohpkNd8ybIEPvPFYVl8e
INjWKT/S6pw6C9YI/feYhdsyKcyBD4yGesXp7mV+DYmPZuT8YggLIZueLlFSrQC+
Xmh1Q14Qz+x9kM0/CjMMbPnTDlbZUBx3VUkTIvRyg4r33fFGIdMVaglY6usy5SdN
dRZijjVwHL/ABmSy2k6yqe4y6ZQcMIZAoywxJCj/YIaHbRh6hXQSIffVjn5mF5zf
0qAAsLAmE5i2dYGkqUBd
=PWzR
-----END PGP SIGNATURE-----

--nextPart2196167.7PJLGleKEi--
