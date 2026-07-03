Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4D5433E84
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2026 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783094289; cv=none; b=rigQiWu0xu097HJMG+jCCqsXxvBFAUlRRptAsItXNthl6i5xHRkM3qivym8NY08lLUOzBNe9RKQMwutDrPHwMVXsMEPGXoxqSTsu5/Ai671k+V2g3lwkIagvkgR4EF/UjjimAJ60CPIW6OYus70DkaTkuYngLWNKuQxlMdjyMCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783094289; c=relaxed/simple;
	bh=JNAzNt3QmBcxA+ujdjwJOwpS12F9PWSml/EWZbbSP9A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iE9aNHGRxh7f4rX3t44lIchsptbG37V1u2276UffKW8zKhAIbc6twehiKT7rqFsItuVr7rjGaxbGOWs+HeGPQeGgTWpxV2jtwIVJo4Ytn6latVslUZ2qflZOiS/WK2wfdN4dJIQb8o5NqNJ58UwKJo0hZAUPtdBR8bJ4iLh4KBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsFOYiK3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsFOYiK3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B526D1F000E9;
	Fri,  3 Jul 2026 15:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783094288;
	bh=dCTaCOsndZV6MiDi9iFS7L2rCALGQUPHMHuxAFjCcSM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hsFOYiK3njnZjK9y/0q6o5fdcsDCdYopSNi45kDEZD5+QaLyQVqpbD0eTOwqyUWUY
	 jGt/Cfs7xhD0CxmuhiNO/K1KWBeJQonOsvcqHNlTDf90kIFm8ZBhtn3uE7MbPbJxfJ
	 dar4eRlYVq58vFvi4/aJxGEs5zrqbltpfEBHQoYTtGQFO/pvUl81Uh3SWaS+1avDvk
	 ityZ/0kWFkxarsV92RAfI71DFEwUh4kERsB9Ey3jZkG6sygvMqtM+d9zz/N3gIIEYD
	 pIcfgDPlZaW9C59P2Jhg5Uybt+IbENz9GoJaN/BR53SXhyLs4+uT7enyYF1SU6zYCv
	 yYadgauUjvJTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] HID: asus: fix missing hid_is_usb() check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jann Horn" <jannh@google.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260703-hid-usbcheck-v2-1-c5ed7bc94772@google.com>
References: <20260703-hid-usbcheck-v2-0-c5ed7bc94772@google.com>
 <20260703-hid-usbcheck-v2-1-c5ed7bc94772@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 15:58:07 +0000
Message-Id: <20260703155807.B526D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Dangling pointer in `drvdata->kbd_backlight` leading to Use-After-=
Free when WMI listener registration fails.
--

commit 0bcf68d0cd670d6cc4fac38b7be14d0855140731
Author: Jann Horn <jannh@google.com>

HID: asus: fix missing hid_is_usb() check

This commit fixes a kernel splat caused by uhid devices that identify as
being on BUS_USB without actually having a USB parent. It adds a missing
hid_is_usb() check before calling to_usb_interface().

Cc: stable@vger.kernel.org

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 3f5e96900b67a..befa990b3210e 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -753,7 +753,7 @@ static int asus_kbd_register_leds(struct hid_device *=
hdev)
>  			return ret;
>  	}
> =20
> -	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
> +	if ((drvdata->quirks & QUIRK_ROG_ALLY_XPAD) && hid_is_usb(hdev)) {
>  		intf =3D to_usb_interface(hdev->dev.parent);
>  		udev =3D interface_to_usbdev(intf);
>  		validate_mcu_fw_version(hdev,

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential
use-after-free later in this same function.

When asus_hid_register_listener() fails, the code frees the backlight=20
structure but leaves the pointer dangling:

drivers/hid/hid-asus.c:asus_kbd_register_leds() {
    ...
    ret =3D asus_hid_register_listener(&drvdata->kbd_backlight->listener);
    if (ret < 0) {
        /* No need to have this still around */
        devm_kfree(&hdev->dev, drvdata->kbd_backlight);
    }
    return ret;
}

Since asus_probe() logs a warning but continues successfully when this
fails, could this cause a use-after-free during device removal or
suspend?

It looks like asus_remove() checks if the pointer is non-null before
dereferencing it:

drivers/hid/hid-asus.c:asus_remove() {
    ...
    if (drvdata->kbd_backlight) {
        asus_hid_unregister_listener(&drvdata->kbd_backlight->listener);
        spin_lock_irqsave(&drvdata->kbd_backlight->lock, flags);
    ...
}

Should drvdata->kbd_backlight be set to NULL after being freed to prevent
this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-hid-usbche=
ck-v2-0-c5ed7bc94772@google.com?part=3D1
