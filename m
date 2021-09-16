Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB19C433F5
	for <linux-input@archiver.kernel.org>; Thu, 16 Sep 2021 18:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD68961207
	for <linux-input@archiver.kernel.org>; Thu, 16 Sep 2021 18:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345772AbhIPSx7 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 16 Sep 2021 14:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349970AbhIPSxz (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Sep 2021 14:53:55 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8EFC0617AE;
        Thu, 16 Sep 2021 10:49:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrewsh)
        with ESMTPSA id DA3E01F441F6
Subject: Re: [PATCH] HID: u2fzero: ignore incomplete packets without data
From:   Andrej Shadura <andrew.shadura@collabora.co.uk>
To:     =?UTF-8?B?SmnFmcOtIEtvc2luYQ==?= <jikos@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Tissoires <benjamin.tissoires@gmail.com>
References: <20210916163311.11968-1-andrew.shadura@collabora.co.uk>
Organization: Collabora
Message-ID: <443b3e33-c9f3-09f7-b112-79559a5ff36f@collabora.co.uk>
Date:   Thu, 16 Sep 2021 18:48:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210916163311.11968-1-andrew.shadura@collabora.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi again,

On 16/09/2021 17:33, Andrej Shadura wrote:
> Since the actual_length calculation is performed unsigned, packets
> shorter than 7 bytes (e.g. packets without data or otherwise truncated)
> or non-received packets ("zero" bytes) can cause buffer overflow.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=214437
> Fixes: 42337b9d4d958("HID: add driver for U2F Zero built-in LED and RNG")
> Signed-off-by: Andrej Shadura <andrew.shadura@collabora.co.uk>

Having sent the email I realised I forgot to describe the actual
situation when I ran into this bug. It happened after I inserted and
removed the device multiple times very quickly. I know it’s not
extremely reliable way to reproduce it, and it rarely happened to me
before for some reason, but on the current kernel (5.11.0) I was able to
cause the crash every time I tried.

-- 
Cheers,
  Andrej
