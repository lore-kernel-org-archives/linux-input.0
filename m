From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] linux-input: bcm5974-0.57: mode-switch to atp_open,
 cleanup bug fixed
Date: Wed, 23 Jul 2008 09:38:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0807230934330.22282-100000@netrider.rowland.org>
References: <20080722093606.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:3582 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751400AbYGWNiW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jul 2008 09:38:22 -0400
In-Reply-To: <20080722093606.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, robfitz@273k.net, akpm@osdl.org, Jiri Kosina <jikos@jikos.cz>, vojtech@suse.cz, dmonakhov@openvz.org, johannes@sipsolutions.net, Oliver Neukum <oliver@neukum.org>

On Tue, 22 Jul 2008, Dmitry Torokhov wrote:

> > 4. From the state (!opened,suspended), calling open fails. Where are we?
> >
> 
> Manual suspend will surely cause open to fail. Autosuspend - if
> autoresume fails then (closed, unknown) otherwise (closed,
> autosuspended - autosuspension may not kick in immediately I think).
> 
> > 5. From the state (opened,suspended), calling resume fails. What state
> > are we in?
> > 
> 
> Screwed up ;) From the driver POV still (opened, suspended) I think.

In both of these cases, the final result depends on the reason why the
resume failed.  If it failed for administrative reasons (such as it was
an autoresume and the device had been manually suspended), then the
final state is still suspended.  But if it fails because the kernel
actually tried to resume the device and couldn't do so, then the final
state is that the device is gone, logically disconnected.

Alan Stern

