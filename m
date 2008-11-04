From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: cleanup of hiddev
Date: Tue, 4 Nov 2008 10:00:06 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0811040959040.2642-100000@iolanthe.rowland.org>
References: <200811041519.52565.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:56651 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756537AbYKDPAI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Nov 2008 10:00:08 -0500
In-Reply-To: <200811041519.52565.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, Jiri Kosina <jikos@jikos.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Tue, 4 Nov 2008, Oliver Neukum wrote:

> Am Montag, 3. November 2008 20:58:11 schrieb Jiri Slaby:
> > Hi.
> > 
> > > this is the cleanup of hiddev against current vanilla. What do you think?
> > 
> > See my comments below.
> 
> Hi,
> 
> there still is a race of disconnect() with ioctl(). It seems like that
> code still operates under the assumption that both methods take
> BKL. Do you prefer a conservative fix with selective application of BKL
> or introduction of a new mutex?

It's none of my business... but IMO we should try to move away from the 
BKL as much as possible.

Alan Stern

