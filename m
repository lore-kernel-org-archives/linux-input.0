From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] wacom + runtime PM = AA deadlock
Date: Tue, 14 Sep 2010 11:23:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009141119340.1648-100000@iolanthe.rowland.org>
References: <201009141603.59338.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201009141603.59338.oneukum@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Jiri Slaby <jslaby@suse.cz>, Dmitry Torokhov <dtor@mail.ru>, pingc@wacom.com, linux-pm <linux-pm@lists.linux-foundation.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 14 Sep 2010, Oliver Neukum wrote:

> > > Should I have used usb_autopm_get_interface_no_resume()?
> > 
> > That actually would work.  It's a good idea.  The only drawback (not a
> > big one) is that if the device _was_ suspended with remote wakeup
> > enabled, doing this wouldn't turn off remote wakeup.  I think that
> > doesn't matter.
> 
> I am afraid it does matter as devices whose remote wakeup is enabled
> may draw more power.

I doubt it, or at least, not very much more.  They are still limited by 
the USB spec as to the total amount of current they can draw while 
suspended.

Alan Stern
