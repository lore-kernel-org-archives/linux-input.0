Return-Path: <SRS0=szqD=YH=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62149C4360C
	for <linux-input@archiver.kernel.org>; Mon, 14 Oct 2019 00:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A12207FF
	for <linux-input@archiver.kernel.org>; Mon, 14 Oct 2019 00:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbfJNAnh (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 13 Oct 2019 20:43:37 -0400
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:34941 "EHLO
        15.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729180AbfJNAnh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 13 Oct 2019 20:43:37 -0400
X-Greylist: delayed 8699 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Oct 2019 20:43:36 EDT
Received: from player692.ha.ovh.net (unknown [10.108.54.9])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id 3A13C25214B
        for <linux-input@vger.kernel.org>; Sun, 13 Oct 2019 23:05:07 +0200 (CEST)
Received: from etezian.org (81-175-223-118.bb.dnainternet.fi [81.175.223.118])
        (Authenticated sender: andi@etezian.org)
        by player692.ha.ovh.net (Postfix) with ESMTPSA id D37F7AC93ED3;
        Sun, 13 Oct 2019 21:04:56 +0000 (UTC)
Date:   Mon, 14 Oct 2019 00:04:55 +0300
From:   Andi Shyti <andi@etezian.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andi Shyti <andi@etezian.org>,
        Simon Shields <simon@lineageos.org>,
        linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Input: mms114 - add support for mms345l
Message-ID: <20191013210455.GA16344@jack.zhora.eu>
References: <20191007203343.101466-1-stephan@gerhold.net>
 <20191007205021.104402-1-stephan@gerhold.net>
 <20191008220014.GI22365@dtor-ws>
 <20191009104740.GA107000@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20191009104740.GA107000@gerhold.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Ovh-Tracer-Id: 10484942885523210989
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrieelgdduheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
Message-ID: <20191013210455.UfDrhX_xKEoPP_3YaykDkL9AgAbMT_y6ABWyuivfnDE@z>

Hi Stephan,

> > > There was a related patch [2] that removes I2C_M_NOSTART for all models,
> > > but it seems abandoned and I do not have any other model for testing.
> > > Therefore, this patch implements the least instrusive solution
> > > and only removes I2C_M_NOSTART for MMS345L.
> > 
> > Hmm,  at this point I am inclined to pick up Andi's patch since it seems
> > to work for you and him and it looks like Android drivers are not using
> > I2C_M_NOSTART. I wonder if this was some quirk/big on the platform where
> > it was originally developed.
> > 
> > Any objections?
> 
> I cannot really speak for any of the other models, but no objections for
> removing I2C_M_NOSTART from my side. I'm actually rather confused by it
> since it is used on the first partial message.
> 
> The documentation [1] says:
>   If you set the I2C_M_NOSTART variable for the first partial message,
>   we do not generate Addr, but we do generate the startbit S.
>   ** This will probably confuse all other clients on your bus,
>   so don't try this. **
> 
> Yet, someone felt like trying this here. ;)

still it should be specified in the i2c protocol of the device,
if it's not, then most probably it's not needed, I guess.

Andi
