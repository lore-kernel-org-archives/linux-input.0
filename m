Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87BF33FE0A
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783929685; cv=none; b=j0/L3dQRw9Xhj4TDXV4kp8sWK2glaMJPhCY8aqebh1flverwyJtZykaUGgeRX4VoXElOYk+ETWIEVH804D5RAYG4GNgF3krcN06rWwnLmnTpCB0Bom/mdiYmqyx3ehtsAJ8G7kELZQT2x2zXCxnkCn9qLTpTxlcYm9AtM6HkpoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783929685; c=relaxed/simple;
	bh=zE+Nm4qWkv1URWx1/m0ZgIxSsgrXiku7sR7D//Zfpmw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JODP6ts35hS9YTWpLXODDfeeQxMaQVPhhrwiD9GhFHgtadJ6EyuMKfkDTLz5Z3vZf6WjRkZcXgMrxG+kCqUmouw94k/vLcbquTRfP2ioVi/adLP/1H1dglvMLTVJXdU2ai5+KoU8eaWJ8YuaprgT90UE2zWvLUI+LWpxlYk1vcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcjV2Vrf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcjV2Vrf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254201F000E9;
	Mon, 13 Jul 2026 08:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783929684;
	bh=jrNMcYQmR+mRx+zz6Muqh/1Biq4gXwjDCKwduOqRa8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fcjV2VrfREJu4ZNZCCYtbNrBm7/AIoN6Y36CmwZlZqGP3wMGYe4lJnhNE1nnBdi1a
	 7/wy+hvawVJssP0sbiMQfRcPCXgsRX/OgCwxF5d0kJcuKngJmzN8klcAqiZdpzuawZ
	 01TYKf/Tr+O8tHbD1n1L6hGgHa9FRLtwKL9Yrb2cP1o7DPbzEBgyxUJKPhk6dxUe2J
	 1R30dn5lUp8QEmya21DbhTmKzBEYJDWQb2aC3VnCLsnGurEbAWBRlNJeBUYI1GrKDw
	 zJtG1qaj6/Xf5J0O9a68Pk1WM/fuX6xW3gBUY3nJnhb6KxbK2q9aAhFyrV3QONu25r
	 j/cJv/2lykmww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: wacom: validate report length before Intuos Pro2
 BT pen parse
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ibrahim Hashimov" <security@auditcode.ai>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260713075110.92469-1-security@auditcode.ai>
References: <20260713075110.92469-1-security@auditcode.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 08:01:23 +0000
Message-Id: <20260713080124.254201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The length checks introduced by the patch are insufficient. While =
they correctly bound the reads in `wacom_intuos_pro2_bt_pen()`, they fail t=
o prevent out-of-bounds reads in the subsequent unconditional calls to the =
touch, pad, and battery parsing functions if the report length falls betwee=
n the checked bounds and the maximum read offset.
--

--- Patch [1]: [PATCH] HID: wacom: validate report length before Intuos Pro=
2 BT pen parse ---
commit 1ba7672ecbf2a3b1f2ac28c705ac40735f4dcbcf
Author: Ibrahim Hashimov <security@auditcode.ai>

HID: wacom: validate report length before Intuos Pro2 BT pen parse

This commit adds length validation in wacom_intuos_pro2_bt_irq() to
prevent out-of-bounds reads before parsing pen reports for Intuos Pro2
and Gen3 Bluetooth devices.

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index da1f0ea85625d..89a191cf1924c 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1548,6 +1548,19 @@ static int wacom_intuos_pro2_bt_irq(struct wacom_w=
ac *wacom, size_t len)
>  		return 0;
>  	}
> =20
> +	if (wacom->features.type =3D=3D INTUOSP2_BT ||
> +	    wacom->features.type =3D=3D INTUOSP2S_BT) {
> +		if (len < 109) {
> +			dev_warn(wacom->pen_input->dev.parent,
> +				 "Pro2 BT report too short: %zu bytes\n", len);
> +			return 0;
> +		}
> +	} else if (len < 43) {
> +		dev_warn(wacom->pen_input->dev.parent,
> +			 "Pro2 BT report too short: %zu bytes\n", len);
> +		return 0;
> +	}
> +
>  	wacom_intuos_pro2_bt_pen(wacom);
>  	if (wacom->features.type =3D=3D INTUOSP2_BT ||
>  	    wacom->features.type =3D=3D INTUOSP2S_BT) {

[Severity: High]
This is a pre-existing issue, but are these length checks sufficient to pre=
vent
out-of-bounds reads in the subsequent parsing functions?

While this successfully protects wacom_intuos_pro2_bt_pen(), the code goes =
on
to unconditionally call other parsing functions:

drivers/hid/wacom_wac.c:wacom_intuos_pro2_bt_irq() {
    ...
	wacom_intuos_pro2_bt_pen(wacom);
	if (wacom->features.type =3D=3D INTUOSP2_BT ||
	    wacom->features.type =3D=3D INTUOSP2S_BT) {
		wacom_intuos_pro2_bt_touch(wacom);
		wacom_intuos_pro2_bt_pad(wacom);
    ...
}

In wacom_intuos_pro2_bt_pad(), it reads up to offset 285:

drivers/hid/wacom_wac.c:wacom_intuos_pro2_bt_pad() {
    ...
	int ring =3D data[285] & 0x7F;
	bool ringstatus =3D data[285] & 0x80;
    ...
}

And for Gen3 devices, after the len < 43 check, it calls
wacom_intuos_gen3_bt_battery() which reads up to offset 45:

drivers/hid/wacom_wac.c:wacom_intuos_gen3_bt_battery() {
    ...
	bool chg =3D data[45] & 0x80;
	int battery_status =3D data[45] & 0x7F;
    ...
}

If a spoofed device sends a report that passes the initial minimum bounds
check (e.g., exactly 109 bytes for Pro2 or 43 bytes for Gen3), could this
still result in out-of-bounds reads when parsing the pad, touch, or battery
data?

>  		wacom_intuos_pro2_bt_touch(wacom);
>  		wacom_intuos_pro2_bt_pad(wacom);
>  		wacom_intuos_pro2_bt_battery(wacom);
>  	} else {
>  		wacom_intuos_gen3_bt_pad(wacom);
>  		wacom_intuos_gen3_bt_battery(wacom);
>  	}
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713075110.9246=
9-1-security@auditcode.ai?part=3D1
