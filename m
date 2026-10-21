Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580868;
	b=3OL10g6LvCXmJBnc9mx5kwm+jHRWzg6RjgWdbockzxanRlFbIOg77jiDBZA7xvKSz+Lu
	 y9P1xOTu5VPpzmO+btsekEAzu8aMVKAhCce0zv+XVfTjSkg59aizsi9EyS9S098evCGlN
	 rFL17zAZAvxHn5ympW8sOXpxy2cMSqjbdCmxxsTDGvoQ3EYrtQKEjjSv0LQTjkzK9CTpi
	 weZyxb9cvOLBPVtibi9BLAheJAyf2wl6D0CotCCWyYdrHSPNBNOHCFYJzBi5AkrlDxrDz
	 s+ycexje0rrKxApy5rUhPqv1RxKdIArWCuCbkUmfuBF6VURXOwU5J6gmkgQyD4lf/lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580868;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9zQAcmsM+2Tsxdew3yxZz+TMabeVeJCxxpaiKMkdx4g=;
	b=prSRdW7+b99Q1euQeA4V29Sdh6RQvYS9E+moFdGknvC1YVUe+V8ZJXKyXCK/C15ndX4a
	 991azWNcu8Eyb3gJSM3IMzjBuWc9+ml/VLyyTJ1G9gUEVCwx6PbnGXXgjBkwZWOh0/xvc
	 cJvrHlL34seH2C2elw/M7K/XLUCWcArS500XMuOL13ar5nVDMsGRrKXy5uw/X8RM5Gvtm
	 L9bVAm4srt9FWJOKgoXApF6afyhh8krY00sPM2Cp4iREMw8gOUhy5FF0DA2OXxlQl6Kry
	 j4Gl5a0XoJ29EetPK9nm4SwgBBpkXuZZaNrD0IqeyMvZ86kya6iB3XYfHmF5pASDt+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VL3XAbSn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92141606A31B;
	Wed, 21 Oct 2026 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VL3XAbSn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26A81F000C9;
	Wed, 21 Oct 2026 11:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792580868;
	bh=9zQAcmsM+2Tsxdew3yxZz+TMabeVeJCxxpaiKMkdx4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VL3XAbSnz+NlFeJoPc8/a2ol2tzKc3tgqMTtHFwn0A2RwYdtly54WvXRXm3GTCBpn
	 74ng2B1F00FKhPrXUOAYYC5Cz2kUlMKhn0DFa7c94TWneT5bsURHuGAK5l0Y2mXwMU
	 yziuFD3l8DIt3ScXyKC2fNgWcl+G8QyFplOiu1Fg8vUXLPp175SkGFA0pEKOj71VIl
	 lggABs7ONUuTZux2fFuQ32qhrBsXBNVbZF12p4CPZAZWeJLmxRUIgWdHR4JMdxRRqI
	 NsGYYE+3YW9h59ktMkpO6BhhpJ5U88Hsq2ykBz5W3Jlyw3tFYpSNvTPub4KvpFplq9
	 zUR7EbpQWbWPQ==
Message-ID: <sashiko-outbox-180142@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 8/9] regulator: Add MediaTek MT6392 regulator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev, linux-gpio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org
In-Reply-To: <20261021105109.199886-9-l.scorcia@gmail.com>
References: <20261021105109.199886-1-l.scorcia@gmail.com>
 <20261021105109.199886-9-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 11:07:47 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] regulator: mt6392: OF node leak in mt6392_regulator_probe()
- [Low] regulator: mt6392: malformed kernel-doc comment on mt6392_regulator=
_info
--

commit e3d039af08fd4f6095c705dd23ad9451cd2c1fd1
Author: Fabien Parent <parent.f@gmail.com>

regulator: Add MediaTek MT6392 regulator

This commit adds a regulator driver for the MediaTek MT6392 power management
integrated circuit, supporting buck and linear regulators controlled over
regmap.

> diff --git a/drivers/regulator/mt6392-regulator.c b/drivers/regulator/mt6=
392-regulator.c
> new file mode 100644
> index 0000000000000..3db52268363e0
> --- /dev/null
> +++ b/drivers/regulator/mt6392-regulator.c

[ ... ]

> +/**
> + * MT6392 regulators' information
> + *
> + * @desc: standard fields of regulator description.
> + * @qi_status_reg: Register to query enable signal status of regulators
> + * @qi_status_mask: Mask to query enable signal status of regulators (RO)
> + * @vselctrl_reg: Vsel control mode selector register
> + * @vselctrl_mask: Vsel control mode selector mask (RO)
> + * @vsel_reg_mode_reg: Vsel register when Vsel control mode selector =3D=
 0 (Register mode)
> + * @vsel_reg_mode_mask: Vsel register mask in Register mode (RW)
> + * @vsel_normal_mode_reg: Vsel register when Vsel control mode selector =
=3D 1 (Normal mode)
> + * @vsel_normal_mode_mask: Vsel register mask in Register mode (RW)
> + * @pwm_modeset_reg: Register to control buck mode (Auto/Force PWM)
> + * @pwm_modeset_mask: Mask to control buck mode (RW)
> + * @lp_modeget_reg: Register to get LDO low-power mode
> + * @lp_modeget_mask: Mask to get LDO low-power mode (RO)
> + * @lp_modeset_reg: Register to control LDO low-power mode
> + * @lp_modeset_mask: Mask to control LDO low-power mode (WO)
> + */
> +struct mt6392_regulator_info {

[Severity: Low]
Because this comment above struct mt6392_regulator_info in
drivers/regulator/mt6392-regulator.c starts with /**, scripts/kernel-doc
parses it during W=3D1 builds and warns that the opening line does not match
"struct mt6392_regulator_info - ...".

Also, @vsel_normal_mode_mask is described as "Register mode" rather than
"Normal mode".

Should the header line be formatted as a kernel-doc struct header and the
@vsel_normal_mode_mask description updated?

[ ... ]

> +static int mt6392_regulator_probe(struct platform_device *pdev)
> +{
> +	struct mt6397_chip *mt6392 =3D dev_get_drvdata(pdev->dev.parent);
> +	struct regulator_config config =3D {};
> +	struct regulator_dev *rdev;
> +	int i;
> +
> +	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
> +
> +	// Initialize the bucks' vsel_reg and vsel_mask according to current HW=
 state
> +	if (mt6392_set_buck_vsel_reg(pdev))
> +		return -EIO;
> +
> +	config.dev =3D mt6392->dev;

[Severity: Medium]
Does calling device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent) in
mt6392_regulator_probe() in drivers/regulator/mt6392-regulator.c leak a
reference to pdev->dev.parent->of_node when the platform device is released
(for example, if mt6392_set_buck_vsel_reg() or devm_regulator_register()
fails, or when the parent device is unbound)?

In drivers/mfd/mt6397-core.c, the regulator child is defined with
MFD_CELL_NAME("mt6392-regulator"), so mfd_add_device() allocates the child
platform_device with pdev->dev.of_node and pdev->dev.fwnode both set to
null.

Calling device_set_of_node_from_dev() increments the reference count on
dev2->of_node and assigns it to pdev->dev.of_node without setting
pdev->dev.fwnode:

drivers/base/core.c:device_set_of_node_from_dev() {
	of_node_put(dev->of_node);
	dev->of_node =3D of_node_get(dev2->of_node);
	dev_set_of_node_reused(dev);
}

When the platform device is destroyed, platform_device_release() only drops
the reference on pa->pdev.dev.fwnode:

drivers/base/platform.c:platform_device_release() {
	...
	if (!is_software_node(dev_fwnode(dev)))
		fwnode_handle_put(pa->pdev.dev.fwnode);
	...
}

Because pdev->dev.fwnode is still null, the reference held by
pdev->dev.of_node is never dropped (unlike
platform_device_set_of_node_from_dev(), which also assigns
pdev->dev.fwnode =3D of_fwnode_handle(pdev->dev.of_node)).

Since mt6392_regulator_probe() already sets config.dev =3D mt6392->dev for
regulator_register() to look up the regulators node and supplies on the
parent device, should device_set_of_node_from_dev() be removed here (or
replaced with platform_device_set_of_node_from_dev())?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021105109.1998=
86-1-l.scorcia@gmail.com?part=3D8
