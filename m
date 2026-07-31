Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5403645C718
	for <linux-input@vger.kernel.org>; Fri, 31 Jul 2026 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785522196; cv=none; b=XvRIlyF5Ow+isETIRn/ZMGfo1CAZ9/LsT1SZK9XboRyrIBOLhlyC5iX1MrbxjNOl/78i9PU3obEuHbPWRujh8n77NuL8CWs6sRNtFW7zY2/ZLU13YYopMZ0etN77kcOlOctzS1JWYaJou7OtMotF7Zro9sw9nbzVv15+5eznlUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785522196; c=relaxed/simple;
	bh=9KaPWGCKAv+vKVQAmZ5q8OMGoVqo1bZvRE/guIRKQeE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HMQwc8TePUKlMoD8Cwpa8QGIyB3EWw4oKjub/n5tjDU7TYJmGjrZHO6V50ZBsRwFMZ9EPZzHxzsgp6Rsrw3LrTpY09SMtvz9HGzy7MKiuzKvxVttnSH2Jf5ZAIrGpbJvUy+Ae4Dv/VO7kv6cmmwokgs/UMrHYKbaJfrmUcUkw+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGp2YdYo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGp2YdYo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00EA1F00AC4;
	Fri, 31 Jul 2026 18:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785522195;
	bh=F4zKtFdNFwaEdV6zJzbutpsolf7hZkZlfE1Y/3MeMkE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GGp2YdYoIklTaD9KT2w1LfIOB0IDRaxeJKF4KfDleGCF65VX9b753S1OrTbwgr/g9
	 UgCBU6+fm9Ao17IPG4wchCDmRg5jAyWZSUKoDhi0t1Mf1zhYsm3H0kfCLzzRzAouul
	 jSIXouiAGkXOJFczUzvMhOK2Gr6GQg89qJ6Bf1mRDLrLrEjGLTHgNjWjGNofT+UXtt
	 WdscCVix+MpyDEZX1johrIYfjB6a5m9RB3SOroN64tXkj22X2V+swhw4LjDMeH/3p7
	 1SjH/tkgxNm0/x3EOWlnRaMe6GOfuWAkv2QiJFkAWyUwwOBpn1HwaGhlDgHQCACVMX
	 4Eya1erLKHGww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] Input: rmi4 - fallback to platform data for x/y-mm
 in F12
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Heidelberg" <david@ixit.cz>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260731-respect-x-y-mm-v1-2-3e85a4bec745@ixit.cz>
References: <20260731-respect-x-y-mm-v1-0-3e85a4bec745@ixit.cz>
 <20260731-respect-x-y-mm-v1-2-3e85a4bec745@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 18:23:14 +0000
Message-Id: <20260731182314.D00EA1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential kernel panic due to division by zero if the device firmw=
are returns 0 for DPM resolution.
- [High] Potential read of uninitialized stack memory when parsing device s=
ubpackets.
- [High] Truncation of physical dimensions `x_mm` and `y_mm` for devices la=
rger than 255 mm.
--

--- Patch [2]: [PATCH 2/2] Input: rmi4 - fallback to platform data for x/y-=
mm in F12 ---
commit 825204fcd696c68bb8002a2ae57765aed06fc9e4
Author: David Heidelberg <david@ixit.cz>

Input: rmi4 - fallback to platform data for x/y-mm in F12

When detection for touchscreen-x-mm / y-mm returns 0, fallback to the
platform data, so we get meaningful values.

> diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
> index 88797556e738c..6f2e98c3a3499 100644
> --- a/drivers/input/rmi4/rmi_f12.c
> +++ b/drivers/input/rmi4/rmi_f12.c
> @@ -199,8 +199,19 @@ static int rmi_f12_read_sensor_tuning(struct f12_dat=
a *f12)

[Severity: High]
This isn't a bug introduced by this patch, but could this lead to a kernel
panic from division by zero?

Earlier in rmi_f12_read_sensor_tuning(), dpm_resolution is read directly
from the hardware into buf:

        ret =3D rmi_read(fn->rmi_dev, query_dpm_addr, buf);
        if (ret) {
                ...
        }
        dpm_resolution =3D buf[0];

        x_mm =3D sensor->max_x / dpm_resolution;
        y_mm =3D sensor->max_y / dpm_resolution;

If a buggy or malicious device returns 0 for the DPM resolution, this will
unconditionally crash the kernel during the probe path. Should there be a=20
check for dpm_resolution =3D=3D 0 before performing this division?


[Severity: High]
This is a pre-existing issue, but does this code read uninitialized stack=20
memory when parsing device subpackets?

In rmi_f12_read_sensor_tuning(), a 15-byte stack array is declared without
initialization:

        u8 buf[15];

The driver reads item->reg_size bytes into this buffer:

        ret =3D rmi_read_block(rmi_dev, fn->fd.control_base_addr + offset,
                             buf, item->reg_size);

The size is controlled by the device descriptor. The driver then uses offse=
ts
to access this buffer based purely on rmi_register_desc_has_subpacket(),
without ensuring item->reg_size actually covers the accessed offsets.

If a device supplies a small reg_size but claims all subpackets are present,
could this read past the initialized portion of buf and leak kernel stack
memory or cause erratic behavior?

>  			 "platform data y_mm (%d) !=3D detected y_mm: (%d)\n",
>  			 sensor->y_mm, y_mm);
> =20
> -	sensor->x_mm =3D x_mm;
> -	sensor->y_mm =3D y_mm;
> +	if (x_mm)
> +		sensor->x_mm =3D x_mm;

[Severity: High]
This is a pre-existing issue, but could the physical dimensions overflow on=
=20
larger devices, which this patch might now incorrectly interpret as a failu=
re?

The dimensions are calculated in millimeters and stored in u8 variables:

drivers/input/rmi4/rmi_f12.c:rmi_f12_read_sensor_tuning()
        u8 x_mm, y_mm;

And also stored as u8 in struct rmi_2d_sensor:

drivers/input/rmi4/rmi_2d_sensor.h:
        u8 x_mm;
        u8 y_mm;

For any touchscreen larger than 255 mm (approx. 10 inches), the value will
overflow and truncate. If a dimension is exactly 256 mm, it truncates to 0.

With this patch, a truncated 0 will trigger the x_mm =3D=3D 0 fallback path=
 and
incorrectly retain platform data instead of the detected value. Should thes=
e=20
dimensions be stored using u16?

> +	else
> +		dev_warn(&fn->dev,
> +			 "x_mm detection returned 0, keeping %d\n",
> +			 sensor->x_mm);
> +
> +	if (y_mm)
> +		sensor->y_mm =3D y_mm;
> +	else
> +		dev_warn(&fn->dev,
> +			 "y_mm detection returned 0, keeping %d\n",
> +			 sensor->y_mm);
> =20
>  	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: x_mm: %d y_mm: %d\n", __func__,
>  		sensor->x_mm, sensor->y_mm);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-respect-x-=
y-mm-v1-0-3e85a4bec745@ixit.cz?part=3D2
