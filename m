Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B927E33438F
	for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 04:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791605084; cv=none; b=szEhUWFWMYGQg/7ElbaVEeOXz9bIMcU6cNlBRz4mIDa8emPxdUkNMZvtOnA6dBX4QpaLL34u39Gfjg0E0KQcv3QXaRAeCRVQSGt+uMHvRvaSC41msq0o90mW6PYxR3dFHJtw/OXWIhTPYJyyEc/SQfAqPWRVrhz9PhtzNhw/HoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791605084; c=relaxed/simple;
	bh=0R/hIxD3YK4VkGAiNXwOkhLJu4YilDqOwqokDZWemEo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=fT+FDK+H99ViknjnCdNdF5Ge4RaG2VibUL2kcbzx9ENlz6qcqWwj+E1cUSem6Kny8uPbWDJ2El62teTkdeGmoOSAgCwNNHR7tZMfTJ4ntNAWD1fSlyuM7SHGRlzBCyOY9wEartc/8U4ubPaIKukVDno01fnjOOcN6Kk5Bm8KQLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cw+9pPq/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cw+9pPq/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8561F000FF;
	Sat, 10 Oct 2026 04:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791605083;
	bh=Oc3qvx/tuttKwLF82VDq/uP7OCY5b+4JavdhWNynWBU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cw+9pPq/v8hbfhHa19SO+ctx7PFHwUfOHxUcGsFeKtz4T7J97eDOWsnHptDGnWHiJ
	 AQHdj+33NEz998X7o2e+iOAQ5vjiPutUDdW9BjhOr+ALEL02HSqWx4EKkmnP669w2z
	 PuiJBeAxxbqBlcLuZB6MIyHkMFt0gmppIh1ZsWxm51gAFoPCdUeJfDGxf90p9e4jHm
	 nyKXyaP7saV3vxc1Rb+Hr+D03qnn467xKNffK7UyuYue9W5j92hw9v8VzSqciP2fjJ
	 iKjNyYDme/jBP4iF3ayY5TafZEcv5c7I2RT8gqYJEW4cP12dRZYX/htkTIYMLzfbl2
	 LI3L4owNg9nzg==
Message-ID: <sashiko-outbox-166252@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: reject parent overrides on managed input devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <asmCc1VxVPLIMgY6@google.com>
References: <asmCc1VxVPLIMgY6@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 04:04:42 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] input: newly added parent check breaks existing managed drivers
- [High] input: NULL pointer dereference in input_free_device()
--

commit 5c214b0cacbe95369ec05dede9ca4ab2c7e279f1
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: reject parent overrides on managed input devices

This commit adds a strict check to ensure that the parent of a managed
input device is not overridden or cleared before registration. It returns
-EINVAL if the parent does not match the original device that allocated
the managed input device. KUnit tests are also added to verify this
behavior.

> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 78c10eea7328d..1cca6d48f5977 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -2396,6 +2396,14 @@ int input_register_device(struct input_dev *dev)
>  	}
> =20
>  	if (dev->devres_managed) {
> +		if (!dev->dev.parent ||
> +		    !devres_find(dev->dev.parent, devm_input_device_release,
> +				 devm_input_device_match, dev)) {
> +			dev_err(&dev->dev,
> +				"Parent of managed input device was overridden, refusing to register=
\n");
> +			return -EINVAL;

[Severity: High]
Does this new strict check break existing in-tree drivers that legitimately
reparent the input device during probe?

For example, looking at da7280_probe() in drivers/input/misc/da7280.c:

da7280_probe() {
    input_dev =3D devm_input_allocate_device(dev);
    ...
    input_dev->dev.parent =3D client->dev.parent;
    ...
    error =3D input_register_device(input_dev);
}

Another example is tps6507x_ts_probe() in drivers/input/touchscreen/tps6507=
x-ts.c:

tps6507x_ts_probe() {
    poll_dev =3D devm_input_allocate_device(&i2c->dev);
    ...
    poll_dev->dev.parent =3D tsc->dev;
    ...
    error =3D input_register_device(poll_dev);
}

Because these drivers explicitly override dev.parent before registration,
wouldn't this new check unconditionally fail with -EINVAL and break their
initialization sequence?

[Severity: High]
If this error path is triggered, can it lead to a NULL pointer dereference
or double-free when the driver cleans up?

When a managed driver's probe fails here, it will typically call
input_free_device() in its error path.  However, input_free_device() trusts
dev->dev.parent unconditionally:

drivers/input/input.c:input_free_device() {
    ...
    if (dev->devres_managed)
        WARN_ON(devres_destroy(dev->dev.parent,
                               devm_input_device_release,
                               devm_input_device_match,
                               dev));
    ...
}

If dev.parent was cleared to NULL before input_register_device() was called,
wouldn't passing NULL to devres_destroy() cause a crash when it tries to
lock the devres list?

Alternatively, if the device was reparented to a different device,
devres_destroy() would fail to find the devres on the new parent.  Wouldn't
this fail to untrack the devres, leading to a double-free later when the
original devm owner is unbound?

> +		}
> +
>  		devres =3D devres_alloc(devm_input_device_unregister,
>  				      sizeof(*devres), GFP_KERNEL);
>  		if (!devres)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/asmCc1VxVPLIMgY6@go=
ogle.com?part=3D1
