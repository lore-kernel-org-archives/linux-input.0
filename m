Return-Path: <SRS0=iUnu=55=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCD2C2BA19
	for <linux-input@archiver.kernel.org>; Mon, 13 Apr 2020 09:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90DF820575
	for <linux-input@archiver.kernel.org>; Mon, 13 Apr 2020 09:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gobbetti.name header.i=@gobbetti.name header.b="sZz30rHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgDMJnN (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 13 Apr 2020 05:43:13 -0400
Received: from mail.howbe.it ([159.69.24.60]:35170 "EHLO mail.howbe.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbgDMJnM (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Apr 2020 05:43:12 -0400
X-Greylist: delayed 482 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 05:43:11 EDT
Received: from kowalski.casa.d.gobbetti.name (78-134-117-45.v4.ngi.it [78.134.117.45])
        (Authenticated sender: daniele)
        by gloria.howbe.it (Postfix) with ESMTPSA id 725A658
        for <linux-input@vger.kernel.org>; Mon, 13 Apr 2020 11:35:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gobbetti.name;
        s=default; t=1586770508;
        bh=aEhVdzDZqX5ZhYnUJjWRwbhfmjj0C5tHqQzzxuT9Q50=;
        h=Subject:From:To:Date:From;
        b=sZz30rHeMBsiQTcic7BEO8UzSkTugdyXC/xTxuZ5wDSqCjCP2HtUz+YxakpKcIW6E
         ftnME4M//qmCfusj6XApEZk6vBiV7445op6nAyqAxugQfW8kC1Ms7sJArUIdi+RDQb
         SDk2jesmZPJtL3ZIQsSSiu4om0EJ7v85CYJK3wjU=
Message-ID: <3247c26ae8598864e960fc79d4928a03198404b7.camel@gobbetti.name>
Subject: Goodix Touchscreen Active Stylus support
From:   Daniele Gobbetti <daniele@gobbetti.name>
To:     linux-input@vger.kernel.org
Date:   Mon, 13 Apr 2020 11:35:07 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hello,

I own a Chuwi Minibook which contains a goodix touchscreen controller
that supports an Active Stylus.

I have (a working prototype of) a patch which is working good on my
device and is loosely based upon [1] but much less invasive.

My patch is creating a second input device for the active stylus. I
noticed this is already done in some other devices (e.g. the surface3
[2], [3]) and has the advantage that the second input device deals
natively with events like proximity.

According to [1] there at least 7 other devices that would benefit from
the inclusion of this functionality in the kernel.

Do you think it makes sense to add support for active styli in the
goodix touchscreen driver?
Would you be interested in reviewing my patch?
Do you think it is acceptable to create a second input device for this?

Best regards,
Daniele


[1] https://gitlab.com/AdyaAdya/goodix-touchscreen-linux-driver/ 
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/tree/drivers/input/touchscreen/surface3_spi.c#n252
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/tree/drivers/input/touchscreen/surface3_spi.c#n288

