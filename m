Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795519271;
	b=BTee70HFi47pJ+mCPStzGoa2Vhsff1FdtTt5bNhEXZpLUSlMUblmc2aJkZbv3/HXTFsZ
	 yIQKgcqfnbt/ZJQ4To5FzhLF6NzH0sqIy7dVWsskUBEZ84/lCWZbCVsxoT0HYI6KUf/Qf
	 xrwXvs699K2zjJsi/fJb5XJ3eAkYwB22XoXpggvzb7kxyGZLWptJjLzAmwcln5moVORSa
	 R5JVnp+ZI2G61ah4hxm8uDEiOztli2/8VeEkhbEM72FXxkEqbLJ17TM1huvZ13n7aMhyJ
	 b8Xy+Ek2gFsw0JUOFnMgqXZL71Ji0lFznmZ8ZecHZMHmTggsJkRI4bg4FyQR8+Yx8/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519271;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=eykty3oSoGJNJdXFXeVz8CWaTenWGSavrnXua+sfRF8=;
	b=O+7FaV3sTq79C70NtyzMLnP8IlLjQSX8WwKd8fEHXAFMACypnxId/R74cIq0VQAlsq9a
	 gDV1Rhshy1Z7xkBtQwY8waCOA/KojVaexPgMu4myVmtjhFvSivHkToJNlyuxa+lnewpWB
	 eEkVynip/gjOqIA94wpMrSt4u9Qhsia6obcXGRQnSbaWrjgrggUy5QOHcYqEhi8zeyVoo
	 4+Y/FXqC93oVHI5LIbag7pgFkOSQB+ah8voZPv0ZuEPpfcIwt8QKKWbIAv0+rs0geXfkO
	 QPzhi/r2fOQrAfvbs2z3bcriHUicMs7/bV1qkeWQdZ0hXfLrpEf3OOlJdxIiBO6A8ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=mR9sDyMn;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F335606A321;
	Tue, 24 Nov 2026 11:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F335606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=mR9sDyMn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795519268;
	bh=X92meWCIe2idWIvdqkPIsxNMMdDXuDPGPKHlu8WtMvU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mR9sDyMno2ncuDBWp1CXjOfdhq2+FvMOYrlLG1QM5AiNIstJ2Fh5FFKfTDgw811W+
	 CqrrGgaUUaojO/WET+fhKLVzyMvGvX6gvzFyqx5VLJAsnwpWFwEWZ3Tll8ZZe0WkDu
	 RJtbOKK2pRbB6rdnaFtq814ERrnL3aGAJhVc57tY+YhN5fnTBfp9Sipycb/fVpeb6c
	 YQ3atOJeiT5eIydbtYUk/aho8TJUm2G0lwYTsU+vx0PnhdkNF4BfeviWXd9dyMcH03
	 kYwYE9dBAQfROwvA+qZf5QDuOXP6j0egDeTAmES2mQ0UjpLbBIRh1R4K+EhP5ty+17
	 KF0Ebeg0cztAA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8D79617E0309;
	Tue, 24 Nov 2026 12:21:08 +0100 (CET)
Message-ID: <c4dcf958-34bf-4000-91b6-d13c12814f8f@collabora.com>
Date: Tue, 24 Nov 2026 12:21:08 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Input: goodix - sync the irq controller while starting
 firmware
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 linux-mediatek@lists.infradead.org
Cc: Hans de Goede <hansg@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20261124085058.128173-1-l.scorcia@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20261124085058.128173-1-l.scorcia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/26 09:46, Luca Leonardo Scorcia wrote:
> On the Lenovo Tab E7 (TB-7104F), which has a Goodix GT-912 touch screen,
> the touch screen fails to come online after loading firmware, printing
> the error "Error reading 1 bytes from 0x8041: -6".
> 
> Comparing the upstream code with the Android stock sources, the existing
> call to goodix_int_sync should be moved between the upload of the firmware
> and the watchdog restart. With this change the touchscreen is correctly
> detected and working.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> Relevant bit of the stock source driver at [1].
> 
> Credits for noticing the issue and finding its cause go to matemiller992
> on the postmarketOS forums, I cannot provide tags as he wants to stay
> anonymous.
> 
> Patch tested on the Lenovo Tab E7 (TB-7104F).
> 
> Changes in v2:
> - Instead of adding a second call to goodix_int_sync, move the existing
>    one;
> - Simplify the access to the necessary arguments/parameters.
> 
> v1: [2]
> 
> [1] https://github.com/lscorcia/linux-lenovo-tb7104f/blob/2dad69c9f28611ac6d3db2f1ee11b480a60d83ee/kernel-4.4/drivers/input/touchscreen/mediatek/gt912_p98996/gt9xx_driver.c#L1529
> [2] https://lore.kernel.org/linux-mediatek/20261020122712.526797-1-l.scorcia@gmail.com/
> 
>   drivers/input/touchscreen/goodix_fwupload.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix_fwupload.c b/drivers/input/touchscreen/goodix_fwupload.c
> index 888da7538c06..642a632d363c 100644
> --- a/drivers/input/touchscreen/goodix_fwupload.c
> +++ b/drivers/input/touchscreen/goodix_fwupload.c
> @@ -153,8 +153,9 @@ static int goodix_enter_upload_mode(struct i2c_client *client)
>   	return 0;
>   }
>   
> -static int goodix_start_firmware(struct i2c_client *client)
> +static int goodix_start_firmware(struct goodix_ts_data *ts)
>   {
> +	struct i2c_client *client = ts->client;
>   	int error;
>   	u8 val;
>   
> @@ -168,6 +169,10 @@ static int goodix_start_firmware(struct i2c_client *client)
>   	if (error)
>   		return error;
>   
> +	error = goodix_int_sync(ts);
> +	if (error)
> +		return error;
> +
>   	error = goodix_i2c_read(client, GOODIX_REG_SW_WDT, &val, 1);
>   	if (error)
>   		return error;
> @@ -249,11 +254,7 @@ static int goodix_firmware_upload(struct goodix_ts_data *ts)
>   	if (error)
>   		return error;
>   
> -	error = goodix_start_firmware(ts->client);
> -	if (error)
> -		return error;
> -
> -	error = goodix_int_sync(ts);
> +	error = goodix_start_firmware(ts);
>   	if (error)
>   		return error;
>   

