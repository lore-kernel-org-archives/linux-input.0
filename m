Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743DE396B6B;
	Mon,  6 Apr 2026 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775501440; cv=none; b=RLAHl8oRXzVJtEaJIsWMlB1b+xDlciAi1JAJEMIU2VnTtAw7gvG1bnRhAoBumLAPvd+r7zoekKsMPC83zHOgkEvBWrvdj5O6+Nafndb2bZDC6rWZNWkZJl2JIhu+PSUTmPFOSSoPVgTseeCKoaqa1N3R3A0GyJIJ+tTjTg/HnwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775501440; c=relaxed/simple;
	bh=k8TELAnuEeTRWnnDfWxWe5LQBKkf6p3yubgbG+wlSnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+57hxNMQPjRZmWtOEmR8SJcuN0DhtE0VM+gnMx23fI/kr2avSf1lFpKk+I4UmMke1fJArEJW4J7RWk9lWFiJa3Cqnt56MK5BeUcLUwdnu0PEdGa49YZcxsJB8jN1liVWU4rxExa7vEer0slcXam4NrpjCC1KCtXJoUmbB6fOWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i642lub3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i642lub3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D5FC2BCB0;
	Mon,  6 Apr 2026 18:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775501440;
	bh=k8TELAnuEeTRWnnDfWxWe5LQBKkf6p3yubgbG+wlSnw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i642lub3J7qnMdjVBplPvSlcKzsMiEsrm13lSXoY7aZPlxAhCp1+pODVHL0eafV4E
	 ZptP6enOmu7PV6/NBr00FBW/4EQ7ptide5o+gRq61ARrg/UE3kvEXkiBtDVwg2lfwE
	 /Rk2sXH9W3QPf6One1q7iTJelsze+bNVJ5lss0uT/zAl/3mQEqFGaSpmLZg3Xq5M4F
	 QXgJeWUN13TSGK5gF3MVr+FlFNV9wGOPK/toVOikWbo1xAA1eV+1B+j792X3dPE1Rj
	 nl5S7r/l2t7l1CBtj1K7bDxdLoXVYvIW8mue2EEYH7m0T2z2Bm0sfVVdiDBHqtmkvl
	 Gdvfff1l33z/A==
Message-ID: <094db7d8-eb0c-4103-86fb-beb11580d53b@kernel.org>
Date: Mon, 6 Apr 2026 20:50:36 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: lg-g15: Add support for the Logitech G710/G710+
 gaming keyboards
To: Xavier Bestel <xav@bes.tel>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260402075239.3829699-1-xav@bes.tel>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260402075239.3829699-1-xav@bes.tel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Xavier,

Thank you for your patch, it is always nice to have people helping
with improving Linux support for devices like this.

On 2-Apr-26 09:52, Xavier Bestel wrote:
> Add support for the Logitech G710 and G710+ (USB ID 046d:c24d) gaming
> keyboards to the hid-lg-g15 driver.
> 
> These keyboards have 6 G-keys (G1-G6), M-keys (M1-M3, MR), a game mode
> toggle, and two independent backlights: one for the main keyboard and one
> for the WASD keys, each with a physical button to cycle brightness through
> 5 levels (0-4).
> 
> Key implementation details:
> 
>  - G-keys and M-keys are reported via HID input report 0x03 (4 bytes)
>    using KEY_MACRO1-6, KEY_MACRO_PRESET1-3 and KEY_MACRO_RECORD_START.
> 
>  - The WASD backlight LED is registered as
>    "g15::kbd_zoned_backlight-wasd" rather than with a
>    "::kbd_backlight" suffix, because UPower currently only supports a
>    single kbd_backlight LED per device. This follows the nomenclature
>    from Documentation/leds/leds-class.rst

Actually that nomenclature is something which was suggested in the past
but has never been agreed upon.

Since the discussion about how to name the LED class devices for
multi-zone keyboard backlights keeps coming up I've submitted a patch
now to document how these should be named:

https://lore.kernel.org/linux-leds/20260406174638.320135-1-johannes.goede@oss.qualcomm.com/

Since the new userspace API for this needs to be agreed upon first, that
patch should be accepted upstream first, before we can move forward with
the G710 support from this patch.

> 
>  - The G710+ firmware GET_REPORT for the backlight feature (0x08)
>    always returns the power-on default values, ignoring any changes
>    made via SET_REPORT. To work around this, the backlight brightness
>    is tracked in the driver cache and brightness_get returns the
>    cached value. M-key and game mode LEDs read back correctly.
> 
>  - The physical brightness cycle buttons are handled following the
>    same pattern as the G15/G15v2: no key events are sent, instead the
>    driver cycles the cached brightness and calls
>    led_classdev_notify_brightness_hw_changed() from a work function,
>    which allows GNOME to show the brightness OSD.
> 
>  - The game mode toggle is handled entirely by the firmware (it
>    disables the Super key and lights an indicator LED). The driver
>    exposes a read-only LED "g15::gamemode" with the
>    LED_BRIGHT_HW_CHANGED flag, and notifies userspace of state
>    changes via led_classdev_notify_brightness_hw_changed() by reading
>    back the actual firmware state on each toggle.
> 
>  - Both brightness LEDs are registered with the LED_BRIGHT_HW_CHANGED
>    flag to enable the brightness_hw_changed sysfs attribute.
> 
>  - HID_QUIRK_NOGET is set because the keyboard has buggy GET_REPORT
>    handling that causes timeouts on some feature reports.
> 
>  - The G-keys feature report (0x09) uses 2 bytes per key rather than
>    1 as on the G510, so the report size calculation is adjusted
>    accordingly.
> 
>  - Also fix a pre-existing comment typo: "f000.0000" -> "ff00.0000"
>    for the application report ID.
> 
>  - The loop bounds in lg_g15_led_set() and lg_g510_led_set() are
>    tightened from "< LG_G15_LED_MAX" to "<= LG_G15_MACRO_RECORD" to
>    avoid iterating over the new LG_G15_GAMEMODE enum value which does
>    not apply to those keyboards.
> 
> Signed-off-by: Xavier Bestel <xav@bes.tel>
> ---
>  drivers/hid/hid-ids.h    |   1 +
>  drivers/hid/hid-lg-g15.c | 393 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 384 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index afcee13bad61..7c0f930bd014 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -904,6 +904,7 @@
>  #define USB_DEVICE_ID_LOGITECH_G15_V2_LCD	0xc227
>  #define USB_DEVICE_ID_LOGITECH_G510		0xc22d
>  #define USB_DEVICE_ID_LOGITECH_G510_USB_AUDIO	0xc22e
> +#define USB_DEVICE_ID_LOGITECH_G710		0xc24d
>  #define USB_DEVICE_ID_LOGITECH_G29_WHEEL	0xc24f
>  #define USB_DEVICE_ID_LOGITECH_G920_WHEEL	0xc262
>  #define USB_DEVICE_ID_LOGITECH_G923_XBOX_WHEEL	0xc26e
> diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
> index 1a88bc44ada4..8a4c4eb22c07 100644
> --- a/drivers/hid/hid-lg-g15.c
> +++ b/drivers/hid/hid-lg-g15.c
> @@ -29,6 +29,11 @@
>  #define LG_G510_INPUT_MACRO_KEYS	0x03
>  #define LG_G510_INPUT_KBD_BACKLIGHT	0x04
>  
> +#define LG_G710_FEATURE_GAMEMODE        0x05
> +#define LG_G710_FEATURE_M_KEYS_LEDS     0x06
> +#define LG_G710_FEATURE_BACKLIGHT       0x08
> +#define LG_G710_FEATURE_EXTRA_KEYS      0x09
> +
>  #define LG_G13_INPUT_REPORT		0x01
>  #define LG_G13_FEATURE_M_KEYS_LEDS	0x05
>  #define LG_G13_FEATURE_BACKLIGHT_RGB	0x07
> @@ -48,6 +53,7 @@ enum lg_g15_model {
>  	LG_G15_V2,
>  	LG_G510,
>  	LG_G510_USB_AUDIO,
> +	LG_G710,
>  	LG_Z10,
>  };
>  
> @@ -59,6 +65,7 @@ enum lg_g15_led_type {
>  	LG_G15_MACRO_PRESET2,
>  	LG_G15_MACRO_PRESET3,
>  	LG_G15_MACRO_RECORD,
> +	LG_G15_GAMEMODE,
>  	LG_G15_LED_MAX
>  };
>  
> @@ -91,7 +98,9 @@ struct lg_g15_data {
>  	enum lg_g15_model model;
>  	struct lg_g15_led leds[LG_G15_LED_MAX];
>  	bool game_mode_enabled;
> +	u16 pressed_keys;
>  	bool backlight_disabled;	/* true == HW backlight toggled *OFF* */
> +	unsigned long brightness_changed;	/* bitmask of LEDs hw-cycled */
>  };
>  
>  /********* G13 LED functions ***********/
> @@ -334,7 +343,7 @@ static int lg_g15_led_set(struct led_classdev *led_cdev,
>  		g15->transfer_buf[1] = g15_led->led + 1;
>  		g15->transfer_buf[2] = brightness << (g15_led->led * 4);
>  	} else {
> -		for (i = LG_G15_MACRO_PRESET1; i < LG_G15_LED_MAX; i++) {
> +		for (i = LG_G15_MACRO_PRESET1; i <= LG_G15_MACRO_RECORD; i++) {
>  			if (i == g15_led->led)
>  				val = brightness;
>  			else
> @@ -567,7 +576,7 @@ static int lg_g510_mkey_led_set(struct led_classdev *led_cdev,
>  
>  	mutex_lock(&g15->mutex);
>  
> -	for (i = LG_G15_MACRO_PRESET1; i < LG_G15_LED_MAX; i++) {
> +	for (i = LG_G15_MACRO_PRESET1; i <= LG_G15_MACRO_RECORD; i++) {
>  		if (i == g15_led->led)
>  			val = brightness;
>  		else
> @@ -597,6 +606,239 @@ static int lg_g510_mkey_led_set(struct led_classdev *led_cdev,
>  	return ret;
>  }
>  
> +/******** G710 LED functions ********/
> +
> +static int lg_g710_update_game_led_brightness(struct lg_g15_data *g15)
> +{
> +	int ret;
> +
> +	ret = hid_hw_raw_request(g15->hdev, LG_G710_FEATURE_GAMEMODE,
> +				 g15->transfer_buf, 8,
> +				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
> +	if (ret != 8) {
> +		hid_err(g15->hdev, "Error getting gamemode LED brightness: %d\n", ret);
> +		return (ret < 0) ? ret : -EIO;
> +	}
> +
> +	g15->leds[LG_G15_GAMEMODE].brightness =
> +		!!g15->transfer_buf[1];
> +
> +	return 0;
> +}
> +
> +static int lg_g710_update_mkey_led_brightness(struct lg_g15_data *g15)
> +{
> +	int ret;
> +
> +	ret = hid_hw_raw_request(g15->hdev, LG_G710_FEATURE_M_KEYS_LEDS,
> +				 g15->transfer_buf, 2,
> +				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
> +	if (ret != 2) {
> +		hid_err(g15->hdev, "Error getting macro LED brightness: %d\n", ret);
> +		return (ret < 0) ? ret : -EIO;
> +	}
> +
> +	g15->leds[LG_G15_MACRO_PRESET1].brightness =
> +		!!(g15->transfer_buf[1] & 0x10);
> +	g15->leds[LG_G15_MACRO_PRESET2].brightness =
> +		!!(g15->transfer_buf[1] & 0x20);
> +	g15->leds[LG_G15_MACRO_PRESET3].brightness =
> +		!!(g15->transfer_buf[1] & 0x40);
> +	g15->leds[LG_G15_MACRO_RECORD].brightness =
> +		!!(g15->transfer_buf[1] & 0x80);
> +
> +	return 0;
> +}
> +
> +static int lg_g710_update_kbd_led_brightness(struct lg_g15_data *g15)
> +{
> +	int ret;
> +
> +	ret = hid_hw_raw_request(g15->hdev, LG_G710_FEATURE_BACKLIGHT,
> +				 g15->transfer_buf, 4,
> +				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
> +	if (ret != 4) {
> +		hid_err(g15->hdev, "Error getting LED brightness: %d\n", ret);
> +		return (ret < 0) ? ret : -EIO;
> +	}
> +
> +	g15->leds[LG_G15_KBD_BRIGHTNESS].brightness = 4 - g15->transfer_buf[2];
> +	g15->leds[LG_G15_LCD_BRIGHTNESS].brightness = 4 - g15->transfer_buf[1];

I think this needs a range-check on the buf contents to avoid e.g.
negative brightness values when we somehow get unexpected values back from
the keyboard.



> +
> +	return 0;
> +}
> +
> +static enum led_brightness lg_g710_led_get(struct led_classdev *led_cdev)
> +{
> +	struct lg_g15_led *g15_led =
> +		container_of(led_cdev, struct lg_g15_led, cdev);
> +	struct lg_g15_data *g15 = dev_get_drvdata(led_cdev->dev->parent);
> +	enum led_brightness brightness;
> +
> +	mutex_lock(&g15->mutex);
> +	/*
> +	 * The G710+ firmware's GET_REPORT for the backlight always returns
> +	 * the power-on default values, ignoring any changes made via
> +	 * SET_REPORT. Use the cached brightness which is kept in sync by
> +	 * the _set callbacks. M-key and gamemode LEDs read back correctly.
> +	 */
> +	if (g15_led->led >= LG_G15_BRIGHTNESS_MAX && g15_led->led < LG_G15_GAMEMODE)
> +		lg_g710_update_mkey_led_brightness(g15);
> +	else if (g15_led->led >= LG_G15_GAMEMODE)
> +		lg_g710_update_game_led_brightness(g15);
> +	brightness = g15->leds[g15_led->led].brightness;
> +	mutex_unlock(&g15->mutex);
> +
> +	return brightness;
> +}
> +
> +static int lg_g710_mkey_led_set(struct led_classdev *led_cdev,
> +			  enum led_brightness brightness)
> +{
> +	struct lg_g15_led *g15_led =
> +		container_of(led_cdev, struct lg_g15_led, cdev);
> +	struct lg_g15_data *g15 = dev_get_drvdata(led_cdev->dev->parent);
> +	u8 val, mask = 0;
> +	int i, ret;
> +
> +	/* Ignore LED off on unregister / keyboard unplug */
> +	if (led_cdev->flags & LED_UNREGISTERING)
> +		return 0;
> +
> +	mutex_lock(&g15->mutex);
> +
> +	g15->transfer_buf[0] = LG_G710_FEATURE_M_KEYS_LEDS;
> +
> +	for (i = LG_G15_MACRO_PRESET1; i <= LG_G15_MACRO_RECORD; i++) {
> +		if (i == g15_led->led)
> +			val = brightness;
> +		else
> +			val = g15->leds[i].brightness;
> +
> +		if (val)
> +			mask |= 1 << (i - LG_G15_MACRO_PRESET1 + 4);
> +	}
> +
> +	g15->transfer_buf[1] = mask;
> +
> +	ret = hid_hw_raw_request(g15->hdev, LG_G710_FEATURE_M_KEYS_LEDS,
> +				 g15->transfer_buf, 2,
> +				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
> +	if (ret == 2) {
> +		/* Success */
> +		g15_led->brightness = brightness;
> +		ret = 0;
> +	} else {
> +		hid_err(g15->hdev, "Error setting LED brightness: %d\n", ret);
> +		ret = (ret < 0) ? ret : -EIO;
> +	}
> +
> +	mutex_unlock(&g15->mutex);
> +
> +	return ret;
> +}
> +
> +static int lg_g710_kbd_led_set(struct led_classdev *led_cdev,
> +			  enum led_brightness brightness)
> +{
> +	struct lg_g15_led *g15_led =
> +		container_of(led_cdev, struct lg_g15_led, cdev);
> +	struct lg_g15_data *g15 = dev_get_drvdata(led_cdev->dev->parent);
> +	int ret;
> +
> +	/* Ignore LED off on unregister / keyboard unplug */
> +	if (led_cdev->flags & LED_UNREGISTERING)
> +		return 0;
> +
> +	mutex_lock(&g15->mutex);
> +
> +	g15->transfer_buf[0] = LG_G710_FEATURE_BACKLIGHT;
> +	g15->transfer_buf[3] = 0;
> +
> +	if (g15_led->led == LG_G15_KBD_BRIGHTNESS) {
> +		g15->transfer_buf[1] = 4 - g15->leds[LG_G15_LCD_BRIGHTNESS].brightness;
> +		g15->transfer_buf[2] = 4 - brightness;
> +	} else {
> +		g15->transfer_buf[1] = 4 - brightness;
> +		g15->transfer_buf[2] = 4 - g15->leds[LG_G15_KBD_BRIGHTNESS].brightness;
> +	}
> +
> +	ret = hid_hw_raw_request(g15->hdev, LG_G710_FEATURE_BACKLIGHT,
> +				 g15->transfer_buf, 4,
> +				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
> +	if (ret == 4) {
> +		/* Success */
> +		g15_led->brightness = brightness;
> +		ret = 0;
> +	} else {
> +		hid_err(g15->hdev, "Error setting LED brightness: %d\n", ret);
> +		ret = (ret < 0) ? ret : -EIO;
> +	}
> +
> +	mutex_unlock(&g15->mutex);
> +
> +	return ret;
> +}
> +
> +/*
> + * The G710+ has separate physical keys for cycling the main keyboard backlight
> + * and the WASD backlight. The firmware handles the actual brightness change
> + * internally, but GET_REPORT always returns the power-on defaults regardless
> + * of any changes. So we must track the brightness in our cache and cycle it
> + * ourselves when a hardware brightness key press is detected.
> + *
> + * The firmware cycles brightness DOWN: 4 → 3 → 2 → 1 → 0 → 4 (in wire
> + * format where 0 = brightest, 4 = off). In user-facing terms (inverted):
> + * 4 → 3 → 2 → 1 → 0 → 4.
> + *
> + * The game mode toggle is also handled here: the firmware toggles game mode
> + * internally and updates the LED, so we read back the actual state via
> + * GET_REPORT and notify userspace of the change.
> + */
> +static void lg_g710_leds_changed_work(struct work_struct *work)
> +{
> +	struct lg_g15_data *g15 = container_of(work, struct lg_g15_data, work);
> +	enum led_brightness brightness[LG_G15_BRIGHTNESS_MAX];
> +	bool changed[LG_G15_BRIGHTNESS_MAX] = {};
> +	bool gamemode_changed;

This can be simplified a bit, drop the brightness[] array here as 
well as the gamemode_changed bool and make the changed array
LG_G15_LED_MAX entries large.


> +	int i;
> +
> +	mutex_lock(&g15->mutex);
> +	for (i = 0; i < LG_G15_BRIGHTNESS_MAX; i++) {
> +		if (!test_and_clear_bit(i, &g15->brightness_changed))
> +			continue;
> +
> +		changed[i] = true;
> +
> +		if (g15->leds[i].brightness > 0)
> +			g15->leds[i].brightness--;
> +		else
> +			g15->leds[i].brightness =
> +				g15->leds[i].cdev.max_brightness;
> +
> +		brightness[i] = g15->leds[i].brightness;

No need to store in the brightness[i] array you can simply use
g15->leds[i].brightness below.

> +	}
> +
> +	gamemode_changed = test_and_clear_bit(LG_G15_GAMEMODE,
> +					      &g15->brightness_changed);

Use changed[LG_G15_GAMEMODE] here instead of the gamemode_changed bool,
replacing it twice both in the assignment and in the if below.

> +	if (gamemode_changed)
> +		lg_g710_update_game_led_brightness(g15);
> +	mutex_unlock(&g15->mutex);

move this mutex_unlock to below the below for loop.

> +
> +	for (i = 0; i < LG_G15_BRIGHTNESS_MAX; i++) {

and make this loop condition "i < LG_G15_LED_MAX"

> +		if (!changed[i])
> +			continue;
> +
> +		led_classdev_notify_brightness_hw_changed(&g15->leds[i].cdev,
> +							  brightness[i]);

use g15->leds[i].brightness here instead of brightness[i]

> +	}

mutex_unlock() ends up here.



> +
> +	if (gamemode_changed)
> +		led_classdev_notify_brightness_hw_changed(
> +			&g15->leds[LG_G15_GAMEMODE].cdev,
> +			g15->leds[LG_G15_GAMEMODE].brightness);

and this bit can be dropped since this is handled by the loop now :)


> +}
> +
>  /******** Generic LED functions ********/
>  static int lg_g15_get_initial_led_brightness(struct lg_g15_data *g15)
>  {
> @@ -619,6 +861,16 @@ static int lg_g15_get_initial_led_brightness(struct lg_g15_data *g15)
>  			return ret;
>  
>  		return lg_g510_update_mkey_led_brightness(g15);
> +	case LG_G710:
> +		ret = lg_g710_update_game_led_brightness(g15);
> +		if (ret)
> +			return ret;
> +
> +		ret = lg_g710_update_mkey_led_brightness(g15);
> +		if (ret)
> +			return ret;
> +
> +		return lg_g710_update_kbd_led_brightness(g15);
>  	case LG_Z10:
>  		/*
>  		 * Getting the LCD backlight brightness is not supported.
> @@ -890,6 +1142,74 @@ static int lg_g510_leds_event(struct lg_g15_data *g15, u8 *data)
>  	return 0;
>  }
>  
> +static int lg_g710_event(struct lg_g15_data *g15, u8 *data, int size)
> +{
> +	/*
> +	 * Bits 0-5:  G1-G6 keys
> +	 * Bits 6-8:  M1-M3 keys
> +	 * Bit 9:     MR key
> +	 * Bit 10:    WASD backlight cycle (handled as hw brightness change)
> +	 * Bit 11:    Kbd backlight cycle (handled as hw brightness change)
> +	 * Bit 12:    Game mode toggle (LED state change, handled by firmware)
> +	 */
> +	static const u16 keymap[] = {
> +		KEY_MACRO1,
> +		KEY_MACRO2,
> +		KEY_MACRO3,
> +		KEY_MACRO4,
> +		KEY_MACRO5,
> +		KEY_MACRO6,
> +		KEY_MACRO_PRESET1,
> +		KEY_MACRO_PRESET2,
> +		KEY_MACRO_PRESET3,
> +		KEY_MACRO_RECORD_START,
> +		0,	/* WASD illumination cycle - not a key event */
> +		0,	/* Kbd illumination cycle - not a key event */
> +		0,	/* Game mode toggle */
> +	};
> +	u16 pressed_keys, changed;
> +	int i;
> +
> +	if (size != 4 || data[0] != 3)
> +		return 1;
> +
> +	pressed_keys = (data[1] & 0x3f) | ((data[2] & 0xf0) << 2) |
> +		       ((data[3] & 0x7) << 10);
> +	changed = pressed_keys ^ g15->pressed_keys;
> +
> +	for (i = 0; i < ARRAY_SIZE(keymap); i++) {
> +		if (keymap[i] && (changed & BIT(i)))
> +			input_report_key(g15->input, keymap[i],
> +					 pressed_keys & BIT(i));
> +	}
> +	input_sync(g15->input);

There is no need for the changed thing / check here and thus also
no need to remember the previously pressed keys. The input subsystem
is smart enough to not send out events when keys are unchanged from
the previous input_sync() call.

> +
> +	/*
> +	 * Detect brightness key presses (0->1 transition) and schedule
> +	 * the work function to cycle cached brightness and notify userspace.
> +	 * Bit 10 = WASD backlight (maps to LG_G15_LCD_BRIGHTNESS slot).
> +	 * Bit 11 = Kbd backlight (maps to LG_G15_KBD_BRIGHTNESS slot).
> +	 */
> +	if ((changed & BIT(10)) && (pressed_keys & BIT(10))) {
> +		set_bit(LG_G15_LCD_BRIGHTNESS, &g15->brightness_changed);
> +		schedule_work(&g15->work);
> +	}
> +	if ((changed & BIT(11)) && (pressed_keys & BIT(11))) {
> +		set_bit(LG_G15_KBD_BRIGHTNESS, &g15->brightness_changed);
> +		schedule_work(&g15->work);
> +	}
> +
> +	/* Game mode toggle — bit 12 is a state bit, trigger on any change */
> +	if (changed & BIT(12)) {
> +		set_bit(LG_G15_GAMEMODE, &g15->brightness_changed);
> +		schedule_work(&g15->work);
> +	}
> +
> +	g15->pressed_keys = pressed_keys;
> +
> +	return 0;
> +}
> +
>  static int lg_g15_raw_event(struct hid_device *hdev, struct hid_report *report,
>  			    u8 *data, int size)
>  {
> @@ -924,6 +1244,10 @@ static int lg_g15_raw_event(struct hid_device *hdev, struct hid_report *report,
>  		if (data[0] == LG_G510_INPUT_KBD_BACKLIGHT && size == 2)
>  			return lg_g510_leds_event(g15, data);
>  		break;
> +	case LG_G710:
> +		if (data[0] == 0x03 && size == 4)
> +			return lg_g710_event(g15, data, size);
> +		break;
>  	}
>  
>  	return 0;
> @@ -1055,6 +1379,37 @@ static int lg_g15_register_led(struct lg_g15_data *g15, int i, const char *name)
>  			ret = devm_led_classdev_register(&g15->hdev->dev, &g15->leds[i].cdev);
>  		}
>  		break;
> +	case LG_G710:
> +		switch (i) {
> +		case LG_G15_LCD_BRIGHTNESS:
> +			/*
> +			 * The G710+ does not have a separate LCD brightness,
> +			 * but it does have a separate brightness for WASD keys.
> +			 * Do not use the ::kbd_backlight suffix here, UPower
> +			 * only supports one kbd_backlight LED per device.
> +			 */
> +			g15->leds[i].cdev.name = "g15::kbd_zoned_backlight-wasd";
> +			fallthrough;
> +		case LG_G15_KBD_BRIGHTNESS:
> +			g15->leds[i].cdev.brightness_set_blocking =
> +				lg_g710_kbd_led_set;
> +			g15->leds[i].cdev.brightness_get =
> +				lg_g710_led_get;
> +			g15->leds[i].cdev.max_brightness = 4;
> +			g15->leds[i].cdev.flags = LED_BRIGHT_HW_CHANGED;
> +			break;
> +		default:
> +			if (i != LG_G15_GAMEMODE)
> +				g15->leds[i].cdev.brightness_set_blocking =
> +					lg_g710_mkey_led_set;
> +			g15->leds[i].cdev.brightness_get =
> +				lg_g710_led_get;
> +			g15->leds[i].cdev.max_brightness = 1;
> +			if (i == LG_G15_GAMEMODE)
> +				g15->leds[i].cdev.flags = LED_BRIGHT_HW_CHANGED;
> +		}
> +		ret = devm_led_classdev_register(&g15->hdev->dev, &g15->leds[i].cdev);
> +		break;
>  	}
>  
>  	return ret;
> @@ -1079,13 +1434,16 @@ static void lg_g15_init_input_dev_core(struct hid_device *hdev, struct input_dev
>  static void lg_g15_init_input_dev(struct hid_device *hdev, struct input_dev *input,
>  				  const char *name)
>  {
> +	struct lg_g15_data *g15 = hid_get_drvdata(hdev);
>  	int i;
>  
>  	lg_g15_init_input_dev_core(hdev, input, name);
>  
> -	/* Keys below the LCD, intended for controlling a menu on the LCD */
> -	for (i = 0; i < 5; i++)
> -		input_set_capability(input, EV_KEY, KEY_KBD_LCD_MENU1 + i);
> +	if (g15->model != LG_G710) {
> +		/* Keys below the LCD, intended for controlling a menu on the LCD */
> +		for (i = 0; i < 5; i++)
> +			input_set_capability(input, EV_KEY, KEY_KBD_LCD_MENU1 + i);
> +	}

Maybe instead add the following above the for-loop and
leave the for-loop as is? :

	if (g15->model == LG_G710)
		return;

	

>  }
>  
>  static void lg_g13_init_input_dev(struct hid_device *hdev,
> @@ -1119,6 +1477,7 @@ static int lg_g15_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		"g15::macro_preset2",
>  		"g15::macro_preset3",
>  		"g15::macro_record",
> +		"g15::gamemode",
>  	};
>  	u8 gkeys_settings_output_report = 0;
>  	u8 gkeys_settings_feature_report = 0;
> @@ -1137,8 +1496,8 @@ static int lg_g15_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		return ret;
>  
>  	/*
> -	 * Some models have multiple interfaces, we want the interface with
> -	 * the f000.0000 application input report.
> +	 * Some models have multiple interfaces, we want the interface
> +	 * with the ff00.0000 application input report.
>  	 */
>  	rep_enum = &hdev->report_enum[HID_INPUT_REPORT];
>  	list_for_each_entry(rep, &rep_enum->report_list, list) {
> @@ -1212,6 +1571,13 @@ static int lg_g15_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	case LG_Z10:
>  		connect_mask = HID_CONNECT_HIDRAW;
>  		break;
> +	case LG_G710:
> +		INIT_WORK(&g15->work, lg_g710_leds_changed_work);
> +		hdev->quirks |= HID_QUIRK_NOGET;
> +		connect_mask = HID_CONNECT_DEFAULT;
> +		gkeys_settings_feature_report = LG_G710_FEATURE_EXTRA_KEYS;
> +		gkeys = 6;
> +		break;
>  	}
>  
>  	ret = hid_hw_start(hdev, connect_mask);
> @@ -1234,11 +1600,14 @@ static int lg_g15_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	}
>  
>  	if (gkeys_settings_feature_report) {
> +		int report_size = ((g15->model == LG_G710) ?
> +				   gkeys * 2 : gkeys) + 1;
> +

The [0] byte in the transfer buffer is the report-number,
so this should be:

		int report_size = (g15->model == LG_G710) ? gkeys * 2 : gkeys;

>  		g15->transfer_buf[0] = gkeys_settings_feature_report;
> -		memset(g15->transfer_buf + 1, 0, gkeys);
> +		memset(g15->transfer_buf + 1, 0, report_size - 1);

and drop the - 1 here.

>  		ret = hid_hw_raw_request(g15->hdev,
>  				gkeys_settings_feature_report,
> -				g15->transfer_buf, gkeys + 1,
> +				g15->transfer_buf, report_size,

and re-add / keep the + 1 here.

>  				HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
>  	}
>  
> @@ -1327,7 +1696,7 @@ static int lg_g15_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		goto error_hw_stop;
>  
>  	/* Register LED devices */
> -	for (i = 0; i < LG_G15_LED_MAX; i++) {
> +	for (i = 0; i < LG_G15_LED_MAX - (g15->model != LG_G710); i++) {
>  		ret = lg_g15_register_led(g15, i, led_names[i]);
>  		if (ret)
>  			goto error_hw_stop;

The " - (g15->model != LG_G710)" you add here is a bit convoluted.

I would prefer if you change the for condition to:
"i <= LG_G15_MACRO_RECORD" like you've done in other places and then below
the loop add:

	if (g15->model == LG_G710) {
		ret = lg_g15_register_led(g15, LG_G15_GAMEMODE, "g15::gamemode");
		if (ret)
			goto error_hw_stop;
	}

You can then also drop the adding of "g15::gamemode" to led_names[].

This is somewhat more code, but a lot easier to parse / read so IMHO
this is better in the long run keeping readability of the code in mind.

Regards,

Hans


> @@ -1366,6 +1735,10 @@ static const struct hid_device_id lg_g15_devices[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>  			 USB_DEVICE_ID_LOGITECH_G510_USB_AUDIO),
>  		.driver_data = LG_G510_USB_AUDIO },
> +	/* G710 or G710+ */
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> +			 USB_DEVICE_ID_LOGITECH_G710),
> +		.driver_data = LG_G710 },
>  	/* Z-10 speakers */
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>  			 USB_DEVICE_ID_LOGITECH_Z_10_SPK),

