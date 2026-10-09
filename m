Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D749444E037
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552153; cv=none; b=j0WMSPgTF0ttx+BqrelOJ+48qd9ozaxJ7avNv3Rljsrn/klOZEesBzZaPq89cUNPAWe06xJQWadUG6CV6E+T6ryOVSSLEnN5q+LLgdCHawrvSJYFF6Z8sbsmAaLHT+WPlQSRcUd8C7y8me7kky8opCG1Pw5AXIcnEgFHsQ214p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552153; c=relaxed/simple;
	bh=OPqStzbbcMr5wohJoBaOnG8sGjcDD3b35HQhkr67r+8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qgqoQYGP8aXr0NH6ev/Bqf7rkitf/yEGaaJvGQHm1XKz9038T8ygMNJHL2kbXJ4dZzRMrEfmX3HxtGsBl5RA+IchyOBVU0fYy2h+Z5+lvaHCKP3xRlSvOJyx10fYNSonbFjYX4WqXxeUudBK0ujBNw0tG01k9XJaFTlo5D1ZeDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHg6yL/N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHg6yL/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8351F000FF;
	Fri,  9 Oct 2026 13:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791552152;
	bh=hYAv/6d8YfoNI6ECFtZBJXRMgXKnlg1LCus69Brq8JQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BHg6yL/NwQp3umk+ed3lFAS7Mma2stFenPema34H6sSaMUIKLJWxH/8WKaWELbUWX
	 pI3NQt2CQiyHrvPDRWG4RiIBqCDIEbw3BcNuJiwsWUAtqqLcm1Q1/lIn2yFffumwrH
	 YBuG46iNTT5KxNyl5mJg3gljvvNlOzUC3RFBvxIhzMdk1f/32jK8a6Rg7bwYzQ5XEx
	 7FNaUxpkipZGLNH+Bn8kjqVh1KhvhamLSJCuw6QNHFbCDR3HQkZve6gXJ6bdiRGJAm
	 US0zVTKCQqKCoPYHOrG/WcKoJPeh3CKHp/W3k/qgcGBj4N/MyEasjBgoAQNfZgg1t5
	 mzydkj/dylsqw==
Message-ID: <sashiko-outbox-165624@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 07/12] HID: asus: add joysticks anti-deadzone
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261009122820.7603-8-denis.benato@linux.dev>
References: <20261009122820.7603-1-denis.benato@linux.dev>
 <20261009122820.7603-8-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 13:22:31 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] sysfs: unconditional range attribute exposure for unsupported featu=
res
--

commit 82e5ab56095fcef34b4dde73bbddbf61750ae376
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add joysticks anti-deadzone configuration

ROG Ally devices allow configuring the anti-deadzone parameter for
the resistive joysticks devices as over time those develops drift,
therefore allow userspace to configure the anti-deadzone by exposing
relevant sysfs attributes.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index b692c180cd706..0d1ead3dcb6ef 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -1382,6 +1382,197 @@ static struct device_attribute dev_attr_right_joy=
stick_outer_threshold =3D
[ ... ]
> +static ssize_t left_joystick_anti_deadzone_show(struct device *dev, stru=
ct device_attribute *attr,
> +						char *buf)
> +{
[ ... ]
> +	if (!cfg->anti_deadzone_support) {
> +		hid_dbg(hdev, "Anti-deadzone not supported on this device\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return sysfs_emit(buf, "%u\n", cfg->left_anti_deadzone);
> +}
[ ... ]
> +static ssize_t left_joystick_anti_deadzone_range_show(struct device *dev,
> +						      struct device_attribute *attr,
> +						      char *buf)
> +{
> +	return sysfs_emit(buf, "0 100\n");
> +}

[Severity: Low]
Does this code expose range values unconditionally, even when the underlying
feature is not supported?

Looking at ally_config_create(), the sysfs group is created if either
user_cal_support or anti_deadzone_support is present. If a device has
user_cal_support but not anti_deadzone_support, left_joystick_anti_deadzone=
_show()
correctly rejects accesses and returns -EOPNOTSUPP.

However, this static range handler completely lacks the support check, mean=
ing
it will successfully return "0 100\n" instead of -EOPNOTSUPP.

[ ... ]
> +static ssize_t right_joystick_anti_deadzone_range_show(struct device *de=
v,
> +						       struct device_attribute *attr,
> +						       char *buf)
> +{
> +	return sysfs_emit(buf, "0 100\n");
> +}

[Severity: Low]
Does this code have the same issue as left_joystick_anti_deadzone_range_sho=
w(),
where the range values are returned unconditionally even when the device do=
es
not support the anti-deadzone feature?

[ ... ]
> @@ -1894,8 +2089,11 @@ static struct ally_config *ally_config_create(stru=
ct hid_device *hdev, struct al
>  		}
>  	}
> =20
> -	/* Skip the calibration groups when the capability is missing. */
> -	if (cfg->user_cal_support) {
> +	/*
> +	 * Skip the calibration and anti-deadzone groups when none of the
> +	 * features they expose is supported.
> +	 */
> +	if (cfg->user_cal_support || cfg->anti_deadzone_support) {
>  		int cal_i;
> =20
>  		for (cal_i =3D 0; cal_i < ARRAY_SIZE(ally_cal_attr_groups);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009122820.7603=
-1-denis.benato@linux.dev?part=3D7
