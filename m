Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09390C43381
	for <linux-input@archiver.kernel.org>; Tue, 26 Jan 2021 19:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C111422A84
	for <linux-input@archiver.kernel.org>; Tue, 26 Jan 2021 19:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbhAZFyD (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:54:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731847AbhAYTZH (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 25 Jan 2021 14:25:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14BC720E65;
        Mon, 25 Jan 2021 19:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611602633;
        bh=nrySLm7/A7eddaou+J/ZDcAo7lhvlKmzMlxsL3q0M4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ggQEx57l2mQ2OCtOeTM6CHX2YnwM0F74HTEwigTk5Rq3ZqyIKKQPAU6NMrCyIyETJ
         vFZexrBfv3RLW/T7bHar096AEGN1jOdhbtHQ7vszmge9u/NCqAlA7xNlcnbH/vp6YK
         6MUL23rjHvVORwZwcowdEUKUdGW4hRMVwxQPxP8lukmF/Zr8ZxNfhBJ2dKgy8kUedK
         XxcPf8ZA6S18OuThXBAhSQbJ1ZbDJHrgP8yFY7Vhz8S38ffP+A5XZ5BuY5np+e6rZH
         A5uDTo/HvxjONsrQs9TV2NP87kv1dw8tmEW4ATyVdD4rJPe/nTF75cL7i6Zcdc11Xu
         J/54eaSy7wU/A==
Date:   Mon, 25 Jan 2021 19:23:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 4/7] regulator: Add regulator driver for ATC260x PMICs
Message-ID: <20210125192311.GC4510@sirena.org.uk>
References: <cover.1611165200.git.cristian.ciocaltea@gmail.com>
 <3f48e9f8114cac0557abca88d4437849423793bb.1611165200.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
In-Reply-To: <3f48e9f8114cac0557abca88d4437849423793bb.1611165200.git.cristian.ciocaltea@gmail.com>
X-Cookie: Drive defensively.  Buy a tank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 20, 2021 at 08:23:29PM +0200, Cristian Ciocaltea wrote:
> Add support for the DC-DC converters and LDO regulators found in
> the ATC2603C and ATC2609A chip variants of the Actions Semi ATC260x
> family of PMICs.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAPGp4ACgkQJNaLcl1U
h9BlWAf+JuZI08hBrCPC+JFuCtzlaNFs1m3PQN63qxhdSaf+NxTTI2yWCCn1aY/w
U4/dPglcEB/XiChaNIJnY+i8LMxGGGUcJe5oOaqWXitK295ywVxAeG/NUSzNre4P
uwxCe2p+vM/JjKMPDS8BD3cy2vghQ7VQ96DD+9zSRSPJgCMfSbm3vTsC3zlw9K4M
SmUIspObeWTpVWAUj1TT8y7yofbPBMsfkmfUglpIDp3LTGITU/lX9H7IDF8jycxz
ZicMlfgoriC2GTPpnDgX5xp9eEjnfDAtvjDOliXmj3mKg5lEeiM1MMk+2Q56QS5h
A0pKkkpdBr6XoX3G/NJ08XxFHGGSXQ==
=LLM3
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
