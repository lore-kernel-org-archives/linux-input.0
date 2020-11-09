Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C60C55ABD
	for <linux-input@archiver.kernel.org>; Mon,  9 Nov 2020 21:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F50620789
	for <linux-input@archiver.kernel.org>; Mon,  9 Nov 2020 21:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbgKIVho (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 9 Nov 2020 16:37:44 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45601 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbgKIVhn (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2020 16:37:43 -0500
Received: by mail-oi1-f196.google.com with SMTP id j7so11855097oie.12;
        Mon, 09 Nov 2020 13:37:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W+KR0yJBmbMDDeIPd0H7Smh/TQS3Huh+/o0TS/ugewM=;
        b=cbxXMfUSersa+u6rfvh4WScBjF0oxvMyH5UwPOx7Sa3byScZwhVYrYBpUNvAXinRDJ
         592Xdeu/3yRXQtjDzeUWfxgTRNAKtn5Di5C7q1AmU/qOTyAXWCUOdEKjHpSyvnyf7cJf
         A9vv0ZR2KdYXhBXcUIJ9rlUqdu54O912Kla9RjDzMfE3BTEsc3RQ4azydFC0gTtMYBjp
         XjhMT0KAi2FDpSt/2pm4aEH6In8Bkd6NCXpzaOCRhLIOS7GaBLL8mjWwq2nlCjVc657S
         mxfMIy28MQibcLBP8FQGBGhKrV0FnXr2mCZgd3Fz7RJjlIv/R3Si/PmDVUIXG8ZsKsCF
         y+FA==
X-Gm-Message-State: AOAM532jPD1GzBe3ohdGHvCizNLWe3rQdBPfGJdroODlPigVqiEcqhOM
        edAbKaAemQB7idoOQLk9g29IrVlqPQ==
X-Google-Smtp-Source: ABdhPJzfGE202DhhObC7AaSKL2vd2oAkxhu3u1O5UyUGlbadiTDZ7oVC4DtjK9Uyc0bkEKufC6w7Jg==
X-Received: by 2002:aca:cf0c:: with SMTP id f12mr800903oig.139.1604957862595;
        Mon, 09 Nov 2020 13:37:42 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s189sm2660577oig.46.2020.11.09.13.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:37:42 -0800 (PST)
Received: (nullmailer pid 1799914 invoked by uid 1000);
        Mon, 09 Nov 2020 21:37:41 -0000
Date:   Mon, 9 Nov 2020 15:37:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrej Valek <andrej.valek@siemens.com>
Cc:     nick@shmanahar.org, hadess@hadess.net, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: goodix
Message-ID: <20201109213741.GA1797317@bogus>
References: <20201029170313.25529-1-andrej.valek@siemens.com>
 <20201106100539.6646-3-andrej.valek@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106100539.6646-3-andrej.valek@siemens.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, Nov 06, 2020 at 11:05:38AM +0100, Andrej Valek wrote:
> Add information about option how to disable FW loading for each boot.

Again, fix your subject.

> 
> Signed-off-by: Andrej Valek <andrej.valek@siemens.com>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/goodix.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
> index e7d9404c86ab..8b0fa25ae96e 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
> @@ -53,7 +53,7 @@ properties:
>    touchscreen-size-x: true
>    touchscreen-size-y: true
>    touchscreen-swapped-x-y: true
> -  touchscreen-do-not-load-fw: false
> +  goodix-do-not-load-fw: false

Why is this incremental on v1?

And that's not how vendor prefixes on properties work.
