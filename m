Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAB7C433EF
	for <linux-input@archiver.kernel.org>; Mon, 18 Apr 2022 15:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345090AbiDRPTx (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 18 Apr 2022 11:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345290AbiDRPTj (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 18 Apr 2022 11:19:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5695949FA4;
        Mon, 18 Apr 2022 07:17:14 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ks6so27135346ejb.1;
        Mon, 18 Apr 2022 07:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:to:cc:subject:from:references:in-reply-to:message-id
         :user-agent;
        bh=oCqldMpOoahK1Z20XtKNSbUZVKynuD1kFyXlvJNqAuo=;
        b=HM3eCv1tuUzIpMZ6KMLFisTFgbnRWjQYlkpVkxRQvL/2crtSJpj4AeOvUKyopCklr1
         Q5hO7WNtHkJ8FdrRuAXcVGd1XxFBK3oy0ByVtx53dkoll6UB5Mw7LOalGt0413rMvtVR
         AMkq1ilAqYbwpWSrosgH4i7QlQ9/DIVlOv1eby0Slhek7IACFdGT9K0b1Ho3Ts7eygCF
         IWeeEqgjb50hbCZjFfUOvJNdCSZJ1oa5oXECFeniGy0Q97YEoTNlyQikIQUaDQliXhwI
         8RqavMGnHahnfJacYdCb2gLLZ9Kc9YdXWociE+WbvKwCDPNd2PiUnqmjzV/UHaxjOVB4
         kYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:to:cc:subject:from:references:in-reply-to
         :message-id:user-agent;
        bh=oCqldMpOoahK1Z20XtKNSbUZVKynuD1kFyXlvJNqAuo=;
        b=ulcr4kefhq7YBBUeoQZiFaH9iSSO6LexdNhqAbAj8wkzy/2sVB4iEOHbVHcJLpYNi9
         kAf1Sws0gR+4yeMSHSnFk4qrrbzjBV3qtgPHP0pBMVGAks/e7cp9C06RYEfygiDJstbn
         8lRP6Lzns/d9kQE2N5qSIh4oG3lZTMjn3juGXOs9FmpDZYJPlOyB3+ESXHit78/ugwsi
         l8tlRfLXb0VUcLmURZ0Zf4yw6sXJimXQznU+HMo9X9RScfR6wQzrYzZji47G58LXZXKC
         bi4luQi+vvNOGEFkhx7NlljaZVXdEqEOOrqZ0hAsz9RSLstXZLpsyIT/dbwghe3y6B/D
         kEpQ==
X-Gm-Message-State: AOAM532gINykdyB7hSx/LwKZfZsmbw/aZ1hDCveTxrjgKA4uUewKAk1n
        MxdeEaH7XdccHVkTzR+EdCc=
X-Google-Smtp-Source: ABdhPJy+yE32tVcy+vgKm4oqBRJZrhLh8OSZLQrJJSk4m3RBwafT+xqkfVqxbOpvrLtV+FS/muB1kA==
X-Received: by 2002:a17:907:7204:b0:6e8:c19e:93da with SMTP id dr4-20020a170907720400b006e8c19e93damr9240345ejc.695.1650291432291;
        Mon, 18 Apr 2022 07:17:12 -0700 (PDT)
Received: from localhost ([2a02:169:1e9::acc])
        by smtp.gmail.com with ESMTPSA id fx3-20020a170906b74300b006daecedee44sm4618799ejb.220.2022.04.18.07.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 07:17:11 -0700 (PDT)
Date:   Mon, 18 Apr 2022 16:17:11 +0200
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     "Daniel J . Ogorchock" <djogorchock@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: nintendo: deregister home LED when it fails
From:   "Silvan Jegen" <s.jegen@gmail.com>
References: <20220415100432.23453-1-icenowy@aosc.io>
In-Reply-To: <20220415100432.23453-1-icenowy@aosc.io>
Message-Id: <39QNT1MSMJLC1.2M2V40UQZFSEE@homearch.localdomain>
User-Agent: mblaze/1.2-7-g31dd7c5 (2022-03-20)
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi

Icenowy Zheng <icenowy@aosc.io> wrote:
> Some Pro Controller compatible controllers do not support home LED, and
> will fail when setting it. Currently this leads to probe failure.
> 
> Change the code that fails probing to deregistering home LED.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Reviewed-by: Silvan Jegen <s.jegen@gmail.com>

I don't have a "Nintendo Pro Controller"-compatible controller to test
with but I have compiled a Kernel with this patch applied and can confirm
that the original Nintendo Pro Controller is still probed correctly with
this patch applied.


Cheers,

Silvan
