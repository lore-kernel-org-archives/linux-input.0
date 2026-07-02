Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD469346A0A
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 03:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782964563; cv=none; b=aKswWjOBgPC+cVW8KFFYIatIjV57nn6ZimQaC3+F6yT8i/GWlrcsnRBlU3IEeQzm6K+FJ1bZifFjrmMGtrJIYbCoWimasTKfSbuKV28nJUSB4ir7oDSA8HXv1RLUlQX5sQP8RLlt0EHg6dqas2jBcTAYZ1PO9tEbbzXylZjFWnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782964563; c=relaxed/simple;
	bh=JzWq3N6J6DZB6zF2m2s7N8RLQD7+xMvO9MgZwOVVbzI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C8LAmnlKUZ+OlgdqgZPxm2vP/9DibiR5CLmcwHblu7r5FkDtp+mPVqjVoxlHAgzOWfs/xlplUlGKm87Iw/h5zX3pDEdhLWdYjsVIrNeseHxx7rPap7ikxZ5NbvSKBzCxsg5eMKzpBcGgrh4qou+h2n2tY+z/jmfZBRZTG0IBYdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYNDRJJf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYNDRJJf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAC41F000E9;
	Thu,  2 Jul 2026 03:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782964561;
	bh=bhPI6esZ9+PZUzwMFcRnXN7JQdsQzOfAMWp6Ozz7q4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fYNDRJJfq2sCMQ2XBh2/kWlKm5821Y/U23z2s6icRLMrd+0AhzI3vuGw+1YTPGq5+
	 vnVOB4WHlbb7IGMenATrWcsDt6gqniJVvDDL1R810o5Jqu+CS8IprJ4rEaRsz1vPV5
	 wSIBTsIdO1I5kAAB4EJE6gU0LzYDxDnv3qvns/cWoV6FXSIcvbGDyTimPD9OlgeOSB
	 YonWbxNaM1G71x5L/2csY9R5OiqJOLokK9OccnMNdD4rguwLChgI6VHMQ0PQI2IUZn
	 jCNsU1HemGUH9qjajnf5J5w4k9QjG0LLrb26gmNDb9nUfESuaKcte7Yw+SYnli6XoR
	 q5uxqgrl7XitA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/3] HID: nintendo: Add preliminary Switch 2
 controller driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260702034106.1498056-2-vi@endrift.com>
References: <20260702034106.1498056-1-vi@endrift.com>
 <20260702034106.1498056-2-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 03:56:00 +0000
Message-Id: <20260702035601.5AAC41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Calling `input_free_device()` on a successfully registered `input_=
dev` when subsequent allocations fail.
- [High] Use-After-Free of `ns2->leds` due to devm lifetime mismatch when r=
eusing the global controller structure.
- [High] Race condition causing NULL pointer dereference of `ns2->cfg` duri=
ng USB initialization error.
- [High] Unconditional `ida_free()` with `U32_MAX` causes a kernel BUG_ON.
--

commit be3a7ca67ec1bc0f796b8ba1203737257398ef18
Author: Vicki Pfau <vi@endrift.com>

HID: nintendo: Add preliminary Switch 2 controller driver

This commit adds a new driver for the Switch 2 controllers. It utilizes a
split-interface design where input and rumble occur on the main HID
interface, while all other communication uses a configuration interface.
The current implementation supports general input for Joy-Con 2, Pro
Controller 2, and GameCube NSO controllers over USB.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -2838,7 +2845,1206 @@ static int nintendo_hid_suspend(struct hid_devic=
e *hdev, pm_message_t message)
> [ ... ]
> +static int switch2_init_input(struct switch2_controller *ns2)
> +{
> [ ... ]
> +	ret =3D input_register_device(input);
> +	if (ret < 0) {
> +		hid_err(ns2->hdev, "Failed to register input; ret=3D%d\n", ret);
> +		input_free_device(input);
> +		return ret;
> +	}
> +
> +	player_led_pattern =3D ns2->player_id % JC_NUM_LED_PATTERNS;
> +	hid_dbg(hdev, "assigned player %d led pattern", player_led_pattern + 1);
> +
> +	ns2->leds =3D devm_kcalloc(&input->dev, JC_NUM_LEDS, sizeof(*ns2->leds)=
, GFP_KERNEL);

[Severity: High]
Since the ns2 structure is reused per physical port via
switch2_get_controller(), could there be a lifetime mismatch here?

If a device is unplugged but its evdev file descriptor is kept open by
userspace, input->dev stays alive. If a new device is then plugged into the
same port, ns2 is reused and ns2->leds is overwritten with an allocation
tied to the new input_dev.

When the new device is unplugged, freeing its devm resources, would a write
to the original device's LED sysfs node in
switch2_player_led_brightness_set() iterate over freed memory?

> +	if (!ns2->leds) {
> +		hid_err(ns2->hdev, "Failed to allocate LEDs\n");
> +		input_free_device(input);

[Severity: High]
Is it safe to use input_free_device() here since input_register_device()
has already successfully registered the device above?

Once the input device is registered, won't calling input_free_device() just
drop the initial reference rather than properly unregistering the device,
leaving dangling sysfs nodes and leaking the device?

> +		return -ENOMEM;
> +	}
> [ ... ]
> +int switch2_receive_command(struct switch2_controller *ns2,
> +	const uint8_t *message, size_t length)
> +{
> +	const struct switch2_cmd_header *header;
> +	int ret =3D 0;
> [ ... ]
> +	header =3D (const struct switch2_cmd_header *)message;
> +	if (!(header->flags & NS2_FLAG_OK)) {
> +		dev_warn(ns2->cfg->dev, "Packet error %02x replying to command %x:%x",

[Severity: High]
Could this lead to a NULL pointer dereference in the error logging path?

In switch2_usb_probe(), we submit the bulk IN URB before calling
switch2_controller_attach_cfg(). If the device immediately returns an error
packet, switch2_receive_command() might run concurrently.

If attach_cfg fails and clears ns2->cfg to NULL, could the workqueue attempt
to log the error using dev_warn(ns2->cfg->dev, ...) and crash?

> +			header->flags, header->command, header->subcommand);
> +		ret =3D -EIO;
> +		goto exit;
> +	}
> [ ... ]
> +static int switch2_probe(struct hid_device *hdev, const struct hid_devic=
e_id *id)
> +{
> [ ... ]
> +	ns2->player_id =3D U32_MAX;
> +	ret =3D ida_alloc(&nintendo_player_id_allocator, GFP_KERNEL);
> +	if (ret < 0)
> +		hid_warn(hdev, "Failed to allocate player ID, skipping; ret=3D%d\n", r=
et);
> +	else
> +		ns2->player_id =3D ret;
> [ ... ]
> +err_cleanup:
> +	ida_free(&nintendo_player_id_allocator, ns2->player_id);

[Severity: High]
If ida_alloc() fails, ns2->player_id is left as U32_MAX.

If the driver probe subsequently fails and enters this cleanup path, won't
ida_free() with U32_MAX (which casts to a negative integer) trigger a BUG_ON
in the IDA core?

> +	ns2->hdev =3D NULL;
> +	mutex_unlock(&ns2->lock);
> +	switch2_controller_put(ns2);
> +	kref_put(&ns2->refcount, switch2_kref_put);
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702034106.1498=
056-1-vi@endrift.com?part=3D1
