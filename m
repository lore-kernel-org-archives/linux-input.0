Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D96024336D
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 07:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783753446; cv=none; b=IQsBFaDLIxzIMOoOAVrSbiFcut0GEXvjfJ0CiJZ3xcRvLaG4E1tJWPcDLVCHJ4WqO6KXr349GFZSDc01Wj2f8aO0dK/XulujpG5Gs8ai/5cb6sn3bAKSY/ALLlNhaxMnc5JrZkfWG7gghbIl0+PsX0LvjJGQVabSwNlFk1MUyU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783753446; c=relaxed/simple;
	bh=y893uE1Ab2E/U0eDfUeDEf5PBLjIAOVmuzNMWgNnEwg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TQu69lm6ZsrZGWBGbdsmer/64X4lgmNVW8egeyyai7c9V6ba+zCbfyHlXQSWpolSKZt8muqOW4M6yCVCyU39TIfM+s19qfs3xb5vT1DuX+7LYJ22r5DQTzH3/N0SkNXT1boGwbnZn0xjMehfGoURjLubbU3Jrasxm4CfjeqOgsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+sSfM5U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+sSfM5U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4F91F000E9;
	Sat, 11 Jul 2026 07:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783753444;
	bh=uArqFjPiK8WEAyxUxzm39umt0cleK61b3lL44Hrqy5A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d+sSfM5U5BJbxP3632FqqgWrQLenayS07EmLne7DrQ7ODXOmctuWfusJL9aDOGSnk
	 uuH6TJvB/NgIc2Z4ZPmn6/bQhxTJLFY1K8Yb5gfsrU60Em1DXhjDXuSCxEwFGeJRjR
	 0sXtdZAv6ZQzQ9oK/+h5C7ST7gRVVuuyyi0ddvwlK71zEv6G2Ab+qYjJQwIRqo9APo
	 bT277Rs2DL7fQt2cEDvdqZgHKha9r4ZfPPyNjGQsTtBjE0/sK/XPwKnD8FU37cKh4E
	 vk92K3dEwD4Y+Dogw3p1RxQygUq/z+H+IbiTtBezC6Hb1YkOJII9jou58NucZVA7cC
	 9Bt/v3GX5E6vQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] Input: applespi - force PIO mode on MacBook8,1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shih-Yuan Lee" <fourdollars@debian.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260711065415.7396-2-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
 <20260711065415.7396-1-fourdollars@debian.org>
 <20260711065415.7396-2-fourdollars@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 07:04:04 +0000
Message-Id: <20260711070404.7F4F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incomplete restoration of `spi->controller->can_dma` leads to an e=
xecute-after-free on module unload if the original callback was NULL.
- [High] Architectural violation and data race due to mutating shared SPI h=
ost controller, which is applied too late to prevent DMA timeouts.
--

--- Patch [1]: [PATCH v2 1/3] Input: applespi - force PIO mode on MacBook8,=
1 ---
commit c3d66aabf4cd47b8a9f7af8039fad4fc085aef5f
Author: Shih-Yuan Lee <fourdollars@debian.org>

Input: applespi - force PIO mode on MacBook8,1

This patch introduces a DMI quirk to force PIO mode on MacBook8,1 laptops.
It overrides the shared SPI controller's can_dma callback to avoid timeout
errors during DMA handshakes, and attempts to restore the original callback
when the driver is removed.

[ ... ]
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
[ ... ]
> @@ -1788,6 +1800,19 @@ static int applespi_probe(struct spi_device *spi)
>  	debugfs_create_file("tp_dim", 0400, applespi->debugfs_root, applespi,
>  			    &applespi_tp_dim_fops);
> =20
> +	/*
> +	 * MacBook8,1's SPI host controller DMA is broken (timeout errors).
> +	 * Force PIO mode by overriding the controller's can_dma callback.
> +	 *
> +	 * Since we modify the shared controller's callback, we save the
> +	 * original pointer and restore it in applespi_remove().
> +	 */
> +	applespi->original_can_dma =3D spi->controller->can_dma;
> +	if (dmi_match(DMI_PRODUCT_NAME, "MacBook8,1")) {
> +		dev_info(&spi->dev, "Disabling DMA for MacBook8,1 SPI to force PIO mod=
e\n");
> +		spi->controller->can_dma =3D applespi_can_not_dma;
> +	}
> +
>  	return 0;
>  }

[Severity: High]
Is this too late to prevent the DMA timeouts?

The override occurs at the very end of applespi_probe(). However, early SPI
transfers triggered earlier in the function via applespi_setup_spi() and
applespi_init(), as well as any reads triggered by ACPI GPE interrupts that
were already enabled, will still attempt to use DMA and fail.

Furthermore, does mutating the shared SPI host controller's method table fr=
om
a peripheral client driver cause data races with concurrent SPI core
operations? Typically, controller-level hardware quirks need to be implemen=
ted
in the SPI host controller driver itself rather than the client driver to
maintain encapsulation and prevent races.

[ ... ]
> @@ -1822,6 +1847,9 @@ static void applespi_remove(struct spi_device *spi)
> =20
>  	applespi_drain_reads(applespi);
> =20
> +	if (applespi->original_can_dma)
> +		spi->controller->can_dma =3D applespi->original_can_dma;
> +
>  	debugfs_remove_recursive(applespi->debugfs_root);
>  }

[Severity: High]
Will this leave a dangling pointer in the host controller if the original
callback was NULL?

If the host controller does not natively provide a can_dma callback,
applespi->original_can_dma will be NULL. In that scenario, this conditional
check evaluates to false and skips the restoration entirely.=20

Once the applespi module is unloaded and unmapped from memory, the shared
host controller will be left pointing to the freed applespi_can_not_dma
function. Any subsequent SPI transfers on the host controller would then
dereference this freed pointer, resulting in an execute-after-free and kern=
el
panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711065415.7396=
-1-fourdollars@debian.org?part=3D1
