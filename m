From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0290/1285] Replace numeric parameter like 0444 with macro
Date: Tue, 2 Aug 2016 15:31:50 +0100
Message-ID: <20160802143150.GC10376@sirena.org.uk>
References: <20160802105711.703-1-baolex.ni@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="52aklQ8BZHJhx2Z3"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:53172 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755518AbcHBOcT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Aug 2016 10:32:19 -0400
Content-Disposition: inline
In-Reply-To: <20160802105711.703-1-baolex.ni@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Baole Ni <baolex.ni@intel.com>
Cc: dmitry.torokhov@gmail.com, hal.rosenstock@gmail.com, dledford@redhat.com, sean.hefty@intel.com, bp@alien8.de, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, haibo.chen@freescale.com, andrey.gelman@compulab.co.il, afd@ti.com, javier@osg.samsung.com, chuansheng.liu@intel.com


--52aklQ8BZHJhx2Z3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 02, 2016 at 06:57:11PM +0800, Baole Ni wrote:
> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access permission.
> As we know, these numeric value for access permission have had the corresponding macro,
> and that using macro can improve the robustness and readability of the code,
> thus, I suggest replacing the numeric parameter with the macro.

Please split these up and send them independently to the relevant
maintainers with sensible subject lines - a single 1000+ patch series is
far too large and you're CCing random people so it's hard to tell which
patches are relevant (for example the batch I'm replying to here are for
the input subsystem which I don't maintain so I'm not 100% sure why I'm
being copied here).

With this sort of thing it's often best to send one series per directory
or something similar.

--52aklQ8BZHJhx2Z3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXoK7VAAoJECTWi3JdVIfQAWUIAIa510HGKM5JLLJoHm3VFddQ
5die0y8z3OJsUYuhVewFX+f9wUVDC3A4TLH4Dl6nvd+q5y2XtaGHDtvkOG71la52
RYawtfuF0LpPt7bD/7n7foO21aJJFIP8zUYyAa3jVA9JS4GAvemO5kI14Np/ysTM
EXHY//Hb36SS06d0pIdHlvgHOZ9GU0jFSIasZmgOW6qodwbmXGbKV4od96XBBhjp
Wh3AMwX1o9XYyayPzRJriLYPudx4+WcQQEDxBYBaWlkqyFF/tcZJQwHQasjsG6uq
DLIxPZ4eRmXygR4oXDctb45GwowAOtMruv2vwMOBZ7lqAGJ7Iud3Uc8Z9u2It2A=
=kmpJ
-----END PGP SIGNATURE-----

--52aklQ8BZHJhx2Z3--
