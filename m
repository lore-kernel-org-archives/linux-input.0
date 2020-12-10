Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010E4C4361B
	for <linux-input@archiver.kernel.org>; Thu, 10 Dec 2020 20:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B066F23A7C
	for <linux-input@archiver.kernel.org>; Thu, 10 Dec 2020 20:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390149AbgLJUOZ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 10 Dec 2020 15:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393661AbgLJUOO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 10 Dec 2020 15:14:14 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E12C0613D3;
        Thu, 10 Dec 2020 12:13:33 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id a9so10080593lfh.2;
        Thu, 10 Dec 2020 12:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cubcqPyiVtmFFdXlSvbS5gnpVAJDkak3mmW80ANq1nA=;
        b=m++KLY50+Zb3kDjd7LHlPu9npriqD7Zo9p6ZkdeEmyVpVlGSA5wE8yjd6BRoBeJ8SO
         eKVX43rqnD15JpNTjqC6SyGW8n+E7aHzYxZop1BSBvWo72F+m09Flem2OoVAsBsMoBDa
         dCwYrX61EenFMZVdkiYVy/qIg+r19bnLWKmfC+Z9QZTcH6HmjrVHP3GNwDDaN2mh/vDO
         wk8kPqpUt54nxfbUrBBKNLjIKVV9dsxmZmrz13gCy0Ln2iQRroX908cx68LsAebGCUmS
         Q6JrocxCza5ZHzCutFVY7TDIuP9XYBVAJuq1X5uz5wP+7ci6TI5uh4hOu9S85Wqo5jbi
         iLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cubcqPyiVtmFFdXlSvbS5gnpVAJDkak3mmW80ANq1nA=;
        b=tuj06iK/TPxFOdkFlLdZMrMGoYl/0Yfd8mdLS+i3NrHc+MJmpO7tugn0Mf2suJoNFD
         Y36jqy/vW+iJx/Ea9v8nj32JFjzptLSGvn5XzeMVL2Jrj7ANwc22f21OKh7iAO2tz/oM
         i//KjOLMEI2C8cajdStHqltvfXcI2FrYgE2LcJcdIJXVJZsoFN6XPJYYVV1G5U1keYwi
         OvRwT0/xoJ0IJ287on/Z+jtzdfLasx2lEN+dol1JdUAwE0Fvw/J89PmQj99UNnhsmfph
         9PpSpbaImbKPboLka8vZsdlmInO1rhXuB2Ofyo6be3a0cujTxTw6GAnEWZDuq6Czgul5
         fVww==
X-Gm-Message-State: AOAM530v0vEHXH+0RiCeVe2VM2ResNuC/sEt0EU+j1rel3r3XIhszGQv
        w3mVxrb+iNy04JzZtAEochQLUEq2gVU=
X-Google-Smtp-Source: ABdhPJzpWtIzRb85t6xHbQMz47MlDCrpDWCIaWe+v+ZY5Gp0X0rHdwH14Rcc8vyrFGrzHidhjqyViA==
X-Received: by 2002:a19:8a46:: with SMTP id m67mr3270217lfd.515.1607631211714;
        Thu, 10 Dec 2020 12:13:31 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-205.dynamic.spd-mgts.ru. [109.252.193.205])
        by smtp.googlemail.com with ESMTPSA id w2sm635587lfk.51.2020.12.10.12.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 12:13:30 -0800 (PST)
Subject: Re: [PATCH RESEND v8 0/4] input: elants: Support Asus TF300T and
 Nexus 7 touchscreens
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Hutterer <peter.hutterer@who-t.net>
References: <cover.1604942771.git.mirq-linux@rere.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <76f75e8f-1895-6f51-eb1d-7d212a7e917f@gmail.com>
Date:   Thu, 10 Dec 2020 23:13:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <cover.1604942771.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

09.11.2020 20:28, Michał Mirosław пишет:
> This series cleans up the driver a bit and implements changes needed to
> support EKTF3624-based touchscreen used in Asus TF300T, Google Nexus 7
> and similar Tegra3-based tablets.
> 
> ---
> v2: extended with Dmitry's patches (replaced v1 patches 3 and 4)
> v3: rebased for v5.7-rc1
> v4: rebased onto v5.7-rc2+ (current Linus' master)
>     update "remove unused axes" and "refactor
>       elants_i2c_execute_command()" patches after review
>     add David's patch converting DT binding to YAML
> v5: rebased onto dtor/input/for-linus
> v6: rebased onto newer dtor/input/for-linus
>     remove yet unused constants from patch 1
>     added a new drive-by cleanup (last patch)
> v7: rebased onto current dtor/input/for-next
> v8: rebased onto current dtor/input/for-linus
> ---
> 
> Dmitry Osipenko (1):
>   input: elants: support 0x66 reply opcode for reporting touches
> 
> Michał Mirosław (3):
>   input: elants: document some registers and values
>   input: elants: support old touch report format
>   input: elants: read touchscreen size for EKTF3624
> 
>  drivers/input/touchscreen/elants_i2c.c | 149 +++++++++++++++++++++----
>  1 file changed, 127 insertions(+), 22 deletions(-)
> 

This patchset missed another kernel release cycle and touchscreen
hardware remains unusable on Nexus 7 [1] and other Asus devices.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi?h=v5.10-rc7#n845

Dmitry Torokhov, could you please take a look at the v8 and let us know
whether it's good already or something needs to be improved?
