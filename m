Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADCD1F1534
	for <linux-input@vger.kernel.org>; Sat, 16 May 2026 05:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778910521; cv=none; b=ZFKtIgiPeubjESgfH4rhPL4o10MHx7UAPAwhTpqv86gjmSZ8ZleVQPM3aejD1kXeipe54Zj2XdIFz1CRZe1JHkupyyIo6dt09fC/I4lZ+zGKHelzw6x3UXmx37JcWtkpiNAdmOWD+6ABCjXb/m86kyvVfneo+D0ZvxuZ8tApYtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778910521; c=relaxed/simple;
	bh=RHw4/MTZsbb+9GTxJ3lqgOGr3qZj5szK5AkgMb65n24=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IeXSH71MMmWKgqPsiYRbYilVQ5JSumzgypNVR2X2jO4PrxSQi5WyNMlfkTRmVF6RGFJS7Nq+Yxlpq0RNazE1TTY+FRGf9/Fc5cTHkGAM3M3dwQ/zc3M+79JOvDgoYIGkYazRjlKPoHsAYj6Y/jSE3a0NWOktnpen44z0SiZdPfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNkHwUxW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNkHwUxW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55971C19425;
	Sat, 16 May 2026 05:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778910521;
	bh=RHw4/MTZsbb+9GTxJ3lqgOGr3qZj5szK5AkgMb65n24=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hNkHwUxWZTxVSWKkbGLF1bBtuPccUFeVJR9AoZPDO+rr+p69KxpJ5CnNQtodu1y9N
	 tgcABzYJrh3vKXqA8yWKj6atjTjQw98rvUgHnyNxYvM5v3a48c/ycP0vT21tC552fV
	 6a+Ig8S1W2mnbnT9IdsHJzkWCI1AqbXxHbK9wq7rECmNFwiiHduowLTSX/awRhhNrc
	 EnthA3Y/uYpq9ocEmOk8ZWueBtnXsvNjRJ6APJjNj8tr5pCuKNMI055AE6cXAsQ+/6
	 BLOilNwfLoSqohXBCM9RXw806gLuVw8puozwAZDo0tk9/0/rN7K9rdioj2kTXSc0sr
	 owNUdN9Yc71+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] HID: hid-msi: Add RGB control interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260516042841.500299-4-derekjohn.clark@gmail.com>
References: <20260516042841.500299-4-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 05:48:40 +0000
Message-Id: <20260516054841.55971C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Holding a spinlock while calling sleeping functions causes a kerne=
l panic.
- [High] `frame_lock` is acquired in process context without disabling inte=
rrupts, leading to a deadlock.
- [High] Re-arming of workqueue during teardown leads to Use-After-Free.
- [High] Early LED registration exposes sysfs attributes before initializat=
ion is complete, causing NULL pointer dereferences or Use-After-Free.
- [Medium] The `frame_lock` spinlock is never initialized.
- [Low] Mixing `goto` and scope-based cleanup helpers in the same function =
violates subsystem guidelines.
--

commit 7eda00d45299494b87bf52e044ab97d5c4a78385
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add RGB control interface

This commit adds an RGB control interface for MSI Claw devices, supporting =
up
to 8 frames of sequential RGB zone data. It implements several lighting
effects mirroring the Windows driver functionality.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index bc0169c992ae8..8ea8f551b8e43 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c
[ ... ]
> @@ -309,15 +372,46 @@ static int claw_profile_event(struct claw_drvdata *=
drvdata, struct claw_command_
>  		for (i =3D 0; i < CLAW_KEYS_MAX; i++)
>  			codes[i] =3D (cmd_rep->data[6 + i]);
>  		break;
> +	case CLAW_RGB_PENDING:
> +		frame =3D (struct rgb_report *)cmd_rep->data;
> +		rgb_addr =3D drvdata->rgb_addr;
> +		read_addr =3D be16_to_cpu(frame->read_addr);
> +		frame_calc =3D (read_addr - rgb_addr) / CLAW_RGB_FRAME_OFFSET;
> +		if (frame_calc >=3D CLAW_RGB_MAX_FRAMES) {
> +			dev_err(drvdata->led_mc.led_cdev.dev, "Got unsupported frame index: %=
x\n",
> +				frame_calc);
> +			ret =3D -EINVAL;
> +			goto err_pending;
> +		}
> +		f_idx =3D frame_calc;
> +
> +		scoped_guard(spinlock, &drvdata->frame_lock) {

This function mixes a goto-based error path (err_pending) with a
scope-based cleanup helper (scoped_guard). Is it possible to convert the
error handling to use cleanup helpers, or remove the scoped guard? Subsystem
guidelines state that goto and cleanup helpers should not be mixed in the
same function.

[ ... ]
> +/* Apply solid effect (1 frame, all zones same color) */
> +static int claw_apply_monocolor(struct claw_drvdata *drvdata)
> +{
> +	struct mc_subled *subleds =3D drvdata->led_mc.subled_info;
> +	struct rgb_zone zone =3D { subleds[0].intensity, subleds[1].intensity,
> +				 subleds[2].intensity };
> +
> +	guard(spinlock)(&drvdata->frame_lock);

Are we acquiring the spinlock without disabling interrupts here? Since
frame_lock is also acquired in claw_profile_event() which runs in the
HID raw event interrupt context, could this lead to a deadlock if an
interrupt fires while this process context holds the lock? Using
guard(spinlock_irqsave) might be necessary to prevent this.

Also, does calling claw_write_rgb_state() while holding the frame_lock
spinlock cause an issue?

Looking at claw_write_rgb_state(), it acquires a mutex, allocates memory
with GFP_KERNEL inside claw_hw_output_report(), and can sleep via
wait_for_completion_interruptible_timeout(). Calling these sleeping functio=
ns
while holding a spinlock will trigger a scheduling while atomic panic.

> +	drvdata->rgb_frame_count =3D 1;
> +	claw_frame_fill_solid(&drvdata->rgb_frames[0], zone);
> +
> +	return claw_write_rgb_state(drvdata);
> +}
[ ... ]
>  static int claw_probe(struct hid_device *hdev, u8 ep)
> @@ -843,12 +1361,28 @@ static int claw_probe(struct hid_device *hdev, u8 =
ep)
>  	if (!drvdata->bmap_support)
>  		dev_dbg(&hdev->dev, "M-Key mapping is not supported. Update firmware t=
o enable.\n");
> =20
> +	drvdata->led_mc.led_cdev.name =3D "msi_claw:rgb:joystick_rings";
> +	drvdata->led_mc.led_cdev.brightness =3D 0x50;
> +	drvdata->led_mc.led_cdev.max_brightness =3D 0x64;
> +	drvdata->led_mc.led_cdev.color =3D LED_COLOR_ID_RGB;
> +	drvdata->led_mc.led_cdev.brightness_set =3D claw_led_brightness_set;
> +	drvdata->led_mc.num_colors =3D 3;
> +	drvdata->led_mc.subled_info =3D devm_kmemdup(&hdev->dev, claw_rgb_suble=
d_info,
> +						   sizeof(claw_rgb_subled_info), GFP_KERNEL);
> +	if (!drvdata->led_mc.subled_info)
> +		return -ENOMEM;
> +
>  	mutex_init(&drvdata->cfg_mutex);
>  	mutex_init(&drvdata->profile_mutex);
>  	mutex_init(&drvdata->rom_mutex);
>  	init_completion(&drvdata->send_cmd_complete);

Is frame_lock missing an explicit initialization? It doesn't appear to be
initialized with spin_lock_init(). Relying on devm_kzalloc
zero-initialization for spinlocks can lead to kernel panics or lockdep
warnings on debug kernels.

>  	INIT_DELAYED_WORK(&drvdata->cfg_resume, &cfg_resume_fn);
>  	INIT_DELAYED_WORK(&drvdata->cfg_setup, &cfg_setup_fn);
> +	INIT_DELAYED_WORK(&drvdata->rgb_queue, &claw_rgb_queue_fn);
> +
> +	ret =3D devm_led_classdev_multicolor_register(&hdev->dev, &drvdata->led=
_mc);
> +	if (ret)
> +		return ret;

By registering the LED device here, the sysfs attributes (like brightness)
are exposed to userspace before hid_set_drvdata() is called later in probe.

If userspace writes to brightness immediately, it will schedule rgb_queue.
When the work executes, will it encounter a NULL pointer dereference, since
claw_hw_output_report() relies on hid_get_drvdata() which hasn't been set
yet?

Additionally, if hid_hw_open() fails, the probe returns an error and devres
cleans up drvdata. Since the queued work isn't canceled on this error path,
could this result in a use-after-free when the work eventually runs?

> =20
>  	/* For control interface: open the HID transport for sending commands. =
*/
>  	ret =3D hid_hw_open(hdev);
[ ... ]
> @@ -910,10 +1444,14 @@ static void claw_remove(struct hid_device *hdev)
>  		return;
>  	}
> =20
> +	/* Block writes to brightness/multi_intensity during teardown */
> +	drvdata->led_mc.led_cdev.brightness_set =3D NULL;
>  	cancel_delayed_work_sync(&drvdata->cfg_setup);
>  	cancel_delayed_work_sync(&drvdata->cfg_resume);
> +	cancel_delayed_work_sync(&drvdata->rgb_queue);
> =20
>  	guard(mutex)(&drvdata->cfg_mutex);
> +	device_remove_group(drvdata->led_mc.led_cdev.dev, &claw_rgb_attr_group);

Does canceling the delayed work before removing the sysfs attributes leave
a race condition?

Since device_remove_group() is called after cancel_delayed_work_sync(), the
sysfs files (like effect or speed) are still active. If a concurrent write
from userspace occurs, it can call mod_delayed_work() and re-queue
rgb_queue.

Once claw_remove() finishes, devres will free drvdata. When the re-queued
work executes later, will it dereference the freed memory and cause a
use-after-free? Removing the sysfs group before canceling the work would
prevent this.

>  	device_remove_group(&hdev->dev, &claw_gamepad_attr_group);
>  	hid_hw_close(hdev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260516042841.5002=
99-1-derekjohn.clark@gmail.com?part=3D3
