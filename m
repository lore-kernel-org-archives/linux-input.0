Return-Path: <SRS0=aG2u=YX=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9BBCA9EC7
	for <linux-input@archiver.kernel.org>; Wed, 30 Oct 2019 14:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89441208E3
	for <linux-input@archiver.kernel.org>; Wed, 30 Oct 2019 14:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572444260;
	bh=pdUv8yrZcsKnvqdHoqOu01NHvCBwYF40ufRwyBiaA9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Se0UvUPPza8Z2Dspba6KNoYUvqb1a+Qnrw0iuASfoRja/fY1cGIX91uP+dbIMNvJc
	 YS1uNYtgQOsjryK3LYg8pYNVFYKECVEoR3evAiLO4ac0NS7QteoNvAIqX/q/dsKsYO
	 iPuwMABR2+UKD8AvDXeuxiIJgNTumAz3//QoYJvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfJ3OEQ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:04:16 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37578 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfJ3OEP (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 30 Oct 2019 10:04:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id y194so2055716oie.4;
        Wed, 30 Oct 2019 07:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LZENjOjFmyezYiGxEO/wBimrkyphD0pCUUhpP3wSbYA=;
        b=VAoRCHTLClvdtFYVjWZK0wxZjI0m9F5RpkbM9dSZNH0zTlCdXwGOHBEr3o8BKcxrLj
         pXQgFzWvMx1lbVPZ9VyM8xF3RWKlcOOHTY6wnf98Lkm4vpHAlCE7HZZol3QuzXVGEBRa
         SDD32imVNcZjj8frQMvIjrUdT795CQ2hiTv7RwAggIc0hXTMoUVWtId09pbiQnZmiZzW
         dTT1xMEhVwf2xDgEGtdXipIebyMqM/0AviSmM0PiwWH9ejJr3UTwCobc7pwoZFW4og9P
         373P5mTnBY7o5XIpmswv+qhf/0R0+L0RTQNzTj36HG0wpORetu4RGtqchSbXSzYJzCRN
         TF4Q==
X-Gm-Message-State: APjAAAUF2DTRQp/rLV6Kc41flBzomqF9DlddfWcZbsFQZH9nn457mEIZ
        xfxg8eDFNFRIUODQG91M56Od92DMxw==
X-Google-Smtp-Source: APXvYqy9QfgVpVNGitqDKbBjh8KZJ0eJt7caUcK4cnWlU27Z+TsCw/YG99rFknF3PL95JPfG2/G3Aw==
X-Received: by 2002:aca:4c8c:: with SMTP id z134mr8550002oia.15.1572444253766;
        Wed, 30 Oct 2019 07:04:13 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j129sm20974oib.22.2019.10.30.07.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 07:04:12 -0700 (PDT)
Date:   Wed, 30 Oct 2019 09:04:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-imx@nxp.com, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/5] dt-bindings: input: tochscreen: ad7879: generic
 node  names in example
Message-ID: <20191030140411.GA4262@bogus>
References: <20191026090403.3057-1-marcel@ziswiler.com>
 <20191026090403.3057-3-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026090403.3057-3-marcel@ziswiler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sat, 26 Oct 2019 11:04:01 +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Update example in ad7879 devicetree documentation to use generic touch
> controller node names.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2: New patch.
> 
>  .../devicetree/bindings/input/touchscreen/ad7879.txt          | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
