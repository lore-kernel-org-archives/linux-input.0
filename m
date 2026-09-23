Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FED496D28;
	Wed, 23 Sep 2026 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161370; cv=none; b=sQ2MAwOxuLNo/83Ajg2SE11+jIbOa0F3QjBUVxyV0vKu1MVK77zyp3wfEntXJSJUiQoOIrupX3cJhlw9Ggpbu4KGKrhtkDXoeAsZ+eN/8n9qdKfjqty2ytHTJjK96GY+yKoOiAlcXVpl59fb7rjtEohWpocZB7RBLlpPu3V9+yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161370; c=relaxed/simple;
	bh=dEpK0OoUO9wOCqvQzvvb6pZyNsD2zpX5gARnf3T/M50=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dkcv3zYte0GZoF8zlWNQMHODCshn0iGNN2LcGLXxr2MTTXX5nTcN0eK/cf54hljTLJUKlSyrZ/AfADYtfQn7v3/WWlQATUa7JMI82e+Lis7/3luVj6YOEjQ6FwfOUTtzVFbPleE9sHVZYSRLKy7XHmnzQot6HWpVJecXeux9GJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDlb+9cA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDlb+9cA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7FB1F000FF;
	Wed, 23 Sep 2026 11:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790161357;
	bh=CTDI8XzoYgVh4/xQUHnt47MVZ2+wAx4BXrD7bGZcBKU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZDlb+9cAiQqbOLMtoMQHX/D6w48FsGlfjp1HBBxt9LovdpZOkk7Ejcwv2OxlhtM2V
	 fOhJC/0AnDiAsX9CxN3CMec/p/jIg5mPsdaHholEiJWodGu1QkDBF1+hBiuwSbGWM/
	 sl+7aUxblvEsKEdUf5oEd17x4yo0+vxVLuNykmvAAS84/t0pz8s5ujYVvWVHtfVebT
	 U5Lrc6s+eFEK4pPTChwx0K/Extc/M+ULU6DU8eeahOt+X8t6f5w4xGuMbNEDrKMcC0
	 0hOo3XGSeX4Tg3eo4kV3nRmrXLlBS0IsMuWHucAoq3AxNi3Tq24pDbfujth767TpsV
	 CDDVGfOFmOqIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: axp20x-pek - add AXP313a support
Reply-To: sashiko-reviews@lists.linux.dev
To: Vladimir <anykey196@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260923105215.1633-1-anykey196@gmail.com>
References: <20260923105215.1633-1-anykey196@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 11:02:36 +0000
Message-Id: <20260923110236.CA7FB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] sysfs: broken startup/shutdown attributes for axp313a
--

commit 2573be3a312f98b032ff9523708d368661f8e004
Author: Vladnwx <vladnwx@users.noreply.github.com>

Input: axp20x-pek - add AXP313a support

The AXP313a MFD driver registers its power button cell as "axp313a-pek",
but the axp20x-pek platform id table only matches "axp20x-pek" and
"axp221-pek". The power button therefore never probes on boards using the
AXP313a PMIC (e.g. the OrangePi Zero 2W).

> diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-=
pek.c
> index 24f9e9d893de3..d4e2fc9a937ff 100644
> --- a/drivers/input/misc/axp20x-pek.c
> +++ b/drivers/input/misc/axp20x-pek.c
> @@ -393,6 +393,10 @@ static const struct platform_device_id axp_pek_id_ma=
tch[] =3D {
>  		.name =3D "axp221-pek",
>  		.driver_data =3D (kernel_ulong_t)&axp221_info,
>  	},
> +	{
> +		.name =3D "axp313a-pek",
> +		.driver_data =3D (kernel_ulong_t)&axp20x_info,
> +	},

[Severity: Medium]
Will using axp20x_info result in broken sysfs attributes for AXP313a?

The AXP313a platform binding unconditionally exposes startup and shutdown
sysfs files because they are hardcoded in axp20x_groups. Reading or writing
these files attempts to access the AXP20X_PEK_KEY register (0x36) in
axp20x_show_attr() and axp20x_store_attr():

drivers/input/misc/axp20x-pek.c:axp20x_show_attr() {
	...
	ret =3D regmap_read(axp20x_pek->axp20x->regmap, AXP20X_PEK_KEY, &val);
	...
}

drivers/input/misc/axp20x-pek.c:axp20x_store_attr() {
	...
	ret =3D regmap_update_bits(axp20x_pek->axp20x->regmap, AXP20X_PEK_KEY,
				 mask, idx);
	...
}

However, the AXP313a regmap configuration restricts max_register to
AXP313A_IRQ_STATE (0x21). The regmap core blocks accesses to registers beyo=
nd
max_register, meaning these sysfs accesses will definitively fail with -EIO.

Could the axp313a-pek driver be updated to avoid exposing these broken sysfs
attributes?

>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(platform, axp_pek_id_match);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923105215.1633=
-1-anykey196@gmail.com?part=3D1
