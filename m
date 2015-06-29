From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH][RFC] usbhid: enable autosuspend for internal devices
Date: Mon, 29 Jun 2015 13:16:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1506291315360.10183@pobox.suse.cz>
References: <20150626221517.GB2761@kroah.com>  <Pine.LNX.4.44L0.1506262113240.31192-100000@netrider.rowland.org>  <20150627012959.GA15207@kroah.com>  <alpine.LNX.2.00.1506270825010.10183@pobox.suse.cz> <1435571292.1805.4.camel@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435571292.1805.4.camel@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Tom Gundersen <teg@jklm.no>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 29 Jun 2015, Oliver Neukum wrote:

> > Last time we were testing this, autosuspend for USB HID devices was quite 
> > a disaster.
> > 
> > Do you have any idea whether udev developers tested the "autosuspend on by 
> > default for USB HID devices" on reasonable set of devices?
> > 
> > The culrpits that I remember from top of my head (it's been long time 
> > ago):
> > 
> > - the LEDs for suspended device go off. This is very confusing at least on 
> >   keyboards, and brings really bad user experience
> 
> That is a bug. hidinput_count_leds() is supposed to prevent that.

This is a HW property and nothing kernel can do about. I am not saying it 
doesn't bring the LEDs up to a proper state again once auto-resumed. But I 
hate the LEDs going off a few seconds after I stop typing (i.e. once the 
keyboard gets auto-suspended).

-- 
Jiri Kosina
SUSE Labs
