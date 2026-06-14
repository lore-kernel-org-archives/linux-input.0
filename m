Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6A2857CC
	for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 05:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781416311; cv=none; b=HjMjhD8cBTP25ny+w2tZLYlmSWAn0zAIie4+oEiKi9IpH0SVYcASK+YIF7OgOXzb7X8iAwSjD5cMi49PPHXPVMG7DErZ9C9VPFat3EfO8UdnYMEf32/OdSm67KidpiWS1cL/JhiBjRAmoOU06aFYF4Hz/zPDLd4ybdCvgZSxvaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781416311; c=relaxed/simple;
	bh=Ejue4QXwPYjegxrOGzU2Lf94GOSeWj2BcsoDipR4GGU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jA6nw0YMNpevR+B5v0C/9Gg7xNhKspX9ck8dveqGjYqp8W2eE2lbxleQFTVPM2osmUIB++SZnAsBbq/LkzHu8O2L1j/Kvo/uNBngavHrKOHimIPvcv8OBZNA6bAEp9BkRagiYypJC1XNSxvtp1C2r16jhvkO+W4kFggmmPyZS3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpjMr7qJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpjMr7qJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B0B1F000E9;
	Sun, 14 Jun 2026 05:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781416308;
	bh=mdxE1LwmiXwePzzUHvs9EzHFdPM60B0Ubp93F/GMcm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SpjMr7qJaifUUD3EC2sZVMvtY4a6gAfp6tNzKXLOKFRp+FaWiZt66TbiT+zT797NX
	 T1nkP7svHraOnoatx2uRl0cfZPKvbMrtyEc0Z/BzCniatFGJsDwt0TBkk6DszMmrYz
	 0SdTmw34feUqVc3fEAvANAWqCroRdmGllfWOKnzHHQWe7fO5gtdzgET04v4HpzelG0
	 cREKFXVK2TlPYugPuK5azpuV4XWt5ekCdpZObGVdJeNVTvlLjVxpB8OqRkx0njUgnW
	 k2bZsA8HW5VArndAxk0rTIuTowAtLxgb1cUI6UogYgfYoS3p8H9tEeQMKxfD1e0Yfg
	 RoT4i9pnmwsvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] Input: synaptics-rmi4 - bound the F3A keymap to the
 GPIO count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas via B4 Relay" <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260614-b4-disp-818d6bda-v1-1-cf39a3615085@proton.me>
References: <20260614-b4-disp-818d6bda-v1-1-cf39a3615085@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 05:51:48 +0000
Message-Id: <20260614055148.72B0B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds shift and logic error in `rmi_f3a_report_button` whe=
n `button >=3D 8`.
- [High] Unbinding the `rmi4_f3a` driver leaves a dangling `input->keycode`=
 pointer, leading to a Use-After-Free.
- [High] Failing to insert into the attention FIFO leaks the dynamically al=
located duplicate buffer.
- [Medium] Multiple RMI4 functions concurrently overwrite the shared `input=
->keycode` map, making all but the last probed map inaccessible to userspac=
e.
--

commit 1556a27ea7ad4e1c54736060ac2c334003a11681
Author: Bryam Vargas <hexlabsecurity@proton.me>

Input: synaptics-rmi4 - bound the F3A keymap to the GPIO count

This commit addresses an out-of-bounds access in the F3A keymap. It sizes t=
he
gpio_key_map buffer to the full gpio_count rather than capping it at 6,
preventing reads or writes past the allocated array during attention
interrupts or keymap ioctls.

> diff --git a/drivers/input/rmi4/rmi_f3a.c b/drivers/input/rmi4/rmi_f3a.c
> index 0e8baed84dbb5..a0777644eef07 100644
> --- a/drivers/input/rmi4/rmi_f3a.c
> +++ b/drivers/input/rmi4/rmi_f3a.c
> @@ -132,7 +132,7 @@ static int rmi_f3a_map_gpios(struct rmi_function *fn,=
 struct f3a_data *f3a,
>  	int button_count =3D min_t(u8, f3a->gpio_count, TRACKSTICK_RANGE_END);
> =20
>  	f3a->gpio_key_map =3D devm_kcalloc(&fn->dev,
> -						button_count,
> +						f3a->gpio_count,
>  						sizeof(f3a->gpio_key_map[0]),
>  						GFP_KERNEL);

[Severity: High]
This isn't a bug introduced by this patch, but I have a question about the
lifecycle of the keymap allocated here.

Since input->keycode is set to f3a->gpio_key_map later in this function, if
the rmi4_f3a function driver is unbound via sysfs, devres will free this
memory. Because rmi_f3a_handler lacks a .remove callback and does not set
.suppress_bind_attrs =3D true, does this leave input->keycode pointing to f=
reed
memory? Could subsequent EVIOCGKEYCODE or EVIOCSKEYCODE ioctls on the shared
input_dev dereference this freed pointer?

[Severity: Medium]
This is a pre-existing issue, but I also noticed how this keymap interacts
with the shared input device.

Both F3A and F30 assign their own private arrays to the shared input->keyco=
de:

drivers/input/rmi4/rmi_f3a.c:rmi_f3a_map_gpios() {
    ...
    input->keycode =3D f3a->gpio_key_map;
    ...
}

drivers/input/rmi4/rmi_f30.c:rmi_f30_map_gpios() {
    ...
    input->keycode =3D f30->gpioled_key_map;
    ...
}

Since multiple RMI4 functions concurrently overwrite the shared
input->keycode, does this make all but the last probed map inaccessible to
userspace? Would earlier functions then report events using their
unmodifiable, private arrays?

>  	if (!f3a->gpio_key_map) {

[ ... ]

[Severity: High]
This is a pre-existing issue, but looking at rmi_f3a_report_button() in
drivers/input/rmi4/rmi_f3a.c:

drivers/input/rmi4/rmi_f3a.c:rmi_f3a_report_button() {
    ...
    bool key_down =3D !(f3a->data_regs[0] & BIT(button));
    ...
}

Since f3a->data_regs is a u8 array, could this incorrectly report the key as
constantly pressed if button >=3D 8? If button >=3D 32, could this result i=
n an
out-of-bounds shift? Since userspace can map a high button index via
EVIOCSKEYCODE and trigger an interrupt, could this be triggered intentional=
ly?

[Severity: High]
This is a pre-existing issue, but looking at rmi_set_attn_data() in
drivers/input/rmi4/rmi_driver.c:

drivers/input/rmi4/rmi_driver.c:rmi_set_attn_data() {
    ...
    fifo_data =3D kmemdup(data, size, GFP_ATOMIC);
    ...
    attn_data.data =3D fifo_data;
    ...
    kfifo_put(&drvdata->attn_fifo, attn_data);
    ...
}

If kfifo_put() fails because the FIFO is full, does this silently leak the
dynamically allocated fifo_data buffer? Could a flood of interrupts lead to
memory exhaustion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260614-b4-disp-81=
8d6bda-v1-0-cf39a3615085@proton.me?part=3D1
