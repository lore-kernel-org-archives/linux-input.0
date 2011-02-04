From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCHv2] evdev: fix evdev_write return value on partial writes
Date: Fri, 04 Feb 2011 12:00:28 +0100
Message-ID: <877hdgrrn7.fsf@macbook.be.48ers.dk>
References: <1296122607-9526-1-git-send-email-jacmet@sunsite.dk>
	<20110127110255.GA15159@polaris.bitmath.org>
	<871v3ysibp.fsf@macbook.be.48ers.dk>
	<20110127114727.GA15626@polaris.bitmath.org>
	<87pqrir1r2.fsf@macbook.be.48ers.dk>
	<20110127122625.GD15626@polaris.bitmath.org>
	<87lj26qzyy.fsf@macbook.be.48ers.dk>
	<20110204084652.GB13046@core.coreip.homeip.net>
	<20110204102405.GA1567@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50077 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab1BDLAi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Feb 2011 06:00:38 -0500
Received: by wyb28 with SMTP id 28so2117649wyb.19
        for <linux-input@vger.kernel.org>; Fri, 04 Feb 2011 03:00:36 -0800 (PST)
In-Reply-To: <20110204102405.GA1567@polaris.bitmath.org> (Henrik Rydberg's
	message of "Fri, 4 Feb 2011 11:24:05 +0100")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, baruch@tkos.co.il

>>>>> "Henrik" == Henrik Rydberg <rydberg@euromail.se> writes:

Hi,

 >> I think that returning -EINVAL is good idea, so I am going to apply it.
 >> I also think we can change this loop to do-while kind since we already
 >> checked there enough space for an event.

 Henrik> The code below will return -EINVAL even if some parts of the buffer
 Henrik> was successfully read, though.

You mean written? I don't see that. The only place we return -EINVAL is
at the initial check.

 >> --- a/drivers/input/evdev.c
 >> +++ b/drivers/input/evdev.c
 >> @@ -321,6 +321,9 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
 >> struct input_event event;
 >> int retval;

 Henrik> Alternatively,

 Henrik> size_t num_written = 0;
 Henrik> int ret = 0;

Any reason for this bigger change? It's imho pretty clear as is. I don't
see any functional change from your version.

-- 
Bye, Peter Korsgaard
