From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: One USB mouse problem with runtime power management enabled
Date: Wed, 3 Jul 2013 12:29:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1307031117410.1241-100000@iolanthe.rowland.org>
References: <20130703024324.GA17349@nchen-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:35001 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754515Ab3GCQ3J (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Jul 2013 12:29:09 -0400
In-Reply-To: <20130703024324.GA17349@nchen-desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Chen <peter.chen@freescale.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Wed, 3 Jul 2013, Peter Chen wrote:

> Hi Jiri and Alan,
> 
> I have run below below at 3.5.7 kernel, but after checking upstream
> kernel, it may also be existed.
> 
> 1. evtest /dev/input/event1 &
> 2. Let mouse auto suspend, enable mouse as wakeup source, and let
> the system enters suspend.
> echo auto > /sys/bus/usb/devices/1-1/power/control
> 
> echo enabled > /sys/bus/platform/devices/2184000.usb/power/wakeup
> echo enabled > /sys/bus/usb/devices/usb1/power/wakeup

You probably don't need this one.  The root hub ought to respond to the 
mouse's wakeup request, even if it isn't enabled for wakeup itself.

> echo enabled > /sys/bus/usb/devices/1-1/power/wakeup
> echo enabled > /sys/bus/platform/devices/ci_hdrc.0/power/wakeup
> 
> sleep 3
> echo mem > /sys/power/state
> 
> 3. Resume system with USB mouse button.
> 
> 4. Console output endless with below message
> hub 1-0:1.0: port 1 nyet suspended
> hub 1-0:1.0: usb_suspend_interface: status -16
> usb usb1: usb_suspend_both: status -16

This looks like the PM core thinks the mouse is runtime suspended when 
it really isn't.

I tried doing the same thing on a slightly modified 3.10 kernel.  It 
worked okay.  But my mouse was attached to a UHCI controller rather 
than EHCI, which may make a difference.

Have you tried running this test with 3.10?

> 5. The reason for above message
> After system goes to suspend, the roothub is RPM_SUSPENDED
> At hub_events it will auto resume roothub, then auto suspend
> roothub after system resumes. When it tries to auto suspend roothub,
> it will print above message. But usbhid interface is resumed 
> by system resume, so its can_submit is 1.

That's right.  The PM core should realize that the usbhid interface 
is resumed, so it shouldn't try to suspend the root hub.

> Unlike the USB Keyboard, the mouse doesn't have any event after system
> resume, so it will not restart OUT/CTRL queues. So the USB mouse will
> not do autoresume and autosuspend.

These things are handled by the USB core, not by the usbhid driver.

> For hid keyboard, it has below message at its usb_hidinput_input_event
> after system resume:
> hid-generic 0003:413C:2105.0002: type:17, code:0, value:0
> hid-generic 0003:413C:2105.0002: type:17, code:1, value:0
> hid-generic 0003:413C:2105.0002: type:17, code:2, value:0
> hid-generic 0003:413C:2105.0002: type:20, code:1, value:33
> hid-generic 0003:413C:2105.0002: type:20, code:0, value:250
> 
> 6. It will not affect evtest, but the USBHID mouse seems will not do
> auto-resume/auto-suspend again even the mouse's button is pressed.
> Then the USBHID has always been active (although it is RPM_SUSPENDED)

It is supposed to be RPM_ACTIVE.  How did it become RPM_SUSPENDED?

> From my point, this problem may need to be fixed:
> 1. At usbhid/input layer:
> Since the usbhid device has auto suspended before system suspend, then,
> it should still auto suspended after system resume.

No; almost all devices get resumed during system resume, even if they
were runtime-suspended beforehand.  If they want to autosuspend later
on, they can.

You can see this in drivers/usb/core/driver.c:usb_resume():

	status = usb_resume_both(udev, msg);
	if (status == 0) {
		pm_runtime_disable(dev);
		pm_runtime_set_active(dev);
		pm_runtime_enable(dev);
		unbind_no_reset_resume_drivers_interfaces(udev);
	}

The pm_runtime_set_active() call tells the PM core that the device is 
RPM_ACTIVE.

> 2. At USB layer:
> It can do auto resume and auto suspend USB device
> after system resume to keep the usb device runtime pm status correct.

The runtime PM status should be correct -- it should indicate that the 
device is active after a system resume.

Alan Stern

