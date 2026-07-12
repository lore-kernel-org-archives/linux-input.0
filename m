Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854633A1DB;
	Sun, 12 Jul 2026 02:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783823057; cv=none; b=iAygLVq0Ct/5CZ6250pf8RRqk917oH6GKgii5eH8fP8GBd42Xwy8WQZsbwqCJ5SWjX6u353u/3JZ9xxQ6qddLGKln6AcwizC+Av35vMvdCMp81V/OgWk+9pooNeEPoObq67ZhTrLAatSGDgRVOFy+v7t/y+LN/BXtBIx/GUcLQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783823057; c=relaxed/simple;
	bh=PlOq7ePd2zYa6FVIE0LvX+279bMaWDPJRmwE2M7ai7Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u6KXtbA/6TT/kj7msapbQSJPJsNhOkvZ5InNNbNRF0Q1UGYW6YbjoqA1f8Z/GeInVWGlqDZ7PMZ2Nj3gxB28hRV8TwJrAD5PrzDFPpYU4wXhrEzAZ648YQsnHEWuKXuPVbWEcHF3y3s6sbpCE6Ly2PenEZPCNZ8ujlnojYkyguA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMvn37Uz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMvn37Uz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED0A1F000E9;
	Sun, 12 Jul 2026 02:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783823056;
	bh=J06DfPkCMVR5QEN3oz56FDBfqbtfLZIEKoENTnnOCNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LMvn37Uzes0PRV/uSuf0s0RziR05dwgLmE3g8sWGR3QiKqaXZsMJPBba69AG5EqUX
	 evQSD4SzHChNR8WHMp582DyqSfYG6iYUq010RB0kq0IW8Ti9RW2ACxKpJ0TXtW2QmU
	 wOjLJJd0rTski4rCaStohcQ8WxADXYb4ez9B++lfVop/ghvsP7lB8CzruuyNRnNOek
	 hJ30pbRuvTxJDAyqGUcct2Gd7fZt7bqaZqZTAX25O1PUAvyeRljIi0rIKPYhVU++jl
	 qRMY9eK9HjfU3iQhtwBwYzYmL5/LR9+sK8rJLbwymBRw5/EZAK91iXwX0xKfeWLT2r
	 QXBC1OZKJgJuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/10] Input: samsung-keypad - handle compact binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: conor+dt@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260711-samsung-kp-v3-2-b2fcaba77aff@gmail.com>
References: <20260711-samsung-kp-v3-0-b2fcaba77aff@gmail.com>
 <20260711-samsung-kp-v3-2-b2fcaba77aff@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 02:24:15 +0000
Message-Id: <20260712022415.AED0A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] IRQ handler is requested before runtime PM is enabled, leading to =
potential bus faults.
- [High] Uninitialized stack variables `row`, `col`, and `key_code` leak ke=
rnel stack memory and can cause out-of-bounds array access.
- [Medium] Time-of-Check to Time-of-Use (TOCTOU) race condition when parsin=
g child nodes causes heap buffer overflow.
--

--- Patch [2]: [PATCH v3 02/10] Input: samsung-keypad - handle compact bind=
ing ---
commit df7d9c0ab9ce4671eb0b2980bb819cb1ac325753
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Input: samsung-keypad - handle compact binding

Add support for standard matrix keymap binding (in addition to the
existing verbose binding with a sub-node for each key). This will
allow easier conversions from platform data to device properties when
using static device properties.

> diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyb=
oard/samsung-keypad.c
> index 17127269e3f05..cc34f0146161e 100644
> --- a/drivers/input/keyboard/samsung-keypad.c
> +++ b/drivers/input/keyboard/samsung-keypad.c
> @@ -231,83 +231,89 @@ static void samsung_keypad_close(struct input_dev *=
input_dev)
>  	samsung_keypad_stop(keypad);
>  }
> =20
> -#ifdef CONFIG_OF
> -static struct samsung_keypad_platdata *
> -samsung_keypad_parse_dt(struct device *dev)

[ ... ]

> +static const struct matrix_keymap_data *
> +samsung_parse_verbose_keymap(struct device *dev)
> +{
> +	struct matrix_keymap_data *keymap_data;
> +	struct fwnode_handle *child;
> +	u32 *keymap;
> +	unsigned int key_count;
> +
> +	keymap_data =3D devm_kzalloc(dev, sizeof(*keymap_data), GFP_KERNEL);
> +	if (!keymap_data)
> +		return ERR_PTR(-ENOMEM);
> +
> +	key_count =3D device_get_child_node_count(dev);
> +	keymap =3D devm_kcalloc(dev, key_count, sizeof(*keymap), GFP_KERNEL);
> +	if (!keymap)
> +		return ERR_PTR(-ENOMEM);
> +
> +	keymap_data->keymap_size =3D key_count;
> +	keymap_data->keymap =3D keymap;
> +
> +	device_for_each_child_node(dev, child) {
> +		u32 row, col, key_code;
> +
> +		fwnode_property_read_u32(child, "keypad,row", &row);
> +		fwnode_property_read_u32(child, "keypad,column", &col);
> +		fwnode_property_read_u32(child, "linux,code", &key_code);
> +
> +		*keymap++ =3D KEY(row, col, key_code);

[Severity: Medium]
This is a pre-existing issue, but could this loop overflow the allocated
keymap array?

The array size is determined earlier:

	key_count =3D device_get_child_node_count(dev);
	keymap =3D devm_kcalloc(dev, key_count, sizeof(*keymap), GFP_KERNEL);

Because there is no synchronization explicitly held, if a concurrent device
tree overlay adds a child node to the keypad between the count and the
iteration here in device_for_each_child_node(), could the loop execute more
times than allocated and cause an out-of-bounds heap write?

[Severity: High]
This isn't a bug introduced by this patch, but what happens if the device
tree child node is missing properties?

If fwnode_property_read_u32() fails for "keypad,row", "keypad,column", or
"linux,code", it leaves the output variables uninitialized.

Since the return values are ignored, the uninitialized stack variables row,
col, and key_code are passed into the KEY() macro and written to the keymap.
Could this leak kernel stack memory to userspace via the EVIOCGKEYCODE ioct=
l,
or create incorrect key mappings?

>  	}
> =20
> +	return keymap_data;
> +}

[ ... ]

> @@ -430,11 +435,14 @@ static int samsung_keypad_probe(struct platform_dev=
ice *pdev)
>  	if (error)
>  		return error;
> =20
> -	if (pdev->dev.of_node) {
> -		devm_kfree(&pdev->dev, (void *)pdata->keymap_data->keymap);
> -		devm_kfree(&pdev->dev, (void *)pdata->keymap_data);
> +	if (!dev_get_platdata(&pdev->dev)) {
> +		if (pdata->keymap_data) {
> +			devm_kfree(&pdev->dev, (void *)pdata->keymap_data->keymap);
> +			devm_kfree(&pdev->dev, (void *)pdata->keymap_data);
> +		}
>  		devm_kfree(&pdev->dev, (void *)pdata);
>  	}
> +

[Severity: High]
This is a pre-existing issue, but could the IRQ handler run before runtime =
PM
is enabled?

In samsung_keypad_probe(), devm_request_threaded_irq() is called to unmask
the IRQ before devm_pm_runtime_enable() is called:

	error =3D devm_request_threaded_irq(&pdev->dev, keypad->irq, NULL,
					  samsung_keypad_irq, IRQF_ONESHOT,
					  dev_name(&pdev->dev), keypad);
	[ ... ]
	error =3D devm_pm_runtime_enable(&pdev->dev);

If an interrupt is pending (for example, left over from the bootloader),
samsung_keypad_irq() could fire immediately.  The handler calls
pm_runtime_get_sync(), which would return -EACCES because runtime PM is not
yet enabled.

If the handler then reads from keypad->base with a disabled clock, could
this cause a bus fault?

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711-samsung-kp=
-v3-0-b2fcaba77aff@gmail.com?part=3D2
