Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D57845FFC7;
	Thu, 17 Sep 2026 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789630214; cv=none; b=gSz+hgBYxTl+bGyhWOCWhSxaWzbJlQkckQZ0/1YKmjyaGaMpfmla1NSalu6GHuCm6inbd4eMIq9Ijje7QvgcLITOsjTO1YM6ERxXYe8mn5Z9LSwmFu2W/CEs1ExQxc/ThnLMyNjFqS5Wx2+mCTfzbOWn3xWZn/MqbEJCWEyLLfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789630214; c=relaxed/simple;
	bh=+Lxj6I+FnZR7jY9+ybwf0bs84V/rS3ly1QC8RAbgZwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWiKUc9HgRu9Zv3rIH6nYwycJwG/Cfj8F4eDVn6whOYoP7y2nz29fTtmKZQY8eUhTnvXo7qFgDnM6GJpxN5aoTrFa+6g0Zs5t+lIX6vcYf+go097EjTeiAtxKJ1Ar5smEBEWHeqDzoOjLXBcxd+UisWut95oDQtA81DRWJtH6uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBd+hGx5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBd+hGx5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781321F000FF;
	Thu, 17 Sep 2026 07:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789630210;
	bh=mjWyoRJj7nRL4q23vXXCkWrdVIuqLTs8i+k3CrXYGhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jBd+hGx54MzKr+CSWGLB1nUntoI37WNZf60y3uPKnsWDPw6dw0MQjfc0/j/AnJoA8
	 5YlSfN7v2pvP+tL11ayldHedkSNe2NLllaXKRmVADlegw4iuP+5i9iylcVWCxM/ien
	 A1dTMzOCf4S6pB10e9dYDWgCenIE0WUoP8t7H49FuVfbyfH5k4Woo06zCQsRe28Ldt
	 HgsleZKN+rP07o1qpTBs5Ug6CPM24PgUe+UCQuDBuyu/ZudPcijXQZTtfXt+AlW5dL
	 9WSmNyDc3r2i8BFHMufwFxvyxKjvw6R0yv1Lc1PN9kRdEahYyyfEYXmL/esJq/851s
	 sBhxzaDKAdg9Q==
Date: Thu, 17 Sep 2026 09:30:06 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Ruzal Daminov <daminovruzal7@gmail.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?utf-8?B?0KDRg9C30LDQu9GM?= <daminovruzal7@gmail.com>
Subject: Re: [PATCH v4] HID: multitouch: add support for Goodix GXTP7863
 touchpad
Message-ID: <aquWNXpJuQr8HLBU@beelink>
References: <20260814171247.16707-1-daminovruzal7@gmail.com>
 <20260819123326.3242-1-daminovruzal7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819123326.3242-1-daminovruzal7@gmail.com>

Hi,

sorry it looks like this one fell through the cracks.

On Aug 19 2026, Ruzal Daminov wrote:
> The Goodix GXTP7863 touchpad controller (VID: 0x27c6, PID: 0x01e0)
> found on Honor MagicBook laptops (e.g. FMI-76 / X14 Plus)
> was missing from the mt_devices[] table.
> 
> As a result, it was claimed by hid-generic, which erroneously mapped
> the vendor telemetry collection (0xFF01) to an input node, translating
> the 1-Hz heartbeat timestamp into an endless loop of phantom
> KEY_BRIGHTNESSUP autorepeat events.
> 
> Fix this by:
>  1. Adding I2C_DEVICE_ID_GOODIX_01E0 to hid-ids.h.
>  2. Adding the device to mt_devices[] with MT_CLS_WIN_8 so hid-multitouch
>     claims the touchpad and retains full Win8 PTP quirks.
>  3. Filtering out the 0xFF01 vendor collection in mt_input_mapping()
>     so the telemetry report is ignored and no phantom input node is
>     created.

FWIW, ou should not describe exactly what the patch does in the commit
description. We can read the code :)

> 
> Tested on Honor MagicBook X14 Plus (FMI-76, AMD Ryzen 8845HS).
> 
> Signed-off-by: Ruzal Daminov <daminovruzal7@gmail.com>
> ---
> v3 -> v4:
>  - Retain MT_CLS_WIN_8 to preserve Win8 PTP quirks, while explicitly
>    filtering out field->application == 0xff010001 in mt_input_mapping()
>    to ignore the vendor telemetry collection.
> v2 -> v3:
>  - Use MT_CLS_DEFAULT to keep export_all_inputs false.
> v1 -> v2:
>  - Move entry to alphabetical order in the Goodix section.
>  - Declare I2C_DEVICE_ID_GOODIX_01E0 in hid-ids.h.
> 
>  drivers/hid/hid-ids.h        |  1 +
>  drivers/hid/hid-multitouch.c | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 1059922baaacd2..60d9d524cd2e15 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -562,6 +562,7 @@
>  #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_E100 0xe100
>  
>  #define I2C_VENDOR_ID_GOODIX		0x27c6
> +#define I2C_DEVICE_ID_GOODIX_01E0	0x01e0
>  #define I2C_DEVICE_ID_GOODIX_01E8	0x01e8
>  #define I2C_DEVICE_ID_GOODIX_01E9	0x01e9
>  #define I2C_DEVICE_ID_GOODIX_01F0	0x01f0
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index edb37b4c867e4b..d2ada08a6b01bf 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1543,6 +1543,12 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  	if (ret != 0)
>  		return ret;
>  
> +	/* Ignore Goodix FreeTouch vendor telemetry collection */
> +	if (hdev->vendor == I2C_VENDOR_ID_GOODIX &&
> +	    hdev->product == I2C_DEVICE_ID_GOODIX_01E0 &&
> +	    field->application == 0xff010001)
> +		return -1;
> +
>  	/* let hid-core decide for the others */
>  	return 0;
>  }
> @@ -2460,6 +2466,11 @@ static const struct hid_device_id mt_devices[] = {
>  		MT_BT_DEVICE(USB_VENDOR_ID_FRUCTEL,
>  			USB_DEVICE_ID_GAMETEL_MT_MODE) },
>  
> +	/* Goodix GXTP7863 Touchpad */
> +	{ .driver_data = MT_CLS_WIN_8,
> +	  HID_DEVICE(BUS_I2C, HID_GROUP_ANY, I2C_VENDOR_ID_GOODIX,

I'm puzzled here: HID_GROUP_ANY? How can this even be working with hid-multitouch?

Are you sure the touchpad part is not already handled by hid-multitouch, but only
the telemetry/phantom event gets assigned to hid-generic?

Can you share the report descriptors of all nodes with hid-recorder so I
can understand why we suddenly have to map to non multitouch devices.

Cheers,
Benjamin

> +		     I2C_DEVICE_ID_GOODIX_01E0) },
> +
>  	/* Goodix GT7868Q devices */
>  	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU,
>  	  HID_DEVICE(BUS_I2C, HID_GROUP_ANY, I2C_VENDOR_ID_GOODIX,
> -- 
> 2.45.2
> 
