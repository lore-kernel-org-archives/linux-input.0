Return-Path: <SRS0=uY0c=EP=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C9CC5517A
	for <linux-input@archiver.kernel.org>; Mon,  9 Nov 2020 06:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CB2C20658
	for <linux-input@archiver.kernel.org>; Mon,  9 Nov 2020 06:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q60vMMi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbgKIGcU (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 9 Nov 2020 01:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgKIGcT (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2020 01:32:19 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39099C0613CF;
        Sun,  8 Nov 2020 22:32:18 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id t18so4245993plo.0;
        Sun, 08 Nov 2020 22:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4p7lSC/S2CeD80LYbkgcl2oygZB5H2aFwhRZnXm9SFY=;
        b=q60vMMi0i7Q2RbZ/J/tMFanjtXdojmZNoui6aPzO8Zh27RzyaGh9nlDdLofQ4VwwHf
         YtF/biiAOK8dnODEG3DELF9ZP40tPF7zs6LGTW5Ed31nWq4JJhUUB3fKkhP6xl35BB8o
         otbTrLUKzWSOQ9V0Qcr2AYBBDTf6gixJIlvnZDVae5+BCeySLLEwCPIb+wjYvlTVCzPT
         Qo4q0R/tXNoGtfwLxRgLfKhZvglxX6/rUSZEKKr4W+yHW3gZHKXq9z6Fk3zw5mFWC594
         O9hRyaApchzAi0HB5Awyj5niATuR9MNDqOxW8BjdjUu+FfiupJkcf62qbodjPKKTDwQF
         Pr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4p7lSC/S2CeD80LYbkgcl2oygZB5H2aFwhRZnXm9SFY=;
        b=fKDzMEzd6kXjR1x+Dz+xtcbpfCZ2gTwIjcKK/p8+PTACO0JIqNP3H1H6Ugfc7b9E+y
         I7ulzkNzJclTTN6yPjSaMAQGVmwrGoNANElNpxj2KjGJv88pUon/ZWYy/3k7T5EFOyyN
         iFnoPvi30x4NLyzei49KTSgcWjHlLzYlx3GR5e89h55YSsQfG0uTF3r5OiA+uQK9AMuY
         rpl2lYyI7oGTceXIRsvz4kf6JM/fOUMNNul0zIp4fSDdWZWul1eQtARH3P5M/A0Ng+/W
         Dmd/cy0o/4RVs8hE384I6JCsAOzzPzR5t5g9SxgBEZWiGLy5wz+nAz1RQsSY54d+tq2g
         kl5Q==
X-Gm-Message-State: AOAM533nc1kuT/pHSy4AyoihDkI6syanYgClWaJVKp2cC8XSdcAcfXqv
        KPzMZpFBhf+E+npTUnWqZrHaOg1eHug=
X-Google-Smtp-Source: ABdhPJyTHLpjPjSmYaIUkOGIIqhFXweWU3okAhoUZmOWpuamfjL1fJqUUR5h2JqkToOXvwIOX4yNSw==
X-Received: by 2002:a17:902:7606:b029:d4:c797:a186 with SMTP id k6-20020a1709027606b02900d4c797a186mr11179010pll.38.1604903537749;
        Sun, 08 Nov 2020 22:32:17 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id l20sm10192746pfd.103.2020.11.08.22.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 22:32:17 -0800 (PST)
Date:   Sun, 8 Nov 2020 22:32:15 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Sundar Iyer <sundar.iyer@stericsson.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 04/20] input: misc: ab8500-ponkey: Fix incorrect name in
 'ab8500_ponkey' doc header
Message-ID: <20201109063215.GQ1003057@dtor-ws>
References: <20201104162427.2984742-1-lee.jones@linaro.org>
 <20201104162427.2984742-5-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104162427.2984742-5-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, Nov 04, 2020 at 04:24:11PM +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/input/misc/ab8500-ponkey.c:32: warning: Function parameter or member 'idev' not described in 'ab8500_ponkey'
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Sundar Iyer <sundar.iyer@stericsson.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied, thank you.

-- 
Dmitry
