Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1133231A065
	for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 19:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791659829; cv=none; b=hhLbEDJRRHFe5CV/72t58DEyA2ORDBnQqgNQltKfCiwwDB9WQPOzlW9OVf3dncq+gcvSlb6ZU9y2pXlCgr2evyRr53VPvK554bOw38G7ebQgoXGnEx6K8GZtfinvvXlTe76w/73yrU8dVWQNqAeara0EDD3dCJyNN1Fa/GjqZLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791659829; c=relaxed/simple;
	bh=/BaBWkBYYmy80W99K5hiYcXOqJaC5gdAEAnejno05Rg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=NXctNm8ST/XgoBoFOvlcCFCDMXtBb6W2ijMlXOI5Vi5130iIsDHY6swdfzKiaduQFpqnLYqphfn3ShR9CaUZrcv61Xl1X3Y1aDQWTWNbzbpjrBZrtrV3uYXG6veEpGnx1vRPd2pM5HbMKWipcSABJy9rAyVgIBdVQKFpu8i2JL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuXAR9bd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuXAR9bd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546761F000FF;
	Sat, 10 Oct 2026 19:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791659827;
	bh=nbuJyN8GRiy0zvQuX4ZQmWuwTaFXcQkMEvWtotiVtL4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HuXAR9bdhl7K+rTo+ABJ5JGXy1P8RzZr5vgYY/UJPyKYM0BHG5wEICtjbjFBAARSq
	 rQRTUN17T8o5Ys23+xv/vM6VbZxNgAfMRAjcE5JpPfwwP3WxfpU2df8wURmnWP/FZY
	 qJYYrySFLpQWIO2/t7PPHKE3uldWpLAg8h2pEuHmxraixMta887708qNc/OuqfC5UJ
	 EklZ5paihiahlv5y9ANNAddrXXSVJx5TBQLCC9D1wkWxpFbertPm1ixz5fDb3yBoDi
	 JaYkBX/QleeI6Ci/Wn+oR/yaUH1AfK3cN9zjb67uuGHNRiePJ9xXuPwY2zkGAQQMuE
	 3Ef73kGrspBEQ==
Message-ID: <sashiko-outbox-166847@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] Input: discard pre-registration events before
 attaching handlers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karlos Abel" <kabel@voidship.net>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261010191033.23577-2-kabel@voidship.net>
References: <20261010191033.23577-1-kabel@voidship.net>
 <20261010191033.23577-2-kabel@voidship.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 19:17:06 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] input: mixed goto-based error cleanup and scope-based guards
--

commit 4198890f3caadca9048a77f9b7d142bbae15ab35
Author: Karlos Abel <kabel@voidship.net>

Input: discard pre-registration events before attaching handlers

This commit prevents replaying pre-registration events when an input handler
connects. It does this by clearing the pending event count and monotonic
timestamp under event_lock before attaching handlers.

> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 01c91fec9b7eb..d59d62caa2f92 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -2445,6 +2445,12 @@ int input_register_device(struct input_dev *dev)
> =20
>  	error =3D -EINTR;
>  	scoped_cond_guard(mutex_intr, goto err_device_del, &input_mutex) {
> +		/* Keep seeded state, but do not replay pre-registration events. */
> +		scoped_guard(spinlock_irq, &dev->event_lock) {
> +			dev->num_vals =3D 0;
> +			dev->timestamp[INPUT_CLK_MONO] =3D ktime_set(0, 0);
> +		}
> +

[Severity: Low]
Does this mix scope-based cleanup with goto-based error handling?

The kernel cleanup guidelines in include/linux/cleanup.h and the subsystem
rules state that we should either convert all resources requiring a "goto"
cleanup to scope-based cleanup, or convert none of them. Mixing both in the
same function creates confusing ownership semantics and increases the risk
of double-free or resource leak bugs.

Because input_register_device() uses manual goto labels (err_device_del,
err_devres_free) for its failure paths, does adding new scope-based cleanup
macros like scoped_guard() here violate the cleanup guidelines?

>  		list_add_tail(&dev->node, &input_dev_list);
> =20
>  		list_for_each_entry(handler, &input_handler_list, node)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010191033.2357=
7-1-kabel@voidship.net?part=3D1
