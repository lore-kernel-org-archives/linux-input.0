From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] Input: mms114: Use devm_* APIs
Date: Tue, 8 Jan 2013 17:08:12 +0530
Message-ID: <CAK9yfHyAnb02mBGVJuaJ9YZdKZox6vqwE0pNEmxRdAhUOOn0Fw@mail.gmail.com>
References: <1357639508-15645-1-git-send-email-sachin.kamat@linaro.org>
	<50EBFE23.7070401@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:34572 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754171Ab3AHLiN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Jan 2013 06:38:13 -0500
Received: by mail-ob0-f178.google.com with SMTP id eh20so251787obb.9
        for <linux-input@vger.kernel.org>; Tue, 08 Jan 2013 03:38:13 -0800 (PST)
In-Reply-To: <50EBFE23.7070401@nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "patches@linaro.org" <patche@linaro.org>, Joonyoung Shim <jy0922.shim@samsung.com>

Hi Laxman,

Thank you for your suggestion.

On 8 January 2013 16:38, Laxman Dewangan <ldewangan@nvidia.com> wrote:
> On Tuesday 08 January 2013 03:35 PM, Sachin Kamat wrote:
>>
>> devm_* APIs are device managed and make the exit and clean up code
>> simpler.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
>> ---
>> Compile tested against linux-next tree (20130108).
>> ---
>>   drivers/input/touchscreen/mms114.c |   41
>> +++++++++++------------------------
>>   1 files changed, 13 insertions(+), 28 deletions(-)
>
>
>>   static int mms114_remove(struct i2c_client *client)
>>   {
>>         struct mms114_data *data = i2c_get_clientdata(client);
>>   -     free_irq(client->irq, data);
>> -       regulator_put(data->io_reg);
>> -       regulator_put(data->core_reg);
>>         input_unregister_device(data->input_dev);
>
>
> Because you are using devm_input_allocate_device() for allocating input
> device, you need not to have the input_unregister_device() and so you can
> get rid of remove() callback at all.
> This is what I learnt from Dmitry on similar patch for Tegra KBC.

input_free_device() is the one which is not required when you use
devm_input_allocate_device().
Unregister call, AFAIK, is required since we are registering using
input_register_device().

Dmitry, please let me know if my understanding is right.

>
> Thanks,
> Laxman




-- 
With warm regards,
Sachin
