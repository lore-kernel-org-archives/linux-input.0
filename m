Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE335222590
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 04:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781325072; cv=none; b=D7URRSCypLobbjNpxvwXVVa8Wc9wQWoP2BjXUL95ZpTrPQmH4bxuUCW09LynxqXI2vVZlXV74OBACYMQBXx+7h7laDf3owQGeXC6SX/1ZrUR8Hx6EQRQJy5y+2l/XJB/g/mcdkPv7Q0tf3h5sF0RYO4umOWukFU/KwXAOXzhIXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781325072; c=relaxed/simple;
	bh=XjWCoXfe3EVIOmGEWztq1x9Hvo51Nc2IwShzWNGvE7o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RAM0WwCZwv+Kj+Xw9BGZBmQ6/R33XwAHTVFiHDTF1GODxdFGfmMMRfl8skIUg9Vg2FjbAB64jOqYcSCo9vWZUu84rB0K/3sjaZaSayut/L70ByW9fcKp6kNPCgsDaYpqKtneDATKTk8Ntynz7v9IU953T0xdXlCJFRQMSTZBPtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2672Ykg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2672Ykg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC8E1F000E9;
	Sat, 13 Jun 2026 04:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781325070;
	bh=3wx3sM5P9tEylarOVheCHtoBdVqUdNXhjRx/yFh1ZT0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f2672YkgqPmtFf6KwT2nzUn4hRi8SVv0xLC2A13ogT9lrmuMim+d1v0Ug4Odcly7Z
	 7fxkBvmDR2qBvCkKVa2IGnQ6U4PyAPssF+tzQKDh8uMVG6r/UujJSbAzzncSLmbG2x
	 rR/4U2mCxhka38Jun0Mgy4LWk77U9VZ6qr4/VYRto/OnV1KyazaYfjVZal7oFgwLJs
	 vA6gMCd+PPcxZuwUt1s7ZWPzygb4/Fo9PlRYSQCIFUBUvj92hlFbU1fPgHgJPOui+1
	 TpvLNiGs33Q2spxonqRvkVVbdHh/c3gxFGH2Fe2HKz4cN4WbO2kkCZa71rCK0MNRhc
	 Nrbp2lWWrtBMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: mms114 - reject an oversized device packet size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas via B4 Relay" <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260612-b4-disp-dc4b8dc4-v1-1-d7cb0a828d92@proton.me>
References: <20260612-b4-disp-dc4b8dc4-v1-1-d7cb0a828d92@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 04:31:09 +0000
Message-Id: <20260613043110.1DC8E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Stack out-of-bounds read and severe struct misalignment when parsi=
ng MMS136/MMS134S touch events, leading to a kernel memory information leak.
--

commit 2622e1ec203d4e3a475cf8bb039715b16ecc29d8
Author: Bryam Vargas <hexlabsecurity@proton.me>

Input: mms114 - reject an oversized device packet size

This commit adds a bounds check to reject packet sizes from the device that
exceed the size of the local touch array. This prevents a stack out-of-boun=
ds
write caused by a malfunctioning or malicious device.

Cc: stable@vger.kernel.org

> diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscre=
en/mms114.c
> index af462086a65ca..4c75f16c503dc 100644
> --- a/drivers/input/touchscreen/mms114.c
> +++ b/drivers/input/touchscreen/mms114.c
> @@ -226,6 +226,13 @@ static irqreturn_t mms114_interrupt(int irq, void *d=
ev_id)
>  	if (packet_size <=3D 0)
>  		goto out;
> =20
> +	/* the device controls packet_size; reject anything too big for touch[]=
 */
> +	if (packet_size > (int)sizeof(touch)) {
> +		dev_err(&client->dev, "Invalid packet size %d (max %zu)\n",
> +			packet_size, sizeof(touch));
> +		goto out;
> +	}
> +
>  	/* MMS136 has slightly different event size */
>  	if (data->type =3D=3D TYPE_MMS134S || data->type =3D=3D TYPE_MMS136)
>  		touch_size =3D packet_size / MMS136_EVENT_SIZE;

[Severity: High]
This is a pre-existing issue, but does this calculation cause an out-of-bou=
nds
read and structure misalignment later in the function?

If packet_size is up to 80 (the maximum allowed by the newly added bounds
check), touch_size for MMS136 and MMS134S devices will be 80 / 6 =3D 13.

In the loop further down in mms114_interrupt():

    for (index =3D 0; index < touch_size; index++) {
        switch (touch[index].type) {

When index reaches 12, touch[12] reads 8 bytes starting from offset 96,
because sizeof(struct mms114_touch) is 8 bytes. Since the touch array is on=
ly
80 bytes long, wouldn't this read past the end of the stack buffer?

Also, since the hardware sends contiguous 6-byte events but they are iterat=
ed
using an 8-byte array step, does this misalign the parsing for every event
after the first one?

This misaligned and out-of-bounds stack data is then processed in
mms114_process_mt(), where touch->width and touch->strength are passed to
input_report_abs(). Could this inadvertently leak uninitialized stack memor=
y to
userspace?

>  	else
>  		touch_size =3D packet_size / MMS114_EVENT_SIZE;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-b4-disp-dc=
4b8dc4-v1-1-d7cb0a828d92@proton.me?part=3D1
