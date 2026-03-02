Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A43800
	for <linux-input@vger.kernel.org>; Mon,  2 Mar 2026 00:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772412289; cv=none; b=I+8az1Dht6ce2VUHPTOTUZy+tXWKw3QwSrjBC8JUl+cK+hFJBUfvZGrI8xRelhC0jDoR5aqIVEckJkp7CfDhMSrB+TtW0x8UGEk3D6pjVGZzBIqO3bDUfjm3zjr9vRwffAzFFKe8z6VtIyN8RQIjdaLgxlLJnfD/GP5NpMHAPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772412289; c=relaxed/simple;
	bh=e7MT3eZOB4RWi4Ip9ErYj33sUKowL739m01VsA54wV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRT/l6RKVX7G4hJNga4gJRj2oLbvYgROUSr/jsBqkFrEZ2cndoaZVLIJ1dgL+IPm4cpDMi5/TZ4ldcdifou2MEYwHOCUBtj/mKC/bSie9iaP6XBKcXkUF453AKr/YdHDZ1bxEZCyyMcQwbp12j0Sj2LWDC5ck8bXxyPGMTQ/9bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVlxyjJP; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVlxyjJP"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2be0711f493so121500eec.0
        for <linux-input@vger.kernel.org>; Sun, 01 Mar 2026 16:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772412287; x=1773017087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VtsMvB6OPf6TfYp2Htw6c9h5hyInU/3hP+InG0kKDEQ=;
        b=UVlxyjJPt5B9YaTrtuTKk87YVIuKKkng+otHV+vSVYh/oMoqvYqwZVKyoUtNYfRBok
         /sREEbAeC0tjGz5u6+Vl5FBRuXOCVPfdZRW0QEXlny11jh4vDqnLC2y727BE5A9fcITk
         biQxvKCA6Rd0FTi+UACvjWWAVXMlUIYPtKRww8/bMmvQVGqAIpjAGcLdhzJ5mcB6QPTG
         +cEObIPZlqORLNKah09tE0xqx5is8lVdqAJXmj49nWWl6roLUE7uyOQQIBjqZwOSbtua
         RbFmKDIUCmzI+OAGU3qYsMKT7n/ZcEE9MwCVSN57hhP+sG4q0W2p2yzl4loCtJ/Indgc
         nxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772412287; x=1773017087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VtsMvB6OPf6TfYp2Htw6c9h5hyInU/3hP+InG0kKDEQ=;
        b=kfloa20rpyMkjBR8MfIraZgrMq7fmL/wuu+gTOt/WGDSae5r2u4nmgtSaQMY5TXuHQ
         MqQRJ1m9pdNjY7MAdQ8Y05aC4ByF5XM9oywH5DKxZaENinBldzzEGWelIUVAqKUuLW8D
         DwdmrRrnvz75ozn0Am4OFDbMFrP/vecmRgB2Nv/+ZJqSYEINwS4lO07rY6XkfyGGTvvn
         DV+UoxPqfE3JmStUGdM2eWXcINDdqeBClFg9vp8k60IEByWE7NwkR+BtOnA4sgWWgWlU
         BNccU7+9HtgC+U7rmFZD4noMfDhf660sLHaWKmyCOJdte51nEhL/mRq5CHf+Df7pM2oE
         Taqg==
X-Forwarded-Encrypted: i=1; AJvYcCUNRf2MRDIwUxDGNwJVqLg7XL208od0VKAw8yKfSYFGv8kWL2dx9g26SW2cSA088k7hXKUbUuLscEBsHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzysQ1I07dn6Ez0zFUPObe0lEKDkhyb3M88eUyoorRHZ67NjeE4
	tFUDkv6BuN35NP1hCY+skPqAHvAvHwIrNSiq9VNZT4M2NkA4koQtmcTX7SCSWA==
X-Gm-Gg: ATEYQzx2Dsxy8ImphgSt37Rqk7N1mMAahgFEwpHzrvdBkIu6bJj+pjGr9ZqA+0KzO5Q
	N/w4HJ+kPIMb6TtYFro5xfUS7luKXEuFPHzVl2JRKl5ObWu1TnSCGNyEFZheXSrVC9tCxNgfJUV
	AjxicBbM9vXDhskVZVhmXkUfhNhNG9j2dntFG20XBi7KIEQBXJ72vgZudlidvpss6me9pQ2tNyX
	9gzMMjqruI3ni5ax/A9UmzOeZY8+OSATHfNBZ/mWhsqAFXbYEOFRlV311ivN5cSV6hX2dSreBWB
	CJCnoG7EAwUThQzstGQGCnEA5slN0aN+ZzNIFMqRf5i720ju7WMerokmhHVMknUW8MlmFdby/mv
	0zhJdqjiifvt1MP2n8f3B1Q35tLcP9/6rlvFtZkRRN5HDOk+Sn1pj3ksAzMw2aENsnxIOGa04kX
	M2+jKSk0iX5Ww/+AP0goUMyHuvSlTEAPppIEhWcciBTYEs9osIIvHOXTn/VHEnIYln+8HisCLo2
	aM=
X-Received: by 2002:a05:7300:f187:b0:2be:969:75f6 with SMTP id 5a478bee46e88-2be09697acbmr1055348eec.9.1772412286891;
        Sun, 01 Mar 2026 16:44:46 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:864f:8513:57d0:4064])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be03fc6fcesm3195687eec.1.2026.03.01.16.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 16:44:46 -0800 (PST)
Date: Sun, 1 Mar 2026 16:44:43 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>, 
	Sebastian Reichel <sre@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, ggrundik@gmail.com
Subject: Re: [PATCH 2/2] HID: input: Add HID_BATTERY_QUIRK_DYNAMIC for Elan
 touchscreens
Message-ID: <aaTZIcPuY3qz5MJm@google.com>
References: <20260228145258.76937-1-johannes.goede@oss.qualcomm.com>
 <20260228145258.76937-2-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228145258.76937-2-johannes.goede@oss.qualcomm.com>

Hi Hans,

On Sat, Feb 28, 2026 at 03:52:58PM +0100, Hans de Goede wrote:
> Elan touchscreens have a HID-battery device for the stylus which is always
> there even if there is no stylus.
> 
> This is causing upower to report an empty battery for the stylus and some
> desktop-environments will show a notification about this, which is quite
> annoying.
> 
> Because of this the HID-battery is being ignored on all Elan I2c and USB
> touchscreens, but this causes there to be no battery reporting for
> the stylus at all.
> 
> This adds a new HID_BATTERY_QUIRK_DYNAMIC and uses these for the Elan
> touchscreens.
> 
> This new quirks causes the present value of the battery to start at 0,
> which will make userspace ignore it and only sets present to 1 after
> receiving a battery input report which only happens when the stylus
> gets in range.

My understanding was that "present" attribute is to be used for
removable batteries (i.e. when a battery can be extracted from either
from the system or from a peripheral) and we want to notify userspace of
that fact). For example, if a laptop can have an additional battery UI
can show if it is installed or not, and it should not simply ignore such
power supplies.

On the other hand the "Unknown" operating status signals that we
actually do not know the state of the battery, and fits better in our
situation.

Anyway, I think we need Sebastian's input here.

> 
> Reported-by: ggrundik@gmail.com
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221118
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> ---
>  drivers/hid/hid-input.c | 14 +++++++++++---
>  include/linux/hid.h     |  1 +
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 67ca1e88ce13..8fc20df99b97 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -354,6 +354,7 @@ static enum power_supply_property hidinput_battery_props[] = {
>  #define HID_BATTERY_QUIRK_FEATURE	(1 << 1) /* ask for feature report */
>  #define HID_BATTERY_QUIRK_IGNORE	(1 << 2) /* completely ignore the battery */
>  #define HID_BATTERY_QUIRK_AVOID_QUERY	(1 << 3) /* do not query the battery */
> +#define HID_BATTERY_QUIRK_DYNAMIC	(1 << 4) /* report present only after life signs */
>  
>  static const struct hid_device_id hid_battery_quirks[] = {
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
> @@ -398,8 +399,8 @@ static const struct hid_device_id hid_battery_quirks[] = {
>  	 * Elan HID touchscreens seem to all report a non present battery,
>  	 * set HID_BATTERY_QUIRK_IGNORE for all Elan I2C and USB HID devices.
>  	 */
> -	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_IGNORE },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_IGNORE },
> +	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_DYNAMIC },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_DYNAMIC },
>  	{}
>  };
>  
> @@ -456,11 +457,14 @@ static int hidinput_get_battery_property(struct power_supply *psy,
>  	int ret = 0;
>  
>  	switch (prop) {
> -	case POWER_SUPPLY_PROP_PRESENT:
>  	case POWER_SUPPLY_PROP_ONLINE:
>  		val->intval = 1;
>  		break;
>  
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval = dev->battery_present;
> +		break;
> +
>  	case POWER_SUPPLY_PROP_CAPACITY:
>  		if (dev->battery_status != HID_BATTERY_REPORTED &&
>  		    !dev->battery_avoid_query) {
> @@ -573,6 +577,8 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
>  	if (quirks & HID_BATTERY_QUIRK_AVOID_QUERY)
>  		dev->battery_avoid_query = true;
>  
> +	dev->battery_present = (quirks & HID_BATTERY_QUIRK_DYNAMIC) ? false : true;
> +
>  	dev->battery = power_supply_register(&dev->dev, psy_desc, &psy_cfg);
>  	if (IS_ERR(dev->battery)) {
>  		error = PTR_ERR(dev->battery);
> @@ -628,6 +634,7 @@ static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
>  		return;
>  
>  	if (hidinput_update_battery_charge_status(dev, usage, value)) {
> +		dev->battery_present = true;
>  		power_supply_changed(dev->battery);
>  		return;
>  	}
> @@ -643,6 +650,7 @@ static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
>  	if (dev->battery_status != HID_BATTERY_REPORTED ||
>  	    capacity != dev->battery_capacity ||
>  	    ktime_after(ktime_get_coarse(), dev->battery_ratelimit_time)) {
> +		dev->battery_present = true;
>  		dev->battery_capacity = capacity;
>  		dev->battery_status = HID_BATTERY_REPORTED;
>  		dev->battery_ratelimit_time =
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index dce862cafbbd..d9b54f0e8671 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -682,6 +682,7 @@ struct hid_device {
>  	__s32 battery_charge_status;
>  	enum hid_battery_status battery_status;
>  	bool battery_avoid_query;
> +	bool battery_present;
>  	ktime_t battery_ratelimit_time;
>  #endif
>  

Thanks.

-- 
Dmitry
