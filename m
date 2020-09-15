Return-Path: <SRS0=5+t2=CY=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F663C43461
	for <linux-input@archiver.kernel.org>; Tue, 15 Sep 2020 21:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20FA420770
	for <linux-input@archiver.kernel.org>; Tue, 15 Sep 2020 21:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600203713;
	bh=Ij/vY2AygUYW9NMEXUsqQbtQ4ionnnndTBEDQBd5nz4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=aGWQzqMk8xU09ZKecf/1Mj5LM1I9x7zyKbYghNjPM3bPtt9I5X/Lah1fEL6I/U3AB
	 PwO5vQJH3QNvv7IJOR2Otzi0+aKtqmGKDX8otJq7s3yVOKQivVtbqwjxMSH+H/yUeX
	 CwY4G87Ot7P121hjxIQRvhtIASmGZYh/wo4GDmN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgIOU7q (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 15 Sep 2020 16:59:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728037AbgIOUpA (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 15 Sep 2020 16:45:00 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5B4720809;
        Tue, 15 Sep 2020 20:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600202694;
        bh=Ij/vY2AygUYW9NMEXUsqQbtQ4ionnnndTBEDQBd5nz4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=w1or3URSKv21LQ8OWSHPYCailYOGScLktGhVjTKiMS3wN4Uh3MLj//c4J2hME5SgG
         8wxsSnwcg/bXDaV6hTpgTRb+XR4yRVIQL+rerZ9SLSRbJkdIRlp2+PZDeYYTK31Ct7
         pyBWQVP9q+KjDANMVPr1TYXCQUcTA+8xFoFoxSS0=
Date:   Tue, 15 Sep 2020 22:44:36 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
cc:     jarkko.nikula@linux.intel.com, aaron.ma@canonical.com,
        admin@kryma.net, andriy.shevchenko@linux.intel.com,
        benjamin.tissoires@redhat.com, hdegoede@redhat.com,
        hn.chen@weidahitech.com, kai.heng.feng@canonical.com,
        linux-i2c@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
        vicamo.yang@canonical.com, wsa@kernel.org
Subject: Re: [PATCH v3] i2c: Squash of SMBus block read patchset to save
 power
In-Reply-To: <20200914001523.3878-1-sultan@kerneltoast.com>
Message-ID: <nycvar.YFH.7.76.2009152243190.3336@cbobk.fhfr.pm>
References: <b3b751fc-668d-91e2-220b-0d7edd231e01@linux.intel.com> <20200914001523.3878-1-sultan@kerneltoast.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sun, 13 Sep 2020, Sultan Alsawaf wrote:

> From: Sultan Alsawaf <sultan@kerneltoast.com>
> 
> This is a squash of the following:
> 
> i2c: designware: Fix transfer failures for invalid SMBus block reads
[ .... ]
> HID: i2c-hid: Use block reads when possible to save power
[ .... ]
> ---
> Hi Jarkko,
> 
> Sorry for the delayed response. Life gets in the way of the things that really
> matter, like kernel hacking ;)
> 
> I fixed the issue with the i2c block reads on 5.8. I've squashed all 4 of my i2c
> commits into this email for simplicity; please apply this patch on either 5.8 or
> 5.9 (it applies cleanly to both) and let me know if it works with your i2c-hid
> touchscreen. If all is well, I will resubmit these patches individually in one
> patchset, in a new thread.
> 
> Thanks,
> Sultan
>  drivers/hid/i2c-hid/i2c-hid-core.c         |  5 ++++-
>  drivers/i2c/busses/i2c-designware-master.c | 15 +++++++++------
>  2 files changed, 13 insertions(+), 7 deletions(-)

I believe it makes most sense for this to go through i2c tree as a whole, 
so feel free to add

	Acked-by: Jiri Kosina <jkosina@suse.cz>

for the drivers/hid/i2c-hid/i2c-hid-core.c hunk. Thanks,

-- 
Jiri Kosina
SUSE Labs

