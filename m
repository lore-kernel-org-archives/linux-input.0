Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02022368D79;
	Sat, 12 Sep 2026 20:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789246437; cv=none; b=i2rC/6Jf8SM0ZLUJhOIsfKm8zZRi4GdKnPTTbRpuhnY2shE75Z25v/j0wEi+iFXt47LqC5oPEYBWTWwU6wDyQNs5IGwYUOQLN0wWcmXWKpQupdzfMNZ9Uls7XaKFrMSjj1hm5qW8DTYF7CGnPD2TsAcPgSKcmoYqWNd69g3s5Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789246437; c=relaxed/simple;
	bh=6IY+Mfn868DxqN2Qi9YSlnKrEbCG8KKwnrKHyI5vDFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnIjr1+lUf06O/NM6MrsyjPLlbpvrgP6MHUc3KT2J/7SVh/Z5KxOye+RB318C9D/ULpbNOxMbnV8dOmCM8NrevUwnhuDRnDd8is9OSedpjq9m5Bo9JQd+OJyCqAN7wUOWNxzTb66FvuGVCbAr6Oz7t9s1/JwpPpwWaPhoFO0Ijc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=ZY864iZ0; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="ZY864iZ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789246428; x=1789851228; i=deller@gmx.de;
	bh=UuzlDjkUg2FyJ6a5Cg08nikXFoTwp3oWAcwzkmh0fAQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZY864iZ0cwfDtx+3uW3oUM1/JAk1N++gxSqGzuYzD2daLicaFgSQsCt1nG7ZaNnU
	 OQl8IiWMuooK/NjPkkyUxfkD+EE5gkGFEecua+X2v21rerzdV7hh1m5sIZSFkIa5x
	 xUOGaQuSecyNdB+akYRt/1gZCqLCc9VYZf9R7DBh1d0XkUCr/tGBHdKnmUdvLdDSx
	 wCLhz13J0Dl33uqFcauFwaQj7PCB4DSgyoiSWsIfrir4NYXMRqGKiW75vLxtM3vGN
	 PialweKD257NDDI3W0xtOB/+KmRgqf6u2X0xzoqYDM/Qmbfc613o5x/f/qrT4TOnj
	 qHtj5c6QpRxZsP3ZhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsYqp-1wqHzj0QxP-010C9o; Sat, 12
 Sep 2026 22:53:48 +0200
Message-ID: <42eb83ba-0da2-4986-8f70-43a754a91266@gmx.de>
Date: Sat, 12 Sep 2026 22:53:46 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: hp_sdc: shut down kicker timer on module exit
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jianhao Xu <jianhao.xu@seu.edu.cn>
References: <20260902154004.3595416-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260902154004.3595416-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QS9x/PwFto1c62E8ClwGvqdU5CxS9of69iGFUEgAArEYbTcwsdk
 5fe6Xoun/+yRDhfMPjnfBM2K3QQR08BMGvET7bjzc2uRO3mdpfD+uT0pcOgjtUsdqt69C5Q
 r0/7R7zzPV03N3Oc5qh6b87XeHkc4g2G+grQmEeAun9NskiQbi2hipg3v7zTmF14WuJnoRr
 6F8o0NGzLjMD9UQTcrQMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FLV32cID4Jc=;OOBiewEqEXrKwlJUA1JQh1QHN/J
 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

On 9/2/26 17:40, Runyu Xiao wrote:
> hp_sdc_kicker() rearms hp_sdc.kicker with mod_timer() after scheduling t=
he
> tasklet.  The module exit path uses timer_delete_sync().  That waits for=
 a
> callback already running but can still leave the timer rearmed.
>=20
> A callback can therefore leave the timer pending while hp_sdc_exit() tea=
rs
> down the driver, allowing timer activity to access dismantled driver sta=
te.
>=20
> Use timer_shutdown_sync() for final teardown.  It waits for a running
> callback and prevents rearming after module exit begins.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Acked-by: Helge Deller <deller@gmx.de>

Helge

> ---
>   drivers/input/serio/hp_sdc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/input/serio/hp_sdc.c b/drivers/input/serio/hp_sdc.c
> index 1461ef319..ecf5347b6 100644
> --- a/drivers/input/serio/hp_sdc.c
> +++ b/drivers/input/serio/hp_sdc.c
> @@ -981,7 +981,7 @@ static void hp_sdc_exit(void)
>   	free_irq(hp_sdc.irq, &hp_sdc);
>   	write_unlock_irq(&hp_sdc.lock);
>  =20
> -	timer_delete_sync(&hp_sdc.kicker);
> +	timer_shutdown_sync(&hp_sdc.kicker);
>  =20
>   	tasklet_kill(&hp_sdc.task);
>  =20

