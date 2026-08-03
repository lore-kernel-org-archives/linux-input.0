Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E8C41378E
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770216; cv=none; b=k8FVwkhupo96b0z/Fxyt5tJ7Y52FQttD7IfuIOPuAWrb08o0ZfwASdRskBp6Zge0xKiraSHbz+3tG5vz249bcoEySUgluHknTjRF+GuO1Dn1xuJr0YreTQX6AQfQZinHlUBLNeI0AunBx5B8kOnyIGjOhr+K3bVbVJgFCRgbv4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770216; c=relaxed/simple;
	bh=lIb0oaPuBc8c8WUp5dL1QvR0kwhOLGhPv7UbxAWqol4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o5QpU3VKIJ7efHKxdBFnbxbYkFV2eEdxREOzMnfhK2U0R61f+yB2qvC6Fvz13H6gNvEGy8vlQb6dB8qShmM0oQl0HsR5FG/hl8HU8J5R8CmACNRmKE8ScRdWKXAjw7x1R7cUiJeV/s/yQwiyZqR9RTM/5Xqnyj0kaYcyrj341oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWbNqE+o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWbNqE+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E9F1F000E9;
	Mon,  3 Aug 2026 15:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785770214;
	bh=M9o4QHzjw2CLUWzbcLHOmmvw2cHMYg6nnvJswxuJ9kE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LWbNqE+o0mdAh3s2gND2edWPg86TfzN5snLbzyOqKh8Zs6a04kauUB6C1/TjR0VFx
	 Upq79cl0rz9YOBUksL+OFAHjsUd9t3nEk8BAgp347RyFsJ1ObROKdZUb8j36V5Fnfk
	 1rQ7peUCm7M5zntc1z4pwbTmqhvvdrWCAjEPbt4nKbOsOyB647CaxcQnOYZfufPiBY
	 2tXQ+o5J7wXEtLYahjiJAS/PQCHpmbusmtigg3e6897SewebptCDe9nD8qp+WMBn0/
	 g1Gr4oiNvY1NFposoUNVKAdy8mByyQb+P/JY1I/hqWJAIoM9PDKI3mzq1CwcQogTev
	 ZdiYfw0Ut+wJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] HID: amd_sfh: Register tablet-mode auxiliary
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Basavaraj Natikar" <Basavaraj.Natikar@amd.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260803145801.3801862-5-Basavaraj.Natikar@amd.com>
References: <20260803145801.3801862-1-Basavaraj.Natikar@amd.com>
 <20260803145801.3801862-5-Basavaraj.Natikar@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 15:16:53 +0000
Message-Id: <20260803151654.66E9F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The tablet-mode auxiliary device is unregistered in the devres cle=
anup phase, which occurs after the parent driver has manually shut down the=
 hardware in its `.remove` callback, creating a Use-After-Teardown window.
--

--- Patch [4]: [PATCH v2 4/5] HID: amd_sfh: Register tablet-mode auxiliary =
device ---
commit cb1f4966427e04f4389572394e9a4fb57915128b
Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

HID: amd_sfh: Register tablet-mode auxiliary device
   =20
Register an auxiliary device when the operating-mode sensor is present,
so a dedicated input driver can bind to it and report the device posture.
This keeps the input handling out of the sensor transport driver.

> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh=
-hid/amd_sfh_pcie.c
> index 4b1cd260410d1..f6f016c8c6787 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
[ ... ]
> @@ -389,6 +391,50 @@ static const struct attribute_group *amd_sfh_groups[=
] =3D {
[ ... ]
> +static void amd_sfh_maybe_register_tm(struct amd_mp2_dev *mp2)
> +{
[ ... ]
> +	mp2->tm_auxdev =3D adev;
> +	if (devm_add_action_or_reset(&mp2->pdev->dev, amd_sfh_tm_cleanup, mp2))
> +		dev_warn(&mp2->pdev->dev, "tabletmode cleanup registration failed\n");
> +}
[ ... ]
> @@ -424,6 +471,7 @@ static void sfh_init_work(struct work_struct *work)
[ ... ]
>  static void amd_sfh_remove(struct pci_dev *pdev)
>  {
>  	struct amd_mp2_dev *mp2 =3D pci_get_drvdata(pdev);
> =20
>  	flush_work(&mp2->work);
>  	if (mp2->init_done)
>  		mp2->mp2_ops->remove(mp2);

[Severity: High]
Does this create a use-after-teardown window on device unbind?

Because the tablet-mode auxiliary device cleanup is registered via
devm_add_action_or_reset() in amd_sfh_maybe_register_tm(), the auxiliary
device is only destroyed during the devres release phase.

Since devres cleanup runs after amd_sfh_remove() completes,
mp2->mp2_ops->remove(mp2) manually tears down the underlying hardware before
the auxiliary device is destroyed.

If the auxiliary driver's remove callback or userspace attempts to
interact with the device during this window between amd_sfh_remove() and the
devres cleanup phase, could they end up accessing disabled hardware?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803145801.3801=
862-1-Basavaraj.Natikar@amd.com?part=3D4
