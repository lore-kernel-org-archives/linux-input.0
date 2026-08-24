Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F226358363
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787594158; cv=none; b=nMxgNZyqrAekPNQpv4l1Pw+ZLnGrUUkffj+oPHWykbC7HEt7rLvSaP21bx2Scln3SYteTZQLiv1tZ3r1r7OK8lbHeuAz6GNUFIqJY/Z3K/CAZQxDXsH7V+jZYr/sNVjDlmO/p8Xo5kOkqEaPd5AHzF5GNwY/A+FYpMnPxGuAJg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787594158; c=relaxed/simple;
	bh=foccDMzGwf2+pUYbp6YhAY1Zj3xCMrWhtNbplXUZWrQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SmLULZiJC+jALr7DBZ/S4Lpz/90NgR2PPwW4PNAQye5VgShWPKZ4ncF91keoKGZ2j6bQfoL5mtLlfyK1D3AKMe6aPpshtmBkInLVs8+gy75a2V8XUAEwFSwkj2TluxdokZFt/6UmiIwi6IUEcRT4VfkaxDBE/ety8UJ+xyT6ISE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UipsLq3X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UipsLq3X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE3B1F000E9;
	Mon, 24 Aug 2026 17:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787594156;
	bh=iqjMyRNB4DLQslzpXYG4Nnhz0erVcFQqc/s0b17UkQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UipsLq3XDjzNGTRbyUtkloN49VTfvdLosbiZLF4GQBltig15NW0FmGWBqCbGjdENI
	 Reo4CM/gXo2IjeSK7eKfmoejBsK/ZbYzwMukV3ep+ZmzuPlT40JlVpTEYMH4oK5rJi
	 c40N5C8dYciein4WhHOeCL1mGUca8vqcYbATNKQZUMnXWg6V4sIUghrSv+qmevbWMT
	 3BHmXrDcFP0znf2divaszyZz5RxmDzGUx9iDe3r5NelyJeY7x73mhXKK/VK5WTEZ9x
	 vWN4j4J6Sh37p7EfeJt3jdZsbbF0FsVyhjU361YWdSsfVe7HxokNWk7ydhBaNanDVy
	 56EGaT/AbKFHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: cancel reset_hi_res_work on probe
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitriy Geels" <dmitriy.geels@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260824173718.14687-1-dmitriy.geels@gmail.com>
References: <20260824173718.14687-1-dmitriy.geels@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 17:55:55 +0000
Message-Id: <20260824175556.2DE3B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free in force feedback destruction callback and work han=
dler
- [High] Sleeping in atomic context due to GFP_KERNEL allocation in force f=
eedback path
--

--- Patch [1]: [PATCH] HID: logitech-hidpp: cancel reset_hi_res_work on pro=
be failure ---
commit deab4716533d9354cbeb6d6d049fa4f6aafc98ce
Author: Dmitriy Geels <dmitriy.geels@gmail.com>

HID: logitech-hidpp: cancel reset_hi_res_work on probe failure

The probe error path cancels hidpp->work before freeing the HID++ device
data, but does not cancel reset_hi_res_work. Cancel reset_hi_res_work in
the probe error path to prevent a potential use-after-free.

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 1504de32b1c84..6a21b281a1df5 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c

[ ... ]

> @@ -4834,6 +4834,7 @@ static int hidpp_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
>  hid_hw_start_fail:
>  	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
>  	cancel_work_sync(&hidpp->work);
> +	cancel_work_sync(&hidpp->reset_hi_res_work);
>  	mutex_destroy(&hidpp->send_mutex);
>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but I noticed a potential Use-After-Free in t=
he
force feedback teardown path.

If userspace holds an open file descriptor to the evdev node during unbind,
the input_dev object is kept alive after devres frees the hidpp private dat=
a.

When userspace eventually closes the file descriptor, input_free_device()
executes hidpp_ff_destroy():

drivers/hid/hid-logitech-hidpp.c:hidpp_ff_destroy() {
    ...
    struct hid_device *hid =3D data->hidpp->hid_dev;
    hid_info(hid, "Unloading HID++ force feedback.\n");
    device_remove_file(&hid->dev, &dev_attr_range);
    ...
}

Because data->hidpp has already been freed by devres, hidpp_ff_destroy()
dereferences a dangling pointer.

A similar UAF can occur in hidpp_ff_work_handler() if any force feedback wo=
rk
runs asynchronously after unbind:

drivers/hid/hid-logitech-hidpp.c:hidpp_ff_work_handler() {
    ...
    ret =3D hidpp_send_fap_command_sync(data->hidpp, ...);
    ...
}

Could a local user trigger this by holding the device node open while the
device is unplugged? Does the driver need to explicitly manage the lifecycle
of the hidpp private data to prevent this?


[Severity: High]
This is a pre-existing issue, but I also noticed a potential sleep-in-atomic
bug in the force feedback implementation.

The input subsystem routes force feedback events through input_ff_event(),
which is called with the dev->event_lock spinlock held and local interrupts
disabled. This invokes the driver's FF callbacks:

drivers/hid/hid-logitech-hidpp.c:hidpp_ff_playback() {
    ...
    return hidpp_ff_queue_work(data, effect_id, HIDPP_FF_SET_EFFECT_STATE, =
params, ARRAY_SIZE(params));
}

Inside hidpp_ff_queue_work(), there is a GFP_KERNEL allocation:

drivers/hid/hid-logitech-hidpp.c:hidpp_ff_queue_work() {
    ...
    struct hidpp_ff_work_data *wd =3D kzalloc_obj(*wd);
    ...
}

Since kzalloc_obj expands to kzalloc with GFP_KERNEL, this performs a sleep=
ing
allocation while holding a spinlock.=20

Could a local user trigger a deadlock by sending EV_FF events to the evdev
node? Should this allocation use GFP_ATOMIC instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824173718.1468=
7-1-dmitriy.geels@gmail.com?part=3D1
