From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RESEND patch 2.6.25-rc8] ads7846 vref support (ads7843)
Date: Fri, 11 Apr 2008 09:50:26 -0400
Message-ID: <20080411094738.ZZRA012@mailhub.coreip.homeip.net>
References: <200804110036.34408.david-b@pacbell.net> <200804110115.25647.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.189]:36420 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758503AbYDKNud (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Apr 2008 09:50:33 -0400
Received: by rn-out-0910.google.com with SMTP id e11so384641rng.17
        for <linux-input@vger.kernel.org>; Fri, 11 Apr 2008 06:50:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200804110115.25647.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-input@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz

On Fri, Apr 11, 2008 at 01:15:25AM -0700, David Brownell wrote:
> On Friday 11 April 2008, David Brownell wrote:
> > Updated since the version sent 5-January (evidently bounced from
> > list archives) ... to remove the warning fix that was merged (from
> > someone else) on 10-March.
> > 

Could you please check the following commit in my tree and make sure
it is the right one:

http://git.kernel.org/?p=linux/kernel/git/dtor/input.git;a=commit;h=7c6d0ee14cb7a4cfad4864dc196256da5749bc0c

> > MAINTAINERS says "linux-input@vger" but the only archives
> > I could find seems to say "@atrey.karlin.mff.cuni.cz"...
> 
> I eventually found an @vger archive, but it seems to have no
> postings since February (unlike the @atrey one).  Those two
> lost patches certainly made it to that archive:
> 
>   http://www.mail-archive.com/linux-input@vger.kernel.org/msg00086.html
>   http://www.mail-archive.com/linux-input@vger.kernel.org/msg00103.html
> 
> It seems maybe the MAINTAINERS entry may be incorrect ...

@vger is the correct only, we are migrating from @atrey due to heavy
spam issues.

-- 
Dmitry
