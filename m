From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [linux-pm] wacom + runtime PM = AA deadlock
Date: Tue, 14 Sep 2010 17:30:38 +0200
Message-ID: <201009141730.38215.oneukum@suse.de>
References: <Pine.LNX.4.44L0.1009141119340.1648-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42156 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327Ab0INPaH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Sep 2010 11:30:07 -0400
In-Reply-To: <Pine.LNX.4.44L0.1009141119340.1648-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Slaby <jslaby@suse.cz>, Dmitry Torokhov <dtor@mail.ru>, pingc@wacom.com, linux-pm <linux-pm@lists.linux-foundation.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

Am Dienstag, 14. September 2010, 17:23:15 schrieb Alan Stern:
> On Tue, 14 Sep 2010, Oliver Neukum wrote:
> 
> > > > Should I have used usb_autopm_get_interface_no_resume()?
> > > 
> > > That actually would work.  It's a good idea.  The only drawback (not a
> > > big one) is that if the device _was_ suspended with remote wakeup
> > > enabled, doing this wouldn't turn off remote wakeup.  I think that
> > > doesn't matter.
> > 
> > I am afraid it does matter as devices whose remote wakeup is enabled
> > may draw more power.
> 
> I doubt it, or at least, not very much more.  They are still limited by 
> the USB spec as to the total amount of current they can draw while 
> suspended.

7.2.3 Sources of remote wakeup may draw 2.5mA when suspended
as opposed to 0.5 mA

	Regards
		Oliver
