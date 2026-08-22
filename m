Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047602D7DD7
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 02:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787367275; cv=none; b=ig0gD5DloVIVDXFE1WP7OPturB9takpPQk22m+rD1RaYKMdPCHhd2n+ozPwDqo8s7dlziP/k5UDSk9SfGy9diPEwlBYd88KmhyRrZOg2tZjKGXMps9Tp++vsjP916jT/cNNOMPkoWjaFPj3Zn3JuSVEm3HownXh3OTu68NOL+GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787367275; c=relaxed/simple;
	bh=/XSzK6Uuv35w8pf1ApLbs1RCGh66Zf0nDn8ZTpaHgXE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rxtNghsj9WbGMV4cbtoYxwOFLDCe7ksnqW/qYFvUjuD5Bt3CoqUjzfevHPz8wgd6tB7jDMweRaVNsMy28HqB/bgyqf3qOGN7ygaiv55F1ibhSPgGMkO/0w0xw9E8Ct5m0hE2ShSEvNB/MDErDG47eR1Y6rg7Lq20E7wGpwUoo0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y768Yjrq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y768Yjrq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516521F000E9;
	Sat, 22 Aug 2026 02:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787367273;
	bh=ziSlYzgjYL3Wl7te5dNJdsXnW7nUc02fClECK1JP8s8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y768YjrqJl/Ey0rvZVvTbQrWFsNrq3sltTLcVIhmj0MTnL++hf01nQiC0zE/u0ljX
	 ClWMAOL4Ooum4qra1QKKguO87XGvFQnRAYyDWCh/PJLLG/k5RZg6AsXAHGjVLFVfLx
	 I4kdOgZcAD4SlxUB6TSxRGK4ucrDxDcAoIVK7nVgmR6dfO7FvqZVZNux7En5+VfLMG
	 LCBZwv+k3AHbSj09eDpemjIfEUgHHDerG72KGkjVITTDZKKoLtm2Kw/GBuF4iHbuc8
	 /ayXh+Qah0IhtB29U9hYpu8inkfXViSN4Vg1OGbJEhNklaFevzj2cUDiMjsuQTvpq+
	 bNVbtD1BA75aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/12] Input: xbox_gip - Add wheel support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260822021140.1149546-13-vi@endrift.com>
References: <20260822021140.1149546-1-vi@endrift.com>
 <20260822021140.1149546-13-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 02:54:32 +0000
Message-Id: <20260822025433.516521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Mismatched raw value offset and declared axis bounds for the ABS_W=
HEEL axis.
- [High] Brittle wraparound logic for the TrueForce wheel hardware rotary d=
ial causes erratic backward spikes.
- [Medium] Packet length validation occurs after partially processing event=
s, causing dropped input_sync() calls and stuck events.

Pre-existing issues:
- [High] Dangling pointer left in attachment->input when input_register_dev=
ice() fails, leading to Use-After-Free on subsequent input reports.
- [High] AB-BA Deadlock between gip_receive_fragment and gip_fragment_timeo=
ut workqueue handler.
--

--- Patch [12]: [PATCH v4 12/12] Input: xbox_gip - Add wheel support ---
commit fd5878269a3ac89add6a8a8b7336791b58d87703
Author: Vicki Pfau <vi@endrift.com>

Input: xbox_gip - Add wheel support

This adds preliminary support for racing wheel support in xbox_gip,
exposing them mapped to the newly added axes.

Signed-off-by: Vicki Pfau <vi@endrift.com>

> diff --git a/drivers/input/joystick/gip/gip-wheel.c b/drivers/input/joyst=
ick/gip/gip-wheel.c
> new file mode 100644
> index 0000000000000..333910448c901
> --- /dev/null
> +++ b/drivers/input/joystick/gip/gip-wheel.c

[ ... ]

> +static int gip_handle_wheel_report(struct gip_attachment *attachment,
> +	struct input_dev *input, const uint8_t *bytes, int num_bytes)
> +{
> +	uint8_t connections;
> +	struct gip_wheel_info *info =3D attachment->driver_data;
> +	int rc =3D gip_driver_navigation.handle_input_report(attachment, input,=
 bytes, num_bytes);
> +
> +	if (rc < 0)
> +		return rc;
> +
> +	if (!info)
> +		return -ENODEV;
> +
> +	if (num_bytes < 17)
> +		return -EINVAL;

[Severity: Medium]
If the packet length is less than 17,
gip_driver_navigation.handle_input_report() has already processed the first
2 bytes and pushed button states to the input core buffer.

Returning -EINVAL here causes the caller to exit without calling
input_sync(). Will this leave the parsed button events stuck in the input
buffer, leading to desynchronized state in userspace?

Could we validate the total packet length before calling the base handler to
modify device state?

> +
> +	input_report_abs(input, ABS_WHEEL, get_unaligned_le16(&bytes[2]) - 0x80=
00);

[Severity: High]
In gip_handle_wheel_ll_static_configuration(), max_angle is calculated as
65535 for 16-bit precision, setting the ABS_WHEEL bounds to [-65536, 65535].

Here, the raw 16-bit wheel value (0-65535) is shifted by a hardcoded 0x8000
(32768), resulting in physical values ranging strictly from -32768 to 32767.
Does this restrict the reported values to only cover 50% of the declared
logical bounding box?

Additionally, if the device reports a precision other than 16 bits, will
this hardcoded 0x8000 shift push the values completely outside the bounding
box?

[ ... ]

> +static int gip_handle_trueforce_wheel_report(struct gip_attachment *atta=
chment,
> +	struct input_dev *input, const uint8_t *bytes, int num_bytes)
> +{

[ ... ]

> +	if (dial =3D=3D 0 && state->dial =3D=3D 7)
> +		input_report_rel(input, REL_DIAL, -1);
> +	else if (dial =3D=3D 7 && state->dial =3D=3D 0)
> +		input_report_rel(input, REL_DIAL, 1);
> +	else
> +		input_report_rel(input, REL_DIAL,
> +			state->dial - dial);

[Severity: High]
If the user spins the hardware dial rapidly, the 3-bit value might jump by
more than one step per report (e.g., from 7 to 1).

Will this bypass the single-step wrap checks and fall back to
state->dial - dial (7 - 1 =3D 6), erroneously reporting a massive 6-step
backward jump instead of the actual 2-step forward movement?

Can this be updated to use modular arithmetic (like sign-extending the
3-bit difference) instead of checking for exact neighbor boundaries?

[ ... ]

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> --- a/drivers/input/joystick/gip/gip-core.c
> +++ b/drivers/input/joystick/gip/gip-core.c

[ ... ]

>  int gip_setup_input_device(struct gip_attachment *attachment)
>  {
>  	struct input_dev *input;

[ ... ]

>  	input_set_drvdata(input, attachment);
>  	rcu_assign_pointer(attachment->input, input);
>  	rc =3D input_register_device(input);
>  	if (rc)
>  		goto err_free_device;

[ ... ]

>  err_free_device:
>  	input_free_device(input);
>  	return rc;
>  }

[Severity: High]
This is a pre-existing issue, but in gip_setup_input_device(), the allocated
input_dev is assigned to attachment->input via rcu_assign_pointer().

If input_register_device() fails, we jump to err_free_device and call
input_free_device(input). Does this leave a dangling pointer in
attachment->input that could cause a use-after-free when a subsequent
input report is processed?

[ ... ]

>  static void gip_receive_fragment(struct gip_attachment *attachment,
>  	const uint8_t *bytes, int num_bytes)
>  {

[ ... ]

> 		cancel_delayed_work_sync(&attachment->in_fragment_timeout);

[Severity: High]
This is a pre-existing issue, but I noticed a potential deadlock between
gip_receive_fragment() and gip_fragment_timeout().

gip_receive_message() acquires attachment->lock before calling
gip_receive_fragment(), which then calls
cancel_delayed_work_sync(&attachment->in_fragment_timeout).

However, the delayed work handler, gip_fragment_timeout(), immediately
attempts to acquire attachment->lock:

static void gip_fragment_timeout(struct work_struct *work)
{
        ...
        guard(mutex)(&attachment->lock);
        ...
}

If the delayed work has already started executing on another CPU, will
cancel_delayed_work_sync() block forever waiting for the work to finish,
while the work handler blocks forever waiting for attachment->lock to
be released?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822021140.1149=
546-1-vi@endrift.com?part=3D12
