Return-Path: <SRS0=KRpH=BA=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF80C433E6
	for <linux-input@archiver.kernel.org>; Tue, 21 Jul 2020 14:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5615D2070A
	for <linux-input@archiver.kernel.org>; Tue, 21 Jul 2020 14:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4P/VrzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgGUOXS (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729116AbgGUOXS (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Jul 2020 10:23:18 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175EFC061794;
        Tue, 21 Jul 2020 07:23:18 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d7so1558774plq.13;
        Tue, 21 Jul 2020 07:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CX4eH9/QUA1u4saPv6izPwaTM6OqoGtAPvD7DC3yquA=;
        b=H4P/VrzK9rOD3lnOaNH0hX9ZLYi7AoWW2siJNnBQYE09LI/XQ3Ip5TyyQg8gqTWv07
         PAC/Ag6TGy+gxyN+27SXJMGJMZvmvNugN22G62XJcK180PdWd6GfbvgzV6XYKSbtHtyF
         SLw5opNeUYvfCMqQwtYHHEMj80bXgD2y237FSBJmnmSYkJW4icj8RfwfHqWHhXWcgQUa
         heDatMhgGWyCk8mTjzc4VKQxp40MAnPCBnqyqQ+46IV6IaN6JiIA/Y59DgOhUL7GfkZf
         jjYJxTTFPdJxwXQGHQd4UDocuApmmkZBebHQmCUP85EIuXxe0eS/quSPus108oRHzqmI
         P9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CX4eH9/QUA1u4saPv6izPwaTM6OqoGtAPvD7DC3yquA=;
        b=bnHAAcn+mybGS8XkiaCVmTf8reUghev6m8iJpufX3MbosUcVjtpLf4fUeV6fRYQkpe
         E7IaHhm3mRGBicL4c2M7mQz5rqgrWPzSme1fJ4VDpEWW7qVV5qL45FTId20GugxjM8rp
         6z1DxAQOucrT2xlKRipgRjuzJAzmRCHFRvCsAZan/3G6NnlVy/FWYKDXFQGw07wdn1i8
         oUhVYDkA3mKeHab0ZsE+eSAkZ7DrC8BgWSst3ltb6VJICnhhrkkblhL6u1cM6g/aVx8p
         Gtm4yq1M167UF6XEyVSVD+r4KhUOmlNlV407scMzrIewlUvwguv0nQ8cjKZu5av/odsL
         YQnQ==
X-Gm-Message-State: AOAM531ESByCZR19nIIcQR/XVTcg3J+Rr+xoyUcBMHYJaVoTf+PLPSeJ
        R32mGAwdxldL5mzRaXQqcXUgQ7TYhAygJf3bXiR55AfmRX4=
X-Google-Smtp-Source: ABdhPJxnpuDyH/u9trmPIq89haOgJSMaTcFCtl639VtNm1WgUMH05ZqjfNiwqqUMlBDkoaI0O0cvoy2rFOxsKhLk8qg=
X-Received: by 2002:a17:902:8491:: with SMTP id c17mr22040941plo.262.1595341397575;
 Tue, 21 Jul 2020 07:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200721022324.21898-1-fengping.yu@mediatek.com>
 <20200721022324.21898-3-fengping.yu@mediatek.com> <87ft9l3v2l.fsf@baylibre.com>
In-Reply-To: <87ft9l3v2l.fsf@baylibre.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jul 2020 17:23:03 +0300
Message-ID: <CAHp75VcnfF3ucuAJXDDy8pit5-LE42d4ROkL2y3QZroK6RU4Rw@mail.gmail.com>
Subject: Re: [PATCH v15 2/3] drivers: input:keyboard: Add mtk keypad driver
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Fengping yu <fengping.yu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, Jul 21, 2020 at 3:38 PM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
> Fengping yu <fengping.yu@mediatek.com> writes:

> > This adds matrix keypad support for Mediatek SoCs.

...

> > +     keypad->regmap = devm_regmap_init_mmio(&pdev->dev,
> > +                                            keypad->base,
> > +                                            &keypad_regmap_cfg);
> > +     if (IS_ERR(keypad->regmap)) {
> > +             dev_err(&pdev->dev,
> > +                     "regmap init failed:%ld\n", PTR_ERR(keypad->regmap));
> > +             return PTR_ERR(keypad->regmap);
> > +     }

Okay, because another comment appeared, I would suggest to switch to
%pe at the same time.

            dev_err(&pdev->dev,   "regmap init failed: %pe\n", keypad->regmap);

-- 
With Best Regards,
Andy Shevchenko
