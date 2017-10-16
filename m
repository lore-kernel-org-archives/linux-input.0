From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH resend v2 1/2] Input: gpio_keys - Allow suppression of
 input events for wakeup button presses
Date: Mon, 16 Oct 2017 09:36:51 +0200
Message-ID: <20171016073651.GO865@mail.corp.redhat.com>
References: <20171011094637.6512-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751196AbdJPHhB (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 16 Oct 2017 03:37:01 -0400
Content-Disposition: inline
In-Reply-To: <20171011094637.6512-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org

Hi Hans,

On Oct 11 2017 or thereabouts, Hans de Goede wrote:
> In some cases it is undesirable for a wakeup button to send input events
> to userspace if pressed to wakeup the system (if pressed during suspend).
> 
> A typical example of this is the power-button on laptops / tablets,
> sending a KEY_POWER event to userspace when woken up with the power-button
> will cause userspace to immediately suspend the system again which is
> undesirable.
> 
> For power-buttons attached to a PMIC, or handled by e.g. ACPI, not sending
> an input event in this case is take care of by the PMIC / ACPI hardware /
> code. But in the case of a GPIO button we need to explicitly suppress the
> sending of the input event.
> 
> This commit adds support for this by adding a no_wakeup_events bool to
> struct gpio_keys_button, which platform code can set to suppress the
> input events for presses of wakeup keys during suspend.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -This is a rewrite if my "Input: gpio_keys - Do not report wake button
>  presses as evdev events" patch.
> -Instead of unconditionally ignoring presses of all wake-up buttons during
>  suspend, this rewrite makes this configurable per button
> -This version uses a timer to delay clearing the suspended flag for software
>  debouncing, rather then jiffy compare magic

Is there any particular reason to have a per button timer instead of a
global one?

> ---
>  drivers/input/keyboard/gpio_keys.c | 33 +++++++++++++++++++++++++++++++--
>  include/linux/gpio_keys.h          |  3 +++
>  2 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index e9f0ebf3267a..611b47261df4 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -38,6 +38,7 @@ struct gpio_button_data {
>  
>  	unsigned short *code;
>  
> +	struct timer_list unsuspend_timer;
>  	struct timer_list release_timer;
>  	unsigned int release_delay;	/* in msecs, for IRQ-only buttons */
>  
> @@ -371,6 +372,9 @@ static void gpio_keys_gpio_report_event(struct gpio_button_data *bdata)
>  		return;
>  	}
>  
> +	if (state && bdata->button->no_wakeup_events && bdata->suspended)
> +		return;
> +
>  	if (type == EV_ABS) {
>  		if (state)
>  			input_event(input, type, button->code, button->value);
> @@ -400,6 +404,9 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
>  	if (bdata->button->wakeup) {
>  		const struct gpio_keys_button *button = bdata->button;
>  
> +		if (bdata->button->no_wakeup_events && bdata->suspended)
> +			return IRQ_HANDLED;
> +
>  		pm_stay_awake(bdata->input->dev.parent);
>  		if (bdata->suspended  &&
>  		    (button->type == 0 || button->type == EV_KEY)) {
> @@ -445,9 +452,13 @@ static irqreturn_t gpio_keys_irq_isr(int irq, void *dev_id)
>  	spin_lock_irqsave(&bdata->lock, flags);
>  
>  	if (!bdata->key_pressed) {
> -		if (bdata->button->wakeup)
> +		if (bdata->button->wakeup) {
>  			pm_wakeup_event(bdata->input->dev.parent, 0);
>  
> +			if (bdata->button->no_wakeup_events && bdata->suspended)
> +				goto out;
> +		}
> +
>  		input_event(input, EV_KEY, *bdata->code, 1);
>  		input_sync(input);
>  
> @@ -468,6 +479,13 @@ static irqreturn_t gpio_keys_irq_isr(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static void gpio_keys_unsuspend_timer(unsigned long _data)
> +{
> +	struct gpio_button_data *bdata = (struct gpio_button_data *)_data;
> +
> +	bdata->suspended = false;
> +}
> +
>  static void gpio_keys_quiesce_key(void *data)
>  {
>  	struct gpio_button_data *bdata = data;
> @@ -476,6 +494,8 @@ static void gpio_keys_quiesce_key(void *data)
>  		cancel_delayed_work_sync(&bdata->work);
>  	else
>  		del_timer_sync(&bdata->release_timer);
> +
> +	del_timer_sync(&bdata->unsuspend_timer);
>  }
>  
>  static int gpio_keys_setup_key(struct platform_device *pdev,
> @@ -496,6 +516,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>  	bdata->input = input;
>  	bdata->button = button;
>  	spin_lock_init(&bdata->lock);
> +	setup_timer(&bdata->unsuspend_timer, gpio_keys_unsuspend_timer,
> +		    (unsigned long)bdata);

You'd better use the new shiny API timer_setup instead (see
https://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git/commit/?h=for-4.15/use-timer-setup&id=0ee32774aed648854a06bc3fae636f20f5f75a68)
for an example.

>  
>  	if (child) {
>  		bdata->gpiod = devm_fwnode_get_gpiod_from_child(dev, NULL,
> @@ -857,6 +879,7 @@ static int __maybe_unused gpio_keys_suspend(struct device *dev)
>  			struct gpio_button_data *bdata = &ddata->data[i];
>  			if (bdata->button->wakeup)
>  				enable_irq_wake(bdata->irq);
> +			del_timer_sync(&bdata->unsuspend_timer);
>  			bdata->suspended = true;
>  		}
>  	} else {
> @@ -881,7 +904,13 @@ static int __maybe_unused gpio_keys_resume(struct device *dev)
>  			struct gpio_button_data *bdata = &ddata->data[i];
>  			if (bdata->button->wakeup)
>  				disable_irq_wake(bdata->irq);
> -			bdata->suspended = false;
> +			if (bdata->button->no_wakeup_events) {
> +				mod_timer(&bdata->unsuspend_timer, jiffies +
> +					  msecs_to_jiffies(
> +						    bdata->software_debounce));
> +			} else {
> +				bdata->suspended = false;

I am not sure why this field is also duplicated in all the buttons,
while we could have only one per device.

Cheers,
Benjamin

> +			}
>  		}
>  	} else {
>  		mutex_lock(&input->mutex);
> diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
> index 0b71024c082c..d8a85e52b6bb 100644
> --- a/include/linux/gpio_keys.h
> +++ b/include/linux/gpio_keys.h
> @@ -15,6 +15,8 @@ struct device;
>   * @debounce_interval:	debounce ticks interval in msecs
>   * @can_disable:	%true indicates that userspace is allowed to
>   *			disable button via sysfs
> + * @no_wakeup_events:	For wake-up source buttons only, if %true then no input
> + *			events will be generated if pressed while suspended
>   * @value:		axis value for %EV_ABS
>   * @irq:		Irq number in case of interrupt keys
>   */
> @@ -27,6 +29,7 @@ struct gpio_keys_button {
>  	int wakeup;
>  	int debounce_interval;
>  	bool can_disable;
> +	bool no_wakeup_events;
>  	int value;
>  	unsigned int irq;
>  };
> -- 
> 2.14.2
> 
