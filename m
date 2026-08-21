Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2DE35AC0C
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 22:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787349832; cv=none; b=V5d/9lSlpQ5ozHaPTPLWexQS0O/IRArcakkYJB5M4VcGlOeXuWn0pVHKYNSv27zk7rHCJeUixR9bDFO43Yml9dbaBK92yfCIYUBct2h9N6ZIMN4DVnBdquTDHhYEJNPUOPveMzew6+pGXDMWwlInojNNfU0tv3Mt5CJQbEy4KpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787349832; c=relaxed/simple;
	bh=9qWCTV/HMvZwl78E1tosr99E3or5K4AnKAJiYlcrr6E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r5QF5St8vfSsFF+xVWSRsJSkAI92kaKiKUoW/06Wj0m/3DXdoqZBksgB7WWIl0yoA12EmuJVbjyA2JgfI8vpb6RsAFJKh6OzVOqNAREyY5eAlnbU7ZC/n1c96qiqffL1v9ZEorVvfy91xTWPLNCEogmV8wc5TQt+x7jYLWdjvT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vgfz6sCw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vgfz6sCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764841F00A3A;
	Fri, 21 Aug 2026 22:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787349830;
	bh=zu9eX/FBe9P1UF4AkXURpwnJBcryFvZiNSSd8Rjh2bY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vgfz6sCwAmBWnatLJm0luGCoNeHtI3MTmPfDKYFAi+aov/WQa5iXipsLnszkPBlgT
	 xKqJ1oep24OnPxNEQ5DW/xjackQyyoDDIBCs1Y6J283dJQoLohD7fZs660Wzz/cKPm
	 OQewWE34VuoJva8TPs+9q8LSX6CRMmenIkYJWZ3NatMuS8Tg0WNX+Hmc13GAJGA9GF
	 iKwQ6DGv5cF0JdNQzW3SvHvdIBX5lA8XfsoGz9V1JqkShb1Q7o9m8RQ6iRUOQ5Ce42
	 wKkyoikFni+RMJBfv85WOF7MiSunGygqz5zYBqtk7a6qLdtafdw+kvOju2rWt6VaMi
	 Wr8i1NP/qzgFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] HID: hid-lenovo-go: return configuration request
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Dash" <mradityadash@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260821214810.87826-6-mradityadash@gmail.com>
References: <20260821214810.87826-1-mradityadash@gmail.com>
 <20260821214810.87826-6-mradityadash@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 22:03:50 +0000
Message-Id: <20260821220350.764841F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Global state variables prevent support for multiple devices, intro=
duce cross-talk, and cause list corruption.
- [High] Propagating timeouts and errors from mcu_property_out() causes cfg=
_setup() to abort prematurely, leaving device state uninitialized.

Pre-existing issues:
- [High] Missing hid_hw_stop() and hid_hw_close() in probe error paths, and=
 missing hid_hw_stop() in remove() for malformed endpoints.
- [High] Failure during schedule_delayed_work leaves the delayed work pendi=
ng while probe fails, leading to a Use-After-Free.
- [High] ABBA deadlock between `drvdata.cfg_mutex` and kernfs active refere=
nce during unbind.
--

--- Patch [5]: [PATCH 5/5] HID: hid-lenovo-go: return configuration request=
 errors ---
commit 3a9434af7b761a1d874276ba01fa7f976cec0f1f
Author: Aditya Dash <mradityadash@gmail.com>

    HID: hid-lenovo-go: return configuration request errors
   =20
    The driver completes a pending request when it receives any decoded
    configuration reply. It also discards the result of its interruptible w=
ait.
    A configuration operation can therefore report success after an unrelat=
ed
    reply, firmware error, interrupted wait, or timeout.

> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index 1e6915c969d8c..a1a255c28e2d2 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c

[ ... ]

> +/* Lenovo replies identify a command and a sub-command, but have no sequ=
ence. */
> +struct hid_go_cmd {
> +	struct completion done;
> +	spinlock_t lock; /* protects fields below */
> +	bool pending;
> +	u8 id;
> +	u8 command;
> +	u8 sub_command;
> +	u8 device;
> +	int result;
> +};
> +
> +static struct hid_go_cmd go_cmd =3D {
> +	.done =3D COMPLETION_INITIALIZER(go_cmd.done),
> +	.lock =3D __SPIN_LOCK_UNLOCKED(go_cmd.lock),
> +};

[Severity: High]
Does this global state variable prevent support for multiple devices and
introduce cross-talk?

If multiple Lenovo Legion Go controllers are connected simultaneously, they
will share this global go_cmd singleton. A late reply from one controller
could satisfy a pending wait on another, or hid_go_cmd_arm() will blindly
overwrite the state of a concurrent command.

Additionally, this driver uses global state in hid_go_cfg_probe():

	ret =3D devm_led_classdev_multicolor_register(&hdev->dev, &go_cdev_rgb);

and:

	INIT_DELAYED_WORK(&drvdata.go_cfg_setup, &cfg_setup);

Using a static global struct pointer (&go_cdev_rgb) corrupts the LED
subsystem's linked lists when a second device is probed. Unconditionally
resetting a global work structure with INIT_DELAYED_WORK corrupts workqueue
linked lists if the work is already pending.

[ ... ]

> @@ -747,22 +834,19 @@ static int mcu_property_out(struct hid_device *hdev=
, u8 id, u8 command,
>  	dev_dbg(&hdev->dev, "Send data as raw output report: [%*ph]\n",
>  		GO_PACKET_SIZE, dmabuf);
> =20
> -	ret =3D hid_hw_output_report(hdev, dmabuf, GO_PACKET_SIZE);
> -	if (ret < 0)
> -		return ret;
> +	if (id =3D=3D MCU_CONFIG_DATA &&
> +	    ((command =3D=3D SET_TRIGGER_CFG && index =3D=3D TRIGGER_CALIBRATE)=
 ||
> +	     (command =3D=3D SET_JOYSTICK_CFG && index =3D=3D JOYSTICK_CALIBRAT=
E) ||
> +	     (command =3D=3D SET_GYRO_CFG && index =3D=3D GYRO_CALIBRATE)))
> +		return hid_go_send_output_report(hdev, dmabuf);
> =20
> -	ret =3D ret =3D=3D GO_PACKET_SIZE ? 0 : -EINVAL;
> +	hid_go_cmd_arm(id, command, index, device);
> +	ret =3D hid_go_send_output_report(hdev, dmabuf);
>  	if (ret)
> -		return ret;
> -
> -	ret =3D wait_for_completion_interruptible_timeout(&drvdata.send_cmd_com=
plete,
> -							msecs_to_jiffies(timeout));
> -
> -	if (ret =3D=3D 0) /* timeout occurred */
> -		ret =3D -EBUSY;
> -
> -	reinit_completion(&drvdata.send_cmd_complete);
> -	return 0;
> +		return hid_go_cmd_cancel(ret);
> +	wait_result =3D wait_for_completion_interruptible_timeout(&go_cmd.done,
> +								msecs_to_jiffies(timeout));
> +	return hid_go_cmd_finish(wait_result);

[Severity: High]
Does returning the exact timeout or error from mcu_property_out() cause
cfg_setup() to abort prematurely and leave the device uninitialized?

Prior to this patch, mcu_property_out() unconditionally returned 0 on timeo=
ut.
The initialization worker cfg_setup() sequentially probes all sub-components
and aborts on the first error:

	ret =3D mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_VERSION_DATA,
			       PRODUCT_VERSION, USB_MCU, NULL, 0);
	if (ret < 0) {
		dev_err(&drvdata.hdev->dev,
			"Failed to retrieve USB_MCU Product Version: %i\n", ret);
		return;
	}

Since mcu_property_out() now propagates -ETIMEDOUT or firmware errors, the
first non-responsive component (such as querying TX_DONGLE when connected
via USB) will cause cfg_setup() to completely abort, leaving RGB LEDs and
other attributes uninitialized.

[ ... ]

> @@ -2395,8 +2479,6 @@ static int hid_go_cfg_probe(struct hid_device *hdev,
> =20
>  	drvdata.led_cdev =3D &go_cdev_rgb.led_cdev;
> =20
> -	init_completion(&drvdata.send_cmd_complete);
> -
>  	/* Executing calls prior to returning from probe will lock the MCU. Sch=
edule
>  	 * initial data call after probe has completed and MCU can accept calls.
>  	 */
>  	INIT_DELAYED_WORK(&drvdata.go_cfg_setup, &cfg_setup);
>  	ret =3D schedule_delayed_work(&drvdata.go_cfg_setup, msecs_to_jiffies(2=
));
>  	if (!ret) {
>  		dev_err(&hdev->dev,
>  			"Failed to schedule startup delayed work\n");
>  		return -ENODEV;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but does returning -ENODEV here
leave the delayed work pending while the probe fails?

If schedule_delayed_work() returns 0 (which happens if the work is already
queued by a previously probed device), probe fails and returns -ENODEV. The
HID core will destroy the device and free its devres-managed memory, but the
delayed work is never canceled in this error path. When it fires, cfg_setup=
()
will dereference the freed hdev pointer, resulting in a use-after-free.

[ ... ]

[Severity: High]
This is a pre-existing issue, but does missing hid_hw_stop() and hid_hw_clo=
se()
in probe error paths cause resource leaks and use-after-free?

In hid_go_probe():

	ret =3D hid_go_cfg_probe(hdev, id);
	if (ret)
		dev_err_probe(&hdev->dev, ret, "Failed to start configuration interface\n=
");

	dev_dbg(&hdev->dev, "Started Legion Go HID Device: %x\n", ep);

	return ret;

If hid_go_cfg_probe() fails, the function returns the error directly without
unwinding hid_hw_start() and hid_hw_open(). The HID core does not automatic=
ally
stop the hardware if a custom probe fails after hid_hw_start() has succeede=
d.

Similarly, in hid_go_remove():

	int ep =3D get_endpoint_address(hdev);

	if (ep <=3D 0)
		return;

If a malicious USB device presents no endpoints, get_endpoint_address() ret=
urns
-ENODEV (<=3D 0), causing the function to return early without calling
hid_hw_close() and hid_hw_stop().

[Severity: High]
This is a pre-existing issue, but does locking drvdata.cfg_mutex before
removing sysfs groups create an ABBA deadlock?

During unbind, hid_go_cfg_remove() does this:

	guard(mutex)(&drvdata.cfg_mutex);
	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);

When a sysfs file is read, kernfs first acquires an active reference, and t=
hen
the driver callback acquires drvdata.cfg_mutex.

During device removal, hid_go_cfg_remove() first acquires drvdata.cfg_mutex
and then calls sysfs_remove_groups(), which blocks waiting for all kernfs
active references to drop. If a sysfs read races with device unbind, Thread=
 1
holds the kernfs active ref and waits for cfg_mutex, while Thread 2 holds
cfg_mutex and waits for the kernfs active ref to drop.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821214810.8782=
6-1-mradityadash@gmail.com?part=3D5
