From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: Re: [PATCH 5/6] HID: sony: Add an led trigger to report controller
 battery status.
Date: Sun, 02 Mar 2014 18:48:19 -0500
Message-ID: <5313C343.1090607@oh.rr.com>
References: <1393646341-16947-1-git-send-email-frank.praznik@oh.rr.com> <1393646341-16947-6-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:61279 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504AbaCBXsY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Mar 2014 18:48:24 -0500
In-Reply-To: <1393646341-16947-6-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>, linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com

On 2/28/2014 22:59, Frank Praznik wrote:
> Creates an LED trigger that changes LED behavior depending on the state of the
> controller battery.
>
> The trigger function runs on a 500 millisecond timer and only updates the LEDs
> if the controller power state has changed or a new device has been added to the
> trigger.
>
> The trigger sets the LEDs to solid if the controller is in wireless mode and
> the battery is above 20% power or if the controller is plugged in and the
> battery has completed charging.  If the controller is not charging and the
> battery drops to or below 20% it blinks the LEDs in 500ms intervals. If the
> controller is plugged in and charging it blinks the LEDs in 1 second intervals.
>
> The order of subsystem initialization had to be changed in sony_probe() so that
> the trigger is created before the LEDs are initialized.
>
> By default the controller LEDs are set to the trigger local to that controller.
>
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
> ---
>   drivers/hid/hid-sony.c | 170 ++++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 162 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 914a6cc..d7889ac 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -730,6 +730,17 @@ struct sony_sc {
>   	struct work_struct state_worker;
>   	struct power_supply battery;
>   
> +#ifdef CONFIG_LEDS_TRIGGERS
> +	spinlock_t trigger_lock;
> +	struct led_trigger battery_trigger;
> +	struct timer_list battery_trigger_timer;
> +	atomic_t trigger_device_added;
> +	__u8 trigger_initialized;
> +	__u8 trigger_timer_initialized;
> +	__u8 trigger_capacity;
> +	__u8 trigger_charging;
> +#endif
> +
>   #ifdef CONFIG_SONY_FF
>   	__u8 left;
>   	__u8 right;
> @@ -1329,14 +1340,19 @@ static int sony_leds_init(struct sony_sc *sc)
>   		if (!(sc->quirks & BUZZ_CONTROLLER))
>   			led->blink_set = sony_blink_set;
>   
> +#ifdef CONFIG_LEDS_TRIGGERS
> +		led->default_trigger = sc->battery_trigger.name;
> +#endif
> +
> +		sc->leds[n] = led;
> +
>   		ret = led_classdev_register(&hdev->dev, led);
>   		if (ret) {
>   			hid_err(hdev, "Failed to register LED %d\n", n);
>   			kfree(led);
> +			sc->leds[n] = NULL;
>   			goto error_leds;
>   		}
> -
> -		sc->leds[n] = led;
>   	}
>   
>   	return ret;
> @@ -1552,6 +1568,137 @@ static void sony_battery_remove(struct sony_sc *sc)
>   	sc->battery.name = NULL;
>   }
>   
> +#ifdef CONFIG_LEDS_TRIGGERS
> +static void sony_battery_trigger_callback(unsigned long data)
> +{
> +	struct sony_sc *drv_data = (struct sony_sc *)data;
> +	struct led_classdev *led;
> +	unsigned long flags;
> +	unsigned long delay_on, delay_off;
> +	int dev_added, ret;
> +	__u8 charging, capacity;
> +
> +	/* Check if new LEDs were added since the last time */
> +	dev_added = atomic_cmpxchg(&drv_data->trigger_device_added, 1, 0);
> +
> +	/* Get the battery info */
> +	spin_lock_irqsave(&drv_data->lock, flags);
> +	charging = drv_data->battery_charging;
> +	capacity = drv_data->battery_capacity;
> +	spin_unlock_irqrestore(&drv_data->lock, flags);
> +
> +	/* Don't set the LEDs if nothing has changed */
> +	if (!dev_added && drv_data->trigger_capacity == capacity &&
> +		drv_data->trigger_charging == charging)
> +		goto reset_timer;
> +
> +	if (charging) {
> +		/* Charging: blink at 1 sec intervals */
> +		delay_on = delay_off = 1000;
> +		led_trigger_blink(&drv_data->battery_trigger, &delay_on,
> +				&delay_off);
> +	} else if (capacity <= 20) {
> +		/* Low battery: blink at 500ms intervals */
> +		delay_on = delay_off = 500;
> +		led_trigger_blink(&drv_data->battery_trigger, &delay_on,
> +				&delay_off);
> +	} else {
> +		/*
> +		 * Normal: set the brightness to stop blinking
> +		 *
> +		 * This just walks the list of LEDs on the trigger and sets the
> +		 * brightness to the existing value. This leaves the brightness
> +		 * the same but the blinking is stopped.
> +		 */
> +		read_lock(&drv_data->battery_trigger.leddev_list_lock);
> +		list_for_each_entry(led,
> +			&drv_data->battery_trigger.led_cdevs, trig_list) {
> +			led_set_brightness(led, led->brightness);
> +		}
> +		read_unlock(&drv_data->battery_trigger.leddev_list_lock);
> +	}
> +
> +	/* Cache the power state for next time */
> +	drv_data->trigger_charging = charging;
> +	drv_data->trigger_capacity = capacity;
> +
> +reset_timer:
> +	ret = mod_timer(&drv_data->battery_trigger_timer,
> +			jiffies + msecs_to_jiffies(500));
> +
> +	if (ret < 0)
> +		hid_err(drv_data->hdev,
> +			"Failed to set battery trigger timer\n");
> +}
> +
> +static void sony_battery_trigger_activate(struct led_classdev *led)
> +{
> +	struct sony_sc *sc;
> +
> +	sc = container_of(led->trigger, struct sony_sc, battery_trigger);
> +
> +	/*
> +	 * Set the device_added flag to tell the timer function that it
> +	 * should send an update even if the power state hasn't changed.
> +	 */
> +	atomic_set(&sc->trigger_device_added, 1);
> +}
> +
> +static int sony_battery_trigger_init(struct sony_sc *sc)
> +{
> +	int ret;
> +
> +	sc->battery_trigger.name = kasprintf(GFP_KERNEL,
> +				"%s-blink-low-or-charging", sc->battery.name);
> +	if (!sc->battery.name)
> +		return -ENOMEM;
> +
> +	sc->battery_trigger.activate = sony_battery_trigger_activate;
> +
> +	ret = led_trigger_register(&sc->battery_trigger);
> +	if (ret < 0)
> +		goto trigger_failure;
> +
> +	setup_timer(&sc->battery_trigger_timer,
> +			sony_battery_trigger_callback, (unsigned long)sc);
> +
> +	ret = mod_timer(&sc->battery_trigger_timer,
> +			jiffies + msecs_to_jiffies(500));
> +	if (ret < 0)
> +		goto timer_failure;
> +
> +	sc->trigger_initialized = 1;
> +
> +	return 0;
> +
> +timer_failure:
> +	led_trigger_unregister(&sc->battery_trigger);
> +trigger_failure:
> +	kfree(sc->battery_trigger.name);
> +	return ret;
> +}
> +
> +static void sony_battery_trigger_remove(struct sony_sc *sc)
> +{
> +	if (sc->trigger_initialized) {
> +		del_timer_sync(&sc->battery_trigger_timer);
> +		led_trigger_unregister(&sc->battery_trigger);
> +		kfree(sc->battery_trigger.name);
> +	}
> +}
> +#else
> +static int sony_battery_trigger_init(struct sony_sc *sc)
> +{
> +	/* Nothing to do */
> +	return 0;
> +}
> +
> +static void sony_battery_trigger_remove(struct sony_sc *sc)
> +{
> +	/* Nothing to do */
> +}
> +#endif
> +
>   static int sony_register_touchpad(struct sony_sc *sc, int touch_count,
>   					int w, int h)
>   {
> @@ -1786,14 +1933,12 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>   	if (ret < 0)
>   		goto err_stop;
>   
> -	if (sc->quirks & SONY_LED_SUPPORT) {
> -		ret = sony_leds_init(sc);
> +	if (sc->quirks & SONY_BATTERY_SUPPORT) {
> +		ret = sony_battery_probe(sc);
>   		if (ret < 0)
>   			goto err_stop;
> -	}
>   
> -	if (sc->quirks & SONY_BATTERY_SUPPORT) {
> -		ret = sony_battery_probe(sc);
> +		ret = sony_battery_trigger_init(sc);
>   		if (ret < 0)
>   			goto err_stop;
>   
> @@ -1805,6 +1950,12 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>   		}
>   	}
>   
> +	if (sc->quirks & SONY_LED_SUPPORT) {
> +		ret = sony_leds_init(sc);
> +		if (ret < 0)
> +			goto err_stop;
> +	}
> +
>   	if (sc->quirks & SONY_FF_SUPPORT) {
>   		ret = sony_init_ff(sc);
>   		if (ret < 0)
> @@ -1817,8 +1968,10 @@ err_close:
>   err_stop:
>   	if (sc->quirks & SONY_LED_SUPPORT)
>   		sony_leds_remove(sc);
> -	if (sc->quirks & SONY_BATTERY_SUPPORT)
> +	if (sc->quirks & SONY_BATTERY_SUPPORT) {
> +		sony_battery_trigger_remove(sc);
>   		sony_battery_remove(sc);
> +	}
>   	sony_cancel_work_sync(sc);
>   	sony_remove_dev_list(sc);
>   	hid_hw_stop(hdev);
> @@ -1834,6 +1987,7 @@ static void sony_remove(struct hid_device *hdev)
>   
>   	if (sc->quirks & SONY_BATTERY_SUPPORT) {
>   		hid_hw_close(hdev);
> +		sony_battery_trigger_remove(sc);
>   		sony_battery_remove(sc);
>   	}
>   
I'm going to self-NAK this patch as I've found a problem scenario with 
it where LEDs might not blink when they should.  I would still 
appreciate feedback on whether or not this concept is worth persuing 
before spending more time on it though.
