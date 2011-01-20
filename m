From: Philippe Langlais <philippe.langlais@stericsson.com>
Subject: Re: [PATCH] input: replace request_irq by request_any_context_irq
 in keyboard GPIO driver
Date: Thu, 20 Jan 2011 13:14:50 +0100
Message-ID: <4D38273A.4020602@stericsson.com>
References: <1294825292-24134-1-git-send-email-philippe.langlais@stericsson.com> <1294825292-24134-2-git-send-email-philippe.langlais@stericsson.com> <20110120075348.GE30522@core.coreip.homeip.net> <20110120092330.GA1316@bnru05.bnr.st.com> <20110120100419.GA3515@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127]:50412 "EHLO
	eu1sys200aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755455Ab1ATMRU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Jan 2011 07:17:20 -0500
In-Reply-To: <20110120100419.GA3515@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rabin VINCENT <rabin.vincent@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Trilok Soni <tsoni@codeaurora.org>, "lee.jones@linaro.org" <lee.jones@linaro.org>

Dmitry,

Sorry, I arrive after the war, thanks Rabin for your answer.
When can I hope this patch merged in kernel?

Philippe

On 01/20/11 11:04, Dmitry Torokhov wrote:
> On Thu, Jan 20, 2011 at 02:53:30PM +0530, Rabin Vincent wrote:
>> On Thu, Jan 20, 2011 at 08:53:48 +0100, Dmitry Torokhov wrote:
>>> On Wed, Jan 12, 2011 at 10:41:32AM +0100, Philippe Langlais wrote:
>>>> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
>>>> index 6069abe..eb30063 100644
>>>> --- a/drivers/input/keyboard/gpio_keys.c
>>>> +++ b/drivers/input/keyboard/gpio_keys.c
>>>> @@ -322,7 +322,7 @@ static void gpio_keys_report_event(struct gpio_button_data *bdata)
>>>>   	struct gpio_keys_button *button = bdata->button;
>>>>   	struct input_dev *input = bdata->input;
>>>>   	unsigned int type = button->type ?: EV_KEY;
>>>> -	int state = (gpio_get_value(button->gpio) ? 1 : 0) ^ button->active_low;
>>>> +	int state = (gpio_get_value_cansleep(button->gpio) ? 1 : 0) ^ button->active_low;
>>>>
>>>>   	input_event(input, type, button->code, !!state);
>>>>   	input_sync(input);
>>>> @@ -410,8 +410,8 @@ static int __devinit gpio_keys_setup_key(struct platform_device *pdev,
>>>>   	if (!button->can_disable)
>>>>   		irqflags |= IRQF_SHARED;
>>>>
>>>> -	error = request_irq(irq, gpio_keys_isr, irqflags, desc, bdata);
>>>> -	if (error) {
>>>> +	error = request_any_context_irq(irq, gpio_keys_isr, irqflags, desc, bdata);
>>>> +	if (error<  0) {
>>> No, this it not correct. request_any_context_irq() means that you could
>>> either get a hardirq or a treaded one. However above you are changing to
>>> gpio_get_value_cansleep() which indicates that you can sleep.
>> Note that gpio_get_value_cansleep() is not being called from the interrupt
>> handler (threaded or not), but from a work queue.
>>
> Ah, then everything is good, sorry about the noise.
>
