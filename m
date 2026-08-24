Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FA236AB57
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 12:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575340; cv=none; b=at3s0uF4WpdKABpy6eCn9k/cxmA+BH6MuTqPar8/PGBOZ/O4Jt7qSlZjos9iMZORtP1PwVIxpNIgVj0uy4OJomKSfWZ54zOZ0KwfydAk9PpGK1DwTzsvzAQdzwl6bvpkaiGqwDDBRoOHs6+HX8yx41MlTAVuHr5X/y98ZWwyS9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575340; c=relaxed/simple;
	bh=4YN31MtHRtFVPlnoG9G3nmUHm5o5HB66DyxDV0Zxtp4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pmTHYG08e0aOZx/xynsu/k1BgR4SOgpl8KiYLjgnBecUrGqopHg85LbbQ9TgWnSst76d2pbgAFj+MbG0OZ/vjz5qLO7oll5iWk19LViJuLo1QotG1e34sRNieboWrRoMflxAZ28FIbWuciUA71T9QlFyT0/ffw6yhpNorHyPPrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTUZIzgG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTUZIzgG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEFF1F000E9;
	Mon, 24 Aug 2026 12:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787575339;
	bh=yoQLJz3V1t1FQDyVMsc1c2S3M0SOexvXOwzEV5bnkOM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XTUZIzgGbDF8FnjYk7p/xrifFKC0ulykwjWGCjG0s85tgn90RoGpPza4Y2kA9Koo9
	 uZZgecBkEynx/c8BXkK6ACpiGmNLmWwpS6SGKqpnnZCWjlhYxSuAOInm3cuZziE9m0
	 IPjHCJJyCX8XKc/daPX4AJ/SCFzVoU5DTKhU9ThjDcAYqRfiWOBtEUTOSVzxCSeKep
	 G4GDV46xTv+hCgar+hN2r+qeg1PsWnU4DbiH5YHIANm/H3I4lUJ7hGMnwsCZ+33D2T
	 YlHymHSRnCQvPqSZHtBt4Ncn5H2vyDzGFKXRZK7HbGAdoI01zS3crsBC2bJcl7rYUm
	 Bynyv4QPod8Xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] Input: synaptics-rmi4 - fix irq[] overrun with 7
 interrupt sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Jie Law" <98lawweijie@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260824122733.76321-2-98lawweijie@gmail.com>
References: <20260824122733.76321-1-98lawweijie@gmail.com>
 <20260824122733.76321-2-98lawweijie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 12:42:18 +0000
Message-Id: <20260824124218.BFEFF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing error check for `irq_create_mapping()` return value.
--

--- Patch [1]: [PATCH v2 1/2] Input: synaptics-rmi4 - fix irq[] overrun wit=
h 7 interrupt sources ---
commit 8ffaede8e39380dc2ce433141763af42eefb7d4a
Author: Wei Jie Law <98lawweijie@gmail.com>

Input: synaptics-rmi4 - fix irq[] overrun with 7 interrupt sources

The commit fixes an out-of-bounds array access in the rmi4 driver by
increasing RMI_FN_MAX_IRQS from 6 to 7. A device can legitimately declare
up to 7 interrupt sources, causing the driver to overwrite memory when
indexing the irq array.

> diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
> index 90122df21f746..faf2ebb00d521 100644
> --- a/drivers/input/rmi4/rmi_bus.h
> +++ b/drivers/input/rmi4/rmi_bus.h
> @@ -12,10 +12,13 @@

[ ... ]

> -#define RMI_FN_MAX_IRQS	6
> +#define RMI_FN_MAX_IRQS	7

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential problem
in how the interrupts are mapped in rmi_create_function_irq().

drivers/input/rmi4/rmi_bus.c:rmi_create_function_irq() {
        ...
        fn->irq[i] =3D irq_create_mapping(drvdata->irqdomain,
                                        fn->irq_pos + i);

        irq_set_chip_data(fn->irq[i], fn);
        irq_set_chip_and_handler(fn->irq[i], &rmi_irq_chip,
                                 handle_simple_irq);
        ...
}

Does this code need to check if irq_create_mapping() returns 0?

If memory allocation fails or the IRQ domain is exhausted during device pro=
be,
it seems we might pass 0 directly to irq_set_chip_data() and
irq_set_chip_and_handler().

On architectures where IRQ 0 is a valid and critical system interrupt, like
the x86 system timer, could overwriting the descriptor cause system
instability?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824122733.7632=
1-1-98lawweijie@gmail.com?part=3D1
