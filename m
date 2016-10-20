From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Input: gpio_keys_polled - always use
 gpiod_get_value_cansleep
Date: Thu, 20 Oct 2016 11:00:03 +0200
Message-ID: <d6b25397-8c90-d40d-c60c-0087f30b7c03@redhat.com>
References: <20161019234107.GA2927@dtor-ws> <20161019234332.GA15459@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:4365 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751594AbcJTJAI (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 20 Oct 2016 05:00:08 -0400
In-Reply-To: <20161019234332.GA15459@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Aaron Lu <aaron.lu@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>

Hi,

On 20-10-16 01:43, Dmitry Torokhov wrote:
> On Wed, Oct 19, 2016 at 04:41:07PM -0700, Dmitry Torokhov wrote:
>> It does not matter if given GPIO may sleep or not when reading state,
>> polling is always done in a non-atomic context, so we should always
>> be able to simply use gpiod_get_value_cansleep().
>>
>> Also let's note in the logs when we fail to read gpio state.
>>
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> ---
>>  drivers/input/keyboard/gpio_keys_polled.c | 21 ++++++++++-----------
>>  1 file changed, 10 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
>> index daef8ea..3c79158 100644
>> --- a/drivers/input/keyboard/gpio_keys_polled.c
>> +++ b/drivers/input/keyboard/gpio_keys_polled.c
>> @@ -34,7 +34,6 @@ struct gpio_keys_button_data {
>>  	int last_state;
>>  	int count;
>>  	int threshold;
>> -	int can_sleep;
>>  };
>>
>>  struct gpio_keys_polled_dev {
>> @@ -76,16 +75,17 @@ static void gpio_keys_polled_check_state(struct input_polled_dev *dev,
>>  {
>>  	int state;
>>
>> -	if (bdata->can_sleep)
>> -		state = !!gpiod_get_value_cansleep(bdata->gpiod);
>> -	else
>> -		state = !!gpiod_get_value(bdata->gpiod);
>> -
>> -	gpio_keys_button_event(dev, button, state);
>> +	state = gpiod_get_value_cansleep(bdata->gpiod);
>> +	if (unlikely(state < 0)) {
>> +		dev_err(input->dev.parent,
>
> Umm, this should have been dev->input->dev.parent

With that fixed this patch looks good to me and is:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


>
>> +			"failed to get gpio state: %d\n", state);
>> +	} else {
>> +		gpio_keys_button_event(dev, button, state);
>>
>> -	if (state != bdata->last_state) {
>> -		bdata->count = 0;
>> -		bdata->last_state = state;
>> +		if (state != bdata->last_state) {
>> +			bdata->count = 0;
>> +			bdata->last_state = state;
>> +		}
>>  	}
>>  }
>>
>> @@ -341,7 +341,6 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
>>  			}
>>  		}
>>
>> -		bdata->can_sleep = gpiod_cansleep(bdata->gpiod);
>>  		bdata->last_state = -1;
>>  		bdata->threshold = DIV_ROUND_UP(button->debounce_interval,
>>  						pdata->poll_interval);
>> --
>> 2.8.0.rc3.226.g39d4020
>>
>>
>> --
>> Dmitry
>
