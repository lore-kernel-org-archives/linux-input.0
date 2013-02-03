From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [RFC] enumeration of "composite devices" using v-usb
Date: Sun, 3 Feb 2013 11:41:42 +0100
Message-ID: <CAN+gG=FTmAV_gtFyt+n-mkgWM0GVSw3ngw1fDrbRZ87eJPTrXQ@mail.gmail.com>
References: <50F9D313.4070803@gmx.de>
	<CAN+gG=EKTkCBifd1zgriigJObq0PHBNuqgAu9sD=144PRcXtSw@mail.gmail.com>
	<510DA95C.20607@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:43377 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152Ab3BCKlo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Feb 2013 05:41:44 -0500
Received: by mail-lb0-f170.google.com with SMTP id ge1so5886459lbb.1
        for <linux-input@vger.kernel.org>; Sun, 03 Feb 2013 02:41:43 -0800 (PST)
In-Reply-To: <510DA95C.20607@gmx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Sun, Feb 3, 2013 at 1:03 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
> Benjamin Tissoires schrieb:
>> On Fri, Jan 18, 2013 at 5:56 PM, Hartmut Knaack <knaack.h@gmx.de> wrote:
>>> Hi,
>>> I've built myself a joystick adapter (project website: http://www.hexagons.de/index.php/USB_Joystickadapter), which has the purpose of connecting up to 2 Atari style joysticks (the ones with db9 connectors, found on 80's home computers like C64, Amiga,...) via USB. Current situation is: on Windows XP, 2 joystick devices get created with 2 axis and 2 buttons each (as intended); while on Linux, just one joystick device (/dev/input/js0) gets created, but with 4 axis and 4 buttons.
>>> This device provides one interface with one Interrupt-in Endpoint. The division into two joystick devices is done using an HID descriptor [1] with two configurations and the REPORT_ID tag.
>>> What I would like to know is, is there a problem in the Linux HID parser, or is its behavior intentional and those composite devices more like a dirty solution around the standards?
>> Hi,
>>
>> well, currently, the HID parser does not split the different reportID
>> into several devices. It's a known limitation and we are working on it
>> (at least we already saw problems with that), but it will not make it
>> in 3.9 I think.
>> The solution that works for now is to use several usb interfaces. The
>> usb layer splits the different interfaces, so it will give you 2
>> different HID devices.
>> Oh, and if you want to contribute to split the device in the HID
>> parser under Linux, you are welcome as well :)
>>
>> Cheers,
>> Benjamin
> Hi,
> using the quirk HID_QUIRK_MULTI_INPUT led to the right result: js0 and js1 got created. So, after getting to know a bit about all the probing and parsing, I found a rather simple solution/workaround. In hid-input.c, function hidinput_connect, replace:
> 1251 <http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=drivers/hid/hid-input.c;h=21b196c394b197d222e0d1f58ac52f37d65b3e5d;hb=HEAD#l1251>
> 1252 <http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=drivers/hid/hid-input.c;h=21b196c394b197d222e0d1f58ac52f37d65b3e5d;hb=HEAD#l1252>                         if (hid->quirks & HID_QUIRK_MULTI_INPUT) {
> 1253 <http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=drivers/hid/hid-input.c;h=21b196c394b197d222e0d1f58ac52f37d65b3e5d;hb=HEAD#l1253>                                 /* This will leave hidinput NULL, so that it
> with:
> 1251 <http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=drivers/hid/hid-input.c;h=21b196c394b197d222e0d1f58ac52f37d65b3e5d;hb=HEAD#l1251>
> 1252 <http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=drivers/hid/hid-input.c;h=21b196c394b197d222e0d1f58ac52f37d65b3e5d;hb=HEAD#l1252>                         if (hid->quirks & HID_QUIRK_MULTI_INPUT || report->id) {
> 1253 <http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=drivers/hid/hid-input.c;h=21b196c394b197d222e0d1f58ac52f37d65b3e5d;hb=HEAD#l1253>                                 /* This will leave hidinput NULL, so that it
> The parser makes sure that, if the HID Report Descriptor contains a definition for reportID, it is not zero.
> Is this attempt OK for you, or do you see any problems? And is HID_QUIRK_MULTI_INPUT still needed in this case?

Sorry for that, I skipped answering your previous mail, so I couldn't
have explained what was missing.
Adding in CC Jirim the hid maintainer.

So, here, the solution you are proposing is, to my mind, not the one
needed. Your device just fits under the case of the
HID_QUIRK_MULTI_INPUT: your device presents several interfaces which
are handled in the same way. The problem comes from devices presenting
several interfaces which are not of the same kind. Some devices
presents on the very same HID descriptor a (multi) touchscreen and a
tablet with a stylus for instance. Both interfaces are activated at
the same time but need different handling.

The discussion I was referring to was about to split the hid driver
much sooner (when parsing the report descriptor) so that it can handle
_different_ hid drivers, one per report.

Your solution is strictly equivalent to remove the
HID_QUIRK_MULTI_INPUT as you can only have several reports if they
have different report_id. But the more I think of it, the more I think
this quirk should not exist if we want to be compliant with the HID
spec. It's just that the current implementation does not allow us to
just remove it.

I really think that just adding the quirk HID_QUIRK_MULTI_INPUT for
your device is the best solution currently as it can be easily
backported and you can even put this quirk from the user-space while
loading usbhid (or by adding it to the boot command of your kernel).

Thanks for the attempt :)

Cheers,
Benjamin


> Thanks
>
> Hartmut
>>> Thanks
>>>
>>> Hartmut Knaack
>>>
>>> [1]
>>> char usbHidReportDescriptor[102] PROGMEM = {
>>>
>>>     // Joystick Port 1
>>>
>>>     0x05, 0x01,                    // USAGE_PAGE (Generic Desktop)
>>>     0x09, 0x04,                    // USAGE (Joystick)
>>>     0xa1, 0x01,                    // COLLECTION (Application)
>>>     0x85, 0x01,                    // REPORT_ID (1)
>>>     0x09, 0x01,                    //   USAGE (Pointer)
>>>     0xa1, 0x00,                    //   COLLECTION (Physical)
>>>     0x09, 0x30,                    //     USAGE (X)
>>>     0x09, 0x31,                    //     USAGE (Y)
>>>     0x15, 0x00,                    //   LOGICAL_MINIMUM (0)
>>>     0x26, 0xff, 0x00,               //   LOGICAL_MAXIMUM (255)
>>>     0x75, 0x08,                    //   REPORT_SIZE (8)
>>>     0x95, 0x02,                    //   REPORT_COUNT (2)
>>>     0x81, 0x02,                    //   INPUT (Data,Var,Abs)
>>>     0xc0,                          // END_COLLECTION
>>>     0x05, 0x09,                    // USAGE_PAGE (Button)
>>>     0x19, 0x01,                    //   USAGE_MINIMUM (Button 1)
>>>     0x29, 0x02,                    //   USAGE_MAXIMUM (Button 2)
>>>     0x15, 0x00,                    //   LOGICAL_MINIMUM (0)
>>>     0x25, 0x01,                    //   LOGICAL_MAXIMUM (1)
>>>     0x75, 0x01,                    // REPORT_SIZE (1)
>>>     0x95, 0x02,                    // REPORT_COUNT (2)
>>>     0x81, 0x02,                    // INPUT (Data,Var,Abs)
>>>     0x75, 0x06,                    // REPORT_SIZE (6)
>>>     0x95, 0x01,                    // REPORT_COUNT (1)
>>>     0x81, 0x03,                    // INPUT (Constant,Var,Abs)
>>>     0xc0,                          // END_COLLECTION
>>>
>>>     // Joystick Port 2
>>>
>>>     0x05, 0x01,                    // USAGE_PAGE (Generic Desktop)
>>>     0x09, 0x04,                    // USAGE (Joystick)
>>>     0xa1, 0x01,                    // COLLECTION (Application)
>>>     0x85, 0x02,                    // REPORT_ID (2)
>>>     0x09, 0x01,                    //   USAGE (Pointer)
>>>     0xa1, 0x00,                    //   COLLECTION (Physical)
>>>     0x09, 0x30,                    //     USAGE (X)
>>>     0x09, 0x31,                    //     USAGE (Y)
>>>     0x15, 0x00,                    //   LOGICAL_MINIMUM (0)
>>>     0x26, 0xff, 0x00,               //   LOGICAL_MAXIMUM (255)
>>>     0x75, 0x08,                    //   REPORT_SIZE (8)
>>>     0x95, 0x02,                    //   REPORT_COUNT (2)
>>>     0x81, 0x02,                    //   INPUT (Data,Var,Abs)
>>>     0xc0,                          // END_COLLECTION
>>>     0x05, 0x09,                    // USAGE_PAGE (Button)
>>>     0x19, 0x01,                    //   USAGE_MINIMUM (Button 1)
>>>     0x29, 0x02,                    //   USAGE_MAXIMUM (Button 2)
>>>     0x15, 0x00,                    //   LOGICAL_MINIMUM (0)
>>>     0x25, 0x01,                    //   LOGICAL_MAXIMUM (1)
>>>     0x75, 0x01,                    // REPORT_SIZE (1)
>>>     0x95, 0x02,                    // REPORT_COUNT (2)
>>>     0x81, 0x02,                    // INPUT (Data,Var,Abs)
>>>     0x75, 0x06,                    // REPORT_SIZE (6)
>>>     0x95, 0x01,                    // REPORT_COUNT (1)
>>>     0x81, 0x03,                    // INPUT (Constant,Var,Abs)
>>>     0xc0                           // END_COLLECTION
>>> };
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
