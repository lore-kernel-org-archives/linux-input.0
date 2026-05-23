Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4550C221FB6
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779553122; cv=none; b=X+pPE6PbQLGjgiv0umDkaVZxHOA6Q2hn9wpCms8STuFrnmGf68LcRRK3xR0FDcUWTqCrTEdg3UBtR5GGDkOBk3OGLbQ0YtT5Hg0oxp19sNPr+/BSEyEyHFQPfgFo9JFFsX2wbofxlb6hdm2fnJqgU/cyZS65hGbN/CQRyDGIuYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779553122; c=relaxed/simple;
	bh=j9/dPyCuN147QVpNad1ZTvqBiMsyFzAI2bgF10Z8JkI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nTajaevDToeRFK/fkBoSKNJXAuvVYSt2Jr9bNBhYJfBi7c6DNCopRIkrc+hgzo6dJvMuPKq5bfNIVyZE2NPbN/F1UeLYUrYpuP34cv0SuK+GC3LxWLSvLvlbShDhzGg7d7BQDD1WlIy3RQnhz2H+TMpb1EMNM0FgPwJtLFYgHWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYwviG9M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYwviG9M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B051F000E9;
	Sat, 23 May 2026 16:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779553121;
	bh=OR2ifn/IClOF6RuTXL8RmQ1ah3bjGcFdkCjysTFfPFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GYwviG9MG44qDipgbaLPyl0S2zAn1eNJ3eF0QMZf62PYXNFp+/n/bwyQ9WaWUbIq6
	 uz8K6BHt9xRpZ5WuezwXl5Rdcc/gcdqqxdqpi853J3imSefGJpyj2dVlZZmherUk7R
	 XrGhImxfdvn8Hv6Wz4eKhc69dH1G99pjxvzVVDEpauYdMnS26AFgGQ8rkDjWqk3z5t
	 yB1FAs4F0QfPBAxpRer15xrCFr6MsXwz+Mg7ygJyGt6yt4iUA+Cslz/gGrxyEYfb7a
	 5uEJUcC8AQAm6+/YAJyWgn44TRYAqKJCq0ZweEcSOyc8OLYl53Ph/wV2GnixWp4i3j
	 Ji0D7emnWZu0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] Input: atmel_mxt_ts: Allow per-board config via
 DT compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hendrik Noack" <hendrik-noack@gmx.de>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260523152332.86864-2-hendrik-noack@gmx.de>
References: <20260523152332.86864-2-hendrik-noack@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 16:18:40 +0000
Message-Id: <20260523161841.06B051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The OF device node reference for the root node is leaked when fa=
lling back to the generic configuration loader.
- [Medium] Mismatch between the constructed firmware filename and the filen=
ame documented in the commit message.
--

commit e3439c3fb5cf6c8c740fae5a27659ea3cb9e7436
Author: Hendrik Noack <hendrik-noack@gmx.de>

Input: atmel_mxt_ts: Allow per-board config via DT compatible

This commit modifies the Atmel maXTouch driver to load a board-specific
configuration file based on the device tree compatible string. If the speci=
fic
configuration file is not found, it falls back to the original generic
configuration behavior.

> Extend the driver to support per-board config files keyed by the device
> tree compatible string. For DT-based systems, the driver now looks up the
> primary compatible of the board and searches for a config file named:
>=20
>   atmel/maxtouch,<compatible>.cfg

[Severity: Medium]
The documentation in the commit message uses a comma before the compatible
string, but the code implementation constructs the filename using a dot.

Is it intended to use a dot here, and if so, could the commit message
be updated to match the code?

> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/tou=
chscreen/atmel_mxt_ts.c
> index 07690c3bff06e..a9e9f151d0424 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c

[ ... ]

> @@ -2233,6 +2235,64 @@ static void mxt_config_cb(const struct firmware *c=
fg, void *ctx)

[ ... ]

> +static int mxt_invoke_config_loader(struct mxt_data *data, bool device_s=
pecific)
> +{
> +	struct device_node *root;
> +	char *board_type =3D NULL;
> +	char *fw_name;
> +	void (*cb)(const struct firmware *fw, void *context);
> +	int error;
> +
> +	root =3D of_find_node_by_path("/");
> +	if (device_specific && root) {
> +		const char *tmp;
> +
> +		if (!of_property_read_string_index(root, "compatible", 0, &tmp))
> +			board_type =3D kstrdup(tmp, GFP_KERNEL);
> +
> +		of_node_put(root);
> +	}

[Severity: Medium]
Does this leak the root device node reference when device_specific is false?

The call to of_find_node_by_path() unconditionally acquires a reference,
but of_node_put() is only called inside the if block. The fallback
configuration path triggered from mxt_board_config_cb() passes false
for device_specific, which would bypass the release.

> +
> +	if (board_type) {
> +		/* get rid of '/' in the compatible string to be able to find the FW */
> +		strreplace(board_type, '/', '-');
> +
> +		fw_name =3D kasprintf(GFP_KERNEL, "%s/%s.%s%s", MXT_CFG_FOLDER, MXT_CF=
G_NAME,
> +				    board_type, MXT_CFG_EXTENSION);

[Severity: Medium]
Does this format string construct the filename with a dot instead of the co=
mma
described in the commit message?

This format string expands to atmel/maxtouch.<compatible>.cfg which might l=
ead
to unexpected firmware loading failures for users following the naming sche=
me
documented in the commit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523152332.8686=
4-1-hendrik-noack@gmx.de?part=3D2
