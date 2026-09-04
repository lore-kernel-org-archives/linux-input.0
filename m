Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3AC3AFD04
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 07:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788507886; cv=none; b=NLdWR3bLGQPpq4HfE2hZO0D+4oZnqZBJWje+8k8VBIJsEh74J0tvMN7AaFkcgCp07m//pAT5N60NgKNL4PHpzVYcmlOrOzmQ1fi+pbpRVv14DvpEEiw/OhhqnBk+T+6uuay/8ryqrKyMscdAI5m+HFKeg950dhx71DD/snckPe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788507886; c=relaxed/simple;
	bh=XJfoOOen5WJo4Jk2oOFG6YOp7ly6pS1XCizad1mUCsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bfk603Y3zwD8GRQWAfASSOqOhfDXoRGAmyuHfbRGHE7oV1TS+UNryUUJ5VBKfOWLUa4mtARHbm7mmf06pIvmD5dbsoe3zA4H1oYtwGuym6dVFX0drOD877mZTTjsT4I2+m5ewGqE5dkDJ5/1+yU7azG/OdvsSWVlz7Sg4FOXGBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHHsCgc3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHHsCgc3"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-499ae1c6471so5700985e9.3
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2026 00:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788507883; x=1789112683; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tyCK4oRCZPxfmzfrmZ0QgQRfuwenxwr/gnFyVsjBLxc=;
        b=aHHsCgc3jMFx3AgSO0NytSQLpOTY9+FrnKey50/OrLu+/LMzGANgwvoGFbfG0EAbtS
         9+eGPEQuqpIUgwq/dH9bTnZVDhyQoyHbqnUPUuRxSV/4IdTIaSp+HgbN9UIQrG4WznVM
         AwjiOOo40iFdtm+5/itf10W4wG22Ra1yZcRY8OG2uRo4WxTLt2tyaztpdCKNUde/o63F
         OibKyPVB/2qHFdzu6weVulVXIjNTDesGGAqy/u9ijmMaj9udhK7P+lWLIf0OjUJySJ2R
         7iwwADpvVPxxfqLGPzo8Y7OyslJ3hiDyYIfkaoKRdn46ZwspZJqmwhIt7URh7+X4hZdU
         T+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788507883; x=1789112683;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tyCK4oRCZPxfmzfrmZ0QgQRfuwenxwr/gnFyVsjBLxc=;
        b=Zj5kg93j4qoN3heHimHnZgaLJxhjQRMJWZJ7DweUuAZoFOe9s5iwMyX6NwQTQyhM2Y
         IIXGr1oJ1ROWPG57g1OFHPYNDTBMxSE9eP8Bs8FHoHOWJ0zSjzr/Dgvg4+ga+FRArTfP
         5dQigOuwK6CDROwejj6w1ed2UBFVzCgC7Mf2vD3OKbvWSd59n57Z00BTa08kZAz3VmY0
         vIPTtOjp1GL8ky2suXgU1JxwTHZNGSGS5NAY622z0PaGg4jbwVn3vz5fi2cgh9NfbDCe
         wJ3kQU9PKXhkVhut/JVDmIqsUBuSxUKzTRI2qKINFU5bV4qTnPbErRTw3nZBmwH5ASbV
         qD+A==
X-Forwarded-Encrypted: i=1; AKwUvBydTeiOd2wwRaRJoXRxWGM5A9nK2sMjkWGzVEpyFvrIwcCRpUlWkb7+72C/mbW2asvDwcMopS/g2F465g==@vger.kernel.org
X-Gm-Message-State: AFuF++nBj+Hp/aIrQ4sF74OpL1O3To8dFxzh9tv/2kgkx9Kxrum4JbB9
	cCpf/wt+EDfjecIo9VZjVYaQL0j8Hv0eha2kbdFKa9Va26rh7n//KRS1
X-Gm-Gg: AYBFou3TQrPkgjpNA7JKlkOZbL5gRXYVyh660IeY8j6aIfCaArsrAGvJawVyI1CAkIf
	qjpNUjAYUGndT/tN+KXKSEteGVnyntCgiPG1ZLVmH1P5wsbamd96F4iIQHrf9IxCQACF0Zjogcf
	7jZcdrFfBYSES0qKSIaFijUJ3VfZOeJ4weTLy0UYHn41vEXluvw6rafgsgbVThi49xtoTztnXqR
	GQ/Ns5E8y+mQ/y4LTIUoPCaD5dDaFN/fbwRI2Rej2/oMPouiDZQcTD991l6sJD+rZmvjQ1r5esU
	/PK+qMMBopHzPwDFzRi1CG8H4ilchJzRtUlQK4v16rxmz4zS5LJtHIhwIB5LFQ+e+30SPDfrQh1
	YTB8tZ0UOzzpHSbT4TzBvPo0+QHFiCSn2YYWkWaVysmKCTA3IJXTiANB5K67DJUZsK8lhhs28gs
	UGFaSyvOPQ7044YRkur1SDh+oa+qq/ngKhdabXxDGgtk01BqiC7NxixtPZomzATKm/Gatazps11
	i5cJ7k=
X-Received: by 2002:a05:600c:1d01:b0:499:cd34:f7c with SMTP id 5b1f17b1804b1-49cf81e6f87mr57045155e9.5.1788507882924;
        Fri, 04 Sep 2026 00:44:42 -0700 (PDT)
Received: from ?IPV6:2a0c:9a40:8950:f000::3a4? ([2a0c:9a40:8950:f000::3a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf772bd2asm45092245e9.11.2026.09.04.00.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 00:44:42 -0700 (PDT)
Message-ID: <96cd3161-3a6c-455e-a63c-f3226b27f74f@gmail.com>
Date: Fri, 4 Sep 2026 12:44:38 +0500
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: logitech-hidpp: fix hi-res scroll for Bolt-connected
 MX Master
To: Rafael Passos <rafael@rcpassos.me>, lains@riseup.net, hadess@hadess.net,
 jikos@kernel.org, bentiss@kernel.org, erikhakan@gmail.com
Cc: Shuah Khan <skhan@linuxfoundation.org>,
 Brigham Campbell <me@brighamcampbell.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>, linux-input@vger.kernel.org
References: <20260904034843.1340846-1-rafael@rcpassos.me>
Content-Language: en-US
From: Alexey Zagorodnikov <xglooom@gmail.com>
In-Reply-To: <20260904034843.1340846-1-rafael@rcpassos.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, thanks for your patch. I've tested it with my MX Master 4 + Bolt.

I'm not seeing a regression from mainline hid++ enabling, as in Solaar 
high-res scrolling was disabled in my config.

But with hid++ for Bolt enabled by mainline and your patch fixing 
high-res scroll init, I finally got smooth high-res scrolling on MX 
Master 4 via a Bolt connection.

Tested-by: Alexey Zagorodnikov <xglooom@gmail.com>

On 9/4/26 08:48, Rafael Passos wrote:
> The new added support for Logitech HID++ caused this mouse to
> scroll too far for each tic when using the USB dongle (Bolt).
> Previously, this mouse was handled as hid_generic over the Bold
> connection, and logitech-hidpp when over Bluetooth.
>
> Cause:
> Over the Bolt receiver, the mouse reports  are forwarded over the generic
> interface 1, instead of the new HID++ child device. The generic hid does
> now know about the hi-res scrolling used by the HID++.
> In my tests, I discovered this mouse has a multiplier factor of 15. This
> multiplier is only handled by the logitech-hidpp driver. When piped to
> hid_generic, the "hi-res" value was piped to a "low-res" field, making
> the scroll unbearable.
>
> The fix routes the wheel using the HID++, so the ticks are scaled by the
> multiplier and correctly reported as a hi-res event.
>
> I also had to move the hidpp_is_bolt_child function up, to use it in the
> hidpp_connect_event function, where the gate for
> hidpp_initialize_hires_scroll function lives.
>
> Tested with:
> - Logitech MX Master 3S (mouse) via Bolt receiver and Bluetooth.
>
> Fixes: 022eb347ff3a ("HID: logitech: add Bolt receiver support for Logitech HID++ devices")
> Signed-off-by: Rafael Passos <rafael@rcpassos.me>
> ---
>
> Hi,
> I decided to send this patch as soon as I made it work, to try to make
> it into this fix cycle.
>
> I do not have other devices to test this with.
> It would *be great* to have other users testing this.
>
> Lastly, I decided to make all the changes in a single patch.
> But I can break it up if asked.
>
> Thanks,
> Rafael
>
>
>   drivers/hid/hid-logitech-hidpp.c | 47 ++++++++++++++++++++++----------
>   1 file changed, 32 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 1504de32b1c84..960543bfd5ea1 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -3900,6 +3900,19 @@ static int hidpp10_consumer_keys_raw_event(struct hidpp_device *hidpp,
>   	return 1;
>   }
>   
> +static bool hidpp_is_bolt_child(struct hid_device *hdev)
> +{
> +	struct device *parent = hdev->dev.parent;
> +	struct hid_device *receiver_hdev;
> +
> +	if (!parent)
> +		return false;
> +
> +	receiver_hdev = to_hid_device(parent);
> +	return receiver_hdev->vendor == USB_VENDOR_ID_LOGITECH &&
> +	       receiver_hdev->product == USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER;
> +}
> +
>   /* -------------------------------------------------------------------------- */
>   /* High-resolution scroll wheels                                              */
>   /* -------------------------------------------------------------------------- */
> @@ -3910,7 +3923,9 @@ static int hi_res_scroll_enable(struct hidpp_device *hidpp)
>   	u8 multiplier = 1;
>   
>   	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL) {
> -		ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
> +		bool use_hidpp = hidpp_is_bolt_child(hidpp->hid_dev);
> +
> +		ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, use_hidpp);
>   		if (ret == 0)
>   			ret = hidpp_hrw_get_wheel_capability(hidpp, &multiplier);
>   	} else if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_SCROLL) {
> @@ -3998,6 +4013,19 @@ static int hidpp20_hires_wheel_raw_event(struct hidpp_device *hidpp,
>   		return 1;
>   	}
>   
> +	/* wheel movement event: 16-bit signed delta in HID++ ticks */
> +	if ((data[3] & 0xf0) == 0x00 && size >= 7 && hidpp->input &&
> +	    hidpp->vertical_wheel_counter.wheel_multiplier) {
> +		s16 delta = get_unaligned_be16(&data[5]);
> +
> +		if (delta) {
> +			hidpp_scroll_counter_handle_scroll(hidpp->input,
> +				&hidpp->vertical_wheel_counter, delta);
> +			input_sync(hidpp->input);
> +		}
> +		return 1;
> +	}
> +
>   	return 0;
>   }
>   
> @@ -4405,19 +4433,6 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
>   	return ret;
>   }
>   
> -static bool hidpp_is_bolt_child(struct hid_device *hdev)
> -{
> -	struct device *parent = hdev->dev.parent;
> -	struct hid_device *receiver_hdev;
> -
> -	if (!parent)
> -		return false;
> -
> -	receiver_hdev = to_hid_device(parent);
> -	return receiver_hdev->vendor == USB_VENDOR_ID_LOGITECH &&
> -	       receiver_hdev->product == USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER;
> -}
> -
>   static int hidpp_bolt_init(struct hidpp_device *hidpp)
>   {
>   	struct hid_device *hdev = hidpp->hid_dev;
> @@ -4579,7 +4594,9 @@ static void hidpp_connect_event(struct work_struct *work)
>   	}
>   
>   	hidpp_initialize_battery(hidpp);
> -	if (!hid_is_usb(hidpp->hid_dev))
> +
> +	if (!hid_is_usb(hidpp->hid_dev) ||
> +	    hidpp_is_bolt_child(hidpp->hid_dev))
>   		hidpp_initialize_hires_scroll(hidpp);
>   
>   	/* forward current battery state */
