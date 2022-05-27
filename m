Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5CAC433F5
	for <linux-input@archiver.kernel.org>; Fri, 27 May 2022 21:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354778AbiE0VaE (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 27 May 2022 17:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354794AbiE0V36 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 27 May 2022 17:29:58 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECF96CF59
        for <linux-input@vger.kernel.org>; Fri, 27 May 2022 14:29:53 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id o13-20020a4a84cd000000b0041161ec8419so167974oog.6
        for <linux-input@vger.kernel.org>; Fri, 27 May 2022 14:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=sWnqhwDkczIhHwTjTv7vAXcYw3J6kKlPUvvwSLfh5AM=;
        b=JaA0Q9VKTrUYRSqVBCw8B+6tE/jw43Ri6DPaXQyzObATK8POeaXU86aOAOLMKiSa8P
         XccAEGKBl5MteXGMYalbaGFBe8dePa1f4TitQpAz9/DkGwJsmDZNcPI1aXsdAEFTTj+v
         lLpZpYwYb/+kLFo9uPWAdMpkJVOQhj+TjJ/cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=sWnqhwDkczIhHwTjTv7vAXcYw3J6kKlPUvvwSLfh5AM=;
        b=ua6YeKmIVcgD4TCu/6JBZQSE0V6QygVc/UzkZZ7Ef2xovmLz3n52RzMDzarqzXLgXk
         YougHm5ONQdjOubNsJFSqjdOc+MOgpj4aPPCpN1lrxIArc/4lFS5YbeSu3viCCTNsAGL
         uLkS5pb0RuQs3+lzidR2tYvYg/My0mBdSJvjXT+/kUV5+ZFpbjaPz/o3bvhHEJX7olUs
         PvfGzzPaPXPVtZZvZgg/Ujgz6vX9/7xPVTRJODswG7RjVDjVD53b/xSWAnm9dyWzFidz
         6ejZh8g/BkB8uQYlvV3+Adw6dR3J88E8MVJ9eGi3hlDxyAFI1LEBXsiAL3eCrskN3eTe
         A7tw==
X-Gm-Message-State: AOAM532wPWyr/B2I1BTrCmUp+YWUNtulyKit7Wz/Yfey5p3du5QxSALC
        CnM1Zvr+p0UZoHI/aWSTvZt7jfeLqcjRVfCt9Ya9PdWaK8s=
X-Google-Smtp-Source: ABdhPJxyyoit3bmwM3Zup7OjaADOAXkI86hQcqfZQkAzi0XJZBT2drhjSeRKHr0E2xqmk5P5SS0oDHmGuQGDN1v9WWI=
X-Received: by 2002:a4a:6f49:0:b0:35e:1902:1d3b with SMTP id
 i9-20020a4a6f49000000b0035e19021d3bmr17892535oof.1.1653686992468; Fri, 27 May
 2022 14:29:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 27 May 2022 17:29:51 -0400
MIME-Version: 1.0
In-Reply-To: <20220526231230.2805147-1-dmitry.torokhov@gmail.com>
References: <20220526231230.2805147-1-dmitry.torokhov@gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 27 May 2022 17:29:51 -0400
Message-ID: <CAE-0n50Cb5irGi-mf66qyDvSpy6p_QvZuBWXpK_C4geg+yyuTA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Input: cros_ec_keyb - switch to using generic device properties
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Quoting Dmitry Torokhov (2022-05-26 16:12:29)
> In preparation to enabling this driver on x86 devices let's switch
> from OF-specific property API to the generic one.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
