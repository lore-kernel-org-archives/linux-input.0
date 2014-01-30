From: Stephan Mueller <smueller@chronox.de>
Subject: Re: Sony Vaio Duo 11: getting middle mouse button to work
Date: Thu, 30 Jan 2014 04:48:16 +0100
Message-ID: <2981174.bDZe6OjLCj@myon.chronox.de>
References: <1674012.xCMptsh8XR@myon.chronox.de> <3981247.bRK36pG72j@tauon> <CAN+gG=EOqfyOid8bDYH5GYCsOOqYysuUdusg5XOh6LtUMShd_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CAN+gG=EOqfyOid8bDYH5GYCsOOqYysuUdusg5XOh6LtUMShd_g@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Mattia Dongili <malattia@linux.it>, platform-driver-x86@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Am Mittwoch, 29. Januar 2014, 10:07:40 schrieb Benjamin Tissoires:

Hi Benjamin,

> On Wed, Jan 29, 2014 at 9:59 AM, Stephan Mueller <smueller@chronox.de> 
wrote:
> > Am Mittwoch, 29. Januar 2014, 09:53:03 schrieb Benjamin Tissoires:
> > 
> > Hi Benjamin,
> > 
> >>On Fri, Jan 24, 2014 at 11:51 PM, Stephan Mueller <smueller@chronox.de>
> >>
> > wrote:
> >>> Am Samstag, 25. Januar 2014, 12:17:13 schrieb Mattia Dongili:
> >>> 
> >>> Hi Mattia,
> >>> 
> >>>> I'd try with the input subsystem and the synaptics_usb driver first
> >>>> but it's just a wild guess. Your kernel log should give you more
> >>>> hints about which driver is bound to the device and the sysfs tree
> >>>> under
> >>>> /sys/class/input/event*/device/* has all the capabilities and
> >>>> identifiers.
> >>> 
> >>> The following did not help:
> >>> 
> >>> modprobe synaptics_usb
> >>> cd /sys/bus/usb/drivers/usbhid
> >>> echo -n "1-1.3:1.0" > unbind
> >>> #now the mouse is without driver, does not move, and
> >>> #/sys/class/input/event2/device/device is without driver
> >>> cd /sys/bus/usb/drivers/synaptics_usb
> >>> echo -n "1-1.3:1.0" > bind
> >>> #error: no such device, mouse does not work, nothing in dmesg
> >>> cd /sys/bus/usb/drivers/usbhid
> >>> echo -n "1-1.3:1.0" > bind
> >>> #mouse works again without middle button
> >>
> >>Hi Stephan,
> >>
> >>in this case, you definitively want to talk to HID (and input) folks.
> >>Adding Jiri, the HID maintainer in the discussion.
> >>
> >>Your mouse does not seem to be handled properly by the hid subsystem
> >>and needs quirks, or fix.
> >>
> >>Can you send us some hid-recorder[1] traces of your device? We should
> >>then be able to check what's wrong and hopefully fix the problem.
> >>
> > Thanks a lot for the helping hand. I will try your suggestion tonight
> > and report back.
> > 
> > But please allow me to point out that I have doubts that HID or input is
> > at fault, because when sniffing on the USB bus with usbmon, I do *not*
> > see any information transported when pressing the middle button.
> > Therefore, I would suspect it is rather the base USB driver that somehow
> > needs a quirk to access the mouse properly.
> 
> Oh, then in this case it may be that your device needs to be put in a
> special mode, and the report descriptors will show us some hints on
> how to do it (maybe).
> I strongly doubt that USB is in fault here. I can not see any reasons
> why the USB or underlying driver would select which packets are
> transmitted.
> 
> What you can also do is setup a windows virtual machine, assign the
> usb device to it, and sniff through usbmon or wireshark what packets
> are emitted from/to the mouse. Then, we will duplicate this behavior
> in the hid driver, and you would be good to go. Still, having the
> reports descriptors (which are provided by hid-recorder, or in
> /sys/kernel/debug/hid/DEVICE/rdesc, or in lsusb -vv when the usbhid
> driver is not bound) would help us to understand the mouse firmware.
> 
> Cheers,
> Benjamin

The device is 26E1:C1A0; when doing a cat 
/sys/kernel/debug/hid/0003\:26E1\:C1A0.0003/events, I see the mouse movements 
and the left and right mouse button, but not the middle one.

# cat /sys/kernel/debug/hid/0003\:26E1\:C1A0.0003/rdesc 
05 01 09 02 a1 01 85 01 09 01 a1 00 05 09 19 01 29 03 15 00 25 01 75 01 95 03 
81 02 95 05 81 01 05 01 15 81 25 7f 75 08 95 03 09 30 09 31 09 38 81 06 c0 c0 
06 a0 ff 09 01 a1 01 85 02 09 02 a1 00 06 a1 ff 09 01 15 80 25 7f 35 00 45 ff 
75 08 95 04 81 02 09 11 15 80 25 7f 35 00 45 ff 75 08 95 04 91 02 c0 c0 

  INPUT(1)[INPUT]
    Field(0)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Mouse)
      Usage(3)
        Button.0001
        Button.0002
        Button.0003
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(1)
      Report Count(3)
      Report Offset(0)
      Flags( Variable Absolute )
    Field(1)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Mouse)
      Usage(3)
        GenericDesktop.X
        GenericDesktop.Y
        GenericDesktop.Wheel
      Logical Minimum(-127)
      Logical Maximum(127)
      Report Size(8)
      Report Count(3)
      Report Offset(8)
      Flags( Variable Relative )
  INPUT(2)[INPUT]
    Field(0)
      Physical(ffa0.0002)
      Application(ffa0.0001)
      Usage(4)
        ffa1.0001
        ffa1.0001
        ffa1.0001
        ffa1.0001
      Logical Minimum(-128)
      Logical Maximum(127)
      Physical Minimum(0)
      Physical Maximum(255)
      Report Size(8)
      Report Count(4)
      Report Offset(0)
      Flags( Variable Absolute )
  OUTPUT(2)[OUTPUT]
    Field(0)
      Physical(ffa0.0002)
      Application(ffa0.0001)
      Usage(4)
        ffa1.0011
        ffa1.0011
        ffa1.0011
        ffa1.0011
      Logical Minimum(-128)
      Logical Maximum(127)
      Physical Minimum(0)
      Physical Maximum(255)
      Report Size(8)
      Report Count(4)
      Report Offset(0)
      Flags( Variable Absolute )

Button.0001 ---> Key.LeftBtn
Button.0002 ---> Key.RightBtn
Button.0003 ---> Key.MiddleBtn
GenericDesktop.X ---> Relative.X
GenericDesktop.Y ---> Relative.Y
GenericDesktop.Wheel ---> Relative.Wheel
ffa1.0001 ---> Absolute.Misc
ffa1.0001 ---> Absolute.?
ffa1.0001 ---> Absolute.?
ffa1.0001 ---> Absolute.?
ffa1.0011 ---> Sync.Report
ffa1.0011 ---> Sync.Report
ffa1.0011 ---> Sync.Report
ffa1.0011 ---> Sync.Report

Here is the hid-recorder output -- the mouse clicks are at the bottom. The 
middle button did not generate anything:

hid-recorder /dev/hidraw0
R: 102 05 01 09 02 a1 01 85 01 09 01 a1 00 05 09 19 01 29 03 15 00 25 01 75 01 
95 03 81 02 95 05 81 01 05 01 15 81 25 7f 75 08 95 03 09 30 09 31 09 38 81 06 
c0 c0 06 a0 ff 09 01 a1 01 85 02 09 02 a1 00 06 a1 ff 09 01 15 80 25 7f 35 00 
45 ff 75 08 95 04 81 02 09 11 15 80 25 7f 35 00 45 ff 75 08 95 04 91 02 c0 c0
N: Crucialtek co.,LTD Optical Track Pad
P: usb-0000:00:1a.0-1.3/input0
I: 3 26e1 c1a0
E: 0.000000 5 01 00 00 01 00
E: 0.007998 5 01 00 00 01 00
E: 0.031999 5 01 00 01 00 00
E: 0.160003 5 01 00 01 fe 00
E: 0.167999 5 01 00 01 ff 00
E: 0.175997 5 01 00 01 fe 00
E: 0.191999 5 01 00 01 fe 00
E: 0.199948 5 01 00 01 fd 00
E: 0.215935 5 01 00 01 fe 00
E: 0.223858 5 01 00 01 fe 00
E: 0.231940 5 01 00 00 ff 00
E: 0.247945 5 01 00 00 ff 00
E: 0.295953 5 01 00 00 ff 00
E: 0.319953 5 01 00 01 fe 00
E: 0.335936 5 01 00 02 fe 00
E: 0.343944 5 01 00 01 fe 00
E: 0.359938 5 01 00 01 ff 00
E: 0.383963 5 01 00 ff 00 00
E: 2.407955 5 01 02 00 00 00
E: 2.623954 5 01 00 00 00 00
E: 5.024015 5 01 01 00 00 00
E: 5.320041 5 01 00 00 00 00


Ciao
Stephan
-- 
| Cui bono? |
