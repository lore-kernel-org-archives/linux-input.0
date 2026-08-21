Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68D6361640
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 21:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787349564; cv=none; b=ApBppuZlAiMy9ZKhZv38kVT5hOUW3xdvVjsILAQtbAaDoQCcL1uyjjLdGwn1KGkwKDvM+QVRezoD/HAXY4LXGNIJBWKPPvQtjryJQ20IhXBklXo+Jy8khMIF0Scb+YqvNHFUvhzpm5hALnP2BzTqeoAK864DJ3+D5w+8jQcHwgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787349564; c=relaxed/simple;
	bh=F/EU5HsjZMc+QGFKpER2aHYNIgZFvpKj68xbkbfyZmk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ID96/oZJySI/MS6R7KmMxEUukECbrOvvrYPRioOrwDXWm2nfkBcbRvS12wvF/0TIGtu7uijexwOKLa9S94AQqk27Oetd6s1bqIDEAlbCh3CINwYb2UosI0pubcSYsp9ubAIsWEeWojCqlRHJuSQm0hgr8P8hLzxzR3BvHYyv3NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1igLjh2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1igLjh2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B8C1F000E9;
	Fri, 21 Aug 2026 21:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787349562;
	bh=M9lfTg/UstGiteJq2Db41hQPzra640CdMT3gw853O6g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g1igLjh2aisTm3tshNzNpq9HRIemEZYe93GMGzXw5cIdrJFF1Gd9gdQCyXI5hHfkX
	 dweiFIG9VpGqoLnKoTYLO/s6RVIp/F1OpneMWwK7rsTie8XiEirFESu12BNvUeb8At
	 itvjOLYKD4yGwpw/0ydwuAJeUCIuV8aGnBiRbWrEFizGzZonRPxm/LvinhSAJvzYyV
	 jW1Ta2SVQLxcG6Gs3LNFdWBlFe7+p7FpmSiQ0QiomDS3P1u30ltlEZCDPyh35G+US/
	 u5xoIOnQDQ3S1hNIdi4gQ8GnqkmWWCcgLTd5DHyrTYgydepXsYIjO6k1HVGTn5qaWa
	 +lmdeOu5naanw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] HID: hid-lenovo-go: use the right controller
 selectors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Dash" <mradityadash@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260821214810.87826-5-mradityadash@gmail.com>
References: <20260821214810.87826-1-mradityadash@gmail.com>
 <20260821214810.87826-5-mradityadash@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:59:22 +0000
Message-Id: <20260821215922.84B8C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup in hid_go_probe() error paths.
- [High] Global state corruption from statically allocated per-device state.
- [High] AB-BA deadlock in hid_go_cfg_remove() with sysfs.
- [High] Early return in hid_go_remove() bypassing cleanup causes Use-After=
-Free.
--

--- Patch [4]: [PATCH 4/5] HID: hid-lenovo-go: use the right controller sel=
ectors ---
commit 21361c83148d2f3658bbae16a33bf294b6a2f9f0
Author: Aditya Dash <mradityadash@gmail.com>

    HID: hid-lenovo-go: use the right controller selectors
   =20
    The right imu_enabled attribute selects FEATURE_IMU_BYPASS, and the rig=
ht
    reset attribute targets the left controller. Select FEATURE_IMU_ENABLE
    for the right imu_enabled attribute. Target the right controller for a
    right reset.

> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index d2d134873dd1f..1e6915c969d8c 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c
> @@ -2006,13 +2006,13 @@ LEGO_DEVICE_ATTR_RW(imu_bypass_right, "imu_bypass=
_enabled", RIGHT_CONTROLLER,
>  		    index, feature_status);
>  static DEVICE_ATTR_RO_NAMED(imu_bypass_right_index, "imu_bypass_enabled_=
index");
> =20
> -static struct go_cfg_attr imu_enabled_right =3D { FEATURE_IMU_BYPASS };
> +static struct go_cfg_attr imu_enabled_right =3D { FEATURE_IMU_ENABLE };
>  LEGO_DEVICE_ATTR_RW(imu_enabled_right, "imu_enabled", RIGHT_CONTROLLER, =
index,
>  		    feature_status);
>  static DEVICE_ATTR_RO_NAMED(imu_enabled_right_index, "imu_enabled_index"=
);
> =20
>  static struct go_cfg_attr reset_right =3D { FEATURE_RESET_GAMEPAD };
> -LEGO_DEVICE_ATTR_WO(reset_right, "reset", LEFT_CONTROLLER, feature_statu=
s);
> +LEGO_DEVICE_ATTR_WO(reset_right, "reset", RIGHT_CONTROLLER, feature_stat=
us);
> =20
>  static struct go_cfg_attr rumble_mode_right =3D { RUMBLE_MODE };
>  LEGO_DEVICE_ATTR_RW(rumble_mode_right, "rumble_mode", RIGHT_CONTROLLER, =
index,

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for the error
path in hid_go_probe() to leak resources?

drivers/hid/hid-lenovo-go.c:hid_go_probe() {
    ...
    ret =3D hid_go_cfg_probe(hdev, id);
    if (ret) {
        dev_err_probe(&hdev->dev, ret, "Failed to start configuration inter=
face\n");
        return ret;
    }
    ...
}

If hid_go_cfg_probe() fails (e.g., due to sysfs_create_groups() returning
an error), it propagates the error and returns without calling
hid_hw_close() and hid_hw_stop().

Additionally, does hid_go_cfg_probe() leave sysfs attributes active if it
fails?

drivers/hid/hid-lenovo-go.c:hid_go_cfg_probe() {
    ...
    ret =3D sysfs_create_groups(&hdev->dev.kobj, top_level_attr_groups);
    ...
}

Subsequent error paths in hid_go_cfg_probe() do not appear to clean up
these sysfs groups before returning. If the module is subsequently unloaded,
the un-removed sysfs attributes could remain on the device.

[Severity: High]
This is a pre-existing issue, but does using a static global struct for
device state cause corruption if multiple devices are probed?

drivers/hid/hid-lenovo-go.c: {
...
static struct hid_go_cfg {
    struct delayed_work go_cfg_setup;
    struct led_classdev *led_cdev;
    struct hid_device *hdev;
    struct mutex cfg_mutex;
//...
} drvdata;
...
}

When hid_go_cfg_probe() is called, it overwrites the hardware device pointer
and re-initializes the work item:

drivers/hid/hid-lenovo-go.c:hid_go_cfg_probe() {
    ...
    hid_set_drvdata(hdev, &drvdata);
    drvdata.hdev =3D hdev;
    ...
    INIT_DELAYED_WORK(&drvdata.go_cfg_setup, &cfg_setup);
    ...
}

If a second gamepad is connected, could this overwrite drvdata.hdev, causing
sysfs requests for the first device to operate on the second? Also, could
calling INIT_DELAYED_WORK() while it is pending for the first device corrupt
the timer list entry?

[Severity: High]
This is a pre-existing issue, but is there a potential deadlock between
sysfs and the configuration mutex in hid_go_cfg_remove()?

drivers/hid/hid-lenovo-go.c:hid_go_cfg_remove() {
    ...
    guard(mutex)(&drvdata.cfg_mutex);
    sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);
    ...
}

sysfs_remove_groups() synchronously waits for active sysfs readers/writers
to drop their kernfs active references. Concurrently, a sysfs reader/writer
might invoke mcu_property_out(), which attempts to acquire
drvdata.cfg_mutex. Could this result in the remove thread holding the mutex
and waiting for sysfs, while the sysfs thread holds the active reference and
waits for the mutex?

[Severity: High]
This isn't a bug introduced by this patch, but does the early return in
hid_go_remove() bypass cleanup?

drivers/hid/hid-lenovo-go.c:hid_go_remove() {
    ...
    int ep =3D get_endpoint_address(hdev);

    if (ep <=3D 0)
        return;
    ...
}

In hid_go_probe(), missing endpoints result in returning success (0),
leaving the hardware active:

drivers/hid/hid-lenovo-go.c:hid_go_probe() {
    ...
    ep =3D get_endpoint_address(hdev);
    if (ep !=3D GO_GP_INTF_IN) {
        dev_dbg(&hdev->dev, "Started interface %x as generic HID device\n",=
 ep);
        return 0;
    }
    ...
}

If the device is later unplugged or unbound, hid_go_remove() returns early,
bypassing hid_hw_stop(). Could the HID hardware remain active while devres
frees the driver data, potentially allowing subsequent incoming hardware
events to access freed devres structures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821214810.8782=
6-1-mradityadash@gmail.com?part=3D4
