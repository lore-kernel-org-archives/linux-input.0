Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1E23D3D0E
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003744; cv=none; b=JbKMESfTQDS6uLFdho1+PDi9EbZYZNiYahawNM8zUw8ZoqsS4NSQ/7ZWNyffRzlWXyQfopWaXTQ2N4XTrF9NtXmJBM3iX8i9ufp0WR1x2mGeXezY6XlTN7mf3w0p5sl3LybZgAym0oGMr0bg3GBUy04cejO7JtYyjGVjzJGxJZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003744; c=relaxed/simple;
	bh=G14W34u3QbN7vFdpbfImnlmABkWiRFfZUDrgvoNe+ho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Px/7IsgNrQL3UFeeRlRFIuWZia3L9xKg8B0NKdNO7x3uUlIa7gqFRPTw+xj8qU4v2WMdDyqJcpsopYivN3s/hJsfLd3AJO+ae9We9SxtwvaDK1A1PUoq6rM0vVznZRAYAlNQ/u5IWWu8paqwI3XJ/DDmCL3v6m9LYYpHSserLh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NT6Pu16r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NT6Pu16r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF521F000E9;
	Mon, 17 Aug 2026 21:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787003737;
	bh=PMI5A2yhnUm6LgkkrWtEQ7rZySsNuSMoxoXchcBz5FE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NT6Pu16rFvjuKw8lxk23RYfyVpl49Ivy+OWJMz28oGzjNg7eGiGNLGUeKGeX8i4Yl
	 oJtmlID7l5LIB3WAG7OjMRoi3mT3QP1/izV7nCuEksjKFVs/6sKzX0Mrb+8M9oCy6r
	 sm0GTpi3OivcxkW9YXQ9aZF9bTptu+KfYjrGnMbxyY2K+GkX43HfavHSG1GUa3pEeQ
	 GEjnbiluK2Sik3hjbtQRuSMelFQXB192WfxsgycWivd8r7ffAQV3OhPaXxKU+4jNgP
	 WeytoU1AEajEmNdJKV9BRnOmYXk/clJP1Uf7jXceTbtjT29DgLukZlSvzPVgDN3BVh
	 rYjNMhu8frx2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] HID: wiimote: turn on the LEDs indicating the
 controller id
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael Passos" <rafael@rcpassos.me>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260817213840.1053216-2-rafael@rcpassos.me>
References: <20260817213840.1053216-1-rafael@rcpassos.me>
 <20260817213840.1053216-2-rafael@rcpassos.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 21:55:37 +0000
Message-Id: <20260817215537.6EF521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Out-of-bounds memory read and IDA leak due to integer truncation o=
f `player_id`.
- [Medium] Unconditional `ida_free(0)` in probe error paths triggers a kern=
el WARN splat.
--

--- Patch [1]: [PATCH v4 1/4] HID: wiimote: turn on the LEDs indicating the=
 controller id ---
commit ee8a446b2fee34f66eb9e5ae9f8fb5e25ff963be
Author: Rafael Passos <rafael@rcpassos.me>

HID: wiimote: turn on the LEDs indicating the controller id

The behavior in a Wii/Wii U console is to have each controller turn on
a different LED indicating the controller id.
This commit implements the same behavior using the ida struct.
Unlike switch controllers, each ID only turns one LED (from 1 to 4).

> diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-cor=
e.c
> index 63c4fa8fbb9b6..acf31d8b6991d 100644
> --- a/drivers/hid/hid-wiimote-core.c
> +++ b/drivers/hid/hid-wiimote-core.c
[ ... ]
> @@ -671,6 +678,12 @@ static void wiimote_modules_load(struct wiimote_data=
 *wdata,
>  	spin_lock_irq(&wdata->state.lock);
>  	wdata->state.devtype =3D devtype;
>  	spin_unlock_irq(&wdata->state.lock);
> +
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock) {
> +		/* after loading modules, set the Player ID LED cycling from 1 to 4*/
> +		wiiproto_req_leds(wdata, player_leds[(wdata->player_id - 1) % 4]);

[Severity: High]
Does this calculation cause an out-of-bounds read if player_id is 0?

Because of C integer promotion rules, if player_id is 0, (0 - 1) % 4
evaluates to -1, which results in reading player_leds[-1].

> +	}
> +
>  	return;
[ ... ]
> @@ -1759,12 +1773,17 @@ static struct wiimote_data *wiimote_create(struct=
 hid_device *hdev)
>  	return wdata;
>  }
> =20
> +/* Global id allocator for wii remotes */
> +static DEFINE_IDA(wiimote_ida);
> +
>  static void wiimote_destroy(struct wiimote_data *wdata)
>  {
>  	unsigned long flags;
> =20
>  	wiidebug_deinit(wdata);
> =20
> +	ida_free(&wiimote_ida, wdata->player_id);
> +

[Severity: Medium]
Will this unconditionally free ID 0 if early probe steps fail?

If an error occurs in wiimote_hid_probe() before an ID is successfully
allocated, the error path jumps to err_free and calls wiimote_destroy().
Because player_id is initialized to 0, calling ida_free(&wiimote_ida, 0)
for an unallocated ID triggers a WARN(1) splat in the IDA core.

[ ... ]
> diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
> index 9c12f63f6dd2d..8e5002f515e24 100644
> --- a/drivers/hid/hid-wiimote.h
> +++ b/drivers/hid/hid-wiimote.h
> @@ -153,6 +153,7 @@ struct wiimote_data {
>  	struct input_dev *mp;
>  	struct timer_list timer;
>  	struct wiimote_debug *debug;
> +	u8 player_id;

[Severity: High]
Can this u8 declaration lead to integer truncation and an IDA leak?

The ida_alloc_min() function returns an unbounded int. If the allocated
ID reaches 256, it will silently truncate to 0 when assigned to this
u8 field.

If truncation occurs, the 0 value will later cause the out-of-bounds read
in wiimote_modules_load() mentioned above. Furthermore, wiimote_destroy()
will pass 0 to ida_free(), permanently leaking the originally allocated ID
(e.g., 256).

> =20
>  	union {
>  		struct input_dev *input;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817213840.1053=
216-1-rafael@rcpassos.me?part=3D1
