Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404571E633C;
	Thu,  9 Jul 2026 05:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783573478; cv=none; b=CbyhnT/TltW5K1MSi8J8OWzi/KmpCplnrOr6FF5AxhKnE8yYaZbfVeWqALQdY+4WmG9BU9SaENedOW6yMU/6u0j8BK8NUN5J+YVgbkFpiuL8V7wBcyfyXU2grQwUONRwhxIZNGLfQzpkugZmvZMGruepdVF+oIaG2HxebP/E/xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783573478; c=relaxed/simple;
	bh=bGv5HTMf8EV9ooKoh2xr5x8q51XWFk+xnPMJ/daoNjM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JX/vy2FXWITv6SWrwmDVjIxxV2nDcXo/HDSkgDnV/0M0W1kKTPYQ1TqqO0lGFM/q35WAsnQLs7BsdcKWFM2JR5sq5ZNqARanGgEibinaAfRe0l7GSK0I3HPc2gV3/28l/wYUB8Cz4Ht/+JW2GdP00PbYFRVdZ3vZgLH8Tr7xXKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FODkuui/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FODkuui/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6145C1F000E9;
	Thu,  9 Jul 2026 05:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783573476;
	bh=NRLMW8/ztuPqIVptOR1phI4H7y6JeMsk8PPEzXWGh/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FODkuui/HJj3FuuAJKMvJCjbW4ewYHBYkc0tZx+m7lJp4L4qCn2hLCn2Z/0ehaimj
	 lq8b6Rs05FW5X9orNo6kDvah3URgtHqgZf9VZumMrJn4L9s8RvdnCm3ShQ/YpM63qu
	 4f+4L21ldRU9iwe5hG1hPsKMBWg5dxv938mQCvt24IWu6hNmWpKJZ9h68WHAUjkrCa
	 NBK9bWNOG5o09wDeoJ3rEx2Cx9NYGgaejFeHJol0naKrJHqCNbkq+1xthosulL8WfY
	 jB+AvBrBQ2VMMWNTOeeKDLnzxE4jxiM8CVVVU5Wf5ID0JMGuVHje7VYiT79Af8WJYi
	 YkKLS+klGLbww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/11] Input: samsung-keypad - remove support for
 platform data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260708-samsung-kp-v2-5-3c6ed4c9b3b6@gmail.com>
References: <20260708-samsung-kp-v2-0-3c6ed4c9b3b6@gmail.com>
 <20260708-samsung-kp-v2-5-3c6ed4c9b3b6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 05:04:35 +0000
Message-Id: <20260709050436.6145C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Legacy device tree properties for row and column counts are immedi=
ately overwritten and discarded by matrix_keypad_parse_properties(), breaki=
ng backward compatibility.

Pre-existing issues:
- [Critical] Stack variables `row`, `col`, and `key_code` are used uninitia=
lized if property reads fail, potentially leading to out-of-bounds keymap g=
eneration and memory corruption.
- [High] The IRQ handler is requested before hardware clocks are enabled, l=
eading to an external abort (system crash) if an interrupt fires early.
--

--- Patch [5]: [PATCH v2 05/11] Input: samsung-keypad - remove support for =
platform data ---
commit 6b84c0425d2f995a2e30b98f55d0febfc3a74cb7
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: samsung-keypad - remove support for platform data

Because there are no more users of samsung_keypad_platdata left in
the kernel remove support for it from the driver. The driver supports
generic device properties so all configuration should be done using
them instead of a custom platform data.

> diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyb=
oard/samsung-keypad.c
> index b9d4ea5f202ae..6f1d766a4134d 100644
> --- a/drivers/input/keyboard/samsung-keypad.c
> +++ b/drivers/input/keyboard/samsung-keypad.c
[ ... ]
> @@ -231,144 +234,77 @@ static void samsung_keypad_close(struct input_dev =
*input_dev)
>  	samsung_keypad_stop(keypad);
>  }
> =20
> -static const struct matrix_keymap_data *
> -samsung_parse_verbose_keymap(struct device *dev)
> +static int samsung_keypad_parse_keymap(struct samsung_keypad *keypad)
>  {
[ ... ]
> +		device_for_each_child_node(dev, child) {
> +			u32 row, col, key_code;
> =20
> -		fwnode_property_read_u32(child, "keypad,row", &row);
> -		fwnode_property_read_u32(child, "keypad,column", &col);
> -		fwnode_property_read_u32(child, "linux,code", &key_code);
> +			fwnode_property_read_u32(child, "keypad,row", &row);
> +			fwnode_property_read_u32(child, "keypad,column", &col);
> +			fwnode_property_read_u32(child, "linux,code", &key_code);
> =20
> -		*keymap++ =3D KEY(row, col, key_code);
> +			*keymap++ =3D KEY(row, col, key_code);

[Severity: Critical]
This is a pre-existing issue, but what happens if the property reads fail?

If the device tree child node is missing properties (like linux,code),
fwnode_property_read_u32() will return an error and leave row, col, and
key_code uninitialized.

Could this stack garbage be packed into the keymap array and subsequently
cause an out-of-bounds bitwise write in matrix_keypad_build_keymap() when it
calls __set_bit(code, input_dev->keybit)?

> +		}
>  	}
> =20
[ ... ]
>  static int samsung_keypad_probe(struct platform_device *pdev)
>  {
[ ... ]
> +	device_property_read_u32(dev, "samsung,keypad-num-rows", &num_rows);
> +	device_property_read_u32(dev, "samsung,keypad-num-columns", &num_cols);
> =20
> -	error =3D matrix_keypad_parse_properties(dev, &num_rows, &num_cols);
> -	if (error)
> -		return ERR_PTR(error);
> -
> -	pdata->rows =3D num_rows;
> -	pdata->cols =3D num_cols;
> -
> -	if (!device_property_present(dev, "linux,keymap")) {
> -		keymap_data =3D samsung_parse_verbose_keymap(dev);
> -		if (IS_ERR(keymap_data))
> -			return ERR_CAST(keymap_data);
> -
> -		pdata->keymap_data =3D keymap_data;
> -	}
> -
> -
> -	pdata->no_autorepeat =3D
> -		device_property_read_bool(dev, "linux,input-no-autorepeat");
> -
> -	pdata->wakeup =3D device_property_read_bool(dev, "wakeup-source") ||
> -			/* legacy name */
> -			device_property_read_bool(dev, "linux,input-wakeup");
> -
> -	return pdata;
> +	error =3D matrix_keypad_parse_properties(dev, &num_rows, &num_cols);
> +	if (error)
> +		return error;

[Severity: High]
Does matrix_keypad_parse_properties() overwrite the legacy properties we ju=
st
read?

Looking at matrix_keypad_parse_properties(), it unconditionally resets the
pointers passed to it:

matrix_keypad_parse_properties() {
	*rows =3D *cols =3D 0;
	device_property_read_u32(dev, "keypad,num-rows", rows);
	device_property_read_u32(dev, "keypad,num-columns", cols);
}

If a device tree uses the legacy bindings (samsung,keypad-num-rows and
samsung,keypad-num-columns) without the modern prefixes, it seems the values
read into num_rows and num_cols will be discarded here.

Since matrix_keypad_parse_properties() will return -EINVAL if the generic
properties are missing, will this cause probe to fail on existing platforms
using the older bindings?

[ ... ]
> @@ -418,7 +373,11 @@ static int samsung_keypad_probe(struct platform_devi=
ce *pdev)
>  		return error;
>  	}

[Severity: High]
This is a pre-existing issue, but is the interrupt handler requested too ea=
rly?

In samsung_keypad_probe(), devm_request_threaded_irq() is called just above
this block before the hardware clocks are fully enabled. During probe,
keypad->stopped is true.

If an interrupt fires immediately (for instance, if the bootloader left the
IP block active), samsung_keypad_irq() will run. While the handler calls
pm_runtime_get_sync(), the runtime resume callback skips enabling the clock
because keypad->stopped is true.

Could this result in the handler attempting an unclocked read:

samsung_keypad_irq() {
	...
	readl(keypad->base + SAMSUNG_KEYIFSTSCLR);
	...
}

and causing a synchronous external abort?

> -	device_init_wakeup(&pdev->dev, pdata->wakeup);
> +	wakeup =3D device_property_read_bool(dev, "wakeup-source") ||
> +		 /* legacy name */
> +		 device_property_read_bool(dev, "linux,input-wakeup");
> +	device_init_wakeup(&pdev->dev, wakeup);
> +
>  	platform_set_drvdata(pdev, keypad);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-samsung-kp=
-v2-0-3c6ed4c9b3b6@gmail.com?part=3D5
