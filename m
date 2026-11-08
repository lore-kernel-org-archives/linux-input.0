Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794146110;
	b=E7w61hqqIuUdUpA4BPtO0lFq6mw7W+3sSpsmgEBqWjzxzR7QGrPnU+ZYd+L2i9xJ/1rn
	 mCjbhAoXNRIXt2uYCO9rpxP/J9ngojrPKjX/Z6QAEnaquHnL/a7xt6qKW7MEnt3T8zOmD
	 DynkXFbeq1RT/KGg4Q1PGaJcD/gUqmXeROFQw5FkLu3lZUYuf1meA+/DKzJ9qDvy9BMFW
	 VQe/1ZHk8W3DnTiOAqB4u9ajtKJKm518/TI/e0wz2myL/RgIGSKIJhYdOZfO58vHGSWec
	 HxgsvV6IlluxRhOk775pKqQ0walqnh5SGJ9uZbXiK1fXLvGdR/r7DLrsT24cpuBxsfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794146110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZrQi1g6OdLGiF+LKKDzmGcgti9ywcdtVUbpGr7gu0lo=;
	b=LHblmdfEjmXewIxhcPmkTnhkvnRFbn6jeaQYtLxWtDL7xA627vMIJiSbNfx37Cyh4LPc
	 rwfIImMjvmSv2Y3bEJHLtQDxw7R3Xv6HsuWq3eY/XEToDRUpK4tNZF4AkDz3HJHzDkZ9v
	 HJO5rAZS3wLhow1dHDiB2FHIUo5TR9fDmCUljSgJrIVWF4VICPo6etuXU0gcVfHlQbh+W
	 n3GGbss1GwMxBrKMbrlUsVlqdJNb+Hgiq90BWVjPR/21YEXVwkrFrXGryT4+cnWHcIKZ3
	 VB8Mh24/h1oCp++2wquoby7B+jzZUyLD5yqFbErDpTTOAT0P4tI2T5KyPNTbMBHnVwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fDlPEdGd;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D334606A320
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 13:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D334606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fDlPEdGd
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1aefd1bf74aso44887c88.1
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 05:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794146109; x=1794750909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZrQi1g6OdLGiF+LKKDzmGcgti9ywcdtVUbpGr7gu0lo=;
        b=fDlPEdGdkdm2V//xQGcdwBBfa78see2JyYKGA4osbIn/cFgbns2dZwThmvKYCoaYj4
         k3fRJwv1HTeXDukPxru6r/tkJQ1/pkus3c7r8YX7WoNoDo+lMobNIJ8ta3+kWqIYli/o
         wDshfvWU2qSJksiBUnCZ6PB9cOP4CgciwPHsTtZhu7uqSS56blGhg+V0KYi9VtgFqCMC
         HmkCGh5m9ikqUrQP1J/awQh93OD7/RL+I0Bq/di6b1NaNsd7WTL4QVG3wRbAv2qJK16L
         CyG+tsvJsSiNsq2HceoTwTj923qeLiHB79FbiONrkWqHtX7zVa/BuvQDDRSrNDfrDwPm
         e9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794146109; x=1794750909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZrQi1g6OdLGiF+LKKDzmGcgti9ywcdtVUbpGr7gu0lo=;
        b=F+TPuhPVc6vmjhYIwegzw5nFb3fbtN90+Qrbm0Vxiq/czHTD1Ha59j9wuyhqcBpnku
         Izd8kv49iuePQuT7XUkh+Mein9rt87vYD5rnpjtMGylCSFTGQHVEIq0MC2ZDUHdzBIv9
         XK/Kpsm19wRVOaDNwv4Yhde9ojMhvm5XhxjtstuGkElT+EDtCTY6Xf6Pf97zLAOV3ttp
         YGGxIQHbyLoD1Ct5xqeZrQyuflxIoLu5B1IsQiR8jck0qzjwl/MJxwfmISjiTU0VHO1y
         pYSpglfw3pLGl/2YXCoW9B9Ui4KWbOrJZeIYX9TlfhETa8iF/5lzqN9rRCCfW/A1Htu/
         PY3Q==
X-Forwarded-Encrypted: i=1; AL+hErEgPgKadUtBb2/ZV28mzctGIq42ZbscNuPwzwaX4KeQeqx21Fov0MFkOxg8cGYp+hv7ti8Xb0ZHr3LP+Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+m2w1XJCD3lOTTL9D5OWU5A6bt7wtB0HOmy9ZAFN0UVs8WbgnP
	9/WzXbhO8LehyP94mdCt0PklIO07R2/9ilTvRfko+KLn5xQjjzEyk0n683IcL1XmiQ==
X-Gm-Gg: AYBFou2W/JNsID2g+itJ88XaLCMUulgmjFiXqiwBZ8SQE+ub4gVy9iVMsO2DDlRPr2s
	/hiu3W4dRaVMzdjMOcLXYX3SKS29DJAwkBNvzqh+XJ9MwpIpaHSEYAbASbIlPB0eMVo1xgXSoFb
	HoOTEl4lQNr+NxIjiGu1068yZzZnqPPELU74iZf0fTSSSyxJkwaqueRmmArvhRt8wmuC5t2pVW+
	YFonBZARLqcsNLJ7Mb09HwgcLjoVFY79rbVnmPhEt/2rCjOjVDtVYTLI4ERjthSKzbkuvH4Cf26
	ylqZXHrxTw39lJIbfEUvuRaQn1/zE+dUZPltuGUQ3Z+YywLFOfafaAoFV2lf8kkotBABn15SikQ
	hIVdpPObdoMIOxCoqO4g9hYirzDO+X0/5TqIQgtxy/k8H1HEJGHeCIGR8ZxoJSWd1joKX6eKg5/
	pxeFBhBfZ3NJnWP5117mjVs2p1EOwVEAqk9i9MWxjGJQpUTxj69wVAkMXebdFvA6g+gUWbsUzuH
	0K/9XbttCcvTM1midildBN92Cnsej0jRtSXbQ7Gf2QpQOPr3EZh+YczmdL/Zj9hwnkHRarmJFwo
	LRqcV5236KYij1avo6CIm/4cuzB6ZS1fXe/10ny8iU0EPZrSMA==
X-Received: by 2002:a05:701b:4541:10b0:143:808b:b178 with SMTP id a92af1059eb24-1b269b4afadmr6255495c88.26.1794146109329;
        Sun, 08 Nov 2026 05:55:09 -0800 (PST)
Received: from localhost.localdomain ([1.251.173.69])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3755e8838sm4986060c88.8.2026.11.08.05.55.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 05:55:08 -0800 (PST)
From: Hijae Song <hijae99@gmail.com>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: ayaneo-flip-kb: Add driver for keyboard backlight
Date: Sun,  8 Nov 2026 22:55:05 +0900
Message-ID: <20261108135505.67330-1-hijae99@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAGwozwEKXJGBY5oZtdrrzfK-aOyYu5GaiOqkejSqbCPdeq0UJg@mail.gmail.com>
References: <CAGwozwEKXJGBY5oZtdrrzfK-aOyYu5GaiOqkejSqbCPdeq0UJg@mail.gmail.com>
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

Hi Antheas,

Thanks for the feedback.

> If this is an actual keyboard product on the market and Ayaneo is
> sourcing the part for their device, look-up similar devices and kernel
> drivers.

I checked. hid-sigmamicro only fixes the 0x0059 report descriptor, and
I found no SiGma Micro backlight driver on lore.

> The name of the driver cannot be -flip-kb. You need to make sure it is
> generic enough to match most Ayaneo devices.

1c4f:007c also appears on the AYANEO Slide in hhd-dev/hwinfo, with the
same vendor interface (report ID 0x41, 7-byte feature report). I only
have a Flip KB, so I can only test the byte layout there.

Matias's hid-ayaneo already claims 1c4f:0002 behind a DMI check for
AYANEO 3. Would you prefer that I add 007c backlight support to
hid-ayaneo once it is merged, or keep a separate driver named after
the chip? I lean towards hid-ayaneo, since the Slide may work the same
way, but I would like your view first.

I will also fix the two sashiko comments in v2.

Thanks,
Hijae
