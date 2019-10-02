Return-Path: <SRS0=4O58=X3=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AF7C35280
	for <linux-input@archiver.kernel.org>; Wed,  2 Oct 2019 14:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CEE21A4C
	for <linux-input@archiver.kernel.org>; Wed,  2 Oct 2019 14:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570027739;
	bh=wSamQ2IHFj7SsWRiciOuzx5098YJgRPNoXydbfMJ/7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jI24w1Lv4y+74BFIRPKUrnraeVzNyWTpZFU3d3oKIxuv3Odm+l/LzcLFZd2GxLOHs
	 pf6G4wz8WX8q3uMDcgZ/DPcQxC0veOnq8hi6rSAbJxUS8gcr3yQfgt6sWyUPoQtLbq
	 U701PJiy+rEWrO7TZcQcp8n2QVFoK0wL+cxMA+VA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfJBOs6 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:48:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbfJBOs6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 2 Oct 2019 10:48:58 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEC4A21783;
        Wed,  2 Oct 2019 14:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570027737;
        bh=wSamQ2IHFj7SsWRiciOuzx5098YJgRPNoXydbfMJ/7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TEfBr11YqcbzylPi+3x9EYQca1ow+0Z0cPcRcElFGXa5mzdjuBMShT8HLW7p40Imb
         HJ1BCbnnzTulctR/+Hv2cZl4gMVVpyJ2+koKpcMB4Xb2hAfaODLhXicj/R2gllA8iM
         kSQgqRt3WuMZHvnd2eECYvTNC/jGoIjAlyEFVGfY=
Date:   Wed, 2 Oct 2019 16:48:54 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Rob Herring <robh@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        andriy.shevchenko@linux.intel.com, bparrot@ti.com,
        andy.shevchenko@gmail.com, simon.budig@kernelconcepts.de,
        hdegoede@redhat.com, fcooper@ti.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        bcousson@baylibre.com, tony@atomide.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, s.hauer@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, shawnguo@kernel.org,
        wens@csie.org
Subject: Re: [PATCH 2/6] dt-bindings: Input: edt-ft5x06 - add disable
 wakeup-source documentation
Message-ID: <20191002144854.cdpgjzi67dz6bs5x@gilmour>
References: <20190917155808.27818-1-m.felsch@pengutronix.de>
 <20190917155808.27818-3-m.felsch@pengutronix.de>
 <20190917170743.GO237523@dtor-ws>
 <20190917171814.owcttekv56xgmsts@pengutronix.de>
 <20190917172658.GQ237523@dtor-ws>
 <20190930231146.GA30010@bogus>
 <20191002130018.pvgipl6bkcv3dexj@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="64afkyf6eiewiqxb"
Content-Disposition: inline
In-Reply-To: <20191002130018.pvgipl6bkcv3dexj@pengutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org


--64afkyf6eiewiqxb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 02, 2019 at 03:00:18PM +0200, Marco Felsch wrote:
> all of you using a edt,* touchscreen and currently the driver marks
> the touchscreen as wakeup source. To keep backward compatibility I added
> a workaround binding (see below) but Dmitry prefer to use the normal
> "wakeup-source" binding and change the affected device-tree's
> (discussion below). Can you give me your ack/nack for Dmitry's solution?

we don't have any upstrem suspend support on the Allwinner SoCs, so
you can safely ignore all the sunxi DTS here.

Maxime

--64afkyf6eiewiqxb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXZS41gAKCRDj7w1vZxhR
xeG7AQDs7bynAylR4A61FT3oxs+U9x3A7f/3K3lN3Szi6wDWiwEAqw6ZJIly1ljs
BvUnwraDgrFvRAGT4/vKsz3fyTLxRgM=
=usoC
-----END PGP SIGNATURE-----

--64afkyf6eiewiqxb--
