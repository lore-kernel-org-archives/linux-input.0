Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8178C4C225E;
	Mon, 19 Oct 2026 10:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405325; cv=none; b=AaSdPOLM5bEhd4sZ3xUYmYtEqCoRiXBlt3vZRUxcZNmSs2NVCHsU0hpQY7dcmy4jMgbNvPeIwoiJTdMXoVYmN3HHPS4ecxXoQ1RFFT/M5zq+vdKg4Zx0v7WrYucAeImd+aWauOqZe5ZCia0WS3lndCXdap766izH4tlSaYM+3R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405325; c=relaxed/simple;
	bh=d8Bj4vzObU/jRIwHnyVsu4EjR9LZ3fZZc+NYrJEJoEY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=J0NkuRzRV1d+52AK/I1ppYMbi71MzOVQkLw3jPXRoUmMmQ4GygVrisCn66smnQn4sr5RTyfJ8FZwSOSDlizTBhKzEKLFmD4svYmVV0xeiacq4/+r1fGLuqQuc2Qmzah156WnOR8On4NDJ0aCI+08GsJ38zekCI0SaXDj2arNz24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUGiEgar; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUGiEgar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BAB1F000C4;
	Mon, 19 Oct 2026 10:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792405324;
	bh=p8cCog9OtPuO8i1Zg+6ar7IAkRn0H6P47rVBxkYuGQY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SUGiEgar4hfSFzwPhNYHQnhzusIIJaNO1bQEeR26pu08jH2NsDqOxhLS+VtDy+uXA
	 9MPoZNXzvkcQaNfurstnTym9nH84L1StkJ2B0acU9iWEnpaALTCUGJWZkRSthdgVCt
	 CAqFw8iZCXtqg3HxxzcTfkEoqWDBHxpVKpSTu5De15nNgtPz5BlXrqHMfTEm/0imM3
	 GhVsKRR+3DEgBnU4MDIubIkMZ9T1ZovQl7RyIvKC0rcL8zxje67KuPEVvFAuOACwqF
	 ET+mDpfvho/9MeeskFJbi1lmDZM1oU2F/ZnVFl5wgzAFdDFHYG66HOrksdp5MvdZzu
	 GHbFPcC3iowpg==
Message-ID: <sashiko-outbox-176977@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 3/7] input: serio: Add driver for ASUS Transformer
 dock keyboard and touchpad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, mfd@lists.linux.dev, linux-leds@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org
In-Reply-To: <20261019100406.103687-4-clamor95@gmail.com>
References: <20261019100406.103687-1-clamor95@gmail.com>
 <20261019100406.103687-4-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 10:22:03 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] input: serio: serio ports registered before notifier in asus_ec_=
kbc_probe()
--

commit 03f99aa77c8833478d88304ecd5af6dc8d7131c2
Author: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

input: serio: Add driver for ASUS Transformer dock keyboard and touchpad

This commit adds a serio driver for the ASUS Transformer dock keyboard and
touchpad controller, forwarding EC notifications to serio ports and
remapping several non-standard keycodes.

> diff --git a/drivers/input/serio/asus-transformer-ec-kbc.c b/drivers/inpu=
t/serio/asus-transformer-ec-kbc.c
> new file mode 100644
> index 0000000000000..fa7f7c3f037db
> --- /dev/null
> +++ b/drivers/input/serio/asus-transformer-ec-kbc.c
> @@ -0,0 +1,264 @@

[ ... ]

> +static int asus_ec_register_serio(struct platform_device *pdev, int idx,
> +				  const char *name, int cmd)
> +{
> +	struct asus_ec_kbc_data *priv =3D platform_get_drvdata(pdev);
> +	struct i2c_client *parent =3D priv->parent;
> +	struct serio *port =3D kzalloc_obj(*port);
> +
> +	if (!port)
> +		return -ENOMEM;
> +
> +	priv->sdev[idx] =3D port;
> +	port->dev.parent =3D &pdev->dev;
> +	port->id.type =3D SERIO_8042;
> +	port->id.extra =3D cmd & 0xFF;
> +	port->write =3D asus_ec_serio_write;
> +	port->port_data =3D (void *)priv;
> +	snprintf(port->name, sizeof(port->name), "%s %s",
> +		 priv->ec->model, name);
> +	snprintf(port->phys, sizeof(port->phys), "i2c-%u-%04x/serio%d",
> +		 i2c_adapter_id(parent->adapter), parent->addr, idx);
> +
> +	serio_register_port(port);
> +
> +	return devm_add_action_or_reset(&pdev->dev, asus_ec_serio_remove, port);
> +}
> +
> +static void asus_ec_notifier_chain_unregister(void *data)
> +{
> +	struct asus_ec_kbc_data *priv =3D data;
> +	struct asusec_core *ec =3D priv->ec;
> +
> +	blocking_notifier_chain_unregister(&ec->notify_list, &priv->nb);
> +}
> +
> +static int asus_ec_kbc_probe(struct platform_device *pdev)
> +{
> +	struct asusec_core *ec =3D dev_get_drvdata(pdev->dev.parent);
> +	struct asus_ec_kbc_data *priv;
> +	int error;
> +
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	priv->ec =3D ec;
> +	priv->parent =3D to_i2c_client(pdev->dev.parent);
> +
> +	error =3D asus_ec_register_serio(pdev, 0, "Keyboard", 0);
> +	if (error)
> +		return error;
> +
> +	error =3D asus_ec_register_serio(pdev, 1, "Touchpad", I8042_CMD_AUX_SEN=
D);
> +	if (error)
> +		return error;
> +
> +	priv->nb.notifier_call =3D asus_ec_kbc_notify;
> +
> +	error =3D blocking_notifier_chain_register(&ec->notify_list, &priv->nb);
> +	if (error)
> +		return dev_err_probe(&pdev->dev, error,
> +				     "failed to register blocking notifier chain");
> +
> +	error =3D devm_add_action_or_reset(&pdev->dev,
> +					 asus_ec_notifier_chain_unregister,
> +					 priv);

[Severity: Medium]
Can registering the serio ports before registering the notifier in
asus_ec_kbc_probe() cause a race with serio driver probing?

Inside asus_ec_register_serio(), serio_register_port() immediately queues
SERIO_REGISTER_PORT onto system_long_wq (serio_event_work). If
serio_event_work runs on another CPU before
blocking_notifier_chain_register() completes, serio_add_port() will bind
atkbd or psmouse, which immediately send PS/2 reset and identification
commands via asus_ec_serio_write() and wait for responses via
serio_interrupt().

Since the parent MFD driver has already enabled its IRQ handler
asus_ec_interrupt(), the EC response will be read from ASUSEC_READ_BUF and
passed to blocking_notifier_call_chain(&ddata->ec.notify_list, ...) before
priv->nb is on the list, dropping the response bytes and causing
ps2_command() timeouts.

Similarly, on driver unbind, devm will run
asus_ec_notifier_chain_unregister() before asus_ec_serio_remove() calls
serio_unregister_port(), disconnecting the receive path while the serio
ports and their drivers are still active.

Should the notifier be registered (or gated via serio open/close or
start/stop callbacks with priv->sdev[] initialized beforehand) so that the
receive path is active whenever the serio ports are registered?

> +	if (error)
> +		return error;
> +
> +	return 0;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019100406.1036=
87-1-clamor95@gmail.com?part=3D3
