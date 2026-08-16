Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FA83368B6
	for <linux-input@vger.kernel.org>; Sun, 16 Aug 2026 06:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786860875; cv=none; b=nAE3BSbw+Nh6GCsVJ/vi+0P13uWA2wC3+lxMdtCnEM7L6EprbuWEX/2JbzXMZeeiib+Vjq9JQnJV9BDvL4dpbOnRVKT4W1dHCO7P6CoUYdDMSSTcP+fOo9YvZ/TLytrIA7ikcMW9b292CRBK2gqx59UEAxCIjdHwoBtHWvEUSYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786860875; c=relaxed/simple;
	bh=zSiKTb0RCWkbgURvKmeHNY3+zneyiJYLOhtPjycXcMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HgyOH3LLvewIB/ZApfy7d5mx6/aIqYS313M0id4FJYhdOCHUpFEFqXIMvBiPq33d7slz3IX+8JQBeS9v0w3ydJ0EP1u4v+fqEZtn3y1Jch9obPeksUs+S8y8gtTAe9S3i19wI4KmFGy975j1GwiTbJBTh/aEI14mGK1edPVIec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPOEFc1Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPOEFc1Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272E61F000E9;
	Sun, 16 Aug 2026 06:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786860874;
	bh=7KtBRJwhuUKc3WP5RPUcfHy8Ab3mIOCRSe+RN83GTe0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oPOEFc1YoDNuOTbwUJU9ir0qv/i54BbNjDo5TyMRNFc5IfawW4gve+yeGDmMkGltQ
	 Kh+LdyaJc3lrPIvcOQ59IsvUghizHP9vh9dnY4ZEZwt2y/v4oTkPGlCCOx/QVonel/
	 EScQF9SjKKtjx4ZTw7GtEY6QaVFT9gS8VrFswyPgXmAInMvBQL+xZUiiekl20/fosl
	 cqx3PiGckKUELfrGnM6TfreZ4zzYdLPEcflPI6Tn3Uep5tZNAzavzoyqXjF6SlwUEF
	 8WgJZpTbkRs+DIXeF3bC7q9+t/haLYR71nb9ZLnLZgWdRMx/lcPPVmMzlcChIUmxpA
	 JMEr8bfmVIHeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/13] Input: adp5585: use
 devm_blocking_notifier_chain_register()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eliav Farber" <farbere@amazon.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260816060648.4030-8-farbere@amazon.com>
References: <20260816060648.4030-1-farbere@amazon.com>
 <20260816060648.4030-8-farbere@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 06:14:33 +0000
Message-Id: <20260816061434.272E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is a poten=
tial NULL pointer dereference due to an unchecked `platform_get_device_id()=
` return value.
--

--- Patch [7]: [PATCH v5 07/13] Input: adp5585: use devm_blocking_notifier_=
chain_register() ---
commit 7fdada2980ba610dca31ca2b97c993a21524a85f
Author: Eliav Farber <farbere@amazon.com>

Input: adp5585: use devm_blocking_notifier_chain_register()

This commit replaces the manual registration and devm cleanup of the
blocking notifier chain with a single call to
devm_blocking_notifier_chain_register().

> diff --git a/drivers/input/keyboard/adp5585-keys.c b/drivers/input/keyboa=
rd/adp5585-keys.c
> index 4208229e13561..012558237674e 100644
> --- a/drivers/input/keyboard/adp5585-keys.c
> +++ b/drivers/input/keyboard/adp5585-keys.c
[ ... ]
>  static int adp5585_keys_probe(struct platform_device *pdev)
>  {
>  	const struct platform_device_id *id =3D platform_get_device_id(pdev);

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for
platform_get_device_id() to return a null pointer here and cause a panic
when id->driver_data is dereferenced?

Looking at adp5585_keys_probe(), the returned id is not checked before
accessing id->driver_data:

drivers/input/keyboard/adp5585-keys.c:adp5585_keys_probe() {
        const struct platform_device_id *id =3D platform_get_device_id(pdev=
);
        ...
        kpad->info =3D (const struct adp5585_kpad_chip *)id->driver_data;
}

If a privileged user writes an arbitrary string to the driver_override
sysfs attribute of a platform device and binds it to this driver,
platform_get_device_id() will return null because the bound device
name doesn't match the driver's id_table. Does this code need a null
pointer check to prevent a local denial of service?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816060648.4030=
-1-farbere@amazon.com?part=3D7
