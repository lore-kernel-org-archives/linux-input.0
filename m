From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ALSA: ac97: Switch to dev_pm_ops
Date: Thu, 20 Aug 2015 09:33:01 -0700
Message-ID: <20150820163301.GA12027@sirena.org.uk>
References: <1438890129-32621-1-git-send-email-lars@metafoo.de>
 <20150806225501.GA24261@dtor-ws>
 <55C468BC.60500@metafoo.de>
 <20150807163213.GB30852@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:53847 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbbHTQd1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2015 12:33:27 -0400
Content-Disposition: inline
In-Reply-To: <20150807163213.GB30852@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, alsa-devel@alsa-project.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 07, 2015 at 09:32:13AM -0700, Dmitry Torokhov wrote:
> On Fri, Aug 07, 2015 at 10:13:48AM +0200, Lars-Peter Clausen wrote:

> > We know that it is used when CONFIG_PM_SLEEP is defined and we know that it
> > is unused CONFIG_PM_SLEEP is not defined. Marking the function as
> > __maybe_unused will cause the compiler to not generate a warning when the
> > function is really unused. Making this explicit works much better.

> It will also drop the code form the final image and having the functions
> in provides better compile coverage.

Just discussed this in person with Dmitry: I'll apply the patch just now
for v4.3 and we can incrementally improve the ifdef handling after.

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1gE5AAoJECTWi3JdVIfQtuUH/jMGzFuODrwvrIAXDF1li+wj
XVhICXTaEQe8WeTNS23tF9Agucq73tjAPFK/DB4YEq1l+xGG5Fwrci3dgZNwB8Jf
zLNwZolhgWeSGy/7YSZ8NXJFXDySMPVIpd1RnW7QKlTE3vmB3zNzlMsCxajYzO6s
sjBuZAeRqyEiJoO2MStxND8lKhJWL0hf5RbELk64HdPGpyVkms5jBnakCLksa6Ji
PC2Bd7RtvvI9qcw3KQh2y577DokUeI2juc9i+7AwdaLri18TyAKrwfXJHu0iZNGo
gSsdGpzKH1QQV1TbayPcJz3qBmFl3aQ05S/HPtdV6Ud26o6S1akHnT9Ydgtf+Tc=
=xg8M
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
