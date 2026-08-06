Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3310175A5
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 06:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996105; cv=none; b=YMuBSGfiiQPDFrxXTql+2Ss2dqVfNNLzNmC2JLvIp+PbnI2ElNMlUn147dWDfa3qGz4vlZjqQaRZdg24je6vCmSlLrGcap3Y3BVnbibeyTR/cBU15Us6B2cWoztZX7MZrNaIDI3tteVHQkKrHeFaQljb9JkSwYV++yaFA380GnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996105; c=relaxed/simple;
	bh=fb8vLzrJwZzUSnBUFmKQUgHXCSWvVbkvWzZ8OBxvymE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HZ8LrRGZB6n6ExLcgyar9A1gj6baCxM6rR+oncflJPYg6vhQpmCCSByu30FGpxz+EBJgVb5SicV9L3PljE1L2X6dCmJtyP/qsupUhyXmeD3No6iBrkp4VslTGwUjmxxovcyQatadrZZZ4s5t7zaLoVCsIBaWy3oNIjNntDMrRUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4UBtwFY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4UBtwFY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C23E1F000E9;
	Thu,  6 Aug 2026 06:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785996104;
	bh=5+fEYmeF/bXRjsXjJrhdW3npyEj6Q6qYSZPeZmGTUlQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K4UBtwFYwInf26DoaEhB+TGx4YfnVQeckD64rON6PdveASYIXojmFlhk2R4bvzGIM
	 cRzUBvZxgIPkJc5nE1+pS1aAhwmq/yd+V33Qy/OnR8NTBMQETx6+I77x+9f3XEzW9T
	 nRoxEVtf1JGjRS103OHIV0ww1D6yB+EhmGJ4IK1viLRm8JiOHqMsSh46lIdss8HDEW
	 jOA/yW61PA1c6BrxdjiKvAXifbHoY01plwAAGv9J+ZuVF0pkfhKsAFjp7yTmqluuVw
	 KAjRwGpGAeIHPAl5NOrfhZEAbWQMYyBIjXod09GAOz6Cbeny50y5Yp8qw4MpGZAJ8C
	 yTEKzA+3IP1ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: atkbd - factor out atkbd_recreate_device()
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <anQg6dtUwQ1Fx4hM@google.com>
References: <anQg6dtUwQ1Fx4hM@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 06:01:43 +0000
Message-Id: <20260806060144.4C23E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The error recovery path in atkbd_recreate_device() corrupts the ac=
tive input device by clearing its EV_SYN capability, rendering the keyboard=
 completely unresponsive.
--

--- Patch [1]: [PATCH] Input: atkbd - factor out atkbd_recreate_device() he=
lper ---
commit 90c8b25166b08db625d55de3789ce58cd2cfc65c
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: atkbd - factor out atkbd_recreate_device() helper

This commit factors out the common logic for unregistering the old input
device, allocating a new one, updating state, and registering the new device
into a new atkbd_recreate_device() helper to reduce code duplication.

> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkb=
d.c
> index 8cb4dc6fb1658..cc061bd0761f4 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -1452,6 +1452,47 @@ static ssize_t atkbd_attr_set_helper(struct device=
 *dev, const char *buf, size_t

[ ... ]

> +static int atkbd_recreate_device(struct atkbd *atkbd,
> +				 unsigned char new_set, bool new_extra)
> +{
> +	struct input_dev *new_dev, *old_dev =3D atkbd->dev;
> +	bool old_extra =3D atkbd->extra;
> +	u8 old_set =3D atkbd->set;
> +	int err;

[ ... ]

> +	err =3D input_register_device(atkbd->dev);
> +	if (err) {
> +		input_free_device(new_dev);
> +
> +		atkbd->dev =3D old_dev;
> +		atkbd->set =3D atkbd_select_set(atkbd, old_set, old_extra);
> +		atkbd_set_keycode_table(atkbd);
> +		atkbd_set_device_attrs(atkbd);

[Severity: High]
This is a pre-existing issue, but does calling atkbd_set_device_attrs() on
the already-registered old_dev corrupt its capabilities during this error
recovery path?

Looking at atkbd_set_device_attrs(), it initializes capabilities using a
direct assignment:

    input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
        BIT_MASK(EV_MSC);

This unconditionally clears bit 0 (EV_SYN). For a newly allocated device
this is fine, as input_register_device() adds EV_SYN later.

However, when called on the active old_dev after input_register_device()
fails, it strips the EV_SYN capability. Without EV_SYN, does the input core
drop all synchronization events (SYN_REPORT), leaving key events stuck in
client buffers and rendering the keyboard unresponsive?

> +
> +		return err;
> +	}
> +
> +	input_unregister_device(old_dev);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/anQg6dtUwQ1Fx4hM@go=
ogle.com?part=3D1
