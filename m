From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH Resend] Input: mms114: Use devm_* APIs
Date: Wed, 9 Jan 2013 12:27:51 +0530
Message-ID: <CAK9yfHzfZvMFLot2vwkh8R5Q3eMS6b2GDq6AcX2Y=3x76O1X6w@mail.gmail.com>
References: <1357704948-25758-1-git-send-email-sachin.kamat@linaro.org>
	<50ECFB4F.8010501@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:41314 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756998Ab3AIG5v (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Jan 2013 01:57:51 -0500
Received: by mail-pb0-f50.google.com with SMTP id wz7so751027pbc.37
        for <linux-input@vger.kernel.org>; Tue, 08 Jan 2013 22:57:51 -0800 (PST)
In-Reply-To: <50ECFB4F.8010501@nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "patches@linaro.org" <patches@linaro.org>, Joonyoung Shim <jy0922.shim@samsung.com>

On 9 January 2013 10:38, Laxman Dewangan <ldewangan@nvidia.com> wrote:
> On Wednesday 09 January 2013 09:45 AM, Sachin Kamat wrote:
>>
>> devm_* APIs are device managed and make the exit and clean up code
>> simpler.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
>> ---
>
>
> I think this is not resend patch, it is Patch V2. Also you can specify the
> changes done from last patch to this patch so that it will be easy to
> reviewer.

OK.

>
>
>> +       data = devm_kzalloc(&client->dev, sizeof(struct mms114_data),
>
> Because you are here, better to change the size to sizeof(*data) in place of
> sizeof(struct..)

In what way is this change useful or better?

>
>> +
>
>
>> +       error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
>> +                       mms114_interrupt, IRQF_TRIGGER_FALLING |
>> IRQF_ONESHOT,
>> +                       "mms114", data);
>
>
> Should be change to devname(&client->dev) in place of hardconding to
> "mms114".

OK.

>
>
>>         if (error) {
>>                 dev_err(&client->dev, "Failed to register interrupt\n");
>> -               goto err_io_reg;
>> +               return error;
>>         }
>>         disable_irq(client->irq);
>>         error = input_register_device(data->input_dev);
>>         if (error)
>
>
>> -
>> +               return error;
>>         return 0;
>
>
>
> Seems the code turn as
> if (error)
>    return error;
> return 0.
>
> I think simply saying return error is fine here as you are not printing any
> error.

Right.

>
>>   }
>> @@ -590,7 +567,6 @@ static struct i2c_driver mms114_driver = {
>>                 .of_match_table = of_match_ptr(mms114_dt_match),
>>         },
>>         .probe          = mms114_probe,
>> -       .remove         = mms114_remove,
>>         .id_table       = mms114_id,
>>   };
>>


I will re-send after making necessary changes.

-- 
With warm regards,
Sachin
