Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A2142A96
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 20:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787170631; cv=none; b=BmzrAixjJzbFsHS9znInK9LRBZueDzayVeTgUMUXROna0p4GPp8EOaqauZG5KZ8RxoyLJBiTDcatllhB+JJrbAIa+lTne4lw0btRaibMYhFepND6Z9JPyE76q5i/RM+rD2NpC+ZvVa/zCNzCZw/eKqDXmVl4t7v0ArFhF/sZwDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787170631; c=relaxed/simple;
	bh=IMkgrmZKKeOX4p540EyHOy3l84A+JqFL49IrnkgdttU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kGmPkaUE3ua9nmprrlJgz1ov3+XL9+M49GwYWOgsaEErMRygp4qfF3zhK73JmPSMUuhY7OnqL7tlcP2dJmnovgXbcyIcL3cAr+dEN0fXgvn4bIe3CXS10p+oV4ErHsgKSK+WS5WG9lEnf1hLICGTAwuY6TqBrD2wyb/x1wBxx5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXYaaG0c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXYaaG0c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8795B1F000E9;
	Wed, 19 Aug 2026 20:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787170629;
	bh=5YLk/gIIHLnB8vfFY1XJZoFOWU1yxltRhqWntIy3zts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NXYaaG0cL1ScZNjYhysepZwYQhlImu3LC5UsogxXZonZZ1v0Ie6sfyjIJNM6SBFLf
	 km5MdgR/xiLBJnWG++8KukQt8fQGd079z75vUvk/NeAjprpzr2ANFJu5YKtSi8pfhE
	 DAsewb5rYHMKdeFZcJg7M/j2k6Rf2BfaQaUA8gAlPst5JsOBFgpmihWXhyTiXQ+y3Z
	 3Dk2o5GZDYm0Vc4SZHHYvpFQXkP1DkT9rajFzvFXTe/4xpKAUss7vqVVwNr9TYJ0fj
	 olwjrjobmgUv8zw7gdRSRaaSNOPK0UhkS858lPi0acbKQAdPma7F0nbq/vti95wdm6
	 gJNhQr4KUd1zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/12] HID: asus: add support for response curve
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260819195835.1649657-9-denis.benato@linux.dev>
References: <20260819195835.1649657-1-denis.benato@linux.dev>
 <20260819195835.1649657-9-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 20:17:09 +0000
Message-Id: <20260819201709.8795B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Inconsistent capability check for response curve sysfs read oper=
ations.
--

--- Patch [8]: [PATCH v2 08/12] HID: asus: add support for response curve -=
--
commit 64bba5ccd81bdede00727b014f07c871c53e11d2
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for response curve

This commit adds the ability for userspace to modify the response curve of
both joysticks on ROG ally devices by exposing relevant sysfs attributes.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 050d979f4315d..6f43b7317168f 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> +static ssize_t response_curve_pct_show(struct device *dev,
> +				       char *buf,
> +				       struct ally_config *cfg, bool is_left,
> +				       unsigned int idx)
> +{
> +	struct ally_joystick_resp_curve *curve;
> +	int ret =3D -EINVAL;
> +
> +	scoped_guard(mutex, &cfg->config_mutex) {
> +		curve =3D is_left ? &cfg->left_curve : &cfg->right_curve;
> +
> +		switch (idx) {

[Severity: Medium]
Should there be a capability check here before returning values?

The corresponding store operations check for !cfg->resp_curve_support and
return -EOPNOTSUPP, but this show function unconditionally returns the loca=
lly
initialized defaults (0, 33, 66, 100) even if the device doesn't support
response curves. Can this cause userspace feature-detection logic to
erroneously believe response curves are supported until a write fails?

> +		case 1:
> +			ret =3D sysfs_emit(buf, "%u\n", curve->entry_1.resp);
> +			break;
> +		case 2:
> +			ret =3D sysfs_emit(buf, "%u\n", curve->entry_2.resp);
> +			break;

[ ... ]

> +static ssize_t response_curve_move_show(struct device *dev,
> +					char *buf,
> +					struct ally_config *cfg, bool is_left,
> +					unsigned int idx)
> +{
> +	struct ally_joystick_resp_curve *curve;
> +	int ret =3D -EINVAL;
> +
> +	scoped_guard(mutex, &cfg->config_mutex) {
> +		curve =3D is_left ? &cfg->left_curve : &cfg->right_curve;
> +
> +		switch (idx) {

[Severity: Medium]
Similarly, should this show function also check !cfg->resp_curve_support
before returning values?

> +		case 1:
> +			ret =3D sysfs_emit(buf, "%u\n", curve->entry_1.move);
> +			break;
> +		case 2:

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819195835.1649=
657-1-denis.benato@linux.dev?part=3D8
