Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F58328B5E
	for <linux-input@vger.kernel.org>; Thu,  7 May 2026 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778176142; cv=none; b=l9j8qD7F6XEEPIAIh3EVAAyKYUWfdHvS9dV++sywaYYL+Fl4VKGSSUjtP+Jed3OWepIVyWnNF36gClqXIU+xvyW2XPuH3RNkSF6RF+Mr+1LfsTACE4gRf3n8RGzch2yTujxm9fFLU1oxlCIbWs5VMsdhx9CJbUxQtVEgJkXrv0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778176142; c=relaxed/simple;
	bh=/rfGN31gBAoYNHm0Nkyv5w8RIzfVXrJ0VbcfKLGEcYE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sFM5h4w8XGl/4C6afVOh2IiTaeOAUkloBnLjIm1ngdj62vmqd+fDLmpnxRl8Q4iiP/XUiA4P6f/D5ceDTv78sNnQylCAvw8yHjh1MUaTjSAsQLKxo7o3/uAzrr/CNJ7Z88TFa9fnh9Tg+i/EWuiuOAEHZ1mlGNd/5ZfmsGavqTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedts.com; spf=pass smtp.mailfrom=embeddedts.com; dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b=O5+46LvY; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedts.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b="O5+46LvY"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2f0ad52830cso1733581eec.1
        for <linux-input@vger.kernel.org>; Thu, 07 May 2026 10:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedts.com; s=google; t=1778176140; x=1778780940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3ZHU3nanBKhjSJAqE3SeT4vC0lZMcS3uOQ8aS9388gw=;
        b=O5+46LvY/R8A/j1G7UTADiFB5azdzYHRaY8VajmmMYPsXw+boBFToRKrg7aW7tZwXD
         fygskcNt4knjblhAPZiP3Z90tjPBUuboVXOIBV6nnnchUiF8qK8akwsexgcvBJdf2uve
         p0yWhMNe0zhMOiYqOXjuM3BtFH0MACx6OkwFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778176140; x=1778780940;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZHU3nanBKhjSJAqE3SeT4vC0lZMcS3uOQ8aS9388gw=;
        b=ZWTfwHJdFxQMA72epjdKQQyLT/jTxIWfppzSkJj1ga2tIatsZBMUsaz+B6ttV86vq+
         e3dWXINBAMLvwLDFE9MoHBF33AiVyWc5YIOVD+zzm0cyXhZq+F5OwbL3cbOWYtHVLZae
         Ydf/OUPI5K5rxZzKVoPGe0fUwMtme4ZXrfZfDN5lUMiFomK0wKr7Tb9YLuSe5qIFANh7
         SmDBnQLGl9YCTF4m4Jt1gfl8Na3pNTzxE6sXXQXNipp+OzxfDU+Tz4rRwrR+4oRogQ/N
         odc/zMvDDx0tZfg6BXibwCCJbakLr6JBFuXEgXq7tCvwuhCCjx5FMbjaUJ4+/dX/BsnD
         uW7w==
X-Forwarded-Encrypted: i=1; AFNElJ89XFeuvPK+kqAjD5XXO1K44b1dsCeMbxoMsNcHUXgs6NY6E+0NhyZ02TO4ktyxllCGnqJLoIw51y7ycA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiQ4sYZCvTtZPEyXLd+KWJL7ZkRYGFY4ICvM38IPl0DoIBP9eI
	gb5n9kgQRrdvtMPOT6uCY7ePoAniS9cU/Q0nvC4jiDlnZAKJUCYDPmBE4G9wdxj+0gimbLxbWlQ
	hFlBCzUYzCA==
X-Gm-Gg: Acq92OH/RUfUR/x5Tn+Oh6Mpn33/CyOf63YjpG2Ov/5yiO4p4pG88EQDYiIEZT5BH7E
	GuVOBakzqaqvWn/9DEC+Yy970Nry8VMeeRew+7cGBu0GVtOz3JW0BBL0n426l2rG7eNLCX1p/x/
	X39xGIgABTzgs290x/IA4MWFIr0aooN7X1jZlDBx3kkXsydm/1j5TFpvdo9EIVktwTrl9RxnG2m
	w2hOIaz5WRPqttLTeGS59MXJL8xdqzQaksyTySZiEqaFPmgdNJpq94bUh7tTt20TofNu7MeN2JE
	HoiS43wB+VGUwehKY+Qs2T3/T++Bc8QY4FI+5+mGiLhO7/vN9WmeupSbYCOuv/OtRjCxfQS6VYj
	qWSuftFaeFpyr+7OwffiUIkc+tI7MTVqAc7FaR2G2rsAVJT/is1VNKWYpKhtORR2G1pyjb1l7P5
	DgojybxtA94DWJJG2x+KWGWSolcBaWHor31UYWYUzjCuUyP/Kev3MoBIoKU8JNNa/UZOYdjWrzP
	H2ZHyZS7V7V9BojwWchmQzpVcY3Lcf4FJz4zE4GhWNA4sqJvo4oCc7LQTj20JYziZ/FnQ==
X-Received: by 2002:a05:7300:a987:b0:2c5:60d0:702e with SMTP id 5a478bee46e88-2f54a77f55cmr4500413eec.18.1778176139630;
        Thu, 07 May 2026 10:48:59 -0700 (PDT)
Received: from [10.10.10.191] ([184.3.231.126])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f570384e46sm9686981eec.26.2026.05.07.10.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 10:48:58 -0700 (PDT)
From: Kris Bahnsen <kris@embeddedts.com>
X-Google-Original-From: Kris Bahnsen <kris@embeddedTS.com>
Message-ID: <cf9e30d8-f51b-4a19-ae7d-914e6bccb265@embeddedTS.com>
Date: Thu, 7 May 2026 10:48:57 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: ads7846 - consolidate coordinate filtering logic
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Mark Featherston <mark@embeddedts.com>, Marek Vasut <marex@nabladev.com>,
 linux-kernel@vger.kernel.org
References: <afl3WtbabMFNjE24@google.com>
Content-Language: en-US
In-Reply-To: <afl3WtbabMFNjE24@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dmitry,

On 5/4/26 9:54 PM, Dmitry Torokhov wrote:
> The ads7846 driver has two separate filtering functions,
> ads7846_filter() and ads7846_filter_one(), for the full-duplex and
> half-duplex SPI paths, respectively.
> 
> They can be consolidated by extracting the core filtering logic for a
> single command into a helper function, ads7846_filter_cmd(), which
> iterates from l->skip to l->count. The half-duplex setup function is
> updated to set l->skip = l->count - 1 so that the helper only processes
> the last sample, preserving the original half-duplex behavior.
> 
> Assisted-by: Gemini:gemini-3.1-pro
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> Not tested so will appreciate if someone could give it a spin.

Forgive my ignorance, but I am unsure of the base commit this applies
to and I'm unable to apply it to current HEAD of linux, linux-next,
or your input tree.

I also am not easily able to test this if it doesn't cleanly apply
to the latest LTS, but will do what I can once I know what other
patches I would need to pull in to our tree.

>  drivers/input/touchscreen/ads7846.c | 74 +++++++++++++++--------------
>  1 file changed, 38 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index d3b529333ca2..093f4b56cc18 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -759,52 +759,54 @@ static bool ads7846_cmd_need_settle(enum ads7846_cmds cmd_idx)
>  	return false;
>  }
>  
> -static int ads7846_filter(struct ads7846 *ts)
> +static int ads7846_filter_cmd(struct ads7846 *ts, unsigned int cmd_idx)
>  {
>  	struct ads7846_packet *packet = ts->packet;
> -	int action;
> -	int val;
> -	unsigned int cmd_idx, b;
> +	struct ads7846_buf_layout *l = &packet->l[cmd_idx];
> +	unsigned int b;
>  
> -	packet->ignore = false;
> -	for (cmd_idx = packet->last_cmd_idx; cmd_idx < packet->cmds - 1; cmd_idx++) {
> -		struct ads7846_buf_layout *l = &packet->l[cmd_idx];
> +	for (b = l->skip; b < l->count; b++) {
> +		int val = ads7846_get_value(&packet->rx[l->offset + b]);
>  
> -		packet->last_cmd_idx = cmd_idx;
> +		switch (ts->filter(ts->filter_data, cmd_idx, &val)) {
> +		case ADS7846_FILTER_REPEAT:
> +			if (b == l->count - 1)
> +				return -EAGAIN;
> +			break;
>  
> -		for (b = l->skip; b < l->count; b++) {
> -			val = ads7846_get_value(&packet->rx[l->offset + b]);
> -
> -			action = ts->filter(ts->filter_data, cmd_idx, &val);
> -			if (action == ADS7846_FILTER_REPEAT) {
> -				if (b == l->count - 1)
> -					return -EAGAIN;
> -			} else if (action == ADS7846_FILTER_OK) {
> -				ads7846_set_cmd_val(ts, cmd_idx, val);
> -				break;
> -			} else {
> -				packet->ignore = true;
> -				return 0;
> -			}
> +		case ADS7846_FILTER_OK:
> +			ads7846_set_cmd_val(ts, cmd_idx, val);
> +			return 0;
> +
> +		case ADS7846_FILTER_IGNORE:
> +		default:
> +			return -EIO;
>  		}
>  	}
>  
> -	return 0;
> +	return -EIO;
>  }
>  
> -static int ads7846_filter_one(struct ads7846 *ts, unsigned int cmd_idx)
> +static int ads7846_filter(struct ads7846 *ts)
>  {
>  	struct ads7846_packet *packet = ts->packet;
> -	struct ads7846_buf_layout *l = &packet->l[cmd_idx];
> -	int action, val;
> -
> -	val = ads7846_get_value(&packet->rx[l->offset + l->count - 1]);
> -	action = ts->filter(ts->filter_data, cmd_idx, &val);
> -	if (action == ADS7846_FILTER_REPEAT)
> -		return -EAGAIN;
> -	else if (action != ADS7846_FILTER_OK)
> -		return -EIO;
> -	ads7846_set_cmd_val(ts, cmd_idx, val);
> +	unsigned int cmd_idx;
> +	int error;
> +
> +	packet->ignore = false;
> +	for (cmd_idx = packet->last_cmd_idx; cmd_idx < packet->cmds - 1; cmd_idx++) {
> +		packet->last_cmd_idx = cmd_idx;
> +
> +		error = ads7846_filter_cmd(ts, cmd_idx);
> +		if (error) {
> +			if (error == -EAGAIN)
> +				return -EAGAIN;
> +
> +			packet->ignore = true;
> +			return 0;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -857,7 +859,7 @@ static void ads7846_halfd_read_state(struct ads7846 *ts)
>  		if (msg_idx == ts->msg_count - 1)
>  			break;
>  
> -		error = ads7846_filter_one(ts, msg_idx);
> +		error = ads7846_filter_cmd(ts, msg_idx);
>  		if (error == -EAGAIN) {
>  			continue;
>  		} else if (error) {
> @@ -1119,7 +1121,7 @@ static int ads7846_halfd_spi_msg(struct ads7846 *ts,
>  		l->offset = offset;
>  		offset += max_count;
>  		l->count = max_count;
> -		l->skip = 0;
> +		l->skip = max_count - 1;
>  		size += sizeof(*packet->rx) * max_count;
>  	}
>  

-- 
Kris Bahnsen
Software Engineer
embeddedTS

