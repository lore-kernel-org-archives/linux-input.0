Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC4AC432BE
	for <linux-input@archiver.kernel.org>; Mon,  2 Aug 2021 07:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C57360F6E
	for <linux-input@archiver.kernel.org>; Mon,  2 Aug 2021 07:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhHBHdL (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 2 Aug 2021 03:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbhHBHdK (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 2 Aug 2021 03:33:10 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5BDC06175F;
        Mon,  2 Aug 2021 00:33:00 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t9so19070931lfc.6;
        Mon, 02 Aug 2021 00:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BXCiU0xKGBVbZ2icElVqPuQRsbpvE6+lSfin6xZD3cE=;
        b=ck5Y31M1VmZAD0RegHR6Ig5OfAtmbEyU5/b90SvojsQ6H88/KrKavwsCJmhEbgui7t
         qxNpfFUa+BHClM6nzQG5tImqKJsRf25vMLyIhl2ZMZ0+Co3jilQZmUxDLp4MgGxr69uN
         TpJNl8ztIoYBV1wfiykxi6iTRhKjuvJr33V8J56oGy0EyOmL2Yr7btjLVWNfKsn8Y+A1
         JyaVevAIixICrX2q7+h3xoP9pbTHlXZrWC6VkHSM7ZC5jqiQ43E8lDzWM8sgths2mx0F
         3vqW3B3PdPbt/ibT8+wD+NyFPpLaegU0ocNtSWo9AtYeWHlWL8fDsp/k5QlGvBHVlYnR
         VyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BXCiU0xKGBVbZ2icElVqPuQRsbpvE6+lSfin6xZD3cE=;
        b=Yb0orle3dOtTdSChQgiugqayLemNtkPjGTqLjeHQLcthby4lRBDgV/gdqgkPBzRKzf
         +g7NbjbYwv3k7n+2RisblNp5bv8UdygB/9hqlEBKhYsR2WXvdXNE/9Hs7YQoB7YOkzAx
         ctL6sqW6DnUran+DA3eNmLzp55A73kmR09+lIwD5r8aSDHOl+P0hPrphF5TP8ii4dM3q
         xej7HnY542Wqqn5x2vSYaCkVwmtj/0FJLG+BAJt8Ah/qrsB2F8PmUCKZoZDZ+aI4jo41
         SDOeiJshHNKF7RL7v0xxp7QSnm8Mtb7IKJFc+sDyGx5aq4NlUphiufvIyyTClS3mmbSU
         711A==
X-Gm-Message-State: AOAM530Lh5sf4NRQHQm+ofhciRXmeEM2XGrLRpR/rirlgxREEw/ug4sD
        bxIEnhZIf7gIRoStzUkUScxue/DLW4A=
X-Google-Smtp-Source: ABdhPJxy6slPPxcwzHe4g7r6e2LrNwaR8rGgOPgFbqUShhMyGjWYhynChcsju2u/IqjSDBwJD28G5g==
X-Received: by 2002:a05:6512:3d26:: with SMTP id d38mr11098294lfv.411.1627889579245;
        Mon, 02 Aug 2021 00:32:59 -0700 (PDT)
Received: from [192.168.1.49] ([109.197.204.123])
        by smtp.gmail.com with ESMTPSA id d16sm879996lfv.223.2021.08.02.00.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 00:32:58 -0700 (PDT)
Subject: Re: [PATCH 3/7] Input: ep93xx_keypad: Prepare clock before using it
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
 <20210613233041.128961-4-alexander.sverdlin@gmail.com>
 <YMfQR8iM9be5Qg8+@google.com>
 <9bf87ee0e1c2a97b0a1b98734e34e456f84ea3d7.camel@gmail.com>
 <YM60mjew2mqMAMRO@google.com>
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <ff37fd74-d9a6-36d5-326b-3b4a87e39682@gmail.com>
Date:   Mon, 2 Aug 2021 09:28:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YM60mjew2mqMAMRO@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hello Dmitry!

On 20/06/2021 05:23, Dmitry Torokhov wrote:
>>>> Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
>>>> to Common Clock Framework.
>>>
>>> Can this be merged standalone?
>>
>> In principle, yes, but I thought it would be easier if the patches
>> would go via the same path as CCF conversion.
> 
> OK, in this case:
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Seems that this doesn't work as we planned and two patches of the series
were already taken in by the respective maintainers.
Could you please apply this patch as well to your tree?

--
Alex.
