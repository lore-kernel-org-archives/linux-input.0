From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: One USB mouse problem with runtime power management enabled
Date: Thu, 4 Jul 2013 10:55:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1307041038540.21341-100000@netrider.rowland.org>
References: <20130704102224.GA32551@nchen-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:39844 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754032Ab3GDOze (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Jul 2013 10:55:34 -0400
In-Reply-To: <20130704102224.GA32551@nchen-desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Chen <peter.chen@freescale.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Thu, 4 Jul 2013, Peter Chen wrote:

> > I tried doing the same thing on a slightly modified 3.10 kernel.  It 
> > worked okay.  But my mouse was attached to a UHCI controller rather 
> > than EHCI, which may make a difference.
> > 
> > Have you tried running this test with 3.10?
> > 
> 
> Have you opened the mouse by apps (like evtest)?, for USB mouse, 
> the usbhid->intf->needs_remote_wakeup is only set at .open/.close
> API. That means if you have not opened mouse, the runtime pm status
> for mouse will changed to RPM_ACTIVE (choose_wakeup -> pm_runtime_resume)
> If you have opened the mouse, the runtime pm status is RPM_SUSPENDED.

Ah, okay, I will try that.

> > That's right.  The PM core should realize that the usbhid interface 
> > is resumed, so it shouldn't try to suspend the root hub.
> 
> You mean runtime pm core? I find the runtime pm core doesn't know
> the device has already resumed by system resume. For this case,
> the pm_runtime_set_active(dev) has returned -EBUSY at usb_resume,
> (I am still checking why, should be related to parent->power.disable_depth),
> so the usbhid is still RPM_SUSPENDED.

It sounds like this is the real problem.  Under normal conditions, the
runtime PM core won't allow pm_runtime_set_active() to succeed if the
device's parent is suspended.

In your case, the parent was the root hub, right?  So the root hub goes 
back into autosuspend too quickly.

> > The runtime PM status should be correct -- it should indicate that the 
> > device is active after a system resume.
> 
> Then, who should take the responsibility to put the device to autosuspend
> if the device has auto-suspended before the system suspend, we can
> see the ../power/control is still "auto".

This happens automatically, when the PM core calls pm_runtime_put()  
from device_complete() in drivers/base/power/main.c.  This has changed
since 3.5 -- in fact, that's probably the explanation for your problem.  
Back in 3.5, the pm_runtime_put() call was in device_resume() rather
than device_complete().  It was moved in 3.7.

Alan Stern

