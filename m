Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E8C331ECF
	for <linux-input@vger.kernel.org>; Sun,  2 Aug 2026 20:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785702551; cv=none; b=KZZLSPUdyYN7gNSMNx8328/RDho75KR/cEFz4pColib49uSA3BVLGO3GLhOwNcudWkn2AUSuEZXIGE0LSGk65nCuHNljs2jYVad0ZqFvC6cfqVxbAfuvyL/QzyHdzKPgq4X9XHBxRbaYmAZC/+oboOL1yaXnkjb/0aSHCG+zrdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785702551; c=relaxed/simple;
	bh=hU6z7tDH/RIBfFMVZ0vmIWyj2jSjD8asNjxERxcj6Mc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ON4eU6FjDjaPv/soux+QC+4tH5SgYPjWBl/sCDo86KYuSc3SExXHHn2NSsQM71AddTIdzHRqVhnZCEslJ39XcJiRsd2kpDR5yI8uqQpmWM4KMPTCSFSSJd+lxULqb3SjJFzPDnViXlIp3dLG9WDDDxMbpCDQZPl0AvOJIgIg3l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3Tzf7zB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3Tzf7zB"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4954c08a7c8so2022265e9.3
        for <linux-input@vger.kernel.org>; Sun, 02 Aug 2026 13:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785702548; x=1786307348; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mQQf06IDZFsoJ7D/EZprq+pM+J9k2ih+aOiCkbV2M8U=;
        b=R3Tzf7zBNVGilplnVjgsxLFzZb+C7Q9IFODerqnXInvoml2ncK0nLnFQGZ0o9Ggd/Q
         +C5XjC8XX6T5RRjsS7JJ0pSBpuJf/6ZnvGlAOyyrPQ+8/6ohi+KOsllC4na4hu0REl7l
         1BmcneSw4k7CPOW9VnpUISywgvoFPgzYsXZLFfC/j64dcp3icxmyc1wMouBD2EGMt50v
         4jDFEbWcc1P1SQY7AZxyr6mSO/DBRfhayPBt212E4aB5Bt7W3cVmX5fO7lbcy30JFRFk
         SBR1CvmIOpbtF5Ig4LI3/J8XbIgirdit+W2I2lBRH6mNUYFT3dGeqVFJQUGS0+spl5S1
         MU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785702548; x=1786307348;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mQQf06IDZFsoJ7D/EZprq+pM+J9k2ih+aOiCkbV2M8U=;
        b=kxXaVeZVpwJj2InSGCMirqJ91UMjmay/AdmtLa5tAgCrb/xrJ79ejYiDQ/ispfspCu
         jtostmUovJ03tOIomgPgPElov2R5jtc4mI5iW+MsDa9ueH4G+2O7m4K7gryPCLN2jsn0
         8Zm4JhJPz8e1D+on6U/qxlyxcFNqlmzVPwLsGB7+8dkTejUyndqmVoy6D434GVzS8/pT
         sWVT2gE0n2VQNWNmjOUd6Z130YncL1IPL+1xlIJmk9+VIrY9ct/RXTrPazhQVsTYfsRC
         Fy0FWYAmegvrbG8MERIMYD5eT0FkHkDa1/3Q4baotxhvEZD7UAASjaNkACG/dgIOYmr3
         2jew==
X-Forwarded-Encrypted: i=1; AHgh+RqLHKvmP7U055RjfUjBCtPppcXJ27FoSyzOJna2qTEOUxF3gAgoxQ1VFt3N4j+pq25Qyg4KyFRdurvFjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz231yt+3U1aalO88NKS902RO2yPaPLw25XdSF8ZRl7gO2nEKmF
	RYHh0OtvKcXK0B4k8jm8n/i+TYR0ITXFfWWb7ic2rTABl8HW1u8KxmHU
X-Gm-Gg: AR+sD11Lti2dEYizFfoujXK8NzTSahIvIgmCJiiUZ1wwjwYK/Blk6sEKRUFoePIuyA6
	W3Gz+BmoJ4hbr8oXh3UghaxaAyeV/j8vkz4D7xR5Zzs7hN19+gH7UoZAw9N7YWNEI7M0ZetRztd
	VUteaN4uKxmr7AHzqb6GuLsmWHnrekRMyTuhwpWQT7n5No6agl3avB1+6Q7ElM9s0t/SGI/044w
	7lXkoCz6G5ngBmFR9ajJTdfI4N1TfY0h5F0inTkN8vFgo3MH1NT2aSSA+JqqE3WVhFCi5PB5CDQ
	d8+AcEhtGde4XspFyjLjyOw1VBCrJaMRaM8wh+hSnwTKy7UZUBCmI565iTjD6xYzlOzk+fK6BOL
	Ij94nYmVnc/jqjJLartxNOztCCc1S9C6y/1o/sdEOPE3OW12cNlAM3hSvph/crFWFPsswBtNBAO
	fEzwoYb/y9C+gHshZ7RqVGmW85EJPOdA3nnha2XSBhSFJ/xbLCoIEMd2KFw4GCpwPzHoZY9QiUf
	xl5dRG1QZz7AGO733JaiPTOjGW7cEKMHx2pWmTtBZ0IfEWF
X-Received: by 2002:a05:600c:1d21:b0:495:6713:9ae2 with SMTP id 5b1f17b1804b1-4980c66d99bmr96563135e9.1.1785702547947;
        Sun, 02 Aug 2026 13:29:07 -0700 (PDT)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b9441csm158560585e9.4.2026.08.02.13.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 13:29:07 -0700 (PDT)
Message-ID: <5ca2e1c1eb36880a0686682588dcb2b6799121ff.camel@gmail.com>
Subject: Re: [PATCH] HID: pidff: fix OOB write when hid->inputs is empty
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Baul Lee <baul.lee@xbow.com>, linux-input@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oleg@makarenk.ooo, jikos@kernel.org, bentiss@kernel.org, 
	federico.kirschbaum@xbow.com
Date: Sun, 02 Aug 2026 22:29:06 +0200
In-Reply-To: <20260726062503.43717-1-baul.lee@xbow.com>
References: <20260726062503.43717-1-baul.lee@xbow.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-07-26 at 15:25 +0900, Baul Lee wrote:
> hid_pidff_init_with_quirks() derives its input_dev from
>=20
> 	list_entry(hid->inputs.next, struct hid_input, list)
>=20
> without first checking that hid->inputs is non-empty.  The list member
> of struct hid_input is at offset 0, so on an empty list list_entry()
> yields &hid->inputs itself and the following hidinput->input load reads
> an unrelated member of struct hid_device.  dev is then a type-confused
> pointer, and force-feedback init writes through it: each
> set_bit(FF_*, dev->ffbit) stores 8 bytes at dev + 192, past the end of
> the object dev actually aliases, and input_ff_create() adds further
> writes of a heap pointer and two function pointers.
>=20
> Until hid-universal-pidff the only caller was hid_pidff_init() from
> usbhid, which runs under HID_CLAIMED_INPUT and therefore always has at
> least one hid_input.  universal_pidff_probe() starts the device with
> HID_CONNECT_DEFAULT & ~HID_CONNECT_FF and then calls
> hid_pidff_init_with_quirks() directly whenever the descriptor carries a
> PID usage page, bypassing that gate.  A report descriptor whose only
> application collection is on HID_UP_PID leaves hid->inputs empty while
> hid_connect() still succeeds through the hidraw claim, so probe reaches
> the unguarded list_entry().
>=20
> The write happens in the USB probe path, on the hotplug workqueue, so
> plugging in a malicious device is enough to trigger it; no attacker
> software and no logged-in user are required.  KASAN reports an 8-byte
> out-of-bounds write in hid_pidff_init_with_quirks() reached from
> universal_pidff_probe().
>=20
> Check for an empty list before deriving dev and return -ENODEV, as the
> other HID force-feedback drivers already do.  universal_pidff_probe()
> propagates the error and unwinds.
>=20
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
>=20
> Fixes: f06bf8d94fff ("HID: Add hid-universal-pidff driver and supported d=
evice ids")
> Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
> Reported-by: Baul Lee <baul.lee@xbow.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>
> ---
>  drivers/hid/usbhid/hid-pidff.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidf=
f.c
> index 5f4395f7c645..22951b7ecd17 100644
> --- a/drivers/hid/usbhid/hid-pidff.c
> +++ b/drivers/hid/usbhid/hid-pidff.c
> @@ -1539,13 +1539,20 @@ static int pidff_check_autocenter(struct pidff_de=
vice *pidff,
>  int hid_pidff_init_with_quirks(struct hid_device *hid, u32 initial_quirk=
s)
>  {
>  	struct pidff_device *pidff;
> -	struct hid_input *hidinput =3D
> -		list_entry(hid->inputs.next, struct hid_input, list);
> -	struct input_dev *dev =3D hidinput->input;
> +	struct hid_input *hidinput;
> +	struct input_dev *dev;
>  	struct ff_device *ff;
>  	int max_effects;
>  	int error;
> =20
> +	if (list_empty(&hid->inputs)) {
> +		hid_err(hid, "no inputs found\n");
> +		return -ENODEV;
> +	}
> +
> +	hidinput =3D list_first_entry(&hid->inputs, struct hid_input, list);
> +	dev =3D hidinput->input;
> +
>  	hid_dbg(hid, "starting pid init\n");
> =20
>  	if (list_empty(&hid->report_enum[HID_OUTPUT_REPORT].report_list)) {

Looks good, doesn't break anything and will help in such scenario.
Thanks!
--=20
Reviewed-by: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
