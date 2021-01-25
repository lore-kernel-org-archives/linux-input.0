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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E9DC433DB
	for <linux-input@archiver.kernel.org>; Mon, 25 Jan 2021 04:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C960022472
	for <linux-input@archiver.kernel.org>; Mon, 25 Jan 2021 04:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbhAYElD (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 24 Jan 2021 23:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbhAYEk7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 24 Jan 2021 23:40:59 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A066C061574
        for <linux-input@vger.kernel.org>; Sun, 24 Jan 2021 20:40:19 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id j21so2220604pls.7
        for <linux-input@vger.kernel.org>; Sun, 24 Jan 2021 20:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ur65WvyBWRX7puJzbRO6IljG5SZSo7DpoK2aKBUW+tQ=;
        b=fWWlJVFpF+6nglFNJ4jERmI5hVfzRxA3nMRrv41ShdKMFacrf2FcrYrxeqUKk3GhUa
         a6wTdWUjcc+2lSXAeCsgkLPyLdNDhZ0ZMiHIfquirk6vxTpGvwk51eI2zmp2JZei0bl6
         +B/hxWPVL2V5Hd71l0ifJEPBTlxuMaD3nmbMJjXqvOZbS2Mn76yaj8W1OFhmoHEhhofX
         bSQix704/IedoS2bDJSztZMEeYP3UjCvG4+vAdk2J1YMBzMxrn7pGebJDQsPOiuH/2fT
         jrS6GzxPPL/9NLLueIT/txmgBY7yv9FXkdh8vmOPWaGvCLs80hvozjoTjR4uR6Ywruhs
         gBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ur65WvyBWRX7puJzbRO6IljG5SZSo7DpoK2aKBUW+tQ=;
        b=B/v0fmtYXZjw3Zq/R7OkHvmWG/EWDw7vNoxS+BhjOY5qfhSu+EfP5W7kcEwNM9XuSU
         JpNQqAEAeR2mrJBxYV4ZQ7nOdKdwxX2GP54YCSBxtrEVrsIlwIuYg38hU42d8PREd3kL
         wi+GgvD6wgsbPIpVIiW34OhALzroCEmU4tf7VmADxuPawVVnMDXXdUvBW0NkT3AEmXcj
         cWy3SzOJ9OT6lG8cwODy6KUnmpMc4uHbUwD6VNC7RfTzagJ3swnNR5xdTDO4nd2EF5Tw
         5GYiRGcrmVgjj62s/wTyiLstkjsFeA9bg14IPCdnUBkOEIYuG9wG81bYG9N7+FX0e/rq
         F87w==
X-Gm-Message-State: AOAM533C/UsQ+LBHwgo3q8ebMb79O6/ZAeRhjMNQg354oEBuWm13IMl7
        EJRK3FtUivOLxUDXmNLiq1/tqeu6AaY=
X-Google-Smtp-Source: ABdhPJyVJ5sSiRn1Vg4eM+dsa5xx1xyDXnGYtgpI8jCmiRL8nCjRXr8+37u3CvRGM7+v9twQ5x9/BA==
X-Received: by 2002:a17:90a:9ac:: with SMTP id 41mr786237pjo.46.1611549618742;
        Sun, 24 Jan 2021 20:40:18 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id ge16sm16831874pjb.41.2021.01.24.20.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 20:40:18 -0800 (PST)
Date:   Sun, 24 Jan 2021 20:40:15 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     linux-input@vger.kernel.org
Subject: Re: [PATCH 06/10] input: iqs5xx: Simplify axis setup logic
Message-ID: <YA5Lr3XMj0kbxqUV@google.com>
References: <1611002626-5889-1-git-send-email-jeff@labundy.com>
 <1611002626-5889-7-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611002626-5889-7-git-send-email-jeff@labundy.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, Jan 18, 2021 at 02:43:42PM -0600, Jeff LaBundy wrote:
> The present implementation manipulates axis swap and inversion fields
> in the device to more or less duplicate what touchscreen_report_pos()
> does. The resulting logic is convoluted and difficult to follow.
> 
> Instead report the maximum X and Y coordinates in earnest as they are
> read from the device, then let touchscreen_parse_properties() fix the
> axes up as necessary. Finally, use touchscreen_report_pos() to report
> the transformed coordinates.
> 
> Last but not least, the maximum X and Y coordinates are not functions
> of the number of rows/columns that comprise the touch surface. Either
> coordinate is simply limited to 1 below what is reported for absolute
> X or Y coordinates when no fingers are present (0xFFFF).
> 
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>

Applied, thank you.

-- 
Dmitry
