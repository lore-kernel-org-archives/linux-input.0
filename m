Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B65F48C414
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858460; cv=none; b=dpm1cfX9tTJeyuGdFnvNBjMqdhUTdWOIr1ItcJuXlhZ25RDuf1rqLggEss+g3xXLiC5TDp476hufdX5eK2bIVE/3X6KyrkTUTOiMBFm9rEOKBLl7dzNS/I+sFv5e0BP548KAWI3EWm9V8JZZa0cXeJ3DntxrP2FnuzMC0hqYUrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858460; c=relaxed/simple;
	bh=nhz3/Pfvs89U0fxpwRxcdjNjUtoQH/SbVFW4Qm1rMpk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fLPFDUiHVWhgqYUGZClTFDieG0Yyq8KEJOeWz7xis3SB+gb70F8MdoBOK81z+paXll8tu+ebjGsLiL11JWcd8SvQKNY8I72WYzCY+vsLSyJs59tq7Bdnd2EwekGP5mwjge9xXnc2as15NuCMfqhQyvRd6bGCBYDDGS4Vzby7uu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nk/F33iW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nk/F33iW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38D6C2BCB0;
	Fri, 15 May 2026 15:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778858460;
	bh=nhz3/Pfvs89U0fxpwRxcdjNjUtoQH/SbVFW4Qm1rMpk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nk/F33iWmLAL5rBT4F+BPKjjGS75ueRltpFJ8a+6h0dBz1ZhCfzzYshQUJCCo7r7F
	 aopMLIZvT8C4Zmu9VzzfXgpJu4qijILZdiqEVgzCOCykgN3yWj6txLz4qARtybgjUS
	 UAk61bqPvZJgPspPzSEc2df71EFdmo7qiuP/Lw77EEaBDU0DfEbYugWUVIFNYk6rEc
	 0VwVmPS4spQKI4J2ElLZbndjEXe8/JOJ2RdmzktozcXhlcO9OQj+g4/7dMI9NSzIop
	 mBN+912AIT/APHfxLTqTqfHylYzQ/9oKe1m4u+1IrqmebuLxNmKeykWq4wW9W7WxzW
	 daFwi1WVsizpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] HID: lenovo-go: reject non-USB transports in
 probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Louis Clinckx" <clinckx.louis@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <e8f92f07a397f39680c72ca69a5ada9882ff7212.1778701376.git.clinckx.louis@gmail.com>
References: <e8f92f07a397f39680c72ca69a5ada9882ff7212.1778701376.git.clinckx.louis@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 15:20:59 +0000
Message-Id: <20260515152059.D38D6C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] This problem wasn't introduced by this patch, but both drivers use=
 a static global variable (`drvdata`) to store device state rather than all=
ocating it per-device.
- [High] This problem wasn't introduced by this patch, but multicolor LED c=
onfiguration structs (`go_cdev_rgb` and `gos_cdev_rgb`) are declared as sta=
tic global variables but are passed to `devm_led_classdev_multicolor_regist=
er()`.
- [High] This problem wasn't introduced by this patch, but in `hid-lenovo-g=
o.c`, the removal function `hid_go_cfg_remove()` fails to cancel the delaye=
d workqueue `go_cfg_setup`.
- [High] This problem wasn't introduced by this patch, but probe failures d=
o not correctly unwind started hardware states and sysfs groups.
- [High] This problem wasn't introduced by this patch, but a NULL pointer i=
s passed to `memcpy` in `mcu_property_out()` when performing `GET_*` proper=
ty requests.
- [High] This problem wasn't introduced by this patch, but completion synch=
ronization is broken in `mcu_property_out()` due to incorrect placement of =
`reinit_completion()`.
--

commit 7a455849d3633575795dff10836095e31a4bbca3
Author: Louis Clinckx <clinckx.louis@gmail.com>

HID: lenovo-go: reject non-USB transports in probe

These drivers only match HID_USB_DEVICE() entries and assume the
underlying bus is USB. Make that explicit at probe by rejecting any
non-USB hdev.

> diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
> index 01c7bdd4fbe04..abf477e680428 100644
> --- a/drivers/hid/hid-lenovo-go-s.c
> +++ b/drivers/hid/hid-lenovo-go-s.c
> @@ -1432,6 +1432,9 @@ static int hid_gos_probe(struct hid_device *hdev,
>  {
>  	int ret, ep;
> =20
> +	if (!hid_is_usb(hdev))
> +		return -EINVAL;
> +

[ ... ]

>  	ret =3D hid_gos_cfg_probe(hdev, id);
>  	if (ret)
>  		dev_err_probe(&hdev->dev, ret, "Failed to start configuration interfac=
e");

This isn't a regression from this patch, but do these probe failures
leave the hardware state active?

If hid_gos_cfg_probe() fails, the code returns the error immediately without
calling hid_hw_close(hdev) and hid_hw_stop(hdev).

Additionally, does sysfs_create_groups() need to be rolled back if later
steps in the config probe fail?

>  	dev_dbg(&hdev->dev, "Started interface %x as Go S configuration interfa=
ce\n", ep);
>  	return ret;
>  }

[ ... ]

> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index d4d26c7833563..3fa1fe83f7e5e 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c
> @@ -2419,6 +2419,9 @@ static int hid_go_probe(struct hid_device *hdev, co=
nst struct hid_device_id *id)
>  {
>  	int ret, ep;
> =20
> +	if (!hid_is_usb(hdev))
> +		return -EINVAL;
> +

[ ... ]

>  	ret =3D hid_go_cfg_probe(hdev, id);
>  	if (ret)
>  		dev_err_probe(&hdev->dev, ret, "Failed to start configuration interfac=
e\n");

This isn't a regression from this patch, but does this early return
bypass hid_hw_close(hdev) and hid_hw_stop(hdev) as well?

>  	dev_dbg(&hdev->dev, "Started Legion Go HID Device: %x\n", ep);
> =20
>  	return ret;
>  }

[ ... ]

This isn't a regression from this patch, but does the use of a static
global drvdata struct cause data races when multiple devices are connected?

Since drvdata is shared, functions like mutex_init() and init_completion()
called during probe() would re-execute on the same memory space. Could this
cause type confusion over drvdata.hdev and memory corruption from concurrent
sysfs accesses or input events?

This isn't a regression from this patch, but do the static global
go_cdev_rgb and gos_cdev_rgb structs corrupt the kernel's global leds_list?

The led framework embeds a struct list_head into the led_classdev structure.
If devm_led_classdev_multicolor_register() is called for multiple devices
using the same static struct, it would double-add the list node.

Would unbinding one device then unlink the shared struct, leading to a
use-after-free when the other device is later accessed or removed?

This isn't a regression from this patch, but does hid_go_cfg_remove()
need to cancel the go_cfg_setup delayed workqueue?

If the controller is rapidly unplugged after hid_go_cfg_probe() schedules
drvdata.go_cfg_setup, hid_go_cfg_remove() will tear down the device.
Without calling cancel_delayed_work_sync(), could the workqueue execute
and dereference the freed hdev pointer in mcu_property_out()?

This isn't a regression from this patch, but does mcu_property_out() pass
a NULL pointer to memcpy() during get property commands?

Callers intentionally pass NULL as the data pointer and 0 as len for these
commands. Since passing NULL to memcpy() is undefined behavior even when
len is 0, could this trigger sanitizer violations?

This isn't a regression from this patch, but is the completion
synchronization in mcu_property_out() susceptible to spontaneous hardware
events?

Because reinit_completion() is called at the end of mcu_property_out(), if
hid_go_raw_event() invokes complete() due to spontaneous events or multiple
responses, the completion object could be left in a signaled state.

Would the next call to wait_for_completion_interruptible_timeout() then
return instantly and provide stale or uninitialized memory to user-space?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1778701376.gi=
t.clinckx.louis@gmail.com?part=3D1
