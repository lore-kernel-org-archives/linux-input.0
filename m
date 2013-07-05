From: Chen Peter-B29397 <B29397@freescale.com>
Subject: RE: One USB mouse problem with runtime power management enabled
Date: Fri, 5 Jul 2013 06:46:34 +0000
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803F04D9C@039-SN2MPN1-023.039d.mgd.msft.net>
References: <20130704102224.GA32551@nchen-desktop>
 <Pine.LNX.4.44L0.1307041038540.21341-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:34096 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751497Ab3GEGqi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 5 Jul 2013 02:46:38 -0400
In-Reply-To: <Pine.LNX.4.44L0.1307041038540.21341-100000@netrider.rowland.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Kosina <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

 
> >
> > Have you opened the mouse by apps (like evtest)?, for USB mouse,
> > the usbhid->intf->needs_remote_wakeup is only set at .open/.close
> > API. That means if you have not opened mouse, the runtime pm status
> > for mouse will changed to RPM_ACTIVE (choose_wakeup ->
> pm_runtime_resume)
> > If you have opened the mouse, the runtime pm status is RPM_SUSPENDED.
> 
> Ah, okay, I will try that.
> 
> > > That's right.  The PM core should realize that the usbhid interface
> > > is resumed, so it shouldn't try to suspend the root hub.
> >
> > You mean runtime pm core? I find the runtime pm core doesn't know
> > the device has already resumed by system resume. For this case,
> > the pm_runtime_set_active(dev) has returned -EBUSY at usb_resume,
> > (I am still checking why, should be related to parent-
> >power.disable_depth),
> > so the usbhid is still RPM_SUSPENDED.
> 
> It sounds like this is the real problem.  Under normal conditions, the
> runtime PM core won't allow pm_runtime_set_active() to succeed if the
> device's parent is suspended.
> 
> In your case, the parent was the root hub, right?  So the root hub goes
> back into autosuspend too quickly.
> 
> > > The runtime PM status should be correct -- it should indicate that
> the
> > > device is active after a system resume.
> >
> > Then, who should take the responsibility to put the device to
> autosuspend
> > if the device has auto-suspended before the system suspend, we can
> > see the ../power/control is still "auto".
> 
> This happens automatically, when the PM core calls pm_runtime_put()
> from device_complete() in drivers/base/power/main.c.  This has changed
> since 3.5 -- in fact, that's probably the explanation for your problem.
> Back in 3.5, the pm_runtime_put() call was in device_resume() rather
> than device_complete().  It was moved in 3.7.
> 
 
It works after cherry-pick yours [1] and Ulf Hansson's patch [2] (only your patch should
also work), besides, it needs to set controller active after system resume, or the
child (roothub) can't set itself as active.

( [1]PM: Prevent runtime suspend during system resume
[2] PM / Runtime: Asyncronous idle|suspend devices at system resume)


Thanks,
Peter

