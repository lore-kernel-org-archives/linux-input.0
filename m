Return-Path: <SRS0=/2A/=Z3=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD92C43603
	for <linux-input@archiver.kernel.org>; Thu,  5 Dec 2019 21:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EA92245C
	for <linux-input@archiver.kernel.org>; Thu,  5 Dec 2019 21:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575580561;
	bh=Lb1o7EVP6Zavy8CFuV7+uxkBdTgm97p2EwRVOXWDqUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SiJZJhUW3FAsR4kGEPwfyWT0+EXOzETDaZLzeDth/0uHD6svjU3zUAzHel2hjENEc
	 5Q7WR4RLmA0M9HPX+jD1xrI/zIl+VJm+1vPTGPecHB0KACQFICs/1dmpvNb6uyJIcr
	 dicP5O9kUybSdq2lknId1uPAG+bEz4jl0L8G+K+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfLEVQA (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 5 Dec 2019 16:16:00 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45486 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbfLEVQA (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 5 Dec 2019 16:16:00 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so3891877otp.12;
        Thu, 05 Dec 2019 13:15:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bMEPgFnBcKMSD8dtJPMDYYn6pR51fgydSuOlX9FkuK0=;
        b=KT8ZTplnSrVXl0zzSk4TNqik4Xjmg3dvrHcuCQMdwUA0icZrUGC9x4VNDymNo2AR1D
         u9BFl9g3K8Q2vAYHy9zWjYKVMW8/NzBzNm2BOc/oS6y+cQq5Q29ntoNQDmS+urfwWxm+
         +uRf7+soJww0gsEotX6r7ja1NHHPgaui53fFrZGLIBiIn1D5P6CkFzjN8ATA3H7hM+lo
         dFFkEE7255POFL2zDkZQ2c9wCV72SzvjTXwBb+2qLkW87nWLfej8RCBYr6B4/ZsnhAq/
         WmAjVyD49HvdLvPmh+e6+XvnWKERoAYPo22icWWQCwurJvpYthTtgSrlaTZZXTDsd2lp
         dHsw==
X-Gm-Message-State: APjAAAXY2alCeE5bdZXAeka5KQ/Cmod9JZ2tDCU+lHaQnOQqhsxCfLcs
        Bq6cXRyPeYSdu/6tt75NjA==
X-Google-Smtp-Source: APXvYqxJ34BuvnBNl8qqmmfGsvnglkGM+dvCwO8QTEHOQg+QsUOlrJsGBfcCWGh/FxUQd5JT5epaAw==
X-Received: by 2002:a9d:53c2:: with SMTP id i2mr7842890oth.43.1575580559384;
        Thu, 05 Dec 2019 13:15:59 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m2sm3934618oim.13.2019.12.05.13.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 13:15:58 -0800 (PST)
Date:   Thu, 5 Dec 2019 15:15:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
        dmitry.torokhov@gmail.com, bparrot@ti.com,
        andy.shevchenko@gmail.com, simon.budig@kernelconcepts.de,
        hdegoede@redhat.com, fcooper@ti.com, mripard@kernel.org,
        alexandre.belloni@bootlin.com, shawnguo@kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v2 3/5] dt-bindings: Input: edt-ft5x06 - document
 wakeup-source capability
Message-ID: <20191205211558.GA31631@bogus>
References: <20191127120948.22251-1-m.felsch@pengutronix.de>
 <20191127120948.22251-4-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127120948.22251-4-m.felsch@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 27 Nov 2019 13:09:46 +0100, Marco Felsch wrote:
> The current driver behaviour was to enable the wakeup-source everytime.
> After discussion [1] we decided to change that behaviour so the device
> will act as wakeup-source only if the "wakeup-source" dt-property is
> present.
> 
> The patch adds the binding documentation to enable the wakeup-source
> capability.
> 
> [1] https://patchwork.kernel.org/patch/11149037/
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> v2:
> - make use of common dt-property wakeup-source
> - adapt commit message
> 
>  .../devicetree/bindings/input/touchscreen/edt-ft5x06.txt        | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
