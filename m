From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [PATCH] input: replace request_irq by request_any_context_irq
 in keyboard GPIO driver
Date: Thu, 20 Jan 2011 13:30:31 +0530
Message-ID: <4D37EB9F.4040103@codeaurora.org>
References: <1294825292-24134-1-git-send-email-philippe.langlais@stericsson.com> <1294825292-24134-2-git-send-email-philippe.langlais@stericsson.com> <20110120075348.GE30522@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:15165 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385Ab1ATIAg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Jan 2011 03:00:36 -0500
In-Reply-To: <20110120075348.GE30522@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Philippe Langlais <philippe.langlais@stericsson.com>, linux-input@vger.kernel.org, STEricsson_nomadik_linux@list.st.com

Hi Dmitry,

On 1/20/2011 1:23 PM, Dmitry Torokhov wrote:
> Hi Philippe,
> 
> On Wed, Jan 12, 2011 at 10:41:32AM +0100, Philippe Langlais wrote:
>> Signed-off-by: Philippe Langlais <philippe.langlais@stericsson.com>
>> ---
>>  drivers/input/keyboard/gpio_keys.c |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
>> index 6069abe..eb30063 100644
>> --- a/drivers/input/keyboard/gpio_keys.c
>> +++ b/drivers/input/keyboard/gpio_keys.c
>> @@ -322,7 +322,7 @@ static void gpio_keys_report_event(struct gpio_button_data *bdata)
>>  	struct gpio_keys_button *button = bdata->button;
>>  	struct input_dev *input = bdata->input;
>>  	unsigned int type = button->type ?: EV_KEY;
>> -	int state = (gpio_get_value(button->gpio) ? 1 : 0) ^ button->active_low;
>> +	int state = (gpio_get_value_cansleep(button->gpio) ? 1 : 0) ^ button->active_low;
>>  
>>  	input_event(input, type, button->code, !!state);
>>  	input_sync(input);
>> @@ -410,8 +410,8 @@ static int __devinit gpio_keys_setup_key(struct platform_device *pdev,
>>  	if (!button->can_disable)
>>  		irqflags |= IRQF_SHARED;
>>  
>> -	error = request_irq(irq, gpio_keys_isr, irqflags, desc, bdata);
>> -	if (error) {
>> +	error = request_any_context_irq(irq, gpio_keys_isr, irqflags, desc, bdata);
>> +	if (error < 0) {
> 
> No, this it not correct. request_any_context_irq() means that you could
> either get a hardirq or a treaded one. However above you are changing to
> gpio_get_value_cansleep() which indicates that you can sleep.
> 
> You need to either revert to gpio_get_value() or explicitly request
> threaded IRQ.

This could be problem. Say, we are doing request_any_context_irq(..) and gpio is over slow-bus,
so we naturally get into the threaded code, and in the thread handler we are calling gpio_get_value(..),
but in this case gpio_get_value could throw a warning that we should call gpio_get_value_cansleep(...)
because sleep attribute is added into the gpiolib hook implementation for these gpios.

Now suppose gpio is memory mapped and we enter into the hardirq and calling sleep variant into the 
handler code will be naturally bad. 

How about checking maysleep explicitly here while using the request_any_context_irq() call though
the semantics of gpiolib framework discourages that. 

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
