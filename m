Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3013A6B8D
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 08:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422720; cv=none; b=Y0ZvajLh79XeALO6yzA5yIG7EDpjF9tScgTr8vOEOh4UE2qEjBG4thjAgkEWYHlHitLwegHZC5oErAsRNrr7EOPxnsZ8hmqsg4pEfzZiYzGXD4GQrKrJINH4qupb31ExFuF0ms/7xMtcs1Jmmsl8R27AutAI9Z902QsNfNWepE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422720; c=relaxed/simple;
	bh=Y7Zztb0y3t4/PcN0hOAOaF5M6OULZ3oCj+vUkHERTtg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iSuYz6XixpmU/NkxS5sO023h0gjoQh8zuSzrjdmZEAG/oVqS/NqvkjMlzsgdrDdkdNt+OCvu5uu14a1pFTc0/XMJ2+i7wS/HYSfm9mQ49/I9nIvcYmTr561mrj4vOuU+a6UDSJqTIdletAWZfHUuUD8tVGsf3xxn4DUZjIMvnHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nz26YAzH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nz26YAzH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FE41F000E9;
	Thu,  3 Sep 2026 08:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788422719;
	bh=KCxepWvOvirn9BT3hgeq0PJoQXIdyzdbDFnx7MUOcqI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nz26YAzHpTR7dqERtBS7nj45tO4iV6mldcFpq8WwXgcuSs2uDCNyMSalM9HbkISNX
	 hbNn44klLjXR9iNveF4IFagwN84OZx/Bkss3klKKAMwbedf0qUWlLhRYndgpi2M60o
	 TAAun/XFS1/Sx0TpY7S+CwBSdvPXjr1KFWzDOVeWIV9lBXOP3iAiuK3V18E8zYeyWC
	 YkJ7nPV+lgye4ksU7EqNfxEN/VBtx0q2bsJYHo5Qlr9Za+b1gSGy2erT9KxTtv1kao
	 6DZoVeN/uSntnSBRijaybmOAuMm1Ob0jMbuaBgpzXVReqaDTLLSkGU8BQU8/xOBRjH
	 gZ/Xbux0qh14w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: cyapa - cap the PIP report length before the I2C
 read
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linkai Gong" <gonglinkai@kylinos.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260903075026.1069672-1-gonglinkai@kylinos.cn>
References: <20260903075026.1069672-1-gonglinkai@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 08:05:18 +0000
Message-Id: <20260903080518.C9FE41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the driver proce=
sses up to `touch_num` touch records from `report_data.touch_records` witho=
ut verifying that the `report_len` read from the I2C device is actually lar=
ge enough to contain them. If `report_len` is smaller than required but `to=
uch_num` is non-zero, it reads uninitialized kernel stack memory and report=
s it to userspace as input events.
--

commit a3170cabcda3be9e64d6692bbb6c52bf82b02d07
Author: Linkai Gong <gonglinkai@kylinos.cn>

Input: cyapa - cap the PIP report length before the I2C read

This commit fixes an issue where the PIP report length could exceed the
size of the receiving buffer. It clamps the report length to the size of the
report_data structure and bounds the number of touch records.

> diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cyapa=
_gen5.c
> index 59f6e97d54827..0c8bc37ab3fd4 100644
> --- a/drivers/input/mouse/cyapa_gen5.c
> +++ b/drivers/input/mouse/cyapa_gen5.c
> @@ -2753,6 +2753,8 @@ static void cyapa_pip_report_touches(struct cyapa *=
cyapa,
> =20
>  	touch_num =3D report_data->report_head[PIP_NUMBER_OF_TOUCH_OFFSET] &
>  			PIP_NUMBER_OF_TOUCH_MASK;
> +	if (touch_num > ARRAY_SIZE(report_data->touch_records))
> +		touch_num =3D ARRAY_SIZE(report_data->touch_records);
> =20
>  	for (i =3D 0; i < touch_num; i++)
>  		cyapa_pip_report_slot_data(cyapa,
>  			&report_data->touch_records[i]);

[Severity: High]
This isn't a bug introduced by this patch, but does this loop potentially
process uninitialized stack memory?

If a malfunctioning or malicious I2C device provides a small report_len
(e.g., 7 bytes) but a non-zero touch_num in the header, the loop iterates
up to touch_num times.

Because cyapa_pip_irq_handler() allocates an uninitialized stack buffer
for report_data and only reads report_len bytes into it:

int cyapa_pip_irq_handler(struct cyapa *cyapa)
{
	struct cyapa_pip_report_data report_data;
	[ ... ]
	ret =3D cyapa_i2c_pip_read(cyapa, (u8 *)&report_data, report_len);
}

This leaves the remainder of the touch_records array uninitialized.

Processing these records here could leak uninitialized kernel stack memory
and cause erratic phantom input events to be reported to userspace.

Should there be an additional check to verify that report_len is actually
large enough to contain touch_num records?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903075026.1069=
672-1-gonglinkai@kylinos.cn?part=3D1
