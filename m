From: Florian Echtler <floe@butterbrot.org>
Subject: Re: [PATCH v3] add sur40 driver for Samsung SUR40 (aka MS Surface
 2.0/Pixelsense)
Date: Tue, 12 Nov 2013 14:35:07 +0100
Message-ID: <52822E8B.6030906@butterbrot.org>
References: <1383748012-28880-1-git-send-email-floe@butterbrot.org> <20131111073105.GA7645@core.coreip.homeip.net> <5280AC87.4020905@butterbrot.org> <5280B0FE.5080203@euromail.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="AwU5Q0leexfS4vosi1eSgeeEBbS46sNRP"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:33542 "EHLO butterbrot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754749Ab3KLNfN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Nov 2013 08:35:13 -0500
In-Reply-To: <5280B0FE.5080203@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, dh.herrmann@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AwU5Q0leexfS4vosi1eSgeeEBbS46sNRP
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11.11.2013 11:27, Henrik Rydberg wrote:
>  >> Also, does the patch below mess up or device or it still works?
>> I'll test this tomorrow (no access to SUR40 today). If everything work=
s,
>> should I resubmit my patch with yours included or just tell you that
>> it's fine?
> No need to resubmit, a confirmation will do nicely. Thanks!
> Henrik

I've tested Dmitry's additional patch, confirmed to work. Just for the
record:

Tested-by: Florian Echtler <floe@butterbrot.org>

BR, Florian
--=20
SENT FROM MY DEC VT50 TERMINAL


--AwU5Q0leexfS4vosi1eSgeeEBbS46sNRP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlKCLosACgkQ7CzyshGvathZ6QCg9HNdcPgu3bydjHeoF0FxBZlj
X3gAnR/HgXmfyjg8MgCIAYH+9SUMUlDR
=KfM3
-----END PGP SIGNATURE-----

--AwU5Q0leexfS4vosi1eSgeeEBbS46sNRP--
