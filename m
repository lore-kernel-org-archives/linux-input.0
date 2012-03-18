From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND] input: kxtj9: who_am_i check value and initial
 data rate fixes
Date: Sat, 17 Mar 2012 21:19:39 -0700
Message-ID: <20120318041939.GB19118@core.coreip.homeip.net>
References: <1328282872-10377-1-git-send-email-chudson@kionix.com>
 <CAB7Re7UT7tULwGqcwn+iQRC+nciDUS4J8LSVP5NasK3p1SOfsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47416 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab2CRETp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Mar 2012 00:19:45 -0400
Received: by dajr28 with SMTP id r28so8198078daj.19
        for <linux-input@vger.kernel.org>; Sat, 17 Mar 2012 21:19:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAB7Re7UT7tULwGqcwn+iQRC+nciDUS4J8LSVP5NasK3p1SOfsw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Hudson <chris.hudson.comp.eng@gmail.com>
Cc: linux-input@vger.kernel.org, Chris Hudson <chudson@kionix.com>

Hi Christopher,

On Fri, Mar 16, 2012 at 02:53:33PM -0400, Christopher Hudson wrote:
> ---------- Forwarded message ----------
> From: <chris.hudson.comp.eng@gmail.com>
> Date: Fri, Feb 3, 2012 at 10:27 AM
> Subject: [PATCH 1/1] input: kxtj9: who_am_i check value and initial data
> rate fixes
> To: linux-input@vger.kernel.org
> Cc: dmitry.torokhov@gmail.com, chris.hudson.comp.eng@gmail.com, Chris
> Hudson <chudson@kionix.com>
> 
> From: Chris Hudson <chudson@kionix.com>
> 
> Several fixes based on customer feedback:
> - WHO_AM_I value has changed since preliminary parts used for initial
> testing
> - Output of le16_to_cpu must be saved to memory before shifting to preserve
> sign
> - Initial data rate was not extracted from data control register init.
>  This was
>  causing the initial data rate to be set to maximum until it was changed.
>  To
>  fix this problem, it made more sense to specify an initial data rate and
>  extract the register mask from that.
> 
> Signed-off-by: Chris Hudson <chudson@kionix.com>

Your mailer messed up the patch (tabs converted to spaces, lines wrapped
up). I fixed it up and applied but please use proper MTA next time
around.

Thanks.

-- 
Dmitry
