From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv2] evdev: fix evdev_write return value on partial writes
Date: Fri, 4 Feb 2011 09:15:19 -0800
Message-ID: <20110204171519.GA14000@core.coreip.homeip.net>
References: <20110127110255.GA15159@polaris.bitmath.org>
 <871v3ysibp.fsf@macbook.be.48ers.dk>
 <20110127114727.GA15626@polaris.bitmath.org>
 <87pqrir1r2.fsf@macbook.be.48ers.dk>
 <20110127122625.GD15626@polaris.bitmath.org>
 <87lj26qzyy.fsf@macbook.be.48ers.dk>
 <20110204084652.GB13046@core.coreip.homeip.net>
 <20110204102405.GA1567@polaris.bitmath.org>
 <877hdgrrn7.fsf@macbook.be.48ers.dk>
 <20110204112314.GA1501@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33868 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511Ab1BDRPa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Feb 2011 12:15:30 -0500
Received: by iwn9 with SMTP id 9so2360169iwn.19
        for <linux-input@vger.kernel.org>; Fri, 04 Feb 2011 09:15:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110204112314.GA1501@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, linux-input@vger.kernel.org, baruch@tkos.co.il

On Fri, Feb 04, 2011 at 12:23:14PM +0100, Henrik Rydberg wrote:
> >  Henrik> The code below will return -EINVAL even if some parts of the buffer
> >  Henrik> was successfully read, though.
> > 
> > You mean written? I don't see that. The only place we return -EINVAL is
> > at the initial check.
> 
> Right, it should have been written, and -EFAULT, referring to the code
> in the loop.
> 

If we faulted somewhere midway the only sane thing it to treat the whole
request as suspect and return -EFAULT. We really do not know what
happened to the other data (it could have gone past the buffer user
intended but haven't triggered the fault yet. We can't fully recover
either since we aleady retrievend the event that caused fault.

-- 
Dmitry
