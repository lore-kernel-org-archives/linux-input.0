Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8E2275AF0
	for <linux-input@vger.kernel.org>; Fri, 23 Jan 2026 00:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769127509; cv=none; b=nB8cOHHfo1M+3xdylh6bmQRCWlk9K5GyN+kQydN9pnaRM3wLm+RpAi23PYdxoZ0bsGfesKYTS4QJ1/yW35qa1iIlK45CdKJ06xTkeWM5y4Qe9i91xznbjd4szCFnicJ7iepynC7mEWh8gze61ykKPdjbpg6RWRR8bGDMFEGoBlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769127509; c=relaxed/simple;
	bh=Q/SJsGsgk7eL84/gKD8Uv4nJC7gAPAsh93GZApqY0HQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CuEP8sccgSrRzb4rcJVviLg1gkKtcZxt9Js+7UikRerpS0s+AsMWfurlaNkLxKnkRbxeSwHGLbAcJQ43pcDXd83SFAUOoPvpSYiWHs0R78ezr5j8oYNUV9vJqqO0ggtO4ybClAA39FJOXh2VhhbgkcXg8cb/b3oIsj5Tgg55ncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fa4oNc49; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fa4oNc49"
Message-ID: <7f67a630-128e-4c03-96b6-a42fb54ed09d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769127490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TivSoVh3Lyt4cPCjVhq1jArunJzfvhAo1xHWFJ0uq8Y=;
	b=fa4oNc49/JRGCyAQWaR3XUZM0Ci9LGCQaEpD/kvPGkdtSWQJWNtn3jJbGiQn8XWmvWYfx8
	xADzhRuKp2X7stPIAbVqDZQ846JjsQRaibwVxXwBBWsXOgnOlRJ05aCyGUaT775DWVQKK6
	LiWxkilDKMfc89Yfj2NZhR8b4WDnnjA=
Date: Fri, 23 Jan 2026 01:18:02 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v12 02/11] HID: asus: initialize additional endpoints only
 for certain devices
To: Antheas Kapenekakis <lkml@antheas.dev>,
 platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20260122075044.5070-1-lkml@antheas.dev>
 <20260122075044.5070-3-lkml@antheas.dev>
Content-Language: en-US, it-IT, en-US-large
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20260122075044.5070-3-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/22/26 08:50, Antheas Kapenekakis wrote:
> Currently, ID1/ID2 initializations are performed for all NKEY devices.
> However, ID1 initializations are only required for RGB control and are
> only supported for RGB capable devices. ID2 initializations are only
> required for initializing the Anime display endpoint which is only
> supported on devices with an Anime display. Both of these
> initializations are for functionality that is not present on this driver
> and are performed for devices which might not support them.
>
> At the same time, there are older NKEY devices that have only been
> tested with these initializations in the kernel and it is not possible
> to recheck them. There is a possibility that especially with the ID1
> initialization, certain laptop models might have their shortcuts stop
> working (currently unproven).
>
> To avoid sending unnecessary commands, change to only initialize ID1/ID2
> for those NKEY devices suspected to be problematic without them by
> introducing a quirk for them and replacing the NKEY quirk in the block
> that performs the inits with that. Therefore, new devices that do not
> need (and some do not support) these initializations will not have
> them performed.
>
> In addition, as these initializations might not be supported by the
> affected devices, change the function to not bail if they fail.
Reviewed-by: Denis Benato <benato.denis96@gmail.com>
> Acked-by: Benjamin Tissoires <bentiss@kernel.org>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/hid/hid-asus.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 323e6302bac5..92904b5a700c 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -90,6 +90,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>  #define QUIRK_ROG_NKEY_KEYBOARD		BIT(11)
>  #define QUIRK_ROG_CLAYMORE_II_KEYBOARD BIT(12)
>  #define QUIRK_ROG_ALLY_XPAD		BIT(13)
> +#define QUIRK_ROG_NKEY_ID1ID2_INIT		BIT(14)
>  
>  #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
>  						 QUIRK_NO_INIT_REPORTS | \
> @@ -652,14 +653,9 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
>  	if (!(kbd_func & SUPPORT_KBD_BACKLIGHT))
>  		return -ENODEV;
>  
> -	if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD) {
> -		ret = asus_kbd_init(hdev, FEATURE_KBD_LED_REPORT_ID1);
> -		if (ret < 0)
> -			return ret;
> -
> -		ret = asus_kbd_init(hdev, FEATURE_KBD_LED_REPORT_ID2);
> -		if (ret < 0)
> -			return ret;
> +	if (drvdata->quirks & QUIRK_ROG_NKEY_ID1ID2_INIT) {
> +		asus_kbd_init(hdev, FEATURE_KBD_LED_REPORT_ID1);
> +		asus_kbd_init(hdev, FEATURE_KBD_LED_REPORT_ID2);
>  	}
>  
>  	if (dmi_match(DMI_PRODUCT_FAMILY, "ProArt P16")) {
> @@ -1376,10 +1372,10 @@ static const struct hid_device_id asus_devices[] = {
>  	  QUIRK_USE_KBD_BACKLIGHT },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
>  	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD),
> -	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
> +	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_ROG_NKEY_ID1ID2_INIT },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
>  	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2),
> -	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
> +	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_ROG_NKEY_ID1ID2_INIT },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
>  	    USB_DEVICE_ID_ASUSTEK_ROG_Z13_LIGHTBAR),
>  	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
