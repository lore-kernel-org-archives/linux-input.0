Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B488923ABBF
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785771999; cv=none; b=IexqqIuO0SGJoNkQlPGLGtJLJP6XLKb8ysdRryMSdKvJiAVNGhnTaFnObItDkj7By8Iry2BPzilHP3q5hT8Mj6me+VvfXvqFRkMyLQ0fokYwv3FgxOLYZoDfC+dvj93w1kvYQESjIpJ3oprm4V99cgLUN7/OJZMbnMOogAA9+DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785771999; c=relaxed/simple;
	bh=PpUMMhTYbB8JX9qqXI2RHYKq1kFjgT+1sDuBMPzKzig=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I51y1kVl3/CNF/DJxTYTGKa4/ViIKrV9xsNwWRdTfOXgOnIARVfh8rfXVW80rNlCFkDf1HcWuhk6KYPZ92hyKTpGxkqAoqR1FVED9IOvhdF1O4MgCEalucSCOYAvr94d6/Tx0oGE4kwnu3Nd2ZEHbXWE7Jc3/R5U2AuBV4QCy5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQ/WsTK7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQ/WsTK7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFD61F000E9;
	Mon,  3 Aug 2026 15:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785771998;
	bh=HKRVyfaxiFiZetmLJgNftk7472rltjs9PjujAKqcpvk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HQ/WsTK7HVZZEnT6PXj04OoL9Q78RMkMjLCQHaBJUnTryNs0lwc/dfO8vlCj1QRwi
	 jztAyr/hPB4Q2xuEGP8WgGE/BSAZ51kCSBOZJPtEGStv1psEmSNROuUfWkeQxEG7Au
	 Qtr84oHTgYnwN+JMAd4TOl3tfXLz0OQeUHSUgmANkcFaG062sRPB0QI/Nw6ISeovmM
	 ddm345DLSMbaSSECsOd/CnH8ivLCFMWQxL1RGljJ1CSokaxhv4Qk6VcwG1XAWpJ3Go
	 rsIwI4PgdHiHKSt0fSRoqri1TwyaPX4Qgq5EEIUxLv2wJaPvCP3Na/FQmr5rfXtMeg
	 y+AN4V0qY823Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] Input: xpad - add sdata_check() to xpad controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Griffin Kroah-Hartman" <griffin@kroah.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260803-xpadone_packet_fix-v1-2-280da203f15c@kroah.com>
References: <20260803-xpadone_packet_fix-v1-0-280da203f15c@kroah.com>
 <20260803-xpadone_packet_fix-v1-2-280da203f15c@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 15:46:37 +0000
Message-Id: <20260803154638.0AFD61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is a use-a=
fter-free of `input_dev` in the error path of `xpad_presence_work()` when `=
xpad_init_input()` fails.
--

--- Patch [2]: [PATCH 2/3] Input: xpad - add sdata_check() to xpad controll=
ers ---
commit 559bf574edac1c4551addcfb6bbff7b5065fbbc5
Author: Griffin Kroah-Hartman <griffin@kroah.com>

Input: xpad - add sdata_check() to xpad controllers

This commit adds the sdata_check() safety wrapper to the
xpad_process_packet() branch. It passes the actual length of the urb
to ensure packet bounds are checked properly. This prevents out-of-bounds
reads during interrupt handling for the original Xbox Controller.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index c516860711a82..319a4c4a695fe 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -813,9 +813,13 @@ static void xpad360w_poweroff_controller(struct usb_=
xpad *xpad);
>   *	The used report descriptor was taken from ITO Takayuki's website:
>   *	 http://euc.jp/periphs/xbox-controller.ja.html
>   */
> -static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned=
 char *data)
> +static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned=
 char *data, u32 len)
>  {
>  	struct input_dev *dev =3D xpad->dev;
> +	struct safe_data sdata;
> +
> +	sdata.data =3D data;
> +	sdata.len =3D len;

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but there is a use-after-free
of input_dev in the error path of xpad_presence_work() when xpad_init_input=
()
fails.

In xpad_init_input(), xpad->dev is assigned to the newly allocated input_de=
v.
If initialization fails later, the function jumps to err_free_input and fre=
es
input_dev, but leaves xpad->dev pointing to the freed memory:

drivers/input/joystick/xpad.c:xpad_init_input() {
    ...
	xpad->dev =3D input_dev;
    ...
err_free_input:
	input_free_device(input_dev);
	return error;
}

When connecting a wireless Xbox 360 controller, xpad_presence_work() calls
xpad_init_input(). If this fails, the error path dereferences the dangling
xpad->dev pointer to log the error:

drivers/input/joystick/xpad.c:xpad_presence_work() {
    ...
		error =3D xpad_init_input(xpad);
		if (error) {
			/* complain only, not much else we can do here */
			dev_err(&xpad->dev->dev,
				"unable to init device: %d\n", error);
    ...
}

Can we avoid dereferencing xpad->dev here, or wait to assign xpad->dev until
xpad_init_input() is fully successful?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-xpadone_pa=
cket_fix-v1-0-280da203f15c@kroah.com?part=3D2
