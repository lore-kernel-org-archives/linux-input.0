Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D974331A7E
	for <linux-input@vger.kernel.org>; Sun, 17 May 2026 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779032711; cv=none; b=t6FkVuGEBRatR9GHPpJ4iTzO2uLj/4ncSARClrEh2GCuNMk7NUSvTfHLjXFaVbQgL7VvSNb0CBGPiFrpQ4dhUSMcmjtB79ZRmnr+md1r8dsko5N9NJOyFBYONuSTvH2UK6VArW89rzgXLW0+7D+8re2H+RHqLo3gIqQFT/mp/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779032711; c=relaxed/simple;
	bh=7Npq5tC/OLRPlqbc3UmsmnyrzryWRyY88hOwLak0JGQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XI+gY2DXwJANOq/hq8kQk56Qm+nAOybkHmRif1desOa6Sc74a2Vd0HpiRnClBuTyHv4UMaEgpaqpsyjDWXOC+nrvy7RDljgsEARJKZGLf9xmPH976bapCozJi/RweyS7M4k6x1Yaqw45XChLxNJflylA4GGo8hQiO65oa64IDnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCzSVNKG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCzSVNKG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1338C2BCB0;
	Sun, 17 May 2026 15:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779032711;
	bh=7Npq5tC/OLRPlqbc3UmsmnyrzryWRyY88hOwLak0JGQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QCzSVNKGLljbTRNwwTE9maNpQ5TXgGPs760U7Mtq4x+a1rGNk+iYN5B4bHsbbVzVq
	 e1JjJ+sI0jtUGHnf9zW2zHsLER+pAqqR4VO4pYTmkAd078Y22v23rxJ7/RKV4Gyl58
	 x9npJQ2ywyn1CkTVBiw0zcIB/5+QWpFlPA/YBQS+MdEfjkfMbWEohycoO6fPFjPokO
	 8tjAONO7WLkKvipF/G6i/26RkdFf0jM2DZcXX05a+kQ8pUJBg+c7FT0aEJfDi4SaJb
	 60wDiBWSMA29HpdpzJl9piUseesRzsYzfPWNdpM560zivCoG9Mb0zzIN0RuGh2Wr7U
	 aXG2tVAW+elMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] HID: wacom: validate report length for 24HDT and
 27QHDT handlers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinmo Yang" <jinmo44.yang@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260517135215.2220117-5-jinmo44.yang@gmail.com>
References: <20260517135215.2220117-5-jinmo44.yang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 15:45:10 +0000
Message-Id: <20260517154510.D1338C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch provides an incomplete fix for out-of-bounds reads cause=
d by short HID reports. It adds length checks for `WACOM_24HDT` and `WACOM_=
27QHDT`, but misses the exact same vulnerability in numerous other device h=
andlers called by `wacom_wac_irq()`.
--

commit 46cbf4294f0d1877c7d3c2555971c064f005babf
Author: Jinmo Yang <jinmo44.yang@gmail.com>

HID: wacom: validate report length for 24HDT and 27QHDT handlers

This commit adds length checks to wacom_wac_irq to prevent out-of-bounds
reads for WACOM_24HDT and WACOM_27QHDT devices when they receive short HID
reports.

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 269e8318f79af..2fd1c4e80a72b 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -3509,7 +3509,14 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, si=
ze_t len)
>  		break;
> =20
>  	case WACOM_24HDT:
> +		if (len < 62)
> +			return;
> +		sync =3D wacom_24hdt_irq(wacom_wac);
> +		break;
> +
>  	case WACOM_27QHDT:
> +		if (len < 64)
> +			return;
>  		sync =3D wacom_24hdt_irq(wacom_wac);
>  		break;

While this prevents out-of-bounds reads for WACOM_24HDT and WACOM_27QHDT,
are there other device handlers in this switch statement that also need
report length validation?

For example, handlers like INTUOSP2_BT, REMOTE, INTUOS, and PENPARTNER
appear to process reports without validating the buffer length.

Looking at wacom_intuos_pro2_bt_irq(), it receives the length but seems to
unconditionally call wacom_intuos_pro2_bt_pen():

wacom_wac_irq() -> wacom_intuos_pro2_bt_irq() -> wacom_intuos_pro2_bt_pen()

Does this allow wacom_intuos_pro2_bt_pen() to read up to data[107] without
validating the buffer size?

Similarly, does wacom_remote_status_irq() read up to data[30] to populate
remote serial numbers without checking the length?

Could a malicious device sending short reports still trigger regressions
like slab-out-of-bounds reads or information leaks to userspace through
these other handlers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517135215.2220=
117-1-jinmo44.yang@gmail.com?part=3D4
