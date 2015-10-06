From: Stephen Kitt <steve@sk2.org>
Subject: Re: Input: joydev - validate axis/button maps before clobbering
 current ones
Date: Tue, 6 Oct 2015 23:01:50 +0200
Message-ID: <20151006230150.598b24f0@heffalump.sk2.org>
References: <20151006185155.GA8997@mwanda>
	<20151006225726.545f4ce5@heffalump.sk2.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/q=ayd25Q3PUxPZPVevLKf31"; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 13.mo6.mail-out.ovh.net ([188.165.56.124]:36815 "EHLO
	13.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbbJFViy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Oct 2015 17:38:54 -0400
Received: from mail95.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo6.mail-out.ovh.net (Postfix) with SMTP id 28C9BFFABAB
	for <linux-input@vger.kernel.org>; Tue,  6 Oct 2015 23:01:54 +0200 (CEST)
In-Reply-To: <20151006225726.545f4ce5@heffalump.sk2.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-input@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

--Sig_/q=ayd25Q3PUxPZPVevLKf31
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Oct 2015 22:57:26 +0200, Stephen Kitt <steve@sk2.org> wrote:
> On Tue, 6 Oct 2015 21:51:55 +0300, Dan Carpenter <dan.carpenter@oracle.co=
m>
> wrote:
> > The patch 999b874f4aa3: "Input: joydev - validate axis/button maps
> > before clobbering current ones" from Aug 25, 2009, leads to the
> > following static checker warning:
> >=20
> > 	drivers/input/joydev.c:466 joydev_handle_JSIOCSAXMAP()
> > 	error: 'abspam' dereferencing possible ERR_PTR()
> >=20
> > drivers/input/joydev.c
> >    437  static int joydev_handle_JSIOCSAXMAP(struct joydev *joydev,
> >    438                                       void __user *argp, size_t
> > len) 439  {
> >    440          __u8 *abspam;
> >    441          int i;
> >    442          int retval =3D 0;
> >    443 =20
> >    444          len =3D min(len, sizeof(joydev->abspam));
> >    445 =20
> >    446          /* Validate the map. */
> >    447          abspam =3D memdup_user(argp, len);
> >    448          if (IS_ERR(abspam)) {
> >    449                  retval =3D PTR_ERR(abspam);
> >    450                  goto out;
> >=20
> > out labels are error prone.  It's safer to return directly.
> >=20
> > https://plus.google.com/106378716002406849458/posts/dnanfhQ4mHQ
> >=20
> > joydev_handle_JSIOCSBTNMAP() has the same issue.
>=20
> Perhaps I'm missing something here, but that's not the code I wrote, nor =
is
> it the code that's currently in the kernel. What I have in my copy of the
> kernel tree is
>=20
>         /* Validate the map. */
>         abspam =3D kmalloc(len, GFP_KERNEL);
>         if (!abspam)
>                 return -ENOMEM;
>=20
> which does as you recommend. If you look up the commit you're referring to
> you'll see that's also the code as I wrote it back in 2009; I'm not sure
> where your IS_ERR() and PTR_ERR() stuff is coming from.

After further investigation I'm guessing this is
https://lkml.org/lkml/2015/10/2/370, so cc'ing Javier and Dmitry.

Regards,

Stephen

--Sig_/q=ayd25Q3PUxPZPVevLKf31
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJWFDa+AAoJEIDTAvWIbYOc4ckP/jF8Y0PI0+o7VYe2dvpK7CDn
iZO1/BYYBjGRF7SLAfpBT8K0b13IHVPgZDFPxLDyuOC1xFdprwNQSWZlde4tzWB5
7YQ0tGhFUiQ+CosLzq5P+wivV/CqgztNbpWPgk1gOlYbLkJbCagjgfahSKdKa0RG
6Rwpko8oe2simPnP0Zeh5j3bQDdAxwxMLCGSWcksINF4jX8JjkVmNaxllflS95XL
kuXcOzMnpIMy76JV1GZxr4IiIqoSUVzT7g0gUYqsVj7ACAV9VPGP/jocjIlETviB
6BIYBNVlVWIYlDUVXOO1XCeRX1SCh426v46CBVvKXupKnZIUAAKtzCJ9gT0/ZrN6
PdnW9JZLaczgyae99a6uyLuTwMo/rWu6CWcgbir15LQQTmkmOeV7Vf72MgGkGFo1
KlBzFlZM8748wb4gRIzp4Y1ZnHtM/pXyiB1o9jtrkKrElM8CLjDMipAX1gcrkUcV
1uf3n7IVibPwDs2iSNMzDiDf5GdbUbKI/VRaz76M7rBQBUH3yAKPgECwEJ+VtXRU
w0HBBDdJDfKUUtmpDj0dkGlmc0R16cENOc/Hj2UqwPHX//SN5hsc9FrlJNb1YLvo
qcYa6H9sJHHeRx7lUA9rzSsE+E5herq2/3z3DVk7maXZ/IzHOF29nqU6r0zfhUM3
kwZ9uUHytpYz4eBDrlVS
=ZpX2
-----END PGP SIGNATURE-----

--Sig_/q=ayd25Q3PUxPZPVevLKf31--
