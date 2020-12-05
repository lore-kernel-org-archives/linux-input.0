Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B21C4361B
	for <linux-input@archiver.kernel.org>; Sat,  5 Dec 2020 23:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD44E2310E
	for <linux-input@archiver.kernel.org>; Sat,  5 Dec 2020 23:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbgLEXI5 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 5 Dec 2020 18:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLEXI5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 5 Dec 2020 18:08:57 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01FCC0613CF
        for <linux-input@vger.kernel.org>; Sat,  5 Dec 2020 15:08:16 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id q13so12769896lfr.10
        for <linux-input@vger.kernel.org>; Sat, 05 Dec 2020 15:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vwb2HdHtdDZZDHnperwU4T/43GW8HXiYw6+fTYALHZ4=;
        b=SU9Mzn3kxhuqqKEDyZufnK7Jl5GgyAGR9GIYFHUx1XMFG2dsRuvATzgzMS5or8jGoq
         GKpKXyiLgp2N/icq5y6VTiGSgXjgABGy+TP5fYyjJ0Lp35u899seb57zkNzG7xvU7DpY
         MjKoPffW5FbBwPxkXy/5yx4HjPXQBeL15aFY8zEe0wMI0UpjdyUXMTL5AERuEX3qD7LG
         7qq0fcrJaTa6HlYtM8xyptVG3WIrKZ0fV53l/FbgiTBCbpYVPZ9Qw5xhge4F/0ur2SqS
         nj/UMaT20vcuXoNMSlm0bdGoS4yVN6aFYkJO3uqNzw+p8jFZjDUwXUmsJeZDJfEUQuds
         OZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vwb2HdHtdDZZDHnperwU4T/43GW8HXiYw6+fTYALHZ4=;
        b=ScsXkdg4PcQPdWVEzO+sgGuMyIf7nH7DX9U+Ms7zZYPZXuEt1U5Lt5xMz/jUryqjTU
         HJj5jk4CUc5ax2Y4YdoFeZv3o9ABN/r+H1cCkK9gqMWDjTa4oupY8g9b1H7yCAXM2gkz
         gkYtjqIwNPtiz4ExG+a9wMTsTMgvKTKj+Qy8P5y5pki+6c029iAmUE/9ZbeBZ95hzFXZ
         XqvorQq9X4rhxD5P5GKwoO7Ez2LRNg7Gniq/rKkbC8bkTa3zkywExBsPs/vTIwu0BLTq
         3tvOiD0zVLVi1UgPifcBRheum2TvmLo2Tu9peDSs6p0IoOc3I/ZV/Iyvn/s+S6FnNT6x
         VsKw==
X-Gm-Message-State: AOAM533RiTe3PnM0TIQ8Y8ljpf3ByAsXDvNm3WKI+oGZkE9/5tKjtBoI
        2cyPgwEhUkBhELqIvs6DFnLXI16Mdv4jsKCL01nUHA==
X-Google-Smtp-Source: ABdhPJwdF479XZ7ajZEMYz/xc/9Bf8EKg6vkYwWis2eIiU1zHQw8oaYyfgNfyCcFk3hweLjiIOpUj79cCisirDSYA8M=
X-Received: by 2002:ac2:4578:: with SMTP id k24mr5761952lfm.502.1607209695139;
 Sat, 05 Dec 2020 15:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20201203131242.44397-1-stephan@gerhold.net>
In-Reply-To: <20201203131242.44397-1-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 6 Dec 2020 00:08:04 +0100
Message-ID: <CACRpkdY+SUkOZCoPgEOZ005T26hop=Tn-NjG3BwwyVFfWbZOpA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: Input: tm2-touchkey - convert to yaml
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Input <linux-input@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, Dec 3, 2020 at 2:13 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> Convert the device tree bindings for tm2-touchkey to the YAML format.
>
> While we're at it, clarify the descriptions a bit to make it clear that
> this driver can be used for many different MCUs that all implement
> a similar I2C protocol. Depending on the MCU the voltage requirements
> may be different, on some devices the controller uses 2.2V, 2.8V or
> even 3.3V for vcc-supply instead of 1.8V.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

LGTM
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
