Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EBC34E766
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906896; cv=none; b=K94LN5MjppTehJNNV3j22D71nydL3Fkt1D5AgKhrxoBYo9U3FSJbCsnv+3dcHAyfUte2oZSuSaCKjZe2ysPYqhVRUWMx6kenP+6RrDQNH3KoKl+HwNmrwdGmUW/xtCt3/d3D9+jQssDZGu73d3zd/mYg+6y8jg+jjt5LDuyk+QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906896; c=relaxed/simple;
	bh=n6/PG5bwM+YlrlAq3lV/lguTFNPTIkn3fTKCx6tehVQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PXWEfVHCk1tZ9PEll8GK4SxMSPLS0r1tsnAVQaSRD61blzajsZIeeOKVHAoW9hkwXPpeDm1OOvrRTG5fvhE2Z2Jig2wEOq+KGgfIQ+Zhi81omD3Y5g5ojtWYRcasCdOpvVYe9n90yqUlr9DVEcrASmPHqTizcR9jcAj07Df6jME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9GpTTZh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9GpTTZh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270111F00A3A;
	Fri, 24 Jul 2026 15:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784906895;
	bh=wFC088VIqC5Leq8MudYiNL0wSu0TkEXx04u29pt0NXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d9GpTTZhm33CTXAYfrQ0qidOpqbc/pSD6OrDsKz8dlGLBjtdytYBq4WL94qX5MJwQ
	 PZQJeI9FjVC2A01ibYp4GMGVAQptQWpFbq2EjAaiRFnb7Sd1sSDacbwWGxpWb/iIA2
	 gRhvzdogwHZcM2vHTTS2LTG4eSkmKk56njYb29Rpuw8KaH4dxY8kaNvS/Y024pOl3f
	 4isAmkau/vXiA6iLMTKAeW+YLSAiAz8PFYKLVlgVoOG/prgH6KcPfworSETWIiqB/t
	 cAPv9/ApQj1I2bCZY4bO8G9dQgvI7OCwkZOmh7CulDw+o9mWpn6OHLKYNG9IMUOxWG
	 U6/qaZepUqRHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: lg4ff: validate report length before fixed
 offsets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiancheng Huang" <jchuang@seu.edu.cn>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260724151317.1419574-1-jchuang@seu.edu.cn>
References: <20260724151317.1419574-1-jchuang@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 15:28:14 +0000
Message-Id: <20260724152815.270111F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Force feedback is initialized on the input device after it has alr=
eady been registered and made visible to userspace, violating input subsyst=
em initialization order.
- [High] Use-after-free of the lg4ff device properties (`entry`) during dev=
ice removal or probe failure, as the properties are freed before hardware I=
/O and input devices are fully unregistered.
- [Low] Data race on `entry->wdata.combine` between sysfs store and interru=
pt context raw event handler.
--

--- Patch [1]: [PATCH v2] HID: lg4ff: validate report length before fixed o=
ffsets ---
commit 64ee3d21ef774099318a4223423dc4d5d4eac310
Author: Jiancheng Huang <jchuang@seu.edu.cn>

HID: lg4ff: validate report length before fixed offsets
   =20
lg4ff_raw_event() rewrites fixed report offsets when combined pedals are
enabled. It currently assumes that each product report contains every
source and destination byte used by the rewrite.
   =20
Return without rewriting a short report before each product-specific
access. Apply the same bound to the computed offset path.


[Severity: High]
This isn't a bug introduced by this patch, but force feedback is initialize=
d on
the input device after it has already been registered.

Looking at drivers/hid/hid-lg.c, lg_probe() registers the input device befo=
re
force feedback capabilities are set up:

drivers/hid/hid-lg.c:lg_probe() {
    ...
	ret =3D hid_hw_start(hdev, connect_mask);
    ...
	if (drv_data->quirks & LG_FF4)
		ret =3D lg4ff_init(hdev);
    ...
}

Because hid_hw_start() exposes the device to userspace, could userspace (e.=
g.
udev, games) open the device and observe an incomplete capability set before
lg4ff_init() modifies dev->ffbit and installs the FF callbacks?


[Severity: High]
This is a pre-existing issue, but is there a use-after-free risk for the lg=
4ff
device properties during device removal?

In drivers/hid/hid-lg.c, the device properties are freed before hardware I/O
and input devices are fully unregistered:

drivers/hid/hid-lg.c:lg_remove() {
	struct lg_drv_data *drv_data =3D hid_get_drvdata(hdev);
	if (drv_data->quirks & LG_FF4)
		lg4ff_deinit(hdev);
	hid_hw_stop(hdev);
	kfree(drv_data);
}

Since lg4ff_deinit() sets drv_data->device_props =3D NULL and frees the ent=
ry,
if an interrupt fires before hid_hw_stop() executes, could lg4ff_raw_event()
cache the entry pointer just before it is freed, leading to a use-after-fre=
e?

Additionally, could lg4ff_play() be concurrently invoked via userspace ioctl
while the input device is still registered, resulting in a similar
use-after-free?


> diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
> index e901fdb7d033c..62f99a93210c9 100644
> --- a/drivers/hid/hid-lg4ff.c
> +++ b/drivers/hid/hid-lg4ff.c
> @@ -336,6 +336,8 @@ int lg4ff_raw_event(struct hid_device *hdev, struct h=
id_report *report,
>  	if (entry->wdata.combine) {

[Severity: Low]
This is a pre-existing issue, but does reading entry->wdata.combine from
interrupt context without locks or READ_ONCE() introduce a data race?

The sysfs store function (lg4ff_combine_store) writes to this shared boolean
state without locks or WRITE_ONCE(). Could this lead to a transient read of=
 an
inconsistent state if a user writes to the sysfs node while the device is
actively sending events?

>  		switch (entry->wdata.product_id) {
>  		case USB_DEVICE_ID_LOGITECH_WHEEL:
> +			if (size < 7)
> +				return 0;
>  			rd[5] =3D rd[3];

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724151317.1419=
574-1-jchuang@seu.edu.cn?part=3D1
