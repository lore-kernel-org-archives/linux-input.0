Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C21C432BE
	for <linux-input@archiver.kernel.org>; Fri, 20 Aug 2021 12:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995D7610C8
	for <linux-input@archiver.kernel.org>; Fri, 20 Aug 2021 12:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237882AbhHTM0N (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 20 Aug 2021 08:26:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237828AbhHTM0L (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 20 Aug 2021 08:26:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 861BD610CA;
        Fri, 20 Aug 2021 12:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629462334;
        bh=3R0qdMCFfXOB2+xRomxMe3m2PUAFmF2GH4U0e1OQDiQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=OGUE0F55UGeE4HvD2Z0lytZXU0UYM2BemxQ8RLIX/fW1jWvydT1ano6b1bgIljkDY
         AZFqlVOKVBqO2VWx1NBZQnk1JnLObu/+WJcW1eQi3lBJ/gjDRwbe0ebDfwwM2Tsk0f
         y1UN64dUNj6X4MmXmPWRLrSAzsENemTWMd8e5j6TYWNG5uxNfemZ6k1QoCyNUojWJQ
         QMK6lOpohdFVGztVIC7ExBvxv4ixrx08T/7So5p3QRQqfAbXbc853qVmY4QjoQwJmV
         mMQDZCqHRM8r9wdvGscX8wgJz9o+Zz5gPMkUOVnvwu54EyEj8MFjUKvlTYlAKtGM2b
         kpbwvUSOSC2Ig==
Date:   Fri, 20 Aug 2021 14:25:30 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Evgeny Novikov <novikov@ispras.ru>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH 1/3] HID: thrustmaster: Fix memory leaks in probe
In-Reply-To: <20210730165110.24667-1-novikov@ispras.ru>
Message-ID: <nycvar.YFH.7.76.2108201425170.15313@cbobk.fhfr.pm>
References: <20210730165110.24667-1-novikov@ispras.ru>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, 30 Jul 2021, Evgeny Novikov wrote:

> When thrustmaster_probe() handles errors of usb_submit_urb() it does not
> free allocated resources and fails. The patch fixes that.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Evgeny Novikov <novikov@ispras.ru>

I've applied all three fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

