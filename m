From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: usbtouchscreen - reduce number fo be16_to_cpu
 conversions
Date: Fri, 4 Jun 2010 09:24:10 -0700
Message-ID: <20100604162410.GA16827@core.coreip.homeip.net>
References: <20100604075057.15829.92443.stgit@localhost.localdomain>
 <201006041235.03153.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f185.google.com ([209.85.222.185]:57399 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880Ab0FDQYP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Jun 2010 12:24:15 -0400
Received: by pzk15 with SMTP id 15so1017136pzk.15
        for <linux-input@vger.kernel.org>; Fri, 04 Jun 2010 09:24:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201006041235.03153.linux@rainbow-software.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-input@vger.kernel.org

On Fri, Jun 04, 2010 at 12:35:02PM +0200, Ondrej Zary wrote:
> On Friday 04 June 2010, Dmitry Torokhov wrote:
> > Let's perform be16_to_cpu() conversions once for each received packet,
> > and then use cached values. Makes code a little bit easier to follow.
> >
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> > ---
> >
> > Ondrej,
> >
> > Any chance you could test the following patch?
> 
> Thanks for the patch, it works.
> 

Thanks Ondrej, I'll queue it for .36 then.

-- 
Dmitry
