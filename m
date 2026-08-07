Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E338D37649D
	for <linux-input@vger.kernel.org>; Fri,  7 Aug 2026 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786112527; cv=none; b=IpefSSIGg/TokVv+FRQbdfZgDaTlLr2wpfGVIt9DO3BS5j3b63q0axq2BTIJbHtSm7x/ttGHNDOfAaCBGRmPc2pnyAuCJ9zhH0oPtlqYkdojSnBHyxxocb2IDxfVID+FTCawU1XCke+TGXbQqYMVDh3eP5w4BtpD05GIchQcDFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786112527; c=relaxed/simple;
	bh=pSSHPNNKp5Z5QPL75Tol1rLzLw4kIdJ0cFnEcy96keQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=riUhLZcOZUM50V+Wf5jieuLSB7sOATuVZpKZf3BgeDE1LKoChMAb/IzF+k3YrOHaPBnppb0dTDyTn6fhATq8fB0oLbwcd9CwwlvbAiZB0yMHkXveY7YddOphDCywsOvscNS8Ofn9WAs1xFoA7xG5aKjHVYV6SqToDlALFl+KPCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ir7TkAUX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ir7TkAUX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCB81F000E9;
	Fri,  7 Aug 2026 14:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786112525;
	bh=FRW2gLef6KY+JdGKu0/0i+vaSi28aXMfxMe6g9ZmHu0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ir7TkAUXIwAH5LNiWa0gmInWg1QiRE2F2urSc9DJ4MF/SXiywFi/Wujf68efBGOar
	 U/C4r0ocPr1HHQ1rr9GK71SQQ9crRYiuB/wI4VFWMNGMxAchhaAMmXPp1isvcms+6/
	 S5pSCCxSQhB8KxPUedpHwShBYku0bmIh629EbSg6wEzXa7Hpgitw+OsK4uwp0VdRCP
	 +loJOHsODFcL+J9nwNH2E2fd9D++7mJoCDmkPcOSSuU423Z4Npwo2DATn4/uq/Pa8C
	 vudXx4qxTl3BX/NsUCtiTcsc9xf7SDHybwqvZnxCLpFYNdHFnAXKIWglgQ0jKw9QYm
	 at9EXTIionuIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: xpad - fix button mapping on Razer Atrox Xbox
 One
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vernon Di Carlo" <vernondicarlo@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260807141419.7930-1-vernondicarlo@gmail.com>
References: <20260807141419.7930-1-vernondicarlo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 14:22:04 +0000
Message-Id: <20260807142205.3BCB81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect fallback logic for short packets on Razer Atrox Xbox O=
ne controllers
--

--- Patch [1]: [PATCH] Input: xpad - fix button mapping on Razer Atrox Xbox=
 One ---
commit 13a313431546b71a3cf1a1ca198625dd7324af1f
Author: Vernon Di Carlo <vernondicarlo@gmail.com>

Input: xpad - fix button mapping on Razer Atrox Xbox One

This commit adds a specific mapping quirk for the Razer Atrox Arcade Stick
to swap LB/RB and correctly report the digital LT/RT states from byte 22.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index feb8f368f834e..b9daa334e038b 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
[ ... ]
> @@ -1133,10 +1140,15 @@ static void xpadone_process_packet(struct usb_xpa=
d *xpad, u16 cmd, unsigned char
> =20
>  		/* triggers left/right */
>  		if (xpad->mapping & MAP_TRIGGERS_TO_BUTTONS) {
> -			input_report_key(dev, BTN_TL2,
> -					(__u16) le16_to_cpup((__le16 *)(data + 6)));
> -			input_report_key(dev, BTN_TR2,
> -					(__u16) le16_to_cpup((__le16 *)(data + 8)));
> +			if ((xpad->mapping & MAP_ATROX) && len > 22) {
> +				input_report_key(dev, BTN_TL2, data[22] & BIT(7));
> +				input_report_key(dev, BTN_TR2, data[22] & BIT(6));
> +			} else {

[Severity: Medium]
If a Razer Atrox controller sends a packet with a length of 22 bytes or
fewer, won't this fall through to the else block?

Does this cause the driver to incorrectly interpret data[6] and data[8]
as trigger states and report spurious trigger events for this device?

> +				input_report_key(dev, BTN_TL2,
> +						(__u16) le16_to_cpup((__le16 *)(data + 6)));
> +				input_report_key(dev, BTN_TR2,
> +						(__u16) le16_to_cpup((__le16 *)(data + 8)));
> +			}
>  		} else {
>  			input_report_abs(dev, ABS_Z,
>  					(__u16) le16_to_cpup((__le16 *)(data + 6)));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807141419.7930=
-1-vernondicarlo@gmail.com?part=3D1
