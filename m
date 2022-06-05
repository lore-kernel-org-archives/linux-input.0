Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E541AC433EF
	for <linux-input@archiver.kernel.org>; Sun,  5 Jun 2022 14:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiFEOJX (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 5 Jun 2022 10:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344749AbiFEOJV (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 5 Jun 2022 10:09:21 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD0C12AB5;
        Sun,  5 Jun 2022 07:09:20 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-e93bbb54f9so16295809fac.12;
        Sun, 05 Jun 2022 07:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CUN+dqsyPhstkqknpJ8eNvTdarmkfh8OwBzfAPab8/g=;
        b=PC97j8Wizlc3d2asHtaPbfEEaCIcu1r96lMXv2tBmw9E0R6/fdut7ySQPxgC/miIfT
         7+MlkCWomRmurbc1n4+gs6AqDtzBBAlVT8LbujPncbK42p0DWBmf81NGgirtndvwpiyN
         a/rCWZoq2+jDsXKkk3MFgSyhs6zQMwHUOWCuP3UmjR8JA4Dcp1TVYeDVsVTFwJHCc/eB
         xGg+rWQnx6NUHvmOGKtk+xgHyfkEiZwi8Bi4MeaY63UUuHosDAZII/c+ehv8vb1CRHlS
         wFkCSUoGXu7yHL+T3YzuZHycaIkBHV12p6Af8ADhL4XDnlMHwSPhpxoFeFh16UOao+dp
         lleg==
X-Gm-Message-State: AOAM530xXYvP0pzVUWb0nOG+M3f7pEs9TiP+4qlDTlASjsWB+4qqzCbA
        e34KylUD/yYODbbaarDr0w==
X-Google-Smtp-Source: ABdhPJyCEP83/5rwaxtTvFVS5RsQGXffUTR+y/HsNvTPMJp2Y9LJjgyqZREzxDH6aCYuK7uiL10X/g==
X-Received: by 2002:a05:6871:8f:b0:fb:511d:94ff with SMTP id u15-20020a056871008f00b000fb511d94ffmr788542oaa.94.1654438160019;
        Sun, 05 Jun 2022 07:09:20 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.0])
        by smtp.gmail.com with ESMTPSA id y37-20020a4a9828000000b0040e68c9dce6sm6449868ooi.31.2022.06.05.07.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 07:09:19 -0700 (PDT)
Received: (nullmailer pid 3422059 invoked by uid 1000);
        Sun, 05 Jun 2022 14:09:14 -0000
Date:   Sun, 5 Jun 2022 09:09:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Danilo Krummrich <danilokrummrich@dk-develop.de>
Cc:     devicetree@vger.kernel.org, krzysztof.kozlowski@canonical.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org
Subject: Re: [RESEND PATCH v3 2/2] dt-bindings: ps2-gpio: document bus
 signals open drain
Message-ID: <20220605140914.GA3422001-robh@kernel.org>
References: <20220529132638.13420-1-danilokrummrich@dk-develop.de>
 <20220529132638.13420-2-danilokrummrich@dk-develop.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220529132638.13420-2-danilokrummrich@dk-develop.de>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sun, 29 May 2022 15:26:38 +0200, Danilo Krummrich wrote:
> The PS/2 bus defines data and clock line to be open drain, this should
> be reflected in the gpio flags set in the binding.
> 
> Especially, this is important since the clock line sometimes is driven
> by the host while being used as interrupt source.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
> ---
>  .../devicetree/bindings/serio/ps2-gpio.yaml        | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 

Applied, thanks!
