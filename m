Return-Path: <SRS0=nOvE=B3=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B54C433E1
	for <linux-input@archiver.kernel.org>; Mon, 17 Aug 2020 10:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD25E2078E
	for <linux-input@archiver.kernel.org>; Mon, 17 Aug 2020 10:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597659343;
	bh=khtutIQkFltI68xUUMBML8b8IYSW0qnqxPWWfbEYhYM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=lnprUco0T7x3VwbVtFpy9ucpUqSjfBZ+54wTWbwfskgadszJGR5J8AZj7L4wVh7g0
	 zMgdnVf4oS8B6umCxS2IjaukzIjM6xNEv3K0b6ZnHg8/xqIszR78Rnm1VppoqAN3U1
	 WiB/oeOk3W7IJQbR5VeysW96FxIP8lXegG0Lrg9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgHQKPn (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:15:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbgHQKPm (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 17 Aug 2020 06:15:42 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8E4920738;
        Mon, 17 Aug 2020 10:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597659341;
        bh=khtutIQkFltI68xUUMBML8b8IYSW0qnqxPWWfbEYhYM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=NVLyDLjo6vZOiw0f49mfNPe8XVYdxxlgyHpcr6GVHuouLeLTlDv2Ic0wHCEKxBaTs
         hpzhqYB+fpCKfz/ZLE7iM0ErL84VNzsC5FoaO6B3RBXxwtGD+N6wypbpvccB+ne0K2
         mfG/+V+p17dUIW05+IqXQwNa6oFxpPv7FZ0oY7IE=
Date:   Mon, 17 Aug 2020 12:15:38 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     BALATON Zoltan <balaton@eik.bme.hu>
cc:     linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dan Bastone <dan@pwienterprises.com>
Subject: Re: [PATCH] HID: apple: Add support for Matias wireless keyboard
In-Reply-To: <20200720205741.0A114747871@zero.eik.bme.hu>
Message-ID: <nycvar.YFH.7.76.2008171214110.27422@cbobk.fhfr.pm>
References: <20200720205741.0A114747871@zero.eik.bme.hu>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, 20 Jul 2020, BALATON Zoltan wrote:

> The Matias Wireless keyboard has an Apple like layout and identifies
> as ISO RevB Alu keyboard. Use hid-apple for it so Fn key and media
> control functions work as expected.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

So If I understand correctly, this keyboard identifies itself with Apple 
VID, but in fact it is not.

I'd like to make sure that we don't break the real 
USB_DEVICE_ID_APPLE_ALU_REVB_ISO device produced by Apple; CCing Dan 
Bastone, who added this device ID back in 2011 (4a4c879904aa). Dan, any 
ideas please?

Thanks,

-- 
Jiri Kosina
SUSE Labs

