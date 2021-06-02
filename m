Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0D2C47083
	for <linux-input@archiver.kernel.org>; Wed,  2 Jun 2021 04:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B5F3613D2
	for <linux-input@archiver.kernel.org>; Wed,  2 Jun 2021 04:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhFBEQX (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 2 Jun 2021 00:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhFBEQX (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 2 Jun 2021 00:16:23 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E5CC061574;
        Tue,  1 Jun 2021 21:14:40 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id u18so1152935pfk.11;
        Tue, 01 Jun 2021 21:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DASUdmuANq8WShRP2cidDgiF2d4vC+al/gFPjy5fagE=;
        b=ddgJdqmN4OQyzlXC2WndBaDLMytaYp4Op1bDns1JM/CtR0fxgmeesbx/gBFvmfwR3F
         ZY+LYdcrJcDEKLRZLAl9CBWhYjS5wna/Fis9wofmTL7jB2kWozz7+AnKh/Ary/t8zWnK
         h9tpIb/RgrfAFoAxOzc7XJmJIFhYjdRbn7WYos2YVUKTXJAKuf1qQp3kSGdy4cxA+d9y
         rbzhXKrg3RR/aqGMlWVnNKPOZaa8m8FMcgA0TbVektDdFY9DnVrnaLzsad+6YCpEPZvZ
         oeWK2WaVFRqcWLJsw9LTII49xYrRuU95xfhF3CcaRdFSSJqRlUqF7pNAGXF6HO1Nt4nC
         akHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DASUdmuANq8WShRP2cidDgiF2d4vC+al/gFPjy5fagE=;
        b=TRRJWJf1aqWEwceUylYsAv97Ipu6bqMtK6zNZ/VG1ttHVO3fubhlGAYuZo0icQxHGJ
         2uVchHc6Q9NmkLQZhwj2GBJL0ojTUWucUorQffHS3czNxIf9UyoIRgDZ+iQLwLqKoSbg
         T6oK/Y8dQDI5Ps1xg0hiyCjqlUFdITdaNVlGTTGwTw+I/NHNlOYDnDu01J+99pom4U0T
         Rk9LHj/2URGRHkrRwmLH14S1fDhiKoCZ9mKLL7fLKozD7elL09jptozF9bnY3hXOCUrQ
         zya6uSoIljHauz8/xIIuHzcIdeB0DQY37Byx1TsjMhxBnLRqWApP9AXdCAHsPlpRnNvV
         +HIQ==
X-Gm-Message-State: AOAM53106R6ONiivfNojLPLwY0S6Rr1wpt0yZYoUgnJPGPgcxVcrLdiT
        mPCNpKr5hNB0oyExyZ7VOEE=
X-Google-Smtp-Source: ABdhPJxFjJdzJw2luXvUFmVz6B4c0UReZJbXwX/w2nZZ9LvPd7bmb7fUrzpPqQxlyG8BbtON3A+Rzg==
X-Received: by 2002:a65:6291:: with SMTP id f17mr11852711pgv.280.1622607280426;
        Tue, 01 Jun 2021 21:14:40 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a596:b3cb:1a6:1ee4])
        by smtp.gmail.com with ESMTPSA id 4sm3388519pji.14.2021.06.01.21.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 21:14:39 -0700 (PDT)
Date:   Tue, 1 Jun 2021 21:14:37 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Input: elants_i2c - Switch to probe_new
Message-ID: <YLcFrbtzFGpXgSyl@google.com>
References: <20210528071024.26450-1-tiwai@suse.de>
 <20210528071024.26450-2-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528071024.26450-2-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, May 28, 2021 at 09:10:24AM +0200, Takashi Iwai wrote:
> Now that we get rid of the usage of id argument at probe again, let's
> switch to the new i2c probe method; this will avoid for people
> misusing the possibly unassigned id pointer again.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Applied, thank you.

-- 
Dmitry
