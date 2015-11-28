From: Jonathan Beilharz <greenbigfrog@gmail.com>
Subject: Re: X-Box one controller causes Xpad to crash [NEW INFO]
Date: Sat, 28 Nov 2015 17:35:29 +0100
Message-ID: <5659D7D1.8090701@gmail.com>
References: <56588978.9030300@gmail.com> <20151127173436.GB27040@dtor-ws>
 <5658971E.4040703@gmail.com> <20151127180809.GD27040@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34724 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322AbbK1Qfd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Nov 2015 11:35:33 -0500
Received: by wmvv187 with SMTP id v187so104052775wmv.1
        for <linux-input@vger.kernel.org>; Sat, 28 Nov 2015 08:35:32 -0800 (PST)
In-Reply-To: <20151127180809.GD27040@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: pavel@rojtberg.net, linux-input@vger.kernel.org

On 27.11.2015 19:08, Dmitry Torokhov wrote:
> On Fri, Nov 27, 2015 at 06:47:10PM +0100, Jonathan Beilharz wrote:
>> On 27.11.2015 18:34, Dmitry Torokhov wrote:
>>> Hi Jonathan,
>>>
>>> On Fri, Nov 27, 2015 at 05:48:56PM +0100, Jonathan Beilharz wrote:
>>>> Still haven't got it on the mailing list... Also can't find any info
>>>> on how to add new stuff. I already had sent an email sometime ago
>>>> but since then I found out more.
>>> Hmm, not sure why your email do not reach the list, it does not require
>>> subscription for posting...
>>>
>>>> [1.] One line summary of the problem:
>>>> X-Box one controller causes Xpad to crash
>>>>
>>>> [2.] Full description of the problem/report:
>>>> Plugging in the so called "Xbox one (converted forces)" controller
>>>> crashes the Xpad module.
>>>> Important part of dmesg:
>>>> "BUG: unable to handle kernel NULL pointer dereference at 000000000000004e"
>>>> "RIP  [<ffffffffc02c952a>] xpad_probe+0x37a/0x9eb [xpad]"
>>>>
>>> You need the following commit from mainline:
>>>
>>> 39a7a88872df98f0c3c50fe278fd1a1f597afd95  - Input: xpad - add Covert
>>> Forces edition of the Xbox One controller
>>>
>>> There was a report that while it fixes the crash the controller is not
>>> really working, so I'd like to hear about your results.
>>>
>>> Thanks.
>>>
>> Thanks for answering.
>>
>> But shouldn't the commit be included in the "Linux version
>> 4.3.0-040300-generic (kernel@gomeisa) (gcc version 5.2.1 20151010
>> (Ubuntu 5.2.1-22ubuntu2) ) #201511020949 SMP Mon Nov 2 14:50:44 UTC
>> 2015" I tested with?
> No, it was in the pull request I sent for 4.4-rc1.
>
>> If not should I build the latest mainline kernel?
> That would be great.
>
> Thanks.
>

So I now was able to boot the new kernel fully (also onto desktop).

The patch fixes the crash and also the module gets successfully loaded 
dynamically.

But as you said earlier it isn't "working". jscal/jstest tell me the 
right amount of axes and buttons. But it doesn't matter if I calibrate 
the controller or not. Everything stays the same. I can move everything 
as much as I want but nothing changes in jstest.

Thanks for looking into this.
