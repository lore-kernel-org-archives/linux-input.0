Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420043;
	b=fpNeroOek93oWjAJUDOTvuyy2DotJdZ/eQZpDUkpdo6w8OjDaC+60rTuREVzfEKhe5zI
	 iWbR7mTDNIxQcsoVzyEiNams2x38E/xHe02gkEDHtQN0uAmgUvLYSRKy4jQKjGWsy6BU2
	 SFcKGp+bP9WRCYontTqoCwlfWmhWU+kLEPmyl2+InMID+82BPLHmI6gIXUOFqPWiy3Hf1
	 gpzCQlXHbeh3qt4Fs/sYq8bYn8O51SaTmfYoQDfAqcOGvgU+U67+Au/o8Mh8rvs95dAdw
	 PjBre5+e6gnpC5irTaRdMqzLx13Tcye5uo6SG3kczaNQZc+kwOdsC5ri0S7VVoG0WFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=gXZUEJAo9ogNRdsof/4yd/DRB/vaqcwMDVHHocdwiu4=;
	b=b415GN0G05AHJAAfU3Tkz8cW3/00wBnmrNYaBmuiuVIcttiJ7sDuveA9Nd07U++Z9cEf
	 wXsmulE1koX+irw4NWi7giJShNUXyoN/kZdULCpMMuLPcvJ+dtAVjAhalJrDfcNtDITpX
	 V6eH8/l8bRePMMo+4qkRTVV+bYsIsJ3arjogTGA9GU1o3oGf0ubEvDnoxN8qMdX5RadOf
	 G+ZqJ+Iv0yuaTIDwbnhQ8/AXmvxqK2Bbaq4GRBUNLqcN9j5SWQSavoXYwTt5aPc8mot6C
	 H7KVY1mrbdjozTuZKstFxvGS35RmL+IBeKYP6/YvOqb1mu2PkaAkg5iCy/edNSeda/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cLhevcER;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5CA606B752
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 18:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA5CA606B752
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cLhevcER
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a06e79e152so1926152b3a.0
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 10:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794420042; x=1795024842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gXZUEJAo9ogNRdsof/4yd/DRB/vaqcwMDVHHocdwiu4=;
        b=cLhevcER5F0cC1w/qvx8koU/5KEhFGypHAezF5O9BGPPNqIeXMakQ46AM3CgshFBIv
         Giqd0YQJGavVCxRE9Q9DKotrEQFnTzzTJvItuYlhjXZBq+xM5+WNEwhlTdovfwLXA5EC
         mM+hyPnIzlg3Gw79i5YO55EkUhlI6WrGVXTbq7M5o9i/Jx8tNf42NUwD/TcktzxLSwo/
         7me3Op8YcBEwnMQSEHF2BhTC+V+s9/fFQ6Ds/Cg5VDkufc/QRv2WOQEQUafqfwvPrM92
         1uizui1kOGViIYLowAmaZXoxuLAfOFV6yIDMb6B9GO6N1lRu2Bf/NfS0KH7epcbfdYoF
         8pDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794420042; x=1795024842;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gXZUEJAo9ogNRdsof/4yd/DRB/vaqcwMDVHHocdwiu4=;
        b=vi8G69Qy98uEB5akTq+0jVys0PS4wUnurttGjC9gVb8nHmYJs/dV98k4dfbUnEQiFD
         XnQckqwV25OplMUPCDH21pcP1pOdFR+8+eDCzKAGMIWex3qd2w/YZEDSjf/ZolIwvMxS
         cHOETUMluoFYIZPmpudS7i3n8Q57gIdDEGpi0MV7FOB4HmHUyBHi5x3PdX3RDKm5r97W
         GIqGmKodvpBcg150zhBwIcIzDUyEy9Yho9tsvH4vjBygms8SboRiBb6A9SNQFUappj33
         UYyEptucx47r3MXyJ+EE0nRbQcslveAM9POQKo8bJJsu9KcfM6lMaCK19jAkvz92hAPc
         VB1g==
X-Forwarded-Encrypted: i=1; AL+hErHnG8awuwrOMV2M2uidOFRzayIOfv/GntP2vBNJrJ+lVjgbixim6/UTqwtS5kFoPZe5sesB7FVh4OEwqw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+/uMddchsBjdYWDdCfOH8yk3FNMY+e7srAmZEHQYA2unTn2GsA
	CA/gwUtMc6ttckgA9RDdOg857SYDmivzbNZGKu6j3acmFz9p9TYN58Fq
X-Gm-Gg: AYBFou1fuCMy7jK19GkENpY76kZKiY8twHbuUP2LBPJlv2dPULhB8IdU3BJrjRxCSeq
	0gejbPrc3pa2mRu3x4u9rR8QhDsUA90JoM5gO33m2zuh4FmfqYs4EoBkS5+ZC5PADy1J1vW9jB1
	D9p7OvJOtg+JnIDLojs27ViGtkIsS5bUq8/AuvupxN4/LOncX/I4P/vhq/x+swT0f5G14lyFwFY
	mmTVbQg6OF2h7gmsHrMRJP1dPmM2l8NwaW43Vuy/dCU/0XmbzARYJGcPOOuAhen6tzorcEOKOzy
	l8s6e3fKimXOO6GVV/li/5U3uaiEnlZDxHDJXnhftiCzZTZwBZpSobDKiyjqysRtRbveqNDj2S/
	M0ouuQ2hHkhtXnid+PdtekO4Om7Zej4WYbFW2LON50tB/B6wheclxSIjCTlxXUVPFpDj9NdoGkW
	Wv0OpRJDs8L6ud3LUCwIntYFGnE92usUGCimTwFTx2xbr+41fMqP1wsb/znOI45mpISUbSIBlu8
	YBLDglGCC7TLpKjAci1+uuNQBFLlmqq1vL1rTYr7TORHtF6DiYg+8XC878RErBHe7zGwuBNZebG
	gOUm34i+/H1SIIpiAhnC5w6qa8P3FEcll1FAk5aqcYq0mBI4Ezvv1bZDULg5k9fApRjGQclNb/d
	3u5XpfAe6EbgPFGwy
X-Received: by 2002:a05:6a00:4193:b0:89f:9ea6:1ddb with SMTP id d2e1a72fcca58-8bc1c0b732cmr2911078b3a.23.1794420041911;
        Wed, 11 Nov 2026 10:00:41 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaae3da61sm2331243b3a.35.2026.11.11.10.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 10:00:38 -0800 (PST)
Date: Wed, 11 Nov 2026 10:00:35 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Henri Ommer <henri.ommer@gmx.net>
Cc: job@noorman.info, phone-devel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] input: himax_hx83112b: Add hx83102d support
Message-ID: <avStFjE4coB0C0q3@google.com>
References: <20261111163354.36751-1-henri.ommer@gmx.net>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111163354.36751-1-henri.ommer@gmx.net>

On Wed, Nov 11, 2026 at 05:33:54PM +0100, Henri Ommer wrote:
> The core functionality of the hx83102d is software-compatible with the hx83112b. As with the hx83112b, firmware flashing is unimplemented.
> This commit also adds support for touchscreen chips which do not have a reset GPIO, like the hx83102d in the Samsung Galaxy A20e.
> 
> Tested on: Samsung Galaxy A20e (SM-A202F)
> 
> Signed-off-by: Henri Ommer <henri.ommer@gmx.net>
> ---
>  drivers/input/touchscreen/himax_hx83112b.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/himax_hx83112b.c b/drivers/input/touchscreen/himax_hx83112b.c
> index 345ece27fe74..04c9c6aba396 100644
> --- a/drivers/input/touchscreen/himax_hx83112b.c
> +++ b/drivers/input/touchscreen/himax_hx83112b.c
> @@ -7,6 +7,9 @@
>   * HX83100A support
>   * Copyright (C) 2024 Felix Kaechele <felix@kaechele.ca>
>   *
> + * HX83102D support
> + * Copyright (C) 2026 Henri Ommer <henri.ommer@gmx.net>
> + *
>   * This code is based on "Himax Android Driver Sample Code for QCT platform":
>   *
>   * Copyright (C) 2017 Himax Corporation.
> @@ -132,6 +135,14 @@ static int himax_bus_read(struct himax_ts_data *ts, u32 address, void *dst,
>  
>  static void himax_reset(struct himax_ts_data *ts)
>  {
> +	/*
> +	 * Some versions of himax touchscreen chips do not contain a reset
> +	 * GPIO. The downstream driver only resets these chips for firmware
> +	 * updates (which aren't implemented in this driver)
> +	 */
> +	if (!ts->gpiod_rst)
> +		return;
> +
>  	gpiod_set_value_cansleep(ts->gpiod_rst, 1);
>  
>  	/* Delay copied from downstream driver */
> @@ -349,7 +360,7 @@ static int himax_probe(struct i2c_client *client)
>  		return error;
>  	}
>  
> -	ts->gpiod_rst = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	ts->gpiod_rst = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);

This should be a separate patch please.

Thanks.

-- 
Dmitry
