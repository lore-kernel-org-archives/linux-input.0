From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] [ARM] pxa/spitz: use GPIO matrix keypad driver
Date: Thu, 30 Jul 2009 11:43:07 +0200
Message-ID: <20090730094307.GD1802@ucw.cz>
References: <1248090115-20571-1-git-send-email-eric.y.miao@gmail.com> <20090729150738.GH1534@ucw.cz> <4A7128F8.3010506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58953 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbZHBN0M (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Aug 2009 09:26:12 -0400
Content-Disposition: inline
In-Reply-To: <4A7128F8.3010506@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Thu 2009-07-30 13:00:40, Eric Miao wrote:
> Pavel Machek wrote:
> > On Mon 2009-07-20 19:41:54, Eric Miao wrote:
> >> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> > 
> > Does this make some other driver obsolete? Should we disable the other
> > one or even remove it completely?
> > 
> 
> Yes, specifically the following two:
> 
>   drivers/input/keyboard/corgikbd.c
>   drivers/input/keyboard/spitzkbd.c
> 
> which I don't feel quite comfortable since they are referencing the PXA
> GPIO registers directly.
> 
> However, marking obsolete might be more smooth for the moment.

Given that there are unused/unsuable after your patch is applied,
removing them from build system is probably good first step.

> >>  static struct platform_device spitzkbd_device = {
> >> -	.name		= "spitz-keyboard",
> >> +	.name		= "matrix-keypad",
> >>  	.id		= -1,
> >> +	.dev		= {
> >> +		.platform_data = &spitzkbd_pdata,
> >> +	},
> >>  };
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
