Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47342C433E0
	for <linux-input@archiver.kernel.org>; Thu,  7 Jan 2021 09:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09E0E23339
	for <linux-input@archiver.kernel.org>; Thu,  7 Jan 2021 09:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbhAGJMv (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 7 Jan 2021 04:12:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:43256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbhAGJMv (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 7 Jan 2021 04:12:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB78823370;
        Thu,  7 Jan 2021 09:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610010730;
        bh=D8bgci7JzMPrF+xWlb6WIcgDoKHG3h151E0qvm5YFqM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=VBhkhDLY8ht5rggDkYRvdLIlX2rnGiJsy7cOMY20IpxuPS6WN54Y4wKdGXRgDN6B3
         6Efw5E4ex7+JO8Ms6FFsgUdKTSQjIoHjDUWTFi9s7cdnwCSAB1G3nB9NMg6Itd0Jvx
         JCJYJLl7txFlEH15DSDI7tXFDPD5M+dybDKrLNDvXKlRbgl+ErmUWGSvQ+Y18xJFgQ
         FV6W3P/N036J3YhTqt7afCzPtWiqoWHna8G3+B8MVpddOCgs81sV4rmbBbT7nl3Hs9
         nRWqLUrPL/F9NmuraEMClrp9LQ+ZFteRATW50VCqV2PKfLcBz+wWsAIvwnmvjB7mFt
         chyBinKXJ7kzg==
Date:   Thu, 7 Jan 2021 10:12:07 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Hui Wang <hui.wang@canonical.com>
cc:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com
Subject: Re: [PATCH 2/2] HID: i2c-hid: Add a quirk to keep the power in
 shutdown
In-Reply-To: <20201204152912.151604-2-hui.wang@canonical.com>
Message-ID: <nycvar.YFH.7.76.2101071011130.13752@cbobk.fhfr.pm>
References: <20201204152912.151604-1-hui.wang@canonical.com> <20201204152912.151604-2-hui.wang@canonical.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, 4 Dec 2020, Hui Wang wrote:

> On the latest Thinkpad Yoga laptop, the touchscreen module is wacom
> I2C WACF2200 (056a:5276), we found the touchscreen could not work
> after rebooting, needs to poweroff the machine then poweron the
> machine to let it work.
> 
> It is highly possible that this is a BIOS issue, but the windows
> doesn't have this problem with the same BIOS.
> 
> If keeping the power on when calling shutdown, the touchscreen could
> work after rebooting. Let us add a quirk for it and apply the quirk
> to this machine only.

I wonder what do Windows do differently here. Perhaps they never put the 
i2c device to sleep while in shutdown anyway? Is there any downside to 
(not) doing the same?

Thanks,

-- 
Jiri Kosina
SUSE Labs

