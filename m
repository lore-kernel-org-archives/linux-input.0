From: Anshul Garg <aksgarg1989@gmail.com>
Subject: Re: [PATCH] Input: Optimize input_to_handler and input_pass_values function
Date: Mon, 5 Jan 2015 21:40:22 +0530
Message-ID: <CA+HOOshDnqxyEO6ywqRzZxEDig-UgyRZisaHP7FTBP1Dr6jgCw@mail.gmail.com>
References: <1419918593-14976-1-git-send-email-anshul.g@samsung.com>
	<20150104225733.GE31987@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:53983 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbbAEQKX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Jan 2015 11:10:23 -0500
Received: by mail-yk0-f172.google.com with SMTP id 131so10424736ykp.31
        for <linux-input@vger.kernel.org>; Mon, 05 Jan 2015 08:10:22 -0800 (PST)
In-Reply-To: <20150104225733.GE31987@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "anshul.g@samsung.com" <anshul.g@samsung.com>, linux-input@vger.kernel.org, p.shailesh@samsung.com

Dear Mr Dimtry ,

Thanks for the suggestions.
I will send you the updated patch soon.



On Mon, Jan 5, 2015 at 4:27 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Dec 30, 2014 at 11:19:53AM +0530, anshul.g@samsung.com wrote:
>> From: Anshul Garg <anshul.g@samsung.com>
>>
>> As input_pass_values function is called everytime when EV_SYN is sent from
>> input driver or input event buffer becomes full.
>>
>> 1. In case of regular handler, event filter code should not run so added check
>>    whether handler supports filter or not.
>> 2. If input device doesn't support EV_KEY event type avoid running auto repeat code.
>
> Can you please split it in 2 patches?
>
>>
>> Signed-off-by: Anshul Garg <anshul.g@samsung.com>
>> ---
>>  drivers/input/input.c |   37 +++++++++++++++++++++----------------
>>  1 file changed, 21 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/input/input.c b/drivers/input/input.c
>> index bbec2dc..9d6609b 100644
>> --- a/drivers/input/input.c
>> +++ b/drivers/input/input.c
>> @@ -100,23 +100,24 @@ static unsigned int input_to_handler(struct input_handle *handle,
>>       struct input_value *end = vals;
>>       struct input_value *v;
>>
>> -     for (v = vals; v != vals + count; v++) {
>> -             if (handler->filter &&
>> -                 handler->filter(handle, v->type, v->code, v->value))
>> -                     continue;
>> -             if (end != v)
>> -                     *end = *v;
>> -             end++;
>> +     if (handler->filter) {
>> +             for (v = vals; v != vals + count; v++) {
>> +                     if (handler->filter(handle, v->type, v->code, v->value))
>> +                             continue;
>> +                     if (end != v)
>> +                             *end = *v;
>> +                     end++;
>> +             }
>> +             count = end - vals;
>>       }
>>
>> -     count = end - vals;
>>       if (!count)
>>               return 0;
>>
>>       if (handler->events)
>>               handler->events(handle, vals, count);
>>       else if (handler->event)
>> -             for (v = vals; v != end; v++)
>> +             for (v = vals; v != vals + count; v++)
>>                       handler->event(handle, v->type, v->code, v->value);
>>
>>       return count;
>> @@ -143,8 +144,10 @@ static void input_pass_values(struct input_dev *dev,
>>               count = input_to_handler(handle, vals, count);
>>       } else {
>>               list_for_each_entry_rcu(handle, &dev->h_list, d_node)
>> -                     if (handle->open)
>> +                     if (handle->open && count)
>>                               count = input_to_handler(handle, vals, count);
>> +                     else
>> +                             break;
>
> This is not correct. You'll stop delivering events at the very first
> closed handle, which is not what we want. We need:
>
>                         if (handle->open) {
>                                 count = input_to_handler(handle, vals, count);
>                                 if (count == 0)
>                                         break;
>                         }
>
>>       }
>>
>>       rcu_read_unlock();
>> @@ -152,12 +155,14 @@ static void input_pass_values(struct input_dev *dev,
>>       add_input_randomness(vals->type, vals->code, vals->value);
>>
>>       /* trigger auto repeat for key events */
>> -     for (v = vals; v != vals + count; v++) {
>> -             if (v->type == EV_KEY && v->value != 2) {
>> -                     if (v->value)
>> -                             input_start_autorepeat(dev, v->code);
>> -                     else
>> -                             input_stop_autorepeat(dev);
>> +     if (test_bit(EV_KEY, dev->evbit)) {
>
> You might want to test for presence of EV_REP as well.
>
>> +             for (v = vals; v != vals + count; v++) {
>> +                     if (v->type == EV_KEY && v->value != 2) {
>> +                             if (v->value)
>> +                                     input_start_autorepeat(dev, v->code);
>> +                             else
>> +                                     input_stop_autorepeat(dev);
>> +                     }
>>               }
>>       }
>>  }
>> --
>> 1.7.9.5
>>
>
> Thanks.
>
> --
> Dmitry
