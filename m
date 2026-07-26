Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162F737BE84
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785061696; cv=none; b=D3QZTPn9ewkCIFfZKRLXhbXC/lFZ9AHyBg/+Wgnqi2/4w9QJU0kOEGFUj/FSZtPeAAJ6jwg+7q6hcefQ3f1jme+Neru9Mmjwl5jCV/QvvdHWt1MPBwTLiuXSCeE8Y1knxge38SMiHLE5e6F6A9h1+37/sy3/zf3dZZ1xNEmw6X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785061696; c=relaxed/simple;
	bh=JM5BKgr5z+1BzalGuEXJPrcb0cnHsDxEoefhzWC2g60=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XY+luh0wEshExiKirhvtGv9/XYuuJ1kS8aE3Fe00kcYiF7g2mCM0imQMKTb7kZbJVWX1FY0sE+m47KMIcRi3ykKVYSY/yNJH7HRtXjoMaMk1djWnH9htebRjxChO8eSVFNJg17MNwh4MTADdUkeZssyKKatrOoCgtHTy8+DI6lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSmtSS0H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSmtSS0H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723DB1F000E9;
	Sun, 26 Jul 2026 10:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785061694;
	bh=BgpYWjiCxQmx44t5Nd3YrCQzu/SnTFX/eTIcKCC8L2k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FSmtSS0HcH9Ow7qOSlaDZx1g1THBl4FniG2tJYxu+GLhXjvjfAQikPr7leAlBgkMo
	 JUsR59qyLnIbDVg1Mqws7GIN9M1WOL+KdEKWD/2KOyol8Kl2Nh5YUImEJHNgQo4L6h
	 cVYTdzQNAxGLJyzYf3mTSRZyCWKgG1E7XPjLdl4m9e3uITtpLfZqwCIeuyZeWkfkd2
	 0ZVFxbb1XUm3GZ+f8QKHjJgM0H54hXHyNkf4KHlGWRSkiBB+nltV+xXdF7N47itV5z
	 rHZ8oBcpXizshoVkxyuLhL6iWPGB0Ka/nV2TzijtFVwj74d+q/Q893VuOvok+RFc8N
	 q5rZAbl3YM1Gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/13] gpio: eic-sprd: use
 devm_atomic_notifier_chain_register()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eliav Farber" <farbere@amazon.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260726101739.33170-12-farbere@amazon.com>
References: <20260726101739.33170-1-farbere@amazon.com>
 <20260726101739.33170-12-farbere@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 10:28:14 +0000
Message-Id: <20260726102814.723DB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbinding one EIC sub-module will break interrupts for all other a=
ctive sub-modules sharing the same parent IRQ.
--

--- Patch [11]: [PATCH v4 11/13] gpio: eic-sprd: use devm_atomic_notifier_c=
hain_register() ---
commit 55c8bafe72677fc98fb136d26d8a1306172a3b1f
Author: Eliav Farber <farbere@amazon.com>

gpio: eic-sprd: use devm_atomic_notifier_chain_register()

This commit replaces the atomic_notifier_chain_register() and
devm_add_action_or_reset() pattern with a single call to
devm_atomic_notifier_chain_register(). This removes the need for the custom
sprd_eic_unregister_notifier() callback.

> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index 3b7ebcf12fe7f..86eb9624d38ac 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c

[ ... ]

> @@ -690,14 +683,8 @@ static int sprd_eic_probe(struct platform_device *pd=
ev)

[Severity: High]
This is a pre-existing issue, but I noticed something about how the parent
interrupt is configured earlier in sprd_eic_probe().

The driver sets up the shared parent interrupt line as a non-shared chained
handler before registering the gpiochip:

    irq->parent_handler =3D sprd_eic_irq_handler;

Since the SPRD EIC hardware exposes up to 4 sub-modules that share the same
parent interrupt line, does unbinding one of these sub-modules break
interrupts for all other active sub-modules?

When a sub-module is unbound via sysfs or fails a late probe step, its
devres cleanup invokes gpiochip_remove(). This unconditionally calls
irq_set_chained_handler_and_data(parent_irq, NULL, NULL) which clears the
shared chained handler completely.

Will this result in a silent loss of GPIO interrupt functionality for the
remaining active EIC sub-modules sharing that parent IRQ?

>  	}
> =20
>  	sprd_eic->irq_nb.notifier_call =3D sprd_eic_irq_notify;
> -	ret =3D atomic_notifier_chain_register(&sprd_eic_irq_notifier,
> -					     &sprd_eic->irq_nb);
> -	if (ret)
> -		return dev_err_probe(dev, ret,
> -				     "Failed to register with the interrupt notifier");
> -
> -	return devm_add_action_or_reset(dev, sprd_eic_unregister_notifier,
> -					&sprd_eic->irq_nb);
> +	return devm_atomic_notifier_chain_register(dev, &sprd_eic_irq_notifier,
> +						   &sprd_eic->irq_nb);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726101739.3317=
0-1-farbere@amazon.com?part=3D11
