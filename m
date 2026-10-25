Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792932432;
	b=XClNLFyQk8IjVYbOhrDh1y2fFPY+Dm4FoQdXwbuvnfE6FCgW8JRzcYRBXtT0Oqg/GVC7
	 ui/7ySBzgMIyxdPIUdjPatp35NZkNWh4faBRLg14x2WQvVgAGkGL4+2KdAIrBc0UHr+Ti
	 uz0CQhFDc6lS3W9oq1wD6qCf2sPe+HvNQnHnuiYDQKRfQwt6faSRpU91+O+BB3YrYY9L+
	 WEPXdRn3hFhctPghX6BIRkW4c2UccY4EdusLZoPwakZ5gMK6ZnyyzOg4/OYAEidi/6TUC
	 3U/JzHBnAkpUTA9y4d1f+g4zvvR02dR7j45Yz0zGiiUXoy5FscAuMUVoW5LF7ZqAQ3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792932432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=pEQsCWXlGXgVQPk1/fnR4W9Zji/K3/rB8B3LyEk76vk=;
	b=1hUZTQD4XfALjOoXA8AJsUVSzgLuWCr01eI9w7XnT+IoHYTi2TbAsQfIp4KNnhw0+/d0
	 ugSYzD5Q1zbqaBRO4383VRawNu0/a/ZBpaCyOn9IhscoICfORc14qAC5nHyxwC6hU6PeQ
	 zmWkCYlreu3mspcVkYnOyVIEifntM3k3KZurkoNMvr+rQIUzZzWnquMc/qSDCuxNEDcpN
	 cWR/yTSNG8dtSv6bilXwvvDZdPgQIiVX57kBebQFknxEwhFoidawClldUu2ZqlRHYK56b
	 maCijl0sKMAANzC4G0YCVDwMdrt6CmANtil5UgDNgdpTbIkYpGkCSOcB3KbzsZB7HNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PVkWZEAH;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3AD606A31A
	for <linux-input@vger.kernel.org>; Sun, 25 Oct 2026 12:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC3AD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PVkWZEAH
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c315869241fso260241866b.0
        for <linux-input@vger.kernel.org>; Sun, 25 Oct 2026 05:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792932430; x=1793537230; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pEQsCWXlGXgVQPk1/fnR4W9Zji/K3/rB8B3LyEk76vk=;
        b=PVkWZEAHc9u7Gm09iIJpHStTuqmRHnPvij+BzKErUJHYipVpXCcBcKTwy4ns9R0F1/
         U6J/nAZlosXAxcWvpwkfA5Pj5yNFjch1zhuPQyJZnFTGG+T6VRZmTe/d7tOEpN6JowMd
         eBqDZFjnejr9MlUAzYF4uORewBIGJtmUusw9aUPBV2XIVQMJtbHDK0OMYqHjbnyltD0w
         sI4gBuOcuUBNauw1Zjib9ayFrBhJRVsiGnbZB3S2Yky1fgEBlcRssGUwQ+YTaJpVSM8J
         HBwkGkYP4G06cxrnp2EAA61MaKDrWRFy7QaVacIOInWnap5Z2jIt2GC90aPZZvMXb9jr
         HYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792932430; x=1793537230;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pEQsCWXlGXgVQPk1/fnR4W9Zji/K3/rB8B3LyEk76vk=;
        b=GPYNg6pFugKqIVcHnPsC69fGU0IDapSwkaZ7/VtbkJ3YRc1Lmnls+GCQB7kXVJBtMk
         ka3+SwCWpkJXQ8GvQmRbUP6E7wtVV6SXzbLPmklDGPcElE3GFSAhJwDCo5AVdHc1xuU8
         iV1f3uMpS3KElRve5l8RA+emDZL29TfyMmj+w2dTryMVz4DyeotgkuCQLFi+tscwkyUo
         REL8aYElKUCJ0iX+fwZsxFkWJOJjvdcUj4si5P2XHDx8y5iIXFkKu95xjxThNcMxSrbV
         r6MJIREpDunaPAOAv4jWQhVS6QiKQSX65tRl7EUGKLSU0fQNHyxi3z3k03Cyy9tneXKb
         igcA==
X-Gm-Message-State: AFq9FYJwaeeaRKz3u3N+ttn2PC2Ez3fCnFma/ij0cvYYos68HsgGItzi
	qNTOQ4MZcA7kwkuB/NuvVma9s49310FyZ7LS4p4AN1XPxmAxnFOUTcgkcwydb4Zl
X-Gm-Gg: AYBFou35psKyQ1m0DmQcP0vGhKSRSz7qj1ujEGmWxHMHnaC1RWC0pmgJE8mIJpRxh0I
	PCgAIKDHdqQ+w91qkY0Qwlg70F6lhpPfg66hPty7RxaXOuubWqNJUL+pxngDevKchWwVQi+H70n
	4MZ96O94C6C94C1Gra4kJNR/zWShyS0SEZgjVdRiB+k9o46rQGanktNz/0ah1pquUVHgnOfgEKP
	0aw1SQju0SxxtW2Jo6meTEWmZfp75BapX+oXt8s7jFIeZfrTTbSSrJ5fbgyaAsn2mdUH1JA4v1w
	XR2+oGNO1QMoXGb38pBPlRt1VRW2YRQHW761M++gmOMjw+hsmkh9c7wuLORJEOT1IGpW55aGYUi
	3+bql+DYtEWjqSVTPlXNW2Fibuta5TbGFDfLHabineqLjLMUMrnIlQyrb32Y3pfPM0OgRn3qNdo
	q8bGpWdfxw4/2Yl83gqk6mCHP1SjZFAhGGvWdlkQ9Qx45+pWrk4aEn+eRMdLCjete4Kgx6YNa8D
	eIKnvror4o9tkBibuR+FkDOhKImj2zuX7UPBZ3ELZ3wucIpOizGVytmgW5KPcfL3QiUH7p7MExL
	pkbd+e7xbzoJQEoY+H696m9TVk0YV9GwMlWJsdR8GSTjVxximX7rSnn4xZuk
X-Received: by 2002:a17:906:9f90:b0:c2e:6a4f:a88b with SMTP id a640c23a62f3a-c46bd905ee8mr496684566b.0.1792932430006;
        Sun, 25 Oct 2026 05:47:10 -0700 (PDT)
Received: from localhost ([2603:5004:20a0:100a:ecf6:8378:c59c:a85f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd66c6dbsm199300166b.59.2026.10.25.05.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 05:47:09 -0700 (PDT)
From: Jerome Tollet <jerome.tollet@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org, bentiss@kernel.org, lains@riseup.net
Subject: Re: [RFC] Radio diagnostics for USB wireless receivers
Date: Sun, 25 Oct 2026 13:46:43 +0100
Message-ID:
 <179293240327.19425.16324980057213489509.cu0019-rfc-followup@gmail.com>
In-Reply-To: <cu0019-rfc-f29e990c-f139-45e7-af04-5f01ac2f4ca8@gmail.com>
References: <cu0019-rfc-f29e990c-f139-45e7-af04-5f01ac2f4ca8@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi,

Following up on this RFC from October 9. I would appreciate any guidance
on whether common radio diagnostics for firmware-managed USB wireless
receivers would be useful.

The specific use case that prompted this work is troubleshooting
suspected interference from nearby USB 3 equipment affecting reception
on some wireless peripherals. Access to radio metrics could help assess
the effect of moving a receiver away from USB 3 ports, cables or devices.

Before developing this further, I would like to understand whether a
common kernel interface makes sense, or whether a shared userspace API
would be preferable. The experimental Logitech C-U0019 module currently
exposes only a raw RSSI candidate through debugfs:

https://github.com/jtollet/logitech-cu0019-radio

Are there existing interfaces or discussions I should look at? If another
mailing list would be more appropriate, please let me know.

Thanks,
Jerome
