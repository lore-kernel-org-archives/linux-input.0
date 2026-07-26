Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650C12110E
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 05:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785042411; cv=none; b=cQyg/cGwRDme2ovnLipWJzubA4GZz80wPuCMiqkyoJOMOq5RNCBZ1REF+QnA9WL2XA41D2rXt108fTvIPA5g4GYo3W5q5NGMYjZEEUFpJ/ift4QVu2uuUJEe5vuT4aJq110Ld0jiudaEsWolH9kRZkT7oB8BaCN/ElXgoReSkYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785042411; c=relaxed/simple;
	bh=GGSGAMRdPl1T94SvH2fnW/QYeO4JnXsUKDUlunHYoLM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rloQOy66+ApvaXnUNShYkU98BM3JIMWsqztuNLX4Fe1TjRvoodUo36mP7xc4EC5Hz/j9D1RfMfmJnKubS8AV1uf4Xc3nutNXYPaHAGo1KKStW3I6N0lNMV0nMrHYyziqpTETwT2cfgREIkl3xlUZ1O8u9gQmH/CK9OT2rkkUOvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqeLe7Uk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqeLe7Uk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91DA1F000E9;
	Sun, 26 Jul 2026 05:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785042410;
	bh=3A7FBRauqIbfLjzd7Bt3dwlXG7DkU9P9OpKh5dTrM0A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iqeLe7UkUF8ro2LCkI7fi+yKYkqEKNxr7qFs3mTkCwbODJnfpYStYXtNE0zy4jtUe
	 ZKGMEuVXFSF5FbJ8QJN7NtWfxmRbBQCIr0gnOY4Fmf9ldsVibU6vNXu+pGvDjPA5gK
	 vHIpfkZp2PyJQ51/k8KlN+qVy0J3PAlHDUwz8VODXNjZ6j7ZJUBoXz+5Dn7iclDAnz
	 sBQ1mN4GmxfyLp6IXNDaNY3e539b6Zakff49X6xFcq6qsgio7QosNYyIku8dAJVA5T
	 KObsWtdAAyvspKHoVJaa2qjvnjkEdxz26CTJZyL9rfEXZWfkUD6JUHb0mx/JQDcPlS
	 ESpPpZWsHV5Uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/12] notifier: add device-managed registration APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eliav Farber" <farbere@amazon.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260726045706.8169-2-farbere@amazon.com>
References: <20260726045706.8169-1-farbere@amazon.com>
 <20260726045706.8169-2-farbere@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 05:06:49 +0000
Message-Id: <20260726050649.B91DA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] devm_raw_notifier_chain_register structurally violates raw notifie=
r locking contracts, causing lockless unregistration and list corruption.
- [High] devm_raw_notifier_chain_register uses GFP_KERNEL inside caller-pro=
vided locking, causing "sleeping in atomic context" panics if the lock is a=
 spinlock.
--

--- Patch [1]: [PATCH v2 01/12] notifier: add device-managed registration A=
PIs ---
commit c5d9a7bbfeb086f5fff3b21d687d1da2f68205b3
Author: Eliav Farber <farbere@amazon.com>

notifier: add device-managed registration APIs

Add device-managed registration functions for atomic, blocking, and raw
notifier chains. These automatically unregister the notifier when the device
is unbound, reducing driver boilerplate.

> diff --git a/kernel/notifier.c b/kernel/notifier.c
> index 2f9fe7c30287f..d8c82b237586e 100644
> --- a/kernel/notifier.c
> +++ b/kernel/notifier.c

[ ... ]

> +struct raw_notifier_chain_devres {
> +	struct raw_notifier_head *nh;
> +	struct notifier_block *nb;
> +};
> +
> +static void devm_raw_notifier_chain_unregister(struct device *dev, void =
*res)
> +{
> +	struct raw_notifier_chain_devres *dr =3D res;
> +
> +	raw_notifier_chain_unregister(dr->nh, dr->nb);

[Severity: High]
How is locking handled during device unbind? The documentation for raw noti=
fiers
states that all locking must be provided by the caller. When the devres
framework automatically invokes devm_raw_notifier_chain_unregister() during
teardown, it calls raw_notifier_chain_unregister() completely locklessly.

Since there is no mechanism for this callback to acquire the caller's
subsystem-specific lock, will this structural flaw force concurrent,
unsynchronized list modifications and corrupt the notifier chain?

> +}
> +
> +/**
> + *	devm_raw_notifier_chain_register - Device-managed raw notifier regist=
ration
> + *	@dev: Device to tie the notifier lifetime to
> + *	@nh: Pointer to head of the raw notifier chain
> + *	@n: New entry in notifier chain
> + *
> + *	Adds a notifier to a raw notifier chain and registers a cleanup
> + *	action to automatically unregister it when @dev is unbound.
> + *	All locking must be provided by the caller.
> + *
> + *	Return:
> + *	0 on success, negative errno on error.
> + */
> +int devm_raw_notifier_chain_register(struct device *dev,
> +				     struct raw_notifier_head *nh,
> +				     struct notifier_block *n)
> +{
> +	struct raw_notifier_chain_devres *dr;
> +	int ret;
> +
> +	dr =3D devres_alloc(devm_raw_notifier_chain_unregister,
> +			  sizeof(*dr), GFP_KERNEL);

[Severity: High]
Will this devres_alloc() call trigger a scheduling while atomic bug? To saf=
ely
use devm_raw_notifier_chain_register() without racing, the caller must acqu=
ire
their chain-protecting lock before calling the function.

If this lock is a spinlock, which is standard for raw notifiers used in
atomic contexts, the unconditional GFP_KERNEL allocation here will sleep
while the caller holds a spinlock.

> +	if (!dr)
> +		return -ENOMEM;
> +
> +	ret =3D raw_notifier_chain_register(nh, n);
> +	if (ret) {
> +		devres_free(dr);
> +		return ret;
> +	}
> +
> +	dr->nh =3D nh;
> +	dr->nb =3D n;
> +	devres_add(dev, dr);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(devm_raw_notifier_chain_register);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726045706.8169=
-1-farbere@amazon.com?part=3D1
