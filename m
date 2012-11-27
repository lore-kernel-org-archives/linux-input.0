From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] Input - arizona-haptics: Add driver haptics module
 on Arizona CODECs
Date: Tue, 27 Nov 2012 06:32:33 +0000
Message-ID: <20121127063233.GT9411@opensource.wolfsonmicro.com>
References: <1353965980-32543-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1353965980-32543-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20121126231122.GA26836@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="flpRHSNNLnUanxKW"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:41433 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755906Ab2K0Gcf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Nov 2012 01:32:35 -0500
Content-Disposition: inline
In-Reply-To: <20121126231122.GA26836@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lrg@ti.com>, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org


--flpRHSNNLnUanxKW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2012 at 03:11:22PM -0800, Dmitry Torokhov wrote:

> > +		mutex_lock_nested(dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);

> You cannot sleep in play() methods.

Sorry, I wasn't getting enough vibrations from the code :)  I just sent
a documentation patch.

--flpRHSNNLnUanxKW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQtF50AAoJELSic+t+oim9zjgP/iMhYsJqWoNtlL+NTS18Iziz
ak1Mf+QVdvy4+LOuIFgfckjsc7qNv1VKmNYVtwaWY85Wi+zqTgZ7Z1tmQ1Wzw4A5
wWNToUpjXd1I5Ace1oP9in+wiw36Yly5mx47R+7VTzHTKG3/CExv59MCdAVRorWE
YVJG6Wndnege5KNLvCVZ8cO+S/OfNouOYzatK2TwHurldosBY43DSsBoakmfmSVp
4eI7Ehbmo4ta14z6Ejda7hu2LPLNTggSP5V3yet3Sdy3FmofSNI1MeYOf1n2L5Uc
A6WBcKGFnEXqiLO2GG7pCdxhk/e0YE9SZR09u8O12/2aSh2te90R6oYFv1aD3Ow4
/Ob9EFHQgutxzIBAG0QaLuAk37LtzSUJJuD1+JuLtEDJK1uK6pBqnt/1bXr9COy2
qVpt5RhHlC7pRupdMM1Rd8ksKY3TW5s7KRwbh70Kd/s/b9GSFFq8CwH1NDycURR9
oS3EwfsTCcZsH7Ruguq7Swbe8NlNpsblQEEN59c8NvkEB/v8gvr43JvH6bcyi6Lx
ZKgny+aU+iWfYiD8puoNMchmB59MFv0Ub2rJixt5eHgDvzP3+H7A61D2pQssGKUD
kalpZrVMNAFa2Vi8tYGiZPUaMaqHJTy/jmHLFy+mlKAOxjoqtd0cnrtxTpNYjnv9
XTmK6hpDwd0zPlCWE8Ln
=n6hn
-----END PGP SIGNATURE-----

--flpRHSNNLnUanxKW--
