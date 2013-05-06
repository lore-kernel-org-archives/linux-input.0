From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [BUG] suspicious RCU usage
Date: Mon, 6 May 2013 13:09:17 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1305061308190.12890@pobox.suse.cz>
References: <51835EFD.2070403@gmail.com> <CAN+gG=F5O_EAr8P2Zgy7w39JcBJwWVzUSUaj0s6U0C6SRP6tYA@mail.gmail.com> <alpine.LNX.2.00.1305031022260.11002@pobox.suse.cz> <518392FE.4000302@gmail.com> <alpine.LNX.2.00.1305031324590.11002@pobox.suse.cz>
 <20130503155113.GB5567@core.coreip.homeip.net> <51870307.2020107@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49615 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753998Ab3EFLJX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 6 May 2013 07:09:23 -0400
In-Reply-To: <51870307.2020107@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, majianpeng <majianpeng@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>

On Fri, 3 May 2013, Dmitry Torokhov wrote:

> > > [  150.908051] ======================================================
> > > [  150.908053] [ INFO: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected ]
> > > [  150.908056] 3.9.0+ #102 Not tainted
> > 
> > Right, oh well, I missed that scenario.
> 
> This looks good to me.
> 
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, 6 May 2013, majianpeng wrote:

> > Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >
> It's  all good for me.

Thanks a lot. I have now queued the patch for 3.10.

-- 
Jiri Kosina
SUSE Labs
