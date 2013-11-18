From: Florian Echtler <floe@butterbrot.org>
Subject: Re: [PATCH v3] add sur40 driver for Samsung SUR40 (aka MS Surface
 2.0/Pixelsense)
Date: Mon, 18 Nov 2013 15:50:39 +0100
Message-ID: <528A293F.3050600@butterbrot.org>
References: <1383748012-28880-1-git-send-email-floe@butterbrot.org> <20131111073105.GA7645@core.coreip.homeip.net> <5280AC87.4020905@butterbrot.org> <5280B0FE.5080203@euromail.se> <52822E8B.6030906@butterbrot.org> <52875AEF.2010109@butterbrot.org> <20131116180838.GA21591@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="G65rsd36MojlnlC5SHI4g49fF6fxU5SKX"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:47144 "EHLO butterbrot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167Ab3KROum (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Nov 2013 09:50:42 -0500
In-Reply-To: <20131116180838.GA21591@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, dh.herrmann@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G65rsd36MojlnlC5SHI4g49fF6fxU5SKX
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Henrik,

thanks for the info, sorry for me being such a nuisance :-)

I'll submit the patch to the Ubuntu kernel team once it's merged into
Dmitry's tree, would be great to see this in the next LTS version.

Best regards, Florian

On 16.11.2013 19:08, Henrik Rydberg wrote:
> Hi Florian,
>=20
>> Looks like the sur40 driver didn't make it into the 3.13 pull request,=

>> anything still missing/broken? I was hoping this might still make it i=
nto
>> Ubuntu 14.04...
>=20
> Nothing is broken, don't worry. If you want to make sure to hit a
> certain merge window, then everything should be set and applied
> several weeks before that, to allow for automatic testing and
> administration. It could be that Dmitry is stacking up for a second
> pull request in a couple of weeks, but I would not count on it. If you
> want Ubuntu to pick your patches up, you can always try to send them
> to kernel-team@lists.ubuntu.com; they might be willing to carry your
> patches to the next kernel release. It helps to refer to the
> appropriate commits in linux-next.
>=20
> Thanks,
> Henrik
>=20


--=20
SENT FROM MY DEC VT50 TERMINAL


--G65rsd36MojlnlC5SHI4g49fF6fxU5SKX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlKKKUAACgkQ7CzyshGvathTlACggzwWzSquil8zVEnzr0vPvKkQ
YKsAn0WAtOCVkq5ryDRTUtif80uhVI8f
=JvLh
-----END PGP SIGNATURE-----

--G65rsd36MojlnlC5SHI4g49fF6fxU5SKX--
