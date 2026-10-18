Received: from mta1.migadu.com (out-25.mta1.migadu.com [95.215.58.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF533DB300
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792342643; cv=none; b=ncR/9Lv8ML3GOvKe8VFtFk9pfzEiDJPbOPv4wYHB4vlUQ6VYdepwWWYEoeM8hIIYaQ/XXQLpoGA9QFBLA+SkVhC1aso5gvL37Yi76M47qyUX2IskoCgJg43Sf+kqw2PdFgqUV15nmSRk0bwjEzGeTowx8r4gdVOW6fzvf0I0sDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792342643; c=relaxed/simple;
	bh=O4MbYrdad66SorgorHSE57MaSNqfUI2Gvbh0mmAJiX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MxWNSCOP8eh6CbO9wNPTWAGm2OE7h/iYj3DtwRtijxyvKIcO55wtJAsI7d7sTJQ25vaLU0qH+bzwBomgFT2QzNR0+XrhgRMDoiJluLOXvKlH9XjvnbpcM8d9yfL+2MJnNrX2YTSGnWKnUZlZdhmZgnAQn04IE1h9ZTJZLBINalE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Odx+GV9r; arc=none smtp.client-ip=95.215.58.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Odx+GV9r"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=O4MbYrdad66SorgorHSE57MaSNqfUI2Gvbh0mmAJiX8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792342639; v=1; x=1792947439;
 b=Odx+GV9rjwFzkqBDCf5NLXW3NrzuVEG48G1/T4f6suGe7elJZeEW52kCIsZExliPZWNnARPR
 ckoW7eNjkXyQshxHgvmAa6vdEyRTR9O2TXLS4iq/lNZ2YGod77+VbyEbi14fA60s9WwtrnG7hdp
 Ex9WFYF4WaJAkdM8r2J+bP68=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id facac7dfeedf9400;
	Sun, 18 Oct 2026 16:57:19 +0000
X-Mizu-Trace-ID: facac7dfeedf9400
X-Migadu-Flow: FLOW_OUT
Message-ID: <42cfc8c8-869f-41e2-a58c-0d6c5ce4a6ba@linux.dev>
Date: Sun, 18 Oct 2026 18:57:16 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] HID: asus: add prod-id, quirk for Zenbook Duo
 keyboard
To: Paolo Pisati <p.pisati@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: Luke Jones <luke@ljones.dev>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Joshua Leivenzon <hacker1024@users.sourceforge.net>,
 Ivan Levchenko <me@livan.pro>, =?UTF-8?Q?Rebecca_Mara_M=C3=BCller?=
 <rebecca.mara@posteo.de>, Nathan Chancellor <nathan@kernel.org>
References: <20261013104033.36079-1-p.pisati@gmail.com>
 <20261013104033.36079-7-p.pisati@gmail.com>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20261013104033.36079-7-p.pisati@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/13/26 12:40, Paolo Pisati wrote:
> From: Luke Jones <luke@ljones.dev>

A piece of mail header opening a commit? Never seen this.

I'd say remove this: that this comes from Luke can be deducted
in the Signed-off-by.

My question is why has this not been accepted before? Did I miss
this while we transitioned maintainer? If so apologies.

> The 2024/2025/2026 ASUS Zenbook Duo has a similar keyboard setup as
> many of the ROG range of laptops, with the same init sequence and
> control for backlight. Enable the keyboard control and backlight by:
> - adding the product ID for 2024/2025/2026 Zenbook Duo keyboard MCU
> - adding the Bluetooth Zenbook Duo keyboard IDs
>
> Intended for the UX8406-style product line with the fully removable
> keyboard.
>
> The keyboard also exposes its touchpad as a separate HID device with
> the same IDs, an interface of the USB device and a second device over
> Bluetooth, so bind the IDs to the HID_GROUP_GENERIC group only, like
> the ROG Z13 Folio, and leave the touchpad to hid-multitouch.
>
> Fn-lock is left out for now: with QUIRK_HID_FN_LOCK the Fn-lock report
> is sent to every interface of the device, before the handshake, and on
> the UX8407AA that stalled the hotkey interface for good. It can be
> added back once the driver only sends it where and when it belongs.
>
> Signed-off-by: Luke Jones <luke@ljones.dev>
> Signed-off-by: Joshua Leivenzon <hacker1024@users.sourceforge.net>
> Signed-off-by: Ivan Levchenko <me@livan.pro>
> [pisati: bind the IDs to HID_GROUP_GENERIC only, drop
>  QUIRK_HID_FN_LOCK]
> Assisted-by: LLM

Same as all others regarding Assisted-by.

When you have removed the weird start:

Reviewed-by: Denis Benato <denis.benato@linux.dev>

> Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
> Tested-by: Rebecca Mara Müller <rebecca.mara@posteo.de> # UX8407AA
> ---
>  drivers/hid/hid-asus.c | 24 ++++++++++++++++++++++++
>  drivers/hid/hid-ids.h  |  6 ++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 7b17553e94b6..503396963eeb 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -1849,6 +1849,30 @@ static const struct hid_device_id asus_devices[] = {
>  	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
>  	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
>  		USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD) },
> +	/*
> +	 * Zenbook Duo detachable keyboards. The touchpad shows up as a
> +	 * separate HID device with the same IDs, over USB and Bluetooth:
> +	 * bind to the HID_GROUP_GENERIC group only, like the ROG Z13 Folio,
> +	 * so that hid-multitouch keeps handling it.
> +	 */
> +	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, USB_VENDOR_ID_ASUSTEK,
> +	    USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406MA_KEYBOARD),
> +	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ZENBOOK_DUO_KEYBOARD },
> +	{ HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_GENERIC, USB_VENDOR_ID_ASUSTEK,
> +	    BT_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406MA_KEYBOARD),
> +	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ZENBOOK_DUO_KEYBOARD },
> +	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, USB_VENDOR_ID_ASUSTEK,
> +	    USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406CA_KEYBOARD),
> +	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ZENBOOK_DUO_KEYBOARD },
> +	{ HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_GENERIC, USB_VENDOR_ID_ASUSTEK,
> +	    BT_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406CA_KEYBOARD),
> +	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ZENBOOK_DUO_KEYBOARD },
> +	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, USB_VENDOR_ID_ASUSTEK,
> +	    USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8407AA_KEYBOARD),
> +	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ZENBOOK_DUO_KEYBOARD },
> +	{ HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_GENERIC, USB_VENDOR_ID_ASUSTEK,
> +	    BT_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8407AA_KEYBOARD),
> +	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ZENBOOK_DUO_KEYBOARD },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(hid, asus_devices);
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index b3aca5aa9176..59f44204d738 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -228,6 +228,12 @@
>  #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD	0x1866
>  #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2	0x19b6
>  #define USB_DEVICE_ID_ASUSTEK_ROG_Z13_FOLIO		0x1a30
> +#define USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406MA_KEYBOARD	0x1b2c
> +#define BT_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406MA_KEYBOARD	0x1b2d
> +#define USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406CA_KEYBOARD	0x1bf2
> +#define BT_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406CA_KEYBOARD	0x1bf3
> +#define USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8407AA_KEYBOARD	0x1cd7
> +#define BT_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8407AA_KEYBOARD	0x1cd8
>  #define USB_DEVICE_ID_ASUSTEK_ROG_Z13_LIGHTBAR		0x18c6
>  #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY		0x1abe
>  #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY_X		0x1b4c
