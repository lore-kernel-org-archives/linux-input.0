Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDD540D570
	for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 05:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781416203; cv=none; b=ihtZk+yfX42mI3Gnp2vqMwu3t+SxDq6AxQfiixsIzm81sC6/XKm2Ny0wxn5KXktkYhrYHdec5UGpfXZyo13JbDDt6V9APXTniEM8KJzsLoErH8rmbTj0VA+co2yg8cscHToGVP4IrjIsuc8A4quxH8+FmKNjY7xgnarlNPwUhrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781416203; c=relaxed/simple;
	bh=jrjvy2gQCzbMuuc7rZcjWFLqRCw/Xt97xAGmC+ehtQw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B5BcTi0acPRCBg97EzYQn3JpeZjS0SkCDjX6GyDkwPlAFb3wJBUGnLPl+tvLJfeRQyLSEVANc13bAY2NzGkyll209Cx+BAecpZPxCO88S/euta0NO5JXvmV+lkWArYSf2Si0V/iuDs8hEgBRKbsVozLDlZOIgp9eakWtlgEgpM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APjgdgnE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APjgdgnE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D6D1F000E9;
	Sun, 14 Jun 2026 05:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781416201;
	bh=Gbsz1Xt9OJGP4kq0zPRQkRlyPARSYykKvmVRHUHSke0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=APjgdgnEiYUrU4Q4DguDvC36NRA66Il8Vv1KBtjneZyCvEBoicOoNVTyFZuyYRChs
	 rm74QwFVFsU4KhsdHLsEekyCg9O1ajTtrc3mgXhp3r2aU2tCatiKvXZmoLMjEb6LJr
	 Vo02Ua9DiEYFjlJ8mTdQ0H0/UuEARwIwnSkxkouo43EehrwQhau6xZ2phbXa/arKzr
	 lViFqknKrz+qRuzCsunNvOHlm44pMJ55+3Hf2Zx9qfYHtHmBHN6A9aWG1Yqs0v26ur
	 yksCJG+eo4wzLP1qdS5pcrcS5TX2iJkPQ2sDMhGCjoO58wTEqxKHAI0LmITDH+XXti
	 jhDzE/gV2RQZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] Input: synaptics-rmi4 - bound the F30 keymap to the
 GPIO/LED count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas via B4 Relay" <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260614-b4-disp-818d6bda-v1-2-cf39a3615085@proton.me>
References: <20260614-b4-disp-818d6bda-v1-2-cf39a3615085@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 05:50:01 +0000
Message-Id: <20260614055001.B3D6D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbinding the `rmi4_f30` driver leaves a dangling pointer in the s=
hared input device's `keycode` field, leading to a Use-After-Free.
--

commit 251790cc33b0da19e8d0320efecb822396ad7b5f
Author: Bryam Vargas <hexlabsecurity@proton.me>

Input: synaptics-rmi4 - bound the F30 keymap to the GPIO/LED count

This commit fixes an out-of-bounds read and write issue in the F30
keymap handler. It allocates the keymap based on the full reported
GPIO/LED count rather than capping the allocation at 6 entries.

> diff --git a/drivers/input/rmi4/rmi_f30.c b/drivers/input/rmi4/rmi_f30.c
> --- a/drivers/input/rmi4/rmi_f30.c
> +++ b/drivers/input/rmi4/rmi_f30.c
> @@ -233,7 +233,7 @@ static int rmi_f30_map_gpios(struct rmi_function *fn,
>  	int button_count =3D min_t(u8, f30->gpioled_count, TRACKSTICK_RANGE_END=
);
> =20
>  	f30->gpioled_key_map =3D devm_kcalloc(&fn->dev,
> -					    button_count,
> +					    f30->gpioled_count,
>  					    sizeof(f30->gpioled_key_map[0]),
>  					    GFP_KERNEL);

[Severity: High]
This is a pre-existing issue, but since we are modifying this allocation,
can this lead to a use-after-free when the driver is unbound?

The memory for f30->gpioled_key_map is managed by the function subdevice
using fn->dev. Later in rmi_f30_map_gpios(), this pointer is assigned to the
shared input device's keycode field:

input->keycode =3D f30->gpioled_key_map;

Since the shared input device is attached to the parent RMI device, it can
outlive the function subdevice. If userspace unbinds the rmi4_f30 driver
via sysfs (because the driver lacks a remove callback and does not set
suppress_bind_attrs), devres will free f30->gpioled_key_map while
the input device remains registered.

Would a subsequent ioctl like EVIOCGKEYCODE or EVIOCSKEYCODE access this
freed input->keycode memory?

Does this also cause a race condition during device unplug, since the
function devices are unbound before the input device is unregistered?

>  	if (!f30->gpioled_key_map) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260614-b4-disp-81=
8d6bda-v1-0-cf39a3615085@proton.me?part=3D2
