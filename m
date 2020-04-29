Return-Path: <SRS0=4q52=6N=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C48C83000
	for <linux-input@archiver.kernel.org>; Wed, 29 Apr 2020 14:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74E202082E
	for <linux-input@archiver.kernel.org>; Wed, 29 Apr 2020 14:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588170314;
	bh=VDO/bSM/ZbI620BK2FYXkq7iHouXBcpOxjTvu+Nbsz4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=bYmc/SthV4xO9B7TAHunRo2TXvSswqRDcLTMdXMlikwV4GnIYUnsivL87jxjFcevW
	 DjawirbUKKTEtGYQVD3c4oq5N7AWUFQSmbnLdutwKeW9glCKV2zr1OIY2jgPXI6/Pa
	 5q/vsuXuayiChV0U/AhhvJ1OBQBk3QgqMpxaRrBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgD2OZO (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbgD2OZN (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 29 Apr 2020 10:25:13 -0400
Received: from pobox.suse.cz (unknown [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 466FF206F0;
        Wed, 29 Apr 2020 14:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588170313;
        bh=VDO/bSM/ZbI620BK2FYXkq7iHouXBcpOxjTvu+Nbsz4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=BKLk16Q032JkI67Elw/wMXKnxNN/0LvKOJ3YW42WouJH5D/6crMar2DWE+t9M/Sp0
         qiCf/fDAo/gLGmI+gh/drjtnOt5yogeUKDYm2HaO5r78LdxEvqBowHF14FdfskiZYE
         r5s9/OTKtCY5ZtNZ8I8NXMxahBTdb4+v2aHdl3K0=
Date:   Wed, 29 Apr 2020 16:25:10 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        syzkaller-bugs@googlegroups.com, linux-input@vger.kernel.org,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usbhid: Fix race between usbhid_close() and
 usbhid_stop()
In-Reply-To: <Pine.LNX.4.44L0.2004221614580.11262-100000@iolanthe.rowland.org>
Message-ID: <nycvar.YFH.7.76.2004291624550.19713@cbobk.fhfr.pm>
References: <Pine.LNX.4.44L0.2004221614580.11262-100000@iolanthe.rowland.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 22 Apr 2020, Alan Stern wrote:

> The syzbot fuzzer discovered a bad race between in the usbhid driver
> between usbhid_stop() and usbhid_close().  In particular,
> usbhid_stop() does:
> 
> 	usb_free_urb(usbhid->urbin);
> 	...
> 	usbhid->urbin = NULL; /* don't mess up next start */
> 
> and usbhid_close() does:
> 
> 	usb_kill_urb(usbhid->urbin);
> 
> with no mutual exclusion.  If the two routines happen to run
> concurrently so that usb_kill_urb() is called in between the
> usb_free_urb() and the NULL assignment, it will access the
> deallocated urb structure -- a use-after-free bug.
> 
> This patch adds a mutex to the usbhid private structure and uses it to
> enforce mutual exclusion of the usbhid_start(), usbhid_stop(),
> usbhid_open() and usbhid_close() callbacks.
> 
> Reported-and-tested-by: syzbot+7bf5a7b0f0a1f9446f4c@syzkaller.appspotmail.com
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> CC: <stable@vger.kernel.org>
> 
> ---
> 
> 
> [as1935]

Applied, thanks a lot Alan.

-- 
Jiri Kosina
SUSE Labs

