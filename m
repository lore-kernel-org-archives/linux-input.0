Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5B13DD84C
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787655221; cv=none; b=ug5loC87WSdzDFObEsUSeIVWtB0KSXKiuVqDM2OG/WwS9T85tPwc13OBleY/4mwvtWii23U//Fx4z7jdbbTz7JT+Cr5jC4B41c1xv2Fk9Qknv+IghhGbsgVnJDu+V7N/QtaoWPgcE/B1RCBI8hfyZhSFSOeMzwjkRXPryykLtx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787655221; c=relaxed/simple;
	bh=dDm8DcGUxWSyVW/B4R8Z4TozDocsWeau2HsQFVqZQ+I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SX+ovlX39snYfnTYKOX6xUEV3u6gkIgm1Yrf/H/1ggYYsbAxJuoXR5KyviMTeEXvUNGLa8Z/1I3OFoVkCB3Zq1D9KAS4XhjjmGRrE/u4QgaRy/QK/B020dRgLqCL5VJwjyS8Lu8sVIfy1oXlKuhd1/El4zUK1WTq/AZ3Gw+P1Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzd05P/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzd05P/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545ED1F00A3D;
	Tue, 25 Aug 2026 10:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787655219;
	bh=YdBFLVeTgbJF+tSjoigp0ZVEOk+NvdZa4gvgZJNIngU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kzd05P/b+UmKWRmR7nPHd05V5vyi8gLX6Col3sX2f5IZoETlF2LOG1ZX098mxEP+M
	 vN6hO1ECuaTgqs/vBn7pEFXAZxB73xMs1twU4ZVTMrPG9T3Z0P9wjLtnKSH64knBe9
	 rONpJEGooFGA5gSiko+X7UcLWq2sl2GBo9jXCRRi3u9z4FM8Prr9BQEXzpkJkLZIbp
	 2ql/Kl0BgO1uSTbhaokV9BxGskqxMVQOI1TsNVhRMZR0vuZN3QoWeSOLuf4kJU0MO0
	 5pvqVtWR0JtkV/rJlrhwsl1a4+xvb0A+pEL5vh6rJvNGEtqgoza8z7KUNU98hZy8qB
	 moeu5uCsEIVnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] Input: synaptics-rmi4 - fix irq[] overrun with 7
 interrupt sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Jie Law" <98lawweijie@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260825103123.12216-2-98lawweijie@gmail.com>
References: <20260825103123.12216-1-98lawweijie@gmail.com>
 <20260825103123.12216-2-98lawweijie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 10:53:38 +0000
Message-Id: <20260825105339.545ED1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds slab write in F11 and F12 probe functions due to an =
unconditional assumption that the device declared at least 2 interrupts.
--

--- Patch [1]: [PATCH v4 1/2] Input: synaptics-rmi4 - fix irq[] overrun wit=
h 7 interrupt sources ---
commit 6aea384b7eaeeddd41195e537ea461a05594e8d1
Author: Wei Jie Law <98lawweijie@gmail.com>

Input: synaptics-rmi4 - fix irq[] overrun with 7 interrupt sources

This commit increases RMI_FN_MAX_IRQS from 6 to 7 to match the
RMI_PDT_INT_SOURCE_COUNT_MASK. This prevents an out-of-bounds array access
when a device declares 7 interrupt sources.

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
This isn't a bug introduced by this patch, but can the unconditional setting
of fn->irq_pos + 1 in the F11 and F12 drivers lead to a slab out-of-bounds
write?

If a malicious or emulated device provides a Page Description Table where t=
he
total sum of interrupt_source_count across all functions is an exact multip=
le
of BITS_PER_LONG (e.g., 64), and an F11 or F12 function is placed at the end
with only 1 interrupt declared:

In drivers/input/rmi4/rmi_f11.c:rmi_f11_initialize():
    set_bit(fn->irq_pos + 1, f11->rel_mask);

In drivers/input/rmi4/rmi_f12.c:rmi_f12_probe():
    set_bit(fn->irq_pos + 1, f12->irq_mask + irq_mask_size);

Since mask_size is calculated as BITS_TO_LONGS(64), it allocates exactly 1
unsigned long (8 bytes). With fn->irq_pos =3D 63, set_bit(64, mask) will
attempt to modify mask[1], writing 8 bytes past the end of the devm_kzalloc
buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825103123.1221=
6-1-98lawweijie@gmail.com?part=3D1
