From: Florian Echtler <floe@butterbrot.org>
Subject: Re: [RFC] surface-input
Date: Mon, 09 Sep 2013 10:25:50 +0200
Message-ID: <522D860E.4020909@butterbrot.org>
References: <52289209.2070707@butterbrot.org> <5229D7CF.4090401@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fPVEHu5Ok5qChSU9whDU5euQRAppNWbai"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:56747 "EHLO butterbrot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750934Ab3IIIZx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Sep 2013 04:25:53 -0400
In-Reply-To: <5229D7CF.4090401@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fPVEHu5Ok5qChSU9whDU5euQRAppNWbai
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06.09.2013 15:25, Benjamin Tissoires wrote:
> Some generic comments:
> - please always inline the code in the message, it is *much* easier to =
review and comment it
> - please directly use a patch format: if the code is good, Dmitry can t=
ake it directly through his tree
> - add the following people for further submissions:
>   * Henrik - multitouch maintainer in the kernel, and I'm sure he will =
be happy to see this stuff
>   * Dmitry - input maintainer, the driver will go through his tree, so =
it's better to let him know as soon as possible of the different discussi=
ons.
> - please stick to the kernel formatting guidelines (without orders: do =
not use C99-style ("// ..."), do not mix tabs and spaces, stick to 80 col=
umns, etc..). The whole documentation is in Documentation/CodingStyle, an=
d use the script scripts/checkpatch.pl to validate most of these.
> - I don't think a separate ".h" will be accepted as the declarations wi=
ll not be used outside of the driver. Just merge the header on top of you=
 .c file.

Benjamin and David, thanks for your feedback. I will integrate this and
get back to you with a proper patch ASAP.

I have one additional question which is more about "future-proofing"
this driver. The SUR40 hardware does also provide a raw video image from
the touch sensor over another USB _endpoint_. Since it's not a different
_interface_, this can only be handled in the same driver as far as I can
tell. At some point in the future, I would like to add a V4L2 interface
to also support the video endpoint - are there any issues I should
already try to watch out for in the input part?

Thanks again, and best regards, Florian
--=20
SENT FROM MY DEC VT50 TERMINAL


--fPVEHu5Ok5qChSU9whDU5euQRAppNWbai
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlIthg4ACgkQ7CzyshGvatgOAACffIV5+qNNC1EKG3Me8URSQcth
CZoAoL5Qw+gJZOdeYUWmBuUSB27gKJli
=H58W
-----END PGP SIGNATURE-----

--fPVEHu5Ok5qChSU9whDU5euQRAppNWbai--
