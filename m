Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794863367;
	b=UdYnt6GGPC342XDdWTSN44z8SDOsSSUY6kp4zPCadybJkd0DZCZFIYtHlntfgrcT9qf3
	 0SdSkfT29hjvgMu3CpSnu40YWvpu2upgbVYun3wZynV3HD9g8VdNkVnsXYQsOUoUcvbt3
	 bQO378wd/WqDES+euSaRbhelGo7cqA1YbLOs354O1mJvEc+S8OvGOEUizJa5GqhhcqaxJ
	 /5st1Z3FiOAHFKm5DR2NysyFiv5gW6ocnUZLWcfkp7Enzgh1Zyy55wjJUzn8I6zHr1USh
	 bCNffhYOTw9sYy0FoDcZTUCx74ViTIYqSUG5V8Wifb9D7LQmuEsU310RnpG88Yh9WYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794863367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/lMdxSYl0oDvZ3U6+DpzTx/kdROHaXy8vo8WHiex83Y=;
	b=I3nD0O1h02qrB8D+mKwVC0mDFXzGArkCgMsQabwA5xMUG5f707ftn6Wyemt2KiSKgI94
	 thmjHixsiMS1zK0dnDxIlERpwMxMVmLKCf9+RsFQPV37Gt4ZsaNEQvLMoJ7l7veRVL3+W
	 +IOsf6cXztM1cPvOtye5Hfw/J3HU9eoXB11blPp3SbdKGdipVc4DDPlX8ON//nao4cnOk
	 8rlCYbvClnG5pNmmFAfpF8GBKQAW6JVeGlM/KNjKwC8pQWdfzvW8eQyGXurYlQzwsgBGA
	 JtejZ35dpdDTy3/tFF51m4iCXFgwfv5CTtnpzBKJbb+dCiFBVIwdP6xVyEhGmCj2LHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rx4GGI1g;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2BF606A31C
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 21:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B2BF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rx4GGI1g
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so14617905e9.0
        for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 13:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794863366; x=1795468166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/lMdxSYl0oDvZ3U6+DpzTx/kdROHaXy8vo8WHiex83Y=;
        b=rx4GGI1gfhh/JrX38oW6mpA4IA+8BbUGemp4vzxzHldpCgcOJxiBOlrLfNxIhfFIaK
         76fa3vJcT92wxoiPXy/YNcy0HfLJH8tXnmuCmlrxqxhxxFsjBruiIzBwZRKeDJQ66a31
         6rqjOEUNO/tM7EYOjZxzZIWI6ghmvSx7u2uywQDxt9SPDhIAgjjpg1+ZgAHOCVPI6KEq
         yFrydTeb/o5uIv5OitXsZ5NaYjSUtsoYGCRjOxNUVmenRspvtFPx5d9Kl044W/yXfCW/
         OrOi/aR9By7gQsrGDMziqlXurYZZwSqh3l9qiKvuo+hEBdcBEyHRjtD4xlcKVMz4Sjxx
         F5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794863366; x=1795468166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/lMdxSYl0oDvZ3U6+DpzTx/kdROHaXy8vo8WHiex83Y=;
        b=XloX5XITZDimuTxrx/MxO7+SgWIng/7hF2gewtI755XBnBZ1ggWO7MOxG910xEZh0H
         E9zjS1YCsrL5niN5UdUjBVuNmOWMpERurY8nodlQ7tu2ODxTMiQo26wiRcRB/tKFthL8
         0DUERp2W8anouJEQ1Gy/j9TAScQ2jFd3cA2nCga8oeV/L/eGYyeSxn3wkImGhG9oLig4
         zlTXyvMp6r0m/MFea0a4fMUQ1WgRea1VTHf6Tq221xWS7/8Iow8eaMuTBslInMhThmPy
         deooUTAjozhd4LBNg6XwMPr0TFK3Yh1shYrlt9EgDSm17tWV51AFQjpcGMu867hS/UJ0
         eEAA==
X-Forwarded-Encrypted: i=1; AL+hErF08EGwpYMo/g2YbkLi6W050Zgg9cWMCOTJIxu5jnb9FgabgUAsFAEn54yX5Ag0MEcW5Qbb9Q68sRwXeQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z90H/m92mWE55gdRQR30yG88ertXdOeIEEYpITGXVPFNUQVGcZL
	i/5ggLZbg5Sl85Es0pXq9wOS4DnkfLJHk+777O7iWPz54k+gHwDTbt+IvJx7wYNHPgk=
X-Gm-Gg: AYBFou1oW66aH7fpsolxT2Yyzq2smgnMASrK56054qKkgadfoUgLBSOZGlnGxGINCFj
	u6ORSWElPJ6F+obV9ADk6ozTJEawHM71jZiyUfykYY77qmtUAh6ZYbT4/GT8GnUsm8JMNyol/Zo
	OeEyKB4c0CjnbvyZy6oYR9bgmcQMM/cHO+jP8QqJwuu1qKvP54RJSfmFVmngx1/dUCEAOACWnLl
	/Nd0Hn6Uzb/R11fl4ZijEy4dny1ir4shLtfJ/OeaHtb7UiUx3TQHYF/mNAd45FMxMkWAxPN2JS/
	1sfKPwCQzoot5tWv5au9NqMofFG97vEfvNqjNyPvb+gEoTCEvr3E++V8lJUB80koWjZWqcAvWPd
	DK1h63suPJEQOvkQEW95B9dDVTwS8aDZC3hSI0dq7txdf64UbhfdREjySMPv7ePjm7XsnYrLcDs
	JAzU4LUx/DwN8xi8GfDB06eRihhoHIIX1qhe4wlDMyp0xOltkToZkAK7P94Mndn1Zdq+4n/xeCt
	9xgMmkl0BelCLPbf00bWC0Jy2F3Wevjp+SRZAKDXDVNj+tuD/1s9kWtlF+b9nBwwd+khUh1tFAc
	PIeVTHyoTIExi5OlC+LB/rfz7pP7d1fLwUR3wiVj/pFcAiG/RdQP+dYOh2zNyj0yRurzOIqdKG+
	/iOb5cAhbKMnlx/oXVvYncxIs0oSPUwPFe5fvtCQq+yn5cAlNnMH8v+QLLiLM0CKle/RkHVg3y9
	xJRW34lhOOHqg=
X-Received: by 2002:a05:600c:8b82:b0:4bb:6814:7391 with SMTP id 5b1f17b1804b1-4bb681476a8mr151777855e9.25.1794863365568;
        Mon, 16 Nov 2026 13:09:25 -0800 (PST)
Received: from archlinux.tailbe3ea7.ts.net ([95.173.233.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78422d2dsm24575765e9.10.2026.11.16.13.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:09:25 -0800 (PST)
From: Ismail Tarim <ismailtarim7@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: James Ogletree <jogletre@opensource.cirrus.com>,
	Fred Treven <fred.treven@cirrus.com>,
	Ben Bright <ben.bright@cirrus.com>,
	patches@opensource.cirrus.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Input: cs40l50 - fix OWT upload length
Date: Tue, 17 Nov 2026 00:09:17 +0300
Message-ID: <20261116210918.1940242-1-ismailtarim7@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261031095438.3070451-1-ismailtarim7@gmail.com>
References: <20261031095438.3070451-1-ismailtarim7@gmail.com>
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

Hi Dmitry,

Gentle ping on this two-patch series. Patch 1 fixes an out-of-bounds
read in cs40l50_upload_owt(), where regmap_bulk_write() gets a byte
count instead of a register count. Patch 2 fixes a work item leak in
the stop worker.

I can rebase or resend if that helps.

Thanks,
Ismail
