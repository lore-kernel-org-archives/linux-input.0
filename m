Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75CE36606C
	for <linux-input@vger.kernel.org>; Wed,  4 Mar 2026 18:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648733; cv=none; b=IHJTvjN63UBczdVDSLp1moXfGfrTRGqPH/5B+cre6pyFMwX/Pa3h3ce0EsvXlpSDNDhPFV9sDXh0YkYZaESiC+FeuxbPwvlUNYvHHwTIeSTidFoPNFLnJPODpX4yNcWHjEYIgSfTTHgSwVVwdzp6asIhpfb4Emz59INxI7f3OqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648733; c=relaxed/simple;
	bh=NPqBeiKnoQNdKkDIOfiBxTXQITaXsqB1SliaeYafsRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QypccAiEN/heghQvh+Y/cTME0g1ec4qduk2ZLYbCF9oWSJ2IOXDYSVBLfzkU/IrVTsBiWDDo9k3m/lqT2KUpxl3fQ51S3BaEdjznN5xXrB2O8D63177Ts7oXSmyWP2bCZ33HNptWdLZR75UmmiGqTnvYGoJhxrIBGX8dlKtDVw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=60228.dev; spf=pass smtp.mailfrom=60228.dev; dkim=pass (2048-bit key) header.d=60228.dev header.i=@60228.dev header.b=GAARg1kr; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=60228.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=60228.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=60228.dev header.i=@60228.dev header.b="GAARg1kr"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64c9c8f8783so7545443d50.1
        for <linux-input@vger.kernel.org>; Wed, 04 Mar 2026 10:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=60228.dev; s=google; t=1772648731; x=1773253531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gcMEnbL2iZRqIcSyrGL6+W1oNYGP8pNhj8CwblCdVG4=;
        b=GAARg1krJjVHGIBHWwM8+ps8I46DIfB4zuWUx76yGYY2/dhAImCkiTUeUvxxqIgMDH
         FKTYyrXg6dUHvUvIe1HntddX6LE9dFwvgELZY2ceDfGEp/MXZE8g9thHDWXeMUhoCzgH
         1faLA3zMC1IR6etJlz0uJl1TzWQUqrqSKb0zlgzqMOzP0mY6gYHNQ5O6+tp1IxeTf8rJ
         DF0lC0jfd0MGmQtuFFnvqskoRbg73ZVzW72y88KonU+NvekB+7qi/5Ayittp//vVk2Ap
         QOASuRD5rnDM2cNu3Jgr8FRjIsYLtDAKEhnv8asdp4drK6pSjVn6LQaqgk5Zh+lokPHR
         NA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648731; x=1773253531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gcMEnbL2iZRqIcSyrGL6+W1oNYGP8pNhj8CwblCdVG4=;
        b=qBPjxp1bDqOf+C9IAzCRvopElLzyk+76oU7/xiA1i8ZcvDAoYY/H4gPx45krl8FVoG
         fucGU5Nsg1Bgv7MXizm/ep3mDfsSTXHm8fcv9lCq0j4to+uHrSV7VU/dOObC2IXTTHqq
         6lrEtZKi+BoPRoWXJVoxgmAIdhA37aYRSKLfCQnRPx0X+lZp2VHzNJxbYCAiAvJk7Q4r
         Xkwq7vjBPuanv7TaOyrztc3l6/YGqsKSIVZsKyKVAi/KVZtpJ6NOyaEYjizRlILWS7dM
         Q8CXaTwTeywpuXsvIuz4M8iBAz7uIJcIB9pnQhKk9nKWvMCDIBESi5sJ1/x7d72wA7NZ
         O1NA==
X-Gm-Message-State: AOJu0YyepRpE2BCGExYSJkng/NLQrpTGrJAVRdf0LDFGL9uoboRgCrV8
	oJyjVfK3tn0k+sAo7t97aeKqttOJvvmbSfGdLz75f4eU6WVBIR/ykZlND1DjX9d9BNo=
X-Gm-Gg: ATEYQzwobKLNhW16c4YM2I6AHTnYugdowmfrWnZAp0/FcodKa3pWxjGP0e+dQdV+UAV
	y3NY+0dIDaEpTHBov1WMN4vF2ISZdY75Ilz9DUqb0tXeovjCXbjZRnDMprf3bG/C0uwATiwhCxp
	ZT88hw7p+htnRzrzWZWQ3McFeOmfTonB9o55I6cl5cj+vipjWNXsfAhyoib5hc2IkSbVRXBjfWa
	wqy/5rKphhN+xjEqNNORslI3GJfssfKOjnSNyS+JVnswBtt9kSUx6aT9Vv04zHQNNK6KUfb4T3i
	BUGQqu0UPQYpHFXEcGB8NhsVXI6T0EKVZdGdvZeMflsNwSAQ90mWjUpw7g7viA64mJDWlhuMIOM
	hQApL3EpsqbIMqh2DWTNN4lT7O39J2wdamowbwarSDn2+D9p+qRyvtgmKfj4bjGoUHvJqLxBR1J
	GSW4rpCuVBtH+Il7mEHCen532vqRZ9LiDfawc0PpFOoSmvE7FoL6tk91LTkmdpZTkb/w==
X-Received: by 2002:a05:690e:4188:b0:64c:9bf0:3055 with SMTP id 956f58d0204a3-64cfaabb185mr1935952d50.6.1772648730768;
        Wed, 04 Mar 2026 10:25:30 -0800 (PST)
Received: from ?IPV6:2600:1700:2760:3c1f:8653:d57b:8d78:ca9d? ([2600:1700:2760:3c1f:8653:d57b:8d78:ca9d])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64cb7626e49sm7978563d50.11.2026.03.04.10.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 10:25:30 -0800 (PST)
Message-ID: <d0f8b1ff-0cfc-4285-823b-ded17eff65d3@60228.dev>
Date: Wed, 4 Mar 2026 13:25:29 -0500
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] HID: quirks: add quirk to always keep device open
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20260304033245.445671-1-leo@60228.dev> <aafeCVaf6ebaxqAQ@beelink>
Content-Language: en-US
From: leo vriska <leo@60228.dev>
In-Reply-To: <aafeCVaf6ebaxqAQ@beelink>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

> It seems 2/2 is dealing with a USB device. So why not simply make use of
> HID_QUIRK_ALWAYS_POLL?

It seems like I misunderstood what HID_QUIRK_ALWAYS_POLL did when I was 
reading the code before writing this patch. Sorry about that! It does 
seem like a cleaner solution to this problem, and I'll send an updated 
patch that just enables it for this device.

Thanks,
leo vriska
