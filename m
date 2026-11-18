Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795004239;
	b=asIQfINJwz+TMsux7kfRrqFZDhoChRzciNrkDjr1kN+39Vl1a4Cho3Cdpu47maAGUlGq
	 Zv8Y/kCYSSK1eEa5iiSho4rpLbzJP4KAfD+NnSy7NVHr5sIMdBu9WxqJb6BjbFMHbZtZR
	 Gtcos/WE3/ZGIayqZJwYNj/ABYmNnyi2kRYL9uCa56AkRsZQAH3b82tjkZpXyxCdZRqM9
	 mV5HEpfOVRxJTWnhs5+/dtLWBWZ/LXlUQm7u1go1uCWd59vC0xR4a9lPhzeTCw6oCIQkm
	 SZY5EdQRxVfft94I8117mfK4SAGByrHvYMIc/9DGibbjm0GFVfse8qz19kFPRInN4ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795004239;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jN/CDcwUHHL0zj4y0UuCIlYSqF2trpSWIhsEub9o7ho=;
	b=d/tUqFMTksDyRvCnvYOTrHKa7nS2hMNng48FbmS8nw4PsEyCmTLj9qHYH6N9FxS2646r
	 xngFlt/arsqoQbSJ0v4AIvBE5CqmSbWn9z8tQ/xVd4jqbpLj7zTumKFsVfuphoJikpZxy
	 M48a6fsaOdiBArV170gXMAU5DLnm/vrhKkePtvFW2aRrK/GBdChhruqZX6GQwYhS2s1g+
	 gbyfRHorzOHjyPRehLf1wxnLm7FZvCRz61AsfUJzys2P2wrCnxKU51Bmj3a+Wq4daiISY
	 vcaS6k9zUuwPfZ9FSJIENRKaE1Q4NPRdpJoDWucBOvRugTxb+Hd371IPMTKZNkO5yIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TVoUdJ4j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5062F606A31C;
	Wed, 18 Nov 2026 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TVoUdJ4j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843B41F000C4;
	Wed, 18 Nov 2026 12:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795004238;
	bh=jN/CDcwUHHL0zj4y0UuCIlYSqF2trpSWIhsEub9o7ho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TVoUdJ4jw4o9p+zJFU10VinfiESdSeJgRiV/EVsW/mb9sIMh7NpYCjKHZBpCp8lYy
	 tm0fP6ke84AYuL/PIazyUEgTXIcpu+NpawWBtILIq0YwzbIqwzlom7+laAZJk2CQUT
	 tG0nIrgwgF9OeLv7LsbGE6rIu/C5usmP2T59M4dYiVMRqE2gNZbnCtW0ukGFofQKB5
	 TBTzl7RcSFNSks/MRSLTi1g/nGUAk5YuJ8l22A7/i3dtZY9OOgzUWQAOcjmepdtcBF
	 K25txEyG/sG/ZyYEa0SGL948C7pu/71BDKcHLxvgPC8k+aBbMt5jnyQfS2Rmk+0trV
	 RKOEDc9rMsiVg==
Message-ID: <sashiko-outbox-220897@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/10] Input: touchscreen: add Silicon Works SW42902
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abdur Rofik" <rofikcoga@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261118120714.31505-7-rofikcoga@gmail.com>
References: <20261118120714.31505-1-rofikcoga@gmail.com>
 <20261118120714.31505-7-rofikcoga@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 12:17:18 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] Input: sw42902: unbalanced regulator disable in
  sw42902_power_off()
--

commit 11bdb001b9ee56acee9761786c40a8731d5ef9cb
Author: Abdur Rofik <rofikcoga@gmail.com>

Input: touchscreen: add Silicon Works SW42902 support

This commit adds an I2C touchscreen driver for the Silicon Works SW42902
controller, handling regulator power sequencing, reset GPIO control, and
multitouch input reporting.

> diff --git a/drivers/input/touchscreen/sw42902.c b/drivers/input/touchscr=
een/sw42902.c
> new file mode 100644
> index 0000000000000..a68bd850bf2e2
> --- /dev/null
> +++ b/drivers/input/touchscreen/sw42902.c

[ ... ]

> +static void sw42902_power_off(void *data)
> +{
> +	struct sw42902 *ts =3D data;
> +
> +	gpiod_set_value_cansleep(ts->reset, 1);
> +	usleep_range(1000, 2000);
> +	regulator_bulk_disable(ARRAY_SIZE(ts->supplies), ts->supplies);
> +}
> +
> +static int sw42902_power_on(struct sw42902 *ts)
> +{
> +	int error;
> +
> +	error =3D regulator_bulk_enable(ARRAY_SIZE(ts->supplies), ts->supplies);
> +	if (error)
> +		return error;

[ ... ]

> +static int sw42902_probe(struct i2c_client *client)
> +{

[ ... ]

> +	error =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(ts->supplies), ts->su=
pplies);
> +	if (error)
> +		return dev_err_probe(dev, error, "failed to get regulators\n");
> +
> +	error =3D devm_add_action_or_reset(dev, sw42902_power_off, ts);
> +	if (error)
> +		return error;
> +
> +	input =3D devm_input_allocate_device(dev);
> +	if (!input)
> +		return -ENOMEM;

[ ... ]

> +	error =3D devm_request_threaded_irq(dev, client->irq, NULL, sw42902_irq,
> +					  IRQF_ONESHOT | IRQF_NO_AUTOEN,
> +					  dev_name(dev), ts);
> +	if (error)
> +		return error;
> +
> +	error =3D sw42902_power_on(ts);
> +	if (error)
> +		return error;

[Severity: Medium]
Can sw42902_power_off() call regulator_bulk_disable() when ts->supplies
are not enabled?

devm_add_action_or_reset() registers sw42902_power_off() before
sw42902_power_on() enables the regulators, so a failure in
devm_input_allocate_device(), input_mt_init_slots(),
devm_request_threaded_irq(), or regulator_bulk_enable() itself runs
sw42902_power_off() on disabled regulators and triggers an unbalanced
regulator disable warning.  The same happens on driver unbind while
suspended or after a failed sw42902_resume(), because sw42902_suspend()
already called sw42902_power_off() and set ts->suspended =3D true.

Registering the devres action right after sw42902_power_on() succeeds
(and before devm_request_threaded_irq(), so the IRQ is freed before power
is cut on unbind) and skipping sw42902_power_off() when ts->suspended is
set would avoid the unbalanced disables.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118120714.3150=
5-1-rofikcoga@gmail.com?part=3D6
