Return-Path: <SRS0=htlr=IG=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8CFC433DB
	for <linux-input@archiver.kernel.org>; Mon,  8 Mar 2021 10:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9D566510E
	for <linux-input@archiver.kernel.org>; Mon,  8 Mar 2021 10:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhCHKRC (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 8 Mar 2021 05:17:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231942AbhCHKQl (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 8 Mar 2021 05:16:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B9AB6511F;
        Mon,  8 Mar 2021 10:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615198601;
        bh=oE6UOI2kxkAuHR0PpcVGg3jkkNG+D6rBJypstuEIQFs=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=DrH+CgOzsX2UydbsBC91G0Zn+Lr2U8vt6XewDg+T66WeOeg/d0TzkagDzuJ+27vvr
         GsVVHtQy3adVywz42vxcm3w4o8NuiWewMMMtWW/JMFiCW96zsIRio9B4Hlke9EDQd+
         BWvdIIc0YC6SjgnlgSk6EwZP19LvtF+0MKqMiYCbwC1nR3ViCttSfGydGfSJrKPwIR
         kGcTmXuJc/sSFvopyoT40i9X23eDUFDxlHilpilTdDAVlTcVhHPIdXjcJjADfqiQNj
         H4qhWWhgPIgKBHjH7HKX6vidaB5M3gZINdR7goOvHpNzSaxmP1ux37nzkfABudYzZW
         3FcLTopC8bVuQ==
Date:   Mon, 8 Mar 2021 11:16:38 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Luke D Jones <luke@ljones.dev>
cc:     benjamin.tissoires@redhat.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: asus: Add support for 2021 ASUS N-Key keyboard
In-Reply-To: <20210218211001.20623-1-luke@ljones.dev>
Message-ID: <nycvar.YFH.7.76.2103081116270.12405@cbobk.fhfr.pm>
References: <20210218211001.20623-1-luke@ljones.dev>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, 19 Feb 2021, Luke D Jones wrote:

> Some new 2021 version of ASUS gamer laptops are using an updated
> N-Key keyboard with the PID of 0x19b6. This version is using the
> same init sequence and brightness control as the 0x1866 keyboard.
> 
> Signed-off-by: Luke D Jones <luke@ljones.dev>

Applied to for-5.12/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

