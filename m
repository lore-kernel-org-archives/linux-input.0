Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05B4C4708F
	for <linux-input@archiver.kernel.org>; Fri,  4 Jun 2021 07:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95253613AD
	for <linux-input@archiver.kernel.org>; Fri,  4 Jun 2021 07:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhFDHew (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 4 Jun 2021 03:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhFDHew (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 4 Jun 2021 03:34:52 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2FFC06174A
        for <linux-input@vger.kernel.org>; Fri,  4 Jun 2021 00:33:06 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id f12so10393084ljp.2
        for <linux-input@vger.kernel.org>; Fri, 04 Jun 2021 00:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7YEaYtGaODGYMRIOcxS82MgtLU/f7MT+ye6QOtsBBwM=;
        b=k0mfwg8RuZBC4VJUPvNHCgyWwdddHYCNtROCMCMUBKNkg9GnTz1wsdRCtp3u+JpX8s
         Bd8xiqdEg1/0d9t6/72HrB9QHSHJg4NgvzI4oxxKIKxoqWRAxXXiT8rID6nOgqDgpb77
         nI4Nkk6iHy0UP7tmIK+o2aZRaOG9YLUCBNyiW2cc56DLMg4dV+LX68pnjHRxNQjv/j+Q
         MC1EW8XWXWCjv3ZxH+FecZEPtv+Uzy/ZOboD0dj8cxd1PpzSD9LTpGKGdPkvKG3rcMSr
         QV2nuWASQJLxcQUXCNBvDyZuQT8200MzPiFcR1nVDOCEIXGK5DM7CGTYxqw4zW6zRs62
         eStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7YEaYtGaODGYMRIOcxS82MgtLU/f7MT+ye6QOtsBBwM=;
        b=CwRS91UR6UevBkOrpZs8XrcSpGOSp7qUDZbaKRvTt0VLXkJpBHd220yqi0zAWqRhG7
         BMLiHYEo8inMl2w70x1b7xT0Iu2wRc0AA0fkIGrO60UVTVkKJ5mJHK3wSOrXz7LuhgrD
         NLZYL1sAP7IkfGNx4DWCOa6c9gmC1IpRM2zl5mRnk/lb/aK3xsLJkEdgEJh+1RB2zCy8
         S5znMl53MX8fqEtn2I1wwLJ9BR5zREAy32KLmDjOqOal2w95SL30bhSqJGZe4pHdGyTd
         WWfJNT2hVjakcUuqIDI3OHlR+XFRdjavJRqm4HKm//ABHT2zRXM1HJF2d1L/utSriiEE
         J7Nw==
X-Gm-Message-State: AOAM533h8WsUh2mUTGgRqv1sdOYTDJfOcNufRsntKv4ORx3RvPXjf3m/
        snxx6/cs1oB4MiQUA1Olyc0R5URClNsjS4JFRT3ccg==
X-Google-Smtp-Source: ABdhPJzgQx04zTlqpg/w82uH4e5VzZHYhg4xdsMgMS13UjBF/oq1+Otkde9ea6/c7c/a5OlXYTJg5cz4/ByP7q5md3E=
X-Received: by 2002:a2e:90c7:: with SMTP id o7mr2515456ljg.368.1622791984619;
 Fri, 04 Jun 2021 00:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210603043726.3793876-1-dmitry.torokhov@gmail.com> <20210603043726.3793876-4-dmitry.torokhov@gmail.com>
In-Reply-To: <20210603043726.3793876-4-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Jun 2021 09:32:53 +0200
Message-ID: <CACRpkdZWkV6Uq98VjGMFp+EaoM8gZ_FYWF88PoRbwTjnGFcJfg@mail.gmail.com>
Subject: Re: [PATCH 4/7] Input: cy8ctmg110_ts - let I2C core configure wake interrupt
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Input <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, Jun 3, 2021 at 6:37 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> I2C core already configures interrupt as wakeup source when device is
> registered using I2C_CLIENT_WAKE flag, so let's rely on it instead of
> configuring it ourselves.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I wonder how many bugs of this deep semantic type we have in the kernel :/

Yours,
Linus Walleij
