From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: [PATCH] Input: joydev - ignore accelerometer devices
Date: Mon, 10 Jul 2017 17:42:00 -0700
Message-ID: <CANndSKmCT9yxWwoohknV0r8Kr1A-OTynRRJk0+cZq_YZGp=rVw@mail.gmail.com>
References: <20170609203547.17691-1-roderick@gaikai.com> <20170609203547.17691-2-roderick@gaikai.com>
 <20170612070953.GA29589@mail.corp.redhat.com> <20170620025710.GF21379@dtor-ws>
 <CANndSKmXo5hxkUQsowD_TH0fjmW+b47CntKOrVpSrZ_69MumJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34899 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbdGKAmC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Jul 2017 20:42:02 -0400
Received: by mail-oi0-f44.google.com with SMTP id 191so89374781oii.2
        for <linux-input@vger.kernel.org>; Mon, 10 Jul 2017 17:42:02 -0700 (PDT)
In-Reply-To: <CANndSKmXo5hxkUQsowD_TH0fjmW+b47CntKOrVpSrZ_69MumJg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Tue, Jun 20, 2017 at 9:58 AM, Roderick Colenbrander
<roderick@gaikai.com> wrote:
> On Mon, Jun 19, 2017 at 7:57 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Mon, Jun 12, 2017 at 09:09:53AM +0200, Benjamin Tissoires wrote:
>>> On Jun 09 2017 or thereabouts, Roderick Colenbrander wrote:
>>> > From: Roderick Colenbrander <roderick.colenbrander@sony.com>
>>> >
>>> > Gamepads like DualShock 3 / 4 as of 4.12 started reporting motion
>>> > sensors on a separate evdev node. Joydev is picking these devices
>>> > up as well, but they don't make sense for the joydev interface.
>>> >
>>> > Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
>>> > ---
>>>
>>> Acked-By: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>
>> Hmm, I think you can quite often use accelerometer as a joystick, it is
>> only the composite devices that we want to ignore I think.
>>
>
> Correct the issue came up for composite devices. So far the
> input_prop_accelerometer flag is only used in a handful of drivers
> (udraw, wacom and sony). They don't have any buttons on the motion
> devices.
>
> The wii driver doesn't set any the acceleration flag yet, but may mix
> acceleration sensors, buttons and sticks. At least currently it does
> for nunchuck and questionably uses ABS_HAT0X/0Y instead of 'ABS_X/_Y'
> for an analog stick, maybe not to get picked up by joydev, the same
> device reports acceleration through ABS_RX/_RY_RZ.
>
> Personally I had the feeling that motion sensors may not be in the
> spirit of the classic joydev interface in part, because it is
> difficult to figure out what axes of which type. If you think it is
> okay to support them through here, I don't mind finding another way at
> least for composite devices to not get these registered. I'm not fully
> sure how we can figure out something is a composite device from joydev
> in an easy way. Any suggestions?

I have been trying to see how this could be handed. Considering we
can't easily look up other devices (and we are still in the process of
device initialization), the best I could think of is maybe adding more
flags to devices. Maybe introduce a new flag to mark something as a
composite device e.g. 'INPUT_PROP_COMPOSITE'. The logic could then be
to filter out composite devices with accelerometers. In addition such
a flag could also be a nice hint to user space that a device is a
composite device.

Another option if no new flags are desired, could be a check which
checks if the device has accelerometers, but no other axes or keys.
Something along these lines is a bit messier.
