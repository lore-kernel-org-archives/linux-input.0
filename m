Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A618634C
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 01:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785720479; cv=none; b=CmU/Lx3pDYpsydQFjKchm5zqX2d1Z1EN/lpLG4Tq4O3PKI4/gj2FDM7ln7EVR5KH5/PU0Mp/qDkLic3O6NINW/KNLXgKYiF44BL3pbqkV6brYdVB2WYjDPgHT+ZBq8myYLpbTkJXlkWvvSQKcmTq5lHeNqNvkiP/X2ToZUyIy+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785720479; c=relaxed/simple;
	bh=oTMPlQj1GfPpSg9cp3d4X0t/SZJboxwW7rqoN8z6cx4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W3Hb68Tuah0Sm0XibDwTznPJvjqrIzlNSLiW4dcWS8154kvkAqdyUjIsvzVYJZXFtkqAs8W1yk0bWfG+vGFC/OQJymZgMQo223jOfHnBuWyY9W7Mf19MG6odTDN3gMpTZ9+/8k8qWfR1C9r5h6wECHNqumALSFMNIoUeDZs4zM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igLdcvk/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igLdcvk/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB1E1F000E9;
	Mon,  3 Aug 2026 01:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785720477;
	bh=UmJEJbqjRK4qL4KOuKYsX/7oiBLoF94gvOecGyGkA/Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=igLdcvk/bM1sawfH/WZFaT8KxKIrCV8mp+WhPPXPs9GKr0rD+8bFxeUWigEo9LSw5
	 yKhthunxj3FgfW97621MDsyV6ojFPovfyS4Uu/GnZHAKU1a4oDmJGGHQzVFssqhVlR
	 kA1bcFSEYJsmGyZS2E/H5AzBdx7Qbg2KX7Y2Ed7RNn9mZWhtPw9fCTjE8kWUDmaAeZ
	 YDM8mSyLGVQA/sU9hzr064H1D93IC8VCbt64TgcXFtQiJHAHYm2E8uh60S68/aJReJ
	 kWr7+SdTo9e6kEuGgfK487UclutX4p1uccY9wV/3Du2Xz7a0iXzasA3tmcQfRzrtqk
	 X2MFP7HxYvIZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] Input: call handler->start() when uninhibiting
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260803005210.1251102-3-dmitry.torokhov@gmail.com>
References: <20260803005210.1251102-1-dmitry.torokhov@gmail.com>
 <20260803005210.1251102-3-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 01:27:57 +0000
Message-Id: <20260803012757.BBB1E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Sysfs uninhibiting a device can race with device unregistration, c=
ausing `dev->open()` to be called on a hardware device that is being destro=
yed.
--

--- Patch [3]: [PATCH v2 3/4] Input: call handler->start() when uninhibitin=
g device ---
commit 7812e6dd22b71b48fc822b6545778a4eb30f8e35
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: call handler->start() when uninhibiting device

When an input device is uninhibited, the driver is re-opened. This patch
ensures that complex handlers are also notified to re-synchronize their
state by calling handler->start() for each open handle.

> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index e4f8c2067b84d..47886a394c6b8 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -1806,6 +1806,7 @@ static int input_inhibit_device(struct input_dev *d=
ev)
> =20
>  static int input_uninhibit_device(struct input_dev *dev)
>  {
> +	struct input_handle *handle;
>  	int error;
> =20
>  	guard(mutex)(&dev->mutex);

[Severity: High]
This is a pre-existing issue, but does this function open a race condition
with input_unregister_device() by missing a check for dev->going_away?

When a driver calls input_unregister_device(), the core sets
dev->going_away =3D true in input_disconnect_device() and releases
dev->mutex.

If a concurrent sysfs write to the inhibited attribute executes
input_uninhibit_device(), it acquires dev->mutex here.

Because it lacks a dev->going_away check (unlike input_open_device()), it
proceeds to set dev->inhibited =3D false and calls dev->open() on a dying
device.

Can this lead to a use-after-free or hardware state corruption if the
driver has already freed its IO mappings or IRQs during unregistration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803005210.1251=
102-1-dmitry.torokhov@gmail.com?part=3D3
