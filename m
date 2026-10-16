Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778094C33D2
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158532; cv=none; b=jfotMx8I+9WfGOck3Px/ZCsCdDDIyPMQp+vdI+Yd/MHTX3uhkgn7SlFRpK0KNCd9pqe7IpycLhTCScn6fpJhz8mF9UfshHRXbn5RFujLlcsGRkkhlYvZK0RLWLgYmoWeT01Ebff4POfLSHVNYG4sJuiMEK0ooL7KY4K5sMR9DwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158532; c=relaxed/simple;
	bh=s+Ocuf9AClaa114XTl3PwUOWvukHAMxQXpRwxuaDpUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNm1ctQPOL29lbVdU0iQQIHsjCZJUFeAIaJB+hC8aSuG64iolPO70PCAmdn9BK3dZoxCYUj74ZeMjzNVE1oKlaTNGfjeiROASpiTA8qLVh3qMdReomNJwmINTcqhPWOx9mlP/j5W/pYs1J2M0/sLwQZKzgPLrZq5KMm74uRB/Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+YfZAFm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+YfZAFm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DD91F000C6;
	Fri, 16 Oct 2026 13:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792158531;
	bh=CSsrYw6gu/4BUrbdCHMm+09Dvhobcum1ZfjDaRmnaXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D+YfZAFmnd+0msLkD1Pd7HWLzX12WgSR2LxpCMHXBYUt99RIvsa6AtRQpUm0QUGm/
	 CGnBnYi26z6r3P27EuECn2pHIFVat7+LhrVweHUoDbOB2FOoLYLM8wxo+i2bZBS/9O
	 jbBF0UxRKprgQkpDBDq4c9kw2D5J3VCK/Q8dhno0USQUqWJr84SqxRrrPcQFFSkV//
	 Scxp64l3r7z631D1qf1liId4+7cNXN8pXlZ4EkAAejNaeswsI/7ZpwYBtFFl3LWuwu
	 rkJrq4YsaD94c+V3SIly5B3oRHBR/4DzPd7+teFGYuoN+sCtP1dyaVgIotboyX9SaP
	 NRw7uHiQy8q4g==
Date: Fri, 16 Oct 2026 15:48:47 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: synonym <20000l@pm.me>, 
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "luke@ljones.dev" <luke@ljones.dev>, 
	"benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
Subject: Re: ASUS T302CHI keyboard dock (0b05:182f) missing from hid-asus,
 brightness keys dead
Message-ID: <atIq520WDeOgyAJD@beelink>
References: <OCupKvK8JTzwwSrGfH05iZGTNOuUCg3cPoiTlNgdDUUt24LbtaNYWciyGx1C90egfE2C8EdnANX7sXM6IwBh5xfycQNq-ji_xAuNLRAVvQQ=@pm.me>
 <o1392s9p-6rrq-3179-289p-447n1703pp1p@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o1392s9p-6rrq-3179-289p-447n1703pp1p@xreary.bet>

On Oct 16 2026, Jiri Kosina wrote:
> From: Jiri Kosina <jkosina@suse.com>

You are missing a proper title, and FWIW, b4 doesn't recognize this as a
patch.

> 
> synonym reports: "The dock (USB 0b05:182f) reports brightness on the ASUS
> vendor usage page 0xff31, usages 0x10 and 0x20, which hid-asus already maps to
> KEY_BRIGHTNESSDOWN / KEY_BRIGHTNESSUP. Because the device is not in
> asus_devices[], it is claimed by hid-generic, which ignores the vendor page
> entirely, so Fn+F5 and Fn+F6 produce no input events at all - not even a
> scancode. Keys on the standard consumer page (volume) on the same device work
> fine, which makes this look like a backlight or ACPI problem rather than a HID
> one."
> 
> Add the device ID.
> 
> Reported-by: synonym <20000l@pm.me>
> Signed-off-by: Jiri Kosina <jkosina@suse.com>

Anyway, feel free to push it to for-7.4/hid-asus with my:

Acked-by: Benjamin Tissoires <bentiss@kernel.org>

Cheers,
Benjamin

> ---
>  drivers/hid/hid-asus.c | 2 ++
>  drivers/hid/hid-ids.h  | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index ec966fc0a411..42655a6d59d9 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -1733,6 +1733,8 @@ static const struct hid_device_id asus_devices[] = {
>  	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
>  	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
>  		USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD) },
> +	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
> +		USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T302CHI_KEYBOARD) },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(hid, asus_devices);
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 43bbddf84e61..63d69d49ee50 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -218,6 +218,7 @@
>  #define USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD	0x1807
>  #define USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD	0x8502
>  #define USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD	0x183d
> +#define USB_DEVICE_ID_ASUSTEK_T302CHI_KEYBOARD	0x182f
>  #define USB_DEVICE_ID_ASUSTEK_T304_KEYBOARD	0x184a
>  #define USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD	0x8585
>  #define USB_DEVICE_ID_ASUSTEK_I2C_ZENBOOK_KEYBOARD	0x4b42
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 
> 
