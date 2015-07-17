From: Anshul Garg <aksgarg1989@gmail.com>
Subject: Re: [PATCH] Input-polldev:Check poll_interval range while registering
 input device
Date: Fri, 17 Jul 2015 19:11:04 +0530
Message-ID: <CA+HOOsjQ9=dVvet0bZ9uToVHGMXg26w6vBpDtFH4vjcX8nbpgA@mail.gmail.com>
References: <aksgarg1989@gmail.com>
	<1437069433-76366-1-git-send-email-aksgarg1989@gmail.com>
	<20150716193510.GE32571@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:32968 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756982AbbGQNlG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jul 2015 09:41:06 -0400
Received: by qkdl129 with SMTP id l129so69742169qkd.0
        for <linux-input@vger.kernel.org>; Fri, 17 Jul 2015 06:41:04 -0700 (PDT)
In-Reply-To: <20150716193510.GE32571@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Mr. Dmitry
,



On Fri, Jul 17, 2015 at 1:05 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Anshul,
>
> On Thu, Jul 16, 2015 at 10:57:13AM -0700, Anshul Garg wrote:
>> Added check for poll_interval range in input_register_polled_device
>> function similar to input_polldev_set_poll function.
>>
>> Signed-off-by: Anshul Garg <aksgarg1989@gmail.com>
>> ---
>>  drivers/input/input-polldev.c |    6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/input/input-polldev.c b/drivers/input/input-polldev.c
>> index 3664f81..0e88a9e 100644
>> --- a/drivers/input/input-polldev.c
>> +++ b/drivers/input/input-polldev.c
>> @@ -309,6 +309,12 @@ int input_register_polled_device(struct input_polled_dev *dev)
>>
>>       input_set_drvdata(input, dev);
>>       INIT_DELAYED_WORK(&dev->work, input_polled_device_work);
>> +
>> +     if (dev->poll_interval > dev->poll_interval_max ||
>> +                     dev->poll_interval < dev->poll_interval_min) {
>> +             pr_err("Poll interval Range incorrect\n");
>> +             return -EINVAL;
>> +     }
>
> What driver was this change tested with?
I have not checked this change for any driver.

This check is useful if some input driver is setting outofrange
poll_interval value
i.e. not in range between min,max. Similar to input_polldev_set_poll
which does this
when user space tries to change poll interval

Thanks
Anshul Garg
>
> Thanks.
>
> --
> Dmitry
