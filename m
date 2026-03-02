Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6623340B6EA
	for <linux-input@vger.kernel.org>; Mon,  2 Mar 2026 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465758; cv=none; b=SB6feth6OMiNKma3xXaois5j36wXZMW23O3b6l0J5LGOgwfjabaaQqvvbDlTvlbSRZ4PEeUW0eJg8Mf1t2Qm+3cqcG5dNCQDS8fkV+LhrB564yAZOyZ6BTYOQ6mGklcEiwqOJW9lR9DX9iPu5AxKTQldfl3Jh6/f7eVRWOGPjeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465758; c=relaxed/simple;
	bh=UaauDFtK5P4JvzGbaX1rrVsS1YEq/WfUDxfW30a6juo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CfrUTPJXFbJNviTr6TVXGgEl2UMywGjFo6MVHvBSm0eUoX6gDUmIFITHG68CGsJo10azo9+3Nt7SMR4VdWX1Y14i42Ceo/CC+/k2W/W4IKlkGD4ZRT2XK7Jyr65MCdA2lf0JIw8Da82lXbBlU6I/weZ9fbHBkuCKE+QwHF6MQXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WC7H42we; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WC7H42we"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d4c3896e32so2564351a34.0
        for <linux-input@vger.kernel.org>; Mon, 02 Mar 2026 07:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772465755; x=1773070555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XPQt556Xjczv++WUGjnYnwojequ0VlrAPFuy5mSrsF0=;
        b=WC7H42we9zRUs8gbeajrlL7VBLHofc0vvu/LQw1sB0Hf9JuApCJUrci1xoQz3qt5vt
         +XxjKR8wkrvDWtz4gNnjwaTvfLNGC+OYDrIp7PYYKVcyv+mSGWs6hV6okcIjbV6l3+i+
         ISci7rugBikrdO9/Fvw/ZC4filbynNdl6qSkUrQZ5h8N188ZI6kNFD2CYyv1JuAkuTpR
         K2KjMv7RUiUuokwZi0KxS3E4dVBOvXMCsBq/2BDm6iDk80HtCBmss1hmomKtCulNolR1
         XwGweWxiicAiQ6vrZFgq7pQt1/bBfrZFaNzVEhDGVu1XEF0OpUQ6/8qesjkdGKz1KeNx
         F1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772465755; x=1773070555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XPQt556Xjczv++WUGjnYnwojequ0VlrAPFuy5mSrsF0=;
        b=S9S3+ffTeo0CgzlLEC7k1plpAAEkocBhIIIl4zzBAXvbUwFZptrDHeZb/6djQ1YCcS
         uOcn4g+yRJ3n3BA2FdpdIy25Y0VC1ZHg0y8VugpnEhRnNYW9RxtpBadQOrsT/FQcfTYc
         v5VHxg59Yuf0fat2GjZGxvO/Fkmyk6/zRs8r6c0bhmiphObdfkqCrqenhCV7+LpvfWh4
         SeHr2Wy+b1lsCN4hi9kpQJhqzbrVXQvGKQjgTOkt40jxo/crcBI+nEmNiuEnpdWt2vGF
         t37YByN5miAj3j/oQGxZoX7PIdnmAGWcH8OZ9VXCDywKVbrfn3JXc2mwF9OtWFzX93Q3
         Vfdw==
X-Forwarded-Encrypted: i=1; AJvYcCXrVCAglGpZH0p9Q02uAWSIW28VneCRi4/7K/Q8ixPtcxV2epj2O3JkiBH3z8xYH+OFAeCq3qTz0basMA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3YNuydPDvK+ABOtVfqdMQeB5EIrj9cSo5qM0QkxaAh08Xb8B3
	dYPGMnT7ggUepjmscRmv1Dh3pVhNJsMBZZ2Xk9cVkyMaPNeVH6WD4jSQkWwlVbGxpaw=
X-Gm-Gg: ATEYQzz4Yr90+/oend7nq9TzH1wyyZnrVu8SGiv8o87zjtap/9cLEjeApP3kHGCsAGH
	d+BXX6P4kNWojJip1QhXpSapG5NCoQ2vegAUz6n1jy/zTnxrYfXd0LVJeYYEK6J5ATVVosrEFER
	ECajIZNq5amUUHlUa7R9HF45aqLT/SoSKHOhaYmx5CQEl58nmTs8sUsiJ4YpDnT8EuBlmWiQXS7
	MO66q7j1xHMvlETk4WlOi3kMfrMUE/FZM60b5MPB95OkwwdLihF1kIVlAcPY/g0UsuiSWUPrt7F
	/nLEWLzgNuNXNhpv/et4Ndapi/M72ZqslsodxmaErT7RLff/zpY0H8rd8kS12w1Kv+3xkkxDcOT
	bOIw7qR4GM/Nyr/URIHTNxehTGnwOzNcbLcA1igGjmWLKs42Ydhkw2wVJkDXYIGwtjpMKsWAjXH
	NEgIAlqN1v8p3EB2zF19nJuyv6opSzQvKx90TS6mQetiRazkiaV5twL+pGV6pt0MIaPT4yDwWH2
	g==
X-Received: by 2002:a05:6871:4510:b0:404:15b0:4602 with SMTP id 586e51a60fabf-41626dd7299mr5869294fac.7.1772465755300;
        Mon, 02 Mar 2026 07:35:55 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7? ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d21196csm11935977fac.12.2026.03.02.07.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 07:35:54 -0800 (PST)
Message-ID: <d9b14aaa-5c03-4769-b7e5-0a6b3dcbe1f6@baylibre.com>
Date: Mon, 2 Mar 2026 09:35:53 -0600
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] iio: buffer: cache largest scan element size
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Lars_M=C3=B6llendorf?= <lars.moellendorf@plating.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Lixu Zhang <lixu.zhang@intel.com>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260301-iio-fix-timestamp-alignment-v1-0-1a54980bfb90@baylibre.com>
 <20260301-iio-fix-timestamp-alignment-v1-3-1a54980bfb90@baylibre.com>
 <091936ced74a1eb051dfda009e27bdb8f32426b2.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <091936ced74a1eb051dfda009e27bdb8f32426b2.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/2/26 6:16 AM, Nuno Sá wrote:
> On Sun, 2026-03-01 at 14:24 -0600, David Lechner wrote:
>> Cache the largest scan element size of elements enabled in a scan
>> buffer. This will be used later to ensure proper alignment of the
>> timestamp element in the scan buffer.
>>
>> The new field could not be placed in struct iio_dev_opaque because we
>> will need to access it in a static inline function later, so we make it
>> __private instead. It is only intended to be used by core IIO code.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  drivers/iio/industrialio-buffer.c | 14 +++++++++++---
>>  include/linux/iio/iio.h           |  3 +++
>>  2 files changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
>> index 71dfc81cb9e5..83e9392f949f 100644
>> --- a/drivers/iio/industrialio-buffer.c
>> +++ b/drivers/iio/industrialio-buffer.c
>> @@ -765,7 +765,8 @@ static int iio_storage_bytes_for_timestamp(struct iio_dev *indio_dev)
>>  
>>  static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
>>  				  const unsigned long *mask, bool timestamp,
>> -				  unsigned int *scan_bytes)
>> +				  unsigned int *scan_bytes,
>> +				  unsigned int *largest_element_size)
>>  {
>>  	unsigned int bytes = 0;
>>  	int length, i, largest = 0;
>> @@ -793,6 +794,9 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
>>  
>>  	*scan_bytes = ALIGN(bytes, largest);
>>  
>> +	if (largest_element_size)
>> +		*largest_element_size = largest;
> 
> I might be missing something but it seems we now have two paths:
> 
> 1. Go with 32 bytes
> 2. Go with 24 bytes (natural alignment)

Hmm... You are right, but we are safe for now because the only repeat is
a quaternion, which has repeat of 4, so we don't have a case with e.g.
24 bytes right now.

I can do a follow-up to future-proof iio_storage_bytes_for_si() to
handle repeat = 3 (or any other less likely value).

Without the repeat, the size is based on .storagebits, and .storagebits /
BITS_PER_BYTE is always a power of 2, so no problem there.

> 
> ABI was not clear so I'm not sure if we do want to enforce/treat repeated values as one single
> element

It has always been this way and we had some recent breakage because I didn't
know about this. This patch series is a direct result of that [1] because we
identified more bugs when analyzing it.

[1]: https://lore.kernel.org/linux-iio/bug-221077-217253@https.bugzilla.kernel.org%2F/

> If so, nothing to change. But if not, we could re-think the approach and save some bytes. 

It's too late and breaks usespace as we have seen.

> Marginal savings though so If having the smaller buffer is not straight enough I would be ok with
> the simplicity tradeoff.
> 
> - Nuno Sá
> 
