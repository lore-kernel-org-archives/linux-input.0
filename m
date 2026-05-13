Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C20C368D6F
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 22:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713100; cv=none; b=bWSestEwYkihTRvUxN7lM+Cqmn591WKRNIfIbc5v9gq+2qr4PL5IOe/psZl7JgnspDPxMWS52W1eZ4P5xfJUDX4sF9kEOTrJQYzqEAkLDXd/37IsX9bv/2++dcKZGVKwJZdCcph1026JbQJDY7IbtTCV6q8Pu6Bizaxs0u858X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713100; c=relaxed/simple;
	bh=5MKY9Jz+mkzh3p9Lc4Z+hV7+FqfeM80voTwUADhzqsE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Acmt45zIpEqpF3Aqo/t4tAS7/CvqzhiyQaoSaICEj5lkmd9UdSJ8OZ//Bbc+gEIGenUwrJ1VbwaoBkhfJOURYC74TS4tlixBbwrpsxHv4A6zJ3GG4b/jkf2SxxLhVzmHl9Qcqo5xjSxUo2iJa+1Zpdu7p9jmOR027vaLTAIVFL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSXgjJA5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSXgjJA5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00890C19425;
	Wed, 13 May 2026 22:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778713100;
	bh=5MKY9Jz+mkzh3p9Lc4Z+hV7+FqfeM80voTwUADhzqsE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=TSXgjJA5B/5g8ELpBy3BsP73tsvQprudwFEk1i8QDGg0ACO4iKIzE5kv+EdZyFbd5
	 jeuVWR7EMMlhua83qP6DBlN1PfX84Jh1CP7yZHVWzYYdTqybbYY0pRnqaqPvTaN8SZ
	 9qWsIdSc0xlgwrx1BlyDPg5dUqoaJQdNlv/iF9YwltlshQt36Fkg2klachkFYV4orj
	 yptgee+i9xy0VM1/FMJBjsLPpyKb8HthOIX072VJHNOoP0pfawTdE8A1nV+uaAiiFh
	 lO6EgENCPsSxuKuO433MKYNj2pn48IVpO21FmhD6MJQ3B3mAs9HYWgcLY+zVrBWj4B
	 P7Pb33r7mDSRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] Input: atlas - Check ACPI_COMPANION() against NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <8696590.T7Z3S40VBb@rafael.j.wysocki>
References: <8696590.T7Z3S40VBb@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 22:58:19 +0000
Message-Id: <20260513225820.00890C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incomplete Fix for driver_override Abuse (Global State Corruption)
--

commit ef51cbfbb2dd379fb06abd9c22db66e86bb70eb3
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Input: atlas - Check ACPI_COMPANION() against NULL

This commit adds a check to ensure the ACPI companion device is present in
the atlas_btns driver to prevent issues when a device is forced to match
via device_match_driver_override().

> diff --git a/drivers/input/misc/atlas_btns.c b/drivers/input/misc/atlas_b=
tns.c
> index 47b31725e8507..835ad45a9d65c 100644
> --- a/drivers/input/misc/atlas_btns.c
> +++ b/drivers/input/misc/atlas_btns.c
> @@ -60,11 +60,15 @@ static acpi_status acpi_atlas_button_handler(u32 func=
tion,
> =20
>  static int atlas_acpi_button_probe(struct platform_device *pdev)
>  {
> -	struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
> +	struct acpi_device *device;
>  	acpi_status status;
>  	int i;
>  	int err;
> =20
> +	device =3D ACPI_COMPANION(&pdev->dev);
> +	if (!device)
> +		return -ENODEV;
> +
>  	input_dev =3D input_allocate_device();

The commit message mentions this check is to protect against
device_match_driver_override() forcing a match with unexpected devices.

If driver_override is used to force-bind this driver to multiple platform
devices that do have ACPI companions, could this cause issues with the glob=
al
input_dev variable?

Since input_dev is overwritten on each successful probe, it looks like earl=
ier
allocated input devices would be leaked if multiple bindings succeed.

Additionally, if these devices are later unbound, or if a subsequent probe
fails after modifying input_dev, could this lead to a double-free or null
pointer dereference when the shared input_dev pointer is cleaned up?

Would it make sense to either reject multiple bindings or store the input
device in the platform device's private data using platform_set_drvdata()?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/8696590.T7Z3S40VBb@=
rafael.j.wysocki?part=3D1
