Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C103783CE
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 22:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778711269; cv=none; b=LwGxHrmDd1zvlEJ17Af/K0sfKsmwYRfxcNdnKk7EyS+K/ImJ4uzb8n1T2hBFBLdt2YbnsbgJVieuMSn8CTp3R2hpVsBUe2Su0XBoV0gEdipEpU+aPYUcbLWe0lA9TKbs+WBpnohAJM6s5X8Dx1Hfd2hvRIx5eOy6mliilsV/e5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778711269; c=relaxed/simple;
	bh=fWPh2GIF2MSV1rg4FBh/+KuFWi1j8HutmXDiPrWfH1Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sSNobMVzD+wGYtSnfQn4P6stwITmoXn5plc5GqPFAsDR7MUg5bp+W3LUv+ITv7+sIcSTf6f/4Yd8EffX0Aoe+B0OfIiMieh3fr5oYC9H5Jou5Maf9V20RtW/phAS9p3CI1a1RDSPa2HUE4lgyRqVe0TvXuGOvTxV/sY+m5KHELA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRGlI49i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRGlI49i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A5FC19425;
	Wed, 13 May 2026 22:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778711269;
	bh=fWPh2GIF2MSV1rg4FBh/+KuFWi1j8HutmXDiPrWfH1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VRGlI49iuG19dlKMETNyUJflOEtFfYuBVgW1wZ57LJ3fzYaD8gqRdFYQ6nHSSDJO9
	 1tCRzUg2JW5CNBVjgkfQgbuQ7VI6UpsZzMkfNOq9CmBtOXQirno5If9T2OJyxajKQ+
	 J9l+Dt6QsLEnOv4hC19boqf9iSJaPNU34JzwAM4CMcWNbjPQGc/kt4I4COz1LUij8s
	 4kjAeKk80gQjfj0al5MU4a/2kEKyi2suPe9ifKY7ITR7jfMlDv34c2LSg+0WQgUkXe
	 vPn1CjFBHP4xYa0CKjqJXOog6bOAua9f6vNhLNysVy3E/r6YgcTLFw3O/J/IvFe9zX
	 ntV3XrDxZZVTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: lenovo: Restore Fn-lock LED state on resume for
 tp10ubkbd devices
Reply-To: sashiko-reviews@lists.linux.dev
To: Kean <rh_king@163.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260512142229.4098386-1-rh_king@163.com>
References: <20260512142229.4098386-1-rh_king@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 22:27:48 +0000
Message-Id: <20260513222748.D7A5FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unprotected state modifications / TOCTOU Race leading to Deadlock
--

commit 7c663fefe9bb0e01bc7e377e27b713f9cd82c9d8
Author: Kean <rh_king@163.com>

HID: lenovo: Restore Fn-lock LED state on resume for tp10ubkbd devices

This commit updates the reset_resume callback to restore the Fn-lock LED
state for several ThinkPad tablet keyboards. It does this by reading the
driver's cached state and calling lenovo_led_set_tp10ubkbd to update the
hardware.

> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> --- a/drivers/hid/hid-lenovo.c
> +++ b/drivers/hid/hid-lenovo.c

[ ... ]

> @@ -1424,6 +1424,8 @@ static int lenovo_probe(struct hid_device *hdev,
> =20
>  static int lenovo_reset_resume(struct hid_device *hdev)
>  {
> +	struct lenovo_drvdata *data;
> +
>  	switch (hdev->product) {
>  	case USB_DEVICE_ID_LENOVO_CUSBKBD:
>  	case USB_DEVICE_ID_LENOVO_TPIIUSBKBD:
> @@ -1431,6 +1433,17 @@ static int lenovo_reset_resume(struct hid_device *=
hdev)
>  			lenovo_features_set_cptkbd(hdev);
> =20
>  		break;
> +	case USB_DEVICE_ID_LENOVO_X12_TAB:
> +	case USB_DEVICE_ID_LENOVO_X12_TAB2:
> +	case USB_DEVICE_ID_LENOVO_TP10UBKBD:
> +	case USB_DEVICE_ID_LENOVO_X1_TAB:
> +	case USB_DEVICE_ID_LENOVO_X1_TAB2:
> +	case USB_DEVICE_ID_LENOVO_X1_TAB3:
> +		data =3D hid_get_drvdata(hdev);
> +		if (data)
> +			lenovo_led_set_tp10ubkbd(hdev, TP10UBKBD_FN_LOCK_LED,
> +						 data->fn_lock ? LED_ON : LED_OFF);

Could this new call to lenovo_led_set_tp10ubkbd() cause a deadlock during
runtime resume?

When userspace writes to the fn_lock sysfs attribute, it eventually calls
lenovo_led_set_tp10ubkbd() which acquires led_report_mutex before issuing
the raw HID request:

lenovo_led_set_tp10ubkbd()
    mutex_lock(&data->led_report_mutex);
    ...
    hid_hw_raw_request(...)

If the device is runtime-suspended and requires a reset-resume,
hid_hw_raw_request() will trigger usb_autopm_get_interface() to
synchronously wake the device. This causes the USB core to execute
lenovo_reset_resume() in the same thread:

lenovo_reset_resume()
    lenovo_led_set_tp10ubkbd()
        mutex_lock(&data->led_report_mutex);

Since led_report_mutex is already held by the initial sysfs write call,
will this result in an immediate self-deadlock?

Additionally, if a resume is initiated by a remote wakeup via a PM worker
thread while a sysfs write is concurrently holding led_report_mutex, could
this lead to an ABBA deadlock between the sysfs thread and the PM worker
thread?

> +		break;
>  	default:
>  		break;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512142229.4098=
386-1-rh_king@163.com?part=3D1
