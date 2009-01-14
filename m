From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 12447] New: usbtouchscreen submits URB too
 quickly if built in to kernel
Date: Wed, 14 Jan 2009 10:28:38 -0800
Message-ID: <20090114102838.3232cec8.akpm@linux-foundation.org>
References: <bug-12447-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <bug-12447-10286-V0hAGp6uBxO456/isadD/XN4h3HLQggn@public.gmane.org/>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, david.hagood-15hjz6xD4c1Wk0Htik3J/w@public.gmane.org
List-Id: linux-input@vger.kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Wed, 14 Jan 2009 08:29:31 -0800 (PST) bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=12447
> 
>            Summary: usbtouchscreen submits URB too quickly if built in to
>                     kernel
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.27
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Input Devices
>         AssignedTo: drivers_input-devices-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
>         ReportedBy: david.hagood-15hjz6xD4c1Wk0Htik3J/w@public.gmane.org
> 
> 
> Latest working kernel version: (unknown)
> Earliest failing kernel version: (unknown)
> Distribution: Debian/x86 (Lenny), Debian/ARM (OMAP, Lenny)
> Hardware Environment: x86, Beagleboard
> Software Environment: Debian Lenny, X
> Problem Description:
> If the usbtouchscreen driver is built in to the kernel and a Microtouch systems
> touchscreen (USB ID 0596:0001) is plugged in, the initialization of the driver
> fails with the following logged:
> 
> usbtouchscreen: usbtouch_irq - usb_submit_urb failed with result: -19           
> usb 1-1.3: new full speed USB device using musb_hdrc and address 11             
> usb 1-1.3: configuration #1 chosen from 1 choice                                
> input: 3M 3M USB Touchscreen - EX II as /class/input/input10
> 
> If the driver is compiled as a module and is not loaded into the kernel, the
> initialization works - dmesg output is:
> 
> usb 1-1.3: new full speed USB device using musb_hdrc and address 12             
> usb 1-1.3: configuration #1 chosen from 1 choice                                
> input: 3M 3M USB Touchscreen - EX II as /class/input/input11                    
> usbcore: registered new interface driver usbtouchscreen
> 
> If the screen is unplugged and plugged in again, the result is the same as if
> the module is built in. If the screen is unplugged, the usbtouchscreen module
> removed, and the screen plugged in, it works.
> 
> I would conjecture that a delay is needed after the insertion to allow the
> hardware to stabilize.
> 
> Steps to reproduce:
> Build the usbtouchscreen driver as a built-in driver.
> Insure touchscreen hardware is NOT plugged in.
> Reboot into new kernel, wait for system up.
> Connect touchscreen hardware.
> 
> Expected results: hardware device found, initialized, /dev/input/event[n]
> created.
> Actual results: Hardware found, URB submission error, no dev entry created.
> 
> Build driver as module.
> Insure touchscreen hardware is NOT plugged in.
> Reboot into new kernel, wait for system up.
> Connect touchscreen hardware.
> 
> Expected results: hardware device found, drivers modprobed, initialized,
> /dev/input/event[n] created.
> Actual results: as expected.
> 
> Remove device, wait 5 seconds, re-connect hardware.
> 
> Expected results: hardware device found, initialized, /dev/input/event[n]
> created.
> Actual results: Hardware found, URB submission error, no dev entry created.
> 
> Remove hardware, rmmod usbtouchscreen driver, reconnect hardware.
> 
> Expected results: hardware device found, drivers modprobed, initialized,
> /dev/input/event[n] created.
> Actual results: as expected.
> 
> NOTE: This happens both on the x86 and the ARM environment.
> 

Is this a USB thing, or an input thing?
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
