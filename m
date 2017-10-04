From: Mark Brown <broonie@kernel.org>
Subject: Re: [Regulator] Request for clarification - GPIO controlled
 regulator, USB VBUS,
Date: Wed, 4 Oct 2017 11:32:13 +0100
Message-ID: <20171004103213.4ezs6ie6z6dq7pvh@sirena.co.uk>
References: <c4ba36d3-c495-8ddf-9aa7-3e25e5b44672@majess.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="inm5twnnmeo4bxij"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60586 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbdJDKcQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 4 Oct 2017 06:32:16 -0400
Content-Disposition: inline
In-Reply-To: <c4ba36d3-c495-8ddf-9aa7-3e25e5b44672@majess.pl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?Q?=C5=81ukasz?= Majewski <l.majewski@majess.pl>
Cc: linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>


--inm5twnnmeo4bxij
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2017 at 06:58:00PM +0200, =C5=81ukasz Majewski wrote:

> Have I overlooked something? Maybe there is any other mainline code, whic=
h I
> could reuse?

No, we don't support randomly toggling power for devices without their
cooperation - it's not generally going to end well.  The reason it's
difficult to do this is that it's a bad idea.  Perhaps this is something
that could be implemented generically for USB as it's a hotpluggable bus
but I'm not convinced.

--inm5twnnmeo4bxij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnUuK0ACgkQJNaLcl1U
h9DMvQf/dlWIFsqPNSE1blawAgh6Ur+y19I5CR51RXNqBdXzWXn8xi9xre4GuOQ9
lOe6RgWygOCvLmWB6LrtTwKIj4TPgrk3GsvimwNlnTpK3ru74gqBE8w+iVNbcWy9
Z/hEcWk64Y4g//F6h5cqKBZZ59ZAGG2fXLqN/b4X+QwPTe/vRRS+E9hU7RKRJirI
yKCkml7RldAPnVKa/dY407qhnG+5KeO/grTjusjHj7u+ODIsQYAO6Qv64DO6Hc3o
itBz0o4tkwfoP7rJ4V6dyZv5fN6ySoCRzecAJ6scIMsbUkdchChriyyReiPRNvOM
vdVmAux+9RJPuna4zxHKDnIAPRsg2g==
=vMZg
-----END PGP SIGNATURE-----

--inm5twnnmeo4bxij--
