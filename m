From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Synaptics touchpad on Dell Vostro V13
Date: Wed, 29 Dec 2010 13:42:40 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1012291341550.16569@pobox.suse.cz>
References: <alpine.LNX.2.00.1012141547570.15140@pobox.suse.cz> <20101214170027.GA11318@core.coreip.homeip.net> <alpine.LNX.2.00.1012152348440.16569@pobox.suse.cz> <201012151523.09476.dmitry.torokhov@gmail.com> <alpine.LNX.2.00.1012281124030.16569@pobox.suse.cz>
 <20101229074410.GC13061@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:49113 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752239Ab0L2Mml (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Dec 2010 07:42:41 -0500
In-Reply-To: <20101229074410.GC13061@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 28 Dec 2010, Dmitry Torokhov wrote:

> > > Hmm, and what happens if you force dfl = 0 in i8042_interrupt()? It looks
> > > like controller FW screwed up...
> > 
> > Yeah, that makes the thing work correctly (together with nomux). This all 
> > is really strange, isn't it? I doubt other OS discards I8042_STR_TIMEOUT 
> > completely :)
> > 
> 
> Looking at the latest bugzilla comment for this laptop it appears
> exactly what custome Dell drivers do ;)

Oh my ...

> Well, another blacklist in i8042 I guess...

Sigh, seems so.

I'll send you patch once I get positive testing feedback.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
