From: arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH] GPIO_KEYS: If devm_add_action() fails, we are explicitly
 calling the cleanup to freethe resources allocated. Use the helper
 devm_add_action_or_reset() and return directly in case of error, since the
 cleanup function has been already called by the helper if there was any
 error.
Date: Wed, 6 Jul 2016 16:52:19 +0530
Message-ID: <577CE9EB.9060202@gmail.com>
References: <1467735500-5033-1-git-send-email-arvind.yadav.cs@gmail.com>
 <20160705170111.GO1190@tuxbot>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35526 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbcGFLWZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jul 2016 07:22:25 -0400
In-Reply-To: <20160705170111.GO1190@tuxbot>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: dmitry.torokhov@gmail.com, ldewangan@nvidia.com, linus.walleij@linaro.org, van.freenix@gmail.com, bjorn.andersson@sonymobile.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Sorry for subject. Thanks for reviewing my patch. I will take care and 
follow the standard now.

regards,
Arvind


On Tuesday 05 July 2016 10:31 PM, Bjorn Andersson wrote:
> On Tue 05 Jul 09:18 PDT 2016, Arvind Yadav wrote:
>
> Your subject line should be a short and descriptive summary, followed by
> an empty line and then potentially a longer description motivating your
> patch.  Please read section #14 of Documentation/SubmittingPatches.
>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
>>   drivers/input/keyboard/gpio_keys.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
>> index 2909365..a2fa3bb 100644
>> --- a/drivers/input/keyboard/gpio_keys.c
>> +++ b/drivers/input/keyboard/gpio_keys.c
>> @@ -542,7 +542,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>>   	 * Install custom action to cancel release timer and
>>   	 * workqueue item.
>>   	 */
>> -	error = devm_add_action(&pdev->dev, gpio_keys_quiesce_key, bdata);
>> +	error = devm_add_action_or_reset(&pdev->dev, gpio_keys_quiesce_key,
>> +					bdata);
> The code leading up to this initializes the timer and work struct, but
> they are not triggered unless their respective isr is exectued. This
> would not happen until after the request_irq at the end of the function.
>
> As such there doesn't appear to be a reason for cancelling any work or
> timers.
>
>>   	if (error) {
>>   		dev_err(&pdev->dev,
>>   			"failed to register quiesce action, error: %d\n",
> Regards,
> Bjorn

