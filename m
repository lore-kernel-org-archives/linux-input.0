From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv2] Input: xpad - Fix double URB submission races
Date: Wed, 26 Aug 2015 10:19:17 -0700
Message-ID: <CAKdAkRTiQZ_Uor32QyBRoEv_n+VJGO5jzo7Ku0iTtXy+hQk8iw@mail.gmail.com>
References: <1439252772-28482-1-git-send-email-labbott@fedoraproject.org>
	<20150821165058.GG26302@localhost>
	<55DBED78.6060709@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34311 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198AbbHZRTS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Aug 2015 13:19:18 -0400
In-Reply-To: <55DBED78.6060709@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laura Abbott <labbott@redhat.com>
Cc: Laura Abbott <labbott@fedoraproject.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org

On Mon, Aug 24, 2015 at 9:22 PM, Laura Abbott <labbott@redhat.com> wrote:
> On 08/21/2015 09:50 AM, Dmitry Torokhov wrote:
>>
>> Hi Laura,
>>
>> On Mon, Aug 10, 2015 at 05:26:12PM -0700, Laura Abbott wrote:
>>>
>>> v2: Created a proper queue for events instead of just dropping them
>>
>>
>> How long does it take for the queue to exhaust your memory if you keep
>> bombarding the driver with requests?
>>
>
> My script which changes the LEDs as fast as possible ran for 7+ hours on
> my machine with 16GB of RAM without exhausting all of it. This is also a
> very extreme case as almost any kind of delay between sending
> commands will drain the queue.

Hmm, that means the device is able to process requests pretty fast;
I'm impressed.

>
>>
>> I do not think you need a queue. I believe the nature of LEDs and rumble
>> force feedback effect is such that you can discard all requests but the
>> latest that arrived between the moment you submitted a request to the
>> device and the moment you are ready submit a new one.
>
>
> So your suggestion is to only keep a single item in the queue?

That would not be a queue anymore, but essentially yes. Store pending
brightness and FF effect in the driver structure and simply replace it
with the latest requests until the device is ready to process next
request. You need to take care alternating serving LED vs FF requests
to make sure one does not starve another.

Thanks!

-- 
Dmitry
