Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B593CF050
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 05:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587225; cv=none; b=gkkbKBumkjOn3BCn7faCaRjlnKecgwHj9wwQlKLvjbu7OusUWW/cikvDTRPkBE6GqNIWpYk/wVtU+U7nOicDOBFAyyJP+nl/9QfxsQ+5oVtIaGJ5VP8GDZqKHbdG/QVXteLgcFoVvPR6RrGglukT7nUm93pV2ZSmJwg177h7snc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587225; c=relaxed/simple;
	bh=TSusuMmaYUFHVbxwG4hgyi4qvqRUwYGox5Bo0cO2YJM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fvNrJiJlzBgxIGftEDFYmsMGKcKhaik9KUBFZ4StIFtpisvB2lhNDL9yl9ySGm4fzEi9/JQkBqMjx7rz18pvPW1M2vgjMKprc4+M530qwhcd53NsdOnKKwWN0O2pyC427kKJnzPxPGjN3W4P1NlFgxUDIQWLLhlBpMHFKesplAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccWRHVp4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccWRHVp4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FFD1F000E9;
	Tue, 16 Jun 2026 05:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781587224;
	bh=MUrtF9a51DYKf6dXMOqEo7S/pK3au4NJKCMdEJDz0h4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ccWRHVp44hvOG/nDQ3kObfJkNqA3NTYp2Jlb5L7Mk/s067UABUmOO/R+7zPuGUb+Y
	 cBizgJvS3FFwEddOBRdnvG0mm7sRnJORBfVdSWxYXzCoFBor3aa+eHdDj0YddIewYQ
	 eEwEMHAGsfxnk1fPq5QCY0X9brc7DQHPwYvpy6T6gnjsqtumQ7b81vQipYaOf4hOKJ
	 wldT7993iPJ8e0RlVdKF4OM3mzN4T0ffWVZAXvoeuigvKdp3fr/iOll6Cu2cwiNtiT
	 mBAwnQbjE2l5XcZpnT0VhwCoW5OL1bNbFLv6FB9fBYrRfK0YU/oPYE4cOJPzK4zqRX
	 YG1vC3+Tcf/yA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] Input: mms114 - fix touch indexing for MMS134S and
 MMS136
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260616050912.1531241-1-dmitry.torokhov@gmail.com>
References: <20260616050912.1531241-1-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 05:20:24 +0000
Message-Id: <20260616052024.59FFD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing validation for `touch->id =3D=3D 0` causes multi-touch slo=
t state corruption.
- [High] The devres allocation order in probe registers the input device's =
unregistration action before the regulators and IRQ are allocated, leading =
to a Use-After-Free.
- [Medium] Hardware I2C packet layout is mapped using compiler-dependent C =
bitfields.
--

commit d12fd2dedb0344983eaa73c88bc06f0ac0c59d09
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: mms114 - fix touch indexing for MMS134S and MMS136

This commit fixes an issue where the driver iterates through touch events
using standard array indexing, assuming an 8-byte size. It explicitly
calculates the byte offset for each event based on the device's specific
event size (6 bytes for MMS134S and MMS136).

> diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscre=
en/mms114.c
> index 4d748a13408d1..53ad35d61d476 100644
> --- a/drivers/input/touchscreen/mms114.c
> +++ b/drivers/input/touchscreen/mms114.c
> @@ -217,7 +217,9 @@ static irqreturn_t mms114_interrupt(int irq, void *de=
v_id)
>  	struct mms114_data *data =3D dev_id;
>  	struct i2c_client *client =3D data->client;
>  	struct mms114_touch touch[MMS114_MAX_TOUCH];
> +	struct mms114_touch *t;

[ ... ]

>  	for (index =3D 0; index < touch_size; index++) {
> -		switch (touch[index].type) {
> +		t =3D (struct mms114_touch *)((u8 *)touch + index * event_size);
> +

[Severity: Medium]
This is a pre-existing issue, but I noticed the hardware I2C packet layout
is mapped using C bitfields:

struct mms114_touch {
        u8 id:4, reserved_bit4:1, type:2, pressed:1;
        u8 x_hi:4, y_hi:4;
...

Because the layout of bitfields within a byte is compiler and endianness
dependent, will this read garbage for the id, type, and pressed fields
if the driver is compiled for a Big Endian system?

> +		switch (t->type) {
>  		case MMS114_TYPE_TOUCHSCREEN:
> -			mms114_process_mt(data, touch + index);
> +			mms114_process_mt(data, t);

[Severity: High]
This isn't a bug introduced by this patch, but does the multi-touch slot
processing handle an empty or invalid touch ID safely?

Looking at mms114_process_mt(), the slot index is calculated without a
check for zero:

mms114_process_mt() {
        ...
        id =3D touch->id - 1;
        ...
        input_mt_slot(input_dev, id);

If the device reports a touch event with touch->id =3D=3D 0, id will underf=
low
to -1. Since the input core ignores negative slot values and leaves the
active slot unchanged, would subsequent coordinate reporting functions act
on this unchanged slot and silently corrupt the multi-touch tracking?

>  			break;
> =20
>  		case MMS114_TYPE_TOUCHKEY:

[ ... ]

[Severity: High]
This is a pre-existing issue, but I have a question about the device cleanup
sequence during unbind.

In mms114_probe(), devm_input_allocate_device() is called before the
regulators and IRQ are allocated:

mms114_probe() {
        ...
        input_dev =3D devm_input_allocate_device(&client->dev);
        ...
        data->core_reg =3D devm_regulator_get(&client->dev, "avdd");
}

Because devres executes cleanup actions in reverse order (LIFO), during
unbind the IRQ and regulators are freed before input_unregister_device()
is called.

If the input device is held open by userspace during unbind, does
input_unregister_device() trigger mms114_input_close() and then
mms114_stop()?

mms114_stop() {
        ...
        disable_irq(client->irq);
        error =3D regulator_disable(data->io_reg);
        ...
}

Could this attempt to disable a freed IRQ and access freed regulators,
causing a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616050912.1531=
241-1-dmitry.torokhov@gmail.com?part=3D1
