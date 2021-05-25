Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0C5C2B9F8
	for <linux-input@archiver.kernel.org>; Tue, 25 May 2021 03:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA5C6140A
	for <linux-input@archiver.kernel.org>; Tue, 25 May 2021 03:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhEYDzK (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 24 May 2021 23:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhEYDzJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 May 2021 23:55:09 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0745C061574;
        Mon, 24 May 2021 20:53:39 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ep16-20020a17090ae650b029015d00f578a8so12381938pjb.2;
        Mon, 24 May 2021 20:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dDsnnWJzd59s0wc/jGhwKP2XZK0889qPpwAI7XHf3C0=;
        b=Whmbx39LmQ8jUfJzLeUy66KfaSV1It73ReN35cLytEn8a/YtftgeXFjsEYw/p2rLGg
         4xfRPSorR2WSIU+asnM+RWW+DM2orn7Jnea+vm6KdbqqSlVdrSSE5boF8fkpQbV5+/et
         IJSf7Pe4TN4JavXAFKa3oqJhkEhFtNyPjGIfJg8KtdzTxqBv6Wy2qVgnwSw7xzP00cXy
         BmFTAU+KDX9s8mfaiSRADWUVQUmu7vmbRHp07T3fvg6a0duoIyA5iIGKx7mYL0IGMgws
         NAIMAgjTAozVYykTSfm5/f2w3mroj2tpfD/fAVlCn5dJsr9XhvHen1lFxlgjEqQ7ocHh
         Z8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dDsnnWJzd59s0wc/jGhwKP2XZK0889qPpwAI7XHf3C0=;
        b=G6asjk0z8WrSPsKXD/TpgSyY1VwhpMq0f7WmsNgZA9tjuh+ene36sQvOAGDg1OW4U8
         QTu/+EWa8n459QylwWSEStZpi55jKejvx92Q7JDnMWlEt4vOsfE6HaaHpFgDxZL78SFt
         Hx7jce1cdinCTbyuBKnzoS3JVeKDqKAKU0HQmR3OVX91W1Ae/gvGGgNsf7dpIAnGEIm5
         xBRGDw9DsYIHFIpInczNn0ar3geX0fwprtiKI5Cik6gVvG7+Dls7xul1ZXrbnxgUTQOK
         y3QQoOo0RDWCWzvRnMvX9fBcM9gt51+2CeW2j3O/kUk9li/Dx3IDqlspVdoAsqSKfULt
         89uA==
X-Gm-Message-State: AOAM532EOlX7FLCK+1rfA8Mcr+zdnfXwRWWDaIxvAtwaP0NFgKUsv7Pk
        lupnzZB6v+ay5rMPl2RZYUaLgLGqE+I=
X-Google-Smtp-Source: ABdhPJwHK7YwVMelEh+iZ82/k6JDQmxStHwcMUVpthAxJivQedCSwFCAa4+bB2y3YpPXoUB+MudAoA==
X-Received: by 2002:a17:90a:5405:: with SMTP id z5mr2638995pjh.38.1621914818941;
        Mon, 24 May 2021 20:53:38 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:870d:a395:9098:674])
        by smtp.gmail.com with ESMTPSA id a20sm11949525pfn.23.2021.05.24.20.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 20:53:37 -0700 (PDT)
Date:   Mon, 24 May 2021 20:53:35 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Chris Ye <lzye@google.com>
Cc:     =?utf-8?Q?=C5=81ukasz?= Patron <priv.luk@gmail.com>,
        Benjamin Valentin <benpicco@googlemail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Olivier =?iso-8859-1?Q?Cr=EAte?= <olivier.crete@ocrete.ca>,
        Sanjay Govind <sanjay.govind9@gmail.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org, kernel-team@android.com
Subject: Re: [PATCH] [v5] Input: Add "Select" button to Microsoft Xbox One
 controller.
Message-ID: <YKx0v9K/1TUZrlbD@google.com>
References: <20210414021201.2462114-1-lzye@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414021201.2462114-1-lzye@google.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, Apr 14, 2021 at 02:12:01AM +0000, Chris Ye wrote:
> Add "Select" button input capability and input event mapping for
> Microsoft Xbox One controller. From product site this is also referred as
> "Share" button.
> Fixed Microsoft Xbox One controller select button not working under USB
> connection.
> 
> Signed-off-by: Chris Ye <lzye@google.com>

Applied, thank you.

-- 
Dmitry
