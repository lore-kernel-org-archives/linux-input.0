Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793795622;
	b=Dp1NM/0R58VDtLFG9BsISgJsRsvx64ZdmaOlnnGxtS19aIrRjceB1FTXcf0NGco27cxO
	 VsPpaNFjWHCWJgnWltsmL9UT6z6HYdCxFjMaXrPVvUhml5BrTvSq4PrWinBN1Rbs9d7UT
	 FnuW7A1iXK9Sgor7bT+TVdk+aguySbZENfmNmNzuh820bhqpDHn8C4sBMrj8sAPlDFm/l
	 rd9gmBAx3dM1NlXEYRHM3tT4kJAHe+0wB1tAXL4xOCFDsDp7DRHwOTVhtzYzJILur5fcc
	 L7PEtMkEWYCO2IFvLYGSSobO1RVrnpXbwamO0y/qCr6bz9/w/alvvfmVOKNud/MP6Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795622;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QTXQSnEmVHKL+w8CQeZbmsm86dtqtVVOhk3Wr0h6/Ag=;
	b=NjmZYO0Q+CDbuDFhFZWiSXAsHWthQya5tus1Kj1WEjFUHoy0ZrM+NbO76XJ3M9y3/NEl
	 1KI1ZX5XTcgxOwWy2YxrYJch0H8ZGtzsdRINQyLMjMuuMfp7OJRVtR095BQgwoHPWLDZ2
	 d8TeVBoBVuazLJR24tpKUsNIy7WzMObuvOf/U/AAOr3pWMlr5EMrT4y4RT8qJXRtIYYnL
	 iF0GEaKOTqTnZG+5UN20NQ7WE/xlxgAd0ihFF0NY0/bgbrdXm5ElTkoKomjITw3rUaHPA
	 SDWWQYDcRQHwPzLphuDz4LonmuVhrDrqZUX1JyFZ4lUY1lx+Z4Lc5LHFHEZCMLKyz3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mWQrBa18;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A160B606A332;
	Wed,  4 Nov 2026 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mWQrBa18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09BC1F000C1;
	Wed,  4 Nov 2026 12:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793795622;
	bh=QTXQSnEmVHKL+w8CQeZbmsm86dtqtVVOhk3Wr0h6/Ag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mWQrBa18FKsI6lxhWrrkrSSfuhMvddcRN+u6rup2OafUZPybmAhbWkM7RLKhgXfOr
	 YyU/zMi96ebhuEsIPFTrlxd4sTs9ir6/BOO1MJU7ifdT/lgsLegD48RQqdppb5+ilO
	 7iDA1IawvBfhfACpc92ndVn00Q8lS7mA66UP3tBI05ftKow5p7ah7SMQgR1avwAPtx
	 ksPze51p02ZdGlWMifV5Ei9kydUk3Ikcg8grM/Hv3K2oF2j6GnZJ8Pn9d3PWwCfF5o
	 Wuw0Ym1I3CSg8kv3hRZrpyvxh2oGdJE0YxbbASrmOF43JQXeBiQFI5UfnS5tYDDdaK
	 eVDSysr3ZaPXg==
Message-ID: <sashiko-outbox-197258@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 5/7] leds: Add driver for ASUS Transformer LEDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, mfd@lists.linux.dev, linux-leds@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org
In-Reply-To: <20261104122606.215629-6-clamor95@gmail.com>
References: <20261104122606.215629-1-clamor95@gmail.com>
 <20261104122606.215629-6-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 12:33:41 +0000
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
- [Medium] leds: non-standard two-part LED name format in asus_ec_led_probe=
()
- [Low] leds: missing driver prefix in commit subject
--

commit 8625f763ce281e3f67385ab547a18ea8401f88e9
Author: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

leds: Add driver for ASUS Transformer LEDs

This commit adds an LED class driver for the green and amber charging
indicator LEDs on the ASUS Transformer Pad and Dock embedded controllers.

>     leds: Add driver for ASUS Transformer LEDs
>    =20
>     ASUS Transformer tablets have a green and an amber LED on both the Pad
>     and the Dock.
>    =20
>     Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
>     Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>     Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

[Severity: Low]
This isn't a bug, but LED subsystem commit subjects normally include the
driver sub-prefix in the form "leds: <driver>: <Capitalized description>".
Should the subject line be updated to something like:

  leds: asus-transformer-ec: Add driver for ASUS Transformer LEDs

[ ... ]

> diff --git a/drivers/leds/leds-asus-transformer-ec.c b/drivers/leds/leds-=
asus-transformer-ec.c
> new file mode 100644
> index 0000000000000..f797dcefd16e6
> --- /dev/null
> +++ b/drivers/leds/leds-asus-transformer-ec.c

[ ... ]

> +static int asus_ec_led_probe(struct platform_device *pdev)
> +{
> +	const struct asusec_core *ec =3D dev_get_drvdata(pdev->dev.parent);
> +	struct device *dev =3D &pdev->dev;
> +	struct asus_ec_led *leds;
> +	int ret;
> +
> +	leds =3D devm_kcalloc(dev, ASUSEC_LED_MAX, sizeof(*leds), GFP_KERNEL);
> +	if (!leds)
> +		return -ENOMEM;
> +
> +	for (int i =3D 0; i < ASUSEC_LED_MAX; i++) {
> +		const struct asus_ec_led_config *cfg =3D &asus_ec_leds[i];
> +		struct asus_ec_led *led =3D &leds[i];
> +
> +		led->cdev.name =3D devm_kasprintf(dev, GFP_KERNEL, "%s:%s", ec->name, =
cfg->name);

[Severity: Medium]
Does formatting led->cdev.name as "%s:%s" with ec->name ("pad" or "dock")
and cfg->name ("amber" or "green") omit the function section expected by
the LED class naming convention?

Documentation/leds/leds-class.rst specifies the three-section
devicename:color:function format (or color:function when devicename is
omitted). When a two-section name containing a single colon such as
"pad:amber" or "dock:green" is exposed in /sys/class/leds/, userspace
tooling such as tools/leds/get_led_device_info.sh parses the first field
(ec->name) as the color and the second field (cfg->name) as the function.

Should led->cdev.name include the function segment as well (for example,
using LED_FUNCTION_CHARGING to form "%s:%s:" LED_FUNCTION_CHARGING)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104122606.2156=
29-1-clamor95@gmail.com?part=3D5
