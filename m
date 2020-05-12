Return-Path: <SRS0=3AEP=62=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C84C2D0F9
	for <linux-input@archiver.kernel.org>; Tue, 12 May 2020 21:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2168920661
	for <linux-input@archiver.kernel.org>; Tue, 12 May 2020 21:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589317441;
	bh=aqivytCV1VWXk93uBvfqsdAKPbjk/Zja2il/5EJ6kkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0mANi+/U8PzFJrJVzzjAJ88z8rkLG7/Hp9N9j87u7W5YZtKVPcJ78ywv2giR56TcG
	 NOUomMjbuwrDLUHfLhibLDpLtl48tN5DcbQ81VDmmyfoF3DrGtmegX7NDS9uF74aMa
	 CfGYMW90+kpNwHYbk4QFwKf3gt4JJexduNT3wWR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgELVEA (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 12 May 2020 17:04:00 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34197 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbgELVEA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 12 May 2020 17:04:00 -0400
Received: by mail-ot1-f65.google.com with SMTP id 72so11747577otu.1;
        Tue, 12 May 2020 14:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SlmOp4Ja0L99f4dWfudYD8NFO8K357bjpSbWG5NFFuU=;
        b=BLZ35eu6x7I+3knoLjTklV9bUeQCvXEKXYthlad+xm6vdDngl/5lMrYcnuuJu2ZNC/
         O74J8q3X4X1uUB4CH5wbqutWJveJ0G1GFK3V3xGgCWZoeVMiAkgjSWzm054wpZeZLcar
         dwKdDoaSklw7pu9qrVl/yuye6rLA2CRW55XEI/+tHfMNtYxdwggj4t2kN/d1uqWtEigU
         8fDYag04mZps0A5nGaJyvDcOad8mkGaRS+jaPXlmxoRDO8vnoH14w8jhphmn9h9Way1a
         ZOfjSDuv+2aJf762BAXtad7g+oJ82ixlujNyFoVCt7D0sDhGhjHH7JLrxkt2f6xtW+G5
         e6zw==
X-Gm-Message-State: AGi0PuYdEjmqHfgwiMkH3rguNJOV+hgPnmp5UIB9SP+D95bVfG5CtpK1
        imoGCIbYMNptZdYkugcSp4Vn50bq6A==
X-Google-Smtp-Source: APiQypIpJoMM+8ajeFgZmBI2vfHIZsLum9JoFijx5dPXwjtrNdAuMIu2sBIysLWIbFHg6ePwVVwG0g==
X-Received: by 2002:a05:6830:1e1c:: with SMTP id s28mr17726799otr.207.1589317439227;
        Tue, 12 May 2020 14:03:59 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w14sm3929257oou.46.2020.05.12.14.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 14:03:58 -0700 (PDT)
Received: (nullmailer pid 24483 invoked by uid 1000);
        Tue, 12 May 2020 21:03:57 -0000
Date:   Tue, 12 May 2020 16:03:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: input: Add bindings for Azoteq
 IQS269A
Message-ID: <20200512210357.GA24425@bogus>
References: <1588352982-5117-1-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588352982-5117-1-git-send-email-jeff@labundy.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri,  1 May 2020 12:09:41 -0500, Jeff LaBundy wrote:
> This patch adds device tree bindings for the Azoteq IQS269A
> capacitive touch controller.
> 
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> ---
> Changes in v2:
>   - Removed '$ref' and 'allOf' from properties with a unit suffix
> 
>  .../devicetree/bindings/input/iqs269a.yaml         | 581 +++++++++++++++++++++
>  1 file changed, 581 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/iqs269a.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
