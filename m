Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A3038B7D4;
	Thu, 23 Jul 2026 19:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784835225; cv=none; b=RM6EdSV9iKBg516g2ITw+mb8gQncXrzMMhh1GY6g2r4J0+wcqmduH5ZSHKnPgxDjDnOGncDW5EGKIMwvgOE/7GJLXAMTtrcPll0AWbfU3dBDQuHilsVKmJNbhzbBPI4dAZ1v4wPlPCknIhiQvEZm1XkYqyXTpp+udbB5KpHHmlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784835225; c=relaxed/simple;
	bh=ydM3zw46W6tOuJ7P8Z1EUBR/8v7EE8BYiisfxzLV4Ig=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W2WE8JZdiQ0KYTof7hnIvJBsDqHmPwRv8LArdQkwzL+1tkrj54vQvMVY9Hgl6oP51TNPnw9h1rnLGF0oTObPLg2+GL4EagfbXodbQDvsewnNklyX8iblVua55OFV+BpbY8vI88z9zz8r2yBEzogE5ZxBkDOE+v1Wd02NKQrVC+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+Vew0ZL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+Vew0ZL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6181F00A3A;
	Thu, 23 Jul 2026 19:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784835222;
	bh=Z1lYOTUgQhlop8oHbVVr3RycHxyVGy6fMWMsi4HMkcE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W+Vew0ZLgQojrcqxvtx3nK++ZyXcMZt6ha+szrHiWbFIaIVEYjQC/SF0dl/De+Mss
	 4NthPIHuKxO7kpD5ndmDuLzDc0Mnl/t3G3kCERiWEIssaxfW35bWH2lUr5mtzipaOi
	 ov0ficV8K8ptwXFcw4RZQp5QB/dgd3q3PVvmyWi/S3JTNmM52RIqkw9w7qxbrIjaxf
	 kZE9vbuvE0iY7apPsvp82ib4IZCXe6gqdP0e7KSwCZjmEYB+3y5laanV6Tj2iNVhlQ
	 rxJmgHx6L4G0k3LOXUlhArCAGYTVQSlLa/9kN0SEw9aCIDpRrSEdNLbbA5XEW1U+fL
	 bXOKk2f/IKBKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] Input: zinitix - check all available fingers for
 every touch event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>
Cc: dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260724-zinitix-modes-v1-1-f6df7d86a878@disroot.org>
References: <20260724-zinitix-modes-v1-0-f6df7d86a878@disroot.org>
 <20260724-zinitix-modes-v1-1-f6df7d86a878@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 19:33:41 +0000
Message-Id: <20260723193341.EA6181F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch reintroduces the 'shadow fingers' bug on BT404 touchscre=
ens by reverting the core logic of commit e941dc13fd37.

Pre-existing issues:
- [High] The driver passes stack-allocated variables as buffers to I2C tran=
sfer functions (`i2c_master_send`, `i2c_master_recv`), which violates the I=
2C API contract and is unsafe if the subsystem uses DMA.
--

--- Patch [1]: [PATCH 1/5] Input: zinitix - check all available fingers for=
 every touch event ---
commit 3c2f3ba29bf59a45063f7eee69e37d4b205c7c37
Author: Kaustabh Chakraborty <kauschluss@disroot.org>

Input: zinitix - check all available fingers for every touch event

This commit modifies the zinitix touchscreen driver to unconditionally iter=
ate
over all available finger slots up to MAX_SUPPORTED_FINGER_NUM. It relies
only on SUB_BIT_EXIST instead of using the finger_mask field.

Link: https://android.googlesource.com/kernel/bcm/+/23d376ef33aa4c500a5ea24=
a290f029d5f8e2de3/drivers/input/touchscreen/zinitix_touch.c#1942 [1]

> diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscr=
een/zinitix.c
> index 0c36765bd79f8..3421b8ffb19b2 100644
> --- a/drivers/input/touchscreen/zinitix.c
> +++ b/drivers/input/touchscreen/zinitix.c
> @@ -445,7 +445,6 @@ static irqreturn_t zinitix_ts_irq_handler(int irq, vo=
id *bt541_handler)
>  	struct bt541_ts_data *bt541 =3D bt541_handler;
>  	struct i2c_client *client =3D bt541->client;
>  	struct touch_event touch_event;

[Severity: High]
This isn't a bug introduced by this patch, but does passing this
stack-allocated touch_event directly to zinitix_read_data() cause problems
with I2C DMA transfers?

Since zinitix_read_data() wraps i2c_master_recv() and passes this buffer:

zinitix_ts_irq_handler() {
    ...
    error =3D zinitix_read_data(bt541->client, ZINITIX_POINT_STATUS_REG,
                              &touch_event, sizeof(struct touch_event));
    ...
}

Could this lead to memory corruption or kernel panics when CONFIG_VMAP_STACK
is enabled, as stack memory isn't physically contiguous for DMA? This same
pattern appears with local variables passed to i2c_master_send() in
zinitix_read_data() and zinitix_write_u16().

> -	unsigned long finger_mask;
>  	__le16 icon_events;
>  	int error;
>  	int i;

[ ... ]

> @@ -470,8 +469,7 @@ static irqreturn_t zinitix_ts_irq_handler(int irq, vo=
id *bt541_handler)
>  		zinitix_report_keys(bt541, le16_to_cpu(icon_events));
>  	}
> =20
> -	finger_mask =3D touch_event.finger_mask;
> -	for_each_set_bit(i, &finger_mask, MAX_SUPPORTED_FINGER_NUM) {
> +	for (i =3D 0; i < MAX_SUPPORTED_FINGER_NUM; i++) {

[Severity: High]
Does this change reintroduce the shadow fingers regression on BT404
touchscreens?

By unconditionally iterating over all slots and relying solely on
SUB_BIT_EXIST instead of the finger_mask:

zinitix_ts_irq_handler() {
    ...
    for (i =3D 0; i < MAX_SUPPORTED_FINGER_NUM; i++) {
        const struct point_coord *p =3D &touch_event.point_coord[i];

        if (p->sub_status & SUB_BIT_EXIST)
            zinitix_report_finger(bt541, i, p);
    ...
}

Won't this break functionality on BT404 firmwares which erroneously populate
multiple slots with SUB_BIT_EXIST set for a single physical touch? This
appears to revert the core logic explicitly introduced in commit
e941dc13fd37 to filter out those phantom fingers.

>  		const struct point_coord *p =3D &touch_event.point_coord[i];
> =20
>  		/* Only process contacts that are actually reported */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-zinitix-mo=
des-v1-0-f6df7d86a878@disroot.org?part=3D1
