Return-Path: <SRS0=PhcK=CZ=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B80C433E2
	for <linux-input@archiver.kernel.org>; Wed, 16 Sep 2020 06:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 788FB21D7D
	for <linux-input@archiver.kernel.org>; Wed, 16 Sep 2020 06:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600236395;
	bh=U6lfdq5Z5bwZ24KqwURAAzz5yhP2cgUVn12Cy9cE4ds=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bBtYuQYmqAEDU/M/5zBvrjllplosj+SMBicgxYxgA7FXAH39aHuPDnlnaD0snAbHa
	 M5PTOjitVuy1LoXZVuD4PbJOebZek7hcEQ7T2Rfw1nkQS2kr5UY0iXwvWC8xOX4q6A
	 dp3C8E5VLdYpC2ueikjX8mZFFI65ZJtu5fUAHV3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgIPGGe (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 16 Sep 2020 02:06:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726093AbgIPGGe (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 16 Sep 2020 02:06:34 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46CA5221E5;
        Wed, 16 Sep 2020 06:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600236393;
        bh=U6lfdq5Z5bwZ24KqwURAAzz5yhP2cgUVn12Cy9cE4ds=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=huLTFENqc8cld6OUesuosVn7xrdIxeN3uKGDyjG5F6exNyPgC1oiadsDIGigA4e5I
         ZGRkcuAUmchsx2p0410TCzc8yChkHG8nMb+nK879C+vQwR2Mh8pZJ8Q/nY8aqwPM4u
         0pMdLtUSFaDUYr5UcadN3RMNwIbcy7/GsYlX7sGU=
Received: by mail-ej1-f53.google.com with SMTP id p9so8584042ejf.6;
        Tue, 15 Sep 2020 23:06:33 -0700 (PDT)
X-Gm-Message-State: AOAM533X5W8iya0eEHZ9aHE16stizwDpnZdt0/q7L+qhRn1HYfMyOQDx
        aUBXmTgYAUmTP53jE1flC0prgneZ2PUFUtR1QQM=
X-Google-Smtp-Source: ABdhPJyPBiRtR+Hb1jazRB3djHeAzVp8UncHE+p7s1eiOctaHHBa4dpN0Pdot92mECEB3DNgWeOmejJaLj6E59zEbs8=
X-Received: by 2002:a17:906:82d1:: with SMTP id a17mr23566817ejy.385.1600236391690;
 Tue, 15 Sep 2020 23:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200828145744.3636-1-krzk@kernel.org> <20200828145744.3636-2-krzk@kernel.org>
 <20200916005359.GE1681290@dtor-ws>
In-Reply-To: <20200916005359.GE1681290@dtor-ws>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 16 Sep 2020 08:06:20 +0200
X-Gmail-Original-Message-ID: <CAJKOXPf5kjJitS=7_9wTWMmM4L1TwSnpdhspR9dQXpY2LH1y=g@mail.gmail.com>
Message-ID: <CAJKOXPf5kjJitS=7_9wTWMmM4L1TwSnpdhspR9dQXpY2LH1y=g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] Input: omap4-keypad - Fix handling of
 platform_get_irq() error
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-input@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 16 Sep 2020 at 02:54, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> On Fri, Aug 28, 2020 at 04:57:42PM +0200, Krzysztof Kozlowski wrote:
> > platform_get_irq() returns -ERRNO on error.  In such case comparison
> > to 0 would pass the check.
> >
> > Fixes: f3a1ba60dbdb ("Input: omap4-keypad - use platform device helpers")
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > ---
> >
> > Changes since v1:
> > 1. None
> > ---
> >  drivers/input/keyboard/omap4-keypad.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
> > index 94c94d7f5155..b075f1af0305 100644
> > --- a/drivers/input/keyboard/omap4-keypad.c
> > +++ b/drivers/input/keyboard/omap4-keypad.c
> > @@ -240,10 +240,8 @@ static int omap4_keypad_probe(struct platform_device *pdev)
> >       }
> >
> >       irq = platform_get_irq(pdev, 0);
> > -     if (!irq) {
> > -             dev_err(&pdev->dev, "no keyboard irq assigned\n");
> > -             return -EINVAL;
> > -     }
> > +     if (irq < 0)
> > +             return -irq;
>
> You must have meant just "irq", right?

Damn it, of course. I'll send a v2 for this.

Best regards,
Krzysztof
