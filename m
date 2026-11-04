Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793796046;
	b=UlaJr+xIMoXjlW+tbp2jx++KDz3mlQ8f6tM3zH17rlmbgPYEF0rDiuztkv/dYrCk1UL9
	 0goSYiD1xsu3jLQwuVN+C/ivuTOnNnag6InOhGGETPxfYCoXKs8kYiuKd6LbNZCR0frDN
	 Iz9Vxt1l/nESPgYkPyGm1DSZn+8141bOady00o713hcK5NgWhqB9Q0GMLEeE4lqfQMJek
	 E4lV1/lvxZOM4WI0lNAZCeFJq2Yst/kynxRBY6xUKSxeA8IoFhbz77zOV86xN0OUEPOig
	 qGRg02s8aHAxxQ31G0R1WsvqLV5S9eJZ0GwDjKmmgmkIuX+PKe2h8F1rDdzjZ9/GJIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796046;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L0zQlxDmOGobbEbvtBPiR2UkkBFYt7715ct0OxHv4qA=;
	b=MVl1Td89M6oZ1aDqeTukECOXhCok1XEuTZLksomeACCdxMXdu4i5FBq+XHHKEQ7YMHBN
	 4FWPMiQZKgJW3G5YzP0RBycMDgsCHx4rJzLm3sxNgmVdTS36IIr/jVuANf4DYjbSEDc/2
	 zIcEJcDkK1l7UKQEuen5wJVLt1ZnZpLvKPV5Q9egVUtxnJU4TCa7HiYurio92qBoPpc0l
	 CP9xcx9kCwEFi/rV5iJT765eb1UJtnTW5VUR+fYzHlL/nnuddKC44RPS+C0hmpAmEOopm
	 TwmUHIHDXgrhr+sjjtBPw5XC1gaoSCXOHIbjbIZ7WLKfjrqKHazsjV9D0sjyNrwQfYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SfQ66bCQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C17606A31B;
	Wed,  4 Nov 2026 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SfQ66bCQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C391F000C1;
	Wed,  4 Nov 2026 12:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793796045;
	bh=L0zQlxDmOGobbEbvtBPiR2UkkBFYt7715ct0OxHv4qA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SfQ66bCQNJi8JP7xKqrVfvAGtutM77y5u410VMSielq0gf5Vf0de84HykDpZgvoWi
	 sPX8ufSpzDMO1lSuceCCKsuC4MXEdolK+QXGkJYCGdoF9ZPyzPjddwU/TmwQlcopSt
	 173MFaeWU+t+dLiOFs53O1e3d2bcb4auIoS77OgHYaCYnZ5Gv5B6C84AF3Ij/zmC6z
	 ydc5lxww83ofhs5xpKreUMnBGOl4i/0sW1JcuMNVADVrNlJN7s0TMupKNV9vL7zldl
	 TW3z7iuT642SD+GQlnOdvCNHru0h8/H87ZpvdkPijBSERr58uXumIZss85A/X5X4pi
	 IBXtWjHuZ9ucQ==
Message-ID: <sashiko-outbox-197282@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 4/7] input: keyboard: Add driver for ASUS
 Transformer dock multimedia keys
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, mfd@lists.linux.dev, linux-leds@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org
In-Reply-To: <20261104122606.215629-5-clamor95@gmail.com>
References: <20261104122606.215629-1-clamor95@gmail.com>
 <20261104122606.215629-5-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 12:40:44 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] input: keyboard: u8 overflow and page mixup in asus_ec_keys_proc=
ess_key()
--

commit ba1df1a44a7f539aae799312892bb55d53afd18c
Author: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

input: keyboard: Add driver for ASUS Transformer dock multimedia keys

This commit adds an input driver for the ASUS Transformer Mobile Dock
multimedia top button row, defaulting to F1-F12 function keys and allowing
switching to multimedia keys with ScreenLock + AltGr.

> diff --git a/drivers/input/keyboard/asus-transformer-ec-keys.c b/drivers/=
input/keyboard/asus-transformer-ec-keys.c
> new file mode 100644
> index 0000000000000..5a8fb86a97555
> --- /dev/null
> +++ b/drivers/input/keyboard/asus-transformer-ec-keys.c
> @@ -0,0 +1,216 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/array_size.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/mfd/asus-transformer-ec.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#define ASUSEC_EXT_KEY_CODES		0x20
> +
> +struct asus_ec_keys_data {
> +	struct notifier_block nb;
> +	struct asusec_core *ec;
> +	struct input_dev *xidev;
> +	unsigned short keymap[ASUSEC_EXT_KEY_CODES * 2];
> +	bool special_key_mode;
> +};

[ ... ]

> +static int asus_ec_keys_process_key(struct input_dev *dev, u8 code)
> +{
> +	struct asus_ec_keys_data *priv =3D dev_get_drvdata(dev->dev.parent);
> +	unsigned int key =3D 0;
> +
> +	if (code =3D=3D 0)
> +		return NOTIFY_DONE;
> +
> +	if (priv->ec->right_alt_pressed) {
> +		priv->ec->special_combo_triggered =3D true;
> +
> +		/* Flip special key mode state when pressing SCREEN LOCK + R ALT */
> +		if (code =3D=3D 1) {
> +			priv->special_key_mode =3D !priv->special_key_mode;
> +			return NOTIFY_OK;
> +		}
> +	}
> +
> +	/*
> +	 * Relocate code to second "page" if pressed state XOR's mode state
> +	 * This way special key will invert the current mode
> +	 */
> +	if (priv->special_key_mode ^ priv->ec->right_alt_pressed)
> +		code +=3D ASUSEC_EXT_KEY_CODES;
> +
> +	if (code < dev->keycodemax) {
> +		unsigned short *map =3D dev->keycode;
> +
> +		key =3D map[code];
> +	}
> +
> +	if (!key)
> +		key =3D KEY_UNKNOWN;
> +
> +	asus_ec_keys_report_key(dev, code, key, 1);
> +	asus_ec_keys_report_key(dev, code, key, 0);
> +
> +	return NOTIFY_OK;
> +}

[Severity: Medium]
Should asus_ec_keys_process_key() validate that code < ASUSEC_EXT_KEY_CODES
before setting priv->ec->special_combo_triggered and offsetting code by
ASUSEC_EXT_KEY_CODES?

In asus_ec_keys_setup_keymap(), dev->keycodemax is set to
ARRAY_SIZE(priv->keymap) (0x40), spanning both keymap pages:

drivers/input/keyboard/asus-transformer-ec-keys.c:asus_ec_keys_setup_keymap=
() {
	...
	dev->keycode =3D priv->keymap;
	dev->keycodesize =3D sizeof(*priv->keymap);
	dev->keycodemax =3D ARRAY_SIZE(priv->keymap);
	...
}

When asus_ec_keys_notify() passes data[2] to asus_ec_keys_process_key() wit=
h a
raw code >=3D ASUSEC_EXT_KEY_CODES (0x20), a few issues can occur:

1. If priv->ec->right_alt_pressed is true, priv->ec->special_combo_triggere=
d is
   set to true even for out-of-range codes.

2. When (priv->special_key_mode ^ priv->ec->right_alt_pressed) is false, a =
raw
   code in 0x20..0x3f passes code < dev->keycodemax (0x40) and indexes into
   the second page (multimedia keys) in map[code] instead of reporting
   KEY_UNKNOWN.

3. When (priv->special_key_mode ^ priv->ec->right_alt_pressed) is true, add=
ing
   ASUSEC_EXT_KEY_CODES (0x20) to the 8-bit u8 code overflows for raw codes=
 in
   0xe0..0xff, wrapping code into 0x00..0x1f (the first page of map[]) and
   reporting the wrapped value via MSC_SCAN instead of KEY_UNKNOWN. For raw
   codes in 0x20..0xdf, MSC_SCAN is also reported with code + 0x20 rather t=
han
   the raw code.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104122606.2156=
29-1-clamor95@gmail.com?part=3D4
