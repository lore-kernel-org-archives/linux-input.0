Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C21C433B4
	for <linux-input@archiver.kernel.org>; Wed,  5 May 2021 12:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 700F7613BC
	for <linux-input@archiver.kernel.org>; Wed,  5 May 2021 12:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhEEM0m (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 5 May 2021 08:26:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232796AbhEEM0m (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 5 May 2021 08:26:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BED53613B3;
        Wed,  5 May 2021 12:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620217545;
        bh=Vf3tmecm6X9PAWz9fZ+T1JVMilcRJL76JtB4vPahEVk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=nKhQI3amPN6cm4peMAFvicD5LX0JUY3zzlClivk6cmRrGn/t6Gw5ti291Kr/5nz4r
         Q5aQHOXXSoif+YdkzlefcYIZfY4MjmUIHCLGTHnZJoAtr9WU9tOifPwcRMcxp9Te91
         YP4GdqOnnz5/qqfT7/F1wVuQHXTbhgLgXRxXsW+1/fD07PEGBByEhWaLKNmc3gtKCw
         UsV0I+lWX9f3yZxg+H3wCjQ2jbhnEDxJxlGpDg95VOnMri8Bt2muPtz+ntLvQ4Yp1U
         H44T9PvCM0kPniKTz0Y9NvG4fX/NnO9Kw8UaIex8XcpKnXqBpagbrVHOL9t1tRPpYh
         L6XPd4LCPiLyA==
Date:   Wed, 5 May 2021 14:25:42 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Nirenjan Krishnan <nirenjan@gmail.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: quirks: Set INCREMENT_USAGE_ON_DUPLICATE for Saitek
 X65
In-Reply-To: <20210329161002.13202-1-nirenjan@gmail.com>
Message-ID: <nycvar.YFH.7.76.2105051425350.28378@cbobk.fhfr.pm>
References: <20210323053511.17887-1-nirenjan@gmail.com> <20210329161002.13202-1-nirenjan@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 29 Mar 2021, Nirenjan Krishnan wrote:

> The Saitek X65 joystick has a pair of axes that were used as mouse
> pointer controls by the Windows driver. The corresponding usage page is
> the Game Controls page, which is not recognized by the generic HID
> driver, and therefore, both axes get mapped to ABS_MISC. The quirk makes
> the second axis get mapped to ABS_MISC+1, and therefore made available
> separately.
> 
> Signed-off-by: Nirenjan Krishnan <nirenjan@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

