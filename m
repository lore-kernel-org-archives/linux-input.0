Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6790B4E4C43
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560622; cv=none; b=Ig18uGUnQ3NWtDI16guFKVLxKAayDqaKn//mQqRQQ34KcoUDI4mbKS6sUP1gcwHLMbUCdCK890MzfQZgJl3QyZEqP18BRma3YYegW6cLDiii6wGqFA4azknLgSvcjmCOpEzpeaysmpwqnHApbjc1SdosdVHuqHmaB3wiKgYnOV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560622; c=relaxed/simple;
	bh=LEpN1oxkCQxcD+tbO6CFABPkDiG0+/4w4r5hbpz6CQY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=tdtDWDW26gAirTMyoC7rcyIk8R7VMY1LVPQwJUkbH2iVSJQ16kmZQNYUR0E7c6ErQbjXLUkWT3hKEeDIWim7Na5H6ah927/rtDmz8ptK4lxvMTWV8Yse7ab3mYXf/E29RHSD05MrfEhjRiriSTv6iT3rLUO2sEJz+fBrkhK5f9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKLdRbjd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKLdRbjd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40261F000FF;
	Fri,  9 Oct 2026 15:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791560621;
	bh=Cg0xt14h9UuJRBVYrkHK0V1HxxCSixJ4Ody/k+vZA6Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VKLdRbjdtSiHWgPnK0zd2bra0tSsGC3VGL1Pc/D6MDf+jFjLNsfUJaMofZukbZV/B
	 6nfypkPZ0gwT9OzXu1zEJsUFO8BaJfM6sHUK+jZJk66WjXs1FH8qdpRPS51FQk5MJK
	 J9ACfKkltmanwjt6h+sdAARBcS42KaQn15CkshiVgNhSvNd449bCBikzAsx4RMPIlN
	 S5SM+tbWwmyLNIkhIN1s5XwBCPgIv/IRhjeIMTJXHFlxXbwgxfjZBj1JmSJV/72yvh
	 VZBT9uKDUt7QXrFQ6SyFWaDdKKPa9+7UpCjlVGdP3ZbYOGsZbocJZoqHAw+nUbWR56
	 YeLuTBNLr6ZnQ==
Message-ID: <sashiko-outbox-165788@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/7] HID: asus: Do not send feature reports larger
 than declared
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Pisati" <p.pisati@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20261009153459.124752-6-p.pisati@gmail.com>
References: <20261009153459.124752-1-p.pisati@gmail.com>
 <20261009153459.124752-6-p.pisati@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 15:43:40 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] hid: asus: handshake string truncated by report size clamping
--

commit fda25fdf61cb84326a7d3ef09500a6da741dd0bc
Author: Paolo Pisati <p.pisati@gmail.com>

HID: asus: Do not send feature reports larger than declared

This commit limits feature report write sizes to the length declared by the
device descriptor. This prevents control transfer timeouts on Zenbook Duo
keyboards, which declare a 15-byte feature report instead of 64 bytes.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index d8a931290c9a7..9e80a2bb54c37 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -618,6 +618,17 @@ static int asus_raw_event(struct hid_device *hdev,
> =20
>  static int asus_kbd_set_report(struct hid_device *hdev, const u8 *buf, s=
ize_t buf_size)
>  {
> +	struct hid_report *report;
> +
> +	/*
> +	 * Do not send more than the declared size of the report: the
> +	 * Zenbook Duo keyboards declare report 0x5a as 15 bytes long and
> +	 * do not answer the 64 byte writes sized for the ROG keyboards.
> +	 */
> +	report =3D hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[buf[0]];
> +	if (report)
> +		buf_size =3D min_t(size_t, buf_size, hid_report_len(report));

[Severity: Medium]
Will this clamp the 16-byte initialization handshake buffer and drop its nu=
ll
terminator?

The commit message notes that "the 16 byte handshake goes through" on the
Zenbook Duo. However, looking at asus_kbd_init(), it sends a 16-byte magic
string for initialization:

	const u8 buf[] =3D { report_id, 0x41, 0x53, 0x55, 0x53, 0x20, 0x54,
		     0x65, 0x63, 0x68, 0x2e, 0x49, 0x6e, 0x63, 0x2e, 0x00 };
	int ret;

	ret =3D asus_kbd_set_report(hdev, buf, sizeof(buf));

If the Zenbook Duo declares report 0x5a as 15 bytes, the min_t function will
reduce buf_size to 15. The trailing 0x00 null terminator of "ASUS Tech.Inc.=
\0"
will be silently truncated before the buffer is duplicated and sent to the
hardware via hid_hw_raw_request().

Could this unterminated string cause the firmware to reject the initializat=
ion
sequence?

> +
>  	u8 *dmabuf __free(kfree) =3D kmemdup(buf, buf_size, GFP_KERNEL);
>  	if (!dmabuf)
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009153459.1247=
52-1-p.pisati@gmail.com?part=3D5
