From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [regression] 2.6.30 leaking keys on console switch
Date: Thu, 15 Oct 2009 21:59:24 -0700
Message-ID: <20091016045924.GD11582@core.coreip.homeip.net>
References: <87eiss7uhb.fsf@basil.nowhere.org> <alpine.LNX.2.00.0907071048210.4994@wotan.suse.de> <20090708065325.GE3309@dtor-d630.eng.vmware.com> <alpine.LNX.2.00.0907091319480.27327@wotan.suse.de> <20090713040528.GH10819@dtor-d630.eng.vmware.com> <alpine.LNX.2.00.0907130906140.10476@wotan.suse.de> <20090713082527.GA26638@basil.fritz.box> <alpine.LNX.2.00.0907161057120.11648@wotan.suse.de> <20090716092406.GC8046@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:43570 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbZJPFAH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Oct 2009 01:00:07 -0400
Content-Disposition: inline
In-Reply-To: <20090716092406.GC8046@one.firstfloor.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Jiri Kosina <jkosina@suse.cz>, rjw@sisk.pl, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>

On Thu, Jul 16, 2009 at 11:24:06AM +0200, Andi Kleen wrote:
> > Andi, are you absolutely sure that this appeared between .29 and .30 for 
> > you?
> 
> I only noticed it after the .30 update at least.
> 
> > And if so, is there any chance you could try bisecting it?
> 
> Ok.
> 
> > 
> > (*) have been on virtual desktop where firefox was running, switched to 
> > console using Ctrl-Alt-F1, and switched back to X using F7. Firefox then 
> > popped up some dialog about configuring some feature that is triggered by 
> > pressing F7/AltF7, or whatever. Is that what you are seeing?
> 
> Yes, I typically see it with the help screen. It also happens with
> other applications, not just firefox.
> 

I don't really see the issue here, except for maybe X being stupid - it
seems that it processes release events as press+release in cases when it
did not see the press event.

Start up xev, switch to text console and then back to X (don't release
the CTRL+ALT+Fx combo). Let X switch fully and then release the combo.
Observe the 2 events reported by xev for Fx key. You may try running
evtest in other window and observe that there are no down events at the
time of 2 xev events, only autorepeats and release event (and
autorepeats are ignored by X who does it's own software autorepeat).

-- 
Dmitry
