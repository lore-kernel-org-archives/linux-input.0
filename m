From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Question : drivers/input ] Fixing Event Filter Mechanism in
 input subsystem
Date: Wed, 24 Dec 2014 10:25:11 -0800
Message-ID: <20141224182511.GA21956@dtor-glaptop>
References: <CA+HOOsgL_fY=Wc+ciDAuk485d=uTn=YTgVGVDJ5Qk3UsqQ8zVA@mail.gmail.com>
 <20141222172622.GA18556@dtor-ws>
 <CA+HOOsgDm-ZGycDwdzw3SvbscUefp7xcD-ikFSF2heouHMhS4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:37257 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbaLXSZQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Dec 2014 13:25:16 -0500
Received: by mail-pa0-f53.google.com with SMTP id kq14so10267247pab.26
        for <linux-input@vger.kernel.org>; Wed, 24 Dec 2014 10:25:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+HOOsgDm-ZGycDwdzw3SvbscUefp7xcD-ikFSF2heouHMhS4g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anshul Garg <aksgarg1989@gmail.com>
Cc: linux-input@vger.kernel.org, "anshul.g@samsung.com" <anshul.g@samsung.com>

Hi Anshul,

On Tue, Dec 23, 2014 at 08:04:45PM +0530, Anshul Garg wrote:
> Dear Mr Dmitry ,
> 
> Thanks for the reply.
> 
> I understand that if some handler grabs the input device then all
> events will sent to that handler only.
> 
> My Concern is If No handler has grabbed the input device then all events
> should go to all handlers after application of all filter handlers on
> input event
> list ( As we have to check for each event whether that event can be filtered
> or not).
> 
> For example : If 5 handlers registered for the input device and input device is
> not grabbed.
> Now among these 5 handlers 2 are filter handlers and remaining 3 are regular
> input handlers.
> So we have to filter the event list first after applying 2 filters
> then send the remaining
> events to all registered handler.
> 
> In this case as per current implementation we pass the events array to
> each handler. Input Core does events filtering fr handler then send remaining
> events to handler.
> 
> What i am proposing is first we have to pass input_value list to all
> filter handlers
> After filteration of events, we can send the remaining events (Some
> events might be removed after applying filter) to all handlers.

As far as I can see that is exactly what happens: we first pass the even list
to filters, which may cause the list to contract - see input_to_handler() - and
then to regular handlers.

I think the tricky part is the fact that we deliberately put filters in the
head of the dev->h_list, and normal handlers are put in the tail. And we also
expect the input_handler to either implement ->filter() or ->event[s]()
callback, but not both.

In case I still misunderstand what the issue you are trying to point out -
please do post your patch and we can discuss the code.

Thanks! 

-- 
Dmitry
