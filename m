Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A32C2B9F4
	for <linux-input@archiver.kernel.org>; Mon, 14 Jun 2021 13:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2298B6128C
	for <linux-input@archiver.kernel.org>; Mon, 14 Jun 2021 13:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbhFNN5t (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 14 Jun 2021 09:57:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233180AbhFNN5s (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 14 Jun 2021 09:57:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E404B610A0;
        Mon, 14 Jun 2021 13:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623678946;
        bh=2AiA7ciNnoSYzbN02CAkdsFukMbfXZE+4JSMq8tgGBU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=BV4TkK1antJP4lTDE/dz4WIlxbR+8Y+58ctwKaX5qVUXTTwqBfEX3zYS2EjULSD9y
         MoxjniPD5fW1R0ztWA00y0ztben3QkUOzUX9p4cyH+oCh/pERz1zps0dNiH34YQz2g
         gQqjs3Oq8ECbJtLsturbR1ox3dZBLtDgHb2mungvpWUO06qjep2xJglL6p7Z2jVXFN
         ME/ODkwqmtmRddqz/xQI1JxJj0c2yyWD0NJyJhu3blZaRkEeymdT/3bcJlZxIeZAn6
         Ps6ZmtBj30yjrHXQQ3pRbVP1Hr9uxhRHDrnU086SpKUkT3VM1lIQkTt+4biHwkyIDN
         tyL5xkctSef2g==
Date:   Mon, 14 Jun 2021 15:55:43 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Even Xu <even.xu@intel.com>
cc:     srinivas.pandruvada@linux.intel.com, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 0/3] enable ISH DMA on EHL platform
In-Reply-To: <1623306114-19208-1-git-send-email-even.xu@intel.com>
Message-ID: <nycvar.YFH.7.76.2106141555350.28378@cbobk.fhfr.pm>
References: <1623306114-19208-1-git-send-email-even.xu@intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, 10 Jun 2021, Even Xu wrote:

> These patch set are used for enabling ISH DMA on EHL platform.
> 
> During ISH DMA enabling, some platforms (such as EHL) don't
> support cache snooping, bus driver (ishtp) has to involve
> a new callback, dma_no_cache_snooping(), in hardware layer (ipc)
> to get hardware DMA capability.
> 
> When do cache flush, clflush_cache_range() API is used on X86
> which isn't supported by all other archs (such as ARM).
> Considering ISH only exists on Intel platforms, adding ISH
> depending on X86 in Kconfig to avoid build warnings or errors
> on other archs.
> 
> Even Xu (3):
>   hid: intel-ish-hid: Set ISH driver depends on x86
>   hid: intel-ish-hid: ishtp: Add dma_no_cache_snooping() callback
>   hid: intel-ish-hid: ipc: Specify that EHL no cache snooping
> 
>  drivers/hid/intel-ish-hid/Kconfig           |  1 +
>  drivers/hid/intel-ish-hid/ipc/ipc.c         | 26 +++++++++++++++++++++++++-
>  drivers/hid/intel-ish-hid/ishtp/client.c    | 18 ++++++++++++++++++
>  drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h |  1 +
>  4 files changed, 45 insertions(+), 1 deletion(-)

Now queued in for-5.14/intel-ish, thanks.

-- 
Jiri Kosina
SUSE Labs

