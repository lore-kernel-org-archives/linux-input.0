Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD4253F6A7;
	Tue, 22 Sep 2026 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083476; cv=none; b=t6Vf07CUgI1EBLr7upeAF9eiy82h1h5jU9AYbRpZbXDMJTcP5YFEB5JYOYqg9l1ZcCm2bb+AJBdiX9buU5VJB9eyqDntIStjcLrvV10RdBUNofiqrisKvBb1HQUMPoJkNbGggtj7q6lOADh5GhARlqxM9Lt8vex9Y3bJVt6ECZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083476; c=relaxed/simple;
	bh=hJyh5umhjUQzkeY45RG3vnDbHnx2/M79M9xxDDutt38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xtku/GV+JVqtn2YQ9PCyYl+VaY4KSS1E5jxCq1NMAYBoUZVAtgPAvAelkR7omyHbUtDXJ6ByV6KI9+LrPtUFuCVpnr5wbSzBzCV3aY85zAjilrdc075SxIuhWBUZp5W9l9vhsBczLJ6OyoelC31qVDgpezfYo/a2d0Q08WnJTwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2tArx7/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2tArx7/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2695D1F000FF;
	Tue, 22 Sep 2026 13:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790083475;
	bh=4IKfl1+YfXajikiICNppO2guUOhgHdrgVLia+JrRZkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h2tArx7/rELf6MZR+1xFSrMkJ2ZOPDjD01rSWvPCFXUCR6JpT3QyfsnGQZRCONie2
	 JWNF1HdQ2wyH9TMC2NNWMXjlIw3UrYzVgdSyqw43ydqaLcq69vImcSDh0iUvvGNFBu
	 7r/J2ft9UmFI+F7bbyQvWMw4f+Uf3u8BKgk4IozXYiOjbiA4KFo0hJe5qfmCmYZwMw
	 4AKyPvNBs750CR+OWO+AUAhsDEG/FNt2BF5konvGkMSKjo9hfbRikh/tnbM+WH8qPp
	 V+SBSZgQ6U9zaAj2fylK1nW33hFkbb1RvVDbpZjpVwESo+AHar1MIo8vN6OAkfvSXo
	 jzDB+frRFjzfg==
Date: Tue, 22 Sep 2026 15:24:30 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Ruzal <daminovruzal7@gmail.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] HID: multitouch: add support for Goodix GXTP7863
 touchpad
Message-ID: <arJ-vvEvd93l_aAp@beelink>
References: <20260814171247.16707-1-daminovruzal7@gmail.com>
 <20260819123326.3242-1-daminovruzal7@gmail.com>
 <aquWNXpJuQr8HLBU@beelink>
 <51055e02-5bf1-4b1e-b430-382d00d3d004@gmail.com>
 <aqwUYWPz_nORoFr6@beelink>
 <33a7c239-ede5-4091-ba72-ff429d97013c@gmail.com>
 <816a300c-1f63-4d4a-a0f9-8eef5bd7e748@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <816a300c-1f63-4d4a-a0f9-8eef5bd7e748@gmail.com>

Hi,

On Sep 19 2026, Ruzal wrote:
> On 9/18/26 9:01 PM, Ruzal wrote:
> > Both descriptor-level approaches confirm what you suspected: modifying the
> > descriptor still leaves the application collection instantiated as an empty/
> > broken input node, which trips up libinput and blocks the compositor event
> > loop for ~15 seconds.
> 
> Hi Benjamin,
> 
> Quick update on the stall and a tested quirk fix:
> 
> The userspace stall happens because unrecognized vendor pages hit
> `unknown:` in hid-input.c:1420 (`map_abs(ABS_MISC)`). This sets EV_ABS,
> causing hidinput_has_been_populated() to return true and register an
> anomalous node with only ABS_MISC, which trips up libinput.

Actually, after a lot of debugging, it turns out that the session stall
was a red herring: it's hid-replay's behavior which basically only
listen for SET_REPORT events before it is ready, but then ignores
everything else.

And in the case where the UNKNOWN input node didn't have the KEY_*,
systemd-logind would not keep the hid node opened, and would further
re-open it, 3 times, and 3 times we have a timeout of 5 seconds due to
uhid not responding to SET_REPORT.

TL;DR: changing the report descriptor is doable, and there won't be this
session lock with a real device.

Regarding the `map_abs(ABS_MISC)`, you are almost correct. The solution
is simply to not use an unknown vendor usage. the second vendor
collection is 0xff00, which matches HID_UP_MSVENDOR which goes to
ignore.

So making the 0xff01 bogus collection 0xff09 (HID_UP_LOGIVENDOR2) or any
other HID_UP_LOGIVENDOR* also goes to ignore, and the phantom node just
disappears.

And TL;DR of rest, changing the usage page of the report ID 8 from
0xff01 to 0xff09 solves the problem entirely :)

> 
> Instead of touching the descriptor, we can handle this via hid-multitouch:
> - Add MT_QUIRK_IGNORE_VENDOR_TELEMETRY to drop HID_UP_HPVENDOR2 in mt_input_mapping().
> - Add MT_CLS_GOODIX (mirroring MT_CLS_WIN_8 quirks).
> - Bind with HID_GROUP_MULTITOUCH_WIN_8 in mt_devices[] (preserving INPUT_PER_APP).
> 
> This drops the phantom input node while leaving raw reports on /dev/hidraw intact.
> 
> I built the module and tested loading it: /proc/bus/input/devices no longer
> creates the UNKNOWN node, and /dev/hidraw0 remains available.

Thanks for this attempt, however, this is not great because there are
multiple checks for MT_CLS_WIN_8 throughout the code, and so your patch
misses them.

It is not great to have a BPF to work around a kernel bug, but in that
case I think that's the most sensible thing to do. A proper fix is to
restrict the parsing of 0xff01 for non keyboards or for non HP machines,
but as mentioned previously, this is prone to regressions :(

Also, I've just checked the fwupd sources, and I think changing the
vendor collection is fine. Hopefully this won't break any user space
program, but OTOH the touchpad is pretty unusable at the moment.

Cheers,
Benjamin

> 
> Diff:
> 
> ---
>  drivers/hid/hid-ids.h        |  1 +
>  drivers/hid/hid-multitouch.c | 27 +++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index b3aca5aa9176..d0850a98c9f8 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -567,6 +567,7 @@
>  #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_E100 0xe100
>  
>  #define I2C_VENDOR_ID_GOODIX		0x27c6
> +#define I2C_DEVICE_ID_GOODIX_01E0	0x01e0
>  #define I2C_DEVICE_ID_GOODIX_01E8	0x01e8
>  #define I2C_DEVICE_ID_GOODIX_01E9	0x01e9
>  #define I2C_DEVICE_ID_GOODIX_01F0	0x01f0
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 451c7324e6a0..2e973a3b652b 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -79,6 +79,7 @@ MODULE_LICENSE("GPL");
>  #define MT_QUIRK_APPLE_TOUCHBAR		BIT(23)
>  #define MT_QUIRK_YOGABOOK9I		BIT(24)
>  #define MT_QUIRK_KEEP_LATENCY_ON_CLOSE	BIT(25)
> +#define MT_QUIRK_IGNORE_VENDOR_TELEMETRY	BIT(26)
>  
>  #define MT_INPUTMODE_TOUCHSCREEN	0x02
>  #define MT_INPUTMODE_TOUCHPAD		0x03
> @@ -235,6 +236,7 @@ static void mt_post_parse(struct mt_device *td, struct mt_application *app);
>  #define MT_CLS_APPLE_TOUCHBAR			0x0114
>  #define MT_CLS_YOGABOOK9I			0x0115
>  #define MT_CLS_EGALAX_P80H84			0x0116
> +#define MT_CLS_GOODIX				0x0117
>  #define MT_CLS_SIS				0x0457
>  
>  #define MT_DEFAULT_MAXCONTACT	10
> @@ -457,6 +459,15 @@ static const struct mt_class mt_classes[] = {
>  			MT_QUIRK_IGNORE_DUPLICATES |
>  			MT_QUIRK_CONTACT_CNT_ACCURATE,
>  	},
> +	{ .name = MT_CLS_GOODIX,
> +		.quirks = MT_QUIRK_ALWAYS_VALID |
> +			MT_QUIRK_IGNORE_DUPLICATES |
> +			MT_QUIRK_HOVERING |
> +			MT_QUIRK_CONTACT_CNT_ACCURATE |
> +			MT_QUIRK_STICKY_FINGERS |
> +			MT_QUIRK_WIN8_PTP_BUTTONS |
> +			MT_QUIRK_IGNORE_VENDOR_TELEMETRY,
> +		.export_all_inputs = true },
>  	{ }
>  };
>  
> @@ -1524,6 +1535,17 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  		return 1;
>  	}
>  
> +	/*
> +	 * Goodix FreeTouch devices emit a periodic heartbeat on vendor
> +	 * page 0xFF01 which hid-input would otherwise map to
> +	 * KEY_MICMUTE / KEY_BRIGHTNESS*, creating a phantom keyboard.
> +	 * Drop it here so no input node is exported; the report remains
> +	 * available through hidraw.
> +	 */
> +	if ((application->quirks & MT_QUIRK_IGNORE_VENDOR_TELEMETRY) &&
> +	    (usage->hid & HID_USAGE_PAGE) == HID_UP_HPVENDOR2)
> +		return -1;
> +
>  	if (rdata->is_mt_collection)
>  		return mt_touch_input_mapping(hdev, hi, field, usage, bit, max,
>  					      application);
> @@ -2457,6 +2479,11 @@ static const struct hid_device_id mt_devices[] = {
>  	  HID_DEVICE(BUS_I2C, HID_GROUP_ANY, I2C_VENDOR_ID_GOODIX,
>  		     I2C_DEVICE_ID_GOODIX_01E9) },
>  
> +	/* Goodix GXTP7863 device with FreeTouch heartbeat on page 0xFF01 */
> +	{ .driver_data = MT_CLS_GOODIX,
> +	  HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8, I2C_VENDOR_ID_GOODIX,
> +		     I2C_DEVICE_ID_GOODIX_01E0) },
> +
>  	/* GoodTouch panels */
>  	{ .driver_data = MT_CLS_NSMU,
>  		MT_USB_DEVICE(USB_VENDOR_ID_GOODTOUCH,
> 
> If this approach looks good to you, I can formally submit it as [PATCH v5].
> 
> Cheers,
> Ruzal
> 
