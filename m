From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [rft]power management for usbtouch
Date: Tue, 1 Jul 2008 11:00:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0807011058340.2780-100000@iolanthe.rowland.org>
References: <20080701085504.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:59542 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754925AbYGAPAM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Jul 2008 11:00:12 -0400
In-Reply-To: <20080701085504.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Oliver Neukum <oliver@neukum.org>, Jiri Kosina <jkosina@suse.cz>, Ville Syrj?l? <syrjala@sci.fi>, daniel.ritz@gmx.ch, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Tue, 1 Jul 2008, Dmitry Torokhov wrote:

> > The user has decided to put the device in a state in which the driver
> > cannot properly function. If the user wanted the driver to work, he should
> > select autosuspend.
> >
> 
> That is the thing with the forced suspend - it leaves device out of
> sync with the rest of the system. If user really does not want to use
> the device it should probably be completely disconnected?

Some devices are rather difficult to disconnect (the cabling may be 
inaccessible).

Also, devices can be suspended by software, but generally speaking they 
cannot be disconnected by software.

Alan Stern

