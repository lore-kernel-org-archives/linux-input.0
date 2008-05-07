From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch]full autosuspend for USB HID
Date: Wed, 7 May 2008 11:57:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0805071156300.2174-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.64.0805071747210.11363@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:59796 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757109AbYEGP5Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 May 2008 11:57:16 -0400
In-Reply-To: <Pine.LNX.4.64.0805071747210.11363@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Oliver Neukum <oliver@neukum.org>, USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Wed, 7 May 2008, Jiri Kosina wrote:

> On Wed, 7 May 2008, Alan Stern wrote:
> 
> > One big problem we always faced with autosuspend for keyboards is that 
> > most of them were not able to autoresume quickly enough to avoid losing 
> > keystrokes.  Isn't that still a problem?
> 
> Hi Alan,
> 
> it definitely is, but with autosuspend defaulting to off, and possibility 
> of whitelisting known-good keyboards, we (or HAL, respectively) can still 
> turn autosupend on those that are known to work properly, and still save 
> some power on some systems.
> 
> Unfortunately, I vaguely remember that some keyboards exposed the 
> behaviors only when connected to certain HCI controllers, so building the 
> whitelist might not be completely trivial.

Can we find out what Windows and OS-X do and copy them?

Alan Stern

