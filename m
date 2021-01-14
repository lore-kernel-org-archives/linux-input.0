Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B1AC433DB
	for <linux-input@archiver.kernel.org>; Thu, 14 Jan 2021 12:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55ECE2376E
	for <linux-input@archiver.kernel.org>; Thu, 14 Jan 2021 12:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbhANMQS (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 14 Jan 2021 07:16:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbhANMQR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 14 Jan 2021 07:16:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FF912376E;
        Thu, 14 Jan 2021 12:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610626537;
        bh=Xj/Fngg6YTsPieWYojwmzSMyDNVGo6WVo757nUzgaF4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=bvy8mJd4v1/vnfursfpdV0ozfly3pNppH/po0cKdV254H8dTGDguVKY9Zb1CMshYR
         P37PJGWrASpH0yvpqQOLsF+BKGymUPNaINRjNtEwzjYVGeJsPXnHMCLDQsuYWewtAR
         YK33AuPpATNdkPIGIx27t6GFUGTxnMOnaEqUSqSRpIpBP1DMVmwm7diUlqwqfhvROk
         lIzmwY5b46OKzEEqD4iwnH1OMB7GNVCE9xbfl9tlMFMw/nbSY6wInt5bDnqt1YZPcI
         3hrcHzyqeTkdL5rzJyVuRA1SaEhFmXa4Go/Qknk9bdtAR6vj3gw/hkLKNO2cPwyyTM
         nnb7mxWYGIjSg==
Date:   Thu, 14 Jan 2021 13:15:34 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: google: Get HID report on probe to confirm tablet
 switch state
In-Reply-To: <20201224114502.1.I41b9795e4b5bda7209eb9099aebdc6a29677391e@changeid>
Message-ID: <nycvar.YFH.7.76.2101141314410.13752@cbobk.fhfr.pm>
References: <20201224114502.1.I41b9795e4b5bda7209eb9099aebdc6a29677391e@changeid>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, 24 Dec 2020, Nicolas Boichat wrote:

> This forces reading the base folded status anytime the device is
> probed.

Could you please provide a little bit more verbose changelog (namely what 
is the actual problem this patch is fixing)? Thanks.

-- 
Jiri Kosina
SUSE Labs

