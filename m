Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C93923EA84
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 06:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787639042; cv=none; b=a7M2rtmCg/2ENxq1t+0AvrT780fT+p4m864enTBOdzbR18LvUeWsH52/qT9AxcknW/K9nwwiMVVVZHKLEsw9pvAZijPDZMZRFYhC9syf2JcE2J+0jIYBcPDFCQNB7Sub3rRSimfU2VmRhoSi94dGmKS5Bt77hH8YsmOM3uZrRck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787639042; c=relaxed/simple;
	bh=T7mscTlWJThrtr0KUl1iqv5e4dFId2J5JzuqD/a3R2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gksfdv0iQ5tqa4TC0a5ILGsnmd60pJIfgRzdcR5EFB1EGAzTKPreQqL22yWbAsFUwZ8DLznhBfxDGO8QJMGXX8dPjfK2Gu5MH5hNVkm7NPPO5ixdvOefFCmVfdNrGa88C5cKUfwWZhCDEdeckmh+eQXMbPP+QX9eO7Idb+c19po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+xZ6QW5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+xZ6QW5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A281F000E9;
	Tue, 25 Aug 2026 06:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787639040;
	bh=tA8omPNnqfemj8QbQElHv6rArVkGBR+E5t/pdfkwbxs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l+xZ6QW5hqyA8tC2D2m00Z/ErlnxD3MAAPN9OgiHPBpEwTPS7/WMzrpQtv1hpbLsd
	 NYO1Jf1EYmn5xBdGPq7Cejz5kZRtE6WfzjJRwjkG7gwxSYyQA2mXxQGjCnAoRtqm7A
	 L4ftttNhYXS4WurK8ssGyA/jP6xwkfqvlMY6mD5rtWgBGtVIb2vHUpqBHvBmgwPPnD
	 ndRRlqhLWYvS2Lf0u2rDiVRBN4mNx6ttAQiPRJk2x5fjD/enFjdjyQyaKPbNleGl8T
	 qHTI08FJ6awrtkKCJGfo1uKuKQG0Sp0CcmFNdxQJbIJFmoa4K3qLrVP1D7xlUe1DxL
	 yEbRqnivRVN9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] Input: synaptics-rmi4 - fix irq[] overrun with 7
 interrupt sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Jie LAW" <98lawweijie@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260825061027.105062-2-98lawweijie@gmail.com>
References: <20260825061027.105062-1-98lawweijie@gmail.com>
 <20260825061027.105062-2-98lawweijie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 06:24:00 +0000
Message-Id: <20260825062400.A8A281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A malicious device reporting an interrupt source count of 0 can tr=
igger an out-of-bounds memory write during function initialization in F11 a=
nd F12 functions.
--

--- Patch [1]: [PATCH v3 1/2] Input: synaptics-rmi4 - fix irq[] overrun wit=
h 7 interrupt sources ---
commit cc9ceca86b18ef61f6b6360e9c31ded31f4d76e9
Author: Wei Jie Law <98lawweijie@gmail.com>

Input: synaptics-rmi4 - fix irq[] overrun with 7 interrupt sources

This commit addresses an array-index-out-of-bounds issue when a device
declares 7 interrupt sources. It increases RMI_FN_MAX_IRQS to 7 to match
the three-bit interrupt source count field in the function descriptor.

> diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
> index 90122df21f746..faf2ebb00d521 100644
> --- a/drivers/input/rmi4/rmi_bus.h
> +++ b/drivers/input/rmi4/rmi_bus.h
> @@ -12,10 +12,13 @@
>  struct rmi_device;
> =20
>  /*
> - * The interrupt source count in the function descriptor can represent u=
p to
> - * 6 interrupt sources in the normal manner.
> + * The interrupt source count in the function descriptor is a three bit =
field
> + * (RMI_PDT_INT_SOURCE_COUNT_MASK), so a device can legitimately declare=
 up to
> + * 7 interrupt sources for a single function.  irq[] must be able to hol=
d all
> + * of them: rmi_create_function_irq() and rmi_unregister_function() both=
 walk
> + * it up to fn->num_of_irqs.
>   */
> -#define RMI_FN_MAX_IRQS	6
> +#define RMI_FN_MAX_IRQS	7

[Severity: High]
This is a pre-existing issue, but since we're looking at edge cases for
interrupt source counts, can a malicious or emulated device trigger an
out-of-bounds heap write if it advertises an interrupt_source_count of 0?

In drivers/input/rmi4/rmi_f11.c:rmi_f11_initialize():

    mask_size =3D BITS_TO_LONGS(drvdata->irq_count) * sizeof(unsigned long);
    f11 =3D devm_kzalloc(&fn->dev,
                       sizeof(struct f11_data) + mask_size * 2,
                       GFP_KERNEL);
    // ...
    set_bit(fn->irq_pos, f11->abs_mask);
    set_bit(fn->irq_pos + 1, f11->rel_mask);

If drvdata->irq_count is 0, mask_size evaluates to 0, leaving 0 extra
bytes allocated for the masks. However, set_bit() is called unconditionally,
which would write past the end of the f11 allocation.

A similar situation appears to exist in
drivers/input/rmi4/rmi_f12.c:rmi_f12_probe():

    irq_mask_size =3D BITS_TO_LONGS(drvdata->irq_count);
    // ...
    f12 =3D devm_kzalloc(&fn->dev,
                       struct_size(f12, irq_mask, irq_mask_size * 2),
                       GFP_KERNEL);
    // ...
    set_bit(fn->irq_pos, f12->irq_mask);
    set_bit(fn->irq_pos + 1, f12->irq_mask + irq_mask_size);

If drvdata->irq_count is 0, the flexible array irq_mask is 0-sized, yet
set_bit() is still executed. Should these functions validate that irq_count
is greater than 0 before allocating and setting bits?

> =20
>  /**
>   * struct rmi_function - represents the implementation of an RMI4

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825061027.1050=
62-1-98lawweijie@gmail.com?part=3D1
