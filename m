From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] Input - arizona-haptics: Add driver haptics module
 on Arizona CODECs
Date: Tue, 27 Nov 2012 09:36:52 +0000
Message-ID: <20121127093652.GA4468@opensource.wolfsonmicro.com>
References: <1354000088-30517-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1354000088-30517-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20121127090820.GB25658@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42052 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758253Ab2K0Jgz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Nov 2012 04:36:55 -0500
Content-Disposition: inline
In-Reply-To: <20121127090820.GB25658@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 27, 2012 at 01:08:20AM -0800, Dmitry Torokhov wrote:
> On Tue, Nov 27, 2012 at 07:08:06AM +0000, Mark Brown wrote:

> Leaking haptics memory.

Meh, sorry - that was supposed to be devm_kzalloc().

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQtImkAAoJELSic+t+oim911gP/iZLFG9QNumuzE3KJJESy27i
+3iwZx1AE1gBloitbkrtPsqKZcjZYWbtMkxKj9rfxURInwQaNYUG3wgDTjXZKiFL
mTkHsNXkuKDUx94P8igc167hmw2pJivZyimwd9UdfcZxEtqe8/MuhhyCiCWJJNwA
EmlVLCQNxNyUHnpFDlJOHaj9EUXOW0hmPv7Zk1brcCH9QDvOsQ/eBrXeNx8hRWT/
6lx6Kew9t8tmwQwIU3mWGG4mqSaVsf6QyV/IE+qVqxo0+hinFFDI1/9Rl9ABMzh5
JM/Idlw4oLMCHNVGU/iIz2dIHfJszxu13Q4tTkqPPZtmuaxkaNZp34oXV39otdTg
JmKo41ThtCPNilleFy01qNo2lEaBhxZ0YD9D0au9Qq2jGxM7bJd1Qo2Jwzxi0ZuI
H+2cLKfMYx9z2iybMbtHWMo8cl3Lb06yw2sKn2MZFOXRQMjp+3yLsaEtT2oHJrz/
7nGHOVI5ly8NrnLE2eiJN7BT0MKHGdeEdLq5VyYjF7Qzc3kkwTRii+uUyYQczD/I
DT6PDJRCqKeii4oGJef4d8iclWQ7EHhHHzE08TGmOE18LHviI8kiLc3Awyo+MFeS
isBOnTrmXT1q2Jtc59GStPnzQC9U1WQlgPP2jgU/v3MJTi0vuPxRykja/piEgG+j
kmoIWCbdmVY9yWqTNneg
=vp7V
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
