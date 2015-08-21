From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ALSA: ac97: Switch to dev_pm_ops
Date: Fri, 21 Aug 2015 09:19:32 -0700
Message-ID: <20150821161932.GE12027@sirena.org.uk>
References: <1440143313-27914-1-git-send-email-lars@metafoo.de>
 <s5hbne1ujxk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="A9k63Mnmpo23fVdx"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:55830 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbbHUQTt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Aug 2015 12:19:49 -0400
Content-Disposition: inline
In-Reply-To: <s5hbne1ujxk.wl-tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org


--A9k63Mnmpo23fVdx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 21, 2015 at 10:25:59AM +0200, Takashi Iwai wrote:
> Lars-Peter Clausen wrote:

> > This patch touches code in both ALSA and the input subsystem. Ideally this
> > patch will be merged via the ALSA tree. Given that the wm97xx touchscreen
> > driver is not seeing too many changes these days the risk of conflicts
> > should be low.

> If Dmitry is happy with this, I'll take this.

He indicated at Plumbers yesterday that he's OK with fixing any
remaining stylistic issues after the merge window.

--A9k63Mnmpo23fVdx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV10+UAAoJECTWi3JdVIfQPBwH/282hfyzITg3CX0lxtE92jqm
NEU8MlmQZ4DPl72e+9O55Ci42qrx7aTmWBPDEYrkj+4AZnx37236D1XK1GA+brQ/
T2Te5S0JJ33nkmkgBLyC8V8EoSZg1cSog4BvXyErGS7HCKrCmgi4tJQwzfH1MsQt
1Ok2EnTYmK7raOTsXsssF4OwsSU7q7vEHNcQ8EisCv7g40yOHKTWx+WvePPMQQ0v
FYrhiHqFa+x7l0lu99+4IjS2tVmzcvuKpp+xMXbc4UVDDbvZPFARZwEaC053DqUD
WAWeWomF/miuy1TwUIZL/It3JrZWqn36mHpA2S9GLIwzV7hDnskkApXEfKT1T5k=
=tkv2
-----END PGP SIGNATURE-----

--A9k63Mnmpo23fVdx--
