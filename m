Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354EA2609E3
	for <linux-input@vger.kernel.org>; Sat, 18 Apr 2026 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776529938; cv=none; b=Cn4qQSalSRAjG4HBVRFaduvCj3G0NyBQbrkhdwe9FIC3W8ajVoDeGV4DhyOKLlzdpvF3vasU2Qe2+YWj2Elvs0EJQtgzigqCyzbl7TXdv9ZuTdPP5igmHPGOMyLaf/g9HMSRGemy78cGG0F4Rha+Xw7TvT7h4RoXW6Z1W6MSQo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776529938; c=relaxed/simple;
	bh=PX7Xc4ornFJUYlDahMoLBg+jWsibb+OPMgZuhF93y2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSB3JBSPrwTmnIgKa+CdwEPib6hIubDbVrhkOoQnc2ZnYBvcyHQ34HdfbiVEcXZJjeK8+Gq96HSPrOJLYsjUtJlevJqizYcHfx5Id9gj/6WP1OSiPUfM01KJD3u42VY6V2A/WqAZ30wo5HXqyYTEx4avsEIca6dwf4RP3cvsv1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=i/Gnh/Tf; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="i/Gnh/Tf"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d55b97f358so998001a34.3
        for <linux-input@vger.kernel.org>; Sat, 18 Apr 2026 09:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776529935; x=1777134735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Ku9MieWOFONWlsgDNSFQqxrZ45MKffmqudSoMnAel0=;
        b=i/Gnh/Tf5I64JIAIXpg9FyWjEsoTPbDXVOYSLG13K2CyxBvBa42n1+iHlEWf1Emrj8
         M40/9XzM38SvrQQ7nzNU4sdBkKtWvZf3SE7PCug9XS+UNsmZMwWNwr1lphhpXkMXxAbx
         hqRAG8p1jMt1u+zXEuQYTGD1v3yka49nLg1tC1IzMorIeqGtm/3OIFQMPoC3Uum5VT2F
         TY0zJFOO5bBnchBmybeaEXSAFBbafcbBCCwOU+P7RWSWya64XNJf+udOlZfngBzspbJB
         yJxpqWM0DVSEZZN1zay8YCjJNiSWdtwBCiL/ufjUsZc+HmJ+q689QpI67zGznYyZsugP
         8ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776529935; x=1777134735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Ku9MieWOFONWlsgDNSFQqxrZ45MKffmqudSoMnAel0=;
        b=Jt7QmGoUgorHjCs/JOARojFoOXO5BZWhu0E99Ncm5O1qFVFqq3Qm9pklJ6oN6muBoV
         zMvTcRjcQu9yjqYOXHf2BcLoo1jPnZCVYxELabZwPG0yoR6p9bYocGAZKCj/poG8VB4B
         ULDOeKLKnsLWWjDmepoF9Az4xV6luHbBLa+OBQPwEJZYFQ9fy4TAGL/W0mBS1N67EJdX
         /2+VYiGyUs7Nd5RzF76thjorvQcPT0aDTEO31Nt78M8vyevcZdzcVKtZ8+x6cxIUpHWq
         99Q31LxCXtFg+wgFGrLePtvJ99ieqTqsjCzCE0amxkMtSYvqxAVX4gBfdqKUnKp2Afk2
         xBvw==
X-Forwarded-Encrypted: i=1; AFNElJ/WzN1rZl57ECAmdAwH761KpAxT1WSuyRph9UxDQ490+svvnw5PYsPSUeHUY8ZgJO59Miyh26McVS24TQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3OhvFC1r+txTnQjSL/++qeg+WawRw956vwHTBlw8+NyRR456a
	BwnYNOprYz6WhA4E37RyIxSCaooRFcvAPAcj3ztD0BjAGMLB6oOE8kUVRb1u9Xe9jtI=
X-Gm-Gg: AeBDievVNlbfRTvJlFLs6F56v726xQ0LjTYgzCxcwO2x3+FYaboDTYAwoBgV7MNppJG
	HKEry5Rl5AtpRzriByiyEJ4BySBQx72RfBlDDv/z+nENvPVcQ3SbKlSexK86aka7fKeO1stCgNe
	V057NPGNu3b/ayCQOtEaY9sI3KRRo/4XcTrgr4THCS3ehERknY8ZFwGemqpsTOaWQZre9oQ9Nog
	0bjm7LRMbzp/dsBF4nDR0uTOtvSTSa10nRvbbdUGHWsW+V8VPOiDQGCbyYORG6sTHTunugPzxFN
	e+aNzm2+NvywXJL2A5tLAs8IWarzFUelb4QI2ThYuu5hhgDBifqfTmh5E1tIlfQe7bfQwHkj5c3
	RREJS0QwSW6n7z/VAGPuKFSQTuL9wrYc2jz13QeaFHADDqr/g71NfT9YYPuQKmwjk6CgMpmxqt2
	54dbS1xpGuMsgV6siTT5av7NRxfKSEj/xo6wwIW2ASKS1XByqaeqf2i61a05Kq1EmFBk3MMGiaD
	S7h3xAMqQza9DBpMXqdUsM=
X-Received: by 2002:a05:6820:82b:b0:692:c2fa:17aa with SMTP id 006d021491bc7-69462e394eamr4281331eaf.16.1776529935203;
        Sat, 18 Apr 2026 09:32:15 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b1f8:aabe:74d7:21ba? ([2600:8803:e7e4:500:b1f8:aabe:74d7:21ba])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69465edde74sm2750450eaf.10.2026.04.18.09.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 09:32:14 -0700 (PDT)
Message-ID: <1c49e011-ae23-4c6f-ad6f-f0b494c2dbbc@baylibre.com>
Date: Sat, 18 Apr 2026 11:32:13 -0500
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] iio: HID: Add helper method
 hid_sensor_adjust_channel_bit_mask()
To: =?UTF-8?Q?Nat=C3=A1lia_Salvino_Andr=C3=A9?= <natalia.andre@ime.usp.br>,
 andy@kernel.org, bentiss@kernel.org, jic23@kernel.org, jikos@kernel.org,
 nuno.sa@analog.com, srinivas.pandruvada@linux.intel.com
Cc: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org
References: <20260417225959.16688-1-natalia.andre@ime.usp.br>
 <20260417225959.16688-2-natalia.andre@ime.usp.br>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260417225959.16688-2-natalia.andre@ime.usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/17/26 5:58 PM, Natália Salvino André wrote:
> Add helper method to deduplicate code in HID sensors.
> 
> Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
> Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
> Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
> ---
>  .../iio/common/hid-sensors/hid-sensor-attributes.c    | 11 +++++++++++
>  include/linux/hid-sensor-hub.h                        |  3 +++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index c115a72832b2..12728cfa5d44 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -589,6 +589,17 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
>  }
>  EXPORT_SYMBOL_NS(hid_sensor_parse_common_attributes, "IIO_HID");
>  
> +void hid_sensor_adjust_channel_bit_mask(struct iio_chan_spec *channels,
> +					int channel, int size)
> +{
> +	channels[channel].scan_type.sign = 's';

We recently renamed the `sign` field to `format`, so it would be nice
to use the new name in new code. (If it is already used in this file,
make a precursor patch to do the rename of existing ones first.)

> +	/* Real storage bits will change based on the report desc. */
> +	channels[channel].scan_type.realbits = size * 8;

There is a BITS_PER_BYTE macro that would make sense here.

> +	/* Maximum size of a sample to capture is u32 */
> +	channels[channel].scan_type.storagebits = sizeof(u32) * 8;

and here.

> +}
> +EXPORT_SYMBOL_NS(hid_sensor_adjust_channel_bit_mask, "IIO_HID");
> +
>  MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@intel.com>");
>  MODULE_DESCRIPTION("HID Sensor common attribute processing");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
> index e71056553108..6523d46c63e0 100644
> --- a/include/linux/hid-sensor-hub.h
> +++ b/include/linux/hid-sensor-hub.h
> @@ -281,4 +281,7 @@ bool hid_sensor_batch_mode_supported(struct hid_sensor_common *st);
>  int hid_sensor_set_report_latency(struct hid_sensor_common *st, int latency);
>  int hid_sensor_get_report_latency(struct hid_sensor_common *st);
>  
> +void hid_sensor_adjust_channel_bit_mask(struct iio_chan_spec *channels,
> +					int channel, int size);
> +
>  #endif

