From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: Re: uinput: ioctls for UI_BEGIN_FF_UPLOAD fails (returns -1). How to
 debug?
Date: Thu, 31 Mar 2016 19:46:50 +0200
Message-ID: <56FD628A.6040606@m-reimer.de>
References: <56F82C42.6020002@m-reimer.de>
 <CAM4jgCp_t_mvayUbBnz_1aznbvZJz8jFLxbD49r=qLZCdOhH7Q@mail.gmail.com>
 <56F8F107.3050906@m-reimer.de>
 <CAM4jgCo9a-6ati0tQWCZqBRyxM6E6NrQK6Cj0uGQAogCRMgrOA@mail.gmail.com>
 <56FAB1D3.5020003@m-reimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:50439 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753474AbcCaRqz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Mar 2016 13:46:55 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.mailbox.org (Postfix) with ESMTPS id 738D843B1E
	for <linux-input@vger.kernel.org>; Thu, 31 Mar 2016 19:46:53 +0200 (CEST)
Received: from smtp1.mailbox.org ([80.241.60.240])
	by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
	with ESMTP id AcQwjm1rxydm for <linux-input@vger.kernel.org>;
	Thu, 31 Mar 2016 19:46:52 +0200 (CEST)
In-Reply-To: <56FAB1D3.5020003@m-reimer.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

On 03/29/2016 06:48 PM, Manuel Reimer wrote:
> As the idea was to publish this under GPL3 anyway, I've uploaded my
> early development state:
>
> https://github.com/M-Reimer/pspaddrv

I'm still getting the errors and I'm still not finding any reason for them.

I had a look at the kernel code and there are mutex locks, so at least 
it seems like it should be thread-safe.

So what I don't understand is, if there are any limitations with the 
function "mutex_lock_interruptible" used by the kernel.

As I have a big list of "write" in here:
https://github.com/M-Reimer/pspaddrv/blob/master/uinput.c#L170
And this block is called at maximum speed the USB attached controller 
can deliver. I guess there is a really good chance that this function is 
hit between "EV_UINPUT" is received and my UI_BEGIN_FF_UPLOAD ioctl is 
sent. Will this conflict in some way?

Of course, it is possible to prefilter the events, I plan to send to 
uinput. I can keep a copy of the last sent event block and compare each 
event to the old state before actually sending it. Is there any chance 
that this could help in this case?

Thanks in advance

Manuel
