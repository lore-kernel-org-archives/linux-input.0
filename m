Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCF459B660
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890913; cv=none; b=tGa/2tQfJAkWwkuyy1nPhBZAJ1sb0k2+vkwQV8sbyrjl37WsGtwPaistDVjUzpi7mF7fEkRcC4wgQQ+aU7vsmDvRMg0+gUSn1wk9iLDmN47fXT0jCUgF1L//D8Qv8sMORS581c13rVRApYfoQg5QKh76R+PHVepC7EAcTq+rLzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890913; c=relaxed/simple;
	bh=XaHyVOKCKm8+BBY1Dlt76XL4uHYIiP7/o4QzG7nUq9E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gn/z6+eKxNpjrTWlpNauGhWw0LxxpNf3bYaDmfshP49cQQONZMGmbIsnA9DaS2ZNMQ3rDXeDgR9QBspS3gCJ2yGnVKClGxdHr4q3pc22a3aTgD0FOaYZc91WytBANp4sBjvv9xQ/OdpkWCOp5w/X7JiDHdxl86ThJOaf6jkZZxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvXG2WPa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvXG2WPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C5F1F00A3A;
	Tue,  8 Sep 2026 18:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890906;
	bh=Wt3f89MlJV86GDzWJgPxSoKskhDzSIk8nwwZqpOyAjU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bvXG2WPah9fnwL7dphqscq1xNik5utXbGBNe0G6B+4pZZJ2qKiamExox2JleWTtDi
	 a2/8uzM0GS0+ZSNxQC4QRQqIOMSVNQfaTg2j2Y/Y+1KM37MO7x0hgexVPO0Zvw8kQL
	 v0QwBnPEqOvifAZi50N0Zq4gUzvvT7wOshPU/xlXAIiZrsmBPJC+j3Bub7eGSoLanV
	 y3r2mICL/5vM0NvniwwaFBuDJi8WRXKa9G872PlbI7pFhC5c1gI9yJUMhTfKYcdplq
	 GHKYn0hB0n8Brmbnbi3noHZfTEGlt1EFSgQq2Odbke+bPrbHpQCPwQVaXpxCmvGmy/
	 B6ifnpCaEdbAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/13] HID: asus: add support for turbo buttons
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260908174433.74260-13-denis.benato@linux.dev>
References: <20260908174433.74260-1-denis.benato@linux.dev>
 <20260908174433.74260-13-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 18:08:26 +0000
Message-Id: <20260908180826.A4C5F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Memory leak of dynamically allocated `button_entries` and sysfs gr=
oups on `hid_asus_ally_init()` failure.
--

commit bb828c60d81e9c63c13fe68b948f5a447a8d5424
Author: Denis Benato <denis.benato@linux.dev>

    HID: asus: add support for turbo buttons
   =20
    ROG ally devices supports a feature called turbo buttons that allows
    the user to quickly toggle button state by keeping a button pressed,
    therefore allow userspace to configure the feature by exposing
    relevant sysfs attributes.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 60228dc84b50d..5cdbcc2bd1bc7 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -2579,6 +2675,339 @@ static const struct attribute_group *const ally_c=
al_attr_groups[] =3D {

[ ... ]

> +/**
> + * ally_create_button_attributes() - Create turbo button attributes
> + * @hdev: HID device
> + * @ally: ally handheld structure
> + * @cfg: ally config structure
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +static int ally_create_button_attributes(struct hid_device *hdev,
> +					 struct ally_handheld *ally,
> +					 struct ally_config *cfg)
> +{
> +	struct ally_btn_sysfs_entry *entries;
> +	int i, ret;
> +
> +	if (!cfg->turbo_support)
> +		return 0;
> +
> +	entries =3D kcalloc(ALLY_BTN_MAX, sizeof(*entries), GFP_KERNEL);
> +	if (!entries)
> +		return -ENOMEM;
> +
> +	cfg->button_entries =3D entries;

[Severity: High]
If hid_asus_ally_init() fails later during probe, does this code leak the
newly allocated button_entries and sysfs groups?

Looking at hid_asus_ally_probe(), if hid_asus_ally_init() fails, it returns
an error without calling ally_config_remove() to roll back the configuratio=
n:

	ally_cfg =3D ally_config_create(hdev, &ally_drvdata);
	if (IS_ERR(ally_cfg)) {
		...
	}

	ret =3D hid_asus_ally_init(hdev, &ally_drvdata);
	if (ret < 0) {
		ally_put_udev_if_orphaned();
		return ERR_PTR(ret);
	}

Because ally_config is global, a transient USB error causing a probe failure
might lead to the next probe re-executing ally_create_button_attributes().
Would this overwrite the cfg->button_entries pointer and permanently leak t=
he
prior kcalloc array, as well as leave stale sysfs attributes attached that
cause subsequent probes to fail with -EEXIST?

> +
> +	for (i =3D 0; i < ALLY_BTN_MAX; i++) {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908174433.7426=
0-1-denis.benato@linux.dev?part=3D12
