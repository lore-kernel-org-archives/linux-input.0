From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH 2/2] skip all blobs that are not touches
Date: Sat, 15 Jul 2017 08:13:15 +1000
Message-ID: <b0a7f255-50a3-7002-8ee4-259616a9e978@who-t.net>
References: <1499626491-22592-1-git-send-email-floe@butterbrot.org>
 <1499626491-22592-2-git-send-email-floe@butterbrot.org>
 <20170709214105.GE21945@dtor-ws>
 <ebe3ea9a-d79c-8fbc-db96-adb878a53848@butterbrot.org>
 <20170710181120.GC23984@dtor-ws>
 <alpine.DEB.2.10.1707140951540.18874@butterbrot>
 <20170714082406.GA29703@jelly>
 <7f9ca984-2798-b3f1-f61a-ac80e5b055b9@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:64232 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbdGNWNd (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 14 Jul 2017 18:13:33 -0400
In-Reply-To: <7f9ca984-2798-b3f1-f61a-ac80e5b055b9@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, "modin@yuri.at" <modin@yuri.at>

On 14/07/2017 19:28 , Florian Echtler wrote:
> On 14.07.2017 10:24, Peter Hutterer wrote:
>> On Fri, Jul 14, 2017 at 09:54:03AM +0200, Florian Echtler wrote:
>>> On Mon, 10 Jul 2017, Dmitry Torokhov wrote:
>>>> On Mon, Jul 10, 2017 at 09:11:53AM +0200, Florian Echtler wrote:
>>>>>
>>>>> Related question: we first attempted to label non-touch objects as MT_TOOL_PALM,
>>>>> but it looks like userspace (Xorg in particular) doesn't actually distinguish
>>>>> between MT_TOOL_* types; is that correct?
>>>>
>>>> It really should, but I think Peter never got around implementing this.
>>>>
>>>> Also, I think it is a good idea to set touch major to max in this case.
>>>> I believe that that will help clients that do no understand MT_TOOL_PALM
>>>> to still do palm rejection.
>>>>
>>>> Peter?
>>>
>>> Would you consider merging v2 of the patch regardless of the Xorg situation?
>>> Right now, it's a useful bugfix in any case, and we can deal with how to
>>> represent blobs/palms/tokens later on.
>>
>> sorry about the delay, bit chaotic here. libinput 1.8 was released a week or
>> so ago and it supports MT_TOOL_PALM, so consider userspace ready for that. I
>> also have patches to use major/minor for palm detection where appropriate
>> which will hit git master (my) tonight.
>
> Nevermind :-) Just to clarify, I can now set MT_TOOL_PALM on generic blob
> objects, and they will still be available in userspace "on request", but will
> not be considered as touch points?
>
> Do you know how "legacy" xserver-xorg-input-evdev will handle this case?

sorry, I just went back to read the whole thread and realised this is a 
touchscreen, not a touchpad. Short answer: we don't have tool type 
handling in touchscreens because no-one asked for it yet. I can probably 
get this done by the end of next week. File a bug against libinput and 
assign it to me please.

That's for libinput. evdev is in maintenance mode, it may be possible to 
add that bit but it largely depends on when the tool type is set. If 
it's set in the first event already that's trivial to add (I think).

> And final question: the SUR40 also is able to identify specific patterns as
> tokens (so-called "bytetags", see
> https://github.com/floe/surface-2.0/blob/master/bytetag/bytetag.pdf ). What
> would be a sensible way to expose these to userspace, too? Add another
> MT_TOOL_TOKEN type?

You'd have to add one for each token here, but that may not be too bad, 
beyond adding a lot of #defines. The tool type is the value field, so we 
have 32 bits before we run out. 64 tokens won't make a dent there. Maybe 
use MT_TOKEN_MIN and MT_TOKEN_MAX to keep the defines in check, though 
I'd recommend considering more specific naming and lots of documentation 
to detail what the tokens stand for. And consider whether we want to use 
something overly specific, userspace won't be happy if we have thirty 
different vendor-specific token ranges.

Cheers,
   Peter

