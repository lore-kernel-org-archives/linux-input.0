From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [linux-pm] [PATCH v2 1/2] Input: gpio-keys - allow platform to
	specify exact irq flags
Date: Mon, 30 Nov 2009 01:16:56 -0800
Message-ID: <20091130091656.GF10295@core.coreip.homeip.net>
References: <87skbx34ba.fsf@tac.ki.iif.hu> <Pine.LNX.4.44L0.0911291103070.3165-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:40198 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbZK3JQy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2009 04:16:54 -0500
Received: by pzk1 with SMTP id 1so2377336pzk.33
        for <linux-input@vger.kernel.org>; Mon, 30 Nov 2009 01:17:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0911291103070.3165-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ferenc Wagner <wferi@niif.hu>, linux-pm@lists.linux-foundation.org, Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sun, Nov 29, 2009 at 11:04:57AM -0500, Alan Stern wrote:
> On Sun, 29 Nov 2009, Ferenc Wagner wrote:
> 
> > Hi,
> > 
> > I thought we'd better ask our friends over at linux-pm, if they've got
> > some interface for this task.  To summarize: an embedded application
> > wants to go into a "locked" state, where some input devices (gpio keys
> > in this case) are "muted", ie. they don't even generate interrupts to
> > minimize power consumption.  This could be solved by adding a new
> > interface to gpio-keys, but the problem seems more general, so I wonder
> > if something like the USB selective runtime suspend is already available
> > (or preferable to develop) for such tasks.
> > 
> > (I hope I got the summary right; Mika will provide the missing bits if I
> > didn't.) 
> 
> See Documentation/power/runtime_pm.txt.  I don't know to what extent 
> the input layer has implemented any runtime PM.

Input layer is not implementing any PM since it consists of virtual, not
physical devices, and leaves PM for the appropriate bus drivers (USB,
serio, platform, etc.).

Also, it is not really runtime PM but rather user-initiated action of
putting device into lower poer state we are talking about here.

-- 
Dmitry
