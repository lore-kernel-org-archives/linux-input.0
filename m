From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: [PATCH 001/001] hid-sony.c: add sysfs provisioning
Date: Mon, 17 Nov 2014 22:21:53 -0500
Message-ID: <546ABB51.4010905@gmail.com>
References: <20141116181846.GA31516@abrij.org> <20141117133518.ee306b3b35a0e0566a255b14@ao2.it> <546A4EF7.903@gmail.com> <20141118000005.GA32256@abrij.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141118000005.GA32256@abrij.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bri <bri@abrij.org>
Cc: Antonio Ospite <ao2@ao2.it>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, open@abrij.org, HID CORE LAYER <linux-input@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi Brian,

On 11/17/2014 19:00, bri wrote:
>
>> Yeah, the device ID in the driver is only for tracking devices internally
>> and setting sane default LED values.  It has no meaning outside of the
>> module.  Like Antonio said, if you want the system number for a controller
>> you are better off just getting it from the joystick device.
> Would you be amenable to a patch that removes the IDA entirely and just sets
> the LEDs to all solid-on?  Since the LEDs are available through sysfs,
> udev rule could probably be made to set the LEDs in the absence of bluez
> or a higher level controller manager, and then it becomes the distro's
> responsibility.
>

What would be the benefit of doing this?  Nothing is stopping higher 
level services from setting the LEDs right now.  The driver just sets 
sane defaults for systems that don't have anything else to set the 
'real' values.  Other controllers like Wiimotes and Xbox gamepads do the 
same thing.  It doesn't get in the way of services like BlueZ setting 
them once initialization is complete.

Leaving it completely up to the distro just means that there will be 
situations where there is nothing to set the default values which makes 
for a bad user experience.
