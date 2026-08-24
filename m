Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C633BD629
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 06:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787551523; cv=none; b=lUDT0vAoHlQVIUZzyRSw5pAgIw8wqf1koHvB8Y3IzIiVgEqf2QRlEWee7SLLCJAKhFVXAVjdgDy5XxaeezNxm3DlQneBGa5lX0q/VaR0K+afF9hpY2vrI8HjBDvy/Ax3FAXdKHQheL1CEXK9ysFwRANMS16Yhx2pFiT2u/e229Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787551523; c=relaxed/simple;
	bh=EE74FgWqtFm1XNbwjZOySAlbxTpBm9EKV52kxvrH7mo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cLbVXoOPfdN922++Mvy00DRWauTeMZaNan7J/+AF9BgegKpmy5WHh/uZjYyp6uLCaHcDyefF5GTiSgb0KLDdKP1oEytBX5/06KB667V7WsNrHsBexr+DT3cZ4mQ5fW8YmdHjyryBhNjeIIe2HhDz6oYsKw2tsOhmT85FNKwiHeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FONfdnD/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FONfdnD/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0811F000E9;
	Mon, 24 Aug 2026 06:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787551521;
	bh=7xhmCAnpvedyK97sKka5HGrNClA03ucR7iuaqhC+MqI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FONfdnD/M23JzapshRIBBnz/R2MZc/G7gW/54XfzPQx0P/n0GN6sV+OVpUbupBfza
	 9xXON/9NmPRHDUxlkHATOyVm0P9e1EAIg/G4QJUbf+QQtnoekb7rZU9BhKdV981SBD
	 wvLLlnlM/wWwmwvNMxAvj76LGSAzbVom2Ew+poR0mnaLtDJSO189VHPQknGPcMUnFp
	 Vnv6WBqfxWZ3bd35vZ5pc84BKUBLdlVAeEP6jLG8Io777tpw1KSmTHrGSzNGDNMbXq
	 sJWdniNCahbJlrLYnLCAsyzHyDMGoJ5oN5au/pHfqNC1ivZmihHa+QWQsenoLeGnn2
	 9nTdbuCsCwMjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] Input: synaptics-rmi4 - fix irq[] overrun with 7
 interrupt sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Jie Law" <98lawweijie@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <4a48122167e32a6755d9ee7033f29bf7c78be796.1787549234.git.98lawweijie@gmail.com>
References: <cover.1787549234.git.98lawweijie@gmail.com>
 <4a48122167e32a6755d9ee7033f29bf7c78be796.1787549234.git.98lawweijie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 06:05:20 +0000
Message-Id: <20260824060521.5B0811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The function devices created during probe are leaked and can trigg=
er a Use-After-Free if `rmi_f34_create_sysfs()` fails.
- [High] Failure of `irq_create_mapping()` returns 0, which is unchecked an=
d passed directly to IRQ manipulation functions, hijacking or corrupting sy=
stem IRQ 0.
- [Medium] The IRQ domain created during probe is leaked on almost all erro=
r paths in `rmi_driver_probe()`.
--

--- Patch [1]: [PATCH 1/2] Input: synaptics-rmi4 - fix irq[] overrun with 7=
 interrupt sources ---
commit 048bbd16c16ceb54800fa66f025c5162730cc787
Author: Wei Jie Law <98lawweijie@gmail.com>

Input: synaptics-rmi4 - fix irq[] overrun with 7 interrupt sources

This commit fixes an out-of-bounds array access by expanding the irq array
size from 6 to 7 to match the maximum interrupt source count specified by t=
he
RMI4 Page Description Table entry.

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
> =20
>  /**
>   * struct rmi_function - represents the implementation of an RMI4

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential
use-after-free and memory leak in the error handling of rmi_driver_probe():

drivers/input/rmi4/rmi_driver.c:rmi_driver_probe() {
    ...
	retval =3D rmi_f34_create_sysfs(rmi_dev);
	if (retval)
		goto err;
    ...
err_destroy_functions:
	rmi_free_function_list(rmi_dev);
err:
	return retval;
}

If rmi_f34_create_sysfs() fails, the code jumps to the err label, skipping
the call to rmi_free_function_list(rmi_dev). Doesn't this leave the function
devices orphaned on the RMI bus with a soon-to-be-freed parent drvdata,
leading to a use-after-free if a driver later attempts to bind to them?

[Severity: Medium]
This isn't a bug introduced by this patch, but I noticed the IRQ domain mig=
ht
be leaking on probe error paths:

drivers/input/rmi4/rmi_driver.c:rmi_driver_probe() {
    ...
	retval =3D rmi_probe_interrupts(data);
	if (retval)
		goto err;
    ...
err_destroy_functions:
	rmi_free_function_list(rmi_dev);
err:
	return retval;
}

The rmi_probe_interrupts() function allocates a linear IRQ domain using
irq_domain_create_linear(), which is not managed by devres. If any subseque=
nt
initialization step fails, the probe function returns without calling
irq_domain_remove(). Is it expected that the IRQ domain is leaked here?

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential problem
in how mapped IRQs are handled:

drivers/input/rmi4/rmi_bus.c:rmi_create_function_irq() {
    ...
		fn->irq[i] =3D irq_create_mapping(drvdata->irqdomain,
						fn->irq_pos + i);

		irq_set_chip_data(fn->irq[i], fn);
		irq_set_chip_and_handler(fn->irq[i], &rmi_irq_chip,
					 handle_simple_irq);
    ...
}

If irq_create_mapping() fails due to memory or descriptor exhaustion, it
returns 0. Is it safe to pass 0 directly to irq_set_chip_data() and
irq_set_chip_and_handler() without checking the return value? Could this
overwrite the chip and handler for system IRQ 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787549234.gi=
t.98lawweijie@gmail.com?part=3D1
