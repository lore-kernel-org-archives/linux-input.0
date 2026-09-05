Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2376A370D5E
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 10:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788604151; cv=none; b=KVkq49G3T6mafPLfRy1NCaAgXyiuNF39JGJkreqx3tLLwWBp40Vv/AclRCO2e44s6aCtuDg7WQv2nS2o/GJyz0odLHoMQAc/nGVDsQGAEXPl3Gu//URkyvIJibjWcQGLlV4j/gJ8ExQNR4SOX2Tb7SLSxU6KnZScXtcdCJhn1xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788604151; c=relaxed/simple;
	bh=ePm+vx7ZpeY+nJWxPPupLAGuQd+/G62japQnm3OTLkc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b0A9kgQTHGGfzMdWJpXvYXmJmdDBuRINb7m+8VhK2/rCz/scleLV4M+PeiAJi24KMcUoGkUuSgUNRyH1+o5WQYRCoLHSStW8j8DGLDBXVr8cd8eGufMjMSWfZHHl2vGgf+096dkYig0bNxdHN5tF9hT4y5P9m1+i3slhocfxeYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nh0Ucr88; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nh0Ucr88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE1F1F00A3D;
	Sat,  5 Sep 2026 10:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788604148;
	bh=2aMX8DYJfMSW/LawhK8He4ncaBnHIvEIVszzA+diuCI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nh0Ucr88AgGQfqXGcUckcT653RXsY7oc7WZQiwtOPB/WXgcHg9xgibMel1FA7Riqk
	 w9xDl+c94/6C2cDwfILvXFq9W+uu8LlRwRBBdJfFI1716HKUYIagTj8xswY0sWgLhZ
	 l30dHAxw+bkhhuTaJu0OR14wHUtOBHVGxVTWpF8afgbcs3k/So84lwCZ1X5cKuZedG
	 o1IczO43wKdpz9XW3Ay3zwTNpm/EIvSLbFBDf/TgP+ORcq0EmTd0u+8QAW+p4u0kPE
	 3KsTC5jJZvS7dyz6tGztkekNGDmHc4DG4O4VJANP6yNKVYyFbRiW846VqauOdu1xeh
	 1auuItsF/UXvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: wacom: validate GRAPHIRE_BT report length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aamir Ahmed" <elb12345@hotmail.co.uk>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <AS8P251MB00012F559DCFF177B19F767BC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
References: <AS8P251MB00012F559DCFF177B19F767BC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 10:29:08 +0000
Message-Id: <20260905102908.ADE1F1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The length check added to wacom_graphire_irq is scoped exclusively=
 to GRAPHIRE_BT devices, leaving other device types (e.g., WACOM_MO, WACOM_=
G4, GRAPHIRE) and other handlers (e.g., wacom_intuos_irq) vulnerable to ide=
ntical stale-buffer reads.
- [High] Missing cancellation of asynchronous timers and workqueues in the =
wacom_probe() error path leads to Use-After-Free.
--

commit 60032e23affbdf87e0c943f82b7987db425fb939
Author: Aamir Ahmed <elb12345@hotmail.co.uk>

HID: wacom: validate GRAPHIRE_BT report length

This commit adds a length check for GRAPHIRE_BT reports in
wacom_graphire_irq() to prevent out-of-bounds reads on short packets.
If the report length is less than expected, it logs a warning and exits.

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 8feb8027be95e..31da8b9566077 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c

[ ... ]

> @@ -350,6 +350,12 @@ static int wacom_graphire_irq(struct wacom_wac *waco=
m)
>  	int retval =3D 0;
> =20
>  	if (features->type =3D=3D GRAPHIRE_BT) {
> +		if (len < WACOM_PKGLEN_PENABLED) {
> +			dev_warn(input->dev.parent,
> +				 "Graphire BT report too short: %zu bytes\n",
> +				 len);
> +			goto exit;
> +		}

[Severity: High]
This isn't a bug introduced by this patch, but does this bounds check
mistakenly limit itself to GRAPHIRE_BT devices?

If a spoofed or malfunctioning WACOM_MO, WACOM_G4, or GRAPHIRE HID device
sends a report with a length shorter than 9 bytes and a valid report ID,
wacom_graphire_irq() bypasses this new check.

It then proceeds to the fallback branch:

} else if (data[0] !=3D WACOM_REPORT_PENABLED) {

and later accesses data[8] unconditionally for WACOM_MO:

	case WACOM_MO:
		prox =3D (data[7] & 0xf8) || data[8];

Can this result in an out-of-bounds read of the HID transport buffer,
leaking up to 8 bytes of uninitialized or stale memory into the input
subsystem?

> @@ -3475,7 +3481,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, siz=
e_t len)
>  	case GRAPHIRE:
>  	case GRAPHIRE_BT:
>  	case WACOM_MO:
> -		sync =3D wacom_graphire_irq(wacom_wac);
> +		sync =3D wacom_graphire_irq(wacom_wac, len);
>  		break;
> =20
>  	case PTU:

[Severity: High]
This is a pre-existing issue, but is it possible to validate the report
length for other handlers like wacom_intuos_irq()?

Currently, wacom_intuos_irq() does not accept a len argument, which seems
to leave it vulnerable to identical stale-buffer reads.


[Severity: High]
This is a pre-existing issue, but is there a missing cancellation of
asynchronous timers and workqueues in the wacom_probe() error path?

In drivers/hid/wacom_sys.c:wacom_probe(), if a subsequent initialization
step fails after wacom_parse_and_register(), it propagates the failure:

	error =3D wacom_parse_and_register(wacom, false);
	if (error)
		return error;

Inside wacom_parse_and_register(), the failure path stops the hardware
but fails to cancel pending works like wacom->init_work or
wacom->battery_work:

fail_hw_stop:
	hid_hw_stop(hdev);
fail:
	wacom_release_resources(wacom);
	return error;

Since wacom is allocated via devm_kzalloc, it is immediately freed upon
probe failure.  When the pending work subsequently executes, might it
access the freed wacom struct, causing a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/AS8P251MB00012F559D=
CFF177B19F767BC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM?part=3D1
