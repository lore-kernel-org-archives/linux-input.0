Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FE75964F2
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890844; cv=none; b=Bjoe07lflsrLiwZfj/8pT0sMkMocGHErrUkPIv/YN/fTISkL9kRaWW6E9oTkHNb5iBSkxSeyAhvVMKKN1lGAVF8+3K66geJ7pqtS54/2psMxWhWebo7Z4sjZJAmK3T+WT4UCtQ4Nxb59gkA6oKfTf+k2sv/ezeRLUd2ZaNtS6yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890844; c=relaxed/simple;
	bh=jDlkuzowK/32LonMHVf0F5Y17z4bJYkfszrtXzbCQCY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WMQ4WW5eoRcNqfdEw1wOQkkZNZjmlUH4VIYisnWOEV2k/6o6Gui8IFv5Au7DvrzpMbXHG75Rzde3Mqpoo4eUqHMJlbGlVNkvJK6EAMakwgiZSuaLj8+SB7xuoX+u1sYo9/D37TngCLinH/9psxarrs39ZphysMkxtWTPbU+b9No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ef3UaCdZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ef3UaCdZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6161F00A3A;
	Tue,  8 Sep 2026 18:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890841;
	bh=g62wr/iiUKZqXcT463vFsiOZ4xYebzKnMbnrphRfgss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ef3UaCdZD0idf2IMkQdGE+dyM1bGqHYmPrg9OQZQkn0ipLpc3pON/n3QZCztk5rNW
	 BBdXo1Ecai7NqYiJzzY9SEcLnXqWZN7YR95rN6japmjXUt775uu+8FGtS6sucrOxIk
	 TBRUCYdDRgcTrmIe7kScNxdEsYtpH0I4wt8YCdvW8uzDazEAwVcbCRTWFeQEldE54g
	 xkQr/6DzY8vELMN0nlp1BZdmQRwx6FjUA1HJFS0CMr6fsiHsAZbDTxf1BRNTTfkoVS
	 scipLixXuG1/hEWcK1RbuGtnB8ntjRlE8pIPYH0s/d8/c2sNCRsTW7PYFTPtnZ90TR
	 mjQmotR4saM8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/13] HID: asus: add support for btn remapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260908174433.74260-14-denis.benato@linux.dev>
References: <20260908174433.74260-1-denis.benato@linux.dev>
 <20260908174433.74260-14-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 18:07:20 +0000
Message-Id: <20260908180720.CC6161F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Button remapping attributes are never exposed for devices lackin=
g turbo support because `ally_create_button_attributes` is incorrectly gate=
d by `if (cfg->turbo_support)` in the caller.
--

commit f62bd64b66b8edafa21a4dcfaec466f614d7bae9
Author: Denis Benato <denis.benato@linux.dev>
Subject: HID: asus: add support for btn remapping

Adds support for button remapping to the ROG Ally, exposing remap_index,
remap, and macro sysfs attributes for physical buttons on the device.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 5cdbcc2bd1bc7..f8655c1ab7359 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -2932,15 +3842,12 @@ static void ally_btn_turbo_init_attrs(struct ally=
_btn_sysfs_entry *entry)
>   * Return: 0 on success, negative errno on failure
>   */
>  static int ally_create_button_attributes(struct hid_device *hdev,
> -					 struct ally_handheld *ally,
> -					 struct ally_config *cfg)
> +					  struct ally_handheld *ally,
> +					  struct ally_config *cfg)
>  {
>  	struct ally_btn_sysfs_entry *entries;
>  	int i, ret;
> =20
> -	if (!cfg->turbo_support)
> -		return 0;
> -

[ ... ]

> +		/* Set up attributes array based on what's supported */
> +		if (cfg->turbo_support) {
> +			entries[i].attrs[4] =3D
> +				&entries[i].remap_attr->dev_attr.attr;
> +			entries[i].attrs[5] =3D
> +				&entries[i].macro_attr->dev_attr.attr;
> +			entries[i].attrs[6] =3D
> +				&entries[i].attr_remap_index.attr;
> +			entries[i].attrs[7] =3D NULL;
> +		} else {
> +			entries[i].attrs[0] =3D
> +				&entries[i].remap_attr->dev_attr.attr;
> +			entries[i].attrs[1] =3D
> +				&entries[i].macro_attr->dev_attr.attr;
> +			entries[i].attrs[2] =3D
> +				&entries[i].attr_remap_index.attr;
> +			entries[i].attrs[3] =3D NULL;
> +		}

[Severity: Medium]
Since ally_create_button_attributes() is now designed to create remap
attributes even when the device lacks turbo support, should the caller
ally_config_create() also be updated to match?

Currently, ally_config_create() still completely gates calling this function
on cfg->turbo_support:

	if (cfg->turbo_support) {
		ret =3D ally_create_button_attributes(hdev, ally, cfg);
		if (ret < 0) {
			...
		}
	}

Does this result in a regression where the new remap attributes are
completely inaccessible for devices without turbo support?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908174433.7426=
0-1-denis.benato@linux.dev?part=3D13
