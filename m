Return-Path: <SRS0=PhcK=CZ=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980C1C433E2
	for <linux-input@archiver.kernel.org>; Wed, 16 Sep 2020 20:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DE9721973
	for <linux-input@archiver.kernel.org>; Wed, 16 Sep 2020 20:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkIZ1Yz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgIPUWI (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgIPR3O (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 16 Sep 2020 13:29:14 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469FCC06174A;
        Wed, 16 Sep 2020 10:29:11 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l126so4388244pfd.5;
        Wed, 16 Sep 2020 10:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l5QENNkdAGMuTC5nW+iy9KsmDtcHDjxhRO+rPJdPpPM=;
        b=nkIZ1Yz1wfmopDGdAEt3hWupDEXkUSS2QDMSF+v9DPARbfQn6vsqnk8bCov1jPMn0g
         4pa8QZzKZdN88lkxxeCOw5BlWjiXdOJgAL0RThOFEVSPu0mUFsbo54bWePy/sGrnNSKl
         ZN5e8Y8mcrfC7NfnclUreQzj9thUQRob/6UsGMSvhRk3NDf2oBLZFxd8GjDN9RjmrljZ
         YxkLzqD/3RcS73PZWRjcWZZ6EoDdKYg0S4c1o+Fd6nYe0V1vir9f0Mz+XJm8TcKtDxSH
         S3Rr82PuU/NL59rs9DU0VBgx2qTeMy4yHtcANIrc7//6jaARjy49MtCEi3tYS1DpKXJD
         BINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l5QENNkdAGMuTC5nW+iy9KsmDtcHDjxhRO+rPJdPpPM=;
        b=laWEl8iCtcmCzPnn6z9qfOn0e0C+jGnw2w7l12Akg1rYEuEXIpLHosbIGLAi2k4cjI
         dmTuAyTT9XAseGKwExEkEOygUrxLWXnOGwb2X9uaGs3kLvxoo5D5Zwy4dtNpIStvdArg
         ADF+/RBLpGVHswegXwSkM3KuBWmlNFa9Pd6LJFk5jIliEDZMDEweHIjp8148InsTDydr
         +9xX2eEU7PYaJzDVZXFuCeVV9DpnICpe2JTQu8YPofC7O8CDLz0dGHeDTXFeJb49gK/K
         YOr8LkQXIRm81NYN3I7Tbc26uGfeociHfSwyrpkojXMQ4G/WsvG80GZJf10Db9Yphkta
         E1bQ==
X-Gm-Message-State: AOAM530P099OAEYnYVmS04LF4Ub+HEsx3QC9kp1cbyhLMEd+TmpJdTkc
        W2e17lto6+w4InisZ5Of1hVfEfUJqvM=
X-Google-Smtp-Source: ABdhPJxmtmqYNX393z5XpwmaQERqHPEt7Mlp1Syuz6+p5V+ykLZgZDqJP1FGN2p2enupG+I2XQqgeQ==
X-Received: by 2002:a63:6881:: with SMTP id d123mr19452899pgc.370.1600277350575;
        Wed, 16 Sep 2020 10:29:10 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id gd17sm3230369pjb.6.2020.09.16.10.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 10:29:10 -0700 (PDT)
Date:   Wed, 16 Sep 2020 10:29:07 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        andi@etezian.org, javier@osg.samsung.com, robh@kernel.org,
        linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] Input: stmfts - Fix a & vs && typo
Message-ID: <20200916172907.GK1681290@dtor-ws>
References: <20200916141941.16684-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916141941.16684-1-yuehaibing@huawei.com>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, Sep 16, 2020 at 10:19:41PM +0800, YueHaibing wrote:
> In stmfts_sysfs_hover_enable_write(), we should check
> value and sdata->hover_enabled is all true.
> 
> Fixes: 78bcac7b2ae1 ("Input: add support for the STMicroelectronics FingerTip touchscreen")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thank you.

-- 
Dmitry
