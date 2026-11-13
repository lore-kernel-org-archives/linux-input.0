Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794533461;
	b=iCS3T78L0FzaHOPuTxVWw1nzOAQOVaxK+22aWyq201EHs/ijJDQSkGgb3c2oGpifYo6y
	 r4ONOOBsFka/qe1Kf6ndlS45KynC0x6DOO6joZNgYSSBcu7Wo6CjEpBu16zI6V5JLZBl5
	 arEzR8BoWa9q4KYuCh0FuQHjU2vCQ7XrcM4dbRX51zR8mGXt1KI8z4N1xEyKl6dNeM98P
	 b+zavgrxql+po2i7N7DvpvzapNoOedJkIGekUIoPY6v77WmTDRv3QzeLn6He3cUXY4ox6
	 YqKacchVmtPiAHqvAOU7NoTAXhbYpFlnARJ4BExHm4hQB/KDmScHMgOKU2KRSOMwTug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794533461;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=/7uHJFgSP2wdQKFM07aMj/DeGGfpQo0FBIAi1jAGJLo=;
	b=tPl10gQ5dPj2Ps2fyx2pzr7+TL4zAXmSD5RnXioDt/K1c6hCiInpAyDE8FCMAGzJmupa
	 dk86Hxh0eYhReacLNUYbWWfIulH1llJFlFLSoVlc0JgpyK0v/V4AOGygRwKvcsMjm/rKV
	 Rd+BOQWz/AokMKq4B43IR1jK2H3PGEONCSa9nWL7zDFKvGTGvvt3AowaH792aa9TCC9IY
	 Z56EnnlYWBM451cvVLUY75HZ4LuPI+DRP9f9lR6G1k01PEuMtYIrmauEoUWTc9KA7WnH6
	 JUTUm1EdXzs6YPnUm1EMCXM6XN5yWn+HjH5acBhJhveSJgCfFI0+M/GQr+3pLqyX/fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0mllq87Q;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906EC606A31C
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 01:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 906EC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0mllq87Q
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3712b6d9843so460860eec.1
        for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 17:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794533460; x=1795138260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/7uHJFgSP2wdQKFM07aMj/DeGGfpQo0FBIAi1jAGJLo=;
        b=0mllq87Q4vcSKU/7bYi3BXWQEiGb4EYY1qiaiiL2oBy1LFuLkqH+Wkv/ClFrNU0CSa
         CG3W88tPRpIe1OxH4YIipMzoQGhzdx5mbZ36zkLoVEHkoYRIZAT7P20dQwoG6oXcWI2f
         CPTpNYDcog81Arvm0uJ2VqpmWVx6IQQ6TICylR9dBQafWDnQPtJgEp6ckNKAJsicH/b/
         CTcCI+S18NroZm9E0qZnQ1XPZaHvW5gtXNs+Z7Fys6VTCRdWbbJs4FcX4U6UxQkL1e2q
         HrfNBNlOdhGUBTdGOKspgTVk2Gz6SD3ZRk7dMuWF1E/UwSTYeGxY+yMtqJM4ejXR8H7b
         6EHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794533460; x=1795138260;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/7uHJFgSP2wdQKFM07aMj/DeGGfpQo0FBIAi1jAGJLo=;
        b=24tlyoK6Ul2MvLb9IJmJYsBaqH5iuO0f4CMBd7y7+Jts3DIYW6bqQPRdSxhkXR7HSB
         aoGEAb4XMaLfeDJE0L0aQLVLfdCVavh+l05PDTGDQ28j+MRR+3alf8hJJyvXbJhW7r5Y
         oseCDLMCp1KSr7n5tAiTrOJu3Eqi9M79n1yTO/pUuEFOcg5uUGltdcti6IxeFU/HVc8Q
         v/2WmMvnzXnlcm/i8ZcLWzcGuQJxbfwad+FZ0namRiSk2sPghq2MYQScOp3tGw8eocQ2
         8fIsQOuTmOSiydMS789PFTP0QD4AtIQ9AsgW7ThX1cVI4w2PoJK0GairmtoVB1cpPrJD
         gR9Q==
X-Gm-Message-State: APuU4Z9tP2qEGzO907wTBnzm5a+F+FQJUvCWO0bvAGFg4N1oo8FHsliG
	eqqo0mZ5ZcmK5CqHVgEmLl0vQyPJ9UUU6CVV7/gm7hFFmnWpWCZh3m/E
X-Gm-Gg: AYBFou2UETKcENvQGIJrq0N5CKSFKBVKkqZXHPjSfQmir1uKyezR95MmZyqCHy5hgs1
	9OTGmrIYiDx5jRg3HRfAYCz8z2TsgIZ5i8rb0fd/MLKR4KXYQaoD7PmeSkkG9txiLeoW61hIoGq
	nlACRHmQ+rcDXwxlrvh1rJwTbrewqmLsUDt0k8BsoNdDhlECC8q6o133XFhBzndpCv880CSaiCL
	MVPxJpKib1mWzZhDC1p/zrI6QI65TeIFrNe/fYYK9slcFggyFG5Cxzx9NzAjRTZgyCy3+d0WF1S
	HDn3535FL5ds6JGpI2FHWF00C7/hmuM+3Trzk+Fjz0nn+nfXrKGA/2mnWQ6FDVFu72TbreR6oZH
	NF3MmrCKs4HnHTGgy2fGgQI4rkMp4gjeozDZdEOhPTry2x76ngtui/ZSn58R83LWTyaOzQvzTvW
	bCaeIME7gN3HIFwRuDzIW4Id38cbgVoreuYQkV4uAyvW7xgcZHOPyToZJJii/WdyujUiXLyKc1f
	bsj+WKnsD27j2nCO9+ZBoLF+S9z6BHs+LGvtiwjNxLUJ5gs2aJPsfnKdxV9v/0CEBW0LSLPXaQw
	fmh+kinECi3fMNfsN0VSP64R1XdCqeGf7LlUOC4moyhPFqOVJF/12sVDyLridPvvZ1rnMx8=
X-Received: by 2002:a05:7300:6d03:b0:36c:3b8a:8090 with SMTP id 5a478bee46e88-37963a4ef35mr1313899eec.2.1794533459424;
        Thu, 12 Nov 2026 17:30:59 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:48f1:7a0b:9bfb:4205])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bb0c40sm2333563eec.28.2026.11.12.17.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 17:30:58 -0800 (PST)
Date: Thu, 12 Nov 2026 17:30:55 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] Input: goodix - sync the irq controller while starting
 firmware
Message-ID: <avZiZoGO4jXjIP7D@google.com>
References: <20261020122712.526797-1-l.scorcia@gmail.com>
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
In-Reply-To: <20261020122712.526797-1-l.scorcia@gmail.com>

Hi Luca,

On Tue, Oct 20, 2026 at 02:26:48PM +0200, Luca Leonardo Scorcia wrote:
> On the Lenovo Tab E7 TB-7104F which has a Goodix GT-912F touch screen,
> the touch screen fails to come online after loading firmware, producing
> the error "Error reading 1 bytes from 0x8041: -6".
> 
> Comparing the upstream code with the Android stock sources a call to
> goodix_int_sync is required between the upload of the firmware and the
> watchdog restart. With this change the touchscreen is correctly detected
> and working.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
> Relevant bit of the stock source driver at [1].
> 
> Credits for noticing the issue and finding its cause go to matemiller992
> on the postmarketOS forums, I cannot provide tags as he wants to stay
> anonymous.
> 
> [1] https://github.com/lscorcia/linux-lenovo-tb7104f/blob/2dad69c9f28611ac6d3db2f1ee11b480a60d83ee/kernel-4.4/drivers/input/touchscreen/mediatek/gt912_p98996/gt9xx_driver.c#L1529
> 
>  drivers/input/touchscreen/goodix_fwupload.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/goodix_fwupload.c b/drivers/input/touchscreen/goodix_fwupload.c
> index 5ae9a109ba0d..01e7705ef515 100644
> --- a/drivers/input/touchscreen/goodix_fwupload.c
> +++ b/drivers/input/touchscreen/goodix_fwupload.c
> @@ -155,6 +155,7 @@ static int goodix_enter_upload_mode(struct i2c_client *client)
>  
>  static int goodix_start_firmware(struct i2c_client *client)
>  {
> +	struct goodix_ts_data *ts = i2c_get_clientdata(client);
>  	int error;
>  	u8 val;
>  
> @@ -168,6 +169,10 @@ static int goodix_start_firmware(struct i2c_client *client)
>  	if (error)
>  		return error;
>  
> +	error = goodix_int_sync(ts);
> +	if (error)
> +		return error;
> +

There is call to goodix_int_sync() right after call to
goodix_start_firmware(). Is it still needed if we call it here? I think
the vendor drivers does not do it.

>  	error = goodix_i2c_read(client, GOODIX_REG_SW_WDT, &val, 1);
>  	if (error)
>  		return error;

Thanks.

-- 
Dmitry
