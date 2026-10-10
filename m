Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BC5370AC7
	for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 18:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791655731; cv=none; b=SLPZwo/3ueij67hEswd6bETBHXmKxMOOo5Ni9JkuTbi8MIVkDCT2j+crfK754iGqsV24DnctmMettEjFxqSpnZDtkT5g8wjeURNsWhu1c08DwVtw5baX1z0yffliWh8FQYOL6FQhhReHKFKZlRNYvpBjJjctqgpuhCj/64Lam/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791655731; c=relaxed/simple;
	bh=GPjg00wMeBdBMKF93C5CIDXW7oBYcoza+KKS0NAA2W4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WdoCwErDSn1Pwu/vJrRf+OBF9DQNvm6mUokGGC5hxTUllfOyDOlukWdsqEUXBqa2NpXDxsRN1fZ5gb0BUIyE2ZHMBUID9aZXUA7MznNZw1VwMk+VAGwfwo62Q9x9Ht+6fo7vEY7wbN7ibs3RrUIu5HQj/8oiKMv8svSVF7AR7Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loFviU7d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loFviU7d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252B91F000FF;
	Sat, 10 Oct 2026 18:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791655730;
	bh=IvZlT47zE0MGl4iwoRZwqkYMF/oCl23Tl9PURx79T1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=loFviU7dE32GjqvZsFodAneZsTvUFRl3LoYcn7NN6jECHSXOEW9dfd/UVpJc94uc0
	 unKFMsaGPBvBcyDulUPUwS8Gouo3GfrvYYBosU3cNyrNhoYAywun37tqjcJHXRyPk4
	 +56TYT38f9zWF9dwHVVx4tIsmfoUswW/BWOQwwMPMegy77dSFaFF7cjuhgyiHopLyo
	 7p1rfcGTpQCX8ttqOwlvfm2BiY1SNVpWUWxQJF8OIyoJ7KxdtsFV3XSNzmjfl7brdK
	 yJZo/JNZw9ENBCjaDC8ae8STgm6afuPASAuSwq0SXcLtew/NXdueiv5WJBEQxCuXdN
	 GhRSYa+TtjERg==
Message-ID: <sashiko-outbox-166792@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] Input: test state seeding across device
 registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karlos Abel" <kabel@voidship.net>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261010180031.7-3-kabel@voidship.net>
References: <20261010180031.7-1-kabel@voidship.net>
 <20261010180031.7-3-kabel@voidship.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 18:08:49 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] input: missing absinfo allocation check in input_set_abs_params ca=
uses NULL pointer dereference
- [Medium] input: dangling pointer match in test teardown allows accidental=
 binding to unrelated devices
--

commit 2e31a0267a25d47a7a2da67f7fbb5534d7ebbae1
Author: Karlos Abel <kabel@voidship.net>

Input: test state seeding across device registration

This commit adds KUnit coverage for input events used to initialize device
state before registration. It exercises both original event buffers and lar=
ger
resizing buffers, verifying the correct retention and delivery of states.

> diff --git a/drivers/input/tests/input_test.c b/drivers/input/tests/input=
_test.c
> index e105ce71a920a..889d9e7ec922f 100644
> --- a/drivers/input/tests/input_test.c
> +++ b/drivers/input/tests/input_test.c
[ ... ]
> @@ -161,11 +161,179 @@ static void input_test_grab(struct kunit *test)
[ ... ]
> +static bool input_seed_match(struct input_handler *handler,
> +			     struct input_dev *dev)
> +{
> +	struct input_seed_test *seed =3D container_of(handler, struct input_see=
d_test,
> +						  handler);
> +
> +	return seed->dev =3D=3D dev;
> +}
[ ... ]
> +	/* An ABS axis also raises the estimated event-buffer size. */
> +	if (resize) {
> +		input_set_abs_params(seed->dev, ABS_X, 0, 100, 0, 0);
> +		seed->dev->hint_events_per_packet =3D 128;
> +	}

[Severity: High]
Does this code risk a NULL pointer dereference if the internal allocation
for `absinfo` fails?

Functions like `input_set_abs_params()` set `EV_ABS` in `dev->evbit` and the
specific axis in `dev->absbit` before calling `input_alloc_absinfo()`. If t=
his
allocation fails (e.g., due to memory pressure), they return silently, leav=
ing
the capability bits permanently set while `dev->absinfo` remains NULL.

[ ... ]
> +	/* Initialize state before registration, without a SYN_REPORT. */
> +	input_set_timestamp(seed->dev, seed_timestamp);
> +	input_report_switch(seed->dev, SW_DOCK, 1);
> +	if (resize)
> +		input_report_abs(seed->dev, ABS_X, 42);

Because this test explicitly relies on seeding initial absolute axis state =
via
`input_report_abs()` before registration, if the allocation failed during
`input_set_abs_params()`, this subsequent event injection causes
`input_handle_abs_event()` to unconditionally dereference
`dev->absinfo[code].value`. This results in a NULL pointer dereference
regression before the delayed missing-absinfo check in
`input_register_device()` can catch it.

Should the failure state of `input_set_abs_params()` be checked here, or
should `input_alloc_absinfo()` be verified to have succeeded before
continuing?

[ ... ]
> +unregister_device:
> +	input_unregister_device(seed->dev);
> +	input_unregister_handler(&seed->handler);

[Severity: Medium]
Can this sequence lead to a use-after-free regression and accidental binding
to unrelated devices?

In this teardown path of `input_test_seed_events()`,
`input_unregister_device()` is called before `input_unregister_handler()`.
For a non-devres device, unregistering calls `input_put_device()`, dropping
the final reference and immediately freeing the device memory. However, the
custom test handler remains on the global `input_handler_list`.

If another input device registers concurrently during this window, the input
core iterates all handlers and calls `input_seed_match()`. This function
evaluates `seed->dev =3D=3D dev` using the freed memory. If the slab alloca=
tor
reused that exact memory address for the newly registered device, the match
will incorrectly return true, and the test handler will erroneously attempt
to bind to the unrelated device.

Should `input_unregister_handler()` be called before
`input_unregister_device()` to avoid this race condition?

> +	return;
> +
> +unregister_handler:
> +	input_unregister_handler(&seed->handler);
> +free_device:
> +	input_free_device(seed->dev);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010180031.7-1-=
kabel@voidship.net?part=3D2
