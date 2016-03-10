From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH] Input: Do not add SYN_REPORT in between a single packet
 data
Date: Thu, 10 Mar 2016 14:45:23 +0100
Message-ID: <56E17A73.8090901@bitmath.org>
References: <1457372672-884-1-git-send-email-a.mathur@samsung.com>
 <CAKdAkRQT0R6peS8iO8PhQ4YoPMowt6voZJez4EubK7R0ZV_m4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailrelay7.public.one.com ([91.198.169.215]:44809 "EHLO
	mailrelay7.public.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbcCJNpR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Mar 2016 08:45:17 -0500
In-Reply-To: <CAKdAkRQT0R6peS8iO8PhQ4YoPMowt6voZJez4EubK7R0ZV_m4Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aniroop Mathur <a.mathur@samsung.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Aniroop Mathur <aniroop.mathur@gmail.com>

Hi Dmitry,

>> diff --git a/drivers/input/input.c b/drivers/input/input.c
>> index 8806059..262ef77 100644
>> --- a/drivers/input/input.c
>> +++ b/drivers/input/input.c
>> @@ -401,8 +401,7 @@ static void input_handle_event(struct input_dev *dev,
>>                 if (dev->num_vals >= 2)
>>                         input_pass_values(dev, dev->vals, dev->num_vals);
>>                 dev->num_vals = 0;
>> -       } else if (dev->num_vals >= dev->max_vals - 2) {
>> -               dev->vals[dev->num_vals++] = input_value_sync;
>> +       } else if (dev->num_vals >= dev->max_vals - 1) {
>>                 input_pass_values(dev, dev->vals, dev->num_vals);
>>                 dev->num_vals = 0;
>>         }
> 
> This makes sense to me. Henrik?

I went through the commits that made these changes, and I cannot see any strong
reason to keep it. However, this code path only triggers if no SYN events are
seen, as in a driver that fails to emit them and consequently fills up the
buffer. In other words, this change would only affect a device that is already,
to some degree, broken.

So, the question to Aniroop is: do you see this problem in practise, and in that
case, for what driver?

Henrik

