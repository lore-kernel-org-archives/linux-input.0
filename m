Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794922729;
	b=o+8UWYyZTLnxrmj4wLsjmz0A0n1Io+aczdYcmItDDRtfyY+j9zKDELM/w2giLue0wXnP
	 WMyd3MTE7YZK+sgcJVNoiA6FZCZewHhvRLSEkPUVDlOczYEXvPAgv9yl4Q/vNjee9GdMq
	 k+ngp7RS4aUUyfxE6mdA4cUkCYpxUJMMbEHbAvdHik60tTL+QVNqwHjOwfoA2pfQIE0R5
	 X40t6qVM/nWlfM24EAoMKltSLAnhmbS+FPZ1tX1bcfheclKhWGIy5BMdNJj3jtm9hFsJi
	 wAfptKfDy1rGxbsg/YTX90LEtwSqPWEbAOtvnVwbMA1mc/JzNanfV3j7e5nlbvv5LLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794922729;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UYydpXgMwJhMx6WxgvE6BeJyiQWGTJheG3NMC8OcOc0=;
	b=UyDGZbGuOWgVbtvPVE84+3rrEaAWg2/zc9jpyq7Z08B8eta9fWpv8qe0pjceMC/0x/bN
	 XriU69Sv+ebcH7pBXfR5Esln12D1nfPAcITWk116mQa2FAZCPHxf6w1SZKUX1uRpVKZda
	 RnHQ+CGeeRJfWIKcq/8Xt3QNDbY/ndLKDCq+TCf2zzs+ZHt8kl/uDvrSaIeGGoUjtd5/d
	 7GnQ5YGoHbq6fz14odMiGTH9wTRhgXQZu4p8liRsWzdiLb0MuQYy/0hmBNvjbvDD9cfuF
	 XcsC2A7OY+79UQKa+jKIFMnxtU5++rC4i7uzcaQC+SAtv7eleIAXRoKvQBMwl+Wqptg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nWGRJosp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B5F606A323;
	Tue, 17 Nov 2026 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nWGRJosp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B3A1F000C4;
	Tue, 17 Nov 2026 13:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794922729;
	bh=UYydpXgMwJhMx6WxgvE6BeJyiQWGTJheG3NMC8OcOc0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nWGRJosp5juLjl8H7ig9EYjakn8Scm9Nlkidn9ASBs2uitwqkU2PCLxhEVGhDSy3W
	 VR5ff4ORJurs8XCD9OhbgKPhClmPmz4jVW12iwgiCU+nVw5LNmjU18hYU0/U5g7XIN
	 hLf4WV3+y5P191NYLmN37k7zbDZWOpDHdXTsquNoIK4QmTiOtFEHPIkK3LtChF52gp
	 0zFejPcU41AF6XmOKgT0IaY3+PMFI1O37K5e4FC7gMOXRC7mQbskxUS2Yuz6cwBMkL
	 tNO5JQHCrirkl/UXZe+CiQ2VmmCwHaWwCl1fIDh/9Dfxep+Dj/Mo71pJcSL5Yi8a4L
	 sdt732QnW9SaA==
Message-ID: <sashiko-outbox-218891@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 4/6] Input: add polled SiRF AT550 resistive touch
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: yy-Local-LLM <yogo.0917.sabu@gmail.com>, devicetree@vger.kernel.org
Cc: linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261117-at550-rfc-v1-v1-4-5879573cb825@gmail.com>
References: <20261117-at550-rfc-v1-v1-0-5879573cb825@gmail.com>
 <20261117-at550-rfc-v1-v1-4-5879573cb825@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 13:38:48 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] Input: at550-ts: non-human handle in Signed-off-by and commit
  author
- [Medium] Input: at550-ts: unsafe register restore and IRQ clear order
  in at550_ts_close()
- [Low] Input: at550-ts: violation of Input subsystem error-handling and
  style rules
--

commit cf7c284aeaacb1e8a41814f52eee2edf5d3fbc10
Author: yy-Local-LLM <yogo.0917.sabu@gmail.com>

> Input: add polled SiRF AT550 resistive touch support
>
> Report raw ABS_X/ABS_Y and BTN_TOUCH using the input polling framework.
> Preserve the firmware settling settings and reject streaming/AUX
> ownership. Use standard touchscreen axis properties; keep affine
> calibration in userspace. Polling is the initial supported acquisition
> mode.
>
> Signed-off-by: yy-Local-LLM <yogo.0917.sabu@gmail.com>

[Severity: High]
Documentation/process/submitting-patches.rst requires a real human name (kn=
own
identity) in the Author header and Signed-off-by trailer rather than a hand=
le
or bot identifier such as yy-Local-LLM.

> diff --git a/drivers/input/touchscreen/at550-ts.c b/drivers/input/touchsc=
reen/at550-ts.c
> new file mode 100644
> index 0000000000000..0a208f4a92f55
> --- /dev/null
> +++ b/drivers/input/touchscreen/at550-ts.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* SiRF AT550 coordinate acquisition. Layout cross-checked with AT551 dr=
aft. */
> +#include <linux/bitfield.h>
> +#include <linux/input.h>
> +#include <linux/input/touchscreen.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>

[ ... ]

> +static int at550_ts_open(struct input_dev *input)
> +{
> +	struct at550_ts *ts =3D input_get_drvdata(input);
> +
> +	/* Polling keeps the interrupt sources disabled. Preserve CE settling. =
*/
> +	writel(3, ts->base + AT550_INTR);
> +	writel(ts->ctrl2 | GENMASK(15, 14), ts->base + AT550_CTRL2);
> +	writel((ts->ctrl1 & GENMASK(7, 4)) | BIT(11) | BIT(10),
> +	       ts->base + AT550_CTRL1);
> +	return 0;
> +}
> +static void at550_ts_close(struct input_dev *input)
> +{
> +	struct at550_ts *ts =3D input_get_drvdata(input);
> +
> +	writel(3, ts->base + AT550_INTR);
> +	writel(ts->ctrl1, ts->base + AT550_CTRL1);
> +	writel(ts->ctrl2, ts->base + AT550_CTRL2);
> +}

[Severity: Medium]
Can at550_ts_close() leave pending interrupt status latched or re-enable
coordinate acquisition and hardware interrupts?

Clearing AT550_INTR before writing AT550_CTRL1 and AT550_CTRL2 allows an
in-flight conversion to complete and reassert interrupt status before the
controller stops.  In addition, at550_ts_probe() accepts any boot-time bits
within 0xffff in ts->ctrl1 and 0xc2ff in ts->ctrl2, so restoring the unmask=
ed
values on close (unlike at550_ts_open(), which masks ts->ctrl1 to
GENMASK(7, 4)) can re-enable acquisition or interrupt generation if firmware
or a bootloader left those bits set.

> +static int at550_ts_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct at550_ts *ts;
> +	struct input_dev *input;
> +	int ret;

[ ... ]

> +	ret =3D input_setup_polling(input, at550_ts_poll);
> +	if (ret)
> +		return ret;
> +	input_set_poll_interval(input, 10);
> +	return input_register_device(input);
> +}

[Severity: Low]
This isn't a bug, but Input subsystem convention is to name the error varia=
ble
error or err, check the result of input_register_device(input), and explici=
tly
return 0 on success:

	error =3D input_register_device(input);
	if (error)
		return error;

	return 0;

Also, linux/bitfield.h is unused here while linux/bits.h (for BIT and GENMA=
SK)
and linux/mod_devicetable.h (for struct of_device_id) should be included
directly, and blank lines should separate top-level definitions and functio=
ns.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-at550-rfc-=
v1-v1-0-5879573cb825@gmail.com?part=3D4
