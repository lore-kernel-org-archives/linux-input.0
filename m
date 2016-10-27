From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: [PATCH] Input: mt: only perform pointer emulation on drivers
 desiring this functionality
Date: Thu, 27 Oct 2016 16:46:01 -0700
Message-ID: <CANndSKmxgUM-u+jZF611Ko5supENX95-JR2xKp++3YPGZHAJtw@mail.gmail.com>
References: <1477603873-9143-1-git-send-email-roderick@gaikai.com> <20161027231942.GB12312@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35936 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030644AbcJ0XqC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Oct 2016 19:46:02 -0400
Received: by mail-vk0-f45.google.com with SMTP id y123so42199726vka.3
        for <linux-input@vger.kernel.org>; Thu, 27 Oct 2016 16:46:02 -0700 (PDT)
In-Reply-To: <20161027231942.GB12312@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Thu, Oct 27, 2016 at 4:19 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Oct 27, 2016 at 02:31:13PM -0700, Roderick Colenbrander wrote:
>> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
>>
>> The input-mt driver pointer emulation from 'input_mt_sync_frame' regardless
>> of the flags passed in to 'input_mt_init_slots' by device drivers.
>
> Right, because needing single-touch (pointer) emulation is not property
> of device or driver but rather consumer. If we get to the point where
> everything is ready to accept multi-touch (are we there yet) then we can
> stop doing pointer emulation altogether.
>
>>
>> Pointer emulation is undesired on drivers, which didn't request this
>> capability like the hid-sony driver for the Dualshock 4. This gamepad already
>> reports ABS_X / ABS_Y for gamepad stick purposes. Pointer emulation would
>> inject touchpad values into these sticks, which is undesired.
>
> The driver should not be re-purposing events like that.
> ABS_MT_POSITION_X and ABS_X should match.
>
> Why doesn't driver follow Documentation/input/gamepad.txt?
>

The original hid-sony code and the multitouch handling code for the Dualshock 4
were written by the community. We are stepping in to make the hid-sony driver
properly handle the Dualshock 4.
The driver doesn't fully follow the gamepad spec yet, which we will
try to improve. At
least the left analog stick is reported as ABS_X and ABS_Y already,
but the buttons
are inconsistent and right stick is wrong as well.
While it would be great to conform to the spec, the conflict with
multitouch would still
exist as the Dualshock 4 has both analog sticks and a multitouch touchpad.

Disabling the pointer emulation feature avoids the conflict. This
issue was only exposed
recently by adding of the input_mt_sync_frame call as recommended by Benjamin as
part of some improvements we did for touchpad handling in hid-sony.

>>
>> This patch checks the flags INPUT_MT_POINTER / INPUT_MT_DIRECT from within
>> input_mt_sync_frame to only allow pointer emulation when the feature was
>> requested by the driver as the flags were set in input_mt_init_slots.
>> ---
>>  drivers/input/input-mt.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
>> index a1bbec9..30c8128 100644
>> --- a/drivers/input/input-mt.c
>> +++ b/drivers/input/input-mt.c
>> @@ -305,7 +305,8 @@ void input_mt_sync_frame(struct input_dev *dev)
>>       if ((mt->flags & INPUT_MT_POINTER) && !(mt->flags & INPUT_MT_SEMI_MT))
>>               use_count = true;
>>
>> -     input_mt_report_pointer_emulation(dev, use_count);
>> +     if (mt->flags & (INPUT_MT_POINTER | INPUT_MT_DIRECT))
>> +             input_mt_report_pointer_emulation(dev, use_count);
>>
>>       mt->frame++;
>>  }
>> --
>> 2.7.4
>>
>
> Thanks.
>
> --
> Dmitry

Thanks,

-- 
Roderick Colenbrander
Senior Manager of Software Engineering
Gaikai, a Sony Interactive Entertainment Company
roderick@gaikai.com
