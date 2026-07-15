Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364563D0932
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105086; cv=none; b=VuA6oonwa4+YYK8148eNbqlQ9lRM1h2vrViHEbnMfGPqCXJO32cobQ8UMQSIL2kXh9hMqaEQx/Ffn+Pab/VrcMLO7SS/YQFzKCtJ2zUWKQEL4SsOxq5JekTnRUMMPpEdAUJCEI2qKT9mbWOnDm8aJEU36SULTo3b8tWP1jW/aA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105086; c=relaxed/simple;
	bh=3/z7M+8Jo4kxFLo7KHkeo/DhhrG5RdWhKkdf0F4Sk5c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gwyiNnviGZdQnAO+17B2aZY17G3+puUoqsxTGPicKTFemmH2kfsMOT8T1JJsONGs3j98PriCqZqhMR5Sic4Lnf52LvyRP5TEenbZtMgJNO5ALo4BUOssHb/3r6q/40O5LHyK0pr1lSt1IW75WJsWaNozWspm5wnT5ytCWMBvPY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8nbNkWc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8nbNkWc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E131F000E9;
	Wed, 15 Jul 2026 08:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784105082;
	bh=k4ZVp5UMx1sUPQXLCgOMLZKSpsqYSIjiDZLV0jDgpLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h8nbNkWcfmYA1S9huL7evggX5/joQklKwJecp/b/i4qkDdp+2Cs9EA2SUq0ahqqt0
	 alHOBFKypw0lBGs13zlwkfF3KQq49Z9Ki9FrCJM7avTXikJOjHUeF66w+YXDoCQ0yi
	 iozp1h+FE7ujcygeFI0cF200h2dU1RYV4OhqPyFIb4/VrgW8uwqpoZ8Waf3P7szsbV
	 MROGgATub/68AEF35iI5sfHhXqRccEkCz11VNE4dT8t+exIdvFNPJ9fOOy81GFQd9q
	 TsMCH6foYHU+NJH5eBuP0lt6MDooEjkVzYXl1b6mMebJr+UeTGBubKaTLbjiFkv0qx
	 pkW7EOI31A4aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: xpad: validate Xbox One report lengths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260715083424.25944-1-pengpeng@iscas.ac.cn>
References: <20260715083424.25944-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 08:44:41 +0000
Message-Id: <20260715084442.58E131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Handling GIP_CMD_ANNOUNCE in xpadone_process_packet calls xpad_sta=
rt_input(), leading to sleeping functions being called in atomic context an=
d a potential deadlock.
--

--- Patch [1]: [PATCH] Input: xpad: validate Xbox One report lengths ---
commit b48d8bd27dd206f904c7c21ce961f7a9225d4190
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: Input: xpad: validate Xbox One report lengths

This commit adds bounds checking to xpadone_process_packet() to prevent
out-of-bounds reads on short USB reports. It validates that mandatory and
optional fields fall within urb->actual_length before processing them.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index feb8f368f834e..9a32e7eb464d5 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c

[ ... ]

> @@ -1079,6 +1093,9 @@ static void xpadone_process_packet(struct usb_xpad =
*xpad, u16 cmd, unsigned char
>  					 error);
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but does the GIP_CMD_ANNOUNCE
handling in the code right above this snippet sleep in atomic context?

xpadone_process_packet() executes in the atomic context of the xpad_irq_in
URB completion handler. When handling a GIP_CMD_ANNOUNCE packet, it calls
xpad_start_input().

This leads to a sleep-in-atomic violation due to a sleeping allocation:

xpadone_process_packet()
  -> xpad_start_input()
       -> usb_submit_urb(xpad->irq_in, GFP_KERNEL)

It also takes a mutex during USB control messages, which can sleep:

xpadone_process_packet()
  -> xpad_start_input()
       -> xpad_start_xbox_one()
            -> usb_set_interface(xpad->udev, GIP_WIRED_INTF_AUDIO, 0)

Finally, if xpad_start_input() fails, does the error path deadlock?=20
It appears to wait indefinitely for the completion handler it is=20
currently executing inside of:

xpadone_process_packet()
  -> xpad_start_input()
       -> usb_kill_urb(xpad->irq_in)

>  	} else if (data[0] =3D=3D GIP_CMD_INPUT) { /* The main valid packet typ=
e for inputs */
> +		if (len < 18)
> +			return;
> +
>  		/* menu/view buttons */
>  		input_report_key(dev, BTN_START,  data[4] & BIT(2));
>  		input_report_key(dev, BTN_SELECT, data[4] & BIT(3));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715083424.2594=
4-1-pengpeng@iscas.ac.cn?part=3D1
