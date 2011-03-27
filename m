From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in 2.6.37
Date: Sun, 27 Mar 2011 10:09:29 -0700
Message-ID: <20110327170928.GB30244@core.coreip.homeip.net>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com>
 <201103242234.03598.oldium.pro@seznam.cz>
 <4D8CE950020000230002A5DA@novprvlin0050.provo.novell.com>
 <201103252022.26766.oldium.pro@seznam.cz>
 <4D8DB372020000230002A653@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D8DB372020000230002A653@novprvlin0050.provo.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: oldium.pro@seznam.cz, davem@davemloft.net, marcel@holtmann.org, Al Cho <ACho@novell.com>, Gary Lin <GLin@novell.com>, johannes@sipsolutions.net, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Mar 25, 2011 at 04:35:46PM -0600, Joey Lee wrote:
> 
> Thank's for your information, I will look at it.
> 
> Finally,
> I borrow a Acer Aspire one ZG8 from Gary, it can reproduce your
> situation.
> 
> The BAD thing is you are right, 
> I CAN REPRODUCE rfkill-input didn't receive any input, it not make sense
> because rfkill-input registered input handler.
> 
> The BT HW key still works because acer-wmi have polling to sync the
> state with EC and killswitch, and EC also take care the BT device power
> off job.
> 
> But, I also found SOMETIMES after system reboot, rfkill-input can
> capture the key event.
> We need find out why input handle didn't receive KEY_* event.
> 
> 
> Hi, Dmitry 
> 
> Appreciate if you can give us any good suggestions!
> Why keyboard emit KEY_BLUETOOTH, but rfkill-input, registered input
> handler, can't capture it?
> 
> *** 06:32:42.972: lshal: device_condition,
> udi=/org/freedesktop/Hal/devices/platform_i8042_i8042_KBD_port_logicaldev_input
>            condition_name=ButtonPressed
>            condition_details=bluetooth
> 
> But, SOMETIMES after reboot system, rfkill-input can capture the key.
> We are working on 2.6.38 kernel, and Acer notebook.

Hi Joey,

If you look in /proc/bus/input/devices do you see rfkill-input as
actually bound to the device that has KEY_BLUETOOTH?

Since it is atkbd that is emitting KEY_BLUETOOTH and this key is not in
the default keymap I think you must be loading Acer-specific keymap via
udev or some other mechanism, and I guess stumbling upon a deficiency in
input layer: we do not re-match devices after changing keymap. So if
rfkill-input was loaded before keymap was altered, then it will not bind
to the keyboard even if you add KE_BLUETOOTH at a later time. Fixing
this is something that was on my TODO list for a while now...

Thaks.

-- 
Dmitry
