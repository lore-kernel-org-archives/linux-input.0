From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: Re: How to get the kernel to emulate force feedback events?
Date: Sun, 21 Feb 2016 11:20:45 +0100
Message-ID: <56C98F7D.6090100@m-reimer.de>
References: <56C8BE6D.7050409@m-reimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:51691 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752855AbcBUR3O (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Feb 2016 12:29:14 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.mailbox.org (Postfix) with ESMTPS id C855043B19
	for <linux-input@vger.kernel.org>; Sun, 21 Feb 2016 11:20:47 +0100 (CET)
Received: from smtp1.mailbox.org ([80.241.60.240])
	by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
	with ESMTP id WENyd2eFuS76 for <linux-input@vger.kernel.org>;
	Sun, 21 Feb 2016 11:20:46 +0100 (CET)
In-Reply-To: <56C8BE6D.7050409@m-reimer.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On 02/20/2016 08:28 PM, Manuel Reimer wrote:
> But what could be the mistake, which allowed me to create a device
> driver which actually only supports FF_RUMBLE? Are there any special
> driver parameters that have to be present, so the kernel side emulation
> gets active?

After searching through the kernel source, I've found some more 
information. Event emulation is done here:

https://github.com/torvalds/linux/blob/master/drivers/input/ff-memless.c

And this is not triggered by the uinput kernel driver at all.

Would it be possible to add this feature to uinput?

Let's say: If only "FF_RUMBLE" is set and the device reports to be only 
able to handle one ff event, then initialize ff-memless.

I could try to create a patch for that, but it would be nice if someone 
of the "linux input pros" could at least tell what they think about 
this? Is this possible at all or is there anything which would make this 
fail?

Thanks in advance.

Best regards

Manuel
