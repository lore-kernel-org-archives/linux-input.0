Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3DE3B71AF
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537755; cv=none; b=ths3H4C74j8MYMoVblaUYqKhBLx3P3k0YqWl58H8yRsFg+4gQCah3fv1miIvO71h8ib4tiOKe2dqbgwDs7TutPh9TtkMjUegeREJ/nf15mHixggTeKA+S+IamnXEX3AdBYUteg4Hee96FpTBrs7dUD53cCIQBy/FkRnvGge5MjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537755; c=relaxed/simple;
	bh=O6nQvRi18xJw2CVf3GxOluzWQurZxEHX6vCRpld7zvM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iOnW5eqyWrEqmbk6KkAtwq+VWRv6FwJqXfVkFz5DGQsiTEQt1n1hL33/H5wF+i2SKlRkjaFHcwyylsY92p6M3Nk1soW5UK4OFfU6QxG/B9t+2mmjVpqd41f7bZPSLlV5AHtsfKITeS3vfrvKSvFhXpVe60HBizf9BT7QTYKA/iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ur2YmQvs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ur2YmQvs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB26C1F00A3D;
	Fri,  4 Sep 2026 16:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537751;
	bh=XXIbNLnKmUIHu/nNqo/rlKrUlv3+LnHTuKJRQLPslEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ur2YmQvsQrAggCPdVFvcUKjmu5wLA5LHqxl6J9YqvTXqTok3RqfkMdnL6Iquaay1z
	 oCcRCAHGG6ThVCm5DFooFF+3WTFItkx7BtBFF1cqM4gckZ5CARpQj/tSpTBaNVGsRX
	 apAg9EqEA7yli9BqDg8NXqGR6XoGaxnoJs04M267GYFa81tIHKipDoYZzDnwodDPTd
	 ZADNrM7f/u9UgF8RJMvC4C2Pf/EhN0IOqyxmircIclaD8WOvy+j0ah+1YcJ89fFOJH
	 PGGQPwp+c9ARjr1nWDPxSM5MRx2Q5EBtmL9YAV+548y/o0aYeyi97vvWEvidaAdYDy
	 RyDvVQ5aqEznA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/13] HID: asus: add support for turbo buttons
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260904145845.184887-13-denis.benato@linux.dev>
References: <20260904145845.184887-1-denis.benato@linux.dev>
 <20260904145845.184887-13-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 16:02:31 +0000
Message-Id: <20260904160231.AB26C1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing cleanup of user calibration sysfs groups (`ally_cal_attr_g=
roups`) in the probe error path of `ally_config_create()`.
--

commit 64475826d55426435b32a4fe5bb92d505b7ed1b7
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for turbo buttons
   =20
ROG ally devices supports a feature called turbo buttons that allows
the user to quickly toggle button state by keeping a button pressed.
This commit allows userspace to configure the feature by exposing
relevant sysfs attributes.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 63efda8938386..7c10e6de438b7 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -2697,6 +3126,14 @@ static struct ally_config *ally_config_create(stru=
ct hid_device *hdev, struct al
>  		}
>  	}
> =20
> +	if (cfg->turbo_support) {
> +		ret =3D ally_create_button_attributes(hdev, ally, cfg);
> +		if (ret < 0) {
> +			hid_err(hdev, "Failed to create button attributes: %d\n", ret);
> +			goto ally_config_create_sysfs_err;

[Severity: High]
If ally_create_button_attributes() fails here, does this jump leak the
sysfs groups that were previously created for ally_cal_attr_groups?

This newly added code introduces a failure point after ally_cal_attr_groups
has already been successfully created, making the missing cleanup reachable.

> +		}
> +	}
> +
>  	/* So far the only hardware this is supported is the Ally 1 */
>  	if (cfg->xbox_controller_support) {
>  		ret =3D ally_set_xbox_controller(hdev, ally, cfg, true);
> @@ -2717,6 +3154,9 @@ static struct ally_config *ally_config_create(struc=
t hid_device *hdev, struct al
> =20
>  	return cfg;
>  ally_config_create_sysfs_err:
> +	if (cfg->button_entries)
> +		ally_remove_button_attributes(hdev, cfg);
> +

[Severity: High]
Does this error recovery path completely omit the sysfs_remove_group()
cleanup loop for ally_cal_attr_groups?

Leaking these sysfs group directories and attributes can cause subsequent
attempts to probe the device to trigger a kernel warning for duplicate sysfs
nodes (-EEXIST). This would render the device permanently unusable without a
reboot.

>  	/* The sysfs groups are not devm-managed: undo the created ones. */
>  	while (sysfs_i-- > 0)
>  		sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[sysfs_i]);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904145845.1848=
87-1-denis.benato@linux.dev?part=3D12
