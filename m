From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 4/5] input: wacom: Add support for the Bamboo Touch trackpad
 (rev4)
Date: Mon, 01 Nov 2010 15:43:49 +0100
Message-ID: <4CCED225.10508@euromail.se>
References: <1283607783-29388-1-git-send-email-rydberg@euromail.se>	<1283607783-29388-5-git-send-email-rydberg@euromail.se>	<AANLkTikpAfeSgCsaBWPcW7EncbW7UtLVjH=bpmmbVU-7@mail.gmail.com>	<4CB5F8B3.6010504@euromail.se> <AANLkTikcEjnWghuJGAe-JiUu2n0vfmE3vh7SzUpqK2tP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:42469 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751528Ab0KAOpS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 1 Nov 2010 10:45:18 -0400
In-Reply-To: <AANLkTikcEjnWghuJGAe-JiUu2n0vfmE3vh7SzUpqK2tP@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chris Bagwell <chris@cnpbagwell.com>, linux-input <linux-input@vger.kernel.org>, =?ISO-8859-1?Q?St=E9phane_C?= =?ISO-8859-1?Q?hatty?= <chatty@enac.fr>, Rafi Rubin <rafi@seas.upenn.edu>

On 10/29/2010 10:45 PM, Ping Cheng wrote:
[...]

>>>
>>> Why do we need an arbitrary MAX_TRACKING_ID when the device can tell
>>> us how many IDs we can have and it tracks the individual fingers for
>>> us?


The emphasis is on unique, not on arbitrary. :-)

>>> In this case, there are only two ID/fingers and the ID can be
>>> retrieved from the raw data. I must be missing something in the
>>> defintion of MAX_TRACKING_ID.
>>
>> In the language of ABS_MT, there is a distinction between slot and id. The slot
>> is the handle used to communicate a unique touch. The id is the identifier of
>> that touch. The device tells us how many slots we have. The range of ids is in
>> principle infinite. In practice, it is set to a large number.
> 
> Sorry to bring this topic back again. I was under the impression that
> I was the only one who didn't get the spec clear. The discussion at
> yesterday's UDS session made me feel I am not alone (good or bad :).
> Let me try it again to see if I can get it right this time.
> 
> From the "Multi-touch (MT) Protocol" under Documentation/input, we see
> the following:
> 
> "The slot protocol requires the use of the ABS_MT_TRACKING_ID, either
> provided by the hardware or computed from the raw data".
> 
> That means if the hardware provides the tracking ID, we use it.
> Otherwise we lose that specific information reported from the
> hardware.


The recurring question is: what information is lost?


> For the Bamboo case, the tracking ID happens to be the same as the
> slot ID we use. But, there are devices, as far as I know, report up to
> 10 fingers/touches. So, there would be 10 slots to report the data.
> But, the tracking ID we get from the devices is 0 to 255. So, slot 5
> could have a tracking ID of 123 now and 9 when tuch 123 is up and
> touch 5 is down.
> 
>> To answer a possible follow-up question: from the tracking id, you can tell if a
>> contact is present, if it is new, and if it is older than another contact.
> 
> The new and old attribute can be tracked by a time stamp in the
> userland. Kernel driver doesn't need to worry about it. Maybe I am
> missing an use case in the kernel?


The kernel is the most long-lived process, and userspace programs may be
restarted many times over during the life cycle of a single boot. What happens
when we want to restart an application monitoring a large touch table, for instance?

Regardless of what applications and needs we will see in the future, I feel the
main argument put forward so far, that hardware information must be passed on
untouched at all costs, is more political than technical, and I would very much
like to stay out of such discussions.

Thanks,
Henrik
