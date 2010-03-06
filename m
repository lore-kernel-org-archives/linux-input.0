From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Problems with remote-wakeup settings
Date: Sat, 6 Mar 2010 21:54:02 +0100
Message-ID: <201003062154.02199.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1003052316290.10381-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1003052316290.10381-100000@netrider.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-input@vger.kernel.org, linux-hotplug@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Saturday 06 March 2010, Alan Stern wrote:
> On Fri, 5 Mar 2010, Rafael J. Wysocki wrote:
> 
> > > So the problem is that subsystems can't usefully set the can_wakeup 
> > > flag before doing either device_initialize() or device_register().  
> > > This can be fixed easily by removing the call in device_initialize().
> > 
> > PCI depends on the flag being unset when pci_pm_init(dev) is called.
> > 
> > If that's still valid after removing the call in device_initialize(), I'm fine
> > with the removal.
> 
> It should still be valid.  After all, there's nothing else to set the
> flag except for other parts of the PCI core.

All right, then.

> > > Agreed, ethtool and sysfs should affect the same flags.
> > 
> > Yeah, but.  Right now, if the setting is changed via sysfs, it doesn't modify
> > the WoL setting as visible by ethtool.
> 
> > > I don't understand.  Do you mean there's no way to update the
> > > _device's_ WoL setting when the sysfs attribute is changed?
> > 
> > There's no code for that, that's the problem.
> > 
> > > The device's WoL setting matters only at suspend time.  So the network
> > > driver's suspend routine ought to test device_may_wakeup() to see
> > > whether or not WoL should be enabled.  Maybe this can be centralized 
> > > somewhere in the network stack.
> > 
> > Maybe.  The problem is people expect wakeup to work once WoL has been set
> > with the help of ethtool and they expect it to work if the WoL is set by
> > default.
> 
> It's not difficult in theory to tie together the WoL setting and the
> wakeup flag:
> 
> 	If ethtool changes the WoL setting, the driver's ioctl handler
> 	should make the corresponding change to the wakeup flag.
> 
> 	If ethtool queries the WoL setting, the ioctl handler should
> 	check the wakeup flag.  If the flag is off, it should report 
> 	that WoL is disabled; if the flag is on, it should report that 
> 	WoL is enabled.  (The same check should be made in the suspend
> 	routine.)

That's done this way already in all drivers I know, but we need a hook
from wake_store() back to the driver.

> > > And also IMO, enabling WoL by default is very questionable.  But that's 
> > > a separate matter.
> > 
> > That's been a common practice for years in the network adapter land and I don't
> > think we're able to change that now.  Besides, if the WoL is set to g by
> > default, which also is common, that doesn't really lead to any problems.
> 
> All right, we can declare that network drivers are allowed to enable
> WoL by default (like keyboard drivers).  There shouldn't be any problem
> provided they initialize the wakeup setting before registering the
> network interface, so that the initialization doesn't override any 
> action by udev.

That sounds reasonable.

Rafael
