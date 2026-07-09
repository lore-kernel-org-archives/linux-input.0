Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC63438D3E4
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 03:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568078; cv=none; b=DN3/epzbi+IP6+10wOKGzX6gCplsOh2DtIxBu5ZI/zSjafNflY7fjxi233JWXHFxbjR49ATpoDaigLc98FNuAy0UQkffW+Jda2+oKm1A4VXAmWgUcCgJ8kSLw57Uspg5tNyJifRBEcWJKMtlxgxJcm3syiKo6M04pPhJNJbmnk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568078; c=relaxed/simple;
	bh=R6Z1dRgRcdjk3Or0raNgtH7S8m+ptF+j8J6gBG81NPo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IQrhu8ZGidMl2ZRifIdDCOulcYSJs7z4W6n7dTxXVb41zufI/NkAsM2/5k35JMuvsEGAicEkf8+1E4g1BFXrTKT+1zkWTbvRHAvpSf7kQtUOaZQ+wVlReMTiA1WjfSsvkougMN1LG6kOZ8jpmNZrPNccIrmOLisT0q1Mf+FqG6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Er7uZ4gY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Er7uZ4gY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216F41F000E9;
	Thu,  9 Jul 2026 03:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783568077;
	bh=9I66sQHzy18/NqFEHanzpctBKLXa71QuFSBptuwHzx0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Er7uZ4gY1G77IG/Igup1QCQnVSlHOWeCpv2591U6kA7QxhO33/gZdmOrHbQEeDZEd
	 yRNBKPZOYliXXCeEWClzGdmcVEiSGFAB59BwF4Qn79L8vA1cMge9/3bo6ufSCvlDHe
	 E+Wd+9s0OdWRFFKprzUDan6xdBzP5UuhqozCB0y72vWRfpQ7l21WmhBPCQM3b83xfM
	 mMJ1H4XrwPbTZ/U8+cVj3LuWgx9r3mf5UXZAN+19abZ6yk0OisThXi8+ihUispIrGz
	 bQMdxaslgOhBV2wRHtAdaiHEJZPWgcGdwElXBfBea3WqmmPnGJs+GuafRi1EykquYq
	 1+zEwhvVNFHhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/9] HID: steelseries: Split Arctis headset driver
 into separate module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sriman Achanta" <srimanachanta@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260709032316.1908460-3-68172138+srimanachanta@users.noreply.github.com>
References: <20260709032316.1908460-1-68172138+srimanachanta@users.noreply.github.com>
 <20260709032316.1908460-3-68172138+srimanachanta@users.noreply.github.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 03:34:36 +0000
Message-Id: <20260709033437.216F41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If `steelseries_headset_battery_register()` fails, the probe funct=
ion ignores the error and continues. This leaves `sd->battery` as an `ERR_P=
TR` and `sd->battery_work` uninitialized. Later, incoming events in `steels=
eries_arctis_raw_event()` call `power_supply_changed(sd->battery)` and `sch=
edule_delayed_work(&sd->battery_work, ...)`, which will dereference the err=
or pointer and operate on an uninitialized work structure, causing a kernel=
 panic. Similarly, `steelseries_arctis_remove()` calls `cancel_delayed_work=
_sync(&sd->battery_work)` which will also crash.
- [High] The driver calls `hid_hw_start()` and `hid_hw_open()` before calli=
ng `steelseries_headset_battery_register()`. `hid_hw_open()` starts the URB=
 polling, enabling asynchronous hardware events to trigger `steelseries_arc=
tis_raw_event()` immediately. At this point, `sd->battery` is still `NULL` =
and `sd->battery_work` is uninitialized. If a report is received during thi=
s race window, the event handler will pass a `NULL` pointer to `power_suppl=
y_changed()` and call `schedule_delayed_work()` on uninitialized work, resu=
lting in an immediate kernel panic.
- [High] Missing length check on the report descriptor before accessing pay=
load offsets in `steelseries_is_vendor_usage_page()`. The function uncondit=
ionally accesses `hdev->rdesc[0]`, `hdev->rdesc[1]`, and `hdev->rdesc[2]`. =
Although `usbhid_parse()` guarantees `rsize > 0`, it does not guarantee `rs=
ize >=3D 3`. If a malformed USB device presents a 1- or 2-byte descriptor, =
this reads out of bounds of the kmalloc'd `rdesc` buffer.
--

--- Patch [2]: [PATCH v6 2/9] HID: steelseries: Split Arctis headset driver=
 into separate module ---
commit 5114a40b6cbe9d3f2ea95a54f76bb50da5fb5d42
Author: Sriman Achanta <srimanachanta@gmail.com>

HID: steelseries: Split Arctis headset driver into separate module

This patch moves the Arctis headset code from hid-steelseries.c into a
new hid-steelseries-arctis.c module. It separates the headset handling
from the SRWS1 racing wheel code.

> diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steel=
series-arctis.c
> new file mode 100644
> index 0000000000000..079504e6932a1
> --- /dev/null
> +++ b/drivers/hid/hid-steelseries-arctis.c

[ ... ]

> +static bool steelseries_is_vendor_usage_page(struct hid_device *hdev, ui=
nt8_t usage_page)
> +{
> +	return hdev->rdesc[0] =3D=3D 0x06 &&
> +		hdev->rdesc[1] =3D=3D usage_page &&
> +		hdev->rdesc[2] =3D=3D 0xff;
> +}

[Severity: High]
This is a pre-existing issue, but does this function properly validate
the size of the report descriptor before accessing it?

The function unconditionally accesses the first 3 bytes of hdev->rdesc.
Although hid_parse() guarantees rsize > 0, if a malformed USB device
presents a 1- or 2-byte descriptor, wouldn't this read out of bounds
of the allocated rdesc buffer?

[ ... ]

> +static int steelseries_arctis_probe(struct hid_device *hdev, const struc=
t hid_device_id *id)
> +{

[ ... ]

> +	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D hid_hw_open(hdev);
> +	if (ret)
> +		return ret;

[Severity: High]
This isn't a bug introduced by this patch, but does calling hid_hw_open()
before steelseries_headset_battery_register() introduce a race condition?

Calling hid_hw_open() starts the hardware polling, which enables
asynchronous events to immediately trigger steelseries_arctis_raw_event().
At this point, sd->battery is still NULL and sd->battery_work is
uninitialized.

If a report is received during this race window, would the event handler
pass a NULL pointer to power_supply_changed() and schedule uninitialized
work, resulting in a crash?

> +
> +	if (steelseries_headset_battery_register(sd) < 0)
> +		hid_err(sd->hdev,
> +			"Failed to register battery for headset\n");
> +
> +	return ret;
> +}

[Severity: High]
This is a pre-existing issue, but is it safe to ignore the return value
of steelseries_headset_battery_register() here?

If registration fails (for example, due to a duplicate name), the probe
function prints an error but still succeeds. This leaves sd->battery as
an ERR_PTR and sd->battery_work uninitialized.

If a subsequent event is processed by steelseries_arctis_raw_event(),
it will call power_supply_changed() and dereference the error pointer.
Furthermore, steelseries_arctis_remove() will call
cancel_delayed_work_sync() on an uninitialized structure, which can
crash the workqueue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709032316.1908=
460-1-68172138+srimanachanta@users.noreply.github.com?part=3D2
