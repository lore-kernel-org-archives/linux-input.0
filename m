Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1B02931FB
	for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 07:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784964535; cv=none; b=HsbUGOykVZhFDZmAoxs01zW3hfXHy7AlUA25e7P/FiQiQHm+5iv2oSKwuq96CN3Zeit3cQD4H5OywO3zREUTMyKai3B9YJAGNUvmLF9QVdOqjmy8siJl2O3JvOIUOrjPJE+PqaP0aIGEBqja6UCx2/Cp/gKqxMUZ1CxLICEmiXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784964535; c=relaxed/simple;
	bh=a3cM5RvtgUrGyPN07Nj4p50/m8fSF+ceJF4yKNvNhhs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bo7t8QZFdHqECzff1eHbH2V0EDSI70N6s6AfZKJqOwMt2vEZBtVdSRN87YRGBn+G8LrgToh4ZqgpOBM0kEnC+PjpuLqnddEw2Tfh62C4PlADEXDrNiq4ynWpfeAf5kPdJalthmAoA0OwJCnB1GDAiA6MATATkOk/fT1Wd7j8DYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VigqTXNT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VigqTXNT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8280E1F000E9;
	Sat, 25 Jul 2026 07:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784964534;
	bh=81WUrFGblPBBZzZC1OkRN307vCdqjIwhxqKWZT51acw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VigqTXNTAXzIpNZtDDGo1NmPcBwCZgk/KvI7o2alY9uuL8v574EgsgJrkjvpognlE
	 LSl0tACsSO0w6ibeIJo8B6IXl8jxZ7ArmWNejFnuyICu1J5/PdDDXeFCpEAU0AzA1O
	 Aw8tUHuO5QeeXgsmmCghXsUz4aabTG5Uq7lJhpYnXOs2T4PqDb3UQ+/EeR2VBnmL1N
	 rGfswTKY15MNnUCpKlJ41gTvRTGfxtsFx3eO+Su47lJ2lxT4rhI1GYgkb219RD19c/
	 +lHDzNV0NhOitE4nl1FeFAGQWmPPtXzsNuaIyXzRLkFgDxFQA+BT1Sq6DZquB3if5o
	 38NzsGOGso0oA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/36] Input: remove conditional return with no effect
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sang-Heon Jeon" <ekffu200098@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260723184538.3888637-17-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-17-ekffu200098@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 07:28:54 +0000
Message-Id: <20260725072854.8280E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The patch transforms an explicit error handling path into a direct =
return of an action function in a function with multiple failure points, vi=
olating input subsystem guidelines.

Pre-existing issues:
- [High] Stack/Heap buffer overflow in `smb_block_read()` due to unsafe buf=
fer assumptions.
--

--- Patch [16]: [PATCH 16/36] Input: remove conditional return with no effe=
ct ---
commit 7d8880d335a34689e5a8927e5f647f213829163d
Author: Sang-Heon Jeon <ekffu200098@gmail.com>

Input: remove conditional return with no effect

This commit removes conditional returns where both branches return the same
value across multiple input drivers, applying a Coccinelle script
(cond_return_no_effect.cocci) to simplify the code.

[ ... ]

> diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/sy=
naptics_i2c.c
> index d4cf982f12632..85e37e2ce45ba 100644
> --- a/drivers/input/mouse/synaptics_i2c.c
> +++ b/drivers/input/mouse/synaptics_i2c.c
> @@ -257,11 +257,7 @@ static s32 synaptics_i2c_reg_set(struct i2c_client *=
client, u16 reg, u8 val)
>  	if (error)
>  		return error;
> =20
> -	error =3D i2c_smbus_write_byte_data(client, reg & 0xff, val);
> -	if (error)
> -		return error;
> -
> -	return error;
> +	return i2c_smbus_write_byte_data(client, reg & 0xff, val);

[Severity: Low]
Does this violate the input subsystem maintainer preference to use explicit
failure paths? The guidelines suggest avoiding "return action(...);" for
functions with multiple failure points, like synaptics_i2c_reg_set() which
already has an earlier failure check.

[ ... ]

> diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbu=
s.c
> index 6de68c602558b..3160714a514a5 100644
> --- a/drivers/input/rmi4/rmi_smbus.c
> +++ b/drivers/input/rmi4/rmi_smbus.c
> @@ -177,13 +177,8 @@ static int smb_block_read(struct rmi_transport_dev *=
xport,
>  	struct rmi_smb_xport *rmi_smb =3D
>  		container_of(xport, struct rmi_smb_xport, xport);
>  	struct i2c_client *client =3D rmi_smb->client;
> -	int retval;
> =20
> -	retval =3D i2c_smbus_read_block_data(client, commandcode, buf);
> -	if (retval < 0)
> -		return retval;
> -
> -	return retval;
> +	return i2c_smbus_read_block_data(client, commandcode, buf);

[Severity: High]
This is a pre-existing issue, but does ignoring the len parameter and passi=
ng
buf directly to i2c_smbus_read_block_data() cause a stack buffer overflow?

For instance, rmi_scan_pdt_page() in rmi_driver.c passes a 6-byte stack
buffer to rmi_read_block():

drivers/input/rmi4/rmi_driver.c:rmi_scan_pdt_page() {
    ...
    u8 buf[RMI_PDT_ENTRY_SIZE];
    ...
    error =3D rmi_read_block(rmi_dev, pdt_address, buf, RMI_PDT_ENTRY_SIZE);
    ...
}

If a malfunctioning or malicious I2C device returns up to 32 bytes, wouldn't
i2c_smbus_read_block_data() copy those 32 bytes directly into the 6-byte
stack buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723184538.3888=
637-1-ekffu200098@gmail.com?part=3D16
