From: Anshul Garg <aksgarg1989@gmail.com>
Subject: Re: [Question : drivers/input ] Fixing Event Filter Mechanism in
 input subsystem
Date: Thu, 25 Dec 2014 11:11:06 +0530
Message-ID: <CA+HOOsg+U6yS4sAsgD_vZ-OGkTuzdKf2Qmg8hcyXkyFbY3WJPQ@mail.gmail.com>
References: <CA+HOOsgL_fY=Wc+ciDAuk485d=uTn=YTgVGVDJ5Qk3UsqQ8zVA@mail.gmail.com>
	<20141222172622.GA18556@dtor-ws>
	<CA+HOOsgDm-ZGycDwdzw3SvbscUefp7xcD-ikFSF2heouHMhS4g@mail.gmail.com>
	<20141224182511.GA21956@dtor-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yh0-f46.google.com ([209.85.213.46]:56388 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbaLYFlH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Dec 2014 00:41:07 -0500
Received: by mail-yh0-f46.google.com with SMTP id t59so4448727yho.33
        for <linux-input@vger.kernel.org>; Wed, 24 Dec 2014 21:41:06 -0800 (PST)
In-Reply-To: <20141224182511.GA21956@dtor-glaptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, "anshul.g@samsung.com" <anshul.g@samsung.com>

Dear Mr Dmitry ,

Thanks a lot for the clarification.

I was in assumption that one handler can support both ->filter() and
->event[s]()
Callback.So that's why i have prepared the patch to first do the
filter then pass
the events.

Can you please tell me why current implementation doesn't expect handler can
have both callbacks?

I think input core should be generic to allow any type of handlers which can
support both filter and events callbacks.

Please help to answer above query as my patch is based on this pre-assumption
that one handler can support both callbacks .

If we really need to have support of such handlers in input core then
only my patch
is good.

Hope to hear from you soon :)

Thanks

Anshul Garg

On Wed, Dec 24, 2014 at 11:55 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Anshul,
>
> On Tue, Dec 23, 2014 at 08:04:45PM +0530, Anshul Garg wrote:
>> Dear Mr Dmitry ,
>>
>> Thanks for the reply.
>>
>> I understand that if some handler grabs the input device then all
>> events will sent to that handler only.
>>
>> My Concern is If No handler has grabbed the input device then all events
>> should go to all handlers after application of all filter handlers on
>> input event
>> list ( As we have to check for each event whether that event can be filtered
>> or not).
>>
>> For example : If 5 handlers registered for the input device and input device is
>> not grabbed.
>> Now among these 5 handlers 2 are filter handlers and remaining 3 are regular
>> input handlers.
>> So we have to filter the event list first after applying 2 filters
>> then send the remaining
>> events to all registered handler.
>>
>> In this case as per current implementation we pass the events array to
>> each handler. Input Core does events filtering fr handler then send remaining
>> events to handler.
>>
>> What i am proposing is first we have to pass input_value list to all
>> filter handlers
>> After filteration of events, we can send the remaining events (Some
>> events might be removed after applying filter) to all handlers.
>
> As far as I can see that is exactly what happens: we first pass the even list
> to filters, which may cause the list to contract - see input_to_handler() - and
> then to regular handlers.
>
> I think the tricky part is the fact that we deliberately put filters in the
> head of the dev->h_list, and normal handlers are put in the tail. And we also
> expect the input_handler to either implement ->filter() or ->event[s]()
> callback, but not both.
>
> In case I still misunderstand what the issue you are trying to point out -
> please do post your patch and we can discuss the code.
>
> Thanks!
>
> --
> Dmitry
