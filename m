Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6A7156661
	for <linux-input@vger.kernel.org>; Sun,  8 Mar 2026 00:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772930140; cv=none; b=sPBxapV8acoOCAS2I++jMRo+q9aaFPQHZNTZ2VLYQneiYIPbV2o3tcUsLHKDDkqijcP9f66v1MKndgI/8mtDVy4eGXc6xXIUDBZNOMKTVtB0w/zwjwV19v0MMkqCe5YmzPY5Y1KQ6R5Bc/Fa8YmG4pHyKcUYXBwNqBo/i4XNtAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772930140; c=relaxed/simple;
	bh=eq8rWAlrWpCDTV0rXsnwg2/EAD5jdK7r4BAEqsX9OBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmeaC5DcXd6g031LIICYvnqT0MLYItpppljVILSqLqfYc2cYW1djfXPMuV3g9ffGKqGulY//Cz+xBGUAXogWCfXp3ToE9y6YPKsOEDlGzQOELxHJ7rYP/X6AijY0xgu3MmjT1Eq+2DGf1qRihw3eY/niMTJnJZMsgSNKvnVBV8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LTDdJhts; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LTDdJhts"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-40ee9b945d5so3515114fac.0
        for <linux-input@vger.kernel.org>; Sat, 07 Mar 2026 16:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772930136; x=1773534936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ylT3Gkt3E+gdnboidI42Bw4R7RZBX2/1MTaq4t5bKEo=;
        b=LTDdJhtsqfUQTG5GZDTtWe0fJy5bbW3e2I7feKv38Vic7shWtbs5V6vlsM7JLQXXCu
         T1LAO9WUB/IMjQ86U3EviSUSpYGxYQ1ieOQPDzckZWFy7bgsjIboUXy8S2GDpXrx9bKv
         Th9QiYDI2XG0KGXR7Sn73VKB0KqbfSTUcfw5GQzCvGvVjDZAuzuLt83xIxLCAPKpSFtz
         96GU1P1e5ttrph81btQosCG9l9vV22DWCaHKsJPKb6vLh1N5JtmP1jSAtKF00RxM/5LW
         ygF8E7nd8nIhVsUosZPntKFDkoHjz8vXEXKVcwovZC3PHu/OPvVB3CriVbjkvogfvUny
         yjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772930136; x=1773534936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylT3Gkt3E+gdnboidI42Bw4R7RZBX2/1MTaq4t5bKEo=;
        b=uBhX6au18EmeXLRDso63a9wx9G6Dl+KfMf8dkl/7b196O2yQGYZKXHIHFbhydyW5/O
         fNHNZQBnomO6H+YSTHHq+niJEWMTsfLt89WsnzAcQHZnHGm9IluxQBx6dDDVOGUQKbDN
         +bBu5gJ1j0VcRcg979sFqfgUJW62fY4QndrZqLwb/V99V2kHgwSo6e0tdE9y9SnqWdmK
         zjnuR7NwYLRyngBC1BHmJboHnxifNS3YV2ZwHXXTRfU4IHO/WS+ZRMLLKMGptU3UNXQO
         970uzB28Ys4ZSt+uJS1d7QUHtTyOcsYldHaAT8vYFCU2facjh5gu7wtW0q8RJzP39VR2
         h1Tw==
X-Forwarded-Encrypted: i=1; AJvYcCX3ohSbMpQDakkgq1mmaU1CUXrsV/WfD58Cfbh4Cqi6B8oVEn+L5v90JSyShrckkJj8r2aQE8vwNDJRYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu/7l8HNDMJpu/nGohY9T/ALficd7loAyfPuIjmY9xpGDRmSua
	lolYKOErR4V2ivNSzdwC7y7rtvoRHy/wqfWoGmvPuTYqpNHe2uN5sfWn4hMutKakjVM=
X-Gm-Gg: ATEYQzzU+2ofPyZiNpQJZfWsRZFO/PFLGRxISBy2VGHvSO4Ouq/5XExnI9XdNez9MYh
	8+W8Kahgb83pq68tRgQOb394iKshG+ZYdGbWdnSdshwRT9HJ2NRX+Skp1UPvV5vIDG5+VVSDX+m
	wtI12Gy8gWr/sxcyD5J76KRz2GgfcsJEOPbeqIcKHmqZBqF4wZlp1WrVygP7cny4xQ9DBo2xJ2I
	eQlhxNatThls6BZlqL2Yn7bfc7QAkbquqrQHLZN5A1Yv6Y8h/Jllgam0CMF43hTx9sjAZlwl+ZG
	wNRKWJRPwPA2U5TRRwbAIbW3CLoxHAvgUZKMY/pkAcVRcfgzAtVxX8UQRkaUGQLMLDcPpUMABuW
	LHP62W/pt5vXpuJ1UsdpN9vpuuRPZNfb+bqxZhAdE2ZI1Cza5VUE8aHAFi0oJCf/x1/yBRGYOmc
	/p+RroHiPIt9HWNQQDJWeU131fviKVoJ2O6EZzM+pkxJj1rQWrdwxGjQbMMJPIyOR8Zf2gfT8if
	Q==
X-Received: by 2002:a05:6870:d10b:b0:409:b130:787c with SMTP id 586e51a60fabf-416e4416afcmr4139493fac.42.1772930136541;
        Sat, 07 Mar 2026 16:35:36 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:cccf:5174:fa72:c520? ([2600:8803:e7e4:500:cccf:5174:fa72:c520])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e67d9c3csm5039017fac.11.2026.03.07.16.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 16:35:34 -0800 (PST)
Message-ID: <7f000ea5-1a41-4da8-aad5-04aa875fa4bc@baylibre.com>
Date: Sat, 7 Mar 2026 18:35:32 -0600
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iio: add IIO_DECLARE_QUATERNION() macro
To: Francesco Lavra <flavra@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-input@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jiri Kosina <jikos@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <20260228-iio-fix-repeat-alignment-v2-0-d58bfaa2920d@baylibre.com>
 <20260228-iio-fix-repeat-alignment-v2-1-d58bfaa2920d@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260228-iio-fix-repeat-alignment-v2-1-d58bfaa2920d@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/26 2:02 PM, David Lechner wrote:
> Add a new IIO_DECLARE_QUATERNION() macro that is used to declare the
> field in an IIO buffer struct that contains a quaternion vector.
> 
> Quaternions are currently the only IIO data type that uses the .repeat
> feature of struct iio_scan_type. This has an implicit rule that the
> element in the buffer must be aligned to the entire size of the repeated
> element. This macro will make that requirement explicit. Since this is
> the only user, we just call the macro IIO_DECLARE_QUATERNION() instead
> of something more generic.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  include/linux/iio/iio.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index a9ecff191bd9..2c91b7659ce9 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -931,6 +931,18 @@ static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
>  #define IIO_DECLARE_DMA_BUFFER_WITH_TS(type, name, count) \
>  	__IIO_DECLARE_BUFFER_WITH_TS(type, name, count) __aligned(IIO_DMA_MINALIGN)
>  
> +/**
> + * IIO_DECLARE_QUATERNION() - Declare a quaternion element
> + * @type: element type of the individual vectors
> + * @name: identifier name
> + *
> + * Quaternions are a vector composed of 4 elements (W, X, Y, Z). Use this macro
> + * to declare a quaternion element in a struct to ensure proper alignment in
> + * an IIO buffer.
> + */
> +#define IIO_DECLARE_QUATERNION(type, name) \
> +	type name[4] __aligned(sizeof(type) * 4)
> +
>  struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv);
>  
>  /* The information at the returned address is guaranteed to be cacheline aligned */
> 

Hi Francesco,

I should have cc'ed you on this one. We'll want to add another macro
like this for IIO_DECLARE_QUATERNION_AXIS(), I imagine. (This has been
applied to the fixes-togreg branch since it is a dependency to a fix.)

What to do on that for the alignment though is an open question since
we've never had a repeat of 3 before. The question is if it is OK to
have an alignment that isn't a power of two bytes. For your case, since
the data is 3 x 16-bit, it would be 3 * 2 = 6 bytes.

