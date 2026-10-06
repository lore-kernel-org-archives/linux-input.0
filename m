Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B45F39A7F2
	for <linux-input@vger.kernel.org>; Tue,  6 Oct 2026 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283870; cv=none; b=thcQ72pJsX54upTMTm7pchYqd4DFhhVLqTB1zmwNNTPOCbw+1tFOIQpsxovPDygS9sr2GqZdo2QLX/DUN84tbjf2vT14bazecDyjBRcZoTps0JpCk6S7sSuKpLCWkHfhU0BuxS1AaDKzL2X4JB9GH9dpqjI+c30RLtWp89Fw+RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283870; c=relaxed/simple;
	bh=xAEvWG2Z6inrVL1pTj9V5OsX2cKYnq8JcPzbyRbQ3uw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y9KWmsSREWdxeu2x4kJvWtRwiwAfdCem6qJjRkT6Q/NOla4AzkWq+tRrJMGi7m1fCqaq+gOneOn2GMPZLa8j5soIPaP68xKu/zXPRFAm7QHhT6QRKQhE3iRoyBwrJK2ARduiQzR1erHMfhvYEesFMfIVf4twrl/mmy/obo22X3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZHEdq/R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZHEdq/R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE77A1F000FF;
	Tue,  6 Oct 2026 10:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791283869;
	bh=vck2g05+brF2JJWRQtuxZF0yJ+0D0GAx4aMZRWC9KbA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KZHEdq/RumRMZi3WTIGkZBGJrpDOKtcU/RpRJ9+sTsBZhPyorS0HR3WMwWu+WGIJo
	 HLPeHuJ27yJ3adUjyZwmBZOkpqK4hB0Jk+Xk+otdJpXpVXPUiTIhn/YpDEG3GWYEKd
	 0l3pvqBrIQ0O5FlX4SaAiPdnpEMd5LVFwjT2U2Xnlu+jaLAwgx+2fvr5Dvkmbj16LG
	 OqDiVDLcZtJSf3Fr9fQ/H705t+rm8FimeRq/M4Rmex7IREmQJytTuRU5SqaEE/W1tk
	 CeXQkrY/l4ua82zr1YpMIGZxK7Xm3B2XDQnNp5M/0rQGoPmv4LZeGL0yNpizq02Agz
	 0BDwZUQmgJ6ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next v2 4/4] HID: amd_sfh: Use report type from request
 node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Basavaraj Natikar" <Basavaraj.Natikar@amd.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20261006103754.3614316-5-Basavaraj.Natikar@amd.com>
References: <20261006103754.3614316-1-Basavaraj.Natikar@amd.com>
 <20261006103754.3614316-5-Basavaraj.Natikar@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 10:51:08 +0000
Message-Id: <20261006105108.DE77A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] amd_sfh: incomplete cleanup of report_type array in amdtp_cl_data
--

commit 8029dfd0564b3015a23fe39f335b6a6e8b4706ba
Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

HID: amd_sfh: Use report type from request node

Use report type from request node while sending feature and input reports
to HID core. The cli_data report type array is never assigned and
feature reports are sent as input reports.

Closes: https://github.com/ublue-os/bazzite/issues/5796

> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_client.c b/drivers/hid/amd-s=
fh-hid/amd_sfh_client.c
> index ae6add0b9ce3f..a68b275f0456b 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_client.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
> @@ -95,7 +95,7 @@ void amd_sfh_work(struct work_struct *work)
>  						    cli_data->feature_report[current_index]);
>  		if (report_size)
>  			hid_input_report(cli_data->hid_sensor_hubs[current_index],
> -					 cli_data->report_type[current_index],
> +					 node_type,

[Severity: Low]
This isn't a bug, but since this patch removes the usage of the report_type
array, should its declaration also be removed from struct amdtp_cl_data?

drivers/hid/amd-sfh-hid/amd_sfh_hid.h:amdtp_cl_data {
    ...
	u32 sensor_requested_cnt[MAX_HID_DEVICES];
	u8 report_type[MAX_HID_DEVICES];
	u8 report_id[MAX_HID_DEVICES];
    ...
};

Leaving the declaration wastes a small amount of memory and adds clutter as
dead code.

>  					 cli_data->feature_report[current_index], report_size, 0);
>  		else
>  			pr_err("AMDSFH: Invalid report size\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006103754.3614=
316-1-Basavaraj.Natikar@amd.com?part=3D4
