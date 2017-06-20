From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: [PATCH] Input: joydev - ignore accelerometer devices
Date: Tue, 20 Jun 2017 09:58:40 -0700
Message-ID: <CANndSKmXo5hxkUQsowD_TH0fjmW+b47CntKOrVpSrZ_69MumJg@mail.gmail.com>
References: <20170609203547.17691-1-roderick@gaikai.com> <20170609203547.17691-2-roderick@gaikai.com>
 <20170612070953.GA29589@mail.corp.redhat.com> <20170620025710.GF21379@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:32854 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdFTQ6l (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Jun 2017 12:58:41 -0400
Received: by mail-oi0-f45.google.com with SMTP id p66so43082778oia.0
        for <linux-input@vger.kernel.org>; Tue, 20 Jun 2017 09:58:41 -0700 (PDT)
In-Reply-To: <20170620025710.GF21379@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Mon, Jun 19, 2017 at 7:57 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Jun 12, 2017 at 09:09:53AM +0200, Benjamin Tissoires wrote:
>> On Jun 09 2017 or thereabouts, Roderick Colenbrander wrote:
>> > From: Roderick Colenbrander <roderick.colenbrander@sony.com>
>> >
>> > Gamepads like DualShock 3 / 4 as of 4.12 started reporting motion
>> > sensors on a separate evdev node. Joydev is picking these devices
>> > up as well, but they don't make sense for the joydev interface.
>> >
>> > Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
>> > ---
>>
>> Acked-By: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> Hmm, I think you can quite often use accelerometer as a joystick, it is
> only the composite devices that we want to ignore I think.
>

Correct the issue came up for composite devices. So far the
input_prop_accelerometer flag is only used in a handful of drivers
(udraw, wacom and sony). They don't have any buttons on the motion
devices.

The wii driver doesn't set any the acceleration flag yet, but may mix
acceleration sensors, buttons and sticks. At least currently it does
for nunchuck and questionably uses ABS_HAT0X/0Y instead of 'ABS_X/_Y'
for an analog stick, maybe not to get picked up by joydev, the same
device reports acceleration through ABS_RX/_RY_RZ.

Personally I had the feeling that motion sensors may not be in the
spirit of the classic joydev interface in part, because it is
difficult to figure out what axes of which type. If you think it is
okay to support them through here, I don't mind finding another way at
least for composite devices to not get these registered. I'm not fully
sure how we can figure out something is a composite device from joydev
in an easy way. Any suggestions?
