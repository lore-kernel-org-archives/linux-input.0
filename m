Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795853904;
	b=xBHLeXzvLtiRy6iUrfOOHdNJ5Wct0m3w1chE6ZaBPQHE1kvYjRIn7ZKdus5jXmXDe4Po
	 tFiKTkHP/wyJ7ZHwge1bM1kKhBv1s4RgPQ21qjiNkRW2/941YG5re01RXZgMpV9Y5awwG
	 vAfMhultT6njDnx5lKN8Os3MhRf05W+k0Aj5I3ndJ3gElx+dPT6fYEbZtmgGm58Iudftg
	 jQVrd1V7WQY7BWNU4yo3mCNrl3zAAZhMv1Lj5jw6/DNYufBNZEKHadw0GtPDydLxz8FZG
	 GE9YEcr5YyfwWUp/ai59oScH4yeUjGgnsAc/fbYQq8SIkEIYYbt+FAXEchUh/DJMBhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795853904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UQHX/qYS5c5kksZ77LXg1WqJxlfjKfapCZLkAYXEJAI=;
	b=eVRrwQIc7b8L6uobuvkLHRCi8YxFNDFjiylpEFl3kSrjbELw/r8/vCiXzidpBOvsA9p5
	 xmKi7OPmIDEFzxBc/0WOGOmxKx2VvdRgoQsorG93uKaFq3n0euBRFo5WmH8kr8ws5cPRK
	 bDymzE2sI/SxkMPTQ7rV7XPw0+ehqvDT+ZHSnCZB+9buE54U9f2QNtYP1+BAan9h46oKL
	 hKAWcvvVUJAIznWAT5nPC5t9YCvIjt9X2MIg/56YrBqHhKttbMIAc0b7+noRBE2FkGwux
	 IXvz/8dVUaqwhLp/zuoSHcJY4ZlH2J9j+NSB8fXsTjAd4IQTFWMCOt8L+Jy3Wlru6nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pL3F2Q9W;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E13606A323
	for <linux-input@vger.kernel.org>; Sat, 28 Nov 2026 08:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81E13606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pL3F2Q9W
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2f04244c3d0so68753155ad.3
        for <linux-input@vger.kernel.org>; Sat, 28 Nov 2026 00:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795853904; x=1796458704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UQHX/qYS5c5kksZ77LXg1WqJxlfjKfapCZLkAYXEJAI=;
        b=pL3F2Q9WB7jP7gHpTdJVbvyZvP8l/9x6jogovbeNWcW056qwrI1F+QfS8G3+Pwn38z
         22yn8/JwUPDWE+c2us2ASxf5aaHue7JmHdRykR3EZU7CvZ03lDxRfwcP6nl0TFhuHu9g
         RaqRDceuHb/UmAZKZ2XwUb2cTzeixcYDg9G0txTsoXlBPuKKp2JWacoKM7tv7QwtgeCP
         x+C0RT8xRs9rDGJYr4ZxcOF9ETzO17nzZm5l8iNQzKlh8OykskKJaMJM2nUNKaNAzbDF
         ZzDtGi8WiTDFFO2lW6c2wrGsauFyQSDfel/2yTwVS9fMFip6Wxef9XnA/KH6eNQtSAwD
         QoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795853904; x=1796458704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UQHX/qYS5c5kksZ77LXg1WqJxlfjKfapCZLkAYXEJAI=;
        b=Xrny1YOCC74rHeni1KRIywDtQNVB/3tM3hzxoQB/fcApXLd7HH0KiHuFgn+Die6QLg
         bS0fem6jq9qXzdzoZv9SZU53+jQdH6Y9rlpKecycBV8gGiM2fT1snCXAsSvMhBBSDUaF
         cnFP3waUfK8wHObFg93zcJbCW3k5bbwhynZEObR/3Ua0matAorrJLMxB9R9O6chrbLNx
         gz1pK3EMX41O6lPrj/Gp6B+tHtCdaRmJw7tYVCJbTTROPgFh95BoK8rwDLuu7hdtLSZV
         0qe35YioqkVeWBa23Ob34JHRJ0NsPECb1jLZq4qXf9XQKvldV87bQtYwqdcaMlMi+VTm
         HSdw==
X-Forwarded-Encrypted: i=1; AL+hErGqAP5gmEF2otcD9EmYeIBrWfrsyEes1cJllagHCDUJ7VuK411GFK1zIrN4YRZXfOmEmd4ePqngUWBAtQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8tJ2DJ+xxoS2/MqyStEAhSlZ+gShDWxEa2r+MhvSOh1qFKsewD
	8EnRBJg1dzWljYPTIxz62zB9Cla/MYo61KGzGlhnrMTlwyXaWj5a6uvT
X-Gm-Gg: AZFdTZdTW6MULw1L/ObzJYKXK2pIWuePcQYYzUeGU8EU4qDWjDC4q4HenHLqcK6Op6x
	Z5iY0l9x2OTtA+mUZuNzUk5NpIAT3EzyyfG1hTgEgsU7SDgWDbJDfS03CibS4KIczvMS8vPpNmW
	r/t5h0shiyzsOLncX7zDVJxwdN2tDWRU6j4Oan0/UwH5Tst+oAuyd5EwQYviJclSxwxpGHKp2hR
	cE3kKbN3zenGxv/GQLBU8tQLKE6sSl2M2pM/ssb5wgrfIWs412uUOK1XOKCAPhAQ0sV3Gnj+Rqv
	s7AhFmk+FlASu7YZD7LgQ+2iUQmfFySGFMF8Ft7UXIm/jkeT5eWqseiTSfdFfQF+nOvCyOBZj6m
	howmd1AYi9FwZusJrMEjpezvQ1OBm56jYWqE40MFohouwOoGPBvb4bD42SKrwk0Uqav5PgOIqrf
	HXx4nZRbT6B42I4Z1spT3lEcvaos0tJZYR4f6UyfDwzgwoyhPvv8J09ncWIzCwlYUKLoWiKw31c
	Up+Ce/qWG74ylXvQXNWO7FIyhrp+UIbNYZx46wd/6z4WRm6itnIllCczhmTOVC1m+BSqsLYAVCG
	UMJmjmK0
X-Received: by 2002:a17:903:b4b:b0:2df:991b:4368 with SMTP id d9443c01a7336-2f03f1817ddmr297156055ad.53.1795853903817;
        Sat, 28 Nov 2026 00:18:23 -0800 (PST)
Received: from wyb-ms7e59 ([2001:df1:7880:4::50a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f14a432sm133882845ad.75.2026.11.28.00.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 00:18:23 -0800 (PST)
From: wyibo6109@gmail.com
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Yibo Wang <wyibo6109@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: input: add OnePlus pogo-pin keyboard
Date: Sat, 28 Nov 2026 02:18:18 -0600
Message-ID: <20261128081818.365987-1-wyibo6109@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017-literate-prudent-walrus-dc6dad@quoll>
References: 
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yibo Wang <wyibo6109@gmail.com>

Hi Krzysztof,

On 17/10/2026 20:01, Krzysztof Kozlowski wrote:
> LLM

Done, the prose now says LLM.

> We agreed to drop all these.

Dropped, together with the touchscreen.yaml reference; the driver does
not parse them from DT either, the geometry is pure per-project match
data now.

> P > N

Moved after ONENAND.

v7 sent as a new thread.

Best regards,
Yibo
