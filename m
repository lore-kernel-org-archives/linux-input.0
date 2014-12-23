From: Anshul Garg <aksgarg1989@gmail.com>
Subject: Re: [Question : drivers/input ] Fixing Event Filter Mechanism in
 input subsystem
Date: Tue, 23 Dec 2014 06:52:17 +0530
Message-ID: <CA+HOOshONvGbFN9F08ppZLeYDLwhqFpWq6zxBTF=1Pn-CiyZ-A@mail.gmail.com>
References: <CA+HOOsgL_fY=Wc+ciDAuk485d=uTn=YTgVGVDJ5Qk3UsqQ8zVA@mail.gmail.com>
	<20141222172622.GA18556@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:45637 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594AbaLWBWS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Dec 2014 20:22:18 -0500
Received: by mail-yk0-f176.google.com with SMTP id q200so2700029ykb.7
        for <linux-input@vger.kernel.org>; Mon, 22 Dec 2014 17:22:17 -0800 (PST)
In-Reply-To: <20141222172622.GA18556@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, "anshul.g@samsung.com" <anshul.g@samsung.com>

Dear Mr Dmitry ,

Thanks for the reply.

I understand that if some handler grabs the input device then all
events will sent
to that handler only.

My Concern is If No one has grabbed the input device then all events
should go to
all handlers after application of all filter handlers.

For example : If 5 handlers registered for the input device.
Now among these 5 handlers 2 are filter handlers and remaining 3 are regular
input handlers.

In this case as per current implementation we pass the events array to
each handler.
Handler does its filtering then sent to handler.

What i am proposing is first we have to pass input_value list to all
filter handlers
After filteration of events, we can send the remaining events (Some
events might be removed
after filter) to all handlers.

In case device is grabbed we will just send the events to handler
which grabbed to device.

I hope to hear from you soon.

Thanks

On Mon, Dec 22, 2014 at 10:56 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Anshul,
>
> On Mon, Dec 22, 2014 at 10:36:09PM +0530, Anshul Garg wrote:
>> In function input_pass_values in input.c file , input core sends all
>> events to each handler associated with the input device ,
>>
>> rcu_read_lock();
>>
>> handle = rcu_dereference(dev->grab);
>> if (handle) {
>> count = input_to_handler(handle, vals, count);
>> } else {
>> list_for_each_entry_rcu(handle, &dev->h_list, d_node)
>> if (handle->open)
>> count = input_to_handler(handle, vals, count);
>> }
>>
>> after this in input_to_handler function events are filtered and sent
>> to the handler.
>>
>> for (v = vals; v != vals + count; v++) {
>> if (handler->filter &&
>>    handler->filter(handle, v->type, v->code, v->value))
>> continue;
>> if (end != v)
>> *end = *v;
>> end++;
>> }
>>
>>
>>
>> But as per previous event filter mechanism all the events should be
>> parsed from all
>> handlers after that remaining events should be sent to handlers list.
>>
>> And in comments also its mentioned as
>>
>> /*
>>  * Pass event first through all filters and then, if event has not been
>>  * filtered out, through all open handles.*/
>>
>> So current approach to filter events seems to be incorrect.
>>
>> Please help to clarify my query.
>
> When you "grab" input device your handler gets exclusive access to all
> events coming form it. Neither filer handlers nor regular input handlers
> receive events from this device until you release it.
>
> So I believe it works as intended.
>
> Thanks.
>
> --
> Dmitry
