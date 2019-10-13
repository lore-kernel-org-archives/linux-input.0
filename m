Return-Path: <SRS0=szqD=YH=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC28C4360C
	for <linux-input@archiver.kernel.org>; Mon, 14 Oct 2019 00:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1A22067B
	for <linux-input@archiver.kernel.org>; Mon, 14 Oct 2019 00:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfJNAIh (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 13 Oct 2019 20:08:37 -0400
Received: from 8.mo5.mail-out.ovh.net ([178.32.116.78]:35499 "EHLO
        8.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbfJNAIh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 13 Oct 2019 20:08:37 -0400
X-Greylist: delayed 10499 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Oct 2019 20:08:36 EDT
Received: from player793.ha.ovh.net (unknown [10.109.143.79])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id 2E53424FF85
        for <linux-input@vger.kernel.org>; Sun, 13 Oct 2019 23:40:02 +0200 (CEST)
Received: from etezian.org (81-175-223-118.bb.dnainternet.fi [81.175.223.118])
        (Authenticated sender: andi@etezian.org)
        by player793.ha.ovh.net (Postfix) with ESMTPSA id E1807AE3A080;
        Sun, 13 Oct 2019 21:39:51 +0000 (UTC)
Date:   Mon, 14 Oct 2019 00:39:50 +0300
From:   Andi Shyti <andi@etezian.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andi Shyti <andi@etezian.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Simon Shields <simon@lineageos.org>,
        linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Input: mms114 - add support for mms345l
Message-ID: <20191013213950.GB16344@jack.zhora.eu>
References: <20191007203343.101466-1-stephan@gerhold.net>
 <20191007205021.104402-1-stephan@gerhold.net>
 <20191008220014.GI22365@dtor-ws>
 <20191009072612.GA2814@jack.zhora.eu>
 <20191009204017.GK22365@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20191009204017.GK22365@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Ovh-Tracer-Id: 11074914435028337306
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrjedtgddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
Message-ID: <20191013213950.jKQRkULC-scd9s6DPwC5YPX8qx5eO_UcHTcosG0hiNM@z>

Hi Dmitry,

> > > > There was a related patch [2] that removes I2C_M_NOSTART for all models,
> > > > but it seems abandoned and I do not have any other model for testing.
> > > > Therefore, this patch implements the least instrusive solution
> > > > and only removes I2C_M_NOSTART for MMS345L.
> > > 
> > > Hmm,  at this point I am inclined to pick up Andi's patch since it seems
> > > to work for you and him and it looks like Android drivers are not using
> > > I2C_M_NOSTART. I wonder if this was some quirk/big on the platform where
> > > it was originally developed.
> > 
> > I completely forgot about that patch :)
> > 
> > I should refresh some old work on that device which was left
> > undone.
> > 
> > > Any objections?
> > 
> > It's OK for me. If you can just update my e-mail, please, when
> > applying the patch to "andi@etezian.org". Thanks!
> 
> Andi, any chance you could resend it with the new email? One thing that
> I try to avoid modifying whenever I can is S-O-B strings...

sure, I will resend the patches, but it might take some time (a
few days I hope) because I don't have the devices with me right
now for testing (and I added some small fixes, as well)

Thanks,
Andi
