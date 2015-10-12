From: Petri Gynther <pgynther@google.com>
Subject: Re: [PATCH] Input: improve autorepeat initialization
Date: Mon, 12 Oct 2015 11:50:21 -0700
Message-ID: <CAGXr9JFovnQLqrpXs642UwzFTz4f+n04fqN+gcUH8BErcY=Sfw@mail.gmail.com>
References: <1444425001-141384-1-git-send-email-pgynther@google.com>
	<20151010001534.GA18914@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35253 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbbJLSuW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2015 14:50:22 -0400
Received: by igbkq10 with SMTP id kq10so78752416igb.0
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2015 11:50:22 -0700 (PDT)
In-Reply-To: <20151010001534.GA18914@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi Dmitry,

On Fri, Oct 9, 2015 at 5:15 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Petri,
>
> On Fri, Oct 09, 2015 at 02:10:01PM -0700, Petri Gynther wrote:
>> Allow driver to initialize only input_dev->rep[REP_DELAY] and
>> input_dev->rep[REP_PERIOD], but then use the input timer and
>> repeat function from input.c.
>>
>> For example, a HID driver could do:
>>
>> static void xyz_input_configured(struct hid_device *hid,
>>                                  struct hid_input *hidinput)
>> {
>>         hidinput->input->rep[REP_DELAY] = 400;
>>         hidinput->input->rep[REP_PERIOD] = 100;
>> }
>>
>> static struct hid_driver xyz_driver = {
>>         .input_configured = xyz_input_configured,
>> }
>>
>
> This will break drivers that either support hardware autorepeat (such as
> atkbd) or ones that implement autorepeat themselves. If you want support
> "starting" repeat rate/delay as you are proposing we need alternative
> way of telling input core whether it should engage generic autorepeat
> code or not. Maybe we should simply add a "softrepeat" flag in input_dev
> structure and call it day.
>
> Thanks.
>

Thanks for pointing this out. I'll add softrepeat flag to input_dev.
Sending patch v2 shortly.

>> Signed-off-by: Petri Gynther <pgynther@google.com>
>> ---
>>  drivers/input/input.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/input/input.c b/drivers/input/input.c
>> index 5391abd..1984ba5 100644
>> --- a/drivers/input/input.c
>> +++ b/drivers/input/input.c
>> @@ -2115,6 +2115,15 @@ int input_register_device(struct input_dev *dev)
>>               dev->rep[REP_PERIOD] = 33;
>>       }
>>
>> +     /*
>> +      * If the driver didn't initialize the timer data and function, then
>> +      * handle the autorepeating here in input.c.
>> +      */
>> +     if (!dev->timer.data && !dev->timer.function) {
>> +             dev->timer.data = (unsigned long) dev;
>> +             dev->timer.function = input_repeat_key;
>> +     }
>> +
>>       if (!dev->getkeycode)
>>               dev->getkeycode = input_default_getkeycode;
>>
>> --
>> 2.6.0.rc2.230.g3dd15c0
>>
>
> --
> Dmitry
