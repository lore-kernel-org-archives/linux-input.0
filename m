Return-Path: <SRS0=uQL6=C7=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E310C2D0E2
	for <linux-input@archiver.kernel.org>; Tue, 22 Sep 2020 09:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28318221F0
	for <linux-input@archiver.kernel.org>; Tue, 22 Sep 2020 09:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600766347;
	bh=mWFRSZMyBbjwK/FEQm1JMdfw+4awqsgxyVdSlSR+BE4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=Sn6xQ8VGaBxF0SLER4V0KQimm1rd7MRaIk2jBB594T7RlUEU9/WJfSoxd174siv/K
	 8DQryr8FwVafNr+H/iX/qJjqL5sg/AcLTHKjDdHEss1p27r5SWuW1Q52aR6UDmyWCT
	 gG5oCIgT3s4RLXK2IbdmyHmGDsJNQiDtvD4BRbLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgIVJTG (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 22 Sep 2020 05:19:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgIVJTG (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 22 Sep 2020 05:19:06 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 320A72075E;
        Tue, 22 Sep 2020 09:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600766345;
        bh=mWFRSZMyBbjwK/FEQm1JMdfw+4awqsgxyVdSlSR+BE4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=eDRX5gyGqt2fplwA55rpFPGnTMwa7OmKZ8zKsKHi8HAF8J7UzNVeDKZG9TPudC4lZ
         BL3+12jGTB0Kas3zxYvSAjUG4TFgcq9dxzn9MrZ4A4qgsLziUbz0kBLw1zUvqxTacD
         GCbP6OCWx4JXcS4XXTZ/CZItrNszCOm2jUYTrW6o=
Date:   Tue, 22 Sep 2020 11:19:00 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
cc:     linux-i2c@vger.kernel.org, aaron.ma@canonical.com, admin@kryma.net,
        andriy.shevchenko@linux.intel.com, benjamin.tissoires@redhat.com,
        hdegoede@redhat.com, hn.chen@weidahitech.com,
        jarkko.nikula@linux.intel.com, kai.heng.feng@canonical.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, vicamo.yang@canonical.com,
        wsa@kernel.org
Subject: Re: [PATCH v2 0/4] i2c-hid: Save power by reducing i2c xfers with
 block reads
In-Reply-To: <20200917052256.5770-1-sultan@kerneltoast.com>
Message-ID: <nycvar.YFH.7.76.2009221118150.3336@cbobk.fhfr.pm>
References: <20200917052256.5770-1-sultan@kerneltoast.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 16 Sep 2020, Sultan Alsawaf wrote:

> From: Sultan Alsawaf <sultan@kerneltoast.com>
> 
> This is a fixed resubmission of "[PATCH 0/2] i2c-hid: Save power by reducing i2c
> xfers with block reads". That original patchset did not have enough fixes for
> the designware i2c adapter's I2C_M_RECV_LEN feature, which is documented
> extensively in the original email thread.
> 
> Here is the original cover letter, which still applies:
> "I noticed on my Dell Precision 15 5540 with an i9-9880H that simply putting my
> finger on the touchpad would increase my system's power consumption by 4W, which
> is quite considerable. Resting my finger on the touchpad would generate roughly
> 4000 i2c irqs per second, or roughly 20 i2c irqs per touchpad irq.
> 
> Upon closer inspection, I noticed that the i2c-hid driver would always transfer
> the maximum report size over i2c (which is 60 bytes for my touchpad), but all of
> my touchpad's normal touch events are only 32 bytes long according to the length
> byte contained in the buffer sequence.
> 
> Therefore, I was able to save about 2W of power by passing the I2C_M_RECV_LEN
> flag in i2c-hid, which says to look for the payload length in the first byte of
> the transfer buffer and adjust the i2c transaction accordingly. The only problem
> though is that my i2c controller's driver allows bytes other than the first one
> to be used to retrieve the payload length, which is incorrect according to the
> SMBus spec, and would break my i2c-hid change since not *all* of the reports
> from my touchpad are conforming SMBus block reads.
> 
> This patchset fixes the I2C_M_RECV_LEN behavior in the designware i2c driver and
> modifies i2c-hid to use I2C_M_RECV_LEN to save quite a bit of power. Even if the
> peripheral controlled by i2c-hid doesn't support block reads, the i2c controller
> drivers should cope with this and proceed with the i2c transfer using the
> original requested length."
> 
> Sultan
> 
> Sultan Alsawaf (4):
>   i2c: designware: Fix transfer failures for invalid SMBus block reads
>   i2c: designware: Ensure tx_buf_len is nonzero for SMBus block reads
>   i2c: designware: Allow SMBus block reads up to 255 bytes in length
>   HID: i2c-hid: Use block reads when possible to save power
> 
>  drivers/hid/i2c-hid/i2c-hid-core.c         |  5 ++++-
>  drivers/i2c/busses/i2c-designware-master.c | 15 +++++++++------
>  2 files changed, 13 insertions(+), 7 deletions(-)

Hans, Benjamin, could you please give this patchset some smoke-testing? It 
looks good to me, but I'd like it to get some testing from your testing 
machinery before merging.

Thanks,

-- 
Jiri Kosina
SUSE Labs

