From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] input: ads7846: fix gpio_pendown configuration
Date: Wed, 04 May 2011 09:42:32 +0300
Message-ID: <4DC0F558.90705@compulab.co.il>
References: <1304438573-7692-1-git-send-email-grinberg@compulab.co.il> <20110503161818.GD6509@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:46544
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752619Ab1EDGme (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 4 May 2011 02:42:34 -0400
In-Reply-To: <20110503161818.GD6509@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On 05/03/11 19:18, Dmitry Torokhov wrote:

> On Tue, May 03, 2011 at 07:02:53PM +0300, Igor Grinberg wrote:
>> The pendown gpio was requested but not configured for input.
>> Request and configure it in one shot.
>>
>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> There is no significant change from the previos version of the patch by
> Sourav Poddar that I tried to apply and had to revert. Does it compile
> if !CONFIG_GENERIC_GPIO?

shout!?!? It has been just several month we had this discussion,
but I've completely forgot it took place... shame on me...

Back to business, either way, the gpio direction must be configured
before accessing the gpio.
I can propose two solutions to this:
1) ads7846 relies on gpio subsystem, so add depend on
   CONFIG_GENERIC_GPIO to Kconfig ads7846 entry.
2) just don't use gpio_request_one(),
   but gpio_request() and then gpio_direction_input().

Logic behind 1 is that platforms that don't use CONFIG_GENERIC_GPIO
most likely don't use ads7846. Anybody know of such platform?
The second one is less intrusive and more local, but will do the job.

What do you think is more preferable?

>> ---
>>  drivers/input/touchscreen/ads7846.c |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
>> index c24946f..bf067aa 100644
>> --- a/drivers/input/touchscreen/ads7846.c
>> +++ b/drivers/input/touchscreen/ads7846.c
>> @@ -956,7 +956,8 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
>>  		ts->get_pendown_state = pdata->get_pendown_state;
>>  	} else if (gpio_is_valid(pdata->gpio_pendown)) {
>>  
>> -		err = gpio_request(pdata->gpio_pendown, "ads7846_pendown");
>> +		err = gpio_request_one(pdata->gpio_pendown, GPIOF_IN,
>> +				       "ads7846_pendown");
>>  		if (err) {
>>  			dev_err(&spi->dev, "failed to request pendown GPIO%d\n",
>>  				pdata->gpio_pendown);
>> -- 
>> 1.7.3.4
>>

-- 
Regards,
Igor.

