From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH: RESEND] Update email-id of author
Date: Mon, 27 Apr 2015 20:50:52 +0100
Message-ID: <20150427195052.GC22845@sirena.org.uk>
References: <1430119562-14816-1-git-send-email-rajeevkumar.linux@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fIeM2UqBLUBfNdiZ"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40028 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbbD0TvX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Apr 2015 15:51:23 -0400
Content-Disposition: inline
In-Reply-To: <1430119562-14816-1-git-send-email-rajeevkumar.linux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rajeev Kumar <rajeevkumar.linux@gmail.com>
Cc: dmitry.torokhov@gmail.com, a.zummo@towertech.it, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, alsa-devel@alsa-project.org, rtc-linux@googlegroups.com, akpm@linux-foundation.org, rajeev-dlh.kumar@st.com


--fIeM2UqBLUBfNdiZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 27, 2015 at 12:56:02PM +0530, Rajeev Kumar wrote:

>  .mailmap                                     |    1 +
>  arch/arm/mach-spear/generic.h                |    2 +-
>  arch/arm/mach-spear/include/mach/irqs.h      |    2 +-
>  arch/arm/mach-spear/include/mach/spear.h     |    2 +-
>  arch/arm/mach-spear/spear6xx.c               |    2 +-
>  drivers/input/keyboard/spear-keyboard.c      |    2 +-
>  drivers/rtc/rtc-spear.c                      |    4 ++--
>  include/linux/platform_data/keyboard-spear.h |    2 +-
>  include/sound/designware_i2s.h               |    2 +-
>  include/sound/spear_dma.h                    |    2 +-
>  10 files changed, 11 insertions(+), 10 deletions(-)

Please split this up into per-subsystem patches so it's easier to apply.

--fIeM2UqBLUBfNdiZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVPpMbAAoJECTWi3JdVIfQ7UwH/0K/e3IB2Sa/2rTAKf7WX18u
uaZAFc760g8wSmyLIZq/YF1erSQYaHfwu9AMUnp3TAWHtCGXaPn/81bqQ0JXhIsc
Ljvy/AbHbzwMa3SAnP3/s5rJvd92G3wUm1CjV83heUh8KyBBSEkuzWCoGo/UjZxF
FS5+VcuKeCP0AwSufiQ+gJn1B/mhkuQHXHVM4Z+smgsL8hwKY6y9rANkfdtfHDh+
waR4omPKHw1kgyp0XKafkQwcL0v00pPyfaRsGVM0AEpi6IMWLtP0Z5h9br9mTujy
Sxrl7ExJlKxVenWmDIm0OI+dfGU0YM++CmipCNi4QeWfWzD/UEhPh5DXwr1QwoE=
=vpKH
-----END PGP SIGNATURE-----

--fIeM2UqBLUBfNdiZ--
