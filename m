Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8C9492517
	for <linux-input@vger.kernel.org>; Wed,  8 Jul 2026 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520381; cv=none; b=ZQ+pBKP+9JhEujXmJtI0aeUm24Hgw7SZWAdPF8O2NGrJFaDSb+OjQIMonmKs/yOKdg5DPz5OqTNFp2t9NjqIaCCp77z24+QQs/+Pi0CzygLogk11RL243B29PkEwATsKcZy39a3gkVMFH2yIoRMW2dtyhWSGqtPntR9HAxnremk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520381; c=relaxed/simple;
	bh=Ewu4yc+qewgzVitql7HZGbAc5xLzA/HPvs60UXHYHr8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RJaj97K1L6fuVzgtWlB2DV8BLIn1RgzKxTWlRDNsoT/3mTAeZ4anG3pruKtjgSLiy85s5YL+dHGJpGrC7/pMmjAb1QGvzhDJjR3dnKHBtX7iZ0X42S95WqlF7nHfPreICPjAxTQRAvrkn2OiI9oTdvfSs25VPSJ95QKqfaq3NiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnWzWWB3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnWzWWB3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C278C1F00A3E;
	Wed,  8 Jul 2026 14:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783520380;
	bh=jR2emk45ALgeXmli9FDV5TY2VCgC2mTw+poNE15B0Mg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LnWzWWB3FRILA1YKxp15rcF5wM/yQF7nndYseUC7tj4qZJpXPHBtEilmRwDCQNVKW
	 qGN5uMh0ZFJaSsqX9g7IPaC2Veu1IkhaHeidSy/DB2uIdk6fcoMN6EFLVLX9Y+iGuZ
	 4bHDG92L9halNQz7nPe3LBt/bx2CGHTgmAFjiHG6TZsVXIcuAqOwVR7/ujpnUAfo63
	 kpUA+tW3aE4q7pyQ8GLYkJu9RCkeocZQ3AXCD/8Cgvn0224yxo5OBYpYcuuAxLloA4
	 I6zC++9jp8vqh0TCvQk9jsw1gvlRCNOYQNDLREIA/4PZmXbIkcPYupqkcS+DyequHR
	 HgkijwzB2OoSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: xpad - ignore short Xbox One packets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260708135939.774433-1-lgs201920130244@gmail.com>
References: <20260708135939.774433-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 14:19:39 +0000
Message-Id: <20260708141939.C278C1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Atomic context violation and double URB submission via xpad_start_=
input
--

--- Patch [1]: [PATCH] Input: xpad - ignore short Xbox One packets ---
commit d7d9f4eb601031ea325de5332a0575c0310240ad
Author: Guangshuo Li <lgs201920130244@gmail.com>

Input: xpad - ignore short Xbox One packets

This commit adds length checks for fixed-offset Xbox One packet fields and
skips optional extended fields when the corresponding bytes are not present.
This prevents parsing stale data left in the transfer buffer from previous
longer transfers when a malformed device sends a short packet.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index feb8f368f834e..649f59b3a162f 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c

[ ... ]

> @@ -1079,6 +1090,9 @@ static void xpadone_process_packet(struct usb_xpad =
*xpad, u16 cmd, unsigned char
>  					 error);

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to call
xpad_start_input() from here?

Since xpadone_process_packet() is called from the URB completion handler,
it runs in atomic softirq context. However, xpad_start_input() appears to
perform sleeping operations:

xpadone_process_packet()
   xpad_start_input()
      usb_submit_urb(xpad->irq_in, GFP_KERNEL);

It also calls xpad_start_xbox_one(), which uses synchronous USB control
messages that can sleep:

xpad_start_input()
   xpad_start_xbox_one()
      usb_set_interface(xpad->udev, GIP_WIRED_INTF_AUDIO, 0);

Could this sequence trigger might_sleep() warnings or cause a deadlock under
memory pressure? Additionally, could submitting xpad->irq_in while its
completion handler is still running cause a double-submission error?

>  		}
>  	} else if (data[0] =3D=3D GIP_CMD_INPUT) { /* The main valid packet typ=
e for inputs */
> +		if (len < 18)
> +			return;
> +
>  		/* menu/view buttons */
>  		input_report_key(dev, BTN_START,  data[4] & BIT(2));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708135939.7744=
33-1-lgs201920130244@gmail.com?part=3D1
