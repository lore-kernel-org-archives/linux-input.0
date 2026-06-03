Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85125405C4D
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 08:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473768; cv=none; b=SAAp/zheqfXM2/aexftBSgm1N9Ky8koO8X/1esY+Lix5KspMKJs5UXcxomHJHNLs9UzxrZPgSUuHlzxYvWxJHjI+sh4pU9YG8ZRan2LdfEpfWniO/o/M2Asjly5q88uFZVsIV4Z7ljBMIwBQZxC0m6aEcY4jCr3KkRzQlS4DRKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473768; c=relaxed/simple;
	bh=ExE9cu5wXOWekyiHNSUDSLori07kgWiaYiZTlIv6meE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fExKyQV93tHd1ahRQFw0lNe+gFNpaKHZ49gcIV2PpxT0cL6U6J8D0GgNYt/5FQaXgJMMQ6Xzg+3V+F18naknlWGN28eUGn6pURTWRYgRrir0CtnLHF93+eXcIda4voF+W3Z08aHWiCL83DKZBQvBGHD122VTj0zG64XKaP9ZkKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVhBU2su; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVhBU2su"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84361F00893;
	Wed,  3 Jun 2026 08:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780473766;
	bh=dD1/dRkx0941rRgqz8RWjK81nmp0MXo5E45tY+5Fmz0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RVhBU2supWQj4JygyG51vXprOAPR8lFh/AjxZFO9IgXC63tf7q9qyyWe7kXi5pp4O
	 11YL+8EppgOKcCw2RBiNRhfytrRC5n7euj+pu7FCwd3xhFO2UFywiR8PyF9nqWOf8H
	 qDnRNEIEkQ2VpwC7zIwjmUKfbIk0x+szMN6a31zUlG4/R41i7zkCjaIvn1TRDABPCG
	 73mXM9R/FqZycdwnSr4Ctol3EeMGHZqDQtwZCtDXqf0Mq2ktf97IV2stwa6MHF2xFm
	 ZiJklEMETyUoaP9KFLvNys++YvCGz0FdOf023xCVesYZAg7f5xnrL9H+ihkhw9jAxW
	 +/9hZ95dMBxuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] Input: axp20x-pek - add is_visible callback for
 sysfs attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Feng" <steven@joint-cloud.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <tencent_ACA5ECDD5E0E1F239149E0F961FE45A65205@qq.com>
References: <tencent_ACA5ECDD5E0E1F239149E0F961FE45A65205@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 08:02:45 +0000
Message-Id: <20260603080245.C84361F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver unconditionally operates on uninitialized IRQs (0) duri=
ng suspend and resume when the input device is not registered, which can cr=
ash or hang the system.
--

commit edceaed72d31aa98549e1afb728e99699b609d10
Author: Steven Feng <steven@joint-cloud.com>

Input: axp20x-pek - add is_visible callback for sysfs attributes

This commit adds an is_visible callback to control the visibility of sysfs
attributes based on hardware capabilities. It hides the attributes for
devices without a startup_time configuration.

> diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-=
pek.c
> index 24f9e9d893de3..c1a4e5ea1e001 100644
> --- a/drivers/input/misc/axp20x-pek.c
> +++ b/drivers/input/misc/axp20x-pek.c
> @@ -193,7 +193,28 @@ static struct attribute *axp20x_attrs[] =3D {
>  	&dev_attr_shutdown.attr,
>  	NULL,
>  };
> -ATTRIBUTE_GROUPS(axp20x);
> +
> +static umode_t axp20x_attr_is_visible(struct kobject *kobj,
> +				      struct attribute *attr, int n)
> +{
> +	struct device *dev =3D kobj_to_dev(kobj);
> +	struct axp20x_pek *axp20x_pek =3D dev_get_drvdata(dev);
> +
> +	if (!axp20x_pek->info->startup_time)
> +		return 0;
> +
> +	return attr->mode;
> +}

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem in how
suspend and resume are handled when the input device is not registered.

If axp20x_pek_should_register_input() returns false (for example, on Cherry
Trail platforms with certain ACPI devices), axp20x_pek_probe_input_device()
is skipped. Since axp20x_pek is allocated with devm_kzalloc(), the irq_dbf
and irq_dbr fields remain 0.

During system suspend and resume, if device_may_wakeup(dev) is false, the
callbacks in axp20x_pek_suspend() and axp20x_pek_resume() unconditionally
execute:

        disable_irq(axp20x_pek->irq_dbf);
        disable_irq(axp20x_pek->irq_dbr);

and

        enable_irq(axp20x_pek->irq_dbf);
        enable_irq(axp20x_pek->irq_dbr);

Could this cause the driver to unconditionally call disable_irq(0) and
enable_irq(0)? On x86 architectures, tampering with IRQ 0 (typically the
legacy system timer) could cause severe system instability or kernel hangs
during the suspend and resume cycle.

> +
> +static const struct attribute_group axp20x_group =3D {
> +	.attrs =3D axp20x_attrs,
> +	.is_visible =3D axp20x_attr_is_visible,
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603074727.6133=
19-1-steven@joint-cloud.com?part=3D1
