Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795124042;
	b=cB7dzSLA46cHAxjd2/gTgH/O+mC/0VrkK0zKmqTQgkw0Fe4NAozISQWpzainIQg+eldA
	 liwlDU2t+1aJ7YAwi6InrGGbF5Lj7CKMK7K7gOGCUlIfU7z2RQ/svpJwFpSvUbb+kbo1j
	 XS7J65TvbBWaParJswt7xLtg4LKcPk2dBvDSwIblIhA9q1BwyJh8H/qYOAmBDRpfVKPNU
	 WnytAcJy7TapOUIqNIKERJR95/pGp2tY6j1Vs+KdP1b81tzhCyb95Y5sZiC7CFEg34R0f
	 hJza6qHfSsoVgQU429wbJaCMjgewATXt5bSgyKyDJ3PQV4a0y+c3yGTGA6VY0A/X0aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795124042;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=d3fqhQ82w5GQ82jcv0lf3R/3OpDP2frOr+T9wLZOh1A=;
	b=aSeZBIlE10C0Ygb2MYpOYQvCHMvtfKXQdk2eOkimEpybholfUo2l4rsIdqgnGFihvoB2
	 gWt3xxI6JHBUefN6A0NubK8j2LqVXNdILUcmbTQwKACK2rN754VLQhcC0vppBezJrgAeE
	 aaBYfJ22012X0/VCx0T64CBitZPbyeAwQikadbyTzx+R3q1+muo8RJFTwo1tb9EPzYBAa
	 5vP33MeLn5Ouny9WG5+u7GCdQy7cpTvJxyMWNk342kFP1VBX4G2YBP5pXdx0u1VxXpV9B
	 I/psGrqWrF1ILib9v8iAe6rOCwD18p4XP/akw/64ctV4j7PNJADvPsD9qcZo07WZV/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XLIQFs4B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1162606A334;
	Thu, 19 Nov 2026 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XLIQFs4B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD45A1F000C4;
	Thu, 19 Nov 2026 21:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795124042;
	bh=d3fqhQ82w5GQ82jcv0lf3R/3OpDP2frOr+T9wLZOh1A=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=XLIQFs4Bar8CDHS08XtAbifwjKZJ3TaOQ64E9YPso29kClavQZNwgKu9rX5cCnZKi
	 9r2BjtBKb5JvYKKah2jTJiLogGjeFoXb/yQ9mjYLCRLZ1YYUxl5JHxpzg+70fDbx7o
	 Rsr8I46w1eVZM8K160Iqu9ghA5nM7QhWA+SOGbA0xc9aIlCmBPH5XppmKigzfWrN2a
	 ArnrUOXNXCE50Y8nniRFxtGcSDjPY8lZNRff+jtB5WryQK1j635MjShRuc2pOW14Ll
	 EJfB/LcB2LEzm9gL6t0pxUeGr91SwNE+2yDvB2jSB1l4oO0+rocoLr/fI7P9i7jwe8
	 ehXL7Yl+DoXlw==
Date: Thu, 19 Nov 2026 22:33:59 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Jiale Yao <yaojiale02@163.com>
cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: wacom: reject short input reports
In-Reply-To: <20261017061920.3781644-1-yaojiale02@163.com>
Message-ID: <s511q250-8391-63o6-o8n6-54rp2qs7q9p8@xreary.bet>
References: <20261017061920.3781644-1-yaojiale02@163.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 17 Oct 2026, Jiale Yao wrote:

> wacom_raw_event() passes incoming reports to the pen serial extractor and
> the device-specific IRQ parsers before the HID core validates the declared
> report length. A short report can therefore make either consumer read past
> the valid input data.
> 
> Require the complete report described by the HID report descriptor before
> invoking either parser.
> 
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/hid/wacom_sys.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 40770affdbde..85e966e80012 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -175,6 +175,9 @@ static int wacom_raw_event(struct hid_device *hdev, struct hid_report *report,
>  	if (wacom->wacom_wac.features.type == BOOTLOADER)
>  		return 0;
>  
> +	if (size < hid_report_len(report))
> +		return 0;
> +
>  	if (wacom_wac_pen_serial_enforce(hdev, report, raw_data, size))
>  		return -1;

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

