Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249464F797A
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535988; cv=none; b=USZiOFiN8WXJVULkE4vrQYmKn6BguF04Ijsr2tAdXVn6mVYD1EEUcTvkaz+TCVBYvu1iNpCFZn85sDWyhoxhwgJCzrShiKh2RTsDiuUS3CvWtefm7O7VW5DeT6rTSKalgIByfJfR04Y/sNbV/ysqbipv0v55SuzH0pG3ifibOM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535988; c=relaxed/simple;
	bh=O7dbpCtdel9MBBOZCCiCKVPFm+kjkW+6/dp+lkWAkJA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O0R62bfAymJ6u8HxWNvRdtLfXbI9zA+uxb1vSF+Bd9sSq2w9c0mRifEmyhQvSCjHGEmWWy65nf0+IS/hkd0Q8yVu6aAClqjXIzF7AcrcbwLZW1+i6Pazhb9NGKhWXkn9A5MCO0FJW6knYiNqNeJq/sU4tqdyhg+uLokCsK+Dcig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOaGmqqz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOaGmqqz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C521F00A3D;
	Fri,  4 Sep 2026 15:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788535986;
	bh=fI3OnYoXLW8yM5rNBMlDWE+3RhDK8/cDphYSIf1tk3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mOaGmqqzwZ80+aj/5tU9PQ1omJo5Z1fp+keI1hexStJ+i3r8w58+7weoLkA2OYG86
	 4jGtfhuVippJtwPyMA+BjJUxfT6paF+r4QdTxQrkOnt/Li5I7+7oKDienwjNRovPGK
	 rPpBaobpqrmQEylW33hP+5fJkKO786Fi4ZPhb8XlkRFnB57fRXqdmtLjQW9azSfP0H
	 n3fjpEgGS1x9bBRM1MoKPkEipZRPBUZ9eUEIVhV1Dqv1C7cM2fBZV4nTnJpgflV54b
	 femIMBNv0U+aH3ZIEqAdnHpoY8jf9yPPndUgMdzqY+sTxQcprEP9YMqghwCAP9GZRH
	 j5f6SaUf+kW9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/13] HID: asus: add support for response curve
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260904145845.184887-10-denis.benato@linux.dev>
References: <20260904145845.184887-1-denis.benato@linux.dev>
 <20260904145845.184887-10-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 15:33:05 +0000
Message-Id: <20260904153306.73C521F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unvalidated and unapplied response curve staging state is writte=
n directly to the hardware during device resume or initialization.
--

commit 6cddd64369499945295736ad70e3538bc1b70719
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for response curve

This commit adds support for configuring the response curve of the joysticks
on ROG Ally devices by exposing sysfs attributes.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index cddb72973bae7..5c3749a914b7f 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -1867,6 +1890,396 @@ static struct device_attribute dev_attr_right_tri=
gger_range_upper_limit =3D
> +static int response_curve_apply(struct ally_handheld *ally,
> +				struct hid_device *hdev,
> +				struct ally_config *cfg, bool is_left)
> +{
> +	struct ally_joystick_resp_curve curve;
> +	int ret;
> +
> +	guard(mutex)(&cfg->config_mutex);
> +
> +	if (!cfg->resp_curve_support)
> +		return -EOPNOTSUPP;
> +
> +	curve =3D is_left ? cfg->left_curve : cfg->right_curve;
> +
> +	if (!(curve.entry_1.move < curve.entry_2.move &&
> +	      curve.entry_2.move < curve.entry_3.move &&
> +	      curve.entry_3.move < curve.entry_4.move))
> +		return -EINVAL;

[ ... ]

> +static ssize_t response_curve_move_store(struct device *dev,
> +					 const char *buf, size_t count,
> +					 struct ally_config *cfg, bool is_left,
> +					 unsigned int idx)
> +{
> +	struct ally_joystick_resp_curve *curve;
> +	u8 value;
> +	int ret;
> +
> +	ret =3D kstrtou8(buf, 10, &value);
> +	if (ret)
> +		return ret;
> +
> +	if (value > 100)
> +		return -EINVAL;
> +
> +	guard(mutex)(&cfg->config_mutex);
> +
> +	if (!cfg->resp_curve_support)
> +		return -EOPNOTSUPP;
> +
> +	curve =3D is_left ? &cfg->left_curve : &cfg->right_curve;
> +
> +	switch (idx) {
> +	case 1:
> +		curve->entry_1.move =3D value;
> +		break;

[Severity: Medium]
Since this modifies the shared configuration state without validating it
against other curve entries, is it possible for the curve to be left in an
invalid, non-monotonic state?

If a user writes invalid values without successfully calling
response_curve_apply(), this unvalidated state remains in cfg->left_curve.

[ ... ]

> @@ -2425,6 +2876,22 @@ static int hid_asus_ally_init(struct hid_device *h=
dev, struct ally_handheld *all
>  					 ret);
>  	}
> =20
> +	if (cfg->resp_curve_support) {
> +		ret =3D ally_set_joystick_resp_curve(ally, hdev, JOYSTICK_LEFT,
> +							   &cfg->left_curve);

[Severity: Medium]
Could this unconditional push to the hardware during initialization or resu=
me
send an invalid response curve to the MCU?

Because response_curve_move_store() directly modifies cfg->left_curve
without ensuring the entries are strictly monotonic, this path bypasses the
validation checks present in response_curve_apply().

Sending unvalidated hardware state could result in unexpected device
behavior or garbage joystick data.

Would it be better to stage the sysfs changes in a separate buffer, or
validate the curve here before writing it to the device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904145845.1848=
87-1-denis.benato@linux.dev?part=3D9
