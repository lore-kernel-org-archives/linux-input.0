From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH 2/2] HID: sony: Add LED controls for Dualshock 4
Date: Thu, 9 Jan 2014 11:45:40 +0100
Message-ID: <20140109114540.394b6365a6c27464e87a523c@studenti.unina.it>
References: <alpine.DEB.2.10.1401031542220.29517@franz-virtual-machine>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:54019 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751649AbaAIKpy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Jan 2014 05:45:54 -0500
In-Reply-To: <alpine.DEB.2.10.1401031542220.29517@franz-virtual-machine>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org

On Fri, 3 Jan 2014 16:03:46 -0500 (EST)
Frank Praznik <frank.praznik@oh.rr.com> wrote:

> This patch builds on the previous patch and adds controls for the light 

Just use "Add controls for ..."

> bar on the Dualshock 4.  The light bar contains a red, green and blue LED 
> that can independently vary in brightness from 0 to 255.  The LED system 
> in the module had to be extended to support a full byte per led for 
> storing the brightness level as well as storing a count of LEDs on each 
> device.  Like the Sixaxis, LED status is set in the worker function by 
> setting certain bytes in the data packet.
> 
> Like the force feedback patch, this meant to be applied against the 
> for-3.14/sony branch in jiros/hid.git
>

Annotation :)

Ah and remember to CC Jiri Kosina when you send the v2, you can use
scripts/get_maintainer.pl to get some _hints_ about where to send a
patch.

Some more nitpicking below.

> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
> 
> ---
>  drivers/hid/hid-sony.c | 77 ++++++++++++++++++++++++++++++++------------------
>  1 file changed, 49 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index f42c866..445b5f2 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -40,7 +40,9 @@
>  #define PS3REMOTE		BIT(4)
>  #define DUALSHOCK4_CONTROLLER	BIT(5)
>  
> -#define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER_USB | BUZZ_CONTROLLER)
> +#define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER_USB | BUZZ_CONTROLLER | DUALSHOCK4_CONTROLLER)
> +
> +#define MAX_LEDS 4
>  
>  static const u8 sixaxis_rdesc_fixup[] = {
>  	0x95, 0x13, 0x09, 0x01, 0x81, 0x02, 0x95, 0x0C,
> @@ -227,7 +229,7 @@ static const unsigned int buzz_keymap[] = {
>  
>  struct sony_sc {
>  	struct hid_device *hdev;
> -	struct led_classdev *leds[4];
> +	struct led_classdev *leds[MAX_LEDS];
>  	unsigned long quirks;
>  	struct work_struct state_worker;
>  
> @@ -236,7 +238,8 @@ struct sony_sc {
>  	__u8 right;
>  #endif
>  
> -	__u8 led_state;
> +	__u8 led_state[MAX_LEDS];
> +	__u8 led_count;
>  };
>  
>  static __u8 *ps3remote_fixup(struct hid_device *hdev, __u8 *rdesc,
> @@ -447,7 +450,7 @@ static int sixaxis_set_operational_bt(struct hid_device *hdev)
>  	return hdev->hid_output_raw_report(hdev, buf, sizeof(buf), HID_FEATURE_REPORT);
>  }
>  
> -static void buzz_set_leds(struct hid_device *hdev, int leds)
> +static void buzz_set_leds(struct hid_device *hdev, const __u8 *leds)
>  {
>  	struct list_head *report_list =
>  		&hdev->report_enum[HID_OUTPUT_REPORT].report_list;
> @@ -456,23 +459,27 @@ static void buzz_set_leds(struct hid_device *hdev, int leds)
>  	__s32 *value = report->field[0]->value;
>  
>  	value[0] = 0x00;
> -	value[1] = (leds & 1) ? 0xff : 0x00;
> -	value[2] = (leds & 2) ? 0xff : 0x00;
> -	value[3] = (leds & 4) ? 0xff : 0x00;
> -	value[4] = (leds & 8) ? 0xff : 0x00;
> +	value[1] = leds[0] ? 0xff : 0x00;
> +	value[2] = leds[1] ? 0xff : 0x00;
> +	value[3] = leds[2] ? 0xff : 0x00;
> +	value[4] = leds[3] ? 0xff : 0x00;
>  	value[5] = 0x00;
>  	value[6] = 0x00;
>  	hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
>  }
>  
> -static void sony_set_leds(struct hid_device *hdev, __u8 leds)
> +static void sony_set_leds(struct hid_device *hdev, const __u8 *leds, int count)
>  {
>  	struct sony_sc *drv_data = hid_get_drvdata(hdev);
> -
> -	if (drv_data->quirks & BUZZ_CONTROLLER) {
> +	int n;
> +
> +	BUG_ON(count > MAX_LEDS);
> +
> +	if (drv_data->quirks & BUZZ_CONTROLLER && count == 4) {
>  		buzz_set_leds(hdev, leds);
> -	} else if (drv_data->quirks & SIXAXIS_CONTROLLER_USB) {
> -		drv_data->led_state = leds;
> +	} else if ((drv_data->quirks & SIXAXIS_CONTROLLER_USB) || (drv_data->quirks & DUALSHOCK4_CONTROLLER)) {
> +		for(n = 0; n < count; n++)
> +			drv_data->led_state[n] = leds[n];
>  		schedule_work(&drv_data->state_worker);
>  	}
>  }
> @@ -492,15 +499,11 @@ static void sony_led_set_brightness(struct led_classdev *led,
>  		return;
>  	}
>  
> -	for (n = 0; n < 4; n++) {
> +	for (n = 0; n < drv_data->led_count; n++) {
>  		if (led == drv_data->leds[n]) {
> -			int on = !!(drv_data->led_state & (1 << n));
> -			if (value == LED_OFF && on) {
> -				drv_data->led_state &= ~(1 << n);
> -				sony_set_leds(hdev, drv_data->led_state);
> -			} else if (value != LED_OFF && !on) {
> -				drv_data->led_state |= (1 << n);
> -				sony_set_leds(hdev, drv_data->led_state);
> +			if (value != drv_data->led_state[n]) {
> +				drv_data->led_state[n] = value;
> +				sony_set_leds(hdev, drv_data->led_state, drv_data->led_count);
>  			}
>  			break;
>  		}
> @@ -522,9 +525,9 @@ static enum led_brightness sony_led_get_brightness(struct led_classdev *led)
>  		return LED_OFF;
>  	}
>  
> -	for (n = 0; n < 4; n++) {
> +	for (n = 0; n < drv_data->led_count; n++) {
>  		if (led == drv_data->leds[n]) {
> -			on = !!(drv_data->led_state & (1 << n));
> +			on = !!(drv_data->led_state[n]);
>  			break;
>  		}
>  	}
> @@ -541,7 +544,7 @@ static void sony_leds_remove(struct hid_device *hdev)
>  	drv_data = hid_get_drvdata(hdev);
>  	BUG_ON(!(drv_data->quirks & SONY_LED_SUPPORT));
>  
> -	for (n = 0; n < 4; n++) {
> +	for (n = 0; n < drv_data->led_count; n++) {
>  		led = drv_data->leds[n];
>  		drv_data->leds[n] = NULL;
>  		if (!led)
> @@ -549,17 +552,21 @@ static void sony_leds_remove(struct hid_device *hdev)
>  		led_classdev_unregister(led);
>  		kfree(led);
>  	}
> +
> +	drv_data->led_count = 0;
>  }
>  
>  static int sony_leds_init(struct hid_device *hdev)
>  {
>  	struct sony_sc *drv_data;
>  	int n, ret = 0;
> +	int max_brightness = 1;

you could avoid initialization here and set the value in the check
below, it'd look more symmetrical to me.

>  	struct led_classdev *led;
>  	size_t name_sz;
>  	char *name;
>  	size_t name_len;
>  	const char *name_fmt;
> +	static const __u8 initial_values[MAX_LEDS] = { 0x00, 0x00, 0x00, 0x00 };
>  
>  	drv_data = hid_get_drvdata(hdev);
>  	BUG_ON(!(drv_data->quirks & SONY_LED_SUPPORT));
> @@ -574,15 +581,22 @@ static int sony_leds_init(struct hid_device *hdev)
>  		name_len = strlen("::sony#");
>  		name_fmt = "%s::sony%d";
>  	}
> +
> +	if (drv_data->quirks & DUALSHOCK4_CONTROLLER) {
> +		drv_data->led_count = 3;
> +		max_brightness = 255;
> +	}
> +	else
> +		drv_data->led_count = 4;
>

Also the else block requires curly braces, see Documentation/CodingStyle
maybe scripts/checkpatch.pl catches these issues.

>  	/* Clear LEDs as we have no way of reading their initial state. This is
>  	 * only relevant if the driver is loaded after somebody actively set the
>  	 * LEDs to on */
> -	sony_set_leds(hdev, 0x00);
> +	sony_set_leds(hdev, initial_values, drv_data->led_count);
>  
>  	name_sz = strlen(dev_name(&hdev->dev)) + name_len + 1;
>  
> -	for (n = 0; n < 4; n++) {
> +	for (n = 0; n < drv_data->led_count; n++) {
>  		led = kzalloc(sizeof(struct led_classdev) + name_sz, GFP_KERNEL);
>  		if (!led) {
>  			hid_err(hdev, "Couldn't allocate memory for LED %d\n", n);
> @@ -594,7 +608,7 @@ static int sony_leds_init(struct hid_device *hdev)
>  		snprintf(name, name_sz, name_fmt, dev_name(&hdev->dev), n + 1);
>  		led->name = name;
>  		led->brightness = 0;
> -		led->max_brightness = 1;
> +		led->max_brightness = max_brightness;
>  		led->brightness_get = sony_led_get_brightness;
>  		led->brightness_set = sony_led_set_brightness;
>  
> @@ -635,7 +649,10 @@ static void sixaxis_state_worker(struct work_struct *work)
>  	buf[5] = sc->left;
>  #endif
>  
> -	buf[10] |= (sc->led_state & 0xf) << 1;
> +	buf[10] |= sc->led_state[0] << 1;
> +	buf[10] |= sc->led_state[1] << 2;
> +	buf[10] |= sc->led_state[2] << 3;
> +	buf[10] |= sc->led_state[3] << 4;
>  
>  	sc->hdev->hid_output_raw_report(sc->hdev, buf, sizeof(buf),
>  					HID_OUTPUT_REPORT);
> @@ -660,6 +677,10 @@ static void dualshock4_state_worker(struct work_struct *work)
>  	buf[5] = sc->left;
>  #endif
>  
> +	buf[6] = sc->led_state[0];
> +	buf[7] = sc->led_state[1];
> +	buf[8] = sc->led_state[2];
> +
>  	sc->hdev->hid_output_raw_report(sc->hdev, buf, sizeof(buf),
>  					HID_OUTPUT_REPORT);
>  }
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
