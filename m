Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669673D565C
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783937511; cv=none; b=rFtQWwjFOV809w0UXYHWbw5uJJS9CYv8n2hco1mJWwNm6KyFjpOFoY53htxjIWVDJqRFVmJ6jxZ0Ilc2IXCdiKi/sBYfKL+m55Mlkv2XfcjMiu1Zkh027HIeqUfVg1KrLFByrMjSuJ4tRy7zgxXJVp7cAGQNdnH5+iMIgYYFZ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783937511; c=relaxed/simple;
	bh=hNPlwXuIuyCFPpyJpHE1L4+DbxPYGvvgROaTUNxVQUM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oygVlvupwGVX3XVI5PTzevATEpB09UKn66UGMrCK98dFLAZDSEXfN5RaXagT3iVqsZVwqxT+SbIM08/qmfcWnm0oHBPgf+4shnwX8JE6U+pl2mKyRQyHkNiMHjKdwl5/cnCZjMMOZ1qpeUIGShNiQIjt7MbNY7M8xjPmZoLcWJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXRy5YQA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXRy5YQA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01E81F000E9;
	Mon, 13 Jul 2026 10:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783937510;
	bh=VqZubkGsD17HSEDfvGPGkbT5b+V0lv/KmyBlHkRwYvI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CXRy5YQAsO+TmOQfRhxFRJ4hU4YvKQUlh63su0izah9BmNqhpmSsOXO52q9hEKoYo
	 MyruoPDBhfHziitY8WrLHT3VUTz9PTtiRSBH4EbrznO4AjcnVyp07bC+l2o8yxCeaT
	 hbO6R8m1JUuiRvGPNGDIvV6tmfGXAACK0CscfpLDnQxSWGOaxdL1vqvInlSrNP9x+6
	 I0MiyBw3KBQ8wRfmGDtg5xrcFAZsXlpLVG47eOzoXIjJNL1Ljdp1SgPbo+S7IJr3Gn
	 vUhMkwFW2aRAXjOOWxfDTvagipWCX0HMCDYFYNF4g2HX4bfPPfQqM9dvM6nwpE0+Og
	 PN+gZr6rEJNtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: wacom: validate report length in
 wacom_intuos_pro2_bt_irq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ibrahim Hashimov" <security@auditcode.ai>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260713093414.94337-1-security@auditcode.ai>
References: <20260713075110.92469-1-security@auditcode.ai>
 <20260713093414.94337-1-security@auditcode.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 10:11:49 +0000
Message-Id: <20260713101149.E01E81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added length validation uses `dev_warn()` without rate=
limiting, allowing a malicious device to spam the kernel log.
--

--- Patch [1]: [PATCH v2] HID: wacom: validate report length in wacom_intuo=
s_pro2_bt_irq ---
commit d2626ddb2110b90160eb60887108918a58cb9412
Author: Ibrahim Hashimov <security@auditcode.ai>

HID: wacom: validate report length in wacom_intuos_pro2_bt_irq

This commit adds length validation to wacom_intuos_pro2_bt_irq to prevent
out-of-bounds reads when parsing Bluetooth reports. It drops undersized
reports and logs a warning before returning.

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index da1f0ea85625d..af76e49fd0f25 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1548,6 +1548,19 @@ static int wacom_intuos_pro2_bt_irq(struct wacom_w=
ac *wacom, size_t len)
>  		return 0;
>  	}
> =20
> +	if (wacom->features.type =3D=3D INTUOSP2_BT ||
> +	    wacom->features.type =3D=3D INTUOSP2S_BT) {
> +		if (len < 286) {
> +			dev_warn(wacom->pen_input->dev.parent,
> +				 "Pro2 BT report too short: %zu bytes\n", len);

[Severity: Medium]
Since this error path is triggered by external Bluetooth input, can a
malicious or malfunctioning device flood the kernel logs by sending many
undersized reports in rapid succession?

Would it be better to use dev_warn_ratelimited() here to prevent potential
log spam and CPU/IO overhead?

> +			return 0;
> +		}
> +	} else if (len < 46) {
> +		dev_warn(wacom->pen_input->dev.parent,
> +			 "Pro2 BT report too short: %zu bytes\n", len);

[Severity: Medium]
Similarly, could this branch also benefit from dev_warn_ratelimited() to
protect against log flooding from undersized reports?

> +		return 0;
> +	}
> +
>  	wacom_intuos_pro2_bt_pen(wacom);
>  	if (wacom->features.type =3D=3D INTUOSP2_BT ||
>  	    wacom->features.type =3D=3D INTUOSP2S_BT) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713093414.9433=
7-1-security@auditcode.ai?part=3D1
