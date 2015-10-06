From: Stephen Kitt <steve@sk2.org>
Subject: Re: Input: joydev - validate axis/button maps before clobbering
 current ones
Date: Tue, 6 Oct 2015 22:57:26 +0200
Message-ID: <20151006225726.545f4ce5@heffalump.sk2.org>
References: <20151006185155.GA8997@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/twPeg52E9P8uUb8N4k1y3cS"; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 7.mo6.mail-out.ovh.net ([46.105.59.196]:44824 "EHLO
	7.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbbJGBnz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Oct 2015 21:43:55 -0400
Received: from mail95.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo6.mail-out.ovh.net (Postfix) with SMTP id 6AAD6FFABA8
	for <linux-input@vger.kernel.org>; Tue,  6 Oct 2015 22:57:37 +0200 (CEST)
In-Reply-To: <20151006185155.GA8997@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-input@vger.kernel.org

--Sig_/twPeg52E9P8uUb8N4k1y3cS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Dan,

On Tue, 6 Oct 2015 21:51:55 +0300, Dan Carpenter <dan.carpenter@oracle.com>
wrote:
> The patch 999b874f4aa3: "Input: joydev - validate axis/button maps
> before clobbering current ones" from Aug 25, 2009, leads to the
> following static checker warning:
>=20
> 	drivers/input/joydev.c:466 joydev_handle_JSIOCSAXMAP()
> 	error: 'abspam' dereferencing possible ERR_PTR()
>=20
> drivers/input/joydev.c
>    437  static int joydev_handle_JSIOCSAXMAP(struct joydev *joydev,
>    438                                       void __user *argp, size_t le=
n)
>    439  {
>    440          __u8 *abspam;
>    441          int i;
>    442          int retval =3D 0;
>    443 =20
>    444          len =3D min(len, sizeof(joydev->abspam));
>    445 =20
>    446          /* Validate the map. */
>    447          abspam =3D memdup_user(argp, len);
>    448          if (IS_ERR(abspam)) {
>    449                  retval =3D PTR_ERR(abspam);
>    450                  goto out;
>=20
> out labels are error prone.  It's safer to return directly.
>=20
> https://plus.google.com/106378716002406849458/posts/dnanfhQ4mHQ
>=20
> joydev_handle_JSIOCSBTNMAP() has the same issue.

Perhaps I'm missing something here, but that's not the code I wrote, nor is
it the code that's currently in the kernel. What I have in my copy of the
kernel tree is

        /* Validate the map. */
        abspam =3D kmalloc(len, GFP_KERNEL);
        if (!abspam)
                return -ENOMEM;

which does as you recommend. If you look up the commit you're referring to
you'll see that's also the code as I wrote it back in 2009; I'm not sure
where your IS_ERR() and PTR_ERR() stuff is coming from.

Regards,

Stephen

--Sig_/twPeg52E9P8uUb8N4k1y3cS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJWFDW8AAoJEIDTAvWIbYOcdRAP/09q80/7jQ0OMXvxkOkp7+y3
H+7C1wQdJ/vHkYS0xRTVtJLcPYDUIsJfn6tlS9bn972olPF1oz+4DOezu4NNVk16
gNlc26k0vOD+193okIdbn53GSahE6ykZ1d4KiD7jAK9ec4EPH9VN6c23BqMO+OWL
8hQ0TSSg9RupmGOXAOa64//uVULS8c/++93q3ry4jMlAr8vr+PniswKuJTnqZb8f
5FeG4V1aW1NSuPvr9F9HV5fQajXKUsv26VVcyN7amGmX6d4eCsffEcW+61QpYigM
Fw5yUM/m5m+YvnTHolIUllBVZ/r1bzb9WgoyMtXqUwmjcMwREpjcpDNdt2QlnvyX
EBBu7XhzfeBQ04A4jugMvEKmpo5mymx8TJZ0o1QSwABEIwpkeZvTge1vNvM4XBwI
KSo+91yKSd32bqN7CetLa6kUHpaO+oUJ7HmXu7/EnA+SzerCHkwq5e9k/vqCrSva
XyOdrG0eAXD18HrkOy/etOL7e9um0UTHHeBjpRHilLNiFs7iBqYFEn3jlJay0xj8
C0js23QV8IIbSP2h/AjfzznI11TmOkzoAoZzizwrl+1k7QH8jZDU4K4cvKJ7Cg9x
q28gaLmNdDjZq22VvZJ04XIb6/bSEZBiNttXr93IOR3+78QTH91TD2AOS13hJM/l
LXDDeGqBIIdB9N8/Hw19
=I1QK
-----END PGP SIGNATURE-----

--Sig_/twPeg52E9P8uUb8N4k1y3cS--
