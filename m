Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793795958;
	b=Rb5ZwVYD9264MFMPl6ITzTgVnnvMOXpQFyr41N0e/vd4z7+wnBvsV+/dRg/01PT9bYtC
	 cKvA8dWbQLj5l6yX01VBJmpkboKcxaZnQApQuMzvoxPE5TZXlOiug0Vj5LDOZpBPLYXCU
	 +vezW+frA5kAozv3NCMViuMh59yMgHKVi1nD8ctFMBl4rqk4nKtoYJKfd3PRptwg2c7mW
	 R6ulWlG9XJMJbr3LrDTvp91b2zRw5zJDaWAIIegQzEDV9RTqsxHMJzouv0ADH6nqrBQ8M
	 L9WVvzRuESGm8myTHwF13GVpoO7FPhUNKkY1asIbiyIYXr/jpXOuASVNb0PpS0TeabA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795958;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fVaNbaMznxlD1PnSfe0wBRtF8HswDfXhTha2jq+S4xY=;
	b=mBJe8Z7I0IkF+iHzGemDBS9CsnVFGCOhX39CzkL+u+iz5ZQBdivtgT3VtHIzQ7uxOLNs
	 2O3kFKgy/A0fyU0VtNl8bSGtLdMFzN5zY/9ZiMtLIej2uGv7eryhGw447XEr9vNLvME2v
	 kp9y1RMlHqUX5a9E7AR3WcReq0jAM62utzYUl248UjFcideQVWEA1D9nV/AnESFCGytLY
	 nrHSCBACGCw6OHbQI8K6fmpv6OTjEajEMlnFeiRfsasiYwmjZoMcHTbV3HRz8bzg8vB+g
	 HJF45P8Sln4L0vyUl9soJQg1shxYBdv4D4fO5rjISEAW3RWN+mC+0Q343eH6/j5saqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c8hS5Cji;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90360606A31B;
	Wed,  4 Nov 2026 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c8hS5Cji
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12761F000C1;
	Wed,  4 Nov 2026 12:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793795957;
	bh=fVaNbaMznxlD1PnSfe0wBRtF8HswDfXhTha2jq+S4xY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c8hS5CjiifhgfL8lqyTyqmggfJCpUKNcBgMOj1u/cY+UTDSVLRPeTIjBvNEPuFGfk
	 Yc3nnDqlZ9tPOCbASUSIQdJcam7vfrbqLN2xjj2jzbD2HGD18ke04ENVLufjX2poC1
	 5D2o0sWxf3WwC2jdXpAw/SqNZdMOH5d3g51uwqlkXlqczZAIOUxk5TQKq1yqI4jLeH
	 Nc0iBKcxCzdfa0mANCDTTAEkkkCSMbWTcV4WoyK/ebQvhpogPaNRmVknLkbrgFokI3
	 l/h6x+qM+QjLjrDinem5o1F7/jsw+5DBQYYGrGu9VOSs9Jh+YadEys2LMvuV9lz7wG
	 7YcZn0DDp7rHQ==
Message-ID: <sashiko-outbox-197277@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 3/7] input: serio: Add driver for ASUS Transformer
 dock keyboard and touchpad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, mfd@lists.linux.dev, linux-leds@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org
In-Reply-To: <20261104122606.215629-4-clamor95@gmail.com>
References: <20261104122606.215629-1-clamor95@gmail.com>
 <20261104122606.215629-4-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 12:39:16 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] input: serio: notifier order in asus_ec_kbc_probe() causes NULL de=
ref or UAF
--

commit 8f5c105d6df4708eb2c002e7fe58ff80a2a0fb84
Author: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

input: serio: Add driver for ASUS Transformer dock keyboard and touchpad

This commit adds a serio driver for the keyboard and touchpad on the ASUS
Transformer dock, registering two serio ports and a notifier on the parent
EC to forward and remap incoming PS/2 data.

> diff --git a/drivers/input/serio/asus-transformer-ec-kbc.c b/drivers/inpu=
t/serio/asus-transformer-ec-kbc.c
> new file mode 100644
> index 0000000000000..cff18da6d59d7
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

> +static int asus_ec_register_serio(struct platform_device *pdev, int idx,=
 const char *name, int cmd)
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
> +	snprintf(port->name, sizeof(port->name), "%s %s", priv->ec->model, name=
);
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
> +	struct device *dev =3D &pdev->dev;
> +	struct asusec_core *ec =3D dev_get_drvdata(dev->parent);
> +	struct asus_ec_kbc_data *priv;
> +	int error;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	priv->ec =3D ec;
> +	priv->parent =3D to_i2c_client(dev->parent);
> +
> +	priv->nb.notifier_call =3D asus_ec_kbc_notify;
> +	error =3D blocking_notifier_chain_register(&ec->notify_list, &priv->nb);
> +	if (error)
> +		return dev_err_probe(dev, error, "Failed to register blocking notifier=
 chain");
> +
> +	error =3D devm_add_action_or_reset(dev, asus_ec_notifier_chain_unregist=
er, priv);
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

[Severity: High]
As reported by Dmitry Torokhov on v12 [1], registering the notifier before
initializing the serio ports and without checking whether the ports are rea=
dy
can lead to a null pointer dereference during probe or a use-after-free
during teardown.

In the parent MFD driver, asus_ec_probe() enables the threaded IRQ handler
asus_ec_interrupt() before adding the child MFD devices. Once
asus_ec_kbc_probe() calls blocking_notifier_chain_register(), an incoming EC
keyboard or touchpad interrupt can invoke asus_ec_kbc_notify() while
priv->sdev[0] and priv->sdev[1] are still NULL (or after priv->sdev[idx] =3D
port in asus_ec_register_serio(), before serio_register_port() initializes
port->lock). Passing priv->sdev[port_idx] to serio_interrupt() will then
dereference NULL or lock an uninitialized spinlock.

Additionally, because devm_add_action_or_reset() for
asus_ec_notifier_chain_unregister() is registered before the
asus_ec_serio_remove() actions in asus_ec_register_serio(), devm teardown r=
uns
in reverse order:

  asus_ec_serio_remove()
    serio_unregister_port()
      serio_disconnect_port()
      serio_destroy_port() -> frees struct serio
  ...
  asus_ec_notifier_chain_unregister()

During serio_disconnect_port(), the attached PS/2 driver sends disable/reset
commands over I2C, causing the EC to generate ACK interrupts while priv->nb
is still registered and priv->sdev[] holds dangling pointers to the freed
serio ports. Can the notifier be registered after the serio ports (or gated
on port readiness under a lock via serio start/stop or open/close callbacks)
so that interrupts cannot reach serio_interrupt() before registration or
after unregistration?

[1] https://lore.kernel.org/r/ate5K6ZdrSoBUI08@google.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104122606.2156=
29-1-clamor95@gmail.com?part=3D3
