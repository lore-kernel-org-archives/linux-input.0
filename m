Return-Path: <SRS0=z9W1=CF=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79335C433DF
	for <linux-input@archiver.kernel.org>; Thu, 27 Aug 2020 09:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DC15206F0
	for <linux-input@archiver.kernel.org>; Thu, 27 Aug 2020 09:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+A3o94s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgH0JKz (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgH0JKz (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Aug 2020 05:10:55 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199FDC061264;
        Thu, 27 Aug 2020 02:10:55 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ds1so2298225pjb.1;
        Thu, 27 Aug 2020 02:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zfXi5d3mlCppdqQ2hYdd4r5e/pgAh2PtV/2Ut1n+dts=;
        b=V+A3o94souHoyQ/DSNP5DW7JMiE2mnBr2ayyZqWoi/57RVL8Otn17AXnetknQ/LGeX
         YEwDhPo6Ebqb3rL7bKV7snzoBAlHStwUym25IzQlXbtn9E0BWjpXpKCSPpahtBoDm/JT
         zWCdI5+P+czuwoXKYl4MQFTq1rI/ihMGGaHFyKJy4lil3q0s4Rf2y492frnCs5gUIBGp
         bvJsdZj7tpinUBEQNxVZksURUG2s6iBHnN2SLnVJmXVPhJrsLMTsYsQm/L4E02CPoCDR
         S9kIB1E09A9z+GT2UvDwiUxhNeYBYGcymreNJbR5ySOA/eyLDwBzvGDgMMZG3GJEOo3B
         ftEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zfXi5d3mlCppdqQ2hYdd4r5e/pgAh2PtV/2Ut1n+dts=;
        b=fPyS2Uti7AgTT0zJ1MBSRYWGXkAdZrPR9L9UGS9E/YxSGus3xQFzPvkg4q2lmt1mmX
         mImzI48JE18NsNH++CYoqIFTjnv7FQhJ+HxlECtrDAlLRtXoMLBEASIbLgkaZJz6PbbU
         iNawMb8m1XJrMQXuvNekGvYLQSn36rdubn+XlZzATppQGOpWNfnoS8D0GtfmXm+LAHYV
         yCkDEB0ymfCmIZE0Yxt/TXSqY7cOkm8W8oLs5Q+ZIeLJJ2PIo7WnIx7o5eV8fA7PAAMD
         HEUGLOG//pq5Zjy+yBz0Os4REm5ZPSz6hJaUeMvcq69kPgAFcQeVIp8mSjQcMPbu5zWO
         J/vA==
X-Gm-Message-State: AOAM533ScgnEMfMfMOxKKGQnBgmepmjo9DfyilInOsn5vOQuDrOhCte0
        tSWA2/q1aewqUufJ9p6QEkv7rzGyYIMFJrxzgl8=
X-Google-Smtp-Source: ABdhPJxhHCNjbIpnW9qEHIjLMO9dEXQz8uHpU8gG2px1Fsc4WFW0weBqsozFBJGzgjp30/FSRXAoAXSkYL7kZHM6AP4=
X-Received: by 2002:a17:90a:e7cb:: with SMTP id kb11mr9445292pjb.181.1598519454568;
 Thu, 27 Aug 2020 02:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200826181706.11098-1-krzk@kernel.org> <20200826181706.11098-9-krzk@kernel.org>
In-Reply-To: <20200826181706.11098-9-krzk@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Aug 2020 12:10:38 +0300
Message-ID: <CAHp75VevroOYYYBnCAHUqhkkeYcAHLrSwnT3wnxj1Mc4k8sfng@mail.gmail.com>
Subject: Re: [PATCH 09/24] Input: bu21013_ts - Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bastien Nocera <hadess@hadess.net>,
        Sangwon Jee <jeesw@melfas.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, Aug 26, 2020 at 9:19 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.

>         ts->cs_gpiod = devm_gpiod_get(&client->dev, "reset", GPIOD_OUT_HIGH);
>         error = PTR_ERR_OR_ZERO(ts->cs_gpiod);

> +       if (error)
> +               return dev_err_probe(&client->dev, error, "failed to get CS GPIO\n");
> +

if (IS_ERR())
 return ... PTR_ERR()...


-- 
With Best Regards,
Andy Shevchenko
