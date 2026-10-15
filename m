Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110044AEBCE;
	Thu, 15 Oct 2026 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061225; cv=none; b=g+MoiiSIPgWWilhMvDusecFl5ccDOJu/coOqnSfIjuIjFi7pt+v5Cz48N2wemoy/lRZ5kGj4wSzQNkdGjDFnUMJKUlykIc4rdpRcrictsFq2E5VJ47zBx/plGGF2t/AgZ0Vy7xqco+Mh+dmL3cuTbPFrAu2OX6yhh/5LFJ2Q14w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061225; c=relaxed/simple;
	bh=3l22oUBQUWdDwjGMwhzw0uMg4snUszAq46Il6N+4ums=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Ht2GbzC2r5FqmquvuR/Y7HdKGTV/faQAbi6NQJkrvTUMnhglEJZ3bpgb+TZ0ygrTLYyVeQjln+WjtH4eIAi//0YCMqt2M3plJYh86PgYjV7GNvl86E0w7348NcYh96B2uPFKfw75+ug3xFAIfO7jC2bOW363iJuf8vGiOI1lZLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfwHVBMu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfwHVBMu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023081F000C4;
	Thu, 15 Oct 2026 10:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792061223;
	bh=Ft+gkYwOAwr7XHuxub+OX7EI1tRPr/sNud4T/vHhp/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XfwHVBMujPCxroB6+pH1C7bnQyRHj879zvcQGbUevWfnyKrfpRt2q8FT10B33eUCf
	 iiZqSw1tktVLpscKt0sTbfGh/wnw3wxx3CI04vI3uonma/JL3sm12zXC94ORWXimNL
	 hsbguhTFRjSqjyIXi7GPSWyq7vgokd/nDBS91GuCHeSbHSctgye8g2uL3NnA+HeUZp
	 gSVdo0LAUtyiAW2+ppv5rOCd/2mIFsUNzuczXBLR6/1JNU5Kz/S3UM3Q8t0hErJxQg
	 Bb/31v5NXwiu+OVz9UAMZ/xKqRa1Wbtso4EoQt2PvSK7m3WQe6hlgNR1okLlVyZF35
	 YeaWgIA6jb/Aw==
Message-ID: <sashiko-outbox-172676@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: usbhid: add HID_QUIRK_SKIP_FEATURE_REPORT_ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fedor Gubenkov" <writesfaster@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261015102601.1235724-1-writesfaster@gmail.com>
References: <20261015102601.1235724-1-writesfaster@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 10:47:02 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] HID: missing HID_QUIRK_SKIP_FEATURE_REPORT_ID check in usbhid_ge=
t_raw_report
--

commit b5d7d6ff27fe5a08bcc6f67c8ed596cb786d6404
Author: Fedor Gubenkov <writesfaster@gmail.com>

HID: usbhid: add HID_QUIRK_SKIP_FEATURE_REPORT_ID

Some HID dongles implement a stateful challenge/response over HID
feature reports. This patch introduces a quirk to omit the report ID from
the SET_REPORT payload, fixing a stall when interacting with the USBKey don=
gle.

> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -914,8 +914,10 @@ static int usbhid_set_raw_report(struct hid_device *=
hid, unsigned int reportnum,
>  	int ret, skipped_report_id =3D 0;
> =20
>  	/* Byte 0 is the report number. Report data starts at byte 1.*/
> -	if ((rtype =3D=3D HID_OUTPUT_REPORT) &&
> -	    (hid->quirks & HID_QUIRK_SKIP_OUTPUT_REPORT_ID))
> +	if (((rtype =3D=3D HID_OUTPUT_REPORT) &&
> +	     (hid->quirks & HID_QUIRK_SKIP_OUTPUT_REPORT_ID)) ||
> +	    ((rtype =3D=3D HID_FEATURE_REPORT) &&
> +	     (hid->quirks & HID_QUIRK_SKIP_FEATURE_REPORT_ID)))
>  		buf[0] =3D 0;
>  	else
>  		buf[0] =3D reportnum;

[Severity: Medium]
Since this quirk is used for a challenge/response over feature reports,
does usbhid_get_raw_report() also need to be updated to handle the response?

If the device omits the report ID in its response, it appears
usbhid_get_raw_report() will not offset the buffer for numbered reports:

drivers/hid/usbhid/hid-core.c:usbhid_get_raw_report() {
	/* Byte 0 is the report number. Report data starts at byte 1.*/
	buf[0] =3D report_number;
	if (report_number =3D=3D 0x0) {
		/* Offset the return buffer by 1, so that the report ID
		   will remain in byte 0. */
		buf++;
		count--;
		skipped_report_id =3D 1;
	}
...
}

Will this cause usb_control_msg() to overwrite buf[0] (the report ID) with =
the
first byte of the device's raw payload, resulting in a misaligned payload f=
or
user-space applications reading these feature reports?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015102601.1235=
724-1-writesfaster@gmail.com?part=3D1
