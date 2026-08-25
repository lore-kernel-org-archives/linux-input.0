Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA5D11CA9;
	Tue, 25 Aug 2026 04:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787633302; cv=none; b=fHQRSdc0mt42V5Q1MeMqoIv/3/coUKjThyzLsse9fqyMBmnloSCRLxqXKvw4ilM6I76j81LFPDGFFzzyJ+LH5u6nmeG6DnhhlXens3bc8+8Ph3R+kyGuTlV9PsgmqsffunNJEMZ8RUcSlHLwXZaX9x5jp8wDPW8Cm9ipt2fTHjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787633302; c=relaxed/simple;
	bh=PGqzgrUhQ1kq9/0ZGGFJJcgrZV3sR3FGzZOoGW3EK40=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OxRGuEz5Hvn6LHdtTLdXYW+8UZyQCEdowdGyrwnK+hEU05sMMPTRsn103CMWzeiKleQU1kJC70IYtmf7Bj7mBOTaWOouOn5Jknd/1MM9N/Iipi6ZhPHml7D1zMNm5rBCpLgawcZ0AvRVcPvWtcVtZWbB2XbPU2MOJGQhCBzHoVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMee4UEv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMee4UEv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110B81F000E9;
	Tue, 25 Aug 2026 04:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787633301;
	bh=hHzlP39FZ5hf27GdW7HIRdEAm2DxqkkVwMNl3V86urs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mMee4UEveeeN9hGkm/7YN6n4NLqWYk9Kof3RaB9BGOlCDQKnw3/InMlpoEHP2uyGr
	 GWJlytBLzQzG6wUW0MCOF45OpDcJgVb+ArowkB1+xJxaIJmhUn06FBtCTFHMp0LYNr
	 pxozX13h0Y5k6iYTYkOci7WaILYPorB25+R2XNmkfQ0cb3vQNpiGfvptb1r+Ppmrh4
	 g2uAnykv57/oqlX5x4eyDaHnRquDecNj13LyCxC3KTDxMpLz9Flnr2BGhqUhxasI+P
	 LLtSGfwWNCwq9oHd9FcpHxc4QUxZcqyLaSD+qYbipJjFUqY+nEIgZXp9J0lHDf5ebk
	 973PZliOUzQIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/7] HID: i2c-hid-of: skip post-power-on delay if
 powered on sufficiently long
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260825041628.988369-4-wenst@chromium.org>
References: <20260825041628.988369-1-wenst@chromium.org>
 <20260825041628.988369-4-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 04:48:20 +0000
Message-Id: <20260825044821.110B81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The patch relies on a buggy core regulator API, resulting in incor=
rect concurrent wait times for regulator sequencing that truncates the requ=
ired hardware initialization delay.
- [High] The reset assertion pulse during probe may be too short if regulat=
ors are already enabled, potentially violating hardware reset timing requir=
ements.
--

--- Patch [3]: [PATCH v5 3/7] HID: i2c-hid-of: skip post-power-on delay if =
powered on sufficiently long ---
commit 3ba58a3bbf6e0eecad8d9882947c8fc478c04ddc
Author: Chen-Yu Tsai <wenst@chromium.org>
Subject: HID: i2c-hid-of: skip post-power-on delay if powered on sufficient=
ly long

This patch switches the driver to use regulator_bulk_enable_and_wait() to
avoid unnecessary boot delays if the device has been powered on long enough.
It omits the unconditional post power delay in favor of measuring the time
since the regulators were actually enabled.

> diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-h=
id-of.c
> index 59393d71ddb9d..fdaad451e7102 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-of.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-of.c

[ ... ]

> @@ -48,16 +49,14 @@ static int i2c_hid_of_power_up(struct i2chid_ops *ops)
>  	struct device *dev =3D &ihid_of->client->dev;
>  	int ret;
> =20
> -	ret =3D regulator_bulk_enable(ARRAY_SIZE(ihid_of->supplies),
> -				    ihid_of->supplies);
> +	ret =3D regulator_bulk_enable_and_wait(ARRAY_SIZE(ihid_of->supplies),
> +					     ihid_of->supplies,
> +					     ihid_of->post_power_delay_ms * USEC_PER_MSEC);

[Severity: High]
Will this correctly wait for all regulator supplies to stabilize?

When looking at the implementation of regulator_bulk_enable_and_wait()
in drivers/regulator/core.c, the setup loop contains:

for (i =3D 0; i < num_consumers; i++) {
        ACCESS_PRIVATE(consumers, wait_us) =3D wait_us;
        async_schedule_domain(regulator_bulk_enable_async,
                              &consumers[i], &async_domain);
}

Since ACCESS_PRIVATE(consumers, wait_us) expands to consumers[0].wait_us
without indexing by i, only the first regulator receives the configured wait
time.

If the first regulator was already enabled by the bootloader (meaning its w=
ait
time evaluates to 0) and the second regulator is newly enabled, won't the
function return instantly and skip the required hardware stabilization delay
for the second supply?

>  	if (ret) {
>  		dev_warn(dev, "Failed to enable supplies: %d\n", ret);
>  		return ret;
>  	}
> =20
> -	if (ihid_of->post_power_delay_ms)
> -		msleep(ihid_of->post_power_delay_ms);
> -
>  	gpiod_set_value_cansleep(ihid_of->reset_gpio, 0);

[Severity: High]
Could skipping this delay cause the reset assertion pulse to be too short?

In i2c_hid_of_probe(), the reset GPIO is asserted just before calling
i2c_hid_of_power_up(). If the regulators are already enabled,
regulator_bulk_enable_and_wait() will return almost instantly.

Since the unconditional delay is now omitted, the code reaches
gpiod_set_value_cansleep() immediately. Does this reduce the reset assertion
pulse width from the previously guaranteed post_power_delay_ms down to just
a few microseconds?

Could this fail to properly reset I2C HID devices that require a longer
minimum reset pulse?

>  	if (ihid_of->post_reset_delay_ms)
>  		msleep(ihid_of->post_reset_delay_ms);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825041628.9883=
69-1-wenst@chromium.org?part=3D3
