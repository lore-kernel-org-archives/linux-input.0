Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C363909B6
	for <linux-input@vger.kernel.org>; Mon,  2 Mar 2026 21:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772488717; cv=none; b=uVGciXxKwxQGODFlnJMK9cLik2DPsSnZJdlmDyJ+jGjkFGvIyyxmoUivOwfcJmO8hQpIfPCn23rouhuvGJVQGDSIdm+/MllIc2XMxTofoQR0Dms3PCm5ALwriSlNnVLxseUDGbgyMpRROR55h61WVmY1o56ZSWInXOzdAYweWoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772488717; c=relaxed/simple;
	bh=rvfKRU8+uxw7VisuS9wr5rbgSLl4dCIT5XHtKw45lTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R9U1vlZXnEFeVUTIWNsbD7WJkm5h3YV4OUM35cIk4AgdR38oU4hGI6uLKRqI8zqFK0U94iYfiRNnrW6/RQdfcpmcqQqvjb12LWJGpes1j2rsnLShCO2hu5APinKVFx1pIfXC9NcaI86RdeKBOjUEUJM7HU5oQV+8iUG4nQP5CQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rhBIsjog; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rhBIsjog"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-662f30d3f1fso4358723eaf.1
        for <linux-input@vger.kernel.org>; Mon, 02 Mar 2026 13:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772488714; x=1773093514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G9sbIv3I3n8wehShB40Wi+NVXgBioPeKZUV6cU+oYrI=;
        b=rhBIsjog9NE2c9DLlRKh+095h/1qeKFyYGsnG+njeXmC7OAxiYJCJsR3wUH3vDpbhF
         NpgI2X6i2BDp2AfYbHMt3gVHGfM+/aZXCET9sV353nEd29NmVaixRYkEVXG3CNxWONBk
         7eQ6VYfAhlyQSiq99Qwy3wGJMRZraMJn7PT3VKAi7UxPoXrovst4HZ3ByHpbVopsGzIF
         veLcOuQWq+UMZKIh6u5N3qwxS7sId9zEJtBZrXIk4cjl/g9Vp5iQ/7emQ/FpdNmnTy91
         03SP4OmkfgPa3MKOtmXqIa0W0C4tDVdALznchjlA3BOERofbpldxlJaLx/JuEY0Q/+AT
         wlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772488714; x=1773093514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G9sbIv3I3n8wehShB40Wi+NVXgBioPeKZUV6cU+oYrI=;
        b=M2gMEVrr22aD//Wk0rhqEf9X8iQR+BVSIXrdMKNn+oqDzhMp1jRFT3elho4lbJOgww
         3F5gOJa6upa7zIjMg16GI7W357TcY8smVb6M/yJqhG159Cah/BZ3+T1UwE/Yh9rarqKk
         2n3Td+16HNQ8/yUwWP3k5eElym4uZOIHhUGWZhaYfrO7KokB8LiIvoDX051nYyJm5Mdg
         I9MHpMbcyeCRJi/6rJRq8y3qoMXHrYyoEG1mQgpIcYskoZreZm0yOnpUorP+DG6Eme7s
         InEWCuQJ6o2tFLwDZkFzVPDP54wtbBCyrL2nUwlFrxX2+Tz4yaljd5qcKcttIu+k5ogJ
         5lww==
X-Forwarded-Encrypted: i=1; AJvYcCUtjTaba9ehIj1LfDdbaW8jdh4OTeXhCbVqPeEXrBIUBW67FiSMSDuZoJGorSpH5g/YeADJaQtOX6sHXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv9s3cklpHDXRnnLnY04ibtpApLrC051n/dqq6638mrLpuOcJp
	B0TAjfRODVZVE9BYrDxn7igMngbFG4AX9QcCam2+txnAfm73/taaUpCmMg52fah/MvE=
X-Gm-Gg: ATEYQzzw0FNRNjC0KbJIUL5RSezBxz5dKAEWtuZLiCICfJFVHT8bL2D0znhGyRiqcyY
	HjM00GHQJLnVQuZFPIGzilHYqyux8bSUXU5+b79yG9bixPiO5MNQy54o8kaYMsHFaCH6+fvcOFR
	msZ8FtnTff2L3sDo0VA6TfCfG89UDI3Q+LgC4xs8JwaAd5/vHMHvWlDMX5uHd7qqHbKYslmar+n
	Rhsjtm+U9E5W4dl/dpcMcrbpO0S+q4n+A2l0H+Rxyf490KyjDE8ROXpaSsD5+xNbxmpvaK4FXZx
	4xF8dHr4Jy9O2xa0F5DOk1CHZeihZZ+SWbiia7SN5hKXKX9sxvAN7KBx1I+c5MV8z9mXT1Dz/Sj
	Y57uMtczUm4DVw3b8toA7OSab/K1mNQQLS6gGc6oiulp2DOGhfqpdBVVbWkOZMG5X92UcGjTguv
	AJOcRtbTRbCrh1D58oKMfKqv8qmFMWWMA8stYLL/mQvDFA9Fqht+90hyZTigbcX4+KgWYRs7/kf
	g==
X-Received: by 2002:a05:6820:200b:b0:677:3b8f:43a4 with SMTP id 006d021491bc7-679fb605b61mr6988343eaf.36.1772488714488;
        Mon, 02 Mar 2026 13:58:34 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7? ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d9e8d6sm9514599eaf.13.2026.03.02.13.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 13:58:34 -0800 (PST)
Message-ID: <d2c593c8-a335-44f4-a14b-0413dedaf31b@baylibre.com>
Date: Mon, 2 Mar 2026 15:58:33 -0600
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] iio: buffer: cache largest scan element size
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
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
 <20260301-iio-fix-timestamp-alignment-v1-3-1a54980bfb90@baylibre.com>
 <20260302204755.462d6b63@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260302204755.462d6b63@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/26 2:47 PM, Jonathan Cameron wrote:
> On Sun, 01 Mar 2026 14:24:52 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> Cache the largest scan element size of elements enabled in a scan
>> buffer. This will be used later to ensure proper alignment of the
>> timestamp element in the scan buffer.
> Why can't we just stash the start of the timestamp?

This is exactly what Nuno suggested. ;-)

