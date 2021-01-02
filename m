Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F87C433DB
	for <linux-input@archiver.kernel.org>; Sat,  2 Jan 2021 05:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30B15221F5
	for <linux-input@archiver.kernel.org>; Sat,  2 Jan 2021 05:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbhABFzx (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 2 Jan 2021 00:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbhABFzw (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 2 Jan 2021 00:55:52 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DEAC061573;
        Fri,  1 Jan 2021 21:55:12 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id j1so11789799pld.3;
        Fri, 01 Jan 2021 21:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iJZAqzKqZgcIsMRNmmvHW0lF2fkCdunCtBb6MpxtWhM=;
        b=jinKG8gH+/HxGhNe7CcKomA1Ta5bARXabnrQLd4e+uei36RFubUkMCX4du3uiAxFDF
         PDNdRX3j4/VlNSKtIOkFZ2+Pmv+5HTc2i/BXu5Jk8bTi+dvWdmOSaalcHNIZ8cwUALUI
         kB2GwnyEg8bCCAp046uoC4PUFjh7l9x4W8HhJBg5iOLvTTu7e4MQiF6c/KiXEMUSoB7s
         ZIZTKvidLuxPd8YV6m4R4ZH3N2UDF+1feXAN/xL4rfd7P4IbD0r8Tvy1iq+RLvxVg2I6
         X8o5HiMcqyRVwuX+7s3y7vr0DUWTCFe6U+xSERrlgXdAYi4tRw6vltRSlpPv8sJF3Hgn
         cSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iJZAqzKqZgcIsMRNmmvHW0lF2fkCdunCtBb6MpxtWhM=;
        b=erkKQNi/I173h++gdKno41fCOdCH+tjXT031xLcXCUSdRx0XLOhtM5mluOnSvQPfJw
         I06b9XDKWsixfneAJ0NsBLkSHZbbzYZExNGPHQ2GzZeqZ572OiSEKrSiH/Dpl3DRfzwG
         tB3JmEF6SI5hE69oVhsNentHu+03X8Z9ZgF98LLsM2SjsZzCIoFg+j+gfnC6EeLALGt5
         8VNBdpHqgA+uFPtDu5dfSVB2Df8eO2deO7zjAZP9Q6l9ska/m39Ual5oEaMHF9C9f5zH
         smyv9x+XUnK2xNzATHYZFo0L8j8fGJHyYqhuptnucRD1RIsSfgMYyikjtA6oNn2DDt5Z
         cuiw==
X-Gm-Message-State: AOAM532UmBXWa+wWdMVyv75ObTfL9NGyFWXMie6+MmpbSqnW/43HYnw1
        gH3Ey4LcZpJOUbfGwsRWC3v3vk07e3o=
X-Google-Smtp-Source: ABdhPJwE/bgsV8V5R2xrSoKI96HszDccfTzvO2UfH6sPNeHp01IQLNWEVWGYBekoKQ5PUTv3b5mQNg==
X-Received: by 2002:a17:902:b706:b029:dc:3817:4da5 with SMTP id d6-20020a170902b706b02900dc38174da5mr40202727pls.23.1609566911638;
        Fri, 01 Jan 2021 21:55:11 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id b7sm38676966pff.96.2021.01.01.21.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 21:55:11 -0800 (PST)
Date:   Fri, 1 Jan 2021 21:55:08 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: ar1021 - use IRQ_NOAUTOEN flags to replace
 disable_irq
Message-ID: <X/AKvA8Wt0F6DjcU@google.com>
References: <20210102042902.41664-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210102042902.41664-1-song.bao.hua@hisilicon.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi Barry,

On Sat, Jan 02, 2021 at 05:29:02PM +1300, Barry Song wrote:
> disable_irq() after request_irq is unsafe as it gives a time gap which
> irq can come before disable_irq(). IRQ_NOAUTOEN is the common way to
> avoid enabling IRQ due to requesting IRQ.

Actually it is OK for the ISR to fire before the input device is
registered, input core allows that.

What I would like to see is to allow passing something like
IRQF_DISABLED to request_irq() so that we would not need neither
irq_set_status_flags() nor disable_irq().

Thanks.

-- 
Dmitry
