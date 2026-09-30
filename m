Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0928151E43A;
	Wed, 30 Sep 2026 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789476; cv=none; b=QlwQLE/B6E9Tb9ffQ9SV6C84ZuX3SG/Q61nHgUIuAS3ppBF5qx0/uqHbJbAs6hG4T9j0GLZFhVT5mpdtja4sZVv4va+MVEpCWgeQwIHFH2MHlsWA/fRQ7udr44AothauBEUeHSWqZ3YNBKfs7sHcI40/iA86mxWWdQHmwaSgJS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789476; c=relaxed/simple;
	bh=WL1y69g1KTEgrXG/1airKc2k0jYVX+esnsDZ5zd9gkU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PpNxozA8XF0da+6esyjy2vC9UsFxuckTGYbwhHCteKMo+1ZOf6vZ6UGwMZyUbslIfJnUUScPfoc2fS72LS0ggY8TFnE3UuF3/9xZla72tNi2bxLdDQ45ivus9aKLqFyISF5whM9wSGAMUHswJuKXZGRP5T8M8XmDQDKgSE3/zAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsIzkhPh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsIzkhPh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C4D1F00898;
	Wed, 30 Sep 2026 17:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790789474;
	bh=9L1STo4mCClNVE4se46hM5cy6sRYgN4grLGxWWygi3s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NsIzkhPhehcS8MQ+45EEHYqhTeAH02ziQklvMG98mRrzq3G0hY2+7BP7J/8R899V6
	 jIa6jdduWUsmHq7g5Iy/mFXJv18X0uLuYdU24JRGfRYbUq5e7dfq7bfWhoGiRudnMM
	 z/alWO+3xH8OyssX/vaGwsVPGZaWjYTaTdUyfgu3JyupaSNlat5FfbNVFBD/a0NFj1
	 lGWoyH2lZ3bkWlBxt+MmDjMUggxcbHggpOYUPDrH9Mfkpk6O4YMsLDPwAI8+YxgoAB
	 8mdhATN+F12WQvvU0lCEN4jqZMmYsH6TBrfJzWHdLJVShoV6AedzcjKQO1lzATLp6R
	 55vEZvFbuDkNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] Input: aw8697 - Add Awinic AW8697 haptics driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Armandas Kvietkus" <armandas.kvietkus@proton.me>
Cc: devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260930-mainlining-v2-2-40bb1b3943db@proton.me>
References: <20260930-mainlining-v2-0-40bb1b3943db@proton.me>
 <20260930-mainlining-v2-2-40bb1b3943db@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 17:31:13 +0000
Message-Id: <20260930173114.71C4D1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] input: UAF in aw8697_play_work due to missing devm cancellation ac=
tion
- [Low] i2c: missing named initializer for i2c_device_id array
--

commit 78f66ce5a94c007171954aaef47a26794e665c94
Author: Armandas Kvietkus <armandas.kvietkus@proton.me>

Input: aw8697 - Add Awinic AW8697 haptics driver

Adds a driver for the Awinic AW8697 LRA haptic driver IC. It supports
force feedback rumble and calibrates the LRA resonance at probe.

> diff --git a/drivers/input/misc/aw8697.c b/drivers/input/misc/aw8697.c
> new file mode 100644
> index 0000000000000..96c0205089fd0
> --- /dev/null
> +++ b/drivers/input/misc/aw8697.c

[ ... ]

> +static int aw8697_probe(struct i2c_client *client)
> +{

[ ... ]

> +	err =3D devm_request_threaded_irq(dev, client->irq, NULL, aw8697_irq,
> +					IRQF_ONESHOT, NULL, haptics);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to request irq\n");
> +
> +	INIT_WORK(&haptics->play_work, aw8697_play_work);
> +
> +	haptics->input_dev =3D devm_input_allocate_device(dev);

[Severity: High]
Could this lead to a use-after-free of the haptics structure if the driver
is unbound while an effect is active?

The workqueue is initialized here, but no devm action is registered to
guarantee cancellation after the input device is fully unregistered.

If the driver is unbound, devm automatically calls input_unregister_device(=
),
which triggers aw8697_close() and cancels the work. However, the
force-feedback memless timer is only stopped later in
input_unregister_device() when it calls the destroy callback.

In this narrow window, the timer can still fire and call aw8697_play_effect=
(),
which reschedules haptics->play_work. Because there is no devm action to
cancel the work queue after the input device is fully unregistered, the
rescheduled work persists after devm frees the haptics structure, causing a
use-after-free when the work executes.

> +	if (!haptics->input_dev)
> +		return -ENOMEM;

[ ... ]

> +static DEFINE_SIMPLE_DEV_PM_OPS(aw8697_pm_ops, aw8697_suspend, aw8697_re=
sume);
> +
> +static const struct i2c_device_id aw8697_id[] =3D {
> +	{ "aw8697" },

[Severity: Low]
Does this array violate the I2C subsystem rule mandating named initializers?
It seems this should be written as { .name =3D "aw8697" }.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, aw8697_id);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-mainlining=
-v2-0-40bb1b3943db@proton.me?part=3D2
