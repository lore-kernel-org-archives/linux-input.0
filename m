Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E60390C8C
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 07:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198430; cv=none; b=QDBdiWcd3OERjzfuF7WsUePUFrRRojb/tHCrnVahBKl6tRAIpp+dsfDAGk8DnsFzjd7p4NDJiooiSaVx+EQ6KvuNRexBc6Rl5Sfs30woDSaioen72xc5CDVPvvhGPUaFu+oluk9p/kHJKC7lDnZ3DTFKKcAoM8VTxbV1E5xDziE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198430; c=relaxed/simple;
	bh=aXJrV2fi5QZ0DS9AC62JkAfwprQQCJK6rbZF+1VunXU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hFyCExMf94kEWuKIdN1fJOTWwrrtUozXbJw9UbPJXIrFvfdP9rty4Ur9rsTxfXfrb2JMREkjyL1Yr1B6M710oWJXcFXzoxJJFNhRPw4Tk0bIkaN6GaKbZnnoCeBc+wouvk2heMU+8eRV/bphdobK21OcIeIwvBn0nmKgN3nTWhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8FAIQ2Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8FAIQ2Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F691F000E9;
	Tue, 23 Jun 2026 07:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782198428;
	bh=a7eB8EpqeBDUNs9uPoyfIsDVqKB0E3tOqLxhgU/AqSg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g8FAIQ2Qz+rApWB2XjLzI1dh8A9Kx30Uw64cO4rRGzdSrdOeSTRwr2/vcgQEcC8lR
	 MGSoqPi/2TuZ/062MPVVFD/2rARnoBpomTdZ4jlN4P2E5/i38PuwABcFxtAvy3RaB3
	 FlnwzAFNrNinIq8AdJBfKuv+JX1mbRlhc3tJAg0gP2aGiRTnzAnGkYf5ri8MXfLAOq
	 YnqS5qWTyppGOIoOEfk+9XdFjDZjX8pZwKbEagDtAEYVsc+Bv5SXR92GLnKv0Ii74A
	 wJV0buldvX0ktOL8tD3vR9SFyraKwKda164tijrf4qtujQC+bmw6RH7kG+aiMDOHUB
	 NhQi2QOHwfzxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: Fix FF device cleanup on init
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haoxiang Li" <haoxiang_li2024@163.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260623065200.1966629-1-haoxiang_li2024@163.com>
References: <20260623065200.1966629-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 07:07:08 +0000
Message-Id: <20260623070708.79F691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Calling `input_ff_destroy(dev)` leaves a dangling `dev->flush` poi=
nter, causing a guaranteed NULL pointer dereference when the device file is=
 closed.
- [High] Calling `input_ff_destroy(dev)` on an active, registered device in=
 the error path introduces a Use-After-Free race condition.

Pre-existing issues:
- [Critical] Use-After-Free in `hidpp_ff_destroy()` due to mismatched lifec=
ycles between `devm`-managed driver data and `input_dev` lifecycle.
- [High] Input device capabilities are initialized after registration, viol=
ating subsystem lifecycle rules and exposing incomplete state to userspace.
--

commit 1a99b024f97c7dab9fe8188d726db401b73dd317
Author: Haoxiang Li <haoxiang_li2024@163.com>

    HID: logitech-hidpp: Fix FF device cleanup on init failure

    hidpp_ff_init() creates the input force-feedback device with
    input_ff_create(), then allocates the HID++ FF private data,
    effect ID array, and workqueue.
   =20
    If any of those allocations fail after input_ff_create() succeeds,
    the function returns an error without destroying the FF device.
    Add an unwind path that frees the private allocations made by
    hidpp_ff_init() and calls input_ff_destroy() for failures after
    input_ff_create() succeeds.

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hi=
dpp.c
index ccbf28869a968..95f84efa77069 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2859,18 +2859,19 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
 	 * ownership to FF core
 	 */

[Severity: High]
This is a pre-existing issue, but does initializing input device capabiliti=
es
after registration violate subsystem lifecycle rules and expose incomplete
state to userspace?

Because hidpp_probe() calls hid_connect() (which registers the device)
before calling hidpp_ff_init(), can userspace open the device and issue
ioctls immediately upon registration, before hidpp_ff_init() has fully
configured the FF capabilities:

    for (j =3D 0; hidpp_ff_effects[j] >=3D 0; j++)
        set_bit(hidpp_ff_effects[j], dev->ffbit);

>  	data =3D kmemdup(data, sizeof(*data), GFP_KERNEL);
> -	if (!data)
> -		return -ENOMEM;
> +	if (!data) {
> +		error =3D -ENOMEM;
> +		goto err_destroy_ff;
> +	}

[ ... ]

>  	data->wq =3D create_singlethread_workqueue("hidpp-ff-sendqueue");
>  	if (!data->wq) {
> -		kfree(data->effect_ids);
> -		kfree(data);
> -		return -ENOMEM;
> +		error =3D -ENOMEM;
> +		goto err_free_effect_ids;
>  	}
> =20
>  	data->hidpp =3D hidpp;

[Severity: Critical]
This is a pre-existing issue, but could this lead to a use-after-free in
hidpp_ff_destroy() due to mismatched lifecycles?

The hidpp_device structure is allocated using devm_kzalloc() in hidpp_probe=
(),
meaning it is freed by devres immediately after the driver's remove()
callback completes.

However, the input_dev is reference-counted and outlives the driver binding
if a userspace process holds the event file descriptor open. When the proce=
ss
finally closes the fd, input_free_device() calls hidpp_ff_destroy(), which
dereferences data->hidpp to access hid_dev:

    struct hid_device *hid =3D data->hidpp->hid_dev;

Could this trigger a use-after-free if a local user holds the input device
open during a device unplug or driver unbind?

[ ... ]

> @@ -2900,6 +2901,14 @@ static int hidpp_ff_init(struct hidpp_device *hidp=
p,
>  		 version);
> =20
>  	return 0;
> +
> +err_free_effect_ids:
> +	kfree(data->effect_ids);
> +err_free_data:
> +	kfree(data);
> +err_destroy_ff:
> +	input_ff_destroy(dev);

[Severity: High]
Is it possible that calling input_ff_destroy(dev) here leaves a dangling
dev->flush pointer?

This frees dev->ff but does not clear the dev->flush =3D input_ff_flush
callback set earlier by input_ff_create().

Since hidpp_probe() ignores the initialization error, the input device
remains registered. If a userspace process opens and then closes the event
node, evdev_release() calls input_flush_device(), triggering
input_ff_flush():

    guard(mutex)(&ff->mutex);

Does this cause a guaranteed NULL pointer dereference because dev->ff is now
NULL?

[Severity: High]
Additionally, since hidpp_ff_init() runs after hid_connect() has already
registered the device, it is visible to userspace.

If input_ff_create() succeeds, it sets the EV_FF bit. If a concurrent thread
immediately issues an EVIOCSFF ioctl, calling input_ff_upload() which uses
dev->ff, and this error path triggers simultaneously calling
input_ff_destroy(dev):

    input_ff_destroy(dev);

Could this regression result in a use-after-free in the force-feedback ioctl
handler without any synchronization?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623065200.1966=
629-1-haoxiang_li2024@163.com?part=3D1
