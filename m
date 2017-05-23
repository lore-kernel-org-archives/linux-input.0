From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND PATCH V7 5/7] regulator: da9061: BUCK and LDO regulator
 driver
Date: Tue, 23 May 2017 18:17:21 +0100
Message-ID: <20170523171721.lpqjhakaawnz4prz@sirena.org.uk>
References: <cover.1495546845.git.stwiss.opensource@diasemi.com>
 <ac0c9c0edf9a3a48d8de7a5c07b16b771871796e.1495546845.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w5ixrwk7fifrgbqj"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:44200 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761906AbdEWRRh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 23 May 2017 13:17:37 -0400
Content-Disposition: inline
In-Reply-To: <ac0c9c0edf9a3a48d8de7a5c07b16b771871796e.1495546845.git.stwiss.opensource@diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>


--w5ixrwk7fifrgbqj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 23, 2017 at 02:40:45PM +0100, Steve Twiss wrote:

> This patch was Acked by Mark Brown, a long time ago, way back in Oct 2016
> (https://patchwork.kernel.org/patch/9397787/).
> I have kept Mark Brown's Ack attached because there have been no real
> code changes since then, but I have recently updated the copyright header
> slightly, rebased the code (no changes necessary) and compile tested it
> against x86_64.

> The MFD files which this patch depended on were accepted into linux-next
> by Lee Jones last week. If there is anything in the way of this patch
> acceptance, could you please let me know?

Given that I've acked this and it depends on the MFD changes I'd have
expected Lee to apply it.  If nothing else happens I can apply it after
the next merge window, otherwise either Lee needs to send me a pull
request for the MFD change so I've got the dependency or he needs to
apply this.

--w5ixrwk7fifrgbqj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkkbqAACgkQJNaLcl1U
h9CBowgAgzyAaejHDzDDrmYGX5ZusFRiVhSCk9YjtEl7zyX7RZC5AK5RqWrO7N9C
VYmQVj+hK3T/JV/I/wHfABIhmq2dfOSRjKAFvJmGyetIwvDyOjSnmXpnNw3feyrc
URrCDUjtqCPGYPcex5vSjC9ahSsvoot9qit3sU1dU6SbpvhBefEwGpTW5EeS+Cub
6FdGgQcNr1kaAZAWrc+Q9Z0nCtk4+Y3DQT2bwveUYxI3Fj+u9oCVrTeDpnZJfG1o
jaYNOQQfWS6DDutsT+p1bwncj8NCDDGsHNk7hsxSEXYXpFqQWY7sda/pMjjR86T1
fLuqTh+F5bphR70n8mfwtq7c1Hcwyw==
=wnhk
-----END PGP SIGNATURE-----

--w5ixrwk7fifrgbqj--
