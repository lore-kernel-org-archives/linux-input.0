Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242985;
	b=ovA+Uzw68GVzNFFDkV+YlFCOlikIIGY5/JuTSRbN/WHDsGdb0efZuGKb7A5dItUJ0KOC
	 pIxw/1J7jj3tcqN0o7xsbZhdhMPZNr+e70oskFG3TfceGViQG8X/LGjO0KAu6Q+C28HgP
	 2LE0fSM8qzEoap3ww4C5l463pLRWLyef2Zfa12GnxRMCAR4x1O4PWB982x/O2Z5ZfKrVk
	 /XYjehdi7Y/FZaYy7LxhKBg73OsBw8fA09TxgUJjya1y48V4AFakY59ZP0lb9c+mCt3BS
	 iOXA0sy7eo6cqC268Ilrub2mk8m7a14GwtLHE0/s1jauzwI76wV8svBDh1Dmr7jAeZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242985;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=ntK5gzbhUL208dXGGZmvcLVkuFXD/3KoPHqBMeHnBTY=;
	b=w0rcyA9zb1E5qsQTE8lBHMnseGqvYE4Juf3A2ThREUQozH5IAwrqHqahukOCRvXUu2Aa
	 kDuEmXpd0k6uIpWOIHofvotaTZibHopT9lT5UDsLV3AWC/Lz71OYGWduy2xg5iPrL0uID
	 lWju+SdmAZOC7Awr6gfxUNiBmX+Dqm0H+o8L6F9tCaMKYxe8fXZzxy5FpLJsQ5/wpiAMO
	 x4HEphR1ai2x9Kv0QRTcynOMY1Pb68w4Ex4SJ4/5th40EQGJBuSSZ3fnsoAgg9XWbQeTV
	 /+z4gJCkcyM1ULDiK5gv4KHYZAxMTkYNAJbWIfp/sWqZKjRWy3aiArjXo9W5CK4rs9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Hh58Y2/m";
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5649606A339;
	Mon,  9 Nov 2026 16:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5649606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hh58Y2/m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794242985; x=1825778985;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZYrr7yXEcAfkqcNTcDNMdpQscFbDq1OMas0rdq8GxKg=;
  b=Hh58Y2/m/ID3pC84/h0JqekxrZlrLRLAv/7PoNz6TycPO4OS7MzdEDRr
   iWAyGAdCohTSTAjnzR+f1phLGy9RwLIupVJpSeklLWU8YdstdmshPzA4/
   lFAn7VWBp5TKeFhr4I0nG8X6x5pi5ZE5TYM2IhnhYZETNWdhkXi9ddsQ8
   XrHtCtgWgE2cMo4avQNZss2Vv9jjh1wPE0W21qyztnfdrvRGJQmeuW1Fo
   7tiUzPJ5uoeCS+v4TrhpKbM1tu8QGOw5z8V5Vo2LvOPEPkVasDig5kipC
   JJ2+ADlsZIj6PElA6eoCLAiwdJ19Ba1NgI4ZC2HAIWzvXxWLQM0yCSFIG
   A==;
X-CSE-ConnectionGUID: m1Wc4WmKT1qONzODaw8aMQ==
X-CSE-MsgGUID: FfJLgKQHQRWMgJNVPceCNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3005200"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3005200"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 08:49:44 -0800
X-CSE-ConnectionGUID: /YFCPKe1Q7WTUqSiMEy4Bg==
X-CSE-MsgGUID: IrGSkU9xSQG+QaYaBWhvfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="9653170"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 08:49:42 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Nov 2026 18:49:37 +0200 (EET)
To: Rodnei Cilto <rodnei.cilto@gmail.com>
cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    Ike Panhc <ikepanhc@gmail.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Hans de Goede <hansg@kernel.org>, linux-input@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/2] platform/x86: ideapad-laptop: add CapsLock/NumLock
 LED via EC
In-Reply-To: <20260628-ideapad-kbd-leds-v1-2-50b421d94927@gmail.com>
Message-ID: <82a8e236-d219-3ce5-f6fa-c5ff23d910c3@linux.intel.com>
References: <20260628-ideapad-kbd-leds-v1-0-50b421d94927@gmail.com> <20260628-ideapad-kbd-leds-v1-2-50b421d94927@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 28 Jun 2026, Rodnei Cilto wrote:

> Some Lenovo IdeaPad laptops (e.g. 83RR/83SR, Wildcat Lake) have
> physical CapsLock and NumLock LEDs controlled via the EC.
> 
> The EC exposes CAPL (bit 5) and NUML (bit 4) at offset 0xA1.
> Writing these bits via ec_write() and evaluating _QDF via
> acpi_evaluate_object() causes the firmware to sync EC state to the
> GPIO lines that drive the physical LEDs.
> 
> Discovery via DSDT analysis on Lenovo IdeaPad 83RR (Wildcat Lake):
>   - CAPL/NUML at EC offset 0xA1 (bits 5 and 4)
>   - _QDF (_SB.PC00.LPCB.EC0._QDF) reads CAPL/NUML -> SGOV()
>   - GPIO 0x001A1087 -> CapsLock LED physical pin
>   - GPIO 0x001A0485 -> NumLock LED physical pin
>   - ec_read/ec_write exported via EXPORT_SYMBOL in drivers/acpi/ec.c
>     and declared in <linux/acpi.h>
> 
> Add two led_classdev entries (input::capslock, input::numlock)
> guarded by DMI match (features.kbd_leds) for 83RR and its Brazil
> regional variant 83SR.
> 
> Signed-off-by: Rodnei Cilto <rodnei.cilto@gmail.com>
> ---
>  drivers/platform/x86/lenovo/ideapad-laptop.c | 143 +++++++++++++++++++++++++++
>  1 file changed, 143 insertions(+)
> 
> diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platform/x86/lenovo/ideapad-laptop.c
> index 4fbc904f1fc3..03e3f234067c 100644
> --- a/drivers/platform/x86/lenovo/ideapad-laptop.c
> +++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
> @@ -42,6 +42,17 @@
>  
>  #include <dt-bindings/leds/common.h>
>  
> +/* EC keyboard LED control (IdeaPad EC PS/2 emulation).
> + * Validated on Lenovo IdeaPad 83RR (Wildcat Lake):
> + *   EC offset 0xA1 bit4=NUML, bit5=CAPL
> + *   _QDF syncs EC state to GPIO -> physical LED
> + * ec_read/ec_write declared in <linux/acpi.h>
> + */
> +#define IDEAPAD_EC_KBD_LED_OFFSET	0xA1
> +#define IDEAPAD_EC_KBD_LED_NUML_BIT	BIT(4)
> +#define IDEAPAD_EC_KBD_LED_CAPL_BIT	BIT(5)
> +#define IDEAPAD_ACPI_EC0_QDF_PATH	"\\_SB.PC00.LPCB.EC0._QDF"
> +
>  #define IDEAPAD_RFKILL_DEV_NUM	3
>  
>  enum {
> @@ -198,6 +209,7 @@ struct ideapad_private {
>  		bool ctrl_ps2_aux_port    : 1;
>  		bool usb_charging         : 1;
>  		bool ymc_ec_trigger       : 1;
> +		bool kbd_leds             : 1;
>  	} features;
>  	struct {
>  		bool initialized;
> @@ -210,6 +222,11 @@ struct ideapad_private {
>  		struct led_classdev led;
>  		unsigned int last_brightness;
>  	} fn_lock;
> +	struct {
> +		bool initialized;
> +		struct led_classdev capslock;
> +		struct led_classdev numlock;
> +	} kbd_leds;
>  };
>  
>  static bool no_bt_rfkill;
> @@ -1587,6 +1604,99 @@ static void ideapad_backlight_notify_brightness(struct ideapad_private *priv)
>  /*
>   * keyboard backlight
>   */
> +static int ideapad_kbd_led_ec_set(u8 bit, bool on)
> +{
> +	u8 val;
> +	int err;
> +
> +	err = ec_read(IDEAPAD_EC_KBD_LED_OFFSET, &val);
> +	if (err)
> +		return err;
> +	if (on)
> +		val |= bit;
> +	else
> +		val &= ~bit;
> +	err = ec_write(IDEAPAD_EC_KBD_LED_OFFSET, val);
> +	if (err)
> +		return err;

Hi,

Don't you need to protect this RMW sequence with a lock?

> +	acpi_evaluate_object(NULL, IDEAPAD_ACPI_EC0_QDF_PATH, NULL, NULL);
> +	return 0;
> +}
> +
> +static void ideapad_capslock_led_set(struct led_classdev *led_cdev,
> +				     enum led_brightness brightness)
> +{
> +	ideapad_kbd_led_ec_set(IDEAPAD_EC_KBD_LED_CAPL_BIT, brightness != LED_OFF);
> +}
> +
> +static enum led_brightness ideapad_capslock_led_get(struct led_classdev *led_cdev)
> +{
> +	u8 val;
> +
> +	if (ec_read(IDEAPAD_EC_KBD_LED_OFFSET, &val))
> +		return LED_OFF;
> +	return (val & IDEAPAD_EC_KBD_LED_CAPL_BIT) ? LED_ON : LED_OFF;
> +}
> +
> +static void ideapad_numlock_led_set(struct led_classdev *led_cdev,
> +				    enum led_brightness brightness)
> +{
> +	ideapad_kbd_led_ec_set(IDEAPAD_EC_KBD_LED_NUML_BIT, brightness != LED_OFF);
> +}
> +
> +static enum led_brightness ideapad_numlock_led_get(struct led_classdev *led_cdev)
> +{
> +	u8 val;
> +
> +	if (ec_read(IDEAPAD_EC_KBD_LED_OFFSET, &val))
> +		return LED_OFF;
> +	return (val & IDEAPAD_EC_KBD_LED_NUML_BIT) ? LED_ON : LED_OFF;
> +}
> +
> +static int ideapad_kbd_leds_init(struct ideapad_private *priv)
> +{
> +	int err;
> +
> +	if (WARN_ON(priv->kbd_leds.initialized))
> +		return -EEXIST;
> +
> +	priv->kbd_leds.capslock.name           = "input::capslock";

Documentation/leds/ example seems to have input<number>::capslock ?

You should also cc leds people when sending v2.

> +	priv->kbd_leds.capslock.max_brightness = 1;
> +	priv->kbd_leds.capslock.brightness_set = ideapad_capslock_led_set;
> +	priv->kbd_leds.capslock.brightness_get = ideapad_capslock_led_get;
> +	priv->kbd_leds.capslock.flags          = LED_RETAIN_AT_SHUTDOWN;
> +
> +	err = led_classdev_register(&priv->platform_device->dev,
> +				    &priv->kbd_leds.capslock);
> +	if (err)
> +		return err;
> +
> +	priv->kbd_leds.numlock.name            = "input::numlock";
> +	priv->kbd_leds.numlock.max_brightness  = 1;
> +	priv->kbd_leds.numlock.brightness_set  = ideapad_numlock_led_set;
> +	priv->kbd_leds.numlock.brightness_get  = ideapad_numlock_led_get;
> +	priv->kbd_leds.numlock.flags           = LED_RETAIN_AT_SHUTDOWN;
> +
> +	err = led_classdev_register(&priv->platform_device->dev,
> +				    &priv->kbd_leds.numlock);
> +	if (err) {
> +		led_classdev_unregister(&priv->kbd_leds.capslock);
> +		return err;
> +	}
> +
> +	priv->kbd_leds.initialized = true;
> +	return 0;
> +}
> +
> +static void ideapad_kbd_leds_exit(struct ideapad_private *priv)
> +{
> +	if (!priv->kbd_leds.initialized)
> +		return;
> +	priv->kbd_leds.initialized = false;
> +	led_classdev_unregister(&priv->kbd_leds.numlock);
> +	led_classdev_unregister(&priv->kbd_leds.capslock);
> +}
> +
>  static int ideapad_kbd_bl_check_tristate(int type)
>  {
>  	return (type == KBD_BL_TRISTATE) || (type == KBD_BL_TRISTATE_AUTO);
> @@ -1832,6 +1942,29 @@ static void ideapad_sync_touchpad_state(struct ideapad_private *priv, bool send_
>  	priv->r_touchpad_val = value;
>  }
>  
> +static const struct dmi_system_id ideapad_kbd_leds_dmi_table[] = {
> +	{
> +		/*
> +		 * Lenovo IdeaPad 83RR (Wildcat Lake) - EC PS/2 emulation
> +		 * controls CapsLock/NumLock LEDs via EC offset 0xA1 + _QDF.
> +		 * CAPL=bit5 (0x20), NUML=bit4 (0x10).
> +		 * _QDF drives GPIO via SGOV() to physical LED pins.
> +		 */

Put this comment before the table and generalize it such that it doesn't 
start with the model but only given that as an example.

> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "83RR"),
> +		},
> +	},
> +	{
> +		/* Lenovo IdeaPad 83SR (83RR Brazil regional variant) */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "83SR"),
> +		},
> +	},
> +	{ }
> +};
> +
>  static const struct dmi_system_id ymc_ec_trigger_quirk_dmi_table[] = {
>  	{
>  		/* Lenovo Yoga 7 14ARB7 */
> @@ -2178,6 +2311,8 @@ static int ideapad_check_features(struct ideapad_private *priv)
>  	priv->features.touchpad_ctrl_via_ec = touchpad_ctrl_via_ec;
>  	priv->features.ymc_ec_trigger =
>  		ymc_ec_trigger || dmi_check_system(ymc_ec_trigger_quirk_dmi_table);
> +	priv->features.kbd_leds =
> +		dmi_check_system(ideapad_kbd_leds_dmi_table);

Fits to one line.

>  
>  	if (!read_ec_data(handle, VPCCMD_R_FAN, &val))
>  		priv->features.fan_mode = true;
> @@ -2418,6 +2553,12 @@ static int ideapad_acpi_add(struct platform_device *pdev)
>  			dev_info(&pdev->dev, "FnLock control not available\n");
>  	}
>  
> +	if (priv->features.kbd_leds) {
> +		err = ideapad_kbd_leds_init(priv);
> +		if (err)
> +			dev_warn(&pdev->dev, "Could not set up kbd LEDs: %d\n", err);
> +	}
> +
>  	/*
>  	 * On some models without a hw-switch (the yoga 2 13 at least)
>  	 * VPCCMD_W_RF must be explicitly set to 1 for the wifi to work.
> @@ -2477,6 +2618,7 @@ static int ideapad_acpi_add(struct platform_device *pdev)
>  		ideapad_unregister_rfkill(priv, i);
>  
>  	ideapad_fn_lock_led_exit(priv);
> +	ideapad_kbd_leds_exit(priv);
>  	ideapad_kbd_bl_exit(priv);
>  	ideapad_input_exit(priv);
>  
> @@ -2506,6 +2648,7 @@ static void ideapad_acpi_remove(struct platform_device *pdev)
>  		ideapad_unregister_rfkill(priv, i);
>  
>  	ideapad_fn_lock_led_exit(priv);
> +	ideapad_kbd_leds_exit(priv);
>  	ideapad_kbd_bl_exit(priv);
>  	ideapad_input_exit(priv);
>  	ideapad_debugfs_exit(priv);
> 
> 

-- 
 i.

