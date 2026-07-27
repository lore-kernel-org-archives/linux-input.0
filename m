Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D7026B764
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164901; cv=none; b=Rv5B9GfyOGMlrpYd3xUdEZGk4Ab7moJ3otQzPLYv+sUj7sqXQudZBS97jQdArgjEMt+DGGR+8s+NPH5sllOvg5SKFgJUsVpI5FIQsMAvscxb+LVk85pGi1X7RUohZPWXQ5f/iCkoWbB1+jwjDQ9fIAVz8HVl/nFnx9d3CqvD+VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164901; c=relaxed/simple;
	bh=atQV8Cby9FlWSCP/pAorqWxXXiN/IxdvbFPgobJj3Sw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=puvy5qVZOMKSW6dGOhRr2bYMLJ6IFd+dcYj6EbHHX1AF4zPk/YlWuWjDgsUC/17x5+AiaYFSyK2L8n9c5mSsw/DYK/2YAJe3Xbtprivon4mjKwUJWzcwnddJVrTTsJWmgE4Shx47tWF57oFlOPWB1ktt6E50Oi3IUtfb0ZdLlQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtSW2xen; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtSW2xen"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335E41F00A3D;
	Mon, 27 Jul 2026 15:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785164900;
	bh=evjLewjhP71CZ+A6JYV/99Q57MF2GyHCKMjsAmrozWI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jtSW2xenCksd+BHneZ43bYsqQ4wcPCwicwDPH9GHJ1zEuAXzU/NYToKfV6nSZseTp
	 bSCgKAoFV6+0kZEnQWYuksmXUg3lJ96EhRkFa+iImr8C8QILJoEc75h1Mweem0Xk/l
	 sEYPsCE5a4IIivuzoMr2pHp3Km+fSCJWPFSGNByGZRmReP6B/+A5siIU0Lv4hMZ/Ao
	 CyMiy5I0FFBy1IRx8P56lTcnuvIo9lDJgh/lsl3iKKfRMdmqtA06fNW5YynVw5Y89X
	 uG9QWrFItvb2Tunsv5TmCqGECQjGmJep2yjevgtF7NjhSXL5Lf5df2JnxhNCa/ySZn
	 U7MjJtgssKmbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/8] HID: hid-tmff: clean up usage of 'driver_data'
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?UGF3ZWwgWmFsZXdza2kgKFRoZSBDYXBhYmxlIEh1Yik=?= <pzalewski@thegoodpenguin.co.uk>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260727-mod-devicetable-hid_device_id-v3-5-980896ca283e@thegoodpenguin.co.uk>
References: <20260727-mod-devicetable-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk>
 <20260727-mod-devicetable-hid_device_id-v3-5-980896ca283e@thegoodpenguin.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 15:08:19 +0000
Message-Id: <20260727150820.335E41F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing hid_hw_stop() in the probe error path when an invalid driv=
er_data index is provided.
- [High] Implicit conversion of an unsigned long to an enum type can lead t=
o a negative index and an out-of-bounds array read.
- [Low] Implicit sizing of ff_bits_table makes the code susceptible to futu=
re out-of-bounds reads.
--

--- Patch [5]: [PATCH v3 5/8] HID: hid-tmff: clean up usage of 'driver_data=
' ---
commit d405905589b1ceab25490f9b10c3aef95f73bffc
Author: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>

HID: hid-tmff: clean up usage of 'driver_data'

This patch modifies the hid_device_id::driver_data field to store an
index into ff_bits_table instead of a direct pointer address. This change
is intended to safely support the command line injection of a new_id device
by bounding retrieval at runtime.

> diff --git a/drivers/hid/hid-tmff.c b/drivers/hid/hid-tmff.c
> index 423f395d01ac5..93de756dd30e6 100644
> --- a/drivers/hid/hid-tmff.c
> +++ b/drivers/hid/hid-tmff.c
> @@ -34,6 +34,17 @@ static const signed short ff_joystick[] =3D {
>  	-1
>  };
> =20
> +enum ff_bits_table_index {
> +	FF_BITS_TABLE_RUMBLE,
> +	FF_BITS_TABLE_JOYSTICK,
> +	NUM_OF_FF_BITS_IN_TABLE
> +};
> +
> +static const signed short *ff_bits_table[] =3D {
> +	[FF_BITS_TABLE_RUMBLE]		=3D ff_rumble,
> +	[FF_BITS_TABLE_JOYSTICK]	=3D ff_joystick
> +};

[Severity: Low]
This isn't a bug, but could we add an explicit size to the array like
ff_bits_table[NUM_OF_FF_BITS_IN_TABLE]?

If a future developer adds a new device type to the enum but forgets to
add a corresponding initializer here, NUM_OF_FF_BITS_IN_TABLE will increase
but the array size will not. The bounds check would then allow accessing
an unallocated index.

[ ... ]

> +static const signed short *get_ff_bits(enum ff_bits_table_index index)
> +{
> +	if (index >=3D NUM_OF_FF_BITS_IN_TABLE)
> +		return NULL;
> +
> +	return ff_bits_table[index];
> +}

[Severity: High]
Does this bounds check properly handle negative values?=20

id->driver_data is an unsigned long injected via the sysfs new_id interface.
When a large unsigned value like 0xFFFFFFFF is passed to get_ff_bits(), it =
is
implicitly cast to enum ff_bits_table_index.=20

On standard architectures, an enum without negative constants defaults to a
signed int. This casts the value to a negative integer, which bypasses the
upper-bound check and results in an out-of-bounds array read at
ff_bits_table[-1].

>  static int tm_probe(struct hid_device *hdev, const struct hid_device_id =
*id)
>  {
>  	int ret;
> +	const signed short *ff_bits =3D get_ff_bits(id->driver_data);
> =20
>  	ret =3D hid_parse(hdev);
>  	if (ret) {
[ ... ]
> @@ -226,7 +246,13 @@ static int tm_probe(struct hid_device *hdev, const s=
truct hid_device_id *id)
>  		goto err;
>  	}
> =20
> -	tmff_init(hdev, (void *)id->driver_data);
> +	if (!ff_bits) {
> +		hid_err(hdev, "no ff_bits found\n");
> +		ret =3D -EINVAL;
> +		goto err;
> +	}

[Severity: High]
Should this error path call hid_hw_stop() before jumping to err?

The probe function previously called hid_hw_start() right above this check.
If an invalid driver_data index is provided via sysfs new_id, get_ff_bits()
returns NULL. The probe function then executes this goto err and returns
-EINVAL without stopping the hardware, which leaks resources allocated
by hid_hw_start().

> +
> +	tmff_init(hdev, ff_bits);
> =20
>  	return 0;
>  err:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-mod-device=
table-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk?part=3D5
