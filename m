From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: Re: Re: [PATCH] Input: evdev: fix queueing of SYN_DROPPED event
 for EVIOCG[type] IOCTL case
Date: Mon, 10 Apr 2017 20:10:37 +0530
Message-ID: <CADYu308UxUX4uaRUMra7WfvcADFfpCLqBiQ4fLCxDqRp35Fgcw@mail.gmail.com>
References: <1480018303-4220-1-git-send-email-a.mathur@samsung.com>
 <20170131160952epcms5p1b3a38493a1ebff1086782735dc30594a@epcms5p1>
 <CGME20170122104616epcas1p399ffe5c203d6ea28418316154dea4087@epcms5p2>
 <CANq1E4RMhJSX+HdbW66pkBXUFW=Yo162qJggY4FRfPnYB-g7wg@mail.gmail.com> <20170224113649epcms5p2bfc0a3e9b9492dbf07c010ccce15e02b@epcms5p2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33712 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753670AbdDJOkj (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Apr 2017 10:40:39 -0400
In-Reply-To: <20170224113649epcms5p2bfc0a3e9b9492dbf07c010ccce15e02b@epcms5p2>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, SAMUEL SEQUEIRA <s.samuel@samsung.com>, Rahul Mahale <r.mahale@samsung.com>, Ashish Kalra <ashish.kalra@samsung.com>, a.mathur@samsung.com

On Fri, Feb 24, 2017 at 5:06 PM, Aniroop Mathur <a.mathur@samsung.com> wrote:
>> Hi
>>
>> On Tue, Jan 31, 2017 at 5:09 PM, Aniroop Mathur <a.mathur@samsung.com> wrote:
>>> On Sun, Jan 22, 2017 at 6:45 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
>>>> On Thu, Nov 24, 2016 at 9:11 PM, Aniroop Mathur <a.mathur@samsung.com> wrote:
>>>>>                         continue;
>>>>>                 } else if (head != i) {
>>>>>                         /* move entry to fill the gap */
>>>>> @@ -151,6 +155,7 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
>>>>>         }
>>>>>
>>>>>         client->head = head;
>>>>> +       return drop_count;
>>>>>  }
>>>>>
>>>>>  static void __evdev_queue_syn_dropped(struct evdev_client *client)
>>>>> @@ -920,6 +925,7 @@ static int evdev_handle_get_val(struct evdev_client *client,
>>>>>         int ret;
>>>>>         unsigned long *mem;
>>>>>         size_t len;
>>>>> +       unsigned int drop_count = 0;
>>>>>
>>>>>         len = BITS_TO_LONGS(maxbit) * sizeof(unsigned long);
>>>>>         mem = kmalloc(len, GFP_KERNEL);
>>>>> @@ -933,12 +939,12 @@ static int evdev_handle_get_val(struct evdev_client *client,
>>>>>
>>>>>         spin_unlock(&dev->event_lock);
>>>>>
>>>>> -       __evdev_flush_queue(client, type);
>>>>> +       drop_count = __evdev_flush_queue(client, type);
>>>>>
>>>>>         spin_unlock_irq(&client->buffer_lock);
>>>>>
>>>>>         ret = bits_to_user(mem, maxbit, maxlen, p, compat);
>>>>> -       if (ret < 0)
>>>>> +       if (ret < 0 && drop_count > 0)
>>>>>                 evdev_queue_syn_dropped(client);
>>>>
>>>> I don't see the point. If bits_to_user() fails, you get EFAULT.
>>>> User-space cannot assume anything is still valid if they get EFAULT.
>>>> This is not like ENOMEM or other errors that you can recover from.
>>>> EFAULT means _programming_ error, not runtime exception.
>>>>
>>>> IOW, EFAULT is special nearly everywhere in the kernel. Usually,
>>>> whenever a syscall returns an error, you can rely on it to not have
>>>> modified state. EFAULT is an exception on most paths, since it might
>>>> occur when copying over results, and it is overly expensive to handle
>>>> EFAULT gracefully there (you'd have to copy _results_ to user-space,
>>>> before making them visible to the system).
>>>>
>>>> Long story short: I don't see the point in this patch. This path is
>>>> *never* triggered, except if your client is buggy. And even if you
>>>> trigger it, placing SYN_DROPPED in the queue does no harm at all.
>>>>
>>>> Care to elaborate why exactly you want this modification?
>>>> David
>>>>
>>>
>>> Sure, I will elaborate for you.
>>> Basically, the bug is that if the last event dropped in the queue is
>>> EV_SYN/SYN_REPORT and next event inserted is EV_SYN/SYN_DROPPED, then the
>>> userspace client will ignore the next complete event packet as per rule
>>> defined in the document although the client should not ignore the events
>>> until EV_SYN/SYN_REPORT because the events for this case are not partial
>>> events but the full packet indeed. So we need to make sure whenever this
>>> happens we immediately insert another EV_SYN/SYN_REPORT after EV_SYN/DROPPED
>>> event so that client do not ignore the next full packet.
>>> I already fixed this bug and you can see the patch here (not submitted yet)
>>> https://patchwork.kernel.org/patch/9362233/
>>>
>>> For this patch, we had no problem with the case of kernel buffer overrun and
>>> also had no problem for the case of clock change request, but only had problem
>>> for the case of EVIOCG ioctl call which I have already explained in this patch
>>> description.
>>> In short, if we insert SYN_DROPPED event wrongly then client will ignore
>>> events until SYN_REPORT event which we do not want to happen. So that is
>>> why I want this modification in order to have correct insertion of
>>> SYN_DROPPED event and hence go ahead with another patch I mentioned above.
>>
>> Fair enough. A SYN_DROPPED should be followed by a SYN_REPORT. The
>> normal insertion path guarantees that (since it keeps the last event
>> alive), the other 2 fake SYN_DROPPED insertions don't. But...
>>
>
> the other 2?
> Anyways, only problematic case for SYN_DROPPED event was EVIOCG[*] ioctl,
> for which you mentioned below that it is completely fine to not add
> SYN_DROPPED event when EFAULT occurs which seems good to me too, so I
> think this case is resolved.
>
> Thank you for checking this issue and reviewing the patch!
>
>>> Next, you have also mentioned that this path is never triggered which I am not
>>> sure of. However, if this path is never triggered then it is best to delete it
>>> to avoid such confusion but I dont think thats a good idea. And if this path
>>> can be triggered rarely (even once) which I believe it can like in case of buggy
>>> client you mentioned or in case of bit flip or for any possible reason, then
>>> we need to make this modification.
>>
>> ...you seem to misunderstand when this code-path is triggered. This is
>> an EFAULT handler. So it is only triggered if user-space is buggy
>> (which the kernel *must* handle gracefully in some regard). That is,
>> your application will never ever trigger this code-path, unless you're
>> doing something wrong. But this does not imply that we can ignore this
>> scenario. The kernel must be prepared to handle buggy applications.
>>
>> However, we can of course reason about what to do in that case. The
>> original idea was that if user-space passes incorrect buffers to
>> EVIOCG* it will be unable to access the events we already flushed.
>> Hence, we queued SYN_DROPPED to make them realize that. But this seems
>> counter-intuitive. EFAULT is a hint that user-space passed wrong
>> pointers, but it is not guaranteed. We might just end up copying into
>> valid memory, and never realize that user-space passed wrong pointers.
>> Sure, this ignores that user-space could rely on EFAULT when passing
>> NULL, but that sounds overly pedantic.
>> If any user-space continues after getting EFAULT, they must recover by
>> resyncing, anyway. So the SYN_DROPPED is nothing but cosmetics.
>>
>> Long story short, I am completely fine with something like this:
>>
>

Hello Mr. Torokhov,

Could you kindly update about this request?
Thanks~

> @Mr. Dmitry Torokhov,
> If you are satisfied with the change then could you please apply
> this patch and another patch? (may together as a single patch)
>
> Another patch: https://patchwork.kernel.org/patch/9362233/
> (fix bug of dropping valid packet after syn_dropped event)
>
> --
> Aniroop Mathur
>
>> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
>> index e9ae3d500a55..28bac2df2982 100644
>> --- a/drivers/input/evdev.c
>> +++ b/drivers/input/evdev.c
>> @@ -179,15 +179,6 @@
>>         }
>>  }
>>
>> -static void evdev_queue_syn_dropped(struct evdev_client *client)
>> -{
>> -       unsigned long flags;
>> -
>> -       spin_lock_irqsave(&client->buffer_lock, flags);
>> -       __evdev_queue_syn_dropped(client);
>> -       spin_unlock_irqrestore(&client->buffer_lock, flags);
>> -}
>> -
>>  static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
>>  {
>>         unsigned long flags;
>> @@ -938,11 +929,7 @@
>>         spin_unlock_irq(&client->buffer_lock);
>>
>>         ret = bits_to_user(mem, maxbit, maxlen, p, compat);
>> -       if (ret < 0)
>> -               evdev_queue_syn_dropped(client);
>> -
>>         kfree(mem);
>> -
>>         return ret;
>>  }
>>
>>
