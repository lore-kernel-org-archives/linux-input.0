Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607612E6CC7
	for <linux-input@vger.kernel.org>; Sat, 18 Apr 2026 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776530083; cv=none; b=JFKf3KbmqUH6MczeitFQRJIGHBUTMbsDhtQJDIkq1DpIaxkrLf9BlsWeVJlvZw3xZbWgUemRsq4byu1n3/sgo/O6pSW+nBPlgQ24aJ8sB4b4Beo1sJatO/WYlonUNbEnjt9vFPJ7LkktdwSOy4aBKh6vwMfA0uMzgmChKNCkYoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776530083; c=relaxed/simple;
	bh=JDb1n0t863YlJpB5pT612flyJ3Euv3WQtPT8N/udF8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZexYX0ws2XMVPgrTPaBbbk6HN5qCkJpLw4p4vGsS0WrN87V6XC+DNc6anLqtppJeDeysF92YPDEEneBnb41rdc+kmhpwMMgbL1BUDOT5Wdw/TxELAILFlbq9psrVkdhVuMNEAuAghhBnb6LUj/gmhtEXYttoN8Cz1lo8NM7qI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=bUhH5EDV; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="bUhH5EDV"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7dca5f64e86so430283a34.0
        for <linux-input@vger.kernel.org>; Sat, 18 Apr 2026 09:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776530081; x=1777134881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UX2ZgJgegyCweH5KbrBLfo8wosIMbfIymwStHkqgwVA=;
        b=bUhH5EDVTURdBhZEaKuXgXyf9/+3rlJNzWbIvrbeTMjzYTmFHEXkVRiT461cfA8Afp
         WHshbiUH3ykhsrKaU8HqvhmxW7WVmHI/tLL12HAlmB1AZh9oTD0islkUJ2D06wSeG6DY
         5aIEgAjODXG1WFP6Ndj05ocbOkvrW0VHHb18bFgqfwjnaJXmQVjsy/W38NbhA0iRYfuD
         kDdQbMfo0eaSFEOi5ybYZ0HncGKPpybVQMoFueNWtugCEiSoFfmS9ks4tIdZttinAgDh
         UMDZRzUSsB+yFM910cR6OQo2afvsDJX1nHaDytd+0JPAhNI5DJNR/hQ7XDalU2wHlYke
         5i8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776530081; x=1777134881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UX2ZgJgegyCweH5KbrBLfo8wosIMbfIymwStHkqgwVA=;
        b=rxbaatKtBY9y0Qxhupi1Wf1bmCBePvQAtzcIcUuNun0MOTxhJ+3Z4miCTxj5ieSFKG
         bpAKPenbRtQRuO3qM1GRCNbdAPiXyf2FL7GaSRjUMKyR0u1gFRWWh/S+gOF2CITymk9W
         nIpQ4u8B9vXTRoAygtmJXW1vapeIxuUDhoA5/NJwdqnvi5sL8bAdpjWrNvOP/WmlhxRD
         0OpGtjXuEG5JVr41AgJztbg6JiZcrBeY7ltTfXwmQhsU1424Lox6TAQjpHziakZ5fSBC
         C/2x3cvg9lCn4OKGxIRXr7kBw3snC7oS1bHjH+r1pFpMo5qVc7YHBanP3GEopSqqh7wL
         nS1w==
X-Forwarded-Encrypted: i=1; AFNElJ/z9qNJT0FtQtY4LJjd2IJFbfGV0AFWlWxXNA6Ak3F/iSGbYZwZhdGc5s0vp6TGMoUDe0tWXNvfHgFw5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwET+Bx4DzSWv+fuAmX+UfV6y82Ll89MSkxEbScxlriep/vuEQj
	hGWR1+5HH0xwr9Zcy/lem4ctuMr7b++HMagEyGMZvERgxUuc8TbO3EL2+6Q3Kbi9Z64=
X-Gm-Gg: AeBDievx1fcOUg2pO+JrUjlKVQsG/TkDRyZOMLxaUd3QgyFEcuE81Kq42tYrbrkFZ79
	jqfYXShYAVNoOhym9s9F/ZxMQ1mmpb+P1S9kaHKyzcWVeofalkuw+FeiFJlyH/D5+L/Ti7Yka2c
	dLioCmtnPPplXdztfT5e7OPGJDjHsemZrd8iypDEvrlndqWr74ba6DAIIEtGkcPHUJqQ1/PyaBR
	FFhd7ETWcHz9a7EHwa9oAUHGCKJZzKpj5fk6+UpaM3Tns03/WW0P0+WQwXSHqFR6gfbAKmH/Gh6
	8/oKRoa/QBAYwj2YeYyGAF1Vu2LFbDsZtoiq4xkQ1MyQ8WRx4d9xMp54Y6B2kMq1iGhNFAmDk57
	MxB+SbCrnI98p1s471ZdotYkwtFb53tnfdIJ3HoT6P2CoOW3TMVNF+JAa5HtmSVifFgI3cQjNOn
	CYllGrMnVtmqMoIQE3mDPAA9h+p7Byqdkmby9qmXo9id8VvjOT7TW7Yph8eFfY+lWzYnGwCdEmI
	JReQPNcyOif
X-Received: by 2002:a05:6830:929:b0:7d7:cf7f:6fd with SMTP id 46e09a7af769-7dc95273245mr4540726a34.25.1776530081368;
        Sat, 18 Apr 2026 09:34:41 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b1f8:aabe:74d7:21ba? ([2600:8803:e7e4:500:b1f8:aabe:74d7:21ba])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc975034e7sm4027334a34.6.2026.04.18.09.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 09:34:40 -0700 (PDT)
Message-ID: <565d1633-0f6e-4364-8dbc-8995595f8c12@baylibre.com>
Date: Sat, 18 Apr 2026 11:34:40 -0500
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] iio: light: HID: Replace method
 prox_adjust_channel_bit_mask()
To: =?UTF-8?Q?Nat=C3=A1lia_Salvino_Andr=C3=A9?= <natalia.andre@ime.usp.br>,
 andy@kernel.org, bentiss@kernel.org, jic23@kernel.org, jikos@kernel.org,
 nuno.sa@analog.com, srinivas.pandruvada@linux.intel.com
Cc: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org
References: <20260417225959.16688-1-natalia.andre@ime.usp.br>
 <20260417225959.16688-6-natalia.andre@ime.usp.br>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260417225959.16688-6-natalia.andre@ime.usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/17/26 5:58 PM, Natália Salvino André wrote:
> Replace method prox_adjust_channel_bit_mask()
> with helper method hid_sensor_adjust_channel_bit_mask().
> 
> Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
> Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
> Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
> ---
>  drivers/iio/light/hid-sensor-prox.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> index efa904a70d0e..61f4627cffab 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -67,17 +67,6 @@ static const struct iio_chan_spec prox_channels[] = {
>  	PROX_CHANNEL(false, 0),
>  };
>  
> -/* Adjust channel real bits based on report descriptor */
> -static void prox_adjust_channel_bit_mask(struct iio_chan_spec *channels,
> -					int channel, int size)
> -{
> -	channels[channel].scan_type.sign = 's';
> -	/* Real storage bits will change based on the report desc. */
> -	channels[channel].scan_type.realbits = size * 8;
> -	/* Maximum size of a sample to capture is u32 */
> -	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
> -}
> -
>  /* Channel read_raw handler */
>  static int prox_read_raw(struct iio_dev *indio_dev,
>  			      struct iio_chan_spec const *chan,
> @@ -250,7 +239,7 @@ static int prox_parse_report(struct platform_device *pdev,
>  		st->scan_mask[0] |= BIT(index);
>  		channels[index] = prox_channels[i];
>  		channels[index].scan_index = index;
> -		prox_adjust_channel_bit_mask(channels, index,
> +		hid_sensor_adjust_channel_bit_mask(channels, index,
>  					     st->prox_attr[index].size);

Make sure to fix the alignment with `(`. Check the other patches too.

If it makes the line too long, just use one tab indent more than the previous line.

>  		dev_dbg(&pdev->dev, "prox %x:%x\n", st->prox_attr[index].index,
>  			st->prox_attr[index].report_id);

