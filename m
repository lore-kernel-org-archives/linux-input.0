Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BD5233937
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2026 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092739; cv=none; b=KNcReJpDGf+/UpO2CpWbTNcwUdS0cRtjcEMR924MbfQ04PzZPgFLaDFzbHzq24xkK2UmMfb851TkFsgMsMAtn5IO518yJEERAgZT/S3+1sG9QzrPBXkpgFOL1mt0c+svLYRREjNzz9GMXuhbbRx6xOA8milYGYMSSSPQOxLGijY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092739; c=relaxed/simple;
	bh=QHmhdNPTnYE+V2nZJ1EqYN4kSkFoE0XZcQI2Mm2GLQc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EQxstZ+D+72Nmq3pDcxBwy9PQc0qdyBoVu5scmlmwRH3dtwtIF0lwlVh9rZPPh81JhdLzQAmx1n2Luv8FGK1BOYekuVHyJLbFhJVKylZVXZiea01ChfqgnaRindeXQ7OcRykamiBQ7hlKEHflT6JgxXAYmOy/nIUkxlx96zG+20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRgO81Y+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRgO81Y+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3C61F000E9;
	Fri,  3 Jul 2026 15:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783092738;
	bh=7EX+gelH0YbbMbZqOtespi7gRD4ggtqGBygmLtRlCeU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LRgO81Y+or1fBZ5vziYkaGRjrPLTGvoLL+GxkqIFvOwkxqDxTDvhs83LtHdw0Ccwo
	 2mtKqQSEN05HmnwtF5XO0YFyONMnm/tzS/vbIA3I1nFJ2BlxLPMSQ3S9CT/uAAfKA/
	 ytsOfmhAsV1D1cjgvBl8831jOwn3Iu8j9Ap34QaZxTVxA7LsFCqakwqkk9ak2BvJ86
	 ttJzzoylZmKy0UIzzMuGHH0vpg4vlRqtH8M4YiUR9NDSHYFgKPHGpqunIGB0sSSx6X
	 SF8KmEzEkkRM/vEHgsBEZYK1nTXKixXmNyefnzox7muo6f1fA6Qhil25HYtYjEdHPM
	 oHJVg6w0XsEHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] HID: asus: fix missing hid_is_usb() check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jann Horn" <jannh@google.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260703-hid-usbcheck-v1-1-e80259ff625d@google.com>
References: <20260703-hid-usbcheck-v1-0-e80259ff625d@google.com>
 <20260703-hid-usbcheck-v1-1-e80259ff625d@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 15:32:17 +0000
Message-Id: <20260703153218.0F3C61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing pointer invalidation after `devm_kfree` causes a determini=
stic Use-After-Free on the failure path.
--

commit d3bce769a13470fb7e8717746a98294d5eb006c9
Author: Jann Horn <jannh@google.com>

HID: asus: fix missing hid_is_usb() check

to_usb_interface() can only be used on a hid_device whose parent is really
USB; uhid can create devices that identify as being on BUS_USB, but don't
actually have a USB parent. Fix the use of to_usb_interface() without a
hid_is_usb() check.

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
This is a pre-existing issue, but does the failure path in this function le=
ave
a dangling pointer that can cause a use-after-free?

If asus_hid_register_listener() fails later in asus_kbd_register_leds():

	ret =3D asus_hid_register_listener(&drvdata->kbd_backlight->listener);
	if (ret < 0) {
		/* No need to have this still around */
		devm_kfree(&hdev->dev, drvdata->kbd_backlight);
	}

The memory allocated for drvdata->kbd_backlight is freed, but the pointer is
not set to NULL.

Then asus_probe() catches the failure, emits a warning, but improperly allo=
ws
probe to succeed:

	if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
	    (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID)) &&
		(asus_kbd_register_leds(hdev)))
		hid_warn(hdev, "Failed to initialize backlight.\n");

If this occurs, could a subsequent call to asus_remove() or asus_resume()
dereference the freed memory?

	if (drvdata->kbd_backlight) {
		asus_hid_unregister_listener(&drvdata->kbd_backlight->listener);
		spin_lock_irqsave(&drvdata->kbd_backlight->lock, flags);
		drvdata->kbd_backlight->removed =3D true;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-hid-usbche=
ck-v1-0-e80259ff625d@google.com?part=3D1
