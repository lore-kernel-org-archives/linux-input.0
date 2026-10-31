Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793408901;
	b=XxCZBjuDfdJDbO1nj4Y2Du2jN0Hy4m0PftVv1s/UvmUD15uvdNL2xZg9ssEj0c+CdgeD
	 hFbebsD+34n4t4kTuqmw3/xQlHrj0lVZk4CLvFNtfOXj7WAXk5PkkhAT6JlmPBsRxbk0U
	 nEFZtlE2Zk3zUAwqK0e9fWZDhlmupjNlD88Vne30ApruJr+md/v5J15d9LdJyI6GYOor+
	 nw1YcsB88NPciY6D1+KMm3VZJAIsN7v31eivKIq1m9ZY/H+g4T76EJRmNEoQffbObGoIe
	 z0lHFfNX3qH/uQyu3UFS4pgvxqUFeEGmMaY+AkD97+L3UKSkUNSbtBZbYr3dBjd33Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793408901;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=TQyhV4gdhT8OD6RENB6e2XOj7w/NCctVqQrkN27YNmc=;
	b=GEbxl37P+ahB4YcMbFYrnFMu8Jcwhq7GnVVCR3FB+N+IKwwzPi9Qn82pMCdsfyavONI/
	 GGX1P6nKfP8OuWRP9CIYXVCsoRmmYIb353YhYZbikHufotairBmEAdpAKeM189oUTaZ9d
	 eVPWPs8NApjoF7i/jW/w8ZZ1c/0KQ3lGLS1iHsj3ROGGXWKZ8ivFXgv5Jjd8+SFJA6/go
	 qHlCrjJ6lFmnXCF9HkZ+aQrAeiHiXtrN/QsTkGxwy/lvzRyRS9gPGomLfwURhAe7/0r1G
	 Wb4O7sy6RzeELwA5LOr6u+Cxfgu7A9SrordYdgXw4DRMRYCLjbtrafuDTvzlykrqwwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BY8f38cG;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0A7606A323
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 01:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F0A7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BY8f38cG
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso919101f8f.1
        for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 18:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793408898; x=1794013698; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TQyhV4gdhT8OD6RENB6e2XOj7w/NCctVqQrkN27YNmc=;
        b=BY8f38cGFqqSNMDxRS4xePwGDociNsZ35liLM7owqbgCdCORVwEFWzId2+IMyTDcUY
         F1peZIE0+CViMM4tXIK8ZoD282ltMFS913Zot3cOeHv/c80Do0ikGweReeRmVeBzdrhY
         n8aFFMe8DcSyLmX5qsfXu9gAd5oXH8zB0tdItwBr/WgwVbVld02LjPFF83s7u/UhTTNB
         +icpRkHiiUmkYenfmX//46CzXk62AylBJ38Ra7oK5/XqjXn0XspObO2qsRX75Q/x6/to
         7fovjZ5K/dQSliArs2YuTDsmwWkAuEg8WZYx+KbnPa1+ebU5JS8oUEh6ijAJ7qFXL7+5
         ibyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793408898; x=1794013698;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TQyhV4gdhT8OD6RENB6e2XOj7w/NCctVqQrkN27YNmc=;
        b=0hwDWzO27lDultLoEAjNBC8dw+006IfnXNekZprFXVroidYpmHRpto7k69Z9/UL516
         uZDIcNWFVgtEzT+4Pahfif4CeALyY0oKr6GgHdSsQVX6CvBeJQ1s8r3nhxkOdnz6+NLB
         n3aIUgTpzpgBscDlzuHNxhn8OuqGTiXTgGjoDDNL1Qwrdkkvm3NfRFzj8weW756iMvVY
         MBM0mK1VF/y/17FWh+7jLFwmUsAPzAh8R1FZDNcyZrOfQJJ7Ox2/uW2pER5sD93F21Y7
         vZejqaSgkzw0DY9E/kYqzfNdei3cRGaTo7DhjNIPbKbSBBfWSa7A9mV/gP/1qeWLGcC+
         KlAg==
X-Forwarded-Encrypted: i=1; AKwUvBzcNO9HoXjmW7+Jt5jl7TgmrDSfN/91q0KWfOM/eOGZRHZCAGGCGyYwn2T98ASgGdLQ/4VOAbj77dOlOA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKN9Mes9ZaJ/egnsHdDdPJbXi1Bgz9/V82Wk07PjzHmu3dgQpgC
	F+AJ6OD+yZHFYtf2IvRlIoN4xKQA6w/Ol8g4/EnWT3A9sULPe9ntTfSn
X-Gm-Gg: AYBFou30Yx3SwPPjCNp7/9A2TtdgkRJjX9PIfTGhL3ioMTzGYgGctTGOdCIGalGpZC+
	VMizeIhQMraPg6nJJd3yTjAUs3eXld/ZNd4m+WnwclecrbyyXTKs84PmX0hSPXXrTCUBCfbj8dI
	QMQeTh4LhegHHKc3nTufnpefJznRUObStQWAGlPVUQRrNd0lAYxp2lfH+F7376X6OGzEa8lQmIB
	7OvCPKmrjHw2qtJbStQVE/5Ii9mnJ25OH+chU0Yj8PsBPGlN/yQrX0XcDv2qB5Fh2bhZszPovu3
	THPXnRROgXCppYBEAv+YophmrgUAB7GpkVDEDIXUyfIc3fRMvGX9Q/J9Us0G+l/YK2GgWW0KJYI
	6SyR0WUg/ydza++GrrXDxZFTPKvNehJTgnTF9PM6iJ/uifjRPKdvPD/gbCGMF+vF3sVErz7guOb
	Ir84RYWFpej3a2BvJfVUIu1AWygQAS1WxfiAWW0XJ0vU30nMqqSQHeb8DRVP6su9N68sFcoUZAD
	pO2o4kJSpSY1obB5AtQ847n4lRm+6ymvWDdUe/uP01Hf4qSG/uirLQ8xFX0Xj0GEgmKo+ikDt6V
	hY91B0Mm6r9FyMDncadXzyIT3riMz/p1iw==
X-Received: by 2002:a05:6000:4b0f:b0:48e:68c3:c2c5 with SMTP id ffacd0b85a97d-48e6e4f4c85mr10711252f8f.22.1793408898187;
        Fri, 30 Oct 2026 18:08:18 -0700 (PDT)
Received: from [10.80.0.99] ([151.95.52.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8e5f4sm6085254f8f.40.2026.10.30.18.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 18:08:17 -0700 (PDT)
Message-ID: <e4bbaaf8-f0e7-4537-a8e4-19504fe3582d@gmail.com>
Date: Sat, 31 Oct 2026 02:08:16 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 11/18] HID: asus: add support for btn remapping
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Denis Benato <denis.benato@linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 linux-input@vger.kernel.org, kernel@lists.opengamingcollective.org,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 "Luke D . Jones" <luke@ljones.dev>,
 Mateusz Schwartz <matthew.schwartz@linux.dev>,
 Jonathan LoBue <jlobue10@gmail.com>,
 Khamunetri Clark <khamunetriclark@gmail.com>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Joshua Leivenzon <hacker1024@users.sourceforge.net>,
 Nathan Chancellor <nathan@kernel.org>,
 =?UTF-8?Q?Rebecca_Mara_M=C3=BCller?= <rebecca.mara@posteo.de>,
 Ivan Levchenko <me@livan.pro>, Corentin Chary <corentin.chary@gmail.com>,
 Hans de Goede <hansg@kernel.org>
References: <20261025235232.129945-1-denis.benato@linux.dev>
 <20261025235232.129945-12-denis.benato@linux.dev>
 <8db19c77-735a-1f21-ff08-f3254108d07e@linux.intel.com>
 <7adf0345-14a9-4dac-ad1d-863a7ae4b6e5@linux.dev>
 <46c0df09-9a3c-62f5-322e-6fea93b9c3da@linux.intel.com>
Content-Language: en-US
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <46c0df09-9a3c-62f5-322e-6fea93b9c3da@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/30/26 16:57, Ilpo Järvinen wrote:
> On Fri, 30 Oct 2026, Denis Benato wrote:
>
>> On 10/26/26 15:03, Ilpo Järvinen wrote:
>>> On Sun, 25 Oct 2026, Denis Benato wrote:
>>>
>>>> Add support for buttons remapping: the ability to assign different
>>>> button events to each one of the physical button on the device.
>>>>
>>>> Each button exposes a remap_index sysfs attribute listing the valid
>>>> remap target names for the current gamepad mode: M1 and M2 can be
>>>> remapped to anything at any time, while other buttons may only be
>>>> remapped to gamepad codes in gamepad mode and keyboard/mouse/media
>>>> codes in desktop mode.
>>>>
>>>> When the gamepad mode is changed the firmware automatically restores
>>>> its internal defaults, so the software cache is refreshed to reflect
>>>> the hardware state.
>>>>
>>>> Signed-off-by: Luke Jones <luke@ljones.dev>
>>>> Signed-off-by: Denis Benato <denis.benato@linux.dev>
>>>> Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
>>>> ---
>>>>  drivers/hid/hid-asus.c | 1059 +++++++++++++++++++++++++++++++++++++++-
>>>>  1 file changed, 1037 insertions(+), 22 deletions(-)
>>>>
>>>> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
>>>> index ed95b2cdec81..ea27495c3df6 100644
>>>> --- a/drivers/hid/hid-asus.c
>>>> +++ b/drivers/hid/hid-asus.c
>>>> @@ -275,9 +275,25 @@ struct ally_turbo_config {
>>>>  	struct ally_btn_turbo_params btn_m1;
>>>>  };
>>>>  
>>>> +/* Button remap attribute structure */
>>>> +struct button_remap_attr {
>>>> +	struct device_attribute dev_attr;
>>>> +	enum ally_button_id button_id;
>>>> +	bool is_macro;
>>>> +	/*
>>>> +	 * The attributes are created while hid_asus_ally_probe() is still
>>>> +	 * running, before asus_probe() publishes drvdata->rog_ally: carry
>>>> +	 * the pointer like the turbo entries do, so the callbacks work
>>>> +	 * from the moment the files exist.
>>>> +	 */
>>>> +	struct ally_handheld *ally;
>>>> +};
>>>> +
>>>> +#define to_button_remap_attr(x) container_of(x, struct button_remap_attr, dev_attr)
>>>> +
>>>>  struct ally_btn_sysfs_entry {
>>>>  	struct attribute_group group;
>>>> -	struct attribute *attrs[5]; /* turbo_period + toggle_period + ranges + NULL */
>>>> +	struct attribute *attrs[8]; /* turbo + ranges + remap + macro + remap_index + NULL */
>>>>  	/*
>>>>  	 * The entries are created while hid_asus_ally_probe() is still running,
>>>>  	 * before asus_probe() publishes drvdata->rog_ally: carrying the shared
>>>> @@ -289,6 +305,9 @@ struct ally_btn_sysfs_entry {
>>>>  	enum ally_button_id btn;
>>>>  	struct device_attribute attr_turbo_period;
>>>>  	struct device_attribute attr_toggle_period;
>>>> +	struct button_remap_attr *remap_attr;
>>>> +	struct button_remap_attr *macro_attr;
>>>> +	struct device_attribute attr_remap_index;
>>>>  };
>>>>  
>>>>  enum ally_gamepad_mode_index {
>>>> @@ -296,6 +315,35 @@ enum ally_gamepad_mode_index {
>>>>  	ALLY_GAMEPAD_MODE_KEYBOARD = 0x02,
>>>>  };
>>>>  
>>>> +/* Button pair indexes for mapping commands */
>>>> +enum btn_pair_index {
>>>> +	BTN_PAIR_DPAD_UPDOWN    = 0x01,
>>>> +	BTN_PAIR_DPAD_LEFTRIGHT = 0x02,
>>>> +	BTN_PAIR_STICK_LR       = 0x03,
>>>> +	BTN_PAIR_BUMPER_LR      = 0x04,
>>>> +	BTN_PAIR_AB             = 0x05,
>>>> +	BTN_PAIR_XY             = 0x06,
>>>> +	BTN_PAIR_VIEW_MENU      = 0x07,
>>>> +	BTN_PAIR_M1M2           = 0x08,
>>>> +	BTN_PAIR_TRIGGER_LR     = 0x09,
>>>> +};
>>>> +
>>>> +struct button_map {
>>>> +	const struct btn_code_map *remap;
>>>> +	const struct btn_code_map *macro;
>>>> +};
>>>> +
>>>> +struct button_pair_map {
>>>> +	enum btn_pair_index pair_index;
>>>> +	struct button_map first;
>>>> +	struct button_map second;
>>>> +};
>>>> +
>>>> +/* Store button mapping per gamepad mode */
>>>> +struct ally_button_mapping {
>>>> +	struct button_pair_map button_pairs[9]; /* 9 button pairs */
>>>> +};
>>>> +
>>>>  struct ally_config {
>>>>  	/* Must be locked if the data is being changed */
>>>>  	struct mutex config_mutex;
>>>> @@ -331,6 +379,8 @@ struct ally_config {
>>>>  
>>>>  	struct ally_turbo_config turbo;
>>>>  	struct ally_btn_sysfs_entry *button_entries;
>>>> +	/* Button mappings of the current gamepad mode */
>>>> +	struct ally_button_mapping button_mappings;
>>>>  
>>>>  	struct ally_joystick_resp_curve left_curve;
>>>>  	struct ally_joystick_resp_curve right_curve;
>>>> @@ -1072,6 +1122,295 @@ static int ally_set_gamepad_mode(struct ally_handheld *ally, struct hid_device *
>>>>  	return 0;
>>>>  }
>>>>  
>>>> +enum btn_map_type {
>>>> +	BTN_TYPE_NONE = 0,
>>>> +	BTN_TYPE_PAD = 0x01,
>>>> +	BTN_TYPE_KB = 0x02,
>>>> +	BTN_TYPE_MOUSE = 0x03,
>>>> +	BTN_TYPE_MEDIA = 0x05,
>>>> +};
>>>> +
>>>> +struct btn_code_map {
>>>> +	unsigned char type;
>>>> +	unsigned char value;
>>>> +	const char *name;
>>>> +};
>>>> +
>>>> +static const struct btn_code_map ally_btn_codes[] = {
>>>> +	{ BTN_TYPE_NONE, 0x00, "NONE" },
>>>> +	/* Gamepad button codes */
>>>> +	{ BTN_TYPE_PAD, 0x01, "BTN_SOUTH" },
>>>> +	{ BTN_TYPE_PAD, 0x02, "BTN_EAST" },
>>>> +	{ BTN_TYPE_PAD, 0x03, "BTN_NORTH" },
>>>> +	{ BTN_TYPE_PAD, 0x04, "BTN_WEST" },
>>>> +	{ BTN_TYPE_PAD, 0x05, "BTN_TL" },
>>>> +	{ BTN_TYPE_PAD, 0x06, "BTN_TR" },
>>>> +	{ BTN_TYPE_PAD, 0x07, "BTN_THUMBL" },
>>>> +	{ BTN_TYPE_PAD, 0x08, "BTN_THUMBR" },
>>>> +	{ BTN_TYPE_PAD, 0x09, "ABS_HAT0Y_NEG" },
>>>> +	{ BTN_TYPE_PAD, 0x0A, "ABS_HAT0Y_POS" },
>>>> +	{ BTN_TYPE_PAD, 0x0B, "ABS_HAT0X_NEG" },
>>>> +	{ BTN_TYPE_PAD, 0x0C, "ABS_HAT0X_POS" },
>>>> +	{ BTN_TYPE_PAD, 0x0D, "ABS_Z" },
>>>> +	{ BTN_TYPE_PAD, 0x0E, "ABS_RZ" },
>>>> +	{ BTN_TYPE_PAD, 0x11, "BTN_SELECT" },
>>>> +	{ BTN_TYPE_PAD, 0x12, "BTN_START" },
>>>> +	{ BTN_TYPE_PAD, 0x13, "BTN_MODE" },
>>>> +
>>>> +	/* Keyboard button codes */
>>>> +	{ BTN_TYPE_KB, 0x8E, "FN_M2" },
>>>> +	{ BTN_TYPE_KB, 0x8F, "FN_M1" },
>>>> +	{ BTN_TYPE_KB, 0x76, "KEY_ESC" },
>>>> +	{ BTN_TYPE_KB, 0x05, "KEY_F1" },
>>>> +	{ BTN_TYPE_KB, 0x06, "KEY_F2" },
>>>> +	{ BTN_TYPE_KB, 0x04, "KEY_F3" },
>>>> +	{ BTN_TYPE_KB, 0x0C, "KEY_F4" },
>>>> +	{ BTN_TYPE_KB, 0x03, "KEY_F5" },
>>>> +	{ BTN_TYPE_KB, 0x0B, "KEY_F6" },
>>>> +	{ BTN_TYPE_KB, 0x80, "KEY_F7" },
>>>> +	{ BTN_TYPE_KB, 0x0A, "KEY_F8" },
>>>> +	{ BTN_TYPE_KB, 0x01, "KEY_F9" },
>>>> +	{ BTN_TYPE_KB, 0x09, "KEY_F10" },
>>>> +	{ BTN_TYPE_KB, 0x78, "KEY_F11" },
>>>> +	{ BTN_TYPE_KB, 0x07, "KEY_F12" },
>>>> +	{ BTN_TYPE_KB, 0x08, "KEY_F13" },
>>>> +	{ BTN_TYPE_KB, 0x10, "KEY_F14" },
>>>> +	{ BTN_TYPE_KB, 0x18, "KEY_F15" },
>>>> +	{ BTN_TYPE_KB, 0x0E, "KEY_GRAVE" }, // backtick
>>>> +	{ BTN_TYPE_KB, 0x16, "KEY_1" },
>>>> +	{ BTN_TYPE_KB, 0x1E, "KEY_2" },
>>>> +	{ BTN_TYPE_KB, 0x26, "KEY_3" },
>>>> +	{ BTN_TYPE_KB, 0x25, "KEY_4" },
>>>> +	{ BTN_TYPE_KB, 0x2E, "KEY_5" },
>>>> +	{ BTN_TYPE_KB, 0x36, "KEY_6" },
>>>> +	{ BTN_TYPE_KB, 0x3D, "KEY_7" },
>>>> +	{ BTN_TYPE_KB, 0x3E, "KEY_8" },
>>>> +	{ BTN_TYPE_KB, 0x46, "KEY_9" },
>>>> +	{ BTN_TYPE_KB, 0x45, "KEY_0" },
>>>> +	{ BTN_TYPE_KB, 0x4E, "KEY_MINUS" }, // hyphen
>>>> +	{ BTN_TYPE_KB, 0x55, "KEY_EQUAL" },
>>>> +	{ BTN_TYPE_KB, 0x66, "KEY_BACKSPACE" },
>>>> +	{ BTN_TYPE_KB, 0x0D, "KEY_TAB" },
>>>> +	{ BTN_TYPE_KB, 0x15, "KEY_Q" },
>>>> +	{ BTN_TYPE_KB, 0x1D, "KEY_W" },
>>>> +	{ BTN_TYPE_KB, 0x24, "KEY_E" },
>>>> +	{ BTN_TYPE_KB, 0x2D, "KEY_R" },
>>>> +	{ BTN_TYPE_KB, 0x2C, "KEY_T" },
>>>> +	{ BTN_TYPE_KB, 0x35, "KEY_Y" },
>>>> +	{ BTN_TYPE_KB, 0x3C, "KEY_U" },
>>>> +	{ BTN_TYPE_KB, 0x43, "KEY_I" },
>>>> +	{ BTN_TYPE_KB, 0x44, "KEY_O" },
>>>> +	{ BTN_TYPE_KB, 0x4D, "KEY_P" },
>>>> +	{ BTN_TYPE_KB, 0x54, "KEY_LEFTBRACE" },
>>>> +	{ BTN_TYPE_KB, 0x5B, "KEY_RIGHTBRACE" },
>>>> +	{ BTN_TYPE_KB, 0x5D, "KEY_BACKSLASH" },
>>>> +	{ BTN_TYPE_KB, 0x58, "KEY_CAPSLOCK" },
>>>> +	{ BTN_TYPE_KB, 0x1C, "KEY_A" },
>>>> +	{ BTN_TYPE_KB, 0x1B, "KEY_S" },
>>>> +	{ BTN_TYPE_KB, 0x23, "KEY_D" },
>>>> +	{ BTN_TYPE_KB, 0x2B, "KEY_F" },
>>>> +	{ BTN_TYPE_KB, 0x34, "KEY_G" },
>>>> +	{ BTN_TYPE_KB, 0x33, "KEY_H" },
>>>> +	{ BTN_TYPE_KB, 0x3B, "KEY_J" },
>>>> +	{ BTN_TYPE_KB, 0x42, "KEY_K" },
>>>> +	{ BTN_TYPE_KB, 0x4B, "KEY_L" },
>>>> +	{ BTN_TYPE_KB, 0x4C, "KEY_SEMICOLON" },
>>>> +	{ BTN_TYPE_KB, 0x52, "KEY_APOSTROPHE" },
>>>> +	{ BTN_TYPE_KB, 0x5A, "KEY_ENTER" },
>>>> +	{ BTN_TYPE_KB, 0x88, "KEY_LEFTSHIFT" },
>>>> +	{ BTN_TYPE_KB, 0x1A, "KEY_Z" },
>>>> +	{ BTN_TYPE_KB, 0x22, "KEY_X" },
>>>> +	{ BTN_TYPE_KB, 0x21, "KEY_C" },
>>>> +	{ BTN_TYPE_KB, 0x2A, "KEY_V" },
>>>> +	{ BTN_TYPE_KB, 0x32, "KEY_B" },
>>>> +	{ BTN_TYPE_KB, 0x31, "KEY_N" },
>>>> +	{ BTN_TYPE_KB, 0x3A, "KEY_M" },
>>>> +	{ BTN_TYPE_KB, 0x41, "KEY_COMMA" },
>>>> +	{ BTN_TYPE_KB, 0x49, "KEY_DOT" },
>>>> +	{ BTN_TYPE_KB, 0x4A, "KEY_SLASH" },
>>>> +	{ BTN_TYPE_KB, 0x89, "KEY_RIGHTSHIFT" },
>>>> +	{ BTN_TYPE_KB, 0x82, "KEY_LEFTMETA" },
>>>> +	{ BTN_TYPE_KB, 0x8A, "KEY_LEFTALT" },
>>>> +	{ BTN_TYPE_KB, 0x29, "KEY_SPACE" },
>>>> +	{ BTN_TYPE_KB, 0x8B, "KEY_RIGHTALT" },
>>>> +	{ BTN_TYPE_KB, 0x84, "KEY_COMPOSE" },
>>>> +	{ BTN_TYPE_KB, 0x8D, "KEY_RIGHTCTRL" },
>>>> +	{ BTN_TYPE_KB, 0xC3, "KEY_SYSRQ" },
>>>> +	{ BTN_TYPE_KB, 0x7E, "KEY_SCROLLLOCK" },
>>>> +	{ BTN_TYPE_KB, 0x91, "KEY_PAUSE" },
>>>> +	{ BTN_TYPE_KB, 0xC2, "KEY_INSERT" },
>>>> +	{ BTN_TYPE_KB, 0x94, "KEY_HOME" },
>>>> +	{ BTN_TYPE_KB, 0x96, "KEY_PAGEUP" },
>>>> +	{ BTN_TYPE_KB, 0xC0, "KEY_DELETE" },
>>>> +	{ BTN_TYPE_KB, 0x95, "KEY_END" },
>>>> +	{ BTN_TYPE_KB, 0x97, "KEY_PAGEDOWN" },
>>>> +	{ BTN_TYPE_KB, 0x98, "KEY_UP" },
>>>> +	{ BTN_TYPE_KB, 0x99, "KEY_DOWN" },
>>>> +	{ BTN_TYPE_KB, 0x9A, "KEY_LEFT" },
>>>> +	{ BTN_TYPE_KB, 0x9B, "KEY_RIGHT" },
>>>> +
>>>> +	/* Numpad button codes */
>>>> +	{ BTN_TYPE_KB, 0x77, "KEY_NUMLOCK" },
>>>> +	{ BTN_TYPE_KB, 0x90, "KEY_KPSLASH" },
>>>> +	{ BTN_TYPE_KB, 0x7C, "KEY_KPASTERISK" },
>>>> +	{ BTN_TYPE_KB, 0x7B, "KEY_KPMINUS" },
>>>> +	{ BTN_TYPE_KB, 0x70, "KEY_KP0" },
>>>> +	{ BTN_TYPE_KB, 0x69, "KEY_KP1" },
>>>> +	{ BTN_TYPE_KB, 0x72, "KEY_KP2" },
>>>> +	{ BTN_TYPE_KB, 0x7A, "KEY_KP3" },
>>>> +	{ BTN_TYPE_KB, 0x6B, "KEY_KP4" },
>>>> +	{ BTN_TYPE_KB, 0x73, "KEY_KP5" },
>>>> +	{ BTN_TYPE_KB, 0x74, "KEY_KP6" },
>>>> +	{ BTN_TYPE_KB, 0x6C, "KEY_KP7" },
>>>> +	{ BTN_TYPE_KB, 0x75, "KEY_KP8" },
>>>> +	{ BTN_TYPE_KB, 0x7D, "KEY_KP9" },
>>>> +	{ BTN_TYPE_KB, 0x79, "KEY_KPPLUS" },
>>>> +	{ BTN_TYPE_KB, 0x81, "KEY_KPENTER" },
>>>> +	{ BTN_TYPE_KB, 0x71, "KEY_KPDOT" },
>>>> +
>>>> +	/* Mouse button codes */
>>>> +	{ BTN_TYPE_MOUSE, 0x01, "BTN_LEFT" },
>>>> +	{ BTN_TYPE_MOUSE, 0x02, "BTN_RIGHT" },
>>>> +	{ BTN_TYPE_MOUSE, 0x03, "BTN_MIDDLE" },
>>>> +	{ BTN_TYPE_MOUSE, 0x04, "REL_WHEEL_HI_RES_UP" },
>>>> +	{ BTN_TYPE_MOUSE, 0x05, "REL_WHEEL_HI_RES_DOWN" },
>>>> +
>>>> +	/* Media button codes */
>>>> +	{ BTN_TYPE_MEDIA, 0x16, "MEDIA_SCREENSHOT" },
>>>> +	{ BTN_TYPE_MEDIA, 0x19, "MEDIA_SHOW_KEYBOARD" },
>>>> +	{ BTN_TYPE_MEDIA, 0x1C, "MEDIA_SHOW_DESKTOP" },
>>>> +	{ BTN_TYPE_MEDIA, 0x1E, "MEDIA_START_RECORDING" },
>>>> +	{ BTN_TYPE_MEDIA, 0x01, "MEDIA_MIC_OFF" },
>>>> +	{ BTN_TYPE_MEDIA, 0x02, "MEDIA_VOL_DOWN" },
>>>> +	{ BTN_TYPE_MEDIA, 0x03, "MEDIA_VOL_UP" },
>>>> +};
>>>> +
>>>> +static const size_t keymap_len = ARRAY_SIZE(ally_btn_codes);
>>> Why is this a variable???? Can't the users just directly use ARRAY_SIZE on 
>>> the array????
>> Not understood: you say variable, but both are const(s), isn't const
>> the exact opposite of variable?
> My point was that you should use ARRAY_SIZE(ally_btn_codes) directly in 
> the 2 place (IIRC) instead of keymap_len. Then you can just drop 
> keymap_len entirely.

Aaaaaahhhh... oooohhh. Okay got it now. On it, thank you!

>> I am stepping away for today, but I have cleaned up much of this
>> mess.
>>
>>> At v11 it's odd to find this much garbage still remaining... :-(
>> At a certain (late) point of the development I noticed that remapping
>> buttons on the X applied immediately, while on my Ally 1 it had
>> to go through apply_all old sysfs interface, so I attempted to
>> unify them late on development, sorry.
> I think my comment was a bit uncalled for anyway, but please see it in 
> the light how much lines I had read at that point.

Don't worry, I understand very well. I reworked this patch so many times due to
new discoveries, differences in ally 1 vs vs ally X and random things.....

This patch is the reason the whole driver exists and it is also the weakest spot
because getting attributes out of sync with what gets emitted is super
easy and no readback exists (as far as we know).

Many things made sense when I implemented them, then I had to rework,
mass-replace, rework again etc... And the thing became that long thing
that somehow apparently covers most of the thing (finally).

It is a bit ugly, I agree.

