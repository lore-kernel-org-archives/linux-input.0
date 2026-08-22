Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4899217723
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 02:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787366242; cv=none; b=TxCjtJjw9gPEwE9RpKZaRy/i0LS/gqIHumWDB0w2YwNWwoJVG8ujv2ZFg5tfhfPnhRTmmCT3FAgzrvE2RzhVW7NZVKPoYymac9sxHZZGhgdb0Rhj0F6W/2xZQPHCx66++aN841w1uRBF1d3lOp1DcYqHf3lAhEbbfhq4RAUkVtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787366242; c=relaxed/simple;
	bh=VA5VL/i+Bicc97UB4qohHFXtg31ynyVt0VY08C2NG0c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=umbf9KzgNYxnb6KUos7GP7t8aq5kxam2/fK+YXp0ZTn9YdxBhftBD2zhgYMDO6+v/8FFN+tbnx8HKIxdg348OFwJ9Og+2pv3uVUTvGxj51pzDDI3RwO1SLeTvRKgih3KcppZq/1zX3seaXb8VADujAAaEBnV2+8WyW68F282t0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxKHdEzd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxKHdEzd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE701F000E9;
	Sat, 22 Aug 2026 02:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787366240;
	bh=g//6LRplCA1G88/K4giPZPcaAbCQ6CazB3UN9Jh58bU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nxKHdEzdNcpaI3VkfhC/kWJQU/178h/625gla1PdaVNV1MiR6OcBYciZQefNa1GeS
	 qgwPEerLVwDr+j25YJ2gfOPVYFHiTM5dgd6hhe5Heu0HgWBXutYr7a8Rj0+uoPoIhA
	 ypl+wMyTGMiTWErhmhblB/vtJXf0vvKgiqKDlCye+/syBFnp1Cf8KUpTyQdDSUB0gP
	 hL1UgGBMDSUScosuMXgRKLAZvAqlCW9ZwKWwN93bb5Z2yt+A6f6OmR/78dRmmv8+EF
	 WnDL117mhzdBxQxIgXfqW3a7kgInR2gvhL1DdYK5v/51/oXDe45g7/icivR+fnLHhe
	 ZpsiHx9t88nUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/12] Input: xbox_gip - Add controllable LED support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260822021140.1149546-4-vi@endrift.com>
References: <20260822021140.1149546-1-vi@endrift.com>
 <20260822021140.1149546-4-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 02:37:19 +0000
Message-Id: <20260822023720.3EE701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Lifecycle mismatch causing Use-After-Free and list corruption for =
the LED class device.
- [Medium] Missing initialization of `intensity` for multicolor LED subleds=
 renders it functionally broken.
- [Medium] Data race on `mc_cdev->subled_info` during concurrent sysfs or t=
rigger updates.

Pre-existing issues:
- [High] Missing bounds check on subsequent message fragments causes out-of=
-bounds read and kernel memory leak.
- [High] Input device properties `phys` and `uniq` point to freed memory, c=
ausing a Use-After-Free and information leak.
--

--- Patch [3]: [PATCH v4 03/12] Input: xbox_gip - Add controllable LED supp=
ort ---
commit ac5f2a01657c115e9d51066385a4a06622ddd86f
Author: Vicki Pfau <vi@endrift.com>

Input: xbox_gip - Add controllable LED support

This commit adds support for monochrome white and RGBW addressable LEDs
found on Xbox One and Elite 2 controllers. It exposes these controllable
LEDs via the led class device and multicolor led class device subsystems.

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> index 12a1fb285bfc8..15f8ed2107110 100644
> --- a/drivers/input/joystick/gip/gip-core.c
> +++ b/drivers/input/joystick/gip/gip-core.c

[ ... ]

> @@ -1038,9 +1038,116 @@ static int gip_send_guide_button_led(struct gip_a=
ttachment *attachment,
> +static int gip_guide_color_led_set(struct led_classdev *led,
> +	enum led_brightness value)
> +{
> +	struct led_classdev_mc *mc_cdev =3D container_of(led,
> +		struct led_classdev_mc, led_cdev);
> +	struct gip_attachment *attachment =3D container_of(mc_cdev,
> +		struct gip_attachment, guide_led.color);
> +
> +	led_mc_calc_color_components(mc_cdev, value);
> +	guard(mutex)(&attachment->lock);

[Severity: Medium]
Can this cause a data race on the subled_info array? The function
led_mc_calc_color_components() modifies mc_cdev->subled_info before the
attachment->lock is acquired. Since the LED subsystem does not serialize
concurrent calls to brightness_set_blocking (for instance, from concurrent
sysfs writes and blink triggers), multiple threads could modify the shared
subled_info array simultaneously before acquiring the mutex.

> +	return gip_send_guide_button_color_led(attachment,
> +		mc_cdev->subled_info[0].brightness,
> +		mc_cdev->subled_info[1].brightness,
> +		mc_cdev->subled_info[2].brightness,
> +		mc_cdev->subled_info[3].brightness);
> +}
> +
> +static int gip_guide_led_probe(struct gip_attachment *attachment, struct=
 device *dev)
> +{
> +	int rc =3D 0;
> +
> +	if (!gip_supports_system_message(attachment, GIP_CMD_LED, false))
> +		return 0;
> +
> +	if (attachment->features & GIP_FEATURE_GUIDE_COLOR) {
> +		struct mc_subled *mc_led_info;
> +		struct led_classdev_mc *mc_cdev =3D &attachment->guide_led.color;
> +		struct led_classdev *cdev =3D &mc_cdev->led_cdev;
> +
> +		mc_led_info =3D devm_kcalloc(dev, 4,
> +			sizeof(*mc_led_info), GFP_KERNEL);
> +		if (!mc_led_info)
> +			return -ENOMEM;
> +
> +		mc_led_info[0].color_index =3D LED_COLOR_ID_RED;
> +		mc_led_info[1].color_index =3D LED_COLOR_ID_GREEN;
> +		mc_led_info[2].color_index =3D LED_COLOR_ID_BLUE;
> +		mc_led_info[3].color_index =3D LED_COLOR_ID_WHITE;

[Severity: Medium]
Does this leave the intensity fields set to 0? The mc_led_info array is
allocated with devm_kcalloc, which zero-initializes the memory. When the
LED core later calls led_mc_calc_color_components(), it multiplies the
requested brightness by each channel's intensity. If the intensity is 0,
the computed brightness for all channels will be 0, and the LED will not
turn on unless userspace manually writes to the multi_intensity sysfs file.

> +
> +		mc_cdev->subled_info =3D mc_led_info;
> +		mc_cdev->num_colors =3D 4;
> +
> +		cdev->brightness =3D 51;
> +		cdev->max_brightness =3D 255;
> +		cdev->flags =3D LED_CORE_SUSPENDRESUME | LED_RETAIN_AT_SHUTDOWN;
> +		cdev->brightness_set_blocking =3D gip_guide_color_led_set;
> +		cdev->name =3D devm_kasprintf(dev, GFP_KERNEL,
> +			"%s:rgb:power", dev_name(dev));
> +		if (!cdev->name)
> +			rc =3D -ENOMEM;
> +
> +		if (!rc)
> +			rc =3D devm_led_classdev_multicolor_register(dev,
> +				mc_cdev);

[Severity: High]
Can this lead to a use-after-free and list corruption on device disconnect?
The LED is registered using devres tied to the input device (dev), meaning
its unregistration is deferred until the input device is finally released.
However, the mc_cdev is embedded in the attachment structure, which is
explicitly freed during gip_disconnect():

drivers/input/joystick/gip/gip-core.c:gip_disconnect() {
    ...
    devm_kfree(to_gip_device(attachment), attachment);
    ...
}

If a user-space process holds an open file descriptor to the evdev node
during a USB disconnect, the input_dev outlives the attachment. The
led_classdev remains registered but its backing memory is freed. When the
evdev node is finally closed, the input_dev devres cleanup will invoke
led_classdev_unregister() on the freed memory.


While reviewing this patch, I noticed a pre-existing issue in
gip_receive_fragment() that might need addressing:

drivers/input/joystick/gip/gip-core.c:gip_receive_fragment() {
    ...
    } else {
        if (header->length !=3D 0)
            memcpy(&attachment->in_fragment_data[*fragment_offset],
                   &bytes[offset], header->length);
    ...
}

[Severity: High]
This is a pre-existing issue, but does this lack a bounds check for
subsequent message fragments? The first fragment properly validates that
header->length does not exceed the packet size, but this else branch omits
that validation. A malicious or malfunctioning USB device could send a
small packet with a large header->length, causing the memcpy to read out
of bounds from the 64-byte gip_raw_message buffer into the heap-allocated
in_fragment_data buffer, potentially leaking kernel memory.


I also noticed another pre-existing lifecycle issue in
gip_setup_input_device() and gip_disconnect():

drivers/input/joystick/gip/gip-core.c:gip_setup_input_device() {
    ...
    input->uniq =3D attachment->uniq;
    ...
    input->phys =3D attachment->phys;
    ...
}

drivers/input/joystick/gip/gip-core.c:gip_disconnect() {
    ...
    devm_kfree(to_gip_device(attachment), attachment->uniq);
    devm_kfree(to_gip_device(attachment), attachment);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but can this cause a
use-after-free if the input device is held open? The input device
properties phys and uniq are set to point to attachment->phys and
attachment->uniq. When the device is disconnected, these are explicitly
freed. If an evdev file descriptor is open, the input_dev outlives the
attachment. Subsequent calls to EVIOCGPHYS or EVIOCGUNIQ ioctls would
read from these freed memory pointers and copy the contents to user-space.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822021140.1149=
546-1-vi@endrift.com?part=3D3
