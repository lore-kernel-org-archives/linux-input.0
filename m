From: Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [RFC] enumeration of "composite devices" using v-usb
Date: Thu, 24 Jan 2013 23:48:41 +0100
Message-ID: <5101BA49.3040006@gmx.de>
References: <50F9D313.4070803@gmx.de> <CAN+gG=EKTkCBifd1zgriigJObq0PHBNuqgAu9sD=144PRcXtSw@mail.gmail.com> <CAN+gG=EY2RpypiT5hAvBT1WqgZs9b3Z8J221614hUD_h_v8fNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:52827 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755982Ab3AXWsp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Jan 2013 17:48:45 -0500
Received: from mailout-de.gmx.net ([10.1.76.12]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0M6yV9-1UuRwc3Eub-00wkwi for
 <linux-input@vger.kernel.org>; Thu, 24 Jan 2013 23:48:43 +0100
In-Reply-To: <CAN+gG=EY2RpypiT5hAvBT1WqgZs9b3Z8J221614hUD_h_v8fNQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input@vger.kernel.org

Benjamin Tissoires schrieb:
> On Mon, Jan 21, 2013 at 4:45 PM, Benjamin Tissoires
> <benjamin.tissoires@gmail.com> wrote:
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
> I just figured out that you could use the quirk HID_QUIRK_MULTI_INPUT
> in usbhid/hid-quirks.c
> The reportID split is still missing, but this is an easier short term
> solution for you.
>
> Sorry,
> Benjamin
>
>> Oh, and if you want to contribute to split the device in the HID
>> parser under Linux, you are welcome as well :)
>>
>> Cheers,
>> Benjamin
Thanks for clearing things up a bit. I would preferably try to get the parser fixed, rather than changing the controllers firmware to use multiple interfaces (that seems to be the better long term solution, since there are already several similar projects on the internet to use multiple NES, SNES or Sega gamepads - all working with this reportID trick).
I have a certain experience in driver development (don't expect too much, though), but so far the complexity of usb and the hid-core are pretty overwhelming and give me a tough start. So, if you could give me a hint on which function to start looking at first, that would be highly appreciated.
You also mentioned, that my issue is already known and you would be working on it. Which search terms would I need to use to find information of your current state of development?
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

