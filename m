Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BCB41C2FE
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575084; cv=none; b=lrN8K4d4IcP1lWMymrwWVhax2vP++9Sa7ngitkwkVK6AL7lmRmBLMgZOX4N7Cb0Mubts/7FBfJD03wWZcqQDC7rCduE6dBKqOQinqt1Znl3MSOtuaxedSB2MUrhvqyP7KTB66JpKw3snFBOSHjUQhqvJRDLe6Iqst19ohDg2Qq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575084; c=relaxed/simple;
	bh=l+5nq1ikleretnZwHPxgNwXbeu0nrXxOrTIWd8D/ZS8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u1GDAuqoJvPPg7e+rlSL2abvs/SxyucTm1EBpzlqfXfGTj3e5M5e64NbcXZvGwNpE403KbH2SJzfB2MkcpVbMLITeU+yC/1w3A0O/b81KAQVLkM0GZZQTUsaVNPQxdiH9ro/sxBJgenTaWWO1j5zxY1Z56tmID2lwzo1pEXj1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2oRWdtC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2oRWdtC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6751F00A3A;
	Mon, 24 Aug 2026 12:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787575082;
	bh=qo6J22MRD8V95PWR6pC3vyCZdqHDGmHCWIJrOlT1Lp4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F2oRWdtCI781SNCJzE6WA/2JblB/KtF3Q7l1GjF0IUuQmjhdwp7OHYiFvPWfN+MHZ
	 vCTP1S5iNt1EyFAE/qbU65IlwAklRlwy9VtVQy/tbILdwi/k4Z6ZD6EnWd4vrrGlRF
	 YOfqOzuax38ZiqnZg6s8xmcE91hKLjd0Ijy5vVSf/qu2pFVxwduVTkL6npcZY7o1Mq
	 E6Xh7eGibyoIf2nlz8/CrTuVYo5rGU0JTGFTi5BcFtcV4k83uTAZX5zUFVv4vc2JAK
	 5yW+0XHeP0sT1x3ggfk4ihOsczs885lRSLjKJidCVCqvjCDcXURTLp+jYJEnRl6BY3
	 WvMJEdXwYpbHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] Input: synaptics-rmi4 - reject a PDT that grows
 between scans
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Jie Law" <98lawweijie@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260824122733.76321-3-98lawweijie@gmail.com>
References: <20260824122733.76321-1-98lawweijie@gmail.com>
 <20260824122733.76321-3-98lawweijie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 12:38:01 +0000
Message-Id: <20260824123802.0D6751F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Memory leak and kobject lifecycle violation on the error path in `=
rmi_create_function()`.
--

--- Patch [2]: [PATCH v2 2/2] Input: synaptics-rmi4 - reject a PDT that gro=
ws between scans ---
commit 846b91538dc6072de55b69393a47494582f0c196
Author: Wei Jie Law <98lawweijie@gmail.com>

Input: synaptics-rmi4 - reject a PDT that grows between scans

This commit adds a validation check in rmi_create_function() to reject
devices whose interrupt counts grow between PDT scans, preventing an
out-of-bounds bitmap write. When the check fails, it frees the function
using kfree().

> The rejection happens before rmi_register_function(), i.e. before
> device_initialize() has touched fn->dev, so the partially built function
> is disposed of with kfree(): put_device() on a kobject that was never
> initialised warns and then leaves the object behind, because the
> saturated refcount stops the release from ever running.

[Severity: High]
Is this assumption accurate? Looking at rmi_alloc_function() which is called
right at the beginning of rmi_create_function(), it appears
device_initialize() is actually called during allocation:

drivers/input/rmi4/rmi_bus.c:rmi_alloc_function() {
    ...
    device_initialize(&fn->dev);
    dev_set_name(&fn->dev, "%s.fn%02x", dev_name(&rmi_dev->dev), id);
    ...
}

> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_dri=
ver.c
> index 5d49a9021c7d0..8dcf088a7a819 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c

[ ... ]

> @@ -899,6 +899,24 @@ static int rmi_create_function(struct rmi_device *rm=
i_dev,
>  	fn->irq_pos =3D *current_irq_count;
>  	*current_irq_count +=3D fn->num_of_irqs;
> =20
> +	/*
> +	 * irq_mask[] was sized from the interrupt count collected by the
> +	 * earlier rmi_count_irqs() scan of the PDT.  Nothing guarantees that
> +	 * this scan sees the same table -- the PDT is read back from the
> +	 * device every time -- so a device that grows its interrupt counts
> +	 * between the two scans would push these set_bit() calls past the end
> +	 * of the flexible array.  Refuse the function instead.
> +	 */
> +	if (fn->num_of_irqs > RMI_FN_MAX_IRQS ||
> +	    fn->irq_pos + fn->num_of_irqs > data->irq_count) {
> +		dev_err(dev,
> +			"F%02X: interrupt count changed between PDT scans (pos %u + %u > %d)\=
n",
> +			pdt->function_number, fn->irq_pos, fn->num_of_irqs,
> +			data->irq_count);
> +		kfree(fn);

[Severity: High]
Does this kfree() bypass the kobject lifecycle rules and cause a memory lea=
k?

Since rmi_alloc_function() already initialized the kobject and dynamically
allocated the device name string via dev_set_name(), shouldn't we use
put_device(&fn->dev) here instead of kfree()?

Calling kfree() directly skips kobject_cleanup(), which permanently leaks
the heap-allocated name string and violates the driver core requirement that
initialized kobjects must be freed via their release method.

> +		return -EINVAL;
> +	}
> +
>  	for (i =3D 0; i < fn->num_of_irqs; i++)
>  		set_bit(fn->irq_pos + i, fn->irq_mask);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824122733.7632=
1-1-98lawweijie@gmail.com?part=3D2
