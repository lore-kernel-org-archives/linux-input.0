Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B038C4332F
	for <linux-input@archiver.kernel.org>; Wed, 15 Sep 2021 14:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 096A76124D
	for <linux-input@archiver.kernel.org>; Wed, 15 Sep 2021 14:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237928AbhIOO7o (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 15 Sep 2021 10:59:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237842AbhIOO7m (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 15 Sep 2021 10:59:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C39261242;
        Wed, 15 Sep 2021 14:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631717903;
        bh=/ZfMlzHl86RUkY+mAXoq6ryeWsjRe4PlpqtUqEFs9/o=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Rd8rFSXfisp6imty9F4sAx9FSrFdJLaQYpHNueuUKT9pHHi46LkxS1P60qC3GmYxP
         QPVmKC/bvBJ6AqyQibt1rIl+D+fUuSY2iei54seugf4JpWQJACTX3iNo3cRGnCP4Ns
         5MZjA+t3rBcbKoLcxrR00p8ZqIIoBwJzfJxGve7u3+oSm3oIMBCUOQNJonk3wyuim5
         OhsZMpa/A+tBceGZNjYxtHrUwf3eht0AFvdNOXI7uro0pdY3/LZsXtTsVFPCdPd7f4
         8a5KrMyKSOpKtTyWEeMAbjValr/pKR79BUcWesG0wnBbWWDtA2lyu4ASX6dqbiCY1B
         3a6Bp/i5oBwJg==
Date:   Wed, 15 Sep 2021 16:58:19 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Evgeny Novikov <novikov@ispras.ru>
cc:     Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Sandeep Singh <sandeep.singh@amd.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] AMD_SFH: Fix potential NULL pointer dereference
In-Reply-To: <20210601163801.17848-1-novikov@ispras.ru>
Message-ID: <nycvar.YFH.7.76.2109151657580.15944@cbobk.fhfr.pm>
References: <20210601163801.17848-1-novikov@ispras.ru>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, 1 Jun 2021, Evgeny Novikov wrote:

> devm_add_action_or_reset() can suddenly invoke amd_mp2_pci_remove() at
> registration that will cause NULL pointer dereference since
> corresponding data is not initialized yet. The patch moves
> initialization of data before devm_add_action_or_reset().
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Evgeny Novikov <novikov@ispras.ru>

Nehal, Basavaraj, could you please Review/Ack this one?

Thanks,

-- 
Jiri Kosina
SUSE Labs

