Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B094A8A35
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 14:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792159967; cv=none; b=Hp5E9plAratzmgkjzkQ4J3+ZhgBm/lMcKW2HIITOWbQPYJVj/GnT6xn45OeIk1QQkoVaVZMYJ/5CUh8iwvHiS38iSK2z1BawqAbIu+5diKeXVvRleOg5X1okBBBUR7JHIAiE2heOqG9M8TIXyQKtLJL4oUNeP3ydauCH9VG6Gog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792159967; c=relaxed/simple;
	bh=X74tmQyxC5p5TZDMxLYBZqhM6nyxsvRCjzz7Ta7aH7k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UhhBqLIHmUPgfYadrDFwvb7uTmMYg3fbp/Vzcvrhb9HdZWY7dGlq2F4hnzM0DlaY+RecZyP6PuF6o5foHcHUPt/34DnDeuM8zXHOZrX1wIqdwmRJVjjlExLbrvOgvw4CZpinMr9HUWy8eWxEn1UYYCGwGm3+dSyNE9oHA/kpjQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObnqKqF4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObnqKqF4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A714E1F000C4;
	Fri, 16 Oct 2026 14:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792159956;
	bh=zf/ugyr+0WpeNxtl4+unho+i/nGYS1We9YpqUvemKoQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ObnqKqF4wRJSV+7xxb5CC717tCTUdMFWQ/SW/MihoLRKpYBmZkeKlgiRPFSxQu8KJ
	 57gE+TpxepFRe5c1aBQjTFlWyGmuOpnM73q+pqrXBK77K+ylPMi1zuv6x+xARvNqsr
	 vxj9ub7uZeCevVFStn04c0UtPEDWGd8hvdUn8Z+x64sjxOFuRuldofNdfuFB4N5w9c
	 t9EP/DwbHcBvVS+6wwa7I86BLaQzcpom9V6EgfeK0qaLqEOmgvxwggoNP7vymC63YS
	 alVOu/8d5/YCVkKAi72MbUhVnbNurCskA/VfbdQv5RegbNgMzApt1beblydhT1maLi
	 UaV0dfzJSTxsQ==
Message-ID: <sashiko-outbox-174423@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] HID: multitouch: fix use-after-free of haptic
 data on delayed input release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261016135516.2957381-3-qwe.aldo@gmail.com>
References: <20261009103333.2476105-1-qwe.aldo@gmail.com>
 <20261016135516.2957381-1-qwe.aldo@gmail.com>
 <20261016135516.2957381-3-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 14:12:36 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] input: module code UAF due to premature module_put() on unbind
- [High] hid: double-put of hdev and input_dev on multiple haptic touchpad =
collections
--

commit 058030eab60c1764e5ac8d06b32cafc8846c4171
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

HID: multitouch: fix use-after-free of haptic data on delayed input release

This commit moves haptic resource cleanup into a devm action so it runs at
driver unbind before the haptic struct is freed. It also pins the input
device and delays clearing ff->private to prevent double-frees if the
input device release is delayed.

> diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
> --- a/drivers/hid/hid-haptic.c
> +++ b/drivers/hid/hid-haptic.c
> @@ -379,32 +379,57 @@ static int hid_haptic_erase(struct input_dev *dev, =
int effect_id)
[ ... ]
> +static void hid_haptic_devm_release(void *data)
> +{
> +	struct hid_haptic_device *haptic =3D data;
> +	struct input_dev *dev =3D haptic->input_dev;
>  	int r;
> =20
[ ... ]
> +	if (haptic->hdev)
> +		put_device(&haptic->hdev->dev);

[Severity: High]
If a composite HID device presents multiple HID_DG_TOUCHPAD application
collections with haptic usages, mt_input_configured() in hid-multitouch.c
will invoke hid_haptic_input_configured() and hid_haptic_init() multiple
times for the same device.

This causes hid_haptic_init() to queue multiple identical devm release
actions using the same haptic data pointer.

During unbind, this release function will execute multiple times. Because
haptic->hdev is not set to NULL after the first put_device(), will this
result in a double-put of the hdev reference count?

[ ... ]
> +	if (dev)
> +		input_put_device(dev);

[Severity: High]
Similarly, the local dev variable here is populated at the start of the
function from haptic->input_dev. If the release action runs multiple times
for the same haptic struct, will this result in a double-put of the
input_dev reference count as well?

> +
> +	module_put(THIS_MODULE);
>  }

[Severity: High]
The devres action runs synchronously during driver unbind. If an application
holds an open file descriptor to the input device, the input_dev structure
and its ff_device are kept alive after unbind.

Since module_put() executes here, the module's reference count drops, allow=
ing
the system to unload the HID driver module.

When the application eventually closes the file descriptor, the last refere=
nce
to the input_dev is dropped. This triggers input_dev_release() which calls
input_ff_destroy().

input_ff_destroy() unconditionally invokes:

    if (ff->destroy)
        ff->destroy(ff);
       =20
Since dev->ff->destroy was not cleared and still points to hid_haptic_destr=
oy()
inside the unloaded module, does this result in the execution of unmapped
memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016135516.2957=
381-1-qwe.aldo@gmail.com?part=3D2
