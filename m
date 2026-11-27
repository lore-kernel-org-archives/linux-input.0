Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795811093;
	b=1UBG9nYzeY7esjtK7KQj787CMvM4ecVlxBTEq2Vp7JZNpAxyhfhOmRKWmm8z8hzI2wx8
	 xJY6/010aNVOS/WH7N/Iv9INcr2DRa3YUhAeaq8dnqPlBQlY56U0IHSy0VK7ByAHxNz04
	 +2hbNKaNBoDb1aoXfKJU/ITDjc3KwXYdZtODlB4VkcJcsFbQTE+JY7iG1GxV6P8XyVPl0
	 zH+bUEj+9zHFEnFczXYhtulUoTq2EJmn5CZ/Dn1/I8+eEXl2YA1qA0mpll9gG1kmZKsAw
	 KqXPPpGM/7YNfbBRurIcL9ajNlsk1UrlaZE0kIZ1yDnTO2XIciAKza/zstGvklSOh1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795811093;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IUHOrklVYlf0/EmH98TMjz/a60nM1Ogmf5WyVS9cUOQ=;
	b=0ngSAA00BmQxzmrgMXhvAiCa+BCE7JTV7x2lkVC9fH4mGvZFOpzaKcQLzpS/JwY5u0YV
	 54AdIv+9ZCqYEp8nTlq9BgJAr/Zi68BCZicsV6nYV8skBSMqGa/isdNmYRq8s2RaZSUnj
	 uNc3B+CvplO13BEIlRcEkN5VPc5D4UAWxJ4JXmYwdC8VYj1BVIAyqU5ms4CLUcplFKuLz
	 M6pPEyAUAF8KdXJrTwthwW3X1b5Yo0ZnRKjQ1+RxZtbOkBqdJPAY9VbIyWSKte017mUrP
	 i5Xp3DW7KHqoQTmgTWjwixMu/V+2A6kWzsE90FpBmCTZ1N0w4waYY9e19MyVjfRyWaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+knbZPf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9430F606A31C
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 20:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+knbZPf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D1E1F000C1;
	Fri, 27 Nov 2026 20:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795811093;
	bh=IUHOrklVYlf0/EmH98TMjz/a60nM1Ogmf5WyVS9cUOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n+knbZPfsmJ57lHFSTSCalP5DWAyjQ/HnyG7iagRms4MKYmipKRmh53Xi7i/vv3U2
	 N9PG7eAu20ME6R1/ZdnuUpqKsH8HEZNY781qr0xjoQvGjGh+jxi9chzqp0+Ju1Ve1V
	 xUI35Rpu3oiDcHDAZkeDAaDnhBbxdcqG7EHYyVoe5OU77umYlE2VrksjlJqNxBQjtF
	 P54w8TzEJJK/K9oIL8Cm29XWAAOJcbFaoVkJaFbPjrP43IEBNltJxP9nH1HgR3wIkJ
	 sV5nM5I7xNcWtXVHBO6G3no1W2Ng4bCSMNMqC478t0CmpxPPPIozLca/SU9vNH+IqC
	 QStPUQ+tfsyxQ==
Message-ID: <sashiko-outbox-238237@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/10] Input: xpad - cancel presence work on
 xpad360w_start_input() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
In-Reply-To: <20261127201050.3532488-4-lee@kernel.org>
References: <20261127201050.3532488-1-lee@kernel.org>
 <20261127201050.3532488-4-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 20:24:52 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] Input: xpad - pad_present desync in xpad360w_start_input() on
  resume error
--

commit 0f7d5d5809640aae808009f6e404e8e6aa6dfa66
Author: Lee Jones <lee@kernel.org>

Input: xpad - cancel presence work on xpad360w_start_input() failure

This commit cancels xpad->work when xpad_inquiry_pad_presence() fails in
xpad360w_start_input() and cleans up any created input device and output
URBs if xpad360w_start_input() fails during xpad_probe().

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 86f4e756a7fc4..ba0f5684f3d66 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -1880,6 +1880,7 @@ static int xpad360w_start_input(struct usb_xpad *xp=
ad)
>  	error =3D xpad_inquiry_pad_presence(xpad);
>  	if (error) {
>  		usb_kill_urb(xpad->irq_in);
> +		cancel_work_sync(&xpad->work);
>  		return error;
>  	}

[Severity: Medium]
Can cancel_work_sync(&xpad->work) leave xpad->pad_present out of sync with
xpad->input_created when xpad360w_start_input() fails during xpad_resume()?

xpad360w_process_packet() updates xpad->pad_present in the URB completion
callback before scheduling xpad->work:

drivers/input/joystick/xpad.c:xpad360w_process_packet() {
    ...
		if (xpad->pad_present !=3D present) {
			xpad->pad_present =3D present;
			schedule_work(&xpad->work);
		}
    ...
}

When xpad_resume() calls xpad360w_start_input() on a live struct usb_xpad
and xpad_inquiry_pad_presence() fails after an incoming packet has already
flipped xpad->pad_present and queued xpad->work, cancelling the pending
work item without running xpad_presence_work() leaves xpad->pad_present in
the new state while xpad->input_created and xpad->x360w_dev remain in the
old state.

Depending on which transition was cancelled, later connection reports are
either ignored because xpad->pad_present is stuck at true, or cause a
later connection to call xpad_init_input() again while xpad->input_created
is already true, overwriting xpad->dev and xpad->led and leaking the
previous input and LED devices.  Using flush_work(&xpad->work) here (as
xpad360w_stop_input() does) would allow any queued transition to complete.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127201050.3532=
488-1-lee@kernel.org?part=3D3
