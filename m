Return-Path: <SRS0=uY0c=EP=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42896C2D0A3
	for <linux-input@archiver.kernel.org>; Mon,  9 Nov 2020 06:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2CD3206E5
	for <linux-input@archiver.kernel.org>; Mon,  9 Nov 2020 06:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMvEqhlr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgKIGZ4 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 9 Nov 2020 01:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgKIGZ4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2020 01:25:56 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFCDC0613CF;
        Sun,  8 Nov 2020 22:25:56 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id e7so7131079pfn.12;
        Sun, 08 Nov 2020 22:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F/81CD/tpAk/YJAJpOglCVTQ51K5WZsM+pMWFXAymu8=;
        b=WMvEqhlrvsjGy/QH+5Kup6jYblhCBjzaQ6NMYPE3qGNm9D6v1V5VvPpzt5UW1wT5Pz
         vS6/s+03ZQu3JPHFIlrhvsWzQYi3tAAzeBkbtdQuYMYfpwkgpqe32KDs2eRALS9EJuzg
         GHcc+SCsaB+4iNsWQTJS/YzSoGUS4fuDoeq91zsozHBuLg9p6Qw0IWyTgZ6024PsPry/
         pNBEtmmegHcbyxYS59UvS25/XQLakzIZsedlLAeYtC5T7aQNXxPHiiMhA+X1z6xoE+HK
         aT0I88uSo24jpjW70Dvcwqsm5tIT457iY56xk4GkiWrN2Jm6dTlWIp7g3ZDmjq/tBoBV
         1y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F/81CD/tpAk/YJAJpOglCVTQ51K5WZsM+pMWFXAymu8=;
        b=Fdt9OrWrFxl5nsQRf/6SG9eERiLM5kj52blXL65XRTW1drnREYAztsEaM708nKqq8m
         dQJ1beDLDnxQtcvWKgkMsXCkyciZ+5Unxol0fCFNcH1cvNRyWw67rFftG/1bFFZgNsBn
         YTjrUG3lkEIJGuextDaN5RxqnJz6X4KDHJE4t3OJra86oWOO7nSaPkHYaHvq3tE91s7A
         cYIqA75mzqDqlIFl47dcieY129Jpo3dna6q2SYY4Elpgwt6bDyUm/Smv94Jv6SjAJcjf
         JrBbID58RcfB6ftEXRGQEPmNA1iUT4byYtn3D2Mj9cCei5Iw6aMA7gve0gn11Fn89Y2t
         ZezA==
X-Gm-Message-State: AOAM532ceLcZt9YeTyF3YWiY9g5Aqmhda+lcif8ypPUroaRB6Clp9HFt
        TIzFp9udUKzI/VRm1vxk0iWq76D7OfI=
X-Google-Smtp-Source: ABdhPJxsXc5HK9PIpE3aFVUdoyS4CYt56qL7iu9RW8BES0EFBCjAtDt3ZH9vpO0K32+GucN9IT2ULQ==
X-Received: by 2002:a05:6a00:6:b029:18b:b5a:494c with SMTP id h6-20020a056a000006b029018b0b5a494cmr12603998pfk.81.1604903155542;
        Sun, 08 Nov 2020 22:25:55 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id q6sm9115964pfu.23.2020.11.08.22.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 22:25:54 -0800 (PST)
Date:   Sun, 8 Nov 2020 22:25:52 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>,
        Arjan Opmeer <arjan@opmeer.net>, linux-input@vger.kernel.org
Subject: Re: [PATCH 12/20] input: mouse: elantech: Demote obvious abuse of
 kernel-doc header
Message-ID: <20201109062552.GN1003057@dtor-ws>
References: <20201104162427.2984742-1-lee.jones@linaro.org>
 <20201104162427.2984742-13-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104162427.2984742-13-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, Nov 04, 2020 at 04:24:19PM +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/input/mouse/elantech.c:1837: warning: Function parameter or member 'psmouse' not described in 'elantech_setup_smbus'
>  drivers/input/mouse/elantech.c:1837: warning: Function parameter or member 'info' not described in 'elantech_setup_smbus'
>  drivers/input/mouse/elantech.c:1837: warning: Function parameter or member 'leave_breadcrumbs' not described in 'elantech_setup_smbus'
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Henrik Rydberg <rydberg@bitmath.org>
> Cc: Arjan Opmeer <arjan@opmeer.net>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied, thank you.

-- 
Dmitry
