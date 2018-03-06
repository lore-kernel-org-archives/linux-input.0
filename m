From: JeffyChen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v3 1/3] Input: gpio-keys - add support for wakeup event
 action
Date: Tue, 06 Mar 2018 15:44:15 +0800
Message-ID: <5A9E46CF.8060206@rock-chips.com>
References: <20180302035102.10084-1-jeffy.chen@rock-chips.com> <20180302035102.10084-2-jeffy.chen@rock-chips.com> <20180306003009.GA2205@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180306003009.GA2205@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, briannorris@google.com, heiko@sntech.de, dtor@google.com, dianders@google.com, Guenter Roeck <linux@roeck-us.net>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Thomas Gleixner <tglx@linutronix.de>, Joseph Lo <josephl@nvidia.com>, stephen lu <lumotuwe@gmail.com>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

Thanks for your review.

On 03/06/2018 08:30 AM, Dmitry Torokhov wrote:
>> >+		switch (button->wakeup_event_action) {
>> >+		case EV_ACT_ASSERTED:
>> >+			bdata->wakeup_trigger_type = active_low ?
>> >+				IRQF_TRIGGER_FALLING : IRQF_TRIGGER_RISING;
> 				IRQ_TYPE_EDGE_FALLING : IRQ_TYPE_EDGE_RISING;
>
ok, will fix in next version
>> >+			break;
>> >+		case EV_ACT_DEASSERTED:
>> >+			bdata->wakeup_trigger_type = active_low ?
>> >+				IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
>> >+			break;
> 		case EV_ACT_ANY:
ok, will fix in next version
>> >+		default:
>> >+			/*
>> >+			 * For other cases, we are OK letting suspend/resume
>> >+			 * not reconfigure the trigger type.
>> >+			 */
>> >+			break;
>> >+		}
>> >  	} else {
>> >  		if (!button->irq) {
>> >  			dev_err(dev, "Found button without gpio or irq\n");
>> >@@ -586,6 +606,12 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>> >
>> >  		isr = gpio_keys_irq_isr;
>> >  		irqflags = 0;
>> >+
>> >+		/*
>> >+		 * For IRQ buttons, the irq trigger type for press and release
>> >+		 * are the same. So we don't need to reconfigure the trigger
>> >+		 * type for wakeup.
> That is not entirely accurate. Interrupt triggers button press, which is
> followed by either immediate or delayed release. There is no interrupt
> for release.
ok, will fix the comment
>
>> >+		 */
>> >  	}
>> >
>> >  	bdata->code = &ddata->keymap[idx];
>> >@@ -618,6 +644,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>> >  		return error;
>> >  	}
>> >
>> >+	bdata->irq_trigger_type = irq_get_trigger_type(bdata->irq);
> Why do we need to store the trigger type? It is always both edges for
> gpio-based keys and we do not support changing wakeup trigger for
> interrupt-based keys.
right, this is not needed.
>
>> >+
>> >  	return 0;
>> >  }
>> >
>> >@@ -718,6 +746,9 @@ gpio_keys_get_devtree_pdata(struct device *dev)
>> >  			/* legacy name */
>> >  			fwnode_property_read_bool(child, "gpio-key,wakeup");
>> >
>> >+		fwnode_property_read_u32(child, "wakeup-event-action",
>> >+					 &button->wakeup_event_action);
>> >+
>> >  		button->can_disable =
>> >  			fwnode_property_read_bool(child, "linux,can-disable");
>> >
>> >@@ -854,6 +885,10 @@ static int __maybe_unused gpio_keys_suspend(struct device *dev)
>> >  	if (device_may_wakeup(dev)) {
>> >  		for (i = 0; i < ddata->pdata->nbuttons; i++) {
>> >  			struct gpio_button_data *bdata = &ddata->data[i];
>> >+
>> >+			if (bdata->button->wakeup && bdata->wakeup_trigger_type)
>> >+				irq_set_irq_type(bdata->irq,
>> >+						 bdata->wakeup_trigger_type);
> 			if (bdata->button->wakeup) {
> 				if (bdata->wakeup_trigger_type) {
> 					error = ...;
> 				}
>
> 				enable_irq_wake(bdata->irq);
> 			}
>
> Might need to be split into a helper; if you add error handling to
> enable_irq_wake() that woudl be great too.
ok, will do that.
>
>> >  			if (bdata->button->wakeup)
>> >  				enable_irq_wake(bdata->irq);
>> >  			bdata->suspended = true;
>> >@@ -878,6 +913,10 @@ static int __maybe_unused gpio_keys_resume(struct device *dev)
>> >  	if (device_may_wakeup(dev)) {
>> >  		for (i = 0; i < ddata->pdata->nbuttons; i++) {
>> >  			struct gpio_button_data *bdata = &ddata->data[i];
>> >+
>> >+			if (bdata->button->wakeup && bdata->wakeup_trigger_type)
>> >+				irq_set_irq_type(bdata->irq,
>> >+						 bdata->irq_trigger_type);
> Just use IRQ_TYPE_EDGE_BOTH.
>
>> >  			if (bdata->button->wakeup)
>> >  				disable_irq_wake(bdata->irq);
>> >  			bdata->suspended = false;
>> >diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
>> >index d06bf77400f1..7160df54a6fe 100644
>> >--- a/include/linux/gpio_keys.h
>> >+++ b/include/linux/gpio_keys.h
>> >@@ -13,6 +13,7 @@ struct device;
>> >   * @desc:		label that will be attached to button's gpio
>> >   * @type:		input event type (%EV_KEY, %EV_SW, %EV_ABS)
>> >   * @wakeup:		configure the button as a wake-up source
>> >+ * @wakeup_event_action:	event action to trigger wakeup
>> >   * @debounce_interval:	debounce ticks interval in msecs
>> >   * @can_disable:	%true indicates that userspace is allowed to
>> >   *			disable button via sysfs
>> >@@ -26,6 +27,7 @@ struct gpio_keys_button {
>> >  	const char *desc;
>> >  	unsigned int type;
>> >  	int wakeup;
>> >+	int wakeup_event_action;
>> >  	int debounce_interval;
>> >  	bool can_disable;
>> >  	int value;
>> >diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
>> >index 53fbae27b280..d7917b0bd438 100644
>> >--- a/include/uapi/linux/input-event-codes.h
>> >+++ b/include/uapi/linux/input-event-codes.h
>> >@@ -32,6 +32,15 @@
>> >  #define INPUT_PROP_CNT			(INPUT_PROP_MAX + 1)
>> >
>> >  /*
>> >+ * Event action types
>> >+ */
>> >+#define EV_ACT_ANY			0x00	/* asserted or deasserted */
>> >+#define EV_ACT_ASSERTED			0x01	/* asserted */
>> >+#define EV_ACT_DEASSERTED		0x02	/* deasserted */
> These do not belong here: they are of no interest to userspace but
> simply a driver specific quirk. If you want to share symbolic names add
> include/dt-bindings/input/gpio-keys.h
ok
>
>
>> >+#define EV_ACT_MAX			0x02
>> >+#define EV_ACT_CNT			(EV_ACT_MAX+1)
> These are not needed at all: you are not defining input bitmasks.
>
