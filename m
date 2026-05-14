Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F363A4F51
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 06:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741438; cv=none; b=V4PLH4xMiMyGVwH54Rq+oKjKej2FxH4Zy4m/8s300s89piWEFehm88JXzkBx1QEIMh1s8YzSuh1FmEnnAWj80OhdmGTt3c9HHm9RuU9RMidWj9mdX+NIgXQXrqvcNFXCpZD+1P5MSUhMd9pgqGBJ1L6JkvH43/VNRo9bC2W+w/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741438; c=relaxed/simple;
	bh=PSN1+Hbia3TXg8zwNasyonCtJC7sLZgM1CrfZejXpdY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oFEcM+qKY2QLgujQMJu5krxTF89owueewLKsWQxneB3gMAtGpluGE3q3i4dKHQoGN5J6Ke/D6pg6Tp/zGPdBVQAZgDE7ZsIeM+f+H4VD65fs9vU7UbY+hYtfYs/7rlW4jrMmlMo1glQ9ZdCk9g296Uork3+Hh7XX+ptY22MjcnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShIE3CL7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShIE3CL7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622EEC2BCB7;
	Thu, 14 May 2026 06:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778741437;
	bh=PSN1+Hbia3TXg8zwNasyonCtJC7sLZgM1CrfZejXpdY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ShIE3CL7y8mVf3mc/F+27Qw2a/WgfPv2k7msq8dhp8jTaDROMJnnZtSF0NaXH8/8S
	 oZTiAonxASegAyYZ2CYhVlTgRPEH7cte6vQ9cM2khWS8P9RkiU0KPTdenfv+hgLaCa
	 T5ZeT9BO8lqqyTLUMUulmtpmyAuEmrLB4zwVy/jmdJpciy1T4LdgrGYmGmAeb5KnF+
	 hP9q/wyOagbJof43M0BcdFV1cLj1vcmH4M3/9tzRaAu3sJDQT/PCLbh6Z2iUDex8oN
	 zDsrOt9ZxfRHi92WCVOP3lfwoM0entLpKbYoE8sZ9d767gtalRdRyZIOjq33endq1x
	 MaO22S9DKw8vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] hid-asus: Fix up Zenbook Duo report descriptors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Pisati" <p.pisati@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260513163248.16483-2-p.pisati@gmail.com>
References: <20260513163248.16483-2-p.pisati@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 06:50:36 +0000
Message-Id: <20260514065037.622EEC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The report descriptor fixup for the Zenbook Duo corrupts the descr=
iptor because it incorrectly shifts only 12 bytes and allocates insufficien=
t memory.
--

commit 6124d2bbfc4e5254d102730c30ac761f188e21b0
Author: Joshua Leivenzon <hacker1024@users.sourceforge.net>

hid-asus: Fix up Zenbook Duo report descriptors

This commit adds a quirk for the Zenbook Duo 2024+ keyboards to fix up an
unmapped Asus vendor usage page code. It reuses the existing report
descriptor fixup logic previously used for T100CHI and T90CHI devices.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 3f5e96900b67a..ce246efba74d3 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -1384,17 +1385,20 @@ static const __u8 *asus_report_fixup(struct hid_d=
evice *hdev, __u8 *rdesc,
>  		hid_info(hdev, "Fixing up Asus T100 keyb report descriptor\n");
>  		rdesc[74] &=3D ~HID_MAIN_ITEM_CONSTANT;
>  	}
> -	/* For the T100CHI/T90CHI keyboard dock */
> -	if (drvdata->quirks & (QUIRK_T100CHI | QUIRK_T90CHI)) {
> +	/* For the T100CHI/T90CHI keyboard dock and Zenbook Duo 2024+ keyboards=
 */
> +	if (drvdata->quirks & (QUIRK_T100CHI | QUIRK_T90CHI | QUIRK_ZENBOOK_DUO=
_KEYBOARD)) {
>  		int rsize_orig;
>  		int offs;
> =20
>  		if (drvdata->quirks & QUIRK_T100CHI) {
>  			rsize_orig =3D 403;
>  			offs =3D 388;
> -		} else {
> +		} else if (drvdata->quirks & QUIRK_T90CHI) {
>  			rsize_orig =3D 306;
>  			offs =3D 291;
> +		} else if (drvdata->quirks & QUIRK_ZENBOOK_DUO_KEYBOARD) {
> +			rsize_orig =3D 257;
> +			offs =3D 176;
>  		}

Could this introduce a regression by corrupting the Zenbook Duo report
descriptor when failing to shift the remainder of the items correctly?

For the Zenbook Duo, the descriptor is 257 bytes long and the offset is 176,
leaving 79 bytes after the replaced item. However, the shared fixup logic
below this code hardcodes a memmove of exactly 12 bytes:

drivers/hid/hid-asus.c:asus_report_fixup() {
    ...
    memcpy(new_rdesc, rdesc, rsize_orig);
    *rsize =3D rsize_orig + 1;
    rdesc =3D new_rdesc;

    memmove(rdesc + offs + 4, rdesc + offs + 2, 12);
    rdesc[offs] =3D 0x19;
    ...
}

Does shifting only 12 bytes overwrite the valid original bytes at offsets 1=
90
and 191, and leave the remaining 67 bytes unshifted?

Additionally, does the new_rdesc allocation properly account for the shift?

Replacing a 2-byte item with a 4-byte item requires shifting the remaining
items forward by 2 bytes. Allocating only rsize_orig + 1 could lead to a
1-byte out-of-bounds write if all 79 bytes are shifted properly.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513163248.1648=
3-1-p.pisati@gmail.com?part=3D1
