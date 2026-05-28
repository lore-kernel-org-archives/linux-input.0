Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B579F233923;
	Thu, 28 May 2026 07:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779951999; cv=none; b=tYkuR4PIP2fIcpBjM0V+1jPtkHS0WmxpPY4gOjLDibdjfoLXa3HRoF+wDZVk+qw4HM5x+Jo5rqJbR4YCabu9hzXffZv65OciLIru4x1ZFINwPs7cCCJpWf6kqeyY93dD32xnm68bXGWa5n4UrB83w2CtQwqiuAgk5oDXl8a8OaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779951999; c=relaxed/simple;
	bh=ImzjA+ndOSyft5xxUqo4XWOX7xBNtjoZeAlU/dOoYzg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aEDgCnCky+Xkw4SC9U9AVC69Xtkw9ej+IrCgR3yv83Pw/8RMgtl+V9tNacEavbXg5k3twbahxrkDkUkWaE5n96IQkuf7PPR5KY4CpSILDGNTgCvr5KnKm4UydIgsagm4eACd9IooW0vrA7rRT+W2sYEF0oaLEj4PM45kTNcH/8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGehPrIA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGehPrIA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD491F00A3A;
	Thu, 28 May 2026 07:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779951998;
	bh=eQLcSqgCAD4VaSYTq34s8sk7K5HMH3cQxF8L0ZA3PVU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aGehPrIACmVCl8lU7XL7BPfD4CxjVeLO/91LF1rWBnK+UU9bUN8cxT7Md9qDrHAFw
	 gwqu9L9nMFGJMbi2draC2N8LR7kz+AQYSnZxdYSWsDmKdTnjYD2UXpMpqTQ+m8wtj3
	 carU4OUBQyfAXakcbyHSnTRKy0RXvqi/WwP0tWmnPVDzXPsp7o2Zkhk7xbMGW+osbR
	 xh83SKpbEXpGttcHY/aJEKSplz9II/3z/Vty9FHyU1pMLGvVRJRdmTm+EfKMnHmZrJ
	 L6oumBUc0OjY2NyqTL06lQiXfRB5Na+4rTZBOEDcK7BXELMjV3yDenZ+EqKixB3wls
	 jWbZerzeqCjiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/7] input: serio: Add driver for ASUS Transformer
 dock keyboard and touchpad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260528053203.9339-4-clamor95@gmail.com>
References: <20260528053203.9339-4-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 07:06:37 +0000
Message-Id: <20260528070638.1AD491F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The serio->write callback calls a sleeping I2C API, violating the =
atomic context requirements of the serio subsystem.
- [High] Serio ports are registered before the EC notifier is active, which=
 can lead to dropped hardware ACKs and driver probe timeouts.
--

commit c384b4357257c7b443531cb85e3b65aa83067d31
Author: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

input: serio: Add driver for ASUS Transformer dock keyboard and touchpad

This commit adds a serio input driver for the ASUS Transformer dock keyboard
and touchpad. It handles incoming scancodes, remaps specific keys to match
the standard AT layout, and forwards the data to the serio subsystem.

Co-developed-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

[ ... ]

> diff --git a/drivers/input/serio/asus-transformer-ec-kbc.c b/drivers/inpu=
t/serio/asus-transformer-ec-kbc.c
> new file mode 100644
> index 0000000000000..6f10b7f1baae5
> --- /dev/null
> +++ b/drivers/input/serio/asus-transformer-ec-kbc.c
> @@ -0,0 +1,158 @@
[ ... ]
> +static int asus_ec_serio_write(struct serio *port, unsigned char data)
> +{
> +	struct asus_ec_kbc_data *priv =3D port->port_data;
> +
> +	return i2c_smbus_write_word_data(priv->parent, ASUSEC_WRITE_BUF,
> +					 (data << 8) | port->id.extra);
> +}

[Severity: High]
Does this code sleep in an atomic context?

The i2c_smbus_write_word_data() function takes the I2C adapter's mutex and
sleeps while waiting for the synchronous transaction to complete.=20

However, the serio core and keyboard/mouse drivers frequently call
serio_write() from atomic contexts. For example, the core serio_interrupt()
function holds the port's spinlock with interrupts disabled:

serio_interrupt() {
    guard(spinlock_irqsave)(&serio->lock);
    ...
    serio->drv->interrupt(...) // calls driver interrupt which may write
}

If a driver like atkbd needs to resend a command or respond to a hardware
NAK, it calls serio_write() directly from this interrupt handler.

Executing a sleeping I2C write while holding a spinlock with interrupts
disabled will trigger a "scheduling while atomic" bug or cause a system
deadlock.

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
> +	return blocking_notifier_chain_register(&ec->notify_list, &priv->nb);
> +}

[Severity: High]
Can this cause driver probe timeouts by dropping hardware ACKs?

The asus_ec_register_serio() calls are exposing the keyboard and touchpad
to the serio subsystem before the EC notifier is attached. The serio port
registration asynchronously queues work on the kseriod workqueue, which
finds and binds drivers.

Since the kseriod workqueue can run concurrently on another CPU, it may send
initialization commands and the hardware may respond before this probe
function reaches blocking_notifier_chain_register().

Because the notifier is not yet attached to receive and forward these ACKs,
the events will be dropped. This causes the bound driver's probe to time out
and fail, leaving the input devices non-functional.

Should the notifier be fully registered before the serio ports are exposed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528053203.9339=
-1-clamor95@gmail.com?part=3D3
