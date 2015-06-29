From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH][RFC] usbhid: enable autosuspend for internal devices
Date: Mon, 29 Jun 2015 13:37:19 +0200
Message-ID: <1435577839.1805.10.camel@suse.de>
References: <20150626221517.GB2761@kroah.com>
	  <Pine.LNX.4.44L0.1506262113240.31192-100000@netrider.rowland.org>
	  <20150627012959.GA15207@kroah.com>
	  <alpine.LNX.2.00.1506270825010.10183@pobox.suse.cz>
	 <1435571292.1805.4.camel@suse.com>
	 <alpine.LNX.2.00.1506291315360.10183@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48165 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627AbbF2LiU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jun 2015 07:38:20 -0400
In-Reply-To: <alpine.LNX.2.00.1506291315360.10183@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Tom Gundersen <teg@jklm.no>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Mon, 2015-06-29 at 13:16 +0200, Jiri Kosina wrote:
> On Mon, 29 Jun 2015, Oliver Neukum wrote:
> 
> > > Last time we were testing this, autosuspend for USB HID devices was quite 
> > > a disaster.
> > > 
> > > Do you have any idea whether udev developers tested the "autosuspend on by 
> > > default for USB HID devices" on reasonable set of devices?
> > > 
> > > The culrpits that I remember from top of my head (it's been long time 
> > > ago):
> > > 
> > > - the LEDs for suspended device go off. This is very confusing at least on 
> > >   keyboards, and brings really bad user experience
> > 
> > That is a bug. hidinput_count_leds() is supposed to prevent that.
> 
> This is a HW property and nothing kernel can do about. I am not saying it 
> doesn't bring the LEDs up to a proper state again once auto-resumed. But I 
> hate the LEDs going off a few seconds after I stop typing (i.e. once the 
> keyboard gets auto-suspended).

That is the point. Unless you give the option to override, they
shouldn't autosuspend.

	Regards
		Oliver



