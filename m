Return-Path: <SRS0=3R5s=3R=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AC3C33CB3
	for <linux-input@archiver.kernel.org>; Tue, 28 Jan 2020 10:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4097E24688
	for <linux-input@archiver.kernel.org>; Tue, 28 Jan 2020 10:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580206298;
	bh=W1KcuPnjq7FXJw8WT//151cJTalsP565myfybN6vS4I=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=OMyc/h+Zs/yGd+KyZZXrQxOY+Tla2dKDqLiLxJwh12PV8SiuhNB/avgJC+bPNM4jY
	 zFcgePpbMKogAgAr8rEB5jTVeJOmWgBz3QjU7bbtQ/MW3qOnLBtDQ4hPZgRUpiBKVd
	 VS0tyVzRWF5PmLUndXrWOdD1orJ3Bx2h2jIe2tHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgA1KLh (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 28 Jan 2020 05:11:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:55460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgA1KLh (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 28 Jan 2020 05:11:37 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76E672467B;
        Tue, 28 Jan 2020 10:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580206296;
        bh=W1KcuPnjq7FXJw8WT//151cJTalsP565myfybN6vS4I=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=V1LexlST9LBqB4XDOM4vtipm5CnhfNiyD47dXcPoMqi8Lp0mYXeBDNuYHJUZttMCH
         0XzbPAB30C44s1g01h6UnvLEZ4bm0WlMfwrVJC3fT1SgKL+8Mzwuh8B/D5OX5HlKty
         xWEWs14BV6M6YYDvf/1ZNBCvplk7rWsF8JoHzdLM=
Date:   Tue, 28 Jan 2020 11:11:33 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Roderick Colenbrander <thunderbird2k@gmail.com>
cc:     Martyn Welch <martyn@welchs.me.uk>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Conn O'Griofa <connogriofa@gmail.com>,
        "Colenbrander, Roelof" <roderick.colenbrander@sony.com>
Subject: Re: [PATCH] HID: Sony: Add support for Gasia controllers
In-Reply-To: <CAEc3jaDjVZF_Z7Guj1YUo5J5C_-GEOYTH=LKARKccCwQAwuZnQ@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2001281109030.31058@cbobk.fhfr.pm>
References: <20200126194513.6359-1-martyn@welchs.me.uk> <CAEc3jaDjVZF_Z7Guj1YUo5J5C_-GEOYTH=LKARKccCwQAwuZnQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 27 Jan 2020, Roderick Colenbrander wrote:

> Thanks for sharing your patch. Though I must say with my Sony hat on, I 
> don't really like supporting clone devices (they hijack our device ids.. 
> etcetera) and we support hid-sony in an official capacity now across 
> various devices. 

Drifting away from this particular patch a little bit -- given this 
official support from Sony, would you be fine with putting this into 
writing, and adding yourself to MAINTAINERS file?

Thanks,

-- 
Jiri Kosina
SUSE Labs

