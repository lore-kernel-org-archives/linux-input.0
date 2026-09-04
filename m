Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CCE3B5314
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536783; cv=none; b=BuY+M3rwLwrN5WkNpSkuarB2oBQQWp9huAwZfhynb+pfD/hIMFeNKrYtrSKjKLfzC1mSRtXN/UjPEdrkDqra6kN3kqY+/SQFy6pWG4l1kjwnqLEmI93qzFL2YwDzb5DWRuLbups3E+SwcCpOiv+8KTaky0dmjIZJJM/gmsmLVxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536783; c=relaxed/simple;
	bh=xTH+aT0ChsUhGa2hfTUhnkW4Ww9E/sR19cm0GwcB2Fo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QRu5HRp1900SZUT5dc+IXulWu7SAtuoesWWy51Go44OLuqnOiBCuYrX8ZLVx06R/oCwhjeEDoDoKt/43u/Po2Paayk0n021KmnUTJatakTt9EQ83n+AkH+KG3SptmBAPayJTM1UIKtOEBfu++4WoK1Mzb8634ogf0youXHG+7Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fC/wFWyi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fC/wFWyi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8425B1F00A3E;
	Fri,  4 Sep 2026 15:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788536781;
	bh=Zc8xviA1W14rVOJ4xCWxVdxFVJxkNdn1VcSUt7b/DgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fC/wFWyimiI0GPsebRaviabyt4214+MVIpJBDdYXeLsUybJrnTS09/nL0aNGbGTdq
	 cfOmEJDwY+t8akQh1h8Il5dgbIzFsMbaRbMr1Wz2/LkBqzG6cxCccBKzMWLmElVUku
	 +/kGGU3l1Zgtp7pYdxRUrpUzJsmNyV+eMm9OpB9Py4k8LBCpGqyRPn73YtVVCyiu7J
	 A2BVfvNnSRGRT8BF2y/Msm9U2gLjPBNgPQUlIZfi//I3NEeeiLNJ3yWKNzT1FOM5WQ
	 y+pdbpiYd2mpteRjD/XwT8hHZcPoJIrP04+gSvAWhsHI9Ny+OobqrZozRjfJORx/RT
	 GKxHmagoefGHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/13] HID: asus: add support for btn remapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260904145845.184887-14-denis.benato@linux.dev>
References: <20260904145845.184887-1-denis.benato@linux.dev>
 <20260904145845.184887-14-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 15:46:21 +0000
Message-Id: <20260904154621.8425B1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] A NULL pointer dereference occurs in `ally_set_button_mapping` dur=
ing initialization on devices that lack turbo support, leading to a kernel =
panic.
- [Medium] New sysfs attributes are exposed to userspace before the driver'=
s private data is fully initialized, causing spurious -ENODEV errors on ear=
ly reads.
--

commit 555564cf1146bdf536948c12422013a569b55b96
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for btn remapping
   =20
This commit introduces button remapping for the ROG Ally, allowing
custom mapping for gamepad, keyboard, mouse, and media codes. It adds
new sysfs attributes for configuring the physical buttons based on the
current controller mode.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 7c10e6de438b7..a8b1d407863d7 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -1034,6 +1077,295 @@ static int ally_set_gamepad_mode(struct ally_hand=
held *ally, struct hid_device *
> +static int ally_set_button_mapping(struct hid_device *hdev, struct ally_=
handheld *ally,
> +				   struct button_pair_map *mapping)
> +{
> +	/* The MCU mapping block is four consecutive 11-byte entries starting at
> +	 * buf[5]: first remap 5-15, first macro 16-26, second remap 27-37,
> +	 * second macro 38-48 (see hid-asus-ally __btn_pair_to_pkt, BTN_CODE_LE=
N).
> +	 */
> +	u8 macro_bytes[11] =3D {0};
> +	u8 btn_bytes[11] =3D {0};
> +
> +	if (!mapping)
> +		return -EINVAL;
> +
> +	u8 *buf __free(kfree) =3D ally_alloc_cmd(CMD_SET_MAPPING, NULL, 0);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	/* This packet is slightly different from the other
> +	 * as before the packet length there is an extra byte
> +	 * which is the pair index.
> +	 */
> +	buf[3] =3D mapping->pair_index;
> +	buf[4] =3D 0x2C; /* Length */
> +
> +	/* First button mapping */
> +	buf[5] =3D mapping->first.remap->type;

[Severity: High]
If a device lacks turbo support, the caller skips initializing the button=20
attributes, which leaves cfg->button_mappings zero-initialized.

When hid_asus_ally_init() unconditionally calls ally_apply_button_mappings(=
),
does this result in a NULL pointer dereference here when accessing=20
mapping->first.remap->type?

> +	/* Fill in bytes 6-14 with button code */
> +	if (mapping->first.remap->type) {

[ ... ]

> @@ -3714,6 +4681,8 @@ static int hid_asus_ally_init(struct hid_device *hd=
ev, struct ally_handheld *all
> +static ssize_t button_remap_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	struct ally_handheld *ally =3D drvdata->rog_ally;

[Severity: Medium]
Can userspace trigger a spurious -ENODEV error here on early reads?

The sysfs files are created during hid_asus_ally_probe(), exposing them
to userspace immediately. However, drvdata->rog_ally is only assigned in
asus_probe() after hid_asus_ally_probe() returns.

If a userspace daemon reads this file in that window, drvdata->rog_ally
will be NULL. The older attributes avoided this race by caching the ally
pointer in struct ally_btn_sysfs_entry.

> +	struct button_remap_attr *btn_attr =3D to_button_remap_attr(attr);
> +	const struct btn_code_map *code;
> +	struct ally_config *cfg;
> +	enum ally_button_id button_id =3D btn_attr->button_id;
> +	enum btn_pair_index pair_idx;
> +	struct button_pair_map *pair;
> +	struct button_map *btn_map;
> +	bool is_first;
> +	int ret;
> +
> +	if (!ally)
> +		return -ENODEV;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904145845.1848=
87-1-denis.benato@linux.dev?part=3D13
