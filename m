Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532A8451060;
	Tue, 21 Jul 2026 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628440; cv=none; b=s0yg5VYs35QlE+EJCGXFsdOvQ2TDMX9Pt2w9cqV0MBQoATys9t/HZEHcuRXaHmache1fYkkUafkakMjosGOUfoj849QkMx6AbRPk8IJ1/vUYrxJMtQj4L8jhBZ/zu1JKnKrwlqpLLSu5Bg9X58thvoGu6hI7p56hse1LlTKlxGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628440; c=relaxed/simple;
	bh=6YRp0CDMWaTeZesymBf7z4LvnP1XQJp17j5hZihlKl8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sMCgNK7NV7aIJY8CdMV/hd1JIWQRX/XR6/mGwKoFHhFI+1qr+wKIjeJ2DvzElNrfW0ifs5Aa4kc5C5x54/ztMRxhc6l3lVmE2WCJTTe/EGNIYqFK7gZGggytp119CNmGQr6SSEEI50z1BXuTCYY/F4WCTh7vQk1r0q72qY3RNJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3KaGA46; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3KaGA46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1E11F00A3A;
	Tue, 21 Jul 2026 10:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784628439;
	bh=dTSZT1EEiL/KxPUmDn0M78Ut6VQdty6KMvO8ANiK+TE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T3KaGA46WyjReLYtnK8yk7Hs/rozD6kgcP71TjGmD6bqy9ffJz7NGJBzJRXYCGjug
	 rBoENUUpg8LC4cCJnRjg+zRMcvNUg4ohtnjGITq11C66Y+BGQuuVLohg+nVAETm3e2
	 RcLaU3UeEJr5SDgy7goAPSLk/DjT8qNOyVxfqCkxPYDwonwDppvxtCR2mJk2vu7ZxJ
	 lsC+GNh4BE6HUA1jbCDqshKqb4KSfrLLgSv35KNXW5RaS6A7AmTv/X3ghSddusfpJ8
	 HebCnTImPDNethgLDQ0hKHUpaGM82u07GcoKkGtWnKe6nCdg4bwdeHmyqAwWkLIQxL
	 QMcDKf/Ptf0wA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/7] input: serio: Add driver for ASUS Transformer
 dock keyboard and touchpad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org, lee@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org
In-Reply-To: <20260721095233.420823-4-clamor95@gmail.com>
References: <20260721095233.420823-1-clamor95@gmail.com>
 <20260721095233.420823-4-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 10:07:18 +0000
Message-Id: <20260721100718.DE1E11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect registration order of the notifier and serio ports leads=
 to NULL pointer dereferences during probe and use-after-free bugs during d=
river removal.
--

--- Patch [3]: [PATCH v10 3/7] input: serio: Add driver for ASUS Transforme=
r dock keyboard and touchpad ---
commit 4e9b70c95d0f43e6f5bf78aeff2f78f72b9b2f82
Author: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

input: serio: Add driver for ASUS Transformer dock keyboard and touchpad
   =20
Add input driver for ASUS Transformer dock keyboard and touchpad.

> diff --git a/drivers/input/serio/asus-transformer-ec-kbc.c b/drivers/inpu=
t/serio/asus-transformer-ec-kbc.c
> new file mode 100644
> index 0000000000000..c6d12c44449d0
> --- /dev/null
> +++ b/drivers/input/serio/asus-transformer-ec-kbc.c

[ ... ]

> +static int asus_ec_kbc_notify(struct notifier_block *nb,
> +			      unsigned long action, void *data_)
> +{

[ ... ]

> +	while (n--)
> +		serio_interrupt(priv->sdev[port_idx], *data++, 0);
> +
> +	return NOTIFY_OK;
> +}

[ ... ]

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
> +	if (error)
> +		return error;
> +
> +	error =3D asus_ec_register_serio(pdev, 0, "Keyboard", 0);
> +	if (error)
> +		return error;
> +
> +	error =3D asus_ec_register_serio(pdev, 1, "Touchpad", I8042_CMD_AUX_SEN=
D);

[Severity: High]
Does this registration order leave the driver vulnerable to race conditions?

Since the parent MFD device might have already enabled its IRQ, an interrupt
can fire immediately after blocking_notifier_chain_register() completes. If
this occurs before the serio ports are registered, asus_ec_kbc_notify() will
read priv->sdev[port_idx] which is still NULL, and pass it to
serio_interrupt(), leading to a NULL pointer dereference.

Additionally, because devm actions execute in LIFO order during driver
removal or probe failure, the serio ports will be unregistered and freed
before the notifier is unregistered. If an interrupt fires during this
teardown window, could it pass a freed serio pointer to serio_interrupt()
and cause a use-after-free?

Should the notifier be registered only after the serio ports are fully
allocated and registered to prevent these crashes?

> +	if (error)
> +		return error;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721095233.4208=
23-1-clamor95@gmail.com?part=3D3
