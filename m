From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH v2 7/8] HID: sony: Initialize the controller LEDs with
 the device ID value
Date: Mon, 10 Mar 2014 23:59:02 +0100
Message-ID: <20140310235902.e09d0855b9c848a098b7ca36@ao2.it>
References: <1394145176-24174-1-git-send-email-frank.praznik@oh.rr.com>
	<1394145176-24174-8-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:59679 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752293AbaCJW7I (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Mar 2014 18:59:08 -0400
In-Reply-To: <1394145176-24174-8-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, dh.herrmann@gmail.com

On Thu,  6 Mar 2014 17:32:55 -0500
Frank Praznik <frank.praznik@oh.rr.com> wrote:

> Use the device ID to initialize the Sixaxis and DualShock 4 controller LEDs to
> default values.  The number or color of the controller is set relative to other
> connected Sony controllers.
>

You already know I am not a huge fan of this idea for the sixaxis and I
found another reason why: the Sixaxis requires the user to press the PS
button before it starts to actually send events and the all-blink
pattern is there to tell the user:
  
  "Look, even if the device is connected, it isn't fully functional yet,
   some action is required".

That's also why the BlueZ sixaxis plugin waits for events before
actually setting the LEDs via USB.

Furthermore I still seem to get the all-blink pattern even with the
patch applied, it seems to start _after_ the kernel driver set the
default as per your patch; do you also experience this?
And I still need a recent BLueZ with the sixaxis plugin to use the
controller via BT so I don't see the benefits of defaults over BT
either, but I am obviously biased.

That said, the approach used looks clean enough so I am not going to
oppose any further :)

Just please, if you can, test your changes in conjunction with the
BlueZ sixaxis plugin in order to make sure the two don't step on each
other toes too much.

Thanks,
   Antonio

> Set the LED class brightness values to the initial values and add the new led to
> the array before calling led_classdev_register so that the correct brightness value
> shows up in the LED sysfs entry.

Also thanks for thinking about that last part, it's a nice thing to do.

> 
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
> ---
> 
>  v2 uses the id assigned by the IDA allocator to set the default values.
> 
>  drivers/hid/hid-sony.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 53 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 13af58c..6de42b4 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -1081,6 +1081,52 @@ static int dualshock4_set_operational_bt(struct hid_device *hdev)
>  				HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
>  }
>  
> +static void sixaxis_set_leds_from_id(int id, __u8 values[MAX_LEDS])
> +{
> +	static const __u8 sixaxis_leds[10][4] = {
> +				{ 0x01, 0x00, 0x00, 0x00 },
> +				{ 0x00, 0x01, 0x00, 0x00 },
> +				{ 0x00, 0x00, 0x01, 0x00 },
> +				{ 0x00, 0x00, 0x00, 0x01 },
> +				{ 0x01, 0x00, 0x00, 0x01 },
> +				{ 0x00, 0x01, 0x00, 0x01 },
> +				{ 0x00, 0x00, 0x01, 0x01 },
> +				{ 0x01, 0x00, 0x01, 0x01 },
> +				{ 0x00, 0x01, 0x01, 0x01 },
> +				{ 0x01, 0x01, 0x01, 0x01 }
> +	};
> +
> +	BUG_ON(MAX_LEDS < ARRAY_SIZE(sixaxis_leds[0]));
> +
> +	if (id < 0)
> +		return;
> +
> +	id %= 10;
> +	memcpy(values, sixaxis_leds[id], sizeof(sixaxis_leds[id]));
> +}
> +
> +static void dualshock4_set_leds_from_id(int id, __u8 values[MAX_LEDS])
> +{
> +	/* The first 4 color/index entries match what the PS4 assigns */
> +	static const __u8 color_code[7][3] = {
> +			/* Blue   */	{ 0x00, 0x00, 0x01 },
> +			/* Red	  */	{ 0x01, 0x00, 0x00 },
> +			/* Green  */	{ 0x00, 0x01, 0x00 },
> +			/* Pink   */	{ 0x02, 0x00, 0x01 },
> +			/* Orange */	{ 0x02, 0x01, 0x00 },
> +			/* Teal   */	{ 0x00, 0x01, 0x01 },
> +			/* White  */	{ 0x01, 0x01, 0x01 }
> +	};
> +
> +	BUG_ON(MAX_LEDS < ARRAY_SIZE(color_code[0]));
> +
> +	if (id < 0)
> +		return;
> +
> +	id %= 7;
> +	memcpy(values, color_code[id], sizeof(color_code[id]));
> +}
> +
>  static void buzz_set_leds(struct hid_device *hdev, const __u8 *leds)
>  {
>  	struct list_head *report_list =
> @@ -1194,7 +1240,7 @@ static int sony_leds_init(struct sony_sc *sc)
>  	size_t name_len;
>  	const char *name_fmt;
>  	static const char * const color_str[] = { "red", "green", "blue" };
> -	static const __u8 initial_values[MAX_LEDS] = { 0x00, 0x00, 0x00, 0x00 };
> +	__u8 initial_values[MAX_LEDS] = { 0 };
>  
>  	BUG_ON(!(sc->quirks & SONY_LED_SUPPORT));
>  
> @@ -1208,12 +1254,14 @@ static int sony_leds_init(struct sony_sc *sc)
>  		if (!hid_validate_values(hdev, HID_OUTPUT_REPORT, 0, 0, 7))
>  			return -ENODEV;
>  	} else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
> +		dualshock4_set_leds_from_id(sc->device_id, initial_values);
>  		sc->led_count = 3;
>  		max_brightness = 255;
>  		use_colors = 1;
>  		name_len = 0;
>  		name_fmt = "%s:%s";
>  	} else {
> +		sixaxis_set_leds_from_id(sc->device_id, initial_values);
>  		sc->led_count = 4;
>  		max_brightness = 1;
>  		use_colors = 0;
> @@ -1248,19 +1296,20 @@ static int sony_leds_init(struct sony_sc *sc)
>  		else
>  			snprintf(name, name_sz, name_fmt, dev_name(&hdev->dev), n + 1);
>  		led->name = name;
> -		led->brightness = 0;
> +		led->brightness = initial_values[n];
>  		led->max_brightness = max_brightness;
>  		led->brightness_get = sony_led_get_brightness;
>  		led->brightness_set = sony_led_set_brightness;
>  
> +		sc->leds[n] = led;
> +
>  		ret = led_classdev_register(&hdev->dev, led);
>  		if (ret) {
>  			hid_err(hdev, "Failed to register LED %d\n", n);
> +			sc->leds[n] = NULL;
>  			kfree(led);
>  			goto error_leds;
>  		}
> -
> -		sc->leds[n] = led;
>  	}
>  
>  	return ret;
> -- 
> 1.8.5.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
