From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: [PATCH] Input: mt: only perform pointer emulation on drivers
 desiring this functionality
Date: Thu, 27 Oct 2016 16:27:08 -0700
Message-ID: <CANndSKkEiy6wYjZV_0kVwMsk1b0aeJgV5q-WpRpEFi6qj_GRrw@mail.gmail.com>
References: <1477603873-9143-1-git-send-email-roderick@gaikai.com> <a1875ed3-56c1-18e7-6cd2-49486c9d1d08@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35704 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034145AbcJ0X1J (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Oct 2016 19:27:09 -0400
Received: by mail-vk0-f53.google.com with SMTP id q126so41720672vkd.2
        for <linux-input@vger.kernel.org>; Thu, 27 Oct 2016 16:27:09 -0700 (PDT)
In-Reply-To: <a1875ed3-56c1-18e7-6cd2-49486c9d1d08@bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

Hi Henrik,

Please see my comments inline.

Thanks,
Roderick

On Thu, Oct 27, 2016 at 3:46 PM, Henrik Rydberg <rydberg@bitmath.org> wrote:
> Hi Roderick,
>
>> Pointer emulation is undesired on drivers, which didn't request this
>> capability like the hid-sony driver for the Dualshock 4. This gamepad already
>> reports ABS_X / ABS_Y for gamepad stick purposes. Pointer emulation would
>> inject touchpad values into these sticks, which is undesired.
>>
>> This patch checks the flags INPUT_MT_POINTER / INPUT_MT_DIRECT from within
>> input_mt_sync_frame to only allow pointer emulation when the feature was
>> requested by the driver as the flags were set in input_mt_init_slots.
>
> So why call input_mt_sync_frame() in the first place?
>
> The existing drivers that use ABS_X / ABS_Y independently do not call that
> function. It seems your recent hid-sony patches adds it, which leads to broken
> behavior.

As part of the review, it was recommended to call input_mt_sync_frame
to make sure we don't lose certain events.
Later on after more validation, we noticed this issue which we weren't aware of.

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
>>
>
> That said, I am not against this patch at all, I think it is good, but the
> commit message should address the effect on the large number of existing drivers
> that use this functionality. Is any of them affected by this patch? As you
> probably know, we do not like to break userspace.
>
> From what I can see, only hid-multitouch (Benjamin?) and hid-sony use
> input_mt_init_slots() in such a way that MT_POINTER or MT_DIRECT cannot be
> directly inferred. So if Benjamin sees no issues with this, I am ok with the change.
>
> Thanks,
> Henrik
>
