Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C844CCDE7
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 06:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245415; cv=none; b=t/DKuG8y4Ay27ZqAViIOUI37jNv7tWLxJGtu7C++O83F0OUzFEXnsFnNVvirodVrDG1nXfIJnkm9VTbVYNfHhSpyNKKC5WP6q3VYsYnH5na3mGwWd1bbJqX8sEZR+23CKsH8VCOFQniiJ5/9LFJc/UZZJzRg+4Di/A5gmhNkwWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245415; c=relaxed/simple;
	bh=aiWDDniSAP4ddhGUWY8Jqjrsv9X8ntQuw5xmojmqE+Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MHgANSkTcAJ+FTkVqUfO8ReO8ydBH5NqejQeXtu/imhoUaOHx4K2TSufHCTqclRHqoA3aAsjMTBIHqW7vNn5y5JNi+cqB/HLCw3Bb/Crq+9jAdKUVWM5A/bg5csrT2ulySvqXR91MDm+LS/MfgtyfWIN3kvtEM/7cauIjIboZJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tg/HcuMb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tg/HcuMb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6C91F00A3D;
	Tue,  1 Sep 2026 06:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788245414;
	bh=EOw8kKDiJ4edvPJBStXHNoxYvrAPB89rI6vyJrU9oZ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tg/HcuMbdO8DTttfnidY+8G13CSqNZkKGEBFgn+ZQY853fXAL6NDWh89mr2g0NZ2Q
	 ZGhIGAERZBIcrwctR2E24CrwkVMD7wKzOW7GOp0YCLtwqDediuKWD94m7FJfw4qp3n
	 yBoOOeFTBwB1aPTZP2zwB93UHZj/frx0ZhlPgJu9YbJyw1u6PpEwAUnvSngTiMmK/i
	 DmXg7guYibzci5zJFGNO4zEFC7D9TOCgdD8k4OTLu0Gd6Tl2izZifUF86cKN+54pep
	 v9hO+7iAGLF2gZWFynB/tdBUoLFKc3IPupaRvlEzUkT/D0xRrOJkI5EofN25f19b2A
	 4k8Ts5oC38gmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/7] HID: hid-lenovo-go: normalize calibration
 failure status
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Dash" <mradityadash@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <49b6e07395d2fe555e844758bd8ccf34ac0cbf0c.1788222001.git.mradityadash@gmail.com>
References: <cover.1788222001.git.mradityadash@gmail.com>
 <49b6e07395d2fe555e844758bd8ccf34ac0cbf0c.1788222001.git.mradityadash@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 06:50:13 +0000
Message-Id: <20260901065014.1F6C91F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Global State Corruption and Race Conditions due to statically =
allocated `drvdata`
- [Critical] Failure to perform required hardware stops and sysfs cleanup i=
n error paths and during removal
- [High] AB-BA deadlock between `cfg_mutex` and kernfs node active reference
- [High] Unprotected state modifications leading to TOCTOU out-of-bounds sy=
sfs read
- [High] LED `brightness_set` callback sleeps in atomic context
--

commit cf1e16b8555a2e916e8e5528ed0d93bceadd90b8
Author: Aditya Dash <mradityadash@gmail.com>

HID: hid-lenovo-go: normalize calibration failure status
   =20
The driver stores the firmware result byte as an index into the
calibration status text. A Legion Go 1 returned 0x08 after an idle Stop.
The status table has only three entries, so a later read returns -EINVAL.

Keep the defined values 0x00 through 0x02. Treat larger result values as
failure before storing them.

> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index deed7acd2dc4b..59b457683357e 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c
> @@ -648,17 +648,22 @@ static int hid_go_light_event(struct command_report=
 *cmd_rep)
> =20
>  static int hid_go_device_status_event(struct command_report *cmd_rep)
>  {
> +	u8 status =3D cmd_rep->data[1];
> +
> +	if (status > CAL_STAT_FAILURE)
> +		status =3D CAL_STAT_FAILURE;
> +
>  	switch (cmd_rep->device_type) {
>  	case LEFT_CONTROLLER:
>  		switch (cmd_rep->data[0]) {
>  		case CALDEV_GYROSCOPE:
> -			drvdata.gp_left_gyro_cal_status =3D cmd_rep->data[1];
> +			drvdata.gp_left_gyro_cal_status =3D status;
>  			return 0;
>  		case CALDEV_JOYSTICK:
> -			drvdata.gp_left_joy_cal_status =3D cmd_rep->data[1];
> +			drvdata.gp_left_joy_cal_status =3D status;
>  			return 0;
>  		case CALDEV_TRIGGER:
> -			drvdata.gp_left_trigg_cal_status =3D cmd_rep->data[1];
> +			drvdata.gp_left_trigg_cal_status =3D status;
>  			return 0;
>  		default:
>  			return -EINVAL;
> @@ -667,13 +672,13 @@ static int hid_go_device_status_event(struct comman=
d_report *cmd_rep)
>  	case RIGHT_CONTROLLER:
>  		switch (cmd_rep->data[0]) {
>  		case CALDEV_GYROSCOPE:
> -			drvdata.gp_right_gyro_cal_status =3D cmd_rep->data[1];
> +			drvdata.gp_right_gyro_cal_status =3D status;
>  			return 0;
>  		case CALDEV_JOYSTICK:
> -			drvdata.gp_right_joy_cal_status =3D cmd_rep->data[1];
> +			drvdata.gp_right_joy_cal_status =3D status;
>  			return 0;
>  		case CALDEV_TRIGGER:
> -			drvdata.gp_right_trigg_cal_status =3D cmd_rep->data[1];
> +			drvdata.gp_right_trigg_cal_status =3D status;
>  			return 0;
>  		default:
>  			return -EINVAL;

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for a TOCTOU
out-of-bounds read to happen here?

drivers/hid/hid-lenovo-go.c:hid_go_light_event()
	case USR_LIGHT_PROFILE_3:
		mc_cdev =3D lcdev_to_mccdev(drvdata.led_cdev);
		drvdata.rgb_effect =3D cmd_rep->data[0];
		mc_cdev->subled_info[0].intensity =3D cmd_rep->data[1];

Since hid_go_light_event() overwrites drvdata.rgb_effect locklessly from
a hardware event, could rgb_effect_show() read drvdata.rgb_effect out of
bounds?

	if (drvdata.rgb_effect >=3D ARRAY_SIZE(rgb_effect_text))
		return -EINVAL;

	return sysfs_emit(buf, "%s\n", rgb_effect_text[drvdata.rgb_effect]);

Without READ_ONCE(), the compiler could emit two loads for drvdata.rgb_effe=
ct.
If an interrupt fires and updates the value between the bounds check and the
array access, could this result in an out-of-bounds array read?

[Severity: Critical]
This is a pre-existing issue, but does this driver corrupt locks, active
completions, and work items when probing multiple devices or interfaces?

drivers/hid/hid-lenovo-go.c
static struct hid_go_cfg {
	struct delayed_work go_cfg_setup;
	struct hid_go_cmd cmd;
...
} drvdata;

When a subsequent interface or device is probed, hid_go_probe() and
hid_go_cfg_probe() overwrite the global drvdata.hdev and globally
re-initialize the active locks:

drivers/hid/hid-lenovo-go.c:hid_go_cfg_probe()
	mutex_init(&drvdata.cfg_mutex);
	hid_set_drvdata(hdev, &drvdata);
	drvdata.hdev =3D hdev;

drivers/hid/hid-lenovo-go.c:hid_go_probe()
		init_completion(&drvdata.cmd.done);
		spin_lock_init(&drvdata.cmd.lock);

If multiple interfaces bind to the driver concurrently, wouldn't this
definitive destruction of active locks and memory structures cause deadlock=
s,
use-after-free, or list corruption panics for the first device?

[Severity: Critical]
This is a pre-existing issue, but does this code bypass hardware teardown a=
nd
sysfs cleanup during error paths and removal?

In hid_go_probe(), if the configuration interface fails to start, the
function returns directly without halting the manually started hardware:

	ret =3D hid_go_cfg_probe(hdev, id);
	if (ret)
		dev_err_probe(&hdev->dev, ret, "Failed to start configuration interface\n=
");

	return ret;

Similarly, in hid_go_cfg_probe(), if LED registration fails, the error path
fails to remove the sysfs groups created earlier:

	ret =3D devm_led_classdev_multicolor_register(&hdev->dev, &go_cdev_rgb);
	if (ret) {
		dev_err_probe(&hdev->dev, ret, "Failed to create RGB device\n");
		return ret;
	}

Additionally, in hid_go_remove(), hardware teardown (hid_hw_stop) is entire=
ly
bypassed for endpoints that are not GO_GP_INTF_IN:

	int ep =3D get_endpoint_address(hdev);

	if (ep <=3D 0)
		return;

	switch (ep) {
	case GO_GP_INTF_IN:
		hid_go_cfg_remove(hdev);
		break;
	}
}

Will these omissions lead to Use-After-Free vulnerabilities or resource lea=
ks
when userspace accesses the remaining orphaned sysfs files or active
interfaces?

[Severity: High]
This isn't a bug introduced by this patch, but is there an AB-BA deadlock
between cfg_mutex and kernfs node active references?

drivers/hid/hid-lenovo-go.c:hid_go_cfg_remove()
	guard(mutex)(&drvdata.cfg_mutex);
	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);

A sysfs store callback (such as feature_status_store) holds a kernfs active
reference while attempting to acquire drvdata.cfg_mutex via mcu_property_ou=
t().

Concurrently, during device removal, hid_go_cfg_remove() acquires
drvdata.cfg_mutex first and then calls sysfs_remove_groups(), which blocks
until all kernfs active references drain.

Could this trigger a system deadlock involving sysfs readers/writers and
device unbind?

[Severity: High]
This is a pre-existing issue, but does the LED brightness_set callback
sleep in atomic context?

The driver assigns hid_go_brightness_set to the non-blocking API:

	.brightness_set =3D hid_go_brightness_set,

However, this synchronous callback invokes sleeping functions:

drivers/hid/hid-lenovo-go.c:mcu_property_out()
	guard(mutex)(&drvdata.cfg_mutex);
...
	wait_result =3D wait_for_completion_interruptible_timeout(&drvdata.cmd.don=
e,
								timeout);

Since the LED subsystem invokes this callback from atomic context (e.g.,
software timers for blinking or heartbeat), wouldn't calling mutex_lock()
and wait_for_completion_interruptible_timeout() cause a scheduling while
atomic kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788222001.gi=
t.mradityadash@gmail.com?part=3D5
