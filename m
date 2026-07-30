Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D56F38B14D
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 03:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785382922; cv=none; b=MQhnWrAr1QW6rK9HSpx39rUSqc/n6k6hcNbJJphLiOiR7oNNbs8jekg5qeC9Dgk8W52hfZfVTJLH0i2ro/d9Ij6z0HX2RiINuowbncFcWXwOXXz7v+sIOcj3kGO77UNgFrCvLCEuJkxDLUJSrRmITa69cdsvC5R8onhqRYySHoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785382922; c=relaxed/simple;
	bh=DvMVvC+WFiJH6mmBncfeATfHxnJqA/3rs++ucQRnk3U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=plWXcoWhTRu+/nkHifyDT4kOtYysSPh3qX1B49yFgIbfe2YlLDozxRuTVNcV/G6hx7a/5IPf1sA4cFoXd8ZMWYVUr1HYyjs2AjMtlx6LzBpv8mgDn3x+05NtbMAkSngdFN4kR0fPGBnL0LeiyqgOn6+le8Hg90JR4NydQznqDnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8M5XO2Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8M5XO2Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC90D1F000E9;
	Thu, 30 Jul 2026 03:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785382920;
	bh=WZgosDnk7WmKvUZBJKY7tq1ZcX0Lc1Ig210ZQ+XWtuk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I8M5XO2QdoPmogFZ/k6O2mzg6RbMfI4yYLy/C8bK6nJqsg4EO1bZ0fdUSSlzehkcV
	 u/7jp+vawEOot0UrHO0tF6w1oGS8BZ3RkCGqu1WRwZO+kELK0wZTEHfwPTNOvE+pUP
	 HXC9yCyW6BXY1uWEpcUD+BW/iyu0YSwzpJZlm8h3zTOY23quWkuUKOgmpImEBc8+3u
	 fB85bRSEVe2lDW6t7YdwcG+JXT9rSt6vn2YH/msCzgXwem6l8W0w9UoUH7M5EL0+IT
	 f461cIhR8Cq3PXgybYJhfcAA11TFT197fGsw98Htm3UqyNIyFV1jdyMbISiHKeitJ5
	 thzoUuL1y66Kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: nintendo: stop device IO before hid_hw_stop on
 probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiangshan Yi" <yijiangshan@kylinos.cn>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260730031927.25444-1-yijiangshan@kylinos.cn>
References: <20260730031927.25444-1-yijiangshan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 03:42:00 +0000
Message-Id: <20260730034200.AC90D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver registers the input device before fully initializing it=
s capabilities and force-feedback callbacks, violating subsystem rules and =
introducing a race condition that can lead to a NULL pointer dereference an=
d broken userspace device recognition.
--

--- Patch [1]: [PATCH v2] HID: nintendo: stop device IO before hid_hw_stop =
on probe failure ---
commit 175b2ac9211bb7f8a122c8a3e3d05eeac1ea8dac
Author: Jiangshan Yi <yijiangshan@kylinos.cn>

HID: nintendo: stop device IO before hid_hw_stop on probe failure

nintendo_hid_probe() calls hid_device_io_start() before joycon_init()
and joycon_leds_create().  If either fails, the error path jumps to
err_close which calls hid_hw_close()/hid_hw_stop() without first calling
hid_device_io_stop().

hid_hw_stop() does not stop device IO, so hid_input_report() may still
run and access driver data that is being torn down, resulting in a
use-after-free.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index e7302ec01ff1f..0db5535288263 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
[ ... ]
> @@ -2766,7 +2766,8 @@ static int nintendo_hid_probe(struct hid_device *hd=
ev,
> =20
>  err_ida:
>  	ida_free(&nintendo_player_id_allocator, ctlr->player_id);
> -err_close:
> +err_io_stop:
> +	hid_device_io_stop(hdev);
>  	hid_hw_close(hdev);
>  err_stop:
>  	hid_hw_stop(hdev);

[Severity: High]
This is a pre-existing issue, but I noticed a potential race condition in h=
ow
the input device is registered in joycon_input_create(), which is called=20
slightly further down in nintendo_hid_probe().

In joycon_input_create(), input_register_device() is called before the devi=
ce=20
capabilities and force-feedback callbacks are fully configured:

    ret =3D input_register_device(ctlr->input);
    if (ret)
        return ret;

    if (joycon_type_is_right_joycon(ctlr)) {
        joycon_config_right_stick(ctlr->input);
...
    if (joycon_has_rumble(ctlr))
        joycon_config_rumble(ctlr);

And in joycon_config_rumble():

    input_set_capability(ctlr->input, EV_FF, FF_RUMBLE);
    input_ff_create_memless(ctlr->input, NULL, joycon_play_effect);

Because input_register_device() makes the device visible to userspace=20
immediately, couldn't a userspace process open the device and trigger the=20
EVIOCSFF ioctl concurrently?

If evdev calls input_ff_upload() while joycon_config_rumble() is running, it
might observe the EV_FF bit but dereference an uninitialized dev->ff,
potentially causing a NULL pointer dereference. Additionally, registering
before setting capabilities means the initial udev event might lack button
and axis information, which could cause input managers like Wayland to
ignore the device.

Should the call to input_register_device() be moved to the end of=20
joycon_input_create() after all capabilities and force-feedback are=20
initialized?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730031927.2544=
4-1-yijiangshan@kylinos.cn?part=3D1
