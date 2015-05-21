From: Thomas Hellstrom <thellstrom@vmware.com>
Subject: Re: [PATCH 1/2] input/joydev: Don't classify the vmmouse as a joystick
Date: Thu, 21 May 2015 10:14:41 +0200
Message-ID: <555D93F1.1000002@vmware.com>
References: <1432035425-45514-1-git-send-email-thellstrom@vmware.com> <1432035425-45514-2-git-send-email-thellstrom@vmware.com> <20150520222352.GG23809@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------060401020605090708020107"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-outbound-1.vmware.com ([208.91.2.12]:56007 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751629AbbEUIPJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 May 2015 04:15:09 -0400
In-Reply-To: <20150520222352.GG23809@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com

--------------060401020605090708020107
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On 05/21/2015 12:23 AM, Dmitry Torokhov wrote:
> Hi Thomas,
>
> On Tue, May 19, 2015 at 04:37:04AM -0700, Thomas Hellstrom wrote:
>> Joydev is currently thinking some absolute mice are joystick, and that
>> messes up games in VMware guests, as the cursor typically gets stuck in
>> the top left corner.
>>
>> Try to detect the event signature of a VMmouse input device and back off
>> for such devices. We're still incorrectly detecting, for example, the
>> VMware absolute USB mouse as a joystick, but adding an event signature
>> matching also that device would be considerably more risky, so defer that
>> to a later merge window.
> Right. What events does it report?

I'm attaching an evemu-describe event report. One possibility would be
to relax the mouse button requirement from being strictly
left-right-middle to just include left-right-middle, and also accept
relative mouse wheels.

However note that VMware's absolute usb mouse is disabled (by default)
on Linux because of joydev, and even if joydev is
fixed I doubt that it will be enabled by default again, as long as there
are "buggy" joydevs out there. Still, I see a point in adding signature
matching for it anyway, as users can override the default off setting
and it would also pave the way for upcoming similar devices, as adding
signature matching like this in the last minute tends to be risky...

>
> EV_SYN is set automatically on _every_ input device.
> There is also amijoy driver that historically uses
> BTN_LEFT/RIGHT/MIDDLE.
>
> Does the version of the patch below still work for you?
>

Yes, it works just fine. If there's a chance we can have that patch in
4.1GA that would be great.

Thanks,
Thomas


--------------060401020605090708020107
Content-Type: text/plain; charset="UTF-8"; name="usb_abs-1.desc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="usb_abs-1.desc"

# EVEMU 1.2
# Input device name: "VMware VMware Virtual USB Mouse"
# Input device ID: bus 0x03 vendor 0xe0f product 0x03 version 0x110
# Supported events:
#   Event type 0 (EV_SYN)
#     Event code 0 (SYN_REPORT)
#     Event code 1 (SYN_CONFIG)
#     Event code 2 (SYN_MT_REPORT)
#     Event code 3 (SYN_DROPPED)
#     Event code 4 ((null))
#     Event code 5 ((null))
#     Event code 6 ((null))
#     Event code 7 ((null))
#     Event code 8 ((null))
#     Event code 9 ((null))
#     Event code 10 ((null))
#     Event code 11 ((null))
#     Event code 12 ((null))
#     Event code 13 ((null))
#     Event code 14 ((null))
#   Event type 1 (EV_KEY)
#     Event code 272 (BTN_LEFT)
#     Event code 273 (BTN_RIGHT)
#     Event code 274 (BTN_MIDDLE)
#     Event code 275 (BTN_SIDE)
#     Event code 276 (BTN_EXTRA)
#     Event code 277 (BTN_FORWARD)
#     Event code 278 (BTN_BACK)
#     Event code 279 (BTN_TASK)
#     Event code 280 ((null))
#     Event code 281 ((null))
#     Event code 282 ((null))
#     Event code 283 ((null))
#     Event code 284 ((null))
#     Event code 285 ((null))
#     Event code 286 ((null))
#     Event code 287 ((null))
#   Event type 2 (EV_REL)
#     Event code 6 (REL_HWHEEL)
#     Event code 8 (REL_WHEEL)
#   Event type 3 (EV_ABS)
#     Event code 0 (ABS_X)
#       Value  12344
#       Min        0
#       Max    32767
#       Fuzz       0
#       Flat       0
#       Resolution 0
#     Event code 1 (ABS_Y)
#       Value  16828
#       Min        0
#       Max    32767
#       Fuzz       0
#       Flat       0
#       Resolution 0
#   Event type 4 (EV_MSC)
#     Event code 4 (MSC_SCAN)
# Properties:
N: VMware VMware Virtual USB Mouse
I: 0003 0e0f 0003 0110
P: 00 00 00 00 00 00 00 00
B: 00 0b 00 00 00 00 00 00 00
B: 01 00 00 00 00 00 00 00 00
B: 01 00 00 00 00 00 00 00 00
B: 01 00 00 00 00 00 00 00 00
B: 01 00 00 00 00 00 00 00 00
B: 01 00 00 ff ff 00 00 00 00
B: 01 00 00 00 00 00 00 00 00
B: 01 00 00 00 00 00 00 00 00
B: 01 00 00 00 00 00 00 00 00
B: 01 00 00 00 00 00 00 00 00
B: 01 00 00 00 00 00 00 00 00
B: 01 00 00 00 00 00 00 00 00
B: 01 00 00 00 00 00 00 00 00
B: 02 40 01 00 00 00 00 00 00
B: 03 03 00 00 00 00 00 00 00
B: 04 10 00 00 00 00 00 00 00
B: 05 00 00 00 00 00 00 00 00
B: 11 00 00 00 00 00 00 00 00
B: 12 00 00 00 00 00 00 00 00
B: 14 00 00 00 00 00 00 00 00
B: 15 00 00 00 00 00 00 00 00
B: 15 00 00 00 00 00 00 00 00
A: 00 0 32767 0 0 0
A: 01 0 32767 0 0 0

--------------060401020605090708020107--
