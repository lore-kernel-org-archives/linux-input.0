Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4023D953D
	for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785222423; cv=none; b=lN3sMwPXnTAUEerOyKPdpcn/gz9ez9shFTIsWbUOGPb3nWCStof5SFeY9cmP23afrs3UZKy19X+W4NhIRVnTy/fvPuJDTvLwYWbDNcyRZSPjFmd94nbPTLNuMQvQ2ZJvt5sW+A+zv6qUPEfglutJKghKU+zoYoCWBBYcmEqvVm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785222423; c=relaxed/simple;
	bh=wgeR3onQsxIhzAcOKZ94iQGyBhvDrBzsD4ezoJD3l0I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tic+kEYi29i0rlnShOh0p7g5a606QZQome/CchAuGrS0iduW1AVh2bZDXix2oxuMtpcV+TbD3+b1iCqOcxb76EhKZ7eDnxZODAl+OxbZACQJ7WcI6rtgpDzMbwLMUNHo6X0jS01IyQPP0gizIG47ueCJC7Xowqa/sJwN9cb9xfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtzVMigr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtzVMigr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC0B1F000E9;
	Tue, 28 Jul 2026 07:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785222418;
	bh=HZcrZ0iwZUqem5SyZMd2mhZjkgw7akOr8F2QyjYJVjM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VtzVMigrLXFo92Y+xnvOF1K3lUlRUrYAicCniJr5ZP9P/GUSv21RDrjwd0AAtlbQq
	 5HhIRLOI2Kau8OF1HVAs6+sQ3Mg06FLtIdeoQCs1LkndUswM2xXv2H0IfyIbNA8wcE
	 nCkZe+o7+XknmuNS2kPYd8+yNxmN6/qZJe6qXdKc8PfNsS5nR1uO6klZX9ilnx5/Lm
	 SHLqZVyPUE8/X4suoywt19g5grFx/R6n1d4LWEHQnNzn/4k7IhHcy5tGNoLSrFc3lb
	 K+MTLMXapEzTlS1Ok2Nlolywthmrm+uxS9iMBfMkqT50XVjUbiv6mQC8F9xXeRY2Ks
	 xHx3TWKErYDxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: huawei/rapoo: reject non-USB transports before
 to_usb_interface()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiale Yao" <yaojiale02@163.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260728064302.3853953-1-yaojiale02@163.com>
References: <20260728064302.3853953-1-yaojiale02@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 07:06:57 +0000
Message-Id: <20260728070657.CFC0B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Missing Kconfig dependency on USB_HID for HID_RAPOO leads to undef=
ined reference link errors.

Pre-existing issues:
- [High] Type confusion vulnerability in `hid-asus.c` remains unpatched.
- [Medium] Resource leak due to missing `hid_hw_stop()` on error paths in `=
rapoo_probe`.
--

--- Patch [1]: [PATCH] HID: huawei/rapoo: reject non-USB transports before =
to_usb_interface() ---
commit 1c01c51fb3ab417da0ea9ad5aa2162a46f5fc7cd
Author: Jiale Yao <yaojiale02@163.com>

HID: huawei/rapoo: reject non-USB transports before to_usb_interface()

This commit fixes a type confusion vulnerability in the hid-huawei and
hid-rapoo drivers by verifying that the device is actually a USB device
using hid_is_usb() before dereferencing the parent as a usb_interface.
This prevents spoofing attacks from uhid devices that forge the bus type.

> diff --git a/drivers/hid/hid-rapoo.c b/drivers/hid/hid-rapoo.c
> index 4c81f3086de43..5c9c396fabf77 100644
> --- a/drivers/hid/hid-rapoo.c
> +++ b/drivers/hid/hid-rapoo.c
> @@ -36,7 +36,7 @@ static int rapoo_probe(struct hid_device *hdev, const s=
truct hid_device_id *id)
>  		return ret;
>  	}
> =20
> -	if (hdev->bus =3D=3D BUS_USB) {
> +	if (hid_is_usb(hdev)) {

[Severity: High]
Does this new call to hid_is_usb() require updating drivers/hid/Kconfig to
add a dependency on USB_HID for config HID_RAPOO?

If the kernel is compiled with CONFIG_HID_RAPOO=3Dy and CONFIG_USB_HID=3Dm
(or n), wouldn't this cause a build failure during final vmlinux linkage
since hid_is_usb() is implemented and exported by the usbhid module?

[Severity: Medium]
This is a pre-existing issue, but does rapoo_probe() fail to clean up
the started hardware on error paths?

If devm_input_allocate_device() or input_register_device() fail later in
this function, the code returns directly without calling hid_hw_stop():

drivers/hid/hid-rapoo.c:rapoo_probe() {
    ...
    ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
    ...
    if (hid_is_usb(hdev)) {
    ...
    input =3D devm_input_allocate_device(&hdev->dev);
    if (!input)
        return -ENOMEM;
    ...
}

Since hid_hw_start() was successfully called earlier, does this leave the
device in an active but unbound state when those allocations fail?

[Severity: High]
This is a pre-existing issue, but is the asus driver vulnerable to the same
type confusion being fixed here?

Looking at asus_kbd_register_leds() in drivers/hid/hid-asus.c, the code cas=
ts
to a usb_interface without verifying if the underlying transport is actually
USB:

drivers/hid/hid-asus.c:asus_kbd_register_leds() {
    ...
    if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
        intf =3D to_usb_interface(hdev->dev.parent);
        udev =3D interface_to_usbdev(intf);
    ...
}

If an attacker injects a spoofed device via /dev/uhid matching the ASUS ROG
ALLY vendor and product IDs, couldn't this trigger the exact same KASAN
slab-out-of-bounds read or panic when interface_to_usbdev() dereferences
the uhid parent?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728064302.3853=
953-1-yaojiale02@163.com?part=3D1
