Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFDD3E5ED7
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780505237; cv=none; b=BSY2wNyzcBLUIuUXOUUjW+Zn9W66ZFRNq+yI66qNJY1RrNNPqbzZFEVKQQ7Diua1oXlL2sAbXWV4Qn3nRPvhQojvUOnDzhowjzg4L/4syMJu8rr8DXW5aUBqa/I2eqOco0vz7WzDjglb32pqTgJbRAW9sKBziQ3AuVvVnQ/SrFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780505237; c=relaxed/simple;
	bh=atjYVBh899Ne21/EI49kKLggo6TXa9Fn27ZOvADilWI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ey5bkqFGNmyJjo1qJo6qs8lGHBB/so2NCnKx6UKOckxK6oWulv6cEa5gvuHYg7n7ayOz4k7AnTQvYfqbwLWRxQAEmMn8rwiTNBmj0UcaLEY2Cl19cP2Epo66Mu+eyAvGxzA741xBAPkxp2+iKIpkeVtGDwEuPof3ohQRR3GiMX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJyRSp34; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJyRSp34"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC131F00893;
	Wed,  3 Jun 2026 16:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780505236;
	bh=GDg+xkGNpNE+Vq4VXt2Gca/64BCNI2LaEVklY61Zcq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JJyRSp34lYjDiaQ2liAIOMSQYd1GtazMvx7DkGWja2bhDuFs9IlIZsxNDkqfqWMPZ
	 RimCK9tBqcV+FOJ5XLg432tA+SX2OPuxRcDRPaHEXuwVIvvyDW6FmGsDGxNB1tS13Q
	 sss7u21erayZalBZicXa5WN7yUX0Y70HvDBq8cQUG5c1PbmSNpUZv3/dE8lb9RE/my
	 eyy/WK/ZC8DEfzIq+2OLJ68fbV/Ct3G7l0XyVv9MMYELZ3l/gWm3Ls/z813kMDKrr+
	 4VIBFKmIcg8m4igfbOnkO5umfQkmVmhw5zBkfyWIdk7samS+Jq344lQ5/YJW+yhQNn
	 kQk0a0gfV+Y7Q==
From: sashiko-bot@kernel.org
Subject: Re: [linux-6.1.y 2/3] HID: pass the buffer size to
 hid_report_raw_event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260603163022.3301081-2-lee@kernel.org>
References: <20260603163022.3301081-2-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 16:47:15 +0000
Message-Id: <20260603164716.2FC131F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The logic to safely pad short HID reports with zeros is entirely u=
nreachable for standard input reports, causing valid short reports to be in=
correctly rejected.
--

commit 74b88a2431a35fe5904c8ec2805668a0317adde6
Author: Benjamin Tissoires <bentiss@kernel.org>

HID: pass the buffer size to hid_report_raw_event

This commit introduces a bufsize parameter to hid_report_raw_event() to help
distinguish between the actual payload size and the buffer capacity. This a=
llows
the HID core to safely memset zero-pad short reports without causing
out-of-bounds writes if the buffer is too small.

> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
[ ... ]
> @@ -2019,9 +2027,15 @@ int hid_report_raw_event(struct hid_device *hid, e=
num hid_report_type type, u8 *
>  	else if (rsize > max_buffer_size)
>  		rsize =3D max_buffer_size;
> =20
> +	if (bsize < rsize) {
> +		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d =
vs %ld)\n",
> +				     report->id, rsize, bsize);
> +		return -EINVAL;
> +	}
> +
>  	if (csize < rsize) {
>  		dbg_hid("report %d is too short, (%d < %d)\n", report->id,
> -				csize, rsize);
> +			csize, rsize);
>  		memset(cdata + csize, 0, rsize - csize);
>  	}

[Severity: High]
Does this new check unconditionally reject short reports for callers that p=
ass
the payload size as the buffer size?

Since bsize is checked against rsize and returns -EINVAL, if bsize
happens to equal csize, the subsequent csize < rsize check and its memset
zero-padding logic become unreachable dead code.

[ ... ]
> @@ -2058,12 +2072,13 @@ EXPORT_SYMBOL_GPL(hid_report_raw_event);
>   *
>   * This is data entry for lower layers.
>   */
> -int hid_input_report(struct hid_device *hid, enum hid_report_type type, =
u8 *data, u32 size,
> -		     int interrupt)
> +int hid_input_report(struct hid_device *hid, enum hid_report_type type, =
u8 *data,
> +		     u32 size, int interrupt)
>  {
>  	struct hid_report_enum *report_enum;
>  	struct hid_driver *hdrv;
>  	struct hid_report *report;
> +	size_t bufsize =3D size;
>  	int ret =3D 0;
> =20
>  	if (!hid)

[Severity: High]
Does initializing bufsize to size here lose the actual allocation capacity
of the buffer?

By constraining bufsize to the payload size, this ensures that bsize =3D=3D=
 csize
in hid_report_raw_event(), which means valid short reports missing trailing
zero bytes will be rejected rather than padded.

[ ... ]
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -74,7 +74,7 @@ static void wacom_wac_queue_flush(struct hid_device *hd=
ev,
>  		int err;
> =20
>  		size =3D kfifo_out(fifo, buf, sizeof(buf));
> -		err =3D hid_report_raw_event(hdev, HID_INPUT_REPORT, buf, size, false);
> +		err =3D hid_report_raw_event(hdev, HID_INPUT_REPORT, buf, size, size, =
false);

[Severity: High]
Should this pass sizeof(buf) as the buffer size instead of size?

Since size is the number of bytes read from the kfifo (the payload size),
passing size as both the buffer size and data size prevents the short-report
zero-padding logic from working correctly.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603163022.3301=
081-2-lee@kernel.org?part=3D1
