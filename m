From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] appletouch driver and 4th generation macbooks
Date: Wed, 2 Apr 2008 10:19:47 -0400
Message-ID: <20080402101704.ZZRA012@mailhub.coreip.homeip.net>
References: <47DAB465.7090100@twam.info> <1205588795.15910.34.camel@johannes.berg> <47F36B03.4060704@twam.info> <1207135383.10910.39.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:27584 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503AbYDBOUd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Apr 2008 10:20:33 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1138743nfb.21
        for <linux-input@vger.kernel.org>; Wed, 02 Apr 2008 07:20:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1207135383.10910.39.camel@johannes.berg>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Tobias M?ller <Tobias_Mueller@twam.info>, linux-input@vger.kernel.org

Hi Johannes, Tobias,

On Wed, Apr 02, 2008 at 01:23:03PM +0200, Johannes Berg wrote:
> 
> On Wed, 2008-04-02 at 13:16 +0200, Tobias M??ller wrote:
> > Hi,
> > 
> > Johannes Berg schrieb:
> > >> Adds product ids for 4th generation MacBooks in appletouch driver. 
> > > 
> > > Looks good.
> > > 
> > >> Signed-off-by: Tobias Mueller <Tobias_Mueller@twam.info>
> > > 
> > > Acked-by: Johannes Berg <johannes@sipsolutions.net>
> >  
> > I still cannot find the new device ids in 2.6.25-rc8. Is there anything to do further from my side?
> 
> I guess I was supposed to pick up the patch and thought somebody else
> would. Dmitry, can you pick it up into your input tree?
> 
> I don't expect it to be going into 2.6.25 at this point, it's rather
> close to being released. On the other hand, it's not like it can cause
> regressions, but I guess we need to draw a line at some point.
> 

I applied the patch to my tree. I will try to push the change to Linus
before 2.6.25 since it is very low risk. Btw, is_geyser3() function
is becoming unwieldy. We might consider changing it to something that
scans array of integers instead of adding more conditions to that "if"
statement next time we add more IDs to it.

-- 
Dmitry
