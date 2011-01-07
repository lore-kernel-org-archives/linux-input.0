From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch] input/tc3589x: fix compile error
Date: Fri, 7 Jan 2011 09:45:16 -0800
Message-ID: <20110107174516.GA28875@core.coreip.homeip.net>
References: <20110104110820.GC1886@bicker>
 <AANLkTi=izTVZ2OH+drgimtB3o=e9Ksu5G+a+VHFDPk=j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58623 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754603Ab1AGRpX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Jan 2011 12:45:23 -0500
Received: by gyb11 with SMTP id 11so6649300gyb.19
        for <linux-input@vger.kernel.org>; Fri, 07 Jan 2011 09:45:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=izTVZ2OH+drgimtB3o=e9Ksu5G+a+VHFDPk=j@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Sundar Iyer <sundar.iyer@stericsson.com>, linux-input@vger.kernel.org, Dan Carpenter <error27@gmail.com>

On Fri, Jan 07, 2011 at 11:12:38AM +0100, Linus Walleij wrote:
> 2011/1/4 Dan Carpenter <error27@gmail.com>:
> 
> > There was a semi-colon missing and it broke the compile.
> >
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> Dmitry can you take this fixup into the input tree?
> Russell pulled the tc3589x driver into his tree and Torvalds
> pulled it into his tree, so if you are based on Torvalds' tree
> for today it should apply fine.
> 

I normally merge with mainline at -rc1 or -rc2 points so I do not have
the driver yet.

I think this is one of those times when forwarding patch directly to
Linus instead of waiting for it to trickle through all the trees is the
most sensible solution.

Thanks.

-- 
Dmitry
