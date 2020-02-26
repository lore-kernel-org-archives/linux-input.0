Return-Path: <SRS0=liY9=4O=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2780C4BA21
	for <linux-input@archiver.kernel.org>; Wed, 26 Feb 2020 22:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA3424656
	for <linux-input@archiver.kernel.org>; Wed, 26 Feb 2020 22:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582755930;
	bh=mg6dzG/WgsYu9t3EEzVjFdHk6TYhs05igqiDo1+Pjtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eybIgFxVN2WYl6nEwvS7dPug66/2KMGDCsuETvicMXnO1Ob3rfXt70rybGlEbr2vq
	 +Q2gIic2xijI4DVmIA7lZzDY0hcvphBEub0knR4XxUf6kLjvhVSnDfy9ieb+X26qf4
	 l0Xwvfr/aiFiYZryL61IZgcabNxBo0heiMfbUAGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgBZWZa (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:25:30 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34525 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgBZWZ3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Feb 2020 17:25:29 -0500
Received: by mail-ot1-f68.google.com with SMTP id j16so1063843otl.1;
        Wed, 26 Feb 2020 14:25:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=avYIifKx3Q5UEDnzXS25Xo1efX9Nlv15wS/Qu2SYdCQ=;
        b=aEV0nC9JE4snmfosxxMRH5klfwrICNFLA/1xBFLf+rbNTaRI+1hKo/kYiQjOqXFbCM
         2trgFLtRi7XY3TEjjqhywfDd3++R3mADbOoGHNyGkcclGxAqJZ2jQResUZlLcskkE8g6
         Wl+k7YvD84UvJGWHY8Z0Yeu5cJsYdxoZ5ic9vCfK1/qTlT0QS0x0pYigXigDzVWGEqLQ
         rLbXQ3W6hw+8XGu2rItDRb2AP1VcmFuIjFFiLSxKbtvaNNtMO2krNqEze85qdaSjFoAd
         JAaWCrVrPUyxLWp9xpmImnMQwja6+xhSVli/TVosC3xq320dhDrLAvJHFqjacokomC+t
         1W6Q==
X-Gm-Message-State: APjAAAWxBiV/aYEgv5fEedK/i5t5QN6Ubf0jV7dj6c9fwYywZ20lDF9d
        CSRuZeeG/5lE5eSSSNg97A==
X-Google-Smtp-Source: APXvYqy70eMmGeAQQjPlOc/swdaYFhmxzrPny5uElx1N2JaEXx2dbW4X1RR9hj7enW903joWn14Y2A==
X-Received: by 2002:a9d:4c06:: with SMTP id l6mr850012otf.161.1582755928886;
        Wed, 26 Feb 2020 14:25:28 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c7sm1258552otn.81.2020.02.26.14.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 14:25:28 -0800 (PST)
Received: (nullmailer pid 12464 invoked by uid 1000);
        Wed, 26 Feb 2020 22:25:27 -0000
Date:   Wed, 26 Feb 2020 16:25:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Luca Weiss <luca@z3ntu.xyz>, Tomas Novotny <tomas@novotny.cz>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: input: gpio-vibrator: Don't require
 enable-gpios
Message-ID: <20200226222527.GA12402@bogus>
References: <20200222231428.233621-1-megous@megous.com>
 <20200222231428.233621-2-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222231428.233621-2-megous@megous.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sun, 23 Feb 2020 00:14:25 +0100, Ondrej Jirman wrote:
> It is possible to turn the motor on/off just by enabling/disabling
> the vcc-supply.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  Documentation/devicetree/bindings/input/gpio-vibrator.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
