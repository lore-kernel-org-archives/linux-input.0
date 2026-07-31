Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B088E41A50A
	for <linux-input@vger.kernel.org>; Fri, 31 Jul 2026 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785522354; cv=none; b=BXcrTWfy18zvtP2qqMqm9cVY7J+tpdK7lpE8R/QI1SE/pZNNieGBLM245n6c6wzGjCPhx56kXq1j3PNV/xZQqq13TjPzW8l2Tla6CYdoa7n3Xiv5MsGOCTm3QdhTyiGQBHSoddjxqPNdoj5k8YbirgYATv5jba8WNCjLRJqtBIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785522354; c=relaxed/simple;
	bh=dWzOwp3s5hMNksf6HWoFvNm+z+F2HZa8dRg5CvWamw4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=boSNq784Syvowf0CJG6KxjZ77CWG7E1izUpesLYi5C9Mh0+3DRrtPsUTbOqEhuKPgwb/5hwkVFZXCetDe+H2FdXHG3MPFoAme8X3vfRMuiD8N7JU7w5GjJjxVsdkqTSXPl+95T6YUYqi81LHelsGnrWxTnU5hVWGsNXqKy1rARQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDnhbCC4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDnhbCC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9EA1F00AC4;
	Fri, 31 Jul 2026 18:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785522352;
	bh=DLlXV2LMSnOtwyJgRUMm5Paq5dugPlAOp+4CMtZU894=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RDnhbCC48lcEfFTF4z66bvPwtxTSCwXE7KC4l36pXwc4+Ub/7TBfFnan/V92sQb/0
	 jdPS57tEOAvrbJfT+6CKjOwVUiNlBAl8vA5zMhoaIVgY9TCPZBH6zQGlz+O0aAwi+8
	 Jnf+mKTRsd0O4IrP1kUv1OYMsIMWVmUTqbij1RJCi2jqafWOLIrh3rwbcOdM+Ho6Cg
	 KGTXPpFEnvuBVV7nqfTJRF/KqijJZKYSMBugGfFYnx1jK28cGAW8cjy4vWkTBz5rqH
	 bdNFO+tbSbWubSlyrNQ4Koce2Yo12bxrIo3PJXRpbfjwLCSgZL4tMpcCYdzZv0Ijgh
	 JTrTP1CPLvYCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] Input: rmi4 - report difference between platform
 data and detected coord in F12
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Heidelberg" <david@ixit.cz>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260731-respect-x-y-mm-v1-1-3e85a4bec745@ixit.cz>
References: <20260731-respect-x-y-mm-v1-0-3e85a4bec745@ixit.cz>
 <20260731-respect-x-y-mm-v1-1-3e85a4bec745@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 18:25:52 +0000
Message-Id: <20260731182552.9E9EA1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential division by zero if the device hardware reports a DPM re=
solution of 0.
- [High] Uninitialized kernel stack memory leak due to insufficient validat=
ion of register size against subpacket map.
--

--- Patch [1]: [PATCH 1/2] Input: rmi4 - report difference between platform=
 data and detected coord in F12 ---
commit b9eac21396bb125557501cbe3a56f93e5854436c
Author: David Heidelberg <david@ixit.cz>

Input: rmi4 - report difference between platform data and detected coord in=
 F12

Platform data may define touchscreen-x-mm and touchscreen-y-mm, but
these are quietly overridden by data provided by sensor.

Warn when detected data doesn't match the device-tree data.

> diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
> index 88c28089de993..88797556e738c 100644
> --- a/drivers/input/rmi4/rmi_f12.c
> +++ b/drivers/input/rmi4/rmi_f12.c
> @@ -100,6 +100,7 @@ static int rmi_f12_read_sensor_tuning(struct f12_data=
 *f12)
>  	int ret;
>  	int offset;
>  	u8 buf[15];
> +	u8 x_mm, y_mm;

[Severity: High]
This isn't a bug introduced by this patch, but could this code leak
uninitialized stack memory if a peripheral advertises a small register size?

In rmi_f12_read_sensor_tuning(), buf is populated via rmi_read_block() with
exactly item->reg_size bytes. Later in the function, it unconditionally
parses fields if the corresponding subpacket bit is set:

rmi_f12_read_sensor_tuning()
    ...
    offset =3D 0;
    if (rmi_register_desc_has_subpacket(item, 0)) {
        sensor->max_x =3D get_unaligned_le16(&buf[offset]);
        sensor->max_y =3D get_unaligned_le16(&buf[offset + 2]);
    ...

If a peripheral sends a crafted register descriptor with a small reg_size
(e.g., 2 bytes) but sets bits in the subpacket map, does this cause the
driver to read past the initialized portion of buf and expose stack memory
to userspace?

>  	int pitch_x =3D 0;
>  	int pitch_y =3D 0;
>  	int rx_receivers =3D 0;

[ ... ]

> @@ -171,8 +172,8 @@ static int rmi_f12_read_sensor_tuning(struct f12_data=
 *f12)
>  		}
>  		dpm_resolution =3D buf[0];
> =20
> -		sensor->x_mm =3D sensor->max_x / dpm_resolution;
> -		sensor->y_mm =3D sensor->max_y / dpm_resolution;
> +		x_mm =3D sensor->max_x / dpm_resolution;
> +		y_mm =3D sensor->max_y / dpm_resolution;

[Severity: High]
This is a pre-existing issue, but is it possible for a malicious or
malfunctioning device to cause a division by zero panic here?

The dpm_resolution value is read directly from the hardware query register
into buf[0] and then used unconditionally as the denominator:

    dpm_resolution =3D buf[0];
    x_mm =3D sensor->max_x / dpm_resolution;

If the unprivileged peripheral returns a value of 0, could this crash the
entire system?

>  	} else {
>  		if (rmi_register_desc_has_subpacket(item, 3)) {
>  			rx_receivers =3D buf[offset];

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-respect-x-=
y-mm-v1-0-3e85a4bec745@ixit.cz?part=3D1
