Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBC6370AE6
	for <linux-input@vger.kernel.org>; Sat, 26 Sep 2026 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790455066; cv=none; b=BWIMvdoBFNnixOiKIjDUzRri7N2xq3OgBNIiFoOUf+o9eoHvLwMtS1C2OVu5KwNcZTiI6PCR2cwAc+TFTvmT4tPwPy3bBxWj93qxTBwehYobmNX0QpR9Y3lyQd2yyH/3oPe5IoOvwxOHhOeIXRJ6jYP7Ij8qGWhsQUUufsHwi9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790455066; c=relaxed/simple;
	bh=2rYLYxdXBLVs2RXuanVQdMaxrD/FVpzxKnTvwECaxHs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RgsQgIBHF9RSH2jyFCKHwm+RaeR7OAbKqMOWMWmMwPwbe69MoHvtiz8w7j2FrtneUAGvjAzghKCLwViNL23p+8YDjtYMgmaAEWl0ZWTYb5SeDFn1bPl5QttT+SdlkyvpZd5z8wK5wjpwOsLtzL68nanq60+BxqbAlgBNowDK7EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enIpg6RF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enIpg6RF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FAA1F000FF;
	Sat, 26 Sep 2026 20:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790455064;
	bh=pHl0ZeWvfGqtpu9Xwtz+Tvn3Xip4bNsQe9hhErl+JSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=enIpg6RFGm7VzQkWh+0vDAceRgx7ylqJhAHagIPHwY9X843WWyoySudc2v3J7mQ4/
	 4yIFfEPINJ5lrkARH6nM5vvnCRGjl5WzKLKEL2K5Q6QzYkdrAiFZEKmXPMaY3N6AX+
	 fVRzdv5DSTnTXS0mTysYEiiJ6usXtHRQOSPhcgIqZsdGhATHDmM9bvx8aZAgn2vNGd
	 4ahknRaA8mOac8d70t9nQ8g0PoELaxKcjhx0Mi21mMAQHMHgsppy5lduRMEC5/HPDh
	 908q/bH+NL76gf6DbJ3hYej9PrLMxZiReZmJL5D0xF/3hm9WqE9YziSKnhd5stwONF
	 gTJKR7L/7/L7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: s6sy761 - fix resume ordering and restore
 sensing
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Heidelberg" <david@ixit.cz>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260926-s6sy761-suspend-v2-1-8f00a96ee6e8@ixit.cz>
References: <20260926-s6sy761-suspend-v2-1-8f00a96ee6e8@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 20:37:44 +0000
Message-Id: <20260926203744.82FAA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] input: permanent IRQ disable on s6sy761_power_on() failure
--

commit e5e3e44a0960351c54b4dc02894567b7b504952c
Author: David Heidelberg <david@ixit.cz>

Input: s6sy761 - fix resume ordering and restore sensing

This commit alters the resume ordering to power on the controller before
unmasking the interrupt, addressing an issue where the boot-complete
event was consumed prematurely. It also ensures SENSE_ON is re-sent upon
resume if the input device is already open.

> diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscr=
een/s6sy761.c
> index 0f24a9b730635..899c179fb2d31 100644
> --- a/drivers/input/touchscreen/s6sy761.c
> +++ b/drivers/input/touchscreen/s6sy761.c
> @@ -500,10 +500,22 @@ static int s6sy761_suspend(struct device *dev)
>  static int s6sy761_resume(struct device *dev)
>  {
>  	struct s6sy761_data *sdata =3D dev_get_drvdata(dev);
> +	int err;
> +
> +	err =3D s6sy761_power_on(sdata);
> +	if (err)
> +		return err;

[Severity: Medium]
Will this early return permanently disable the interrupt if power on fails?

If s6sy761_power_on() fails (for example, due to a transient I2C error
during resume), this early return skips enable_irq(). However, the PM core
will still clear the suspended state despite the error.

On the next system suspend cycle, s6sy761_suspend() will run again and call
disable_irq(), which unconditionally increments the IRQ disable depth to 2.
A subsequent successful resume would then call enable_irq() only once,
reducing the depth back to 1, which leaves the IRQ permanently disabled.

Should the error path balance the IRQ state to avoid losing touchscreen
functionality after a transient failure?

> =20
>  	enable_irq(sdata->client->irq);
> =20

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926-s6sy761-su=
spend-v2-1-8f00a96ee6e8@ixit.cz?part=3D1
