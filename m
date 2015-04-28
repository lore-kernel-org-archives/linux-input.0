From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Thinkpad Helix (2nd gen) Wacom stylus not working (was Re:
 keyboard not working with Thinkpad Helix (2nd gen) (also stylus))
Date: Tue, 28 Apr 2015 17:20:04 -0400
Message-ID: <CAN+gG=EDjQMU=kzePc-Lj7-_cd1HyvVDQxncZJcJ0T8VvKto0g@mail.gmail.com>
References: <CAJXMp+qGdtEh59U33FKx+7CSyKbARRbAs30u8=fFR1c492eK4A@mail.gmail.com>
	<CAN+gG=G8NboNgBQDTRZoUWaq0=+PqQaFiYFg6Jm_DYgpHStYQA@mail.gmail.com>
	<CAJXMp+rzgaYA=nJ_Vrhg8FbUJ2-nEdmyoKg=X6fF+uXYBLCr0g@mail.gmail.com>
	<CAN+gG=GKJr4t_iFkuR68mA4_wz2xRZ=gsmJt=RkT-+9LGD+czw@mail.gmail.com>
	<553FE975.90905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:36332 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966017AbbD1VUF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Apr 2015 17:20:05 -0400
Received: by qcpm10 with SMTP id m10so4293384qcp.3
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2015 14:20:04 -0700 (PDT)
In-Reply-To: <553FE975.90905@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: John Reid <owlman.lists@gmail.com>
Cc: jono <lejono@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jason Gerecke <killertofu@gmail.com>

On Tue, Apr 28, 2015 at 4:11 PM, John Reid <owlman.lists@gmail.com> wrote:
> Hi all,
>
> I've attached the dmesg output from my system with kernel boot option
> i2c-hid.debug=1
>
> $ uname -a
> Linux espace 4.0.0-040000-generic #201504121935+debug1.1 SMP Wed Apr 29
> 03:37:46 AEST 2015 x86_64 x86_64 x86_64 GNU/Linux

Thanks both of you for the traces.

When I "plug" the report descriptor on my system, it gets correctly
handled by wacom.ko. Can you make sure that you have the wacom module
enabled in your tree?
Everything looks fine on the i2c-hid side, so wacom.ko should get
loaded when the device is ready while it is not the case.

>
> On my system the i2c-ATML1000:00 touchscreen appears to work without any
> problems. I'm not sure how to test the Wacom digitiser... I can't see

I guess if the cursor follows the stylus, you are good :)


Regarding the ATMEL digitizer, your two Helix 2 are slightly
different. You both have a stylus from Wacom (pid 0x0114) while John
has an Atmel digitizer and Jonathan a Wacom one.
That means that when the Wacom driver will be loaded, Jonathan will
get both touch and stylus input, and kernel palm rejection, while John
will need to force the digitizer to go through xf86-input-wacom to get
palm rejection.

> anything too obvious in the logs. Been too busy trying to sort out the
> keyboard, and thought I'd get around to testing the digitiser once I've
> set up libinput and the xf86-input-libinput driver.

libinput and xf86-libinput won't work right now for the wacom stylus
part. The tablet support is still in a WIP branch as we need to polish
it a little bit more. You need to use xf86-input-wacom which should
get loaded automatically as soon as the wacom device shows up in the
dmesg.

>
> Hope this helps :)
>

Yep :)

One last thing. On the Thinkwiki, there is a mention that the
Synaptics buttons are behaving like scroll events. Which kernel was
used to make this test?
A recent kernel (maybe 4.1-rc1, I can't recall if this was in 4.0
final or backported to it) should reroute the trackstick buttons to
the trackstick and they should forward left, middle, right from the
trackstick node, not the touchpad node.

You can test that by running evemu-record (package evemu. in most
distributions).

If this is not working as expected with a 4.1-rc1 kernel, then I will
need to fix that too :(

Cheers,
Benjamin

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
