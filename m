Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF1E3093DD;
	Fri, 12 Jun 2026 07:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249704; cv=none; b=qrHW1GUfRnILztAMm2P4W93cfH+ZKDl2wRP/h1UcGEemSXmhkln4NofiatuZh4C8XUhhjqZgMUwuskXTRMu2dg1ZONWJ5FVuMa9b2ORcADw/nn0ixWG3Knull/gQDvb6sGjN7q26inrQ3Npjt9q5THHLizfsFU92D0QvKB7BJ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249704; c=relaxed/simple;
	bh=c3kL5s24IjZdqNAkEyQW8HyKyNN1XCWHZ6SiVE5iauw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LTF4i9Ub40WdTPP90G2jtBLos7eCD5bhDmErDxQSVvl2kc9M3jLL3ghr/j6SHOSZlzO3GTbDdC7Y9snJv0h4cPqc1Mw/cAtwWHXWQxOCMBV5pTyEUYGyIZfQlu/7EocZX3WmY1mO+bOkI7S/V44YZoMUI8KdDQst2wmVKgjWPac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfF1Qlsg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfF1Qlsg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B73E1F000E9;
	Fri, 12 Jun 2026 07:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781249703;
	bh=PqFUaAzicDXnwo7BPdGxRkhbTJrXlB/E2E1lcj0+JVw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IfF1QlsgGQq1cn0kNxMyAFxZi1A8x2OF0eaeVdIWeaM67Y8NkMiHHRLG3AmLid3OM
	 kypCljJNN2flhxrOpjoZeqK5AKIqttVUBAjbqj1uLICUiTF08LU0Oz6I/PEKIf3yl0
	 FLjEOcfw5SDJzUBStpcjmPUpkWbmWmJCk0sgDFopEiBblToQ1x+Hx0KpTZh4Kq/wJR
	 /9BoYkS/+2KkLY8cfDSfNTOceYqOx5hlw7Ht2nCjospi6LwD3kfxyNeW27gyBL3fLr
	 XYOYi6iKwxj6cSjgWPAAUIJBtUD0hYf0A4TKG4rpao9tLsBh8AKMq6h2mKFJLNuwsH
	 tuG5cedAuMrcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/9] Input: cap11xx - refactor code for better
 CAP1114 support.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jun Yan" <jerrysteve1101@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260612072237.1177304-8-jerrysteve1101@gmail.com>
References: <20260612072237.1177304-8-jerrysteve1101@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 07:35:02 +0000
Message-Id: <20260612073503.1B73E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The input device is registered and exposed to userspace before its=
 threaded IRQ handler is requested, creating a race window where events cou=
ld be lost or unhandled.
--

commit d2a53f68ed5e5f2311cb5dfaea4bd95be2449ab4
Author: Jun Yan <jerrysteve1101@gmail.com>

Input: cap11xx - refactor code for better CAP1114 support.

Extend cap11xx_hw_model structure to support CAP1114 with
different register offsets and hardware characteristics.

> diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/ca=
p11xx.c
> index 75746a8a22332..d45bb231d7a1f 100644
> --- a/drivers/input/keyboard/cap11xx.c
> +++ b/drivers/input/keyboard/cap11xx.c
[ ... ]
> @@ -554,41 +564,64 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c=
_client)
>  }

[Severity: High]
This isn't a bug introduced by this patch, but looking at cap11xx_i2c_probe=
(),
the input device is registered and exposed to userspace before its threaded
IRQ handler is requested:

	error =3D input_register_device(priv->idev);
	if (error)
		return error;

	error =3D devm_request_threaded_irq(dev, i2c_client->irq,
					  NULL, cap11xx_thread_func,
					  IRQF_ONESHOT, dev_name(dev), priv);

Since input_register_device() makes the device visible to userspace, proces=
ses
like udev can immediately open the device. This invokes cap11xx_input_open()
and wakes the hardware from deep sleep.

If a hardware interrupt occurs before devm_request_threaded_irq() registers
the handler, could this unhandled interrupt cause an interrupt storm? The
kernel might then disable the IRQ line ('nobody cared'), rendering the touch
controller permanently inoperable until the module is reloaded or the system
reboots.

Should the IRQ handler be requested before the device is registered?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612072237.1177=
304-1-jerrysteve1101@gmail.com?part=3D7
