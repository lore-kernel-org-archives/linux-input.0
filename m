Return-Path: <SRS0=6uoY=EF=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4698DC00A89
	for <linux-input@archiver.kernel.org>; Fri, 30 Oct 2020 15:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0ED02151B
	for <linux-input@archiver.kernel.org>; Fri, 30 Oct 2020 15:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604072227;
	bh=piDP34L7yDaL+NISKJuKg/cP0skP9zXEe8+3aMUTnr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KyRFHDKFT6K9MLU12TU8p0VhIHQlNx6qwJQvNr3oT1t0w/dm1nRfD0VfhaAPQrNeM
	 unYqpxT5yhzkphp8oLctvzj/k2pxVFbrsYOjWcETwsN+93zlDtNl0NipmmvLVoIHlt
	 oOgWmqbm+o8MipnFf8cqdtBvCsh8zHQwLXn5MeYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgJ3PhF (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 30 Oct 2020 11:37:05 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39392 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgJ3PhE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 30 Oct 2020 11:37:04 -0400
Received: by mail-ot1-f65.google.com with SMTP id z16so726610otq.6;
        Fri, 30 Oct 2020 08:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ofFXL9c4WfPJ0vh1CrcqW4yOOzqJ5jwhDnFefF3udus=;
        b=oHPFOZlT419zlIqkVRtxWBQiD7ZTouxU45CvLFJHNo+doHw0eFGrUOshY4VtYlhK14
         T6eZzvOdNgg/gp225vV/mPajIZ7F5dFmHHs0in/gU0FgHPAeLm/TrKjvA9JP+QS0GLid
         IAVasBEjgrPG/TVSLRVxTGSawiUdMt7y5vYs8Oi8Y7MPADz3+iS1udp9eQqQz1kAR3QU
         wZMVJsnva8PrOiKyv3UtkSaxA7WJLhyodqjlbdxhWASvRRjuW4aEt3NeiqjmPP3W+omG
         MEpoql9yTfkNvayFuZVzHkhSxfQWBYZWi9VdOXaNzY8SuidcCSZfSILesW2Wv/SWFmlr
         RNMg==
X-Gm-Message-State: AOAM5331bKr6E1PiVH5FRg1ZGH8K1dOQC9x4hD0y2M8ZnpyDGba+ScHc
        TJMbXQQ43oHskxwL9PSA/A==
X-Google-Smtp-Source: ABdhPJycwUiV1vpf0o9YvAtnAVAgs/nLhIp6vbRgzxDr6FgbxTRz8AT2NZiGH5vGAw9RUdLMKfrjGg==
X-Received: by 2002:a05:6830:1345:: with SMTP id r5mr2026633otq.6.1604072223527;
        Fri, 30 Oct 2020 08:37:03 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m13sm1363306otn.20.2020.10.30.08.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 08:37:02 -0700 (PDT)
Received: (nullmailer pid 3888717 invoked by uid 1000);
        Fri, 30 Oct 2020 15:37:01 -0000
Date:   Fri, 30 Oct 2020 10:37:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     devel@driverdev.osuosl.org, linux-pwm@vger.kernel.org,
        Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Eric Anholt <eric@anholt.net>, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, sboyd@kernel.org,
        gregkh@linuxfoundation.org, Ray Jui <rjui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>,
        u.kleine-koenig@pengutronix.de, p.zabel@pengutronix.de,
        dmitry.torokhov@gmail.com
Subject: Re: [PATCH v2 08/10] dt-bindings: pwm: Add binding for RPi firmware
 PWM bus
Message-ID: <20201030153701.GA3888665@bogus>
References: <20201022155858.20867-1-nsaenzjulienne@suse.de>
 <20201022155858.20867-9-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022155858.20867-9-nsaenzjulienne@suse.de>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, 22 Oct 2020 17:58:55 +0200, Nicolas Saenz Julienne wrote:
> The PWM bus controlling the fan in RPi's official PoE hat can only be
> controlled by the board's co-processor.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> ---
> Changes since v1:
>  - Update bindings to use 2 #pwm-cells
> 
>  .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 20 +++++++++++++++++++
>  .../pwm/raspberrypi,firmware-pwm.h            | 13 ++++++++++++
>  2 files changed, 33 insertions(+)
>  create mode 100644 include/dt-bindings/pwm/raspberrypi,firmware-pwm.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
