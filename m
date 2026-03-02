Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4F5407566
	for <linux-input@vger.kernel.org>; Mon,  2 Mar 2026 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464741; cv=none; b=su528seLDJg1gyhaC1SiuV+BbBGSKOvEg0Osyh/n1rmcm1s8p6F/USdfo8YKcvjBf+SdRsiePVJfaVe20gtDzsS4cbt15gAQptItG29g8rek/p3VXh3CABBAHL62sxTM6eGeKtzMYhpWMd6aJ7iKjYVuWj+uDT70y9KJw7mQ31k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464741; c=relaxed/simple;
	bh=4DnvNXGvvtNNdmmyM4AMeHaM1InJU6nPwqe5ojDIsTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TM6gYxOiWuRNWk3wlJ3DNlkwN3cPw99yKVaJIU2JCY+7Tz96EKMrWtlY6+8gwgdKVLLopfbuQqQmRlpNV7cdfpN8BuWSp+umljYprs8cAAgU1BB2jPyiLSPQGu/8i7ww7jSuDKz/BZ2N2WJNkWs5kPV33cwCY0B7aVoBntpTJUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=t4Gq4CN+; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t4Gq4CN+"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d4c1d2123dso5716457a34.2
        for <linux-input@vger.kernel.org>; Mon, 02 Mar 2026 07:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772464738; x=1773069538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ZJnsgIALSYKEYqBOZPypi+I02KS1mMRPI+ojqPd+Cg=;
        b=t4Gq4CN+sFzwknZkYFPwQ1svPHbl9g40N50ey43bBBTGcf7DGm6qO9JaY3Hx+AmFm5
         d1xlR6/UUngpYReYMaRdyXTf0zBful1UlQ0lVRuM9KRmZ2mepxezadNKPGpg7Elxczhz
         4cY1vE/7DGw84j/6f9Ap6/llPWQ3U14XL0x53Pmq9UKeFw4iziMGrXDIusoQJXoa+AWN
         c3bq59OVXcqwWQL1pGuI7XbLH50dU5K9qIsl5iaPlk+9pvyVdqOszeaf9LICHEPutg00
         LbpXZ35iFdYS7JD5KNhwDLTjmBJGqubv2MPOYYySaiv0Q91uAq8XrtBJMeba3pgLjOue
         CYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772464738; x=1773069538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ZJnsgIALSYKEYqBOZPypi+I02KS1mMRPI+ojqPd+Cg=;
        b=s6o8Dol4Yee05/m8l0hrnq29W2XTwAtXS+UQUwc6XWJlNnFZFJxVFt8fomg6c40bkQ
         Ww0RnhJ834TkhQfyBDTk1ntucOCCgyXNbLL8DA3G0BlyzUu2utlS1hQ4TC5tesDtbU0X
         ESRLq6qUlawzfpjK9DDY81ylSpvfrosV+9SCZVAmPxRffv9EJ8AUwgm6EuI3ohcqi/U/
         USRX9erMvqB5T2meJa516I/RuE9F/Ap7R1jyZUgA1+UBjrgbvEHPUdm3X06P3QTl9774
         0khRrjPbUxSO4AaIxArWnrBnAeS8utFzZ9whUi2Lp1p24vZ75sRQxnyh75m057XRrDFO
         fMqA==
X-Forwarded-Encrypted: i=1; AJvYcCWlAaqVaW0HlfhifxhUykh0w5JSnHmhmZlrDjYOdjeocjWApIuX6eHCITeTuFsH/81lEQ6rC93arnvF6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpJR+WykLFcs1Eo0BeNWkU3dFQsjuvaR1OhsxbrdfxaSAeAsuu
	s8KEG4Ioz4Z5zXT4A47QlkB1dtxjysaVI/w2Td7Vq8fpH0Ysq4teVwoNiChZQWVTjpo=
X-Gm-Gg: ATEYQzwMW2iaUrTXXl1ZleXIVuFbwNox5BqYDADnmEMJMnEdND30VXxYK3WYzv4yAIW
	6q/fXJ4GRcS+DOOtvo9NaAGL0Q/VWb3Op49G2R8NwyJ4r5M2dC9EL2bXtZZFeK377WskaIa5OM8
	ZJ1Yy35fN5lMpRnOxf0SRarfHB5DKHeBeOD4Rkg95kzUB+cI2aX2pswPnaofcNwM1UDP3kwjdp5
	HZdXJvNe/xxUMBUPEhes3qUF3zqgOjF6oyqci/Y1dZpyem+g1F6h27T8vo8fQZC1Wujjm/MZaTd
	Umu8stAtpzA6EKrSFK64egWHjfrx0zW5Yalf5DoihuwdApqxZJFmCDVg45BbyxmpFwdirVfH7wR
	fzlZ6G3Iw7uShu9QpMHxVgwKwOt/tXPab6w2NpNyldk9BhGMgB5EO326CbuNMH2FAsLAy4HwqMY
	dqQ5JszUOgd9dX6r/Ct6oR/3/VP/OxyW26Ki8qVoNHAnL4pR31DLF4tXLUjqHWYyyeaSC8xwSJA
	Q==
X-Received: by 2002:a05:6870:6592:b0:3e8:970e:d4f7 with SMTP id 586e51a60fabf-41626d64dd3mr6976780fac.11.1772464738185;
        Mon, 02 Mar 2026 07:18:58 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7? ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d26d20asm11334813fac.15.2026.03.02.07.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 07:18:57 -0800 (PST)
Message-ID: <8f9dc90d-9dba-4ed4-8cca-41012027aa10@baylibre.com>
Date: Mon, 2 Mar 2026 09:18:56 -0600
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] iio: orientation: hid-sensor-rotation: add timestamp
 hack to not break userspace
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Lars_M=C3=B6llendorf?= <lars.moellendorf@plating.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Lixu Zhang <lixu.zhang@intel.com>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260301-iio-fix-timestamp-alignment-v1-0-1a54980bfb90@baylibre.com>
 <20260301-iio-fix-timestamp-alignment-v1-1-1a54980bfb90@baylibre.com>
 <aaVPQsvz02S8GtsX@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aaVPQsvz02S8GtsX@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/26 2:50 AM, Andy Shevchenko wrote:
> On Sun, Mar 01, 2026 at 02:24:50PM -0600, David Lechner wrote:
>> Add a hack to push two timestamps in the hid-sensor-rotation scan data
>> to avoid breaking userspace applications that depend on the timestamp
>> being at the incorrect location in the scan data due to unintentional
>> misalignment in older kernels.
>>
>> When this driver was written, the timestamp was in the correct location
>> because of the way iio_compute_scan_bytes() was implemented at the time.
>> (Samples were 24 bytes each.) Then commit 883f61653069 ("iio: buffer:
>> align the size of scan bytes to size of the largest element") changed
>> the computed scan_bytes to be a different size (32 bytes), which caused
>> iio_push_to_buffers_with_timestamp() to place the timestamp at an
>> incorrect offset.
>>
>> There have been long periods of time (6 years each) where the timestamp
>> was in either location, so to not break either case, we open-code the
>> timestamps to be pushed to both locations in the scan data.
> 
> ...
> 
>> +		/*
>> +		 * HACK: There are two copies of the same timestamp in case of
> 
> Usually we use FIXME in such cases. HACK is something which goes with
> "do not apply".
> 
> Does it mean it will stay forever?

Yes, it will have to stay forever because we can't break userspace.

My intention here was for HACK to mean "do not copy to another driver".


If we think that no one is depending on timestamps being in the wrong
offset, we could omit this change and apply only the rest of the series.
And then only apply this patch if anyone complains. I am just trying to
play it safe here and not risk breaking things.
