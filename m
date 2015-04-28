From: John Reid <owlman.lists@gmail.com>
Subject: Re: keyboard not working with Thinkpad Helix (2nd gen)
Date: Wed, 29 Apr 2015 04:46:57 +1000
Message-ID: <553FD5A1.6040206@gmail.com>
References: <CAJXMp+qGdtEh59U33FKx+7CSyKbARRbAs30u8=fFR1c492eK4A@mail.gmail.com>	<CAN+gG=G8NboNgBQDTRZoUWaq0=+PqQaFiYFg6Jm_DYgpHStYQA@mail.gmail.com>	<CAJXMp+rzgaYA=nJ_Vrhg8FbUJ2-nEdmyoKg=X6fF+uXYBLCr0g@mail.gmail.com> <CAN+gG=GKJr4t_iFkuR68mA4_wz2xRZ=gsmJt=RkT-+9LGD+czw@mail.gmail.com> <553FCA5C.8060808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33998 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030524AbbD1SrC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Apr 2015 14:47:02 -0400
Received: by pablf10 with SMTP id lf10so750398pab.1
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2015 11:47:01 -0700 (PDT)
In-Reply-To: <553FCA5C.8060808@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, jono <lejono@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

Hi all,

To me the following page in the keyboard interface 0 descriptor (from
"sudo usbhid-dump -a1:8 -i0| grep -v : | xxd -r -p | hidrd-convert -o")
seems suspicious. I'm guessing Logical Maximum should not be -1 if
Logical Minimum is 0, and a Usage Maximum of FFFFh might break
include/linux/hid.h #define HID_MAX_USAGES    12288

Usage Page (88h),                   ; 88h, reserved
Usage (01h),
Collection (Application),
    Report ID (4),
    Usage Minimum (00h),
    Usage Maximum (FFFFh),
    Logical Minimum (0),
    Logical Maximum (-1),
    Report Size (8),
    Report Count (2),
    Input (Variable),
End Collection,

Cheers,
John

On 29/04/15 03:58, John Reid wrote:
> Hi Benjamin,
> 
> Thanks for getting back to us so promptly, and for the hopeful news.
> Please find attached attached the output for the debugfs/hid entries on
> my system. I've also updated the thinkwiki page with the output from
> every method of getting the HID descriptor I can think of.
> 
> I'll attach the output from dmesg with i2c-hid.debug in a seperate post
> once my kernel recompiles - I had CONFIG_DEBUG_DRIVER=y swamping the logs...
> 
> Cheers,
> John
> 
> BTW, I finally managed to get some events from the keyboard (keypress
> events for a,s,d,f on interface 0, still can't get anything on interface
> 1) :
> 
> $ sudo usbhid-dump -a1:8 -i0 -e all
> 001:008:000:DESCRIPTOR         1430239015.142435
>  06 85 FF 09 95 A1 01 85 5A 09 01 15 00 26 FF 00
>  75 08 95 10 B1 00 C0 05 01 09 06 A1 01 85 01 75
>  01 95 08 05 07 19 E0 29 E7 15 00 25 01 81 02 95
>  01 75 08 81 03 95 05 75 01 05 08 19 01 29 05 91
>  02 95 01 75 03 91 03 95 06 75 08 15 00 26 FF 00
>  05 07 19 00 2A FF 00 81 00 C0 05 0C 09 01 A1 01
>  85 03 19 00 2A 3C 02 15 00 26 3C 02 75 10 95 01
>  81 00 C0 05 01 09 0C A1 01 85 02 15 00 25 01 09
>  C6 95 01 75 01 81 06 75 07 81 03 C0 05 88 09 01
>  A1 01 85 04 19 00 2A FF FF 15 00 26 FF FF 75 08
>  95 02 81 02 C0 05 01 09 80 A1 01 85 05 19 81 29
>  83 15 00 25 01 95 08 75 01 81 02 C0
> 
> Starting dumping interrupt transfer stream
> with 1 minute timeout.
> 
> 001:008:000:STREAM             1430239018.043838
>  01 00 00 04 00 00 00 00 00
> 
> 001:008:000:STREAM             1430239018.095839
>  01 00 00 00 00 00 00 00 00
> 
> 001:008:000:STREAM             1430239019.163851
>  01 00 00 16 00 00 00 00 00
> 
> 001:008:000:STREAM             1430239019.211845
>  01 00 00 00 00 00 00 00 00
> 
> 001:008:000:STREAM             1430239021.495878
>  01 00 00 07 00 00 00 00 00
> 
> 001:008:000:STREAM             1430239021.551867
>  01 00 00 00 00 00 00 00 00
> 
> 001:008:000:STREAM             1430239022.091878
>  01 00 00 09 00 00 00 00 00
> 
> 001:008:000:STREAM             1430239022.143873
>  01 00 00 00 00 00 00 00 00
> 
> 
> 
> On 29/04/15 01:28, Benjamin Tissoires wrote:
>> HI Jonathan,
>>
>> On Mon, Apr 27, 2015 at 8:56 PM, jono <lejono@gmail.com> wrote:
>>> Thanks, and apologies for the multiple reports. I've attached the
>>> output of dmesg using the latest kernel. Other relevant files can be
>>> found in the links in my original message, and at
>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1448479
>>> Also this link may be of interest:
>>> http://www.thinkwiki.org/wiki/Installing_Kubuntu_15.04_on_a_Thinkpad_Helix_2nd_generation
>>
>> Thanks. Your dmesg and these links are useful information. The last
>> link says that the keyboard is a USB one, and that the report
>> descriptor is broken. This should not take too long to fix if that is
>> the case.
>>
>> Can you run as root:
>> #> for i in /sys/kernel/debug/hid/* ; do echo $i ; \
>>      cat $i/rdesc ; done > /tmp/rdesc.txt
>>
>> It will log in the file /tmp/rdesc.txt all of the report descriptors
>> available on your computer, and we should be able to figure out what
>> is broken here if you send it to us.
>>
>> For the Wacom part, the links above suggest that there is also a
>> touchscreen plugged through i2c-hid, but I do not see one in your
>> logs. This may be the root of the problem if i2c-hid is unable to
>> handle both the touchscreen and the Wacom digitizer.
>>
>> Can you also provide the dmesg while appending to the kernel boot line
>> "i2c-hid.debug=1".
>>
>> We should see a little bit more what is happening.
>>
>> Cheers,
>> Benjamin
>>
>>> Best,
>>> Jonathan
>>>
>>> On Mon, Apr 27, 2015 at 7:34 PM, Benjamin Tissoires
>>> <benjamin.tissoires@gmail.com> wrote:
>>>> Hi Jono,
>>>>
>>>> On Sun, Apr 26, 2015 at 2:16 PM, jono <lejono@gmail.com> wrote:
>>>>> The keyboard that this machine comes works fine under grub and windows
>>>>> but not linux.  The keyboard is a Lenovo Thinkpad Helix Ultrabook Pro
>>>>> which also has a touchpad, extra battery, usb port etc. The touchpad,
>>>>> battery, ports are all detected, but the keyboard doesn't work. A usb
>>>>> and bluetooth keyboard work fine.
>>>>>
>>>>> I currently have kernel 4.0.0- 040000- generic. It has been reported
>>>>> in a number of other forums, e.g.
>>>>>
>>>>> https:/ /bugs.launchpad .net/ubuntu/ +source/ xorg/+bug/ 1437051
>>>>> https://forums.lenovo.com/t5/Linux-Discussion/ThinkPad-Helix-keyboard-not-detected-in-Linux/td-p/2051477
>>>>>
>>>>> which all contain useful information and log files. I'm currently
>>>>> running on a fresh install of Ubuntu 15.04 with their "upstream
>>>>> kernel", but the problem exists in previous Ubuntu and kernel
>>>>> versions.
>>>>>
>>>>> "cat /proc/bus/input/devices" lists:
>>>>>
>>>>> I: Bus=0011 Vendor=0001 Product=0001 Version=ab54
>>>>> N: Name="AT Translated Set 2 keyboard"
>>>>> P: Phys=isa0060/serio0/input0
>>>>> S: Sysfs=/devices/platform/i8042/serio0/input/input3
>>>>> U: Uniq=
>>>>> H: Handlers=sysrq kbd event3
>>>>> B: PROP=0
>>>>> B: EV=120013
>>>>> B: KEY=402000000 3803078f800d001 feffffdfffefffff fffffffffffffffe
>>>>> B: MSC=10
>>>>> B: LED=7
>>>>>
>>>>> which appears to be it, The Xorg log lists
>>>>>
>>>>> [     4.815] (II) config/udev: Adding input device AT Translated Set 2
>>>>> keyboard (/dev/input/event3)
>>>>> [     4.815] (**) AT Translated Set 2 keyboard: Applying InputClass
>>>>> "evdev keyboard catchall"
>>>>> [     4.815] (II) Using input driver 'evdev' for 'AT Translated Set 2 keyboard'
>>>>> [     4.815] (**) AT Translated Set 2 keyboard: always reports core events
>>>>> [     4.815] (**) evdev: AT Translated Set 2 keyboard: Device:
>>>>> "/dev/input/event3"
>>>>> [     4.815] (--) evdev: AT Translated Set 2 keyboard: Vendor 0x1 Product 0x1
>>>>> [     4.815] (--) evdev: AT Translated Set 2 keyboard: Found keys
>>>>> [     4.815] (II) evdev: AT Translated Set 2 keyboard: Configuring as keyboard
>>>>> [     4.815] (**) Option "config_info"
>>>>> "udev:/sys/devices/platform/i8042/serio0/input/input3/event3"
>>>>> [     4.815] (II) XINPUT: Adding extended input device "AT Translated
>>>>> Set 2 keyboard" (type: KEYBOARD, id 14)
>>>>> [     4.815] (**) Option "xkb_rules" "evdev"
>>>>> [     4.815] (**) Option "xkb_model" "pc105"
>>>>> [     4.815] (**) Option "xkb_layout" "us"
>>>>>
>>>>>
>>>>>
>>>>> As an aside, the stylus is properly not recognized in this kernel, but
>>>>> works fine in previous kernels with "cat /proc/bus/input/devices"
>>>>> listing
>>>>>
>>>>> I: Bus=0018 Vendor=056a Product=0114 Version=0100
>>>>> N: Name="WCOM0009:00 056A:0114"
>>>>> P: Phys=
>>>>> S: Sysfs=/devices/pci0000:00/INT3433:00/i2c-8/i2c-WCOM0009:00/0018:056A:0114.0004/input/input9
>>>>> U: Uniq=
>>>>> H: Handlers=mouse2 event8
>>>>> B: PROP=0
>>>>> B: EV=1f
>>>>> B: KEY=c03 30001 0 0 0 0
>>>>> B: REL=3
>>>>> B: ABS=1000003
>>>>> B: MSC=10
>>>>>
>>>>> in kernel 3.12 for example, but the device is not listed in 3.16 or
>>>>> later (although possibly it is detected in earlier kernels).
>>>>>
>>>>
>>>> Hmm, you are here reporting 2 bugs at the same time, which will make
>>>> things difficult to track.
>>>>
>>>> Anyway, for being able to understand both problems, we will need the
>>>> dmesg output of the closest to upstream kernel you have.
>>>>
>>>> For the Wacom ISD bits, I  am adding Jason to the thread. It looks
>>>> like your device is an I2C over HID one, so I guess it did not worked
>>>> before v3.11 or v3.12. In v3.16 I changed the way the Wacoms are
>>>> handled and now they are all handled through HID. But this apparently
>>>> broke your device, and I'll try to figure out what happened. We
>>>> normally handle unknown Wacoms properly, but there must be something
>>>> odd in your case that should hopefully show up in the dmesg output.
>>>>
>>>> Cheers,
>>>> Benjamin
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
