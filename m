Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F36C433E0
	for <linux-input@archiver.kernel.org>; Mon, 11 Jan 2021 10:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60EBF22288
	for <linux-input@archiver.kernel.org>; Mon, 11 Jan 2021 10:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbhAKKqN (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 11 Jan 2021 05:46:13 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:34595 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbhAKKqN (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 11 Jan 2021 05:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1610361801;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:From:
        Subject:Sender;
        bh=ABYtgL8WCDyJBHLF6uBzBnDslnn/KWxm8J0xpTuAi1M=;
        b=S2I3pbEl+8tgb93bnPRW1+7GiJvLJ++vIvmTvSpFXH0azJTb128PMMdeSoDJtJjGCe
        v8qiitCM7e0PVfBVXvfv/cxoYux8lanViCnGw/aEHwzmW9HPhiHkPKN1NEhc0OL7qkM3
        Zb60731ZNldMNcehLD7LgQA4kv4wGbsNKE1DT5p2ipIW6Hg8wjeZB37USgX14O5XhLbq
        WUPFUYGVx2tSGfBVazU22IahswQkqkjhHoEH8dpd6kwn0A2OR3FkFZrLxyGlh6iBo+B+
        2NldwMfBFaFvHAXmSPShoLNjE3iBX//l+feG/3fRFJNFzGIzmerKD0uy3HsHyXq825gt
        0SIw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8jxIcvGBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id R0a218x0BAhGrgj
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 11 Jan 2021 11:43:16 +0100 (CET)
Date:   Mon, 11 Jan 2021 11:43:00 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Ondrej Jirman <megous@megous.com>
Subject: Re: [PATCH 2/2] Input: edt-ft5x06 - add support for iovcc-supply
Message-ID: <X/wrtAsJlGXqOPih@gerhold.net>
References: <20210108192337.563679-1-stephan@gerhold.net>
 <20210108192337.563679-2-stephan@gerhold.net>
 <20210111083612.swe2bu7mvjzjromg@pengutronix.de>
 <X/wZqiRbx6nmrj0e@gerhold.net>
 <20210111102236.GT4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111102236.GT4077@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, Jan 11, 2021 at 12:22:36PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 11, 2021 at 10:26:25AM +0100, Stephan Gerhold wrote:
> > On Mon, Jan 11, 2021 at 09:36:12AM +0100, Marco Felsch wrote:
> > > On 21-01-08 20:23, Stephan Gerhold wrote:
> 
> ...
> 
> > > > +	if (error)
> > > > +		return dev_err_probe(&client->dev, error,
> > > > +				     "failed to request regulators\n");
> > > 
> > > It would be nice to have a patch in front of this one which handles the
> > > support for dev_err_probe().
> > > 
> > 
> > OK, I can send a v2 with the dev_err_probe() change separated into an
> > extra patch.
> 
> AFAIR Dmitry has strong opinion against dev_err_probe(). But I might be
> mistaken.
> 

Hmm, yeah actually it seems like there was a patch for this already:
https://lore.kernel.org/linux-input/20200827185829.30096-12-krzk@kernel.org/

I guess it's better to not include this here then...

Thanks,
Stephan
