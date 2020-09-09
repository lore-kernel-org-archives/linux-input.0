Return-Path: <SRS0=+NLB=CS=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD433C433E2
	for <linux-input@archiver.kernel.org>; Wed,  9 Sep 2020 06:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 988A321532
	for <linux-input@archiver.kernel.org>; Wed,  9 Sep 2020 06:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599633357;
	bh=FTAgov64ac04dst3A94wgkLpWgOSry5DPtPvBH46Xo8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=QWcAl5s5jJSGLis4Zhsd1c3nTRqIOXwbnvTbj4KCTOusrYkthZbYkUjK2T2rm4Utl
	 Y/1uzeKtaxfa+pmzi9fCMt5wbovSQbqd/nwunWUqbwDxApTptzhQ48FWqvqgwH32WQ
	 08wH3S9IcEf46knaM5YgZ6plGBebtPH57YLe/+QE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgIIGf4 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 9 Sep 2020 02:35:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgIIGf4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 9 Sep 2020 02:35:56 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DC9C21741;
        Wed,  9 Sep 2020 06:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599633355;
        bh=FTAgov64ac04dst3A94wgkLpWgOSry5DPtPvBH46Xo8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Lez1JDQ6EymzGW68pPp9Bu7sdiO3BRpN5RYaj6dzlZIAQ3bbe7PxSpCYfo/FRRbO+
         bxIF9LtU45tZb/7TLf1LBWrYaumwtCfqvaRf1qr4U9ZQWr6w8R3pIe2Uh+F4NP3CxA
         KuEf/orKS0DQBZp5GxqGW0Uz7FyC5G/tBCMD3Ezs=
Date:   Wed, 9 Sep 2020 08:35:52 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
cc:     Stefan Achatz <erazor_de@users.sourceforge.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] HID: roccat: add bounds checking in
 kone_sysfs_write_settings()
In-Reply-To: <20200824085735.GA208317@mwanda>
Message-ID: <nycvar.YFH.7.76.2009090835410.4671@cbobk.fhfr.pm>
References: <20200824085735.GA208317@mwanda>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 24 Aug 2020, Dan Carpenter wrote:

> This code doesn't check if "settings->startup_profile" is within bounds
> and that could result in an out of bounds array access.  What the code
> does do is it checks if the settings can be written to the firmware, so
> it's possible that the firmware has a bounds check?  It's safer and
> easier to verify when the bounds checking is done in the kernel.
> 
> Fixes: 14bf62cde794 ("HID: add driver for Roccat Kone gaming mouse")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2:  In the v1 patch I added a check against settings->size but that's
> potentially too strict so it was removed.

Applied, thanks Dan.

-- 
Jiri Kosina
SUSE Labs

