Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7EAC433DB
	for <linux-input@archiver.kernel.org>; Tue, 22 Dec 2020 17:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3999523133
	for <linux-input@archiver.kernel.org>; Tue, 22 Dec 2020 17:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgLVROt (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 22 Dec 2020 12:14:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:39308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbgLVROt (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 22 Dec 2020 12:14:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7374023130;
        Tue, 22 Dec 2020 17:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608657249;
        bh=66GEWSPJvzklIeHSRZpHVnCFR+8HJC+nKGb813bV9hI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aWs69kfw6Bu8vPoRm2mstM8cN5qc21cRYPUxea3N6r6e7jMT1rC4QPXZFbG1nQTSj
         80RmGS/kZR5s3vEUg57DgvdNXdHY9+qz0nXaIGOV/bCPh9jtUkfW0biDFkaPdjGO7C
         CPckUBTitQeTJn+0KSAIlVZ8d9WMZWlg/xot+gMfIC6sBR8y3w3UbTv8DExf5ZXkd5
         OsG4f0NxluCb1z9xA0rEcUYweusb35BWT4NrRInpBFXsYEbuoDIU5wAKkuZlNEhBQO
         wXekjpo5AkOVBPVRe+kbLym/4TXTDNET7R50Pw4JZOVdanEu3kSVIqnLrdb/bmawxe
         /qJfMLdp3TiMg==
Date:   Tue, 22 Dec 2020 17:13:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Drop unnecessary *-supply schemas properties
Message-ID: <20201222171353.GC5269@sirena.org.uk>
References: <20201221234659.824881-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
In-Reply-To: <20201221234659.824881-1-robh@kernel.org>
X-Cookie: Truth can wait
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 21, 2020 at 04:46:59PM -0700, Rob Herring wrote:
> *-supply properties are always a single phandle, so binding schemas
> don't need a type $ref nor 'maxItems'.

Acked-by: Mark Brown <broonie@kernel.org>

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/iKVAACgkQJNaLcl1U
h9BQcwf+IyZrHbhUmoHb97rb0P395HOZ2TPnUA9AQrgEIQGiygf98JpHLjKBN7aJ
VUR66urIU4NRzpPl8BA55GEgZvCF5U+n6S/vSUWJcHgMFMGgCZGwFzZnhoytB7TJ
0qvxrT1+fasUg2ioSOGjpCnCDxVbQL0Wdyk6MkpVXLG7cOLJcCnm0Gvuw1Ph8MQV
k6DuRiPuCOzSjYUnXeu/gsgkBUj78/WI3FBMa3CsNjytiYXIq26Za/m5U03be47y
N/MGGcnNdxeIMx+TwUBgJNickvKltn6FLuKWzPgltB5d8D07JSupjWwC7Ybndx0b
M+e04W6kW75K2MskhF6Ef1e4F3qMGg==
=eF01
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
