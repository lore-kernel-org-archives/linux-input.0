From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] Input: touchscreen: ads7846: copy info from pdata to
 private struct
Date: Mon, 6 May 2013 11:47:42 +0100
Message-ID: <20130506104742.GZ4945@sirena.org.uk>
References: <1366889633-12577-1-git-send-email-zonque@gmail.com>
 <20130506032444.GD25084@core.coreip.homeip.net>
 <20130506102502.GX4945@sirena.org.uk>
 <5187872F.3040301@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E0GpUEom8qu4+vDz"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:57770 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939Ab3EFKsQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 06:48:16 -0400
Content-Disposition: inline
In-Reply-To: <5187872F.3040301@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, grant.likely@linaro.org, agust@denx.de, imre.deak@nokia.com, chf@fritzc.com


--E0GpUEom8qu4+vDz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 06, 2013 at 12:34:23PM +0200, Daniel Mack wrote:

> But I can browse my reflog and switch back to the other approach if
> that's preferred. The only concern I have is what I already mentioned:
> the allocation of function pointers which are definitely unused for DT.

I don't particularly care either way; what you say sounds sensible.

--E0GpUEom8qu4+vDz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRh4pLAAoJELSic+t+oim996UP/RZTgTmkdx9XoTSyN5PsZ51H
6oFbw+Enmn5I4wZ3ZH8kRy/StQCIt9FL04KO/vY7wCAjnG2DRpbXvC/ruKIpkjrk
9Dit8vWci+3LW6HTbQeWCcvIqrAn6vSUGFNDmc3u2M0vU8FM4Q2H2fhLlMmI4t4w
hQAHnWgjtYaWARcCM71BSl7fiLnhqiw8/nN65c0G8KRhez3r2N0j70MjqV6hrgX5
MfEgxKgyS7iz51vgPPMz9E4hKDdFldNgjywGgdiZkY3wvy3pcRv7OQi3qTjuUtC1
wpHpzqXFAhZNP1VGN61ioPzRmFiDYh2We4DpMS0NDezMJvIW/yzLjzQtu7TSX48N
BL1zDnGyvM3LJyWKVOzfHlcSAXQgy7Ytw5InbYYbnypm4v6CJpp2PiuMnUxRT/hX
nmDP8GGhbPpF8lmLZO3WEmLKFGcqz3boVEbry0TILk/D6iSHz3H7YQoSzEZ1WziL
XJnmNazI+xV6snTijQ5GfGyJx59Pp4JkMf5bF4NvriT8CAU7/nzThDRzfcvjGXpl
AP9h0PwUlN9vP5g19w1z2sn1R/RrCt6abPmRpfNVPcF4vRIKca/KCwgMSOkf2ab8
b6DxINuVbu8z3V68JJIAVRMQ0IkQDSrw+3OdLz83pyg5zjqHKdZsCcwNDV3JzVEh
EYEI/IHc3hEtba0Ah03p
=pcCI
-----END PGP SIGNATURE-----

--E0GpUEom8qu4+vDz--
