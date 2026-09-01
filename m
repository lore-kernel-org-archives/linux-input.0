Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDA44CCDD5
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 06:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245415; cv=none; b=IE3rrJcp8jPE/gDms2DSQrh3+ss28p4z7N14do8JE1DfpiO+1m1g2qDXa+w2LBBXw8T0cLSLJf5D0cU70WG+f2wVdTZivxEmauyxM1dlNLUDRulwY3juwcbvZrsOSWMpfvthQBy62d8sCP1l4QxXQgByJhgyPtxqW8aC6FKcY4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245415; c=relaxed/simple;
	bh=16x2RvYEG9uRlH8/r7D1jQyHlr1jQ7/dMyUfDn8F+yk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nO2kDDZeajFxhHCXElle2CqxxBLru50RrRh7q2F7Dxo8N7CL1mxZmXiSsWw23ikqX4fWoEUJTUcQzRj3wB5P4bPn+6hLqZEFFQquQ24ypnrZP2PG2nXi2WPo1zvEWEIlfm0vfHH2DxUJhzj5Ldyi9G230wTuHu/bSp7lKRnjGTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nzin5CpL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nzin5CpL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624451F000E9;
	Tue,  1 Sep 2026 06:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788245413;
	bh=n6uhlpEBNeTAOyR1A2E855cHuzx+VNLAoepP8Lea7FE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nzin5CpLiNZPVfW4FomPRe7ratpYzvSB2kb/cHkAbCU7dYt6Ub18ALCYkOYogOk8U
	 YmeVQru+mwfFFjgaq0WpV5WLarCHr+Ztktfz+BEtHSFkSFn9MLWqYOck2fSiLwZnyt
	 xvX2FcGHrsoh7FESvYxCN7AXRqxkvRX9EoLGpqZQDOMZEDFIMKcjZVgV19X567FVJf
	 tBeeSQyyfvtjkfAYhotQWX8rw8vQdRPgLHfHyC9RVMMhqYyVk87QoIbVhmWELYufNZ
	 SkDvaIrzwqmJd47nSLzAqKdWQUuDRXRFiLbEvoj8JMZurgKHNIXiudNGfjjM+SBEBL
	 Dn36uI86TdtiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/7] HID: hid-lenovo-go: use the correct calibration
 commands
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Dash" <mradityadash@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <d10f7771d20d356dbba45047894aca0b41e7a3ae.1788222001.git.mradityadash@gmail.com>
References: <cover.1788222001.git.mradityadash@gmail.com>
 <d10f7771d20d356dbba45047894aca0b41e7a3ae.1788222001.git.mradityadash@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 06:50:12 +0000
Message-Id: <20260901065013.624451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing hid_hw_stop() and hid_hw_close() in hid_go_probe() error p=
ath.
- [High] Sysfs attribute groups are leaked on error paths in hid_go_cfg_pro=
be(), leading to an Execute-After-Free panic.
- [High] hid_go_remove fails to stop and close the HID hardware if get_endp=
oint_address returns a negative value.
- [High] Accessing the USB endpoint array without verifying the endpoint co=
unt can lead to an out-of-bounds read.
- [High] The driver uses a statically allocated global variable for device =
private data, breaking support for multiple connected devices.
--

commit 0f59f6a616b3448c35bd0ae030452c8605182e3d
Author: Aditya Dash <mradityadash@gmail.com>

    HID: hid-lenovo-go: use the correct calibration commands
   =20
    The calibration attributes pass the calibration operation as the command
    and the configuration command as the sub-command. This sends each reque=
st
    with the two fields reversed.
   =20
    Swap the command and sub-command values for all six calibration attribu=
tes.
    For example, the malformed left joystick Start request is:
   =20
      05 00 04 0c 03 01 ...
   =20
    The corrected request is:
   =20
      05 00 0c 04 03 01 ...
   =20
    The bytes identify the output report, configuration group, command,
    sub-command, left controller, and Start action, in that order.
   =20
    Fixes: 995887a10da1 ("HID: hid-lenovo-go: Add Calibration Settings")
    Assisted-by: Pi:gpt-5.6-sol
    Signed-off-by: Aditya Dash <mradityadash@gmail.com>
    Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
    Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>

> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index 318b1152ff8ba..b8248bf8965c6 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c
> @@ -1911,18 +1911,18 @@ LEGO_DEVICE_ATTR_RW(rumble_notification_left, "ru=
mble_notification",
>  static DEVICE_ATTR_RO_NAMED(rumble_notification_left_index,
>  			    "rumble_notification_index");
> =20
> -static struct go_cfg_attr cal_trigg_left =3D { TRIGGER_CALIBRATE };
> -LEGO_CAL_DEVICE_ATTR(cal_trigg_left, "calibrate_trigger", SET_TRIGGER_CF=
G,
> +static struct go_cfg_attr cal_trigg_left =3D { SET_TRIGGER_CFG };
> +LEGO_CAL_DEVICE_ATTR(cal_trigg_left, "calibrate_trigger", TRIGGER_CALIBR=
ATE,
>  		     LEFT_CONTROLLER, index);

[ ... ]

While reviewing this code, I noticed a few pre-existing issues elsewhere in
the driver.

> static int get_endpoint_address(struct hid_device *hdev)
> {
> 	struct usb_interface *intf =3D to_usb_interface(hdev->dev.parent);
> 	struct usb_host_endpoint *ep;
>=20
> 	ep =3D intf->cur_altsetting->endpoint;
> 	if (!ep)
> 		return -ENODEV;
>=20
> 	return ep->desc.bEndpointAddress;
> }
        ^^^^
[Severity: High]
This isn't a bug introduced by this patch, but is it possible for a
malicious USB device to provide an interface with zero endpoints?

If so, this code reads ep->desc.bEndpointAddress without verifying the
intf->cur_altsetting->desc.bNumEndpoints count. Does this need a check
to prevent an out-of-bounds read of the endpoint array?


> static int hid_go_cfg_probe(struct hid_device *hdev,
> 			    const struct hid_device_id *_id)
> {
> 	unsigned char *buf;
> 	int ret;
>=20
> 	buf =3D devm_kzalloc(&hdev->dev, GO_PACKET_SIZE, GFP_KERNEL);
> 	if (!buf)
> 		return -ENOMEM;
>=20
> 	hid_set_drvdata(hdev, &drvdata);
> 	drvdata.hdev =3D hdev;
> 	mutex_init(&drvdata.cfg_mutex);
        ^^^^
[Severity: High]
This is a pre-existing issue, but does using a single static 'drvdata'
struct break support for multiple connected devices?

If two devices are connected (or one exposes multiple interfaces), the
second probe will unconditionally overwrite the global drvdata.hdev
pointer and re-initialize the mutex. Would dynamically allocating this
state (e.g., via devm_kzalloc) prevent cross-device command routing
issues and deadlocks?

> 	ret =3D sysfs_create_groups(&hdev->dev.kobj, top_level_attr_groups);
> 	if (ret) {
> 		dev_err_probe(&hdev->dev, ret,
> 			      "Failed to create gamepad configuration attributes\n");
> 		return ret;
> 	}
>=20
> 	ret =3D devm_led_classdev_multicolor_register(&hdev->dev, &go_cdev_rgb);
> 	if (ret) {
> 		dev_err_probe(&hdev->dev, ret, "Failed to create RGB device\n");
> 		return ret;
> 	}
        ^^^^
[Severity: High]
This is a pre-existing issue, but does the error path leak sysfs attributes?

If devm_led_classdev_multicolor_register() fails, the function returns
without calling sysfs_remove_groups(). If the driver unbinds, could reading
or writing the dangling sysfs files trigger an execute-after-free panic?


> static int hid_go_probe(struct hid_device *hdev, const struct hid_device_=
id *id)
> {
> 	int ret, ep;
>=20
> 	if (!hid_is_usb(hdev))
> 		return -EINVAL;
[ ... ]
> 	ret =3D hid_go_cfg_probe(hdev, id);
> 	if (ret)
> 		dev_err_probe(&hdev->dev, ret, "Failed to start configuration interface=
\n");
>=20
> 	dev_dbg(&hdev->dev, "Started Legion Go HID Device: %x\n", ep);
>=20
> 	return ret;
> }
        ^^^^
[Severity: High]
This isn't a bug introduced by this patch, but does this error path leave
the hardware and input nodes running?

If hid_go_cfg_probe() fails, the error code is returned directly without
calling hid_hw_close() and hid_hw_stop() to tear down what was started
earlier.

Since the HID core doesn't automatically stop the hardware if a custom probe
fails after hid_hw_start() succeeds, could this cause a use-after-free
if the module is unloaded while callbacks remain active?


> static void hid_go_remove(struct hid_device *hdev)
> {
> 	int ep =3D get_endpoint_address(hdev);
>=20
> 	if (ep <=3D 0)
> 		return;
        ^^^^
[Severity: High]
This is a pre-existing issue, but can this skip the required hardware
teardown when the driver is unbound?

If get_endpoint_address() returns a negative error code during unbind, the
function returns early. This skips hid_hw_close() and hid_hw_stop(), leaving
the hardware active.

Could this result in a use-after-free since the input_dev and hidraw
interfaces would remain active after the driver's resources are freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788222001.gi=
t.mradityadash@gmail.com?part=3D1
