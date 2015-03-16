From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: Fun with sony motion controllers: navigation controller
Date: Mon, 16 Mar 2015 11:26:32 -0400
Message-ID: <5506F628.1050901@gmail.com>
References: <20150314191917.GA3680@amd> <alpine.LNX.2.00.1503161354310.25438@pobox.suse.cz> <20150316130547.GA20976@amd> <alpine.LNX.2.00.1503161453010.25438@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1503161453010.25438@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Pavel Machek <pavel@ucw.cz>
Cc: vojtech@suse.cz, mike-@cinci.rr.com, jslaby@suse.cz, dave@thedillows.org, colin.leitner@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 3/16/2015 09:55, Jiri Kosina wrote:
> On Mon, 16 Mar 2015, Pavel Machek wrote:
>
>> On Mon 2015-03-16 13:55:39, Jiri Kosina wrote:
>>> On Sat, 14 Mar 2015, Pavel Machek wrote:
>>>
>>>> Hi!
>>>>
>>>> After oopsing kernel with ps/3 peripherals, I decided to play some
>>>> more.
>>>>
>>>> First "sony motion controller" (part of ps/3 move without the
>>>> led). Good news is that it no longer oopses. After pressing the PS
>>>> button, it seems to work, but it produces endless stream of events in
>>>> evtest:
>>>>
>>>> Event: time 1426360519.967818, type 3 (EV_ABS), code 0 (ABS_X), value 131
>>>> Event: time 1426360519.967818, type 3 (EV_ABS), code 1 (ABS_Y), value 129
>>>> Event: time 1426360519.967818, type 3 (EV_ABS), code 59 (ABS_MT_DISTANCE), value 513
>>>> Event: time 1426360519.967818, type 3 (EV_ABS), code 60 (ABS_MT_TOOL_X), value 513
>>>>
>>>> Should it really produce multitouch events?
>>> Some sony devices are producing multitouch events. You unfortunately
>>> didn't send us the VID/PID of the device you are playing with.
>> Umm. I thought multitouch events are for touchscreen. This is joystick
>> with accelerometer...?
> Ok, that's USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER, which should get
> SIXAXIS_CONTROLLER_USB. That one shouldn't really be producing multitouch
> events.
>
> Could you please add printk()s to hid-sony.c to see how it's possible that
> it's generating those?
>
> I am sure Frank will comment on this as well.
>

The Dualshock 3 is a special case in that every button except for start, 
select and the PS button are both digital and analog.  As such, the 
controller reports 27 axes that end up spilling over into the ABS_MT 
values.  This mapping comes from the default HID descriptor from the 
device, so it's been this way from day 1.  If the navigation controller 
is basically the same as a DS3 then it will have the same issues.

To note, the DS3 only has 20 actual, physical axes meaning that 7 of the 
reported axes don't even do anything and I'm not sure why they are 
there.  The HID descriptor could be rewritten to map everything in a 
more correct manner, but that would break the mapping that has been 
there for 8 or 9 years at this point and probably break some user-space 
applications in the process.
