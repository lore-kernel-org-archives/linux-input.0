Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792973447;
	b=Hgys+s3RR2xOfeVR/Rv0ovA6waSwXEnRc98ofN2uqrlNwupd4CYlss+di9ERBQVgY1Zw
	 9C3tKQEZe0YYVBCR2acpXwTw1huxnJEc9LF7uiGO0P2VyW7TwP7MTq9/RXwLp7eybgN2N
	 ySYWRS1TkE6bj1kqmsCbKH5xYnwAWP9q8eeDS9CvGwJchNPe27JpL4lFfkndg4tZvEwuH
	 JPxVeSxUCcHB5wkSgc3oUw/oz/BICT7ju8RYi+yCXc2LFfX6c2pn2Bwlc2BXGT8iyHZEi
	 qgGCV+DP5U+G1y7lB5TI+riHII1Y/lOoUCp0hWniyfR3Fjm0E29wwYBHeEljG8+PCNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792973447;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rXquamZqs6uNe29GuMFV5jbqBSGwcQvZWC6JzcW9uc4=;
	b=vHBgMqfHbc66QeQECyMAooNotlWyKAl4iRWGc+oVoJ2J2jCHFEVIEWgA0M3CABp9sfP8
	 qpv64gkEiOHqNpbH2oiNQ3m2qtq0tkHabaWHSgM1W2UyFUWlZx4PdE6xmq3DlBr1Gs1iq
	 0CgzoIIltt1mXVBgISB+Z45HB7rmP22QlJ9LGYuGNeOx6095QuFkJ2f9nPBtUVx5xSFcz
	 MYxjDN30yPB/Mnrtk04VDcMEHr6ppQPgzVnbP8sT34q1a04ahxif9Sqm0vmJtwWClhgd4
	 ybpDE83kNou+sxksJyoPWfZug9iywJf9wHT4UIyDypMVDRt5UrdZ01TdjJdOrZQfvXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V4xy/Wzo";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDD0606A31A
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 00:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V4xy/Wzo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9961F01825;
	Mon, 26 Oct 2026 00:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792973447;
	bh=rXquamZqs6uNe29GuMFV5jbqBSGwcQvZWC6JzcW9uc4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V4xy/Wzou/Mm96b6UBF6nSyOm2tdwzN4dXoai+nRvN/hzwOzLK1TqfRi5XoSfAXd3
	 utrALTCGvt5BwINb+vYB0y3O7CPB7jSMmnMgH18KGreoD8NM0FnA8PpRE4m+Ep/KKW
	 T9RTUDuHEv+6xcgwMzbWw9twPFoU9n1ryia8zycnFQMu6dCBvRWNqhlKhm6ApP34mJ
	 8mjEzwsvbTIx6orpl3j1Yaur3naAG18Xvkdd+tr7IJp4bTAzcj5ncNTI6oUoRItwCr
	 AHiWJcw2gAhtq5bMbLv2XpVOHcImeFzdI/OcIw4FyZJ50tr2gH8bxCUbeQPqJnirwL
	 fuCGAVeTbdc+A==
Message-ID: <sashiko-outbox-184555@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 02/18] HID: asus: add gamepad configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261025235232.129945-3-denis.benato@linux.dev>
References: <20261025235232.129945-1-denis.benato@linux.dev>
 <20261025235232.129945-3-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 00:10:46 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] HID: asus: premature cfg_hdev role release in hid_asus_ally_remo=
ve()
--

commit c72354da64cec15cd42189e4692a21643e33def5
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add gamepad configuration

This commit adds the base configuration structures and sysfs attribute
groups for ROG Ally gamepad configuration, detects hardware capabilities,
and initializes the controller into a known state.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 9e6796bbbdcbd..6d1007433daa8 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -1162,8 +1531,25 @@ static void hid_asus_ally_remove(struct hid_device=
 *hdev, struct ally_handheld *
>  		ally->keyboard_input =3D NULL;
>  		ally->keyboard_hdev =3D NULL;
>  	}
> +
> +	owns_cfg =3D ally->cfg_hdev =3D=3D hdev;
> +	if (owns_cfg) {
> +		cfg =3D ally->config;
> +		ally->cfg_hdev =3D NULL;
> +		ally->config =3D NULL;
> +	}
> +
>  	spin_unlock_irqrestore(&ally_data_lock, flags);
> =20
> +	/*
> +	 * The config teardown removes sysfs groups and takes sleeping locks:
> +	 * it must not run under ally_data_lock. The config pointer has been
> +	 * unpublished above, so no new sysfs callback can find it while the
> +	 * groups are being removed.
> +	 */
> +	if (owns_cfg)
> +		ally_config_remove(hdev, cfg);

[Severity: Medium]
In hid_asus_ally_remove(), should ally->cfg_hdev be cleared only after
ally_config_remove(hdev, cfg) completes, rather than before it?

Clearing ally->cfg_hdev before ally_config_remove() releases the
HID_ALLY_INTF_CFG_IN role while sysfs_remove_group() is still sleeping (for
example, waiting in kernfs_drain() for an in-flight xbox_controller_store()
callback). During that window:

1. A concurrent hid_asus_ally_remove() on the last sibling interface sees
   ally_drvdata.cfg_hdev =3D=3D NULL and ally_drvdata.cfg_probe_in_progress=
 =3D=3D
   false in ally_put_udev_if_orphaned(), dropping ally_drvdata.udev early.

2. A concurrent hid_asus_ally_probe() for HID_ALLY_INTF_CFG_IN (from a
   re-enumerated device or duplicate endpoint) is no longer blocked by the
   role check:

	if ((ep =3D=3D HID_ALLY_INTF_CFG_IN &&
	     (ally_drvdata.cfg_hdev || ally_drvdata.cfg_probe_in_progress)) ||

   and can enter ally_config_create() concurrently with ally_config_remove(=
).

That allows ally_config_create() to mutate the singleton ally_config
(including cfg->initialized and the capability flags) and re-publish
ally->config =3D cfg while the old hdev's sysfs groups are still draining,
which also lets sysfs callbacks on the unbinding hdev see a non-NULL
ally_get_config() again.

By comparison, the hid_asus_ally_init() error path in hid_asus_ally_probe()
clears ally_drvdata.config =3D NULL under ally_data_lock, calls
ally_config_remove(), and only afterwards releases the role via
ally_probe_release_role(ep) and ally_put_udev_if_orphaned().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025235232.1299=
45-1-denis.benato@linux.dev?part=3D2
