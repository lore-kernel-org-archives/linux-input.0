Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D67357CF5
	for <linux-input@vger.kernel.org>; Mon,  1 Jun 2026 18:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780339670; cv=none; b=Z+YMlX4q+0uRRtJZLj54qw8vmQ5ojKiwZJqkC1SDEVQkfAWCzl02IMG5sfQubT4toEVCQmjvwps8I55H2JMx5x1rThvbpMjVlTDy3jOxPqUUA9eZ7lPZYSEdUTFJq6wzEL425y0nHheLitudJ+fcxNk/6w9NzKFl1ZKwvQSZUPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780339670; c=relaxed/simple;
	bh=USeW9luT+At6uCmdYrxUTqbi1PPSYzUfxwUttQaJsm0=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KBn20Ir0L0aDF19kdAa60qshc+ZInqJqFTKe1A/6CNDnq+GHna+QPmuWcg03SXxrIznnBqpeg2Kdl95UzOcQUpZF7ukeL8km0hXMs3ZjqeryWj7kOpm6kt2w+mwuk6jPLIUE7WPMrhTph/GrcxIkv6zJz53575mzau3vrqn3mYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NO6F3uOf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO6F3uOf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843DB1F00893;
	Mon,  1 Jun 2026 18:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780339667;
	bh=+iTZgYGwbfVDseCR7fWNhE4/ZEBwUaT3SLgtdhn+7r0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=NO6F3uOfHAXWsQsO4SKIFM3iFRfAqBAbjKXDzNyxN+hvupJ2EqFkNd3tP/0mfpXv3
	 dgN/7hceJ92rBjDs6kPnHAYxURjoKMRn5omA1+sCN1QvGVgceDmNESIHXU0PaqpyER
	 6N2MO8lLK0u/9wcdQxb7sJmZs4Wgi8Z+aIQwHFA0rdMCcmODOQB92K9nzpiFwG2j/y
	 SSuXp/tESHYaOR5J7K/QZFzoG8oMVDR7XAiyyW5pdQITcsexud044zUvTb2G8zSI4X
	 jitqKbIoCdmS9LVTcnVQls6/mSCt/inYNn5u9MP9kfcmCALkIerqgVuQ8SsA00oPs0
	 vj17/3HK95RnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] HID: i2c-hid-of: Fall back to ACPI _DSM when
 hid-descr-addr is missing
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_0EE402E968E17B8EACEDFF0E9EBDDBF17E09@qq.com>
References: <tencent_0EE402E968E17B8EACEDFF0E9EBDDBF17E09@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 18:47:47 +0000
Message-Id: <20260601184747.843DB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The i2c-hid-of driver uses the ACPI _DSM fallback to obtain the HI=
D descriptor address but does not provide a restore_sequence callback to re=
-evaluate the _DSM during hibernation (S4) restore.
--

commit 3ebee1e22f96c1e99e3c6adbd49d92242f2497f9
Author: =E8=B0=A2=E8=87=B4=E9=82=A6 (XIE Zhibang) <Yeking@Red54.com>

HID: i2c-hid-of: Fall back to ACPI _DSM when hid-descr-addr is missing

This commit updates the i2c-hid-of driver to fall back to the ACPI _DSM
method for obtaining the HID descriptor address when the "hid-descr-addr"
property is missing. It specifically targets devices using the "PRP0001"
_HID with a "hid-over-i2c" compatible string. Safe default power and reset
delays are also configured for these devices.

> diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-h=
id-of.c
> index 57379b77e9778..e925e2d2cfe0d 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-of.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-of.c
> @@ -92,6 +92,36 @@ static int i2c_hid_of_probe(struct i2c_client *client)
>  	ihid_of->ops.power_down =3D i2c_hid_of_power_down;
> =20
>  	ret =3D device_property_read_u32(dev, "hid-descr-addr", &val);
> +	if (ret) {
> +		/*
> +		 * Some devices, for example the Lenovo KaiTian N60d and Inspur
> +		 * CP300L3, declare their I2C HID touchpad with _HID "PRP0001"
> +		 * and _DSD compatible "hid-over-i2c" but lack the
> +		 * "hid-descr-addr" property. Fall back to _DSM to obtain the
> +		 * HID descriptor address.
> +		 */
> +		int dsm_ret =3D i2c_hid_core_acpi_get_descriptor(dev);

[Severity: High]
Does this missing PM callback break S4 hibernation restore?

The native i2c-hid-acpi driver re-evaluates the _DSM method during hibernat=
ion
restore via its restore_sequence callback to reinitialize the hardware stat=
e,
such as switching the hardware back from PS/2 emulation to I2C-HID mode.

Because this ACPI _DSM fallback is added in i2c_hid_of_probe() without also
wiring up ops.restore_sequence in the OF driver, will these touchpads fail
to resume correctly and become unresponsive after waking from S4?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601181510.3870=
5-1-Yeking@Red54.com?part=3D3
