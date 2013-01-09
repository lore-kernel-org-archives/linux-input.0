From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] Input: samsung-keypad: Remove input_unregister_device()
 call
Date: Wed, 9 Jan 2013 14:54:37 +0530
Message-ID: <CAK9yfHzu6Koa-Ex5UTXQL5j2-HYFm5cnG=h5P=fz8qYr-99M7A@mail.gmail.com>
References: <1357713829-30273-1-git-send-email-sachin.kamat@linaro.org>
	<20130109092132.GB4369@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:46546 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757510Ab3AIJYi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Jan 2013 04:24:38 -0500
Received: by mail-pa0-f43.google.com with SMTP id fb10so913422pad.30
        for <linux-input@vger.kernel.org>; Wed, 09 Jan 2013 01:24:37 -0800 (PST)
In-Reply-To: <20130109092132.GB4369@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, patches@linaro.org

On 9 January 2013 14:51, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Wed, Jan 09, 2013 at 12:13:49PM +0530, Sachin Kamat wrote:
>> Since devm_input_allocate_device() is used, explicit unregistering
>> of device is not required as it is handled by devres infrastructure.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>>  drivers/input/keyboard/samsung-keypad.c |    2 --
>>  1 files changed, 0 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
>> index 22e357b..fab8972 100644
>> --- a/drivers/input/keyboard/samsung-keypad.c
>> +++ b/drivers/input/keyboard/samsung-keypad.c
>> @@ -501,8 +501,6 @@ static int samsung_keypad_remove(struct platform_device *pdev)
>>       device_init_wakeup(&pdev->dev, 0);
>>       platform_set_drvdata(pdev, NULL);
>>
>> -     input_unregister_device(keypad->input_dev);
>> -
>>       clk_unprepare(keypad->clk);
>>
>
> No, don't you see clk_unprepare() call? The device must be unregistered
> before calling clk_unprepare() to keep proper order of operations.

Sorry, my bad. I overlooked it. Thanks for noticing.

>
> Thanks.
>
> --
> Dmitry



-- 
With warm regards,
Sachin
