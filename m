Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BD230F7EB
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787926552; cv=none; b=ih9VWKzM5ypmSjX3GrLmyKSOmR+9dy3f7zMFr1JBtzi3oytyXpU6GVsPoc7rF/SYwUoHbAXG3WyPlFvQZNf9IAhf2X59y2cfaD7TRDReMilUnx8oH2u0nizqxJLpHu2LCXlVmBT5kwjgz+y9OQp1dJYUqfhz9h78xdQfUpzRnvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787926552; c=relaxed/simple;
	bh=P9z1GZ2IPjiUW5jc9cn4l8EADeSnwcXhx1/q54qTrBk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lx5lCARSylBfDwXUC03Gy6YUGcm9awhTIUUURET1L01d6ZfxVlcabW793WDsnTYRWXPXQhSk5vibum+jCQZfNYqQcI9IP/FLMuWS7p6S2AakfMs9nLJveeo58z1HYbxryTfnfy4dJEyMH/c1Zq5hm3Z/xV2KClBrvlZ4df+4XRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yvpga3ci; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yvpga3ci"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232281F000E9;
	Fri, 28 Aug 2026 14:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787926551;
	bh=FDcmypVQoBx4UCG5gVxdK7wzGc41OSKLJcRD1dVvW8A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yvpga3ciZwXvb+Zs+fxkPAXFsM7Yh1QOyrpeTj48mVg7nivnEu2XvXmw2sdg1+c9n
	 jcqat9R/Aaci4bMTleExZ/+34IihqTWLLi05p3NG9d+bZ1XSVTsYZqx1/HA3znT1rM
	 cZkAAxewZjHG/VV4vgZb44hHQYoUM6BB5QU5YCA1xHS+vaZwUOU1cHqc2weJLpoPTZ
	 5TRtnHwvxrfNfNjMOaUsNpzLotqnPodDR7yHMHT9ODJmFlEjAxmikqP4nxkMvLIq4d
	 oD6iS8YAjjEWxZ6vx8ltggOPszby/3WhW5YW9pzV/KuYT4MPUHADooOLZAR4vy/GWw
	 4wCXcj/ydG0FQ==
From: sashiko-bot@kernel.org
Subject: Re: [syzbot] [input?] KASAN: slab-use-after-free Read in
 atkbd_set_repeat_rate
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jeffin Philip" <jeffinphilip14@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260828140330.134760-1-jeffinphilip14@gmail.com>
References: <6a90d9ef.4d659fcc.734b4.0019.GAE@google.com>
 <20260828140330.134760-1-jeffinphilip14@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 14:15:50 +0000
Message-Id: <20260828141551.232281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Using an interruptible lock guard (`scoped_guard(mutex_intr)`) in =
a teardown path conditionally skips the device disable logic if a signal is=
 pending, resulting in a Use-After-Free of `atkbd->dev`.
--

commit bc5cff19d061e401dc02c7bcc7660c6bf6781f46
Author: Jeffin Philip <jeffinphilip14@gmail.com>

KASAN: slab-use-after-free Read in atkbd_set_repeat_rate

This commit attempts to fix a use-after-free issue by wrapping the
device disable routine in atkbd_disconnect with a mutex guard to serialize
teardown against other event and attribute operations.

> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkb=
d.c
> index 3509b58e64920..d5b564bab0e20 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -961,7 +961,9 @@ static void atkbd_disconnect(struct serio *serio)
>  {
>  	struct atkbd *atkbd =3D atkbd_from_serio(serio);
> =20
> +	scoped_guard(mutex_intr, &atkbd->mutex) {
>  	atkbd_disable(atkbd);
> +	}

[Severity: High]
If a signal is pending when atkbd_disconnect() is called, will this scoped
guard silently skip the hardware disable block?

Because mutex_intr is interruptible, it returns -EINTR if the process
receives a signal (such as when userspace sends a signal to the unbind
process). This causes the guarded scope block to be bypassed, meaning
atkbd_disable() is not executed and atkbd->enabled remains true.

When input_unregister_device() subsequently frees the device, could
concurrent handlers that rely on the enabled flag still execute and trigger
a use-after-free on the freed dev pointer?

For example, in atkbd_receive_byte():

	if (!atkbd->enabled)
		return;

	input_event(dev, EV_MSC, MSC_RAW, code);

And similarly in atkbd_event_work():

	if (test_and_clear_bit(ATKBD_REP_EVENT_BIT, &atkbd->event_mask))
		atkbd_set_repeat_rate(atkbd);

Should this use an uninterruptible guard instead, since disabling the device
is a mandatory step during teardown?

> =20
>  	input_unregister_device(atkbd->dev);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828140330.1347=
60-1-jeffinphilip14@gmail.com?part=3D1
