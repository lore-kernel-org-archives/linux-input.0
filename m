From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: remove unused omap4-keypad file and code
Date: Thu, 29 May 2014 00:33:07 -0700
Message-ID: <20140529073307.GL11817@core.coreip.homeip.net>
References: <1400361851-32274-1-git-send-email-manabian@gmail.com>
 <1400361851-32274-2-git-send-email-manabian@gmail.com>
 <20140519053710.GD29386@core.coreip.homeip.net>
 <20140519161814.GE4849@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:45833 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbaE2HdK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 May 2014 03:33:10 -0400
Content-Disposition: inline
In-Reply-To: <20140519161814.GE4849@atomide.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Joachim Eastwood <manabian@gmail.com>, illia.smyrnov@ti.com, linux-omap@vger.kernel.org, linux-input@vger.kernel.org

On Mon, May 19, 2014 at 09:18:15AM -0700, Tony Lindgren wrote:
> * Dmitry Torokhov <dmitry.torokhov@gmail.com> [140518 22:38]:
> > On Sat, May 17, 2014 at 11:24:10PM +0200, Joachim Eastwood wrote:
> > > This has been unused since omap4 board files went away.
> > > 
> > > Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> > 
> > Tony, can I merge both through my tree?
> 
> Yes I don't have anything touching the omap4_keyboard_init
> areas that I can think of:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
>  

Applied both, thank you.

-- 
Dmitry
