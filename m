From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Eliminate double kfree
Date: Thu, 29 May 2008 12:14:23 -0400
Message-ID: <20080529121315.ZZRA012@mailhub.coreip.homeip.net>
References: <Pine.LNX.4.64.0805291504400.26229@ask.diku.dk> <20080529101012.ZZRA012@mailhub.coreip.homeip.net> <Pine.LNX.4.64.0805291754480.26229@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:47582 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775AbYE2QOb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 May 2008 12:14:31 -0400
Received: by ug-out-1314.google.com with SMTP id h2so130221ugf.16
        for <linux-input@vger.kernel.org>; Thu, 29 May 2008 09:14:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0805291754480.26229@ask.diku.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Thu, May 29, 2008 at 05:57:50PM +0200, Julia Lawall wrote:
> On Thu, 29 May 2008, Dmitry Torokhov wrote:
> 
> > Hi Julia,
> > 
> > On Thu, May 29, 2008 at 03:05:07PM +0200, Julia Lawall wrote:
> > > From: Julia Lawall <julia@diku.dk>
> > > 
> > > The variable report is only non-NULL and non-freed in a small region of
> > > code, so it should only be freed in error handling code that comes from
> > > that region.
> > > 
> > 
> > Thank you for your patch. There isn't a double-kfree though, as far
> > as I can see.
> 
> There was a double free because the error handling at the end of the 
> function (for input_register_device) would fall through to the 
> kfree(report) under err_free_devs, even though report is already freed at 
> that point.
> 

Ah, yes, indeed.. Well, that decides what branch the patch gets
applied then ;)

-- 
Dmitry
