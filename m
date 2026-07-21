Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E5E37F748;
	Tue, 21 Jul 2026 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784633657; cv=none; b=CR67z7nDb+sOCsqNJaB6pe4E9XKx+LCIsUXnNl1544m+PTUGwpqYuaviXeynPxCB9arJciHYDh2BoS99KeAaEOjLo6leiESN3QNFShuiJmqtmWTEoEAWAH4GVmlIZNv1LfDw9/87GJb5iE7/I9ZKyFqcfeV1FiMO10xby28FaLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784633657; c=relaxed/simple;
	bh=U7ethrPjro+nIvxVbVI4DNqf/NwFyZOadItqvfnFUts=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vy8w3kdjTOeW97hl9V7T2p/Y3BiWzs/o7WIDyr3bfAN1hp0nhHLIsKmvoR0edW/LxCfLnubyd+cv7kd1osFB+RyboblIdLBpP3W+SXh5anWjI/5cTfMwD15S5/D9T/T5Gyp6gBth65WEqh9EJWC5pwxI1pVs2dZdsNEO7C6+BVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCXqL6Ma; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCXqL6Ma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655C01F000E9;
	Tue, 21 Jul 2026 11:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784633648;
	bh=PArcXuGcxVkYbHbZ0JDAmL4nZr7XyevIyRu/GP8HdQk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PCXqL6MafXzNC1VPH8DkyClaoNyl35lEe6/++vtT6LqpyJGu0Napu9U2OpYQIssT8
	 iQcovEHdwpAd0TZF+ESJ7wvd5HPNicTJyrZKcIUP5B97LlezwCasyN7eRrUkZXtq5+
	 HKiWkpjixo5DWAWS91zj+QY2UW1RPYEdWSpyDOntt7f8z3aYpifKzQcZ5bZW+A1G9k
	 r10izde39OCpsLYvJyMjnO+JrFM2L6F7Fi+mcEFBRSRd8cFaEzQJJsrBhIgW1gF3o4
	 2CnIiO93wuUCjSp02XDtl315jvE9bVkkgWT2nlw5mrZFZDmV3Y6GNwmtpcDYDsbUex
	 i/IXExfRcO5SQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] dt-bindings: input: Convert TI TPS65217 power
 button to DT schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Bostina" <egbostina@gmail.com>
Cc: conor+dt@kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org, devicetree@vger.kernel.org, lee@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260721112133.70382-4-egbostina@gmail.com>
References: <20260721112133.70382-1-egbostina@gmail.com>
 <20260721112133.70382-4-egbostina@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 11:34:07 +0000
Message-Id: <20260721113408.655C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing NULL check on `dev_get_regmap` can lead to a kernel panic =
in the IRQ handler.
- [High] The driver incorrectly masks `platform_get_irq()` error codes with=
 `-EINVAL`, breaking probe deferral.
--

--- Patch [3]: [PATCH v3 3/4] dt-bindings: input: Convert TI TPS65217 power=
 button to DT schema ---
commit 7ffa82f06e0d099b257abd8ec45ed224af6ff3c6
Author: Eduard Bostina <egbostina@gmail.com>

dt-bindings: input: Convert TI TPS65217 power button to DT schema

Convert the Texas Instruments TPS65217 and TPS65218 Power Button
bindings to DT schema.

drivers/input/misc/tps65218-pwrbutton.c:tps6521x_pb_probe() {
        ...
        pwr->regmap =3D dev_get_regmap(dev->parent, NULL);
        ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does this code need to check
if pwr->regmap is NULL?

If dev_get_regmap() returns NULL due to an incomplete device tree, it seems
this could lead to a kernel panic during an interrupt when tps6521x_pb_irq()
dereferences it:

drivers/input/misc/tps65218-pwrbutton.c:tps6521x_pb_irq() {
        ...
        error =3D regmap_read(pwr->regmap, tps_data->reg_status, &reg);
        ...
}


drivers/input/misc/tps65218-pwrbutton.c:tps6521x_pb_probe() {
        ...
        irq =3D platform_get_irq(pdev, 0);
        if (irq < 0)
                return -EINVAL;
        ...
}

[Severity: High]
This is also a pre-existing issue, but does masking the return value of
platform_get_irq() break probe deferral?

If platform_get_irq() returns -EPROBE_DEFER, converting the error to -EINVAL
prevents the driver core from handling the deferral and retrying later.

> diff --git a/Documentation/devicetree/bindings/input/ti,tps65217-pwrbutto=
n.yaml b/Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml
> new file mode 100644
> index 0000000000000..3526d8b045fd2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721112133.7038=
2-1-egbostina@gmail.com?part=3D3
