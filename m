From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Input sync flag when registering.
Date: Mon, 25 Aug 2014 11:19:06 -0700
Message-ID: <20140825181906.GA35881@core.coreip.homeip.net>
References: <53FAF963.9020403@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:42045 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbaHYSTR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Aug 2014 14:19:17 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so20632523pdb.41
        for <linux-input@vger.kernel.org>; Mon, 25 Aug 2014 11:19:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53FAF963.9020403@parrot.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Poussevin <thomas.poussevin@parrot.com>
Cc: linux-input@vger.kernel.org

Hi Thomas,

On Mon, Aug 25, 2014 at 10:52:51AM +0200, Thomas Poussevin wrote:
> Hi,
> I noticed that with touchscreen drivers that don't explicitly call a
> input_sync after input_register_device, suspend to ram is blocked if
> no event is sent, because the input_dev created is considered as not
> synchronized. The problem was seen with Atmel mxt driver. When any
> event is sent, the driver explicitly ask a sync, so the problem is
> solved.
> The problem occurs only when the screen has never send any event
> before suspend to ram.
> I solved it setting the sync element to true (when input dev is
> created, no element is pending).
> Is there a better way to solve the problem ?

It is not clear to me what the problem is. The kernel as far as I
remember never checked state of 'sync' field when executing suspend
callbacks. Moreover there is no longer 'sync' field at all in mainline.

It sounds like some userspace code makes assumptions that are not always
valid.

Thanks.

-- 
Dmitry
