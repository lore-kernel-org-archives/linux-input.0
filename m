Return-Path: <SRS0=RGIC=6U=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63111C38A2A
	for <linux-input@archiver.kernel.org>; Wed,  6 May 2020 12:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4384820575
	for <linux-input@archiver.kernel.org>; Wed,  6 May 2020 12:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HKgt/yuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgEFMtv (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 6 May 2020 08:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728542AbgEFMtu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 6 May 2020 08:49:50 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CA0C061A41
        for <linux-input@vger.kernel.org>; Wed,  6 May 2020 05:49:49 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a21so2170784ljj.11
        for <linux-input@vger.kernel.org>; Wed, 06 May 2020 05:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vGrAL221U5LNFhyomdWD44/6fcd1PnVHrarNM3q/rB4=;
        b=HKgt/yucHxP3oL+g7rj+nOg7Qg8kMDg6w4PXkk9Qk5J32RYqKhXSzTfL2UusXRkZ9r
         O2StDPBYRDXKb+J1PtGUc24f0sARXZnS89BtEMms1cXY+5flaKRfapQ9K7V3s03lll89
         codd1AN2XQZhUsdeXdFmiRNpoBYDAUcyiS0479s0pfBTTnLJwWpyBLJj5SZ+mIJ9zFCj
         PEtcVypA6N3FwlvTcob+epUPeNM+uiS+Cnl3BN1CpVJGlbKygZgVmT8OMBCL1Aos2QIv
         4/mPn1QV6hB/SLg2g4Q0UmozH8hGwGVOYINA418+STfObX11M7ZQPiR/e0tttmUtjlBR
         ddxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vGrAL221U5LNFhyomdWD44/6fcd1PnVHrarNM3q/rB4=;
        b=QbwngQYWW8Ye7oNHABQ9Dlg814dhBjScMalU6hKABPlpSBFs1IWM+pMMDbwcMqk4D0
         ofgxRqBzqFsuKtIrQBBVTERcGFi/TkjX8vCb6Avl6m5C7eDcp53XW9K4/G//ds3tWnKE
         t62aCbyS7GdbOQkyQhgXwV7ZBA3xyr2O01Cqshh4GOogduZLZ83UOLwZQ/vRs2Lu+YHj
         +pUaJvPRJiawzKpqHANcukq7/k4pj34VYiYGZWjutQnYWNVxi3n5UtJ1QzhLIzYxbK5A
         0aEk9UmN5ndrw2BZ6OrR7jn89tiIgKLuJ/jQ5ttF7fc9ZLS0Q//WzhezBbp2pDeu8lXp
         jZbA==
X-Gm-Message-State: AGi0PubVnwHX2x/j2dDkCl9W5zKSEVwNRA2V0zP8uPgPl6CAa3xxfaVP
        10lSDW9WOe5NPoR2uc0uwsZzbUEKLM74P5yhCkz1pg==
X-Google-Smtp-Source: APiQypKsFo3w+1HtO8wBxx6yf4L26hGpogFQ0SkxurfXqdzs9iDJ62nzs6zcG/VDKtCJyrzv6laayACPUSjDv3/Lfjo=
X-Received: by 2002:a2e:8087:: with SMTP id i7mr4455713ljg.99.1588769387748;
 Wed, 06 May 2020 05:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200503172206.13782-1-xc-racer2@live.ca> <BN6PR04MB06609033B2E0AB157A228989A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
In-Reply-To: <BN6PR04MB06609033B2E0AB157A228989A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 6 May 2020 14:49:36 +0200
Message-ID: <CACRpkdY7aSe-MWdWvL-2NC0RKohpgibnod9dnNiS_Wr9eHL-_Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: iio: accel: Add required regulators to bma180
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sun, May 3, 2020 at 7:22 PM Jonathan Bakker <xc-racer2@live.ca> wrote:

> The bma180 and related chips should have two registers attached to
> them.  The IIO driver currently uses them, document them here as
> well.
>
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
