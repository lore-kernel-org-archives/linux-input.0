Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8F81F5EA;
	Sat, 21 Feb 2026 02:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771641763; cv=none; b=WeDkbyN7mNLj+56DqxU4c1Q6F2IkDP/Lkf7KNZLZ1eKC+X/GiGveTrU7VMDUlptQ/U8MWfWfVpXr6c/u0Z2/bGXztd0+MEHu/UKj3vGl7MczfAqh01qwvOjDwvGMzYGdC4QkchmgfzDMYETDLjXn81a8YrPmm+DP46t1/jAqfA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771641763; c=relaxed/simple;
	bh=9xzjJksUdob00RqTMrN+1nKTN8dnWrtnkKGJMmaND0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ALvI2fAss5Sf0MNcOetPXNiViP8ZTVRSjUBb4Uo8CcQp6pCFZQBpyOeBRTZabG0g23tRZDEDcuj8UXxsSHnV4jxDqQhlaL5wHYd5O7AxsKaodhOTkWPRuW/8t7y/Ufu4yM28j4bOtbEJrDz2KDwNcjXSMBmI5l9PLCqQ0VQWFE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=gI72VM2s; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gI72VM2s"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fHrxf720Pz9tjn;
	Sat, 21 Feb 2026 03:42:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1771641751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xVBsFUAqDv9GV79aGhrCnZ4kcr3ekjS0IcWz5nFQzn4=;
	b=gI72VM2sr9cQYQJoc5jmWjeW578WUt6q+PBpi9ag1iivhWGzqB/t3dEwvwUQve+nJo3tRE
	JIVkktqGJURnTeeZZF4QIxlCqXf/etVyUaBA47goCsnhHUgCfxwg1+oYawBlHJyA6vE+W/
	KHvDtPwfyi9kCDUQ9oNkhAIzPmDL6Y5Mk04XQ+6zslO8zW0uL1fZT1u7k+nVWyQ2zV8qO0
	iEkkPZFxPOdqWSASY7nCheO3YKtCCSh2HaIT/qBDrARsFRUQ+m91Kgx/eQya9qAX4f+hVi
	HVtIjgzeNizH238HsspRQ0yzcFofuhSZgqQkIPlowBoX8vIOV4MbIuruNgjmtw==
Message-ID: <f0d2a36a-5320-43c9-909b-3c41257c5e48@mailbox.org>
Date: Sat, 21 Feb 2026 03:42:27 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] HID: sony: add support for Rock Band 2 instruments
To: appsforartists@google.com, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sanjay Govind <sanjay.govind9@gmail.com>,
 Antheas Kapenekakis <lkml@antheas.dev>, Vicki Pfau <vi@endrift.com>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>
References: <20260220165047.2844568-1-appsforartists@google.com>
Content-Language: en-US
From: Rosalie <rosalie@mailbox.org>
In-Reply-To: <20260220165047.2844568-1-appsforartists@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 37e53d9960f0414efda
X-MBO-RS-META: oguaoyq1oxgr6whso881b1jh6jt68c51

On 20/02/2026 17:50, appsforartists@google.com wrote:
> From: Brenton Simpson <appsforartists@google.com>
> 
> Rock Band 2 for the Nintendo Wii and for the Sony PlayStation 3 use the
> same mapping as later games:
> 
>      Green:              SOUTH   (A)
>      Red:                EAST    (B)
>      Yellow:             NORTH   (Y)
>      Blue:               WEST    (X)
>      Orange/pedal:       TL      (L1)
>      Solo flag:          TL2     (L2)
>      Tilt:               TR      (R1)
>      Pad flag:           THUMBL  (L3)
>      Instrument button:  MODE    (Steam/Xbox)
>      Whammy bar:         ABS_Z   (Axis 4)
>      Effects switch:     Z       (Axis 5)
> 
> As documented at https://github.com/TheNathannator/PlasticBand/blob/main/Docs/.
> 
> The guitar and drums both use the same mapping.  Tested using the Wii
> versions of the instruments.
> 
> Signed-off-by: Brenton Simpson <appsforartists@google.com>
> ---
>   drivers/hid/hid-ids.h  |  8 +++++++-
>   drivers/hid/hid-sony.c | 45 +++++++++++++++++++++++++++++-------------
>   2 files changed, 38 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 3e299a30dcde..644d3c4df144 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -664,6 +664,10 @@
>   #define USB_DEVICE_ID_UGCI_FLYING	0x0020
>   #define USB_DEVICE_ID_UGCI_FIGHTING	0x0030
>   
> +#define USB_VENDOR_ID_HARMONIX		0x1bad
> +#define USB_DEVICE_ID_HARMONIX_WII_RB2_GUITAR_DONGLE	0x3010
> +#define USB_DEVICE_ID_HARMONIX_WII_RB2_DRUMS_DONGLE	0x3110
> +
>   #define USB_VENDOR_ID_HP		0x03f0
>   #define USB_PRODUCT_ID_HP_ELITE_PRESENTER_MOUSE_464A		0x464a
>   #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A	0x0a4a
> @@ -1299,7 +1303,9 @@
>   
>   #define USB_VENDOR_ID_SONY_RHYTHM	0x12ba
>   #define USB_DEVICE_ID_SONY_PS3WIIU_GHLIVE_DONGLE	0x074b
> -#define USB_DEVICE_ID_SONY_PS3_GUITAR_DONGLE	0x0100
> +#define USB_DEVICE_ID_SONY_PS3_GH_GUITAR_DONGLE		0x0100
> +#define USB_DEVICE_ID_SONY_PS3_RB2_GUITAR_DONGLE	0x0200
> +#define USB_DEVICE_ID_SONY_PS3_RB2_DRUMS_DONGLE		0x0210
>   
>   #define USB_VENDOR_ID_SINO_LITE			0x1345
>   #define USB_DEVICE_ID_SINO_LITE_CONTROLLER	0x3008
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index a89af14e4acc..f6975f6ae882 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -62,9 +62,10 @@
>   #define GH_GUITAR_CONTROLLER      BIT(14)
>   #define GHL_GUITAR_PS3WIIU        BIT(15)
>   #define GHL_GUITAR_PS4            BIT(16)
> -#define RB4_GUITAR_PS4_USB        BIT(17)
> -#define RB4_GUITAR_PS4_BT         BIT(18)
> -#define RB4_GUITAR_PS5            BIT(19)
> +#define RB2_INSTRUMENT            BIT(17)
> +#define RB4_GUITAR_PS4_USB        BIT(18)
> +#define RB4_GUITAR_PS4_BT         BIT(19)
> +#define RB4_GUITAR_PS5            BIT(20)
>   
>   #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT)
>   #define MOTION_CONTROLLER (MOTION_CONTROLLER_USB | MOTION_CONTROLLER_BT)
> @@ -422,12 +423,12 @@ static const unsigned int sixaxis_keymap[] = {
>   	[0x11] = BTN_MODE, /* PS */
>   };
>   
> -static const unsigned int rb4_absmap[] = {
> +static const unsigned int rb_absmap[] = {
>   	[0x30] = ABS_X,
>   	[0x31] = ABS_Y,
>   };


Is the Whammy bar mapped correctly to ABS_Z with this patch, or do the 
instruments not use the rb_absmap array, because the array does not 
contain ABS_Z?

If it doesn't need the rb_absmap array, maybe it'd be better to make a 
separate rb2_instrument_mapping function instead of re-using the 
rb4_guitar_mapping function.

>   
> -static const unsigned int rb4_keymap[] = {
> +static const unsigned int rb_keymap[] = {
>   	[0x1] = BTN_WEST, /* Square */
>   	[0x2] = BTN_SOUTH, /* Cross */
>   	[0x3] = BTN_EAST, /* Circle */
> @@ -625,17 +626,17 @@ static int gh_guitar_mapping(struct hid_device *hdev, struct hid_input *hi,
>   	return 0;
>   }
>   
> -static int rb4_guitar_mapping(struct hid_device *hdev, struct hid_input *hi,
> +static int rb_instrument_mapping(struct hid_device *hdev, struct hid_input *hi,
>   			  struct hid_field *field, struct hid_usage *usage,
>   			  unsigned long **bit, int *max)
>   {
>   	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON) {
>   		unsigned int key = usage->hid & HID_USAGE;
>   
> -		if (key >= ARRAY_SIZE(rb4_keymap))
> +		if (key >= ARRAY_SIZE(rb_keymap))
>   			return 0;
>   
> -		key = rb4_keymap[key];
> +		key = rb_keymap[key];
>   		hid_map_usage_clear(hi, usage, bit, max, EV_KEY, key);
>   		return 1;
>   	} else if ((usage->hid & HID_USAGE_PAGE) == HID_UP_GENDESK) {
> @@ -645,10 +646,10 @@ static int rb4_guitar_mapping(struct hid_device *hdev, struct hid_input *hi,
>   		if (usage->hid == HID_GD_HATSWITCH)
>   			return 0;
>   
> -		if (abs >= ARRAY_SIZE(rb4_absmap))
> +		if (abs >= ARRAY_SIZE(rb_absmap))
>   			return 0;
>   
> -		abs = rb4_absmap[abs];
> +		abs = rb_absmap[abs];
>   		hid_map_usage_clear(hi, usage, bit, max, EV_ABS, abs);
>   		return 1;
>   	}
> @@ -1101,11 +1102,14 @@ static int sony_mapping(struct hid_device *hdev, struct hid_input *hi,
>   	if (sc->quirks & GH_GUITAR_CONTROLLER)
>   		return gh_guitar_mapping(hdev, hi, field, usage, bit, max);
>   
> +	if (sc->quirks & RB2_INSTRUMENT)
> +		return rb_instrument_mapping(hdev, hi, field, usage, bit, max);
> +
>   	if (sc->quirks & (RB4_GUITAR_PS4_USB | RB4_GUITAR_PS4_BT))
> -		return rb4_guitar_mapping(hdev, hi, field, usage, bit, max);
> +		return rb_instrument_mapping(hdev, hi, field, usage, bit, max);
>   
>   	if (sc->quirks & RB4_GUITAR_PS5)
> -		return rb4_guitar_mapping(hdev, hi, field, usage, bit, max);
> +		return rb_instrument_mapping(hdev, hi, field, usage, bit, max);
>   
>   	/* Let hid-core decide for the others */
>   	return 0;
> @@ -2369,12 +2373,25 @@ static const struct hid_device_id sony_devices[] = {
>   	/* Guitar Hero PC Guitar Dongle */
>   	{ HID_USB_DEVICE(USB_VENDOR_ID_REDOCTANE, USB_DEVICE_ID_REDOCTANE_GUITAR_DONGLE),
>   		.driver_data = GH_GUITAR_CONTROLLER },
> -	/* Guitar Hero PS3 World Tour Guitar Dongle */
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_GUITAR_DONGLE),
> +	/* Guitar Hero World Tour PS3 Guitar Dongle */
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_GH_GUITAR_DONGLE),
>   		.driver_data = GH_GUITAR_CONTROLLER },
>   	/* Guitar Hero Live PS4 guitar dongles */
>   	{ HID_USB_DEVICE(USB_VENDOR_ID_REDOCTANE, USB_DEVICE_ID_REDOCTANE_PS4_GHLIVE_DONGLE),
>   		.driver_data = GHL_GUITAR_PS4 | GH_GUITAR_CONTROLLER },
> +	/* Rock Band 2 instruments
> +	 * Nintendo Wii instruments are included in `hid-sony` because `hid-nintendo`
> +	 * is for the newer Nintendo Switch, and the Wii instruments use the same
> +	 * protocol as their Sony PlayStation 3 cousins.
> +	 */
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB2_GUITAR_DONGLE),
> +		.driver_data = RB2_INSTRUMENT },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB2_DRUMS_DONGLE),
> +		.driver_data = RB2_INSTRUMENT },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB2_GUITAR_DONGLE),
> +		.driver_data = RB2_INSTRUMENT },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB2_DRUMS_DONGLE),
> +		.driver_data = RB2_INSTRUMENT },
>   	/* Rock Band 4 PS4 guitars */
>   	{ HID_USB_DEVICE(USB_VENDOR_ID_PDP, USB_DEVICE_ID_PDP_PS4_RIFFMASTER),
>   		.driver_data = RB4_GUITAR_PS4_USB },

