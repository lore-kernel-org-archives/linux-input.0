Return-Path: <SRS0=nOvE=B3=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C6CC433DF
	for <linux-input@archiver.kernel.org>; Mon, 17 Aug 2020 10:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13B572072E
	for <linux-input@archiver.kernel.org>; Mon, 17 Aug 2020 10:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597659128;
	bh=k0JXuhhUk7q50yJL2tLhx3us/0o27JntImAxXEKVLRY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=L85x1SZ7eWugUXI8ygleVoBtXbw44QkbJc6PJ4kpQC9NgMQNFQkOUom3Kh6jZsOmk
	 1nRkLUCFB4DhY5Pu1GBQmGtY2IGEIoqT6lKTYnDPPJfqXTxhaw5onFTvyQkUmHPeNR
	 oKB5qjJHMmxWVIXC+OscWA1DmukMp1YLGYhFMLOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgHQKMG (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:12:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgHQKMD (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 17 Aug 2020 06:12:03 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D09F2067C;
        Mon, 17 Aug 2020 10:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597659122;
        bh=k0JXuhhUk7q50yJL2tLhx3us/0o27JntImAxXEKVLRY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=sgZXZSCCpXAWeF0JFtO5oZnB900lsxmHDkiYUod03+reO1N9FrF/cSreNdOFLPTsh
         ruce2oUVciHayyLmrkaCASw95yYcLX/UqBV85pdY6zwAN+ViVf0WcbIlenWZ2YEiIQ
         F5nhIMOX3DZxMEICFfcwro32WTMncnFpW2JWNcfM=
Date:   Mon, 17 Aug 2020 12:12:00 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Sebastian Parschauer <s.parschauer@gmx.de>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: quirks: Always poll three more Lenovo PixArt mice
In-Reply-To: <20200817083628.21075-1-s.parschauer@gmx.de>
Message-ID: <nycvar.YFH.7.76.2008171211480.27422@cbobk.fhfr.pm>
References: <20200817083628.21075-1-s.parschauer@gmx.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 17 Aug 2020, Sebastian Parschauer wrote:

> The PixArt OEM mice are known for disconnecting every minute in
> runlevel 1 or 3 if they are not always polled. One Lenovo PixArt
> mouse is already fixed. Got two references for 17ef:602e and three
> references for 17ef:6019 misbehaving like this. Got one direct bug
> report for 17ef:6093 from Wyatt Ward (wyatt8740). So add
> HID_QUIRK_ALWAYS_POLL for all of them.

Applied, thanks Sebastian.

-- 
Jiri Kosina
SUSE Labs

