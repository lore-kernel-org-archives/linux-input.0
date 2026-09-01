Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8736635E1CC
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 06:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245321; cv=none; b=T9PDfM6a8bsbbPLhkos4D/rO6kLHq1e2c1uIV40kjC4lbjo9sudZCUo5s3QhNKJRMLRtMWqWx9YsvUCzU33emhyBGxAjKn6a1E25KPQjhCtmxpd1biGu9wFFmPVneKMROeNJYXda8/EcCE9XYeddh+vWVULu3Dky0jPnxZyKPRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245321; c=relaxed/simple;
	bh=kiXNTPN5s5OAwLWCc3xsvn0fDxQGbM/SCFMd/VU8S3E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=awqXZz3T0LxHoreSueONOs6D9gM+E0Qg18ljLeOGpcZlSiOCrpjMI+UVTiiOP0sDZnWXBATANfiFu6fZ7WYiFqOR4S4hSu91BbuBl1JxF2VWLeVQY+JYmTMVGpdaC6ON5uMYJxTckqqxcbZkpmlvAVGmfzCRgQKD1pMVxAPEpyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iI0EdfnO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iI0EdfnO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4010A1F000E9;
	Tue,  1 Sep 2026 06:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788245320;
	bh=CVJZEq5ZNnzI1ipdARDBF3AzVkXD1TM7VflfMvAmhPk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iI0EdfnORgKfT5h0ItIRhZeF0cwdDVGIUqTBj2eX/8DXU5oozGcceIVwHjiLRLaEX
	 /bs8H6y0g17AWXRs/3z84eFbCMmOSwsIaT3eTL4YrbB9OYTdOc5Pn3RDwfF4d00HrO
	 //ylNcmF6W5ibQIxkQRfkJYzG9MfOnxFkTnpTgGbEUVtDs3+shH8Q5H2z0cz1CZ+wr
	 ZQLc3sWwHGmn81AJCva8zDGLzhPRcO19KhBwhour4mQ8vfWWMSNEVfy+kNnPhEPu5p
	 ywx/BzdEvGs8MyxfuQPL2G5Otv0TWOAtz1IAl2cLIvdQ+EA5pBfVU8BzWmOsa1NaEp
	 B6IgN2pEOjywg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/7] HID: hid-lenovo-go: reject unknown calibration
 action
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Dash" <mradityadash@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <0c37a763177a5b8b45e94ac678094165cd965bf1.1788222001.git.mradityadash@gmail.com>
References: <cover.1788222001.git.mradityadash@gmail.com>
 <0c37a763177a5b8b45e94ac678094165cd965bf1.1788222001.git.mradityadash@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 06:48:39 +0000
Message-Id: <20260901064840.4010A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The driver uses a static global singleton `drvdata` structure =
for per-device context, breaking support for multiple devices.
- [High] Missing HID hardware cleanup in `hid_go_probe` error path.
- [High] Sysfs attribute groups are permanently leaked in the `hid_go_cfg_p=
robe()` error paths.
- [High] Early return in `hid_go_remove()` on endpoint lookup failure skips=
 crucial teardown steps.
- [High] Improper workqueue error handling causes a Use-After-Free if `sche=
dule_delayed_work()` returns 0.
- [High] Uninitialized `rgb_profile` leads to an out-of-bounds firmware com=
mand configuration payload.
- [High] Incomplete fix: identical logical vulnerability exists in `feature=
_status_store` and `motor_config_store` causing malformed payloads.
--

commit ba76c1361f7d941a3336995df53ed1361e960284
Author: Aditya Dash <mradityadash@gmail.com>
Date:   Tue Sep 1 06:36:07 2026 +0000

    HID: hid-lenovo-go: reject unknown calibration action
   =20
    The calibration action table includes 'unknown' at index zero. The opti=
ons
    attribute skips that entry and lists only 'start' and 'stop', but the s=
tore
    searches the full table. Writing 'unknown' sends a request without an
    action byte.
   =20
    Reject CAL_UNKNOWN before building the request. Start and Stop both use=
 a
    one-byte action, so pass that size directly.
   =20
    Fixes: 995887a10da1 ("HID: hid-lenovo-go: Add Calibration Settings")
    Assisted-by: Pi:gpt-5.6-sol
    Signed-off-by: Aditya Dash <mradityadash@gmail.com>

> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index 59b457683357e..a6dec5490d179 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c
> @@ -1412,20 +1412,18 @@ static ssize_t calibrate_config_store(struct devi=
ce *dev,
>  				      const char *buf, u8 cmd, u8 sub_cmd,
>  				      size_t count, enum dev_type device_type)
>  {
> -	size_t size =3D 1;
> -	u8 val =3D 0;
> +	u8 val;
>  	int ret;
> =20
>  	ret =3D sysfs_match_string(cal_enabled_text, buf);
>  	if (ret < 0)
>  		return ret;
> +	if (ret =3D=3D CAL_UNKNOWN)
> +		return -EINVAL;
> =20
>  	val =3D ret;
> -	if (!val)
> -		size =3D 0;
> -
>  	ret =3D mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, cmd, sub_cmd,
> -			       device_type, &val, size);
> +			       device_type, &val, sizeof(val));
>  	if (ret < 0)
>  		return ret;

[Severity: High]
This is a pre-existing issue, but does this identical logical vulnerability
still exist in feature_status_store() and motor_config_store()?

Both of those functions appear to use sysfs_match_string() with string tabl=
es
where 'unknown' is index 0. If a user writes 'unknown' to features like
imu_enabled, val will be 0, triggering size =3D 0, and sending a malformed
payload missing its action byte to the firmware:

drivers/hid/hid-lenovo-go.c:feature_status_store() {
    ...
        ret =3D sysfs_match_string(enabled_status_text, buf);
        val =3D ret;
        break;
    ...
    if (!val)
        size =3D 0;

    ret =3D mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA,
                           SET_FEATURE_STATUS, index, device_type, &val,
                           size);
    ...
}

Could the same fix be applied to those functions?


[Severity: Critical]
This isn't a bug introduced by this patch, but does the driver use a static
global singleton drvdata structure for per-device context?

drivers/hid/hid-lenovo-go.c:
    ...
    } drvdata;
    ...

drivers/hid/hid-lenovo-go.c:hid_go_cfg_probe() {
    ...
    mutex_init(&drvdata.cfg_mutex);
    hid_set_drvdata(hdev, &drvdata);
    drvdata.hdev =3D hdev;
    ...
}

If multiple compatible devices are connected, would the active
synchronization primitives and workqueue list heads be unconditionally
re-initialized, potentially corrupting kernel linked lists and leading
to a use-after-free or deadlocks?


[Severity: High]
This is a pre-existing issue, but does the hid_go_probe() error path
miss hardware cleanup?

drivers/hid/hid-lenovo-go.c:hid_go_probe() {
    ...
    ret =3D hid_go_cfg_probe(hdev, id);
    if (ret)
        dev_err_probe(&hdev->dev, ret, "Failed to start configuration inter=
face\n");

    dev_dbg(&hdev->dev, "Started Legion Go HID Device: %x\n", ep);

    return ret;
}

If hid_go_cfg_probe() fails, the function directly returns the error code.
Does this leave the hardware active since hid_hw_close() or hid_hw_stop()
are not called, potentially causing a use-after-free when hardware events
trigger on the freed device?


[Severity: High]
This isn't a bug introduced by this patch, but are sysfs attribute groups
permanently leaked in the hid_go_cfg_probe() error paths?

drivers/hid/hid-lenovo-go.c:hid_go_cfg_probe() {
    ...
    ret =3D sysfs_create_groups(&hdev->dev.kobj, top_level_attr_groups);
    if (ret) {
    ...
    ret =3D devm_led_classdev_multicolor_register(&hdev->dev, &go_cdev_rgb);
    if (ret) {
        dev_err_probe(&hdev->dev, ret, "Failed to create RGB device\n");
        return ret;
    }
    ...
}

Since sysfs_create_groups() is not managed by devres, if subsequent steps
like devm_led_classdev_multicolor_register() fail, the function returns
directly. Since probe() fails, remove() will not be called. Could this leave
permanently dangling sysfs nodes tied to the kobject that cause a
use-after-free if accessed?


[Severity: High]
This is a pre-existing issue, but does the early return in hid_go_remove()
on endpoint lookup failure skip crucial teardown steps?

drivers/hid/hid-lenovo-go.c:hid_go_remove() {
    ...
    if (ep <=3D 0)
        return;
    ...
}

If the interface has zero endpoints, get_endpoint_address() returns -ENODEV
and the early return bypasses all teardown logic. Does this omit
hid_hw_close() and hid_hw_stop(), permanently leaking the active device
node and creating a use-after-free condition?


[Severity: High]
This isn't a bug introduced by this patch, but does improper workqueue error
handling cause a use-after-free if schedule_delayed_work() returns 0?

drivers/hid/hid-lenovo-go.c:hid_go_cfg_probe() {
    ...
    ret =3D schedule_delayed_work(&drvdata.go_cfg_setup, msecs_to_jiffies(2=
));
    if (!ret) {
        dev_err(&hdev->dev,
            "Failed to schedule startup delayed work\n");
        return -ENODEV;
    }
    ...
}

If schedule_delayed_work() returns 0 (meaning the work was already pending),
the driver treats this as a fatal failure and returns -ENODEV. Since probe()
fails, the HID core and devres will destroy the device and free hdev.
Because the work is still pending and never canceled, when the timer expire=
s,
will cfg_setup() execute and dereference the freed drvdata.hdev?


[Severity: High]
This is a pre-existing issue, but can an uninitialized rgb_profile lead to
an out-of-bounds firmware command configuration payload?

drivers/hid/hid-lenovo-go.c:rgb_effect_store() {
    ...
    index =3D drvdata.rgb_profile + 3;
    u8 rgb_profile[6] =3D { effect,
                  mc_cdev->subled_info[0].intensity,
    ...
    ret =3D rgb_cfg_call(drvdata.hdev, SET_RGB_CFG, index, rgb_profile, 6);
    ...
}

drvdata.rgb_profile is statically initialized to 0. If a user writes to the
rgb_effect or rgb_speed sysfs attributes before setting or reading
rgb_profile, index evaluates to 3 (corresponding to LIGHT_PROFILE_SEL).

This executes rgb_cfg_call() with a 6-byte payload targeting
LIGHT_PROFILE_SEL. If the firmware natively expects LIGHT_PROFILE_SEL to
receive a 1-byte payload, could sending a 6-byte profile array cause an
out-of-bounds write that crashes or corrupts the device firmware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788222001.gi=
t.mradityadash@gmail.com?part=3D6
