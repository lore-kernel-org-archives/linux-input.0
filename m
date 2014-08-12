From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Retire gamecon?
Date: Tue, 12 Aug 2014 13:28:45 -0700
Message-ID: <20140812202845.GA21474@core.coreip.homeip.net>
References: <20140812170722.GC5563@core.coreip.homeip.net>
 <alpine.LNX.2.00.1408122212340.15220@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:46394 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754734AbaHLU2s (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Aug 2014 16:28:48 -0400
Received: by mail-pa0-f46.google.com with SMTP id lj1so13525091pab.5
        for <linux-input@vger.kernel.org>; Tue, 12 Aug 2014 13:28:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1408122212340.15220@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>

On Tue, Aug 12, 2014 at 10:17:42PM +0200, Jiri Kosina wrote:
> On Tue, 12 Aug 2014, Dmitry Torokhov wrote:
> 
> > I am wondering it it is time to retire gamecon support from the kernel. 
> 
> Absolutely no objections from me on this, but I guess Vojtech's opinion is 
> much more relevant here, as he has actually *seen* this hardware (I 
> guess) :)
> 
> > It hasn't been working well ever since cpufreq became mainstream and it 
> > becomes increasingly hard to find hardware and software that would run 
> > on such old hardware.
> 
> Makes me wonder though what makes gamecon so special among other drivers 
> of such kind (such as JOYSTICK_DB9, to name one randomly picked example).

Sorry, I actually meant gameport, not gamecon. I obviously did not have enough
coffee when I sent out that message.

Thanks.

-- 
Dmitry
