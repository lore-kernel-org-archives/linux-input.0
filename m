From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH][RFC] usbhid: enable autosuspend for internal devices
Date: Sat, 27 Jun 2015 08:29:16 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1506270825010.10183@pobox.suse.cz>
References: <20150626221517.GB2761@kroah.com> <Pine.LNX.4.44L0.1506262113240.31192-100000@netrider.rowland.org> <20150627012959.GA15207@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47033 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751828AbbF0G3T (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Jun 2015 02:29:19 -0400
In-Reply-To: <20150627012959.GA15207@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Tom Gundersen <teg@jklm.no>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 26 Jun 2015, Greg Kroah-Hartman wrote:

> > I thought udev used a whitelist of devices known to work okay with 
> > autosuspend.  Does it really turn on autosuspend for _every_ USB HID 
> > device that is marked as removable?
> 
> Yes, it had a tiny whitelist of 3-4 devices, and then would turn on
> autosuspend for anything not marked as removable or unknown.  Look at
> /usr/lib/udev/rules.d/42-usb-hid-pm.rules on your system for them, it's
> these lines:
> 	ACTION=="add", SUBSYSTEM=="usb", SUBSYSTEMS=="usb", ATTR{../removable}=="removable", GOTO="usb_hid_pm_end"
> 	ACTION=="add", SUBSYSTEM=="usb", SUBSYSTEMS=="usb", ATTR{../removable}=="unknown", GOTO="usb_hid_pm_end"
> 
> > (Come to think of it, given the bug in the hub driver, no device 
> > attached directly to the root hub will _ever_ be marked as removable 
> > AFAICS.  So maybe that bug is masking possible regressions.)
> 
> Maybe that's the issue, don't know, it would be good to figure out as
> upstream udev just deleted that whole rules file :)

Last time we were testing this, autosuspend for USB HID devices was quite 
a disaster.

Do you have any idea whether udev developers tested the "autosuspend on by 
default for USB HID devices" on reasonable set of devices?

The culrpits that I remember from top of my head (it's been long time 
ago):

- the LEDs for suspended device go off. This is very confusing at least on 
  keyboards, and brings really bad user experience

- many keyboards were losing first keystroke when waking up from suspend. 
  We've been debugging this with Alan, and never root-caused it to a 
  problem in our code, it seems to be the property of the HW

I really do want to keep the autosuspend disabled by default on USB HID 
devices (at least keyboards), and enable it based on whitelist. If udev is 
not going to do this any more, I am afraid we'll have to move the default 
into the kernel.

-- 
Jiri Kosina
SUSE Labs
