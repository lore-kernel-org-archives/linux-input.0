Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872C5422545
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783698286; cv=none; b=T5X0uV9tFJ5AMR078kVKA3HSngll7utTmztflDoZLtR6h6dRfgCqpHiY+YJXvqIDhIs4+JusAi186JqsZNnQVOgz1hiSYip5cLJk9tp+Tfj5jxH2akYSIQDndXJrdPDyKYf74CSamWunyi1lx2gLVdeZhOAswLAY9OG5GUEHbBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783698286; c=relaxed/simple;
	bh=N0KOqeOrDdM7at41csq9G78I4JeWYUPnbA8quqYjgR0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eNye7OGtkN99yrceWlbMYK1ZsATmb39rS8kLwOKnDHtb/uX3TmdteIyfdUUTYKCK8MVhil/6AKvG5w0wo8rt+KwyN1JEU152mn19Zh9Yywq+VYhaV+UyrylD9yxRa4Qt8Z21jnrWYNDJVY5tYW0fzGP/33X5NePnO8pOn1QncA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cp84rwnz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cp84rwnz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA581F000E9;
	Fri, 10 Jul 2026 15:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783698284;
	bh=isqZFVmsjZRFJ9ox4nc3WOcEj1+grAoy4c/H4BYgxWg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cp84rwnz9kZR4bBSdU7RP5YZ3yVK4oZAjXZol3/WM1kRkD2Z15K7aRwZXYMOniBkU
	 a84ZbqO0S3Znx1weR8kn4oI5IsG93bw1bG6RCrg50WcWxTFJKbQT535Vlq8Dhzx5vC
	 /l/mJtry7ihgJDLN9UtwXsexgN3wwYJrAy87KlIV6eSKRHtpWl8ODVp2GJAyNlx+e3
	 6kkIoqrGQtuL00ptsvWaAcdWB5A6oV9xk6Vz7iaZGanEJzKIAHNkHj5QKR25SVt2W/
	 wkeasiMuLuskt+UouqstURbAt5gnCEs/N1GM3YdLT8qeB2tVwicTgRI+ew2fN+7QGS
	 zZ+vEbPU6Ociw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] HID: wiimote: use scoped cleanup in led creation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael Passos" <rafael@rcpassos.me>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260710153456.2093889-4-rafael@rcpassos.me>
References: <20260710153456.2093889-1-rafael@rcpassos.me>
 <20260710153456.2093889-4-rafael@rcpassos.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 15:44:43 +0000
Message-Id: <20260710154443.8DA581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The check `if (!instance_id)` after `ida_alloc_min()` incorrectly =
assumes 0 on failure, missing negative error codes and leading to an out-of=
-bounds array access and kernel BUG.
--

--- Patch [3]: [PATCH 3/3] HID: wiimote: use scoped cleanup in led creation=
 ---
commit 2a6971d40f61933b6a7890df0931f14066de90e7
Author: Rafael Passos <rafael@rcpassos.me>

HID: wiimote: use scoped cleanup in led creation

This commit updates the wiimod_led_probe function to use modern scoped
cleanup for led allocation. It ensures the led structure is safely freed
on error paths while transferring ownership appropriately on success.

> diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-=
modules.c
> index f42f9aa7b2d49..7c305099c82d6 100644
> --- a/drivers/hid/hid-wiimote-modules.c
> +++ b/drivers/hid/hid-wiimote-modules.c
> @@ -340,11 +340,11 @@ static int wiimod_led_probe(const struct wiimod_ops=
 *ops,
>  {
>  	struct device *dev =3D &wdata->hdev->dev;
>  	size_t namesz =3D strlen(dev_name(dev)) + 9;

[ ... ]

[Severity: High]
Does this driver handle negative error codes from ida_alloc_min() correctly?

Looking at wiimote_hid_probe(), the return value is checked with a boolean
negation:

drivers/hid/hid-wiimote-core.c:wiimote_hid_probe() {
    ...
	instance_id =3D ida_alloc_min(&wiimote_ida, 1, GFP_KERNEL);
	if (!instance_id) {
		hid_err(hdev, "cannot allocate controller id, defaulting to 1\n");
		instance_id =3D 1;
	}
    ...
}

If ida_alloc_min() fails due to memory pressure or IDA exhaustion, it
returns a negative error code like -ENOMEM. The check if (!instance_id)
evaluates to false, bypassing the fallback logic and allowing the
negative error code to be stored in wdata->instance_id.

This negative value is later used in an array index calculation:

drivers/hid/hid-wiimote-core.c:wiimote_modules_load() {
    ...
	scoped_guard(spinlock_irqsave, &wdata->state.lock) {
		wiiproto_req_leds(wdata, player_leds[(wdata->instance_id - 1) % 4]);
	}
    ...
}

Can this cause an out-of-bounds array read, since the modulo operator
in C retains the sign of the dividend?

Additionally, when the device is removed or rolled back, this negative ID
is freed:

drivers/hid/hid-wiimote-core.c:wiimote_hid_remove() {
    ...
	ida_free(&wiimote_ida, wdata->instance_id);
    ...
}

Could passing the negative ID to ida_free() explicitly trigger a BUG_ON
and crash the kernel during teardown?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710153456.2093=
889-1-rafael@rcpassos.me?part=3D3
