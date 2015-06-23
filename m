From: Anshul Garg <aksgarg1989@gmail.com>
Subject: Re: [PATCH] Input :Optimize input_dev_release_keys function
Date: Wed, 24 Jun 2015 01:15:27 +0530
Message-ID: <CA+HOOsjnL41yj14wNorSTHm3bYdB4kH2E_x9mRS=BWeCABbVNg@mail.gmail.com>
References: <aksgarg1989@gmail.com>
	<1435082903-41017-1-git-send-email-aksgarg1989@gmail.com>
	<20150623185720.GC40168@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37400 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932765AbbFWTp2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2015 15:45:28 -0400
Received: by igblr2 with SMTP id lr2so19461763igb.0
        for <linux-input@vger.kernel.org>; Tue, 23 Jun 2015 12:45:28 -0700 (PDT)
In-Reply-To: <20150623185720.GC40168@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, "anshul.g@samsung.com" <anshul.g@samsung.com>

Hello Mr. Dmitry,

Yes it was actually a typo.
I have tested the code with resetting "key" structure instead of "keybit".

I have resent the patch for the review.

Please check.


On Wed, Jun 24, 2015 at 12:27 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Jun 23, 2015 at 11:08:23AM -0700, Anshul Garg wrote:
>> From: Anshul Garg <aksgarg1989@gmail.com>
>>
>> input_dev_release_keys : Use for_each_set_bit instead
>> of testing every bit upto KEY_MAX as it is more clean
>> and more optimized.
>>
>> input_estimate_events_per_packet : Use bitmap_weight
>> to get set bits count for EV_REL type instead of using
>> loop and also use for_each_set_bit for EV_ABS event for
>> more optimized code.
>>
>> Signed-off-by: Anshul Garg <aksgarg1989@gmail.com>
>> ---
>>  drivers/input/input.c |   28 ++++++++++------------------
>>  1 file changed, 10 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/input/input.c b/drivers/input/input.c
>> index e0b7b8e..9459f8b 100644
>> --- a/drivers/input/input.c
>> +++ b/drivers/input/input.c
>> @@ -682,12 +682,9 @@ static void input_dev_release_keys(struct input_dev *dev)
>>       int code;
>>
>>       if (is_event_supported(EV_KEY, dev->evbit, EV_MAX)) {
>> -             for (code = 0; code <= KEY_MAX; code++) {
>> -                     if (is_event_supported(code, dev->keybit, KEY_MAX) &&
>> -                         __test_and_clear_bit(code, dev->key)) {
>> -                             input_pass_event(dev, EV_KEY, code, 0);
>> -                     }
>> -             }
>> +             for_each_set_bit(code, dev->keybit, KEY_MAX)
>> +                     input_pass_event(dev, EV_KEY, code, 0);
>> +             memset(dev->keybit, 0, sizeof(dev->keybit));
>
> I do not think this will work, you are resetting wrong bitmap.
> dev->keybit represents keys the device is capable of sending while
> dev->key represents keys that are currently pressed. Once your code is
> ran you should not get any more key events.
>
> How was this tested?
>
> Thanks.
>
> --
> Dmitry
