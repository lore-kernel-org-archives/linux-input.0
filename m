From: Peter Chen <peter.chen@freescale.com>
Subject: Re: One USB mouse problem with runtime power management enabled
Date: Thu, 4 Jul 2013 18:22:25 +0800
Message-ID: <20130704102224.GA32551@nchen-desktop>
References: <20130703024324.GA17349@nchen-desktop>
 <Pine.LNX.4.44L0.1307031117410.1241-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:58058
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751622Ab3GDKWl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 4 Jul 2013 06:22:41 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1307031117410.1241-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Wed, Jul 03, 2013 at 12:29:08PM -0400, Alan Stern wrote:
> On Wed, 3 Jul 2013, Peter Chen wrote:
> 
> > Hi Jiri and Alan,
> > 
> > I have run below below at 3.5.7 kernel, but after checking upstream
> > kernel, it may also be existed.
> > 
> > 1. evtest /dev/input/event1 &
> > 2. Let mouse auto suspend, enable mouse as wakeup source, and let
> > the system enters suspend.
> > echo auto > /sys/bus/usb/devices/1-1/power/control
> > 
> > echo enabled > /sys/bus/platform/devices/2184000.usb/power/wakeup
> > echo enabled > /sys/bus/usb/devices/usb1/power/wakeup
> 
> You probably don't need this one.  The root hub ought to respond to the 
> mouse's wakeup request, even if it isn't enabled for wakeup itself.
> 

Yes, it doesn't need for remote wakeup, but it is needed for
WKCN/WKDN(wakeup on connect/disconnect), my script need to take
all usb wakeup into account.

> > echo enabled > /sys/bus/usb/devices/1-1/power/wakeup
> > echo enabled > /sys/bus/platform/devices/ci_hdrc.0/power/wakeup
> > 
> > sleep 3
> > echo mem > /sys/power/state
> > 
> > 3. Resume system with USB mouse button.
> > 
> > 4. Console output endless with below message
> > hub 1-0:1.0: port 1 nyet suspended
> > hub 1-0:1.0: usb_suspend_interface: status -16
> > usb usb1: usb_suspend_both: status -16
> 
> This looks like the PM core thinks the mouse is runtime suspended when 
> it really isn't.
> 
> I tried doing the same thing on a slightly modified 3.10 kernel.  It 
> worked okay.  But my mouse was attached to a UHCI controller rather 
> than EHCI, which may make a difference.
> 
> Have you tried running this test with 3.10?
> 

Have you opened the mouse by apps (like evtest)?, for USB mouse, 
the usbhid->intf->needs_remote_wakeup is only set at .open/.close
API. That means if you have not opened mouse, the runtime pm status
for mouse will changed to RPM_ACTIVE (choose_wakeup -> pm_runtime_resume)
If you have opened the mouse, the runtime pm status is RPM_SUSPENDED.

> > 5. The reason for above message
> > After system goes to suspend, the roothub is RPM_SUSPENDED
> > At hub_events it will auto resume roothub, then auto suspend
> > roothub after system resumes. When it tries to auto suspend roothub,
> > it will print above message. But usbhid interface is resumed 
> > by system resume, so its can_submit is 1.
> 
> That's right.  The PM core should realize that the usbhid interface 
> is resumed, so it shouldn't try to suspend the root hub.

You mean runtime pm core? I find the runtime pm core doesn't know
the device has already resumed by system resume. For this case,
the pm_runtime_set_active(dev) has returned -EBUSY at usb_resume,
(I am still checking why, should be related to parent->power.disable_depth),
so the usbhid is still RPM_SUSPENDED.

> > 
> > 6. It will not affect evtest, but the USBHID mouse seems will not do
> > auto-resume/auto-suspend again even the mouse's button is pressed.
> > Then the USBHID has always been active (although it is RPM_SUSPENDED)
> 
> It is supposed to be RPM_ACTIVE.  How did it become RPM_SUSPENDED?

Yes, the same with above, it needs to check why 
pm_runtime_set_active(dev) has returned -EBUSY.

> 
> > From my point, this problem may need to be fixed:
> > 1. At usbhid/input layer:
> > Since the usbhid device has auto suspended before system suspend, then,
> > it should still auto suspended after system resume.
> 
> No; almost all devices get resumed during system resume, even if they
> were runtime-suspended beforehand.  If they want to autosuspend later
> on, they can.
> 
> You can see this in drivers/usb/core/driver.c:usb_resume():
> 
> 	status = usb_resume_both(udev, msg);
> 	if (status == 0) {
> 		pm_runtime_disable(dev);
> 		pm_runtime_set_active(dev);
> 		pm_runtime_enable(dev);
> 		unbind_no_reset_resume_drivers_interfaces(udev);
> 	}
> 
> The pm_runtime_set_active() call tells the PM core that the device is 
> RPM_ACTIVE.
> 
> > 2. At USB layer:
> > It can do auto resume and auto suspend USB device
> > after system resume to keep the usb device runtime pm status correct.
> 
> The runtime PM status should be correct -- it should indicate that the 
> device is active after a system resume.

Then, who should take the responsibility to put the device to autosuspend
if the device has auto-suspended before the system suspend, we can
see the ../power/control is still "auto".

Thanks.

-- 

Best Regards,
Peter Chen

