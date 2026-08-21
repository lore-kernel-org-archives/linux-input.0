Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A493803DF
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 22:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787349710; cv=none; b=j3+pWTSMbwSMWlhDL4YuQpKtnVnYgiuwEPeLgKLMtGnsZmDkv4W2CCqTlTXRUK/1JOBBPiwrFh1QR/NBjdA7RqhGnHrnAQoksOK7OZCZAkvoeYd23uLuEmrJU8HNM5LyAcqD8RNT9ZLHsS8XkS6R7Z5XrPxaQPZy0jxNJ+nTPOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787349710; c=relaxed/simple;
	bh=JTbfBfOLlghVv1KPuzMSoa2vGY64VvN8fOQPTUzUvxU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gZou1rwa6JPje2Ut+OQw5swpIGYa+vOnnLZ23a4uF3zp8XOOeDh7j2SfG/zsDucN7OSvyQFiRKdKM2JR8E8oM6dDfzwGJ6rz0ao0bwKt9fWiKvSE8uQocdPE7p/19B6DWIl09N3CHVq98tyfIunYV9rxB6xZLvs6g3ZzE0IWWkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xr5ctAxY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xr5ctAxY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634311F000E9;
	Fri, 21 Aug 2026 22:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787349708;
	bh=pyu1Ro5uoOQUBUFUvM8HJ0O4YSlcoT9bUQRlF+bYBNU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xr5ctAxYBA0ZPoqhqdBPireoc4t1S8imSpJxXSABKNbSmfGWxikrvpaV5iW72mpIF
	 G57d7ZoQ6LVefRAxhM1MGvHrBCsEtkVJmKLO7i4tD01S2eSliXHEf5M9edr5E5Jntd
	 4ic9nj8dRZ4Vt/QP6IfnzJ3guZC4KaZofTZs2yw5JBV3joqOPi99soOCHxuP8XgIoF
	 r6Tos58Breie56yWWMvXOyMwSWEvD7S69I78X95gEbflxEPOmcoiAFtPbZMNChVi4y
	 k8gUIlFMI/cCbeMkCUAGwdsrUrYYO9XweIEUEpucM82zzunnwFIFWUDmsD1h7eWtSJ
	 F3BFCfkmEnMZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] HID: hid-lenovo-go: fix the FPS mode DPI request
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Dash" <mradityadash@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260821214810.87826-3-mradityadash@gmail.com>
References: <20260821214810.87826-1-mradityadash@gmail.com>
 <20260821214810.87826-3-mradityadash@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 22:01:47 +0000
Message-Id: <20260821220148.634311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

New issues:
- [High] FPS mode DPI read requests and responses use incorrect byte offset=
s and headers.

Pre-existing issues:
- [High] Missing hid_hw_stop() and hid_hw_close() in the hid_go_probe() err=
or path.
- [High] The driver uses a single global static variable drvdata for device=
-specific state.
- [High] Early return in hid_go_remove() bypasses hid_hw_stop() completely.
- [High] get_endpoint_address() lacks a boundary check for bNumEndpoints.
- [High] AB-BA deadlock between device removal and sysfs file access.
- [High] Passing a NULL pointer to memcpy() when processing GET requests.
- [Medium] Sysfs attribute groups are leaked on hid_go_cfg_probe() error pa=
ths.
--

--- Patch [2]: [PATCH 2/5] HID: hid-lenovo-go: fix the FPS mode DPI request=
 ---
commit 9b984e3644e77c41adb68e3622677de0ae7cd145
Author: Aditya Dash <mradityadash@gmail.com>

HID: hid-lenovo-go: fix the FPS mode DPI request

mcu_property_out() adds the five-byte request header used by most
configuration commands. For FPS mode DPI writes, this inserts a device byte
before the four-byte DPI value.

The FPS mode DPI request does not contain a device byte. Its little-endian
DPI value starts immediately after the command and sub-command.

Use the four-byte header only for FPS mode DPI writes. Keep the common
header for all other requests.

> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index b8248bf8965c6..a6e9a130ad417 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c
> @@ -725,6 +725,11 @@ static int mcu_property_out(struct hid_device *hdev,=
 u8 id, u8 command,
>  	int timeout =3D 50;
>  	int ret;
> =20
> +	/* The FPS mode DPI request does not contain a device byte. */
> +	if (id =3D=3D MCU_CONFIG_DATA && command =3D=3D SET_DPI_CFG &&
> +	    index =3D=3D FPS_MODE_DPI)
> +		header_size--;
> +

[Severity: High]
Does this change result in FPS mode DPI read requests and responses using
incorrect byte offsets and headers?

Since the check specifically targets SET_DPI_CFG, a GET_DPI_CFG request from
fps_mode_dpi_show() will still send a 5-byte header. hid_go_fps_dpi_event()
will then read the response from an incorrect byte offset due to asymmetric
header tracking.

>  	if (header_size + len > GO_PACKET_SIZE)
>  		return -EINVAL;
> =20

While reviewing this patch, I also noticed a few preexisting issues in this
file.

[Severity: High]
This isn't a bug introduced by this patch, but does this invoke undefined
behavior by passing a NULL pointer to memcpy()?

drivers/hid/hid-lenovo-go.c:mcu_property_out()
    ...
    memcpy(dmabuf, header, header_size);
    memcpy(dmabuf + header_size, data, len);
    ...

When mcu_property_out() is called for GET requests (like GET_DPI_CFG in
fps_mode_dpi_show()), the data pointer is NULL and len is 0.


[Severity: High]
This isn't a bug introduced by this patch, but does using a single global
static variable drvdata cause multiple devices to corrupt each other's stat=
e?

drivers/hid/hid-lenovo-go.c
    static struct hid_go_cfg {
        ...
    } drvdata;

The global drvdata is mutated per-device and its mutex is re-initialized on
every probe, which could cause issues if more than one of these devices is
connected.


[Severity: High]
This isn't a bug introduced by this patch, but does the hid_go_probe() error
path miss calling hid_hw_stop() and hid_hw_close()?

drivers/hid/hid-lenovo-go.c:hid_go_probe()
    ...
    ret =3D hid_go_cfg_probe(hdev, id);
    if (ret)
        dev_err_probe(&hdev->dev, ret, "Failed to start configuration inter=
face\n");

    dev_dbg(&hdev->dev, "Started Legion Go HID Device: %x\n", ep);

    return ret;

If hid_go_cfg_probe() fails, this returns the error without tearing down the
hardware that was started earlier, which could lead to a resource leak and
use-after-free.


[Severity: Medium]
This isn't a bug introduced by this patch, but are the sysfs attribute grou=
ps
leaked on hid_go_cfg_probe() error paths?

drivers/hid/hid-lenovo-go.c:hid_go_cfg_probe()
    ...
    ret =3D devm_led_classdev_multicolor_register(&hdev->dev, &go_cdev_rgb);
    if (ret) {
        dev_err_probe(&hdev->dev, ret, "Failed to create RGB device\n");
        return ret;
    }

The function returns directly on error without calling sysfs_remove_groups()
to clean up the groups created earlier by sysfs_create_groups().


[Severity: High]
This isn't a bug introduced by this patch, but does this early return in
hid_go_remove() completely bypass hid_hw_stop()?

drivers/hid/hid-lenovo-go.c:hid_go_remove()
    int ep =3D get_endpoint_address(hdev);

    if (ep <=3D 0)
        return;

If the endpoint is not found or is less than zero on disconnect, the early
return skips hid_hw_stop() and hid_hw_close(), leaving hardware active.


[Severity: High]
This isn't a bug introduced by this patch, but does get_endpoint_address() =
lack
a boundary check for bNumEndpoints?

drivers/hid/hid-lenovo-go.c:get_endpoint_address()
    ...
    ep =3D intf->cur_altsetting->endpoint;
    if (!ep)
        return -ENODEV;

    return ep->desc.bEndpointAddress;

Accessing ep->desc.bEndpointAddress directly without verifying that
intf->cur_altsetting->desc.bNumEndpoints > 0 could result in an out-of-boun=
ds
read on the endpoint descriptor array.


[Severity: High]
This isn't a bug introduced by this patch, but is there an AB-BA deadlock
between device removal and sysfs file access here?

drivers/hid/hid-lenovo-go.c:hid_go_cfg_remove()
    ...
    guard(mutex)(&drvdata.cfg_mutex);
    sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);
    ...

hid_go_cfg_remove() acquires cfg_mutex before sysfs_remove_groups(). If a
sysfs write is waiting on cfg_mutex while holding the kernfs active
reference, calling sysfs_remove_groups() while holding cfg_mutex will
deadlock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821214810.8782=
6-1-mradityadash@gmail.com?part=3D2
