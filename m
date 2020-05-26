Return-Path: <SRS0=UvBs=7I=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83BEC433E2
	for <linux-input@archiver.kernel.org>; Tue, 26 May 2020 22:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C6B32075F
	for <linux-input@archiver.kernel.org>; Tue, 26 May 2020 22:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590533547;
	bh=vIOuaLbRAiYJ63AofcACC/Yx4qRLSjxINJKFVeUQe2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yUFN23XzMcqugPrhhQPNb51kz84caB1fDO9v/P6PjUWFIebmzANPbuFIc/dgYzUJg
	 ryr8BxusuLgFyTET3Jot4bA4x5oyYtgBD4FA218rUMUNeo9PDMu/4/G1BfDUFbZEa2
	 hsP0caM75P2kiJoX9gdRbKLbigKzf/CU7y07xDy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392241AbgEZWw0 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 26 May 2020 18:52:26 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37378 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404588AbgEZWvq (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 26 May 2020 18:51:46 -0400
Received: by mail-io1-f67.google.com with SMTP id r2so13592789ioo.4;
        Tue, 26 May 2020 15:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b//O80efuR9XCAH6meLDCFiWRVl9cYjfSg/OL1ItrFE=;
        b=OdBQb42YKxt3NWEXmElfG0qMEQeo0Kk2f3NM+26BZcvGPDLujn20kLiXEN6+GSljKo
         fE1g45r3fdtlCH1cnedylXBRRZC4yBiVxk8ROrKA2QIflzNsic4D8UPq6WaNuLYqpfZj
         t8AJ8slLCw+kFRtkGC7lk80BEfSQqtOi4cyAwJVLnx3f1K61T0u4MqeCewCP/kxqy0ns
         wfoXYW+m/a0P90HUre+ux4JGOLlRdLrC46xtf1pqwZAhtl02GtAk6FG9yybdnj6b8v0K
         2+xb17x8+wz6d3Kseg/0kfcH1RljwONckjSbW2r74I+VOSPNYtHbnUbI846Ry2qPhCrm
         +wkw==
X-Gm-Message-State: AOAM532PcpZVAKQ5vHzPGyV1bpRXazWjytAeb1Y4bH9ASNqscgdY0ImG
        9mTgdUrM0VTQb8liIquI7g==
X-Google-Smtp-Source: ABdhPJyzPZNiAEIXvFn8cBENJZbF+cuL2BgGEDt1Uc90DnYvpmSvolGQ6Om+x4XqHV+RQZDT2HHctg==
X-Received: by 2002:a05:6638:44e:: with SMTP id r14mr3241032jap.53.1590533503186;
        Tue, 26 May 2020 15:51:43 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id p75sm524459ilb.23.2020.05.26.15.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 15:51:42 -0700 (PDT)
Received: (nullmailer pid 536270 invoked by uid 1000);
        Tue, 26 May 2020 22:51:41 -0000
Date:   Tue, 26 May 2020 16:51:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 4/5] dt-bindings: counter: microchip-tcb-capture
 counter
Message-ID: <20200526225141.GA536209@bogus>
References: <20200519083716.938384-1-kamel.bouhara@bootlin.com>
 <20200519083716.938384-5-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519083716.938384-5-kamel.bouhara@bootlin.com>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, 19 May 2020 10:37:15 +0200, Kamel Bouhara wrote:
> Describe the devicetree binding for the Microchip TCB module.
> Each counter blocks exposes three independent counters.
> 
> However, when configured in quadrature decoder, both channel <0> and <1>
> are required for speed/position and rotation capture (yet only the
> position is captured).
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> ---
>  .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 32 +++++++++++++++++--
>  1 file changed, 29 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
