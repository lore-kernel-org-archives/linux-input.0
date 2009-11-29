From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH v2 1/2] Input: gpio-keys - allow platform to
 specify exact irq flags
Date: Sun, 29 Nov 2009 11:04:57 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911291103070.3165-100000@netrider.rowland.org>
References: <87skbx34ba.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:49419 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751922AbZK2QEv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Nov 2009 11:04:51 -0500
In-Reply-To: <87skbx34ba.fsf@tac.ki.iif.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: linux-pm@lists.linux-foundation.org, Mika Westerberg <mika.westerberg@iki.fi>, ext Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sun, 29 Nov 2009, Ferenc Wagner wrote:

> Hi,
> 
> I thought we'd better ask our friends over at linux-pm, if they've got
> some interface for this task.  To summarize: an embedded application
> wants to go into a "locked" state, where some input devices (gpio keys
> in this case) are "muted", ie. they don't even generate interrupts to
> minimize power consumption.  This could be solved by adding a new
> interface to gpio-keys, but the problem seems more general, so I wonder
> if something like the USB selective runtime suspend is already available
> (or preferable to develop) for such tasks.
> 
> (I hope I got the summary right; Mika will provide the missing bits if I
> didn't.) 

See Documentation/power/runtime_pm.txt.  I don't know to what extent 
the input layer has implemented any runtime PM.

Alan Stern

