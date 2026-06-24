Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AAE32AAB5
	for <linux-input@vger.kernel.org>; Wed, 24 Jun 2026 06:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782280965; cv=none; b=CzM2wjhBqKc2X8fZWTNK8mEh7g8b3Hb1azvN3/xEJKcES7ArJx62fmoOPf9Jgcg0nnT1Jwt6/708yP+qarhnkqsnv+thW39ZvdNDU1d/S48+i9pJ8uKNyLf8zc8szbFeQ2sKEQkvrOvsgSeFXm8iMD3PWLdT6FkAd9hyq+y+Jsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782280965; c=relaxed/simple;
	bh=MCMnYoT7HzOKlP4JiqyZcLs70dBezqYUk7nVJvY4t8U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R+3qmuUMSu3jkL/TCILFKYSrH+FwdWjqEF9aqsSPnWsS4qdhT21pllhcCepzYbKsR/kcwQVAalBkbD7NcPSUy0eHx/479S45e+Iq48x7e7cutWQdT/dS0jgUQacielP2ZY3AN0oQKJwBWc9PTdAoF1jc8Fe3n2xo/QVFQnW5luo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IK+1teOJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IK+1teOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D3C1F000E9;
	Wed, 24 Jun 2026 06:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782280963;
	bh=JMntcpFaFde96lpRlszHXS4nayWoWBjyvQ54fnQRXSk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IK+1teOJY0qhNjlyvSqsOW6uz7PvrnW+96OxrqsVI8O5Zd1p3ftSNV6JJ2osg79I7
	 w3N60mV+ZVbMNnRUoNY8BuN6QcpzT8ricPkbpNz76m4nNt7tQoAL+QS2Xa6VNt0Y6a
	 8RzT9R7D5Qqxp+KwynBj2q1wXGGyxdDuM93AkFaIUsYbUt/7tFWhYz319bHJeGjO/B
	 eb3BJy1BxkE64+uDESGNzQr0is022yjGPbkI7FPBVC9kN02z/cp8P2nIuUVxbzmHZe
	 8NDmEK+u+gEEC+pwm/WOHRA4QP3KUoYG2fIE+Acm38TlG9yNRZdqIdx6FgfCGojNJu
	 lrlHVPQOZ53mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] Input: ensure device is ready before delivering
 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260624055008.2494980-4-dmitry.torokhov@gmail.com>
References: <20260624055008.2494980-1-dmitry.torokhov@gmail.com>
 <20260624055008.2494980-4-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 06:02:43 +0000
Message-Id: <20260624060243.96D3C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing physical feedback teardown in input_close_device causes =
LEDs/sounds to remain stuck ON indefinitely.
--

commit 75d930ba0fffcfc837221baa51848c81d0ba0c9e
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: ensure device is ready before delivering events

This commit introduces a ready flag in the input_dev structure to prevent
events from being delivered to the hardware before the driver's open() meth=
od
successfully completes. It ensures logical state is replayed upon opening,
and synchronizes physical feedback teardown during inhibition.

> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 0a95cbdc467ed..724cc146fc093 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c

[ ... ]

> @@ -661,6 +708,10 @@ void input_close_device(struct input_handle *handle)
>  		if (!--dev->users && !dev->inhibited) {
>  			if (dev->poller)
>  				input_dev_poller_stop(dev->poller);
> +
> +			scoped_guard(spinlock_irq, &dev->event_lock)
> +				dev->ready =3D false;

[Severity: Medium]
Will this leave LEDs and sounds permanently stuck on when a device is close=
d?

In input_inhibit_device(), there is a call to input_dev_toggle(dev, false)
right before setting dev->ready to false.

However, in input_close_device(), dev->ready is cleared without first
toggling the state off.

Since the suspend and poweroff handlers rely on dev->ready to issue events,
could omitting input_dev_toggle() here prevent them from turning off physic=
al
feedback, resulting in a persistent power drain?

> +
>  			if (dev->close)
>  				dev->close(dev);
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624055008.2494=
980-1-dmitry.torokhov@gmail.com?part=3D4
