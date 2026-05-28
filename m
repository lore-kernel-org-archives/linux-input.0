Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E70731F9AF;
	Thu, 28 May 2026 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954087; cv=none; b=LGmrb8F1ZW4svVEIyJsXly2O6l2W6K41p9nvihbixgFb5ONjwTlVC/Hik6+a7PQp5mXDXyPGKKO1qAt4Xra0tloAsY/3WR9X8cdfwyCoIXTobfaYlDHJXS743eY7nWkuNzDYhnqozGAa7DBU/lQQjn3dNEnvbv38AMokd66WGA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954087; c=relaxed/simple;
	bh=Lm/Dk6HkuTK3kUq9tZs/lY/NoHt0IDCi9e7PA5i5pkk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g/Z2Sfr27klte1YhSJ4SbQbCPuqd2lzK6rvNXtIIqUOCHNdjP3j34SSdTStgw8E2qlnDZrFpfHqYt5gNSnMK3Ktuhf567OXVveyt7VXTzDrgkmL7IzDWGuHDsYo9bxEly5h9/n0vZmNEWDrG1xdaYyGx9Tb0UCnuLgV0mozrHXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIBU3SLO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIBU3SLO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851C81F000E9;
	Thu, 28 May 2026 07:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779954085;
	bh=LXvxG4ig51mUiHDuVZrfETNoYiZ8wn0vUvc0IS2ItBQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eIBU3SLOD3pbKkwJofHmFaI5EmkDepBMiaQzUXGxkwi6GovnYTdqYRLTo4/INdoN4
	 cwUMOOUJzprldjQv8Ow4oh0/W+dWL2PokZpoUGth4q90XrmRcu7im2owHMOJtznKZs
	 hwwxNRMBk6zEqavvGS6B0fxbvET0MIQsrzdi3tbRkAKGeo44Uj3+PDdH7vUhEN7GZm
	 ieog1i3v+HO78rtdWvvbFxC6bXPKZy8MeFy9d9PfPS8icssiEqhaolAUhVvkbHC+NM
	 10JgiPGfUNQxmdsofY6EO9AxllyvVfdohSfZVi3M8sx5YxpmgUsp60034QKfzU7BXG
	 EiKHZ2uWpxYuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/7] input: keyboard: Add driver for ASUS Transformer
 dock multimedia keys
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260528053203.9339-5-clamor95@gmail.com>
References: <20260528053203.9339-5-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 07:41:24 +0000
Message-Id: <20260528074125.851C81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The driver registers a global input handler to snoop keystrokes fr=
om all input devices in the system, violating driver boundaries.
- [High] The input_dev's name, phys, and keycode fields point to devres-man=
aged memory that is freed when the driver unbinds, causing a Use-After-Free=
 if userspace holds the input device open.
- [Medium] The state flags `special_key_pressed` and `special_key_mode` are=
 accessed and modified concurrently from multiple contexts without any lock=
ing or synchronization.
- [Low] The driver unregisters the input handler before unregistering the h=
ardware event notifier in the remove function, violating the reverse-order =
teardown principle.
--

commit ed5ee673506765c49f751d4f9cce6ec50eda686c
Author: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
Subject: input: keyboard: Add driver for ASUS Transformer dock multimedia k=
eys

This commit adds support for the multimedia top button row of the
ASUS Transformer's Mobile Dock keyboard. It switches to multimedia keys
when ScreenLock + AltGr are pressed.

> diff --git a/drivers/input/keyboard/asus-transformer-ec-keys.c b/drivers/=
input/keyboard/asus-transformer-ec-keys.c
> new file mode 100644
> index 0000000000000..bf6db002a8537
> --- /dev/null
> +++ b/drivers/input/keyboard/asus-transformer-ec-keys.c
> @@ -0,0 +1,286 @@
[ ... ]
> +static void asus_ec_input_event(struct input_handle *handle,
> +				unsigned int event_type,
> +				unsigned int event_code, int value)
> +{
> +	struct asus_ec_keys_data *priv =3D handle->handler->private;
> +
> +	/* Store special key state */
> +	if (event_type =3D=3D EV_KEY && event_code =3D=3D KEY_RIGHTALT)
> +		priv->special_key_pressed =3D !!value;

[Severity: Medium]
Can this result in a data race on special_key_pressed?

The asus_ec_input_event() function writes to special_key_pressed from the
input event delivery context, which often runs in hardirq or softirq.

Concurrently, asus_ec_keys_process_key() reads this flag and modifies
special_key_mode from a process context via the blocking notifier chain.

Could concurrent execution lead to missed key modifiers or lost mode updates
without synchronization primitives or READ_ONCE() annotations?

> +}
[ ... ]
> +static const struct input_device_id asus_ec_input_ids[] =3D {
> +	{
> +		.flags =3D INPUT_DEVICE_ID_MATCH_EVBIT,
> +		.evbit =3D { BIT_MASK(EV_KEY) },
> +	},
> +	{ }
> +};

[Severity: High]
Does this input_device_id match any device with EV_KEY capabilities, causing
the driver to intercept key events globally?

If a user unplugs an unrelated external USB keyboard while the RIGHTALT key
is currently held down, could the special_key_pressed state remain
permanently stuck?

[ ... ]
> +static int asus_ec_keys_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
[ ... ]
> +	priv->xidev =3D devm_input_allocate_device(dev);
> +	if (!priv->xidev)
> +		return -ENOMEM;
> +
> +	priv->xidev->name =3D devm_kasprintf(dev, GFP_KERNEL, "%s Keyboard Ext",
> +					   ec->model);
> +	priv->xidev->phys =3D devm_kasprintf(dev, GFP_KERNEL, "i2c-%u-%04x",
> +					   i2c_adapter_id(parent->adapter),
> +					   parent->addr);

[Severity: High]
Does this code introduce a use-after-free regression if userspace holds the
input device open during an unbind?

The priv->xidev->name and priv->xidev->phys strings, as well as the
priv->keymap array assigned to dev->keycode, are managed by devres and will
be freed when the driver unbinds.

However, if a userspace process holds a file descriptor to the evdev node,
the input_dev object is kept alive via reference counting.

Could a subsequent ioctl from userspace, such as EVIOCGNAME, attempt to
read from these already-freed pointers?

[ ... ]
> +static void asus_ec_keys_remove(struct platform_device *pdev)
> +{
> +	struct asus_ec_keys_data *priv =3D platform_get_drvdata(pdev);
> +	struct asusec_core *ec =3D priv->ec;
> +
> +	input_unregister_handler(&priv->input_handler);
> +	blocking_notifier_chain_unregister(&ec->notify_list, &priv->nb);

[Severity: Low]
Does this remove sequence violate the reverse-order teardown principle?

In asus_ec_keys_probe(), the driver registers the input handler first,
followed by the EC notifier chain.

Unregistering the handler first opens a race window where the software
tracking is disconnected but the driver is still registered to receive
hardware events from the EC.

Can the driver still process events in a partially dismantled state?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528053203.9339=
-1-clamor95@gmail.com?part=3D4
