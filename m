Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAB7263C8C;
	Thu, 25 Jun 2026 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376048; cv=none; b=a3icwhYLWS7X/MOVXj0aCaq80ljl0wQOwkYQWKNM+TZO8+2MkScPrBmUStKC7mWfR09ugYkTjwZUsKdzmqgO6tlAsv5lCzBzeXMuSl8LRDh3jtdgcYoqyag1X/EAJingVaVd3EWVn2Zcwss/y5VflMDN4YZ4jvv4WCHkPUujmpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376048; c=relaxed/simple;
	bh=p4SrQ0ICcDbUOf6AZCyJNO6mPvn1nYVxhb1a4UdTBlM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NlxR5jUi4OZg7ZLLfy6iZQ7QZ2oa/4IdHOp26VTA1cyPOgK99HWGWAK1LFWclG3JW8NsfwAY+w9xYGudr4vrgs6uzQNnZefEn6nDeuhl/1vO9IvKsLl9+ruhG6QL24dsQ0zQuGTGH+xh/bdSTQXdFSg+7VAUQpwlV/GeayeugVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jT1onq94; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jT1onq94"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842D71F000E9;
	Thu, 25 Jun 2026 08:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782376047;
	bh=wuPXO3zQaJFo4PO16PNzjg8LiMSK1jYOps4QfG6sS/8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jT1onq94wNrxYK+1LgK8dat8oFEl8Ebufu6ZkoHeB25z7ySlkUP47XUAbzVRcWkKy
	 qjeYaMkn4teCc2WZa4WrV5QslaJnAF/yZtHwf3kNpHaST7FcIC0yii/bwwUdr43jZI
	 JLkHzzuGvPQlfDFQTw3VMKnaTPuQerNwhTNngqm0KCezZBc0OubzZDHYY0Qg0c4QWV
	 KBigjDmeLsPq/zwEcI6VEktcPMTTpZQKxZEbE27uza7HA0D40/cSg7aVE3Q7yNOKZs
	 tAj5G8Ext9wlx44jxhav4CeVZlZz+eIVNgGYssxLt2b55SQRyE7x60AZjgFNjuWE+0
	 7CnVc634fu6uA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/7] input: serio: Add driver for ASUS Transformer
 dock keyboard and touchpad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dmitry.torokhov@gmail.com, conor+dt@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-leds@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260625081529.22447-4-clamor95@gmail.com>
References: <20260625081529.22447-1-clamor95@gmail.com>
 <20260625081529.22447-4-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 08:27:26 +0000
Message-Id: <20260625082726.842D71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Premature registration of the event notifier before callback initi=
alization causes a race condition leading to a NULL pointer dereference.
- [High] Incorrect devres ordering leaves the notifier active after serio p=
orts are destroyed, causing a Use-After-Free during teardown.
- [High] Incorrect bounds check on the EC packet length allows an out-of-bo=
unds heap read and exposes uninitialized memory.
--

commit 27a9e7909b45cc654374940aa7f4c4574172729b
Author: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

input: serio: Add driver for ASUS Transformer dock keyboard and touchpad

Add input driver for ASUS Transformer dock keyboard and touchpad. Modify
incoming keyboard data to send proper scancodes for keys that don't match
their position.

> diff --git a/drivers/input/serio/asus-transformer-ec-kbc.c b/drivers/inpu=
t/serio/asus-transformer-ec-kbc.c
> new file mode 100644
> index 0000000000000..3ddfa9925b2b0
> --- /dev/null
> +++ b/drivers/input/serio/asus-transformer-ec-kbc.c

[ ... ]

> +static int asus_ec_kbc_notify(struct notifier_block *nb,
> +			      unsigned long action, void *data_)
> +{

[ ... ]

> +	/*
> +	 * The data[0] is the length of the packet including itself. The data[]
> +	 * buffer has to be at least 3 bytes (length + ctrl + 1 data byte) and
> +	 * must not exceed the EC buffer size.
> +	 */
> +	if (data[0] < 2 || data[0] > ASUSEC_ENTRY_BUFSIZE)
> +		return NOTIFY_BAD;
> +
> +	n =3D data[0] - 1;
> +	data +=3D 2;

[ ... ]

> +	while (n--)
> +		serio_interrupt(priv->sdev[port_idx], *data++, 0);

[Severity: High]
If data[0] is ASUSEC_ENTRY_BUFSIZE (33), n becomes 32, and data is advanced
by 2. Will the loop read 32 bytes from data[2] up to data[33]?

Since the buffer is exactly 33 bytes long, could this read past the end of
the array or access uninitialized data?

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
> +	error =3D blocking_notifier_chain_register(&ec->notify_list, &priv->nb);

[Severity: High]
Is it safe to register the notifier here before priv->nb.notifier_call is
initialized?

If an interrupt fires immediately after registration, could the notifier co=
re
attempt to call a NULL pointer?

> +	if (error)
> +		return dev_err_probe(&pdev->dev, error,
> +				     "failed to register blocking notifier chain");
> +
> +	error =3D devm_add_action_or_reset(&pdev->dev,
> +					 asus_ec_notifier_chain_unregister,
> +					 priv);

[Severity: High]
Since managed resources (devm) are released in LIFO order, will the serio
ports registered below be unregistered and freed before this notifier is
unregistered?

If an interrupt arrives during the unbind window or if the probe function
fails after port registration, could the notifier loop in asus_ec_kbc_notif=
y()
dereference the freed serio port pointers?

> +	if (error)
> +		return error;
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
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625081529.2244=
7-1-clamor95@gmail.com?part=3D3
