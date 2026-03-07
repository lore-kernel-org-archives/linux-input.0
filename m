Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F652E55A
	for <linux-input@vger.kernel.org>; Sat,  7 Mar 2026 02:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772851604; cv=none; b=UL+danheImMNaMjqBsagdCZAr1P+EtT4ZItJQIFI/oki/sXEbb9BOufh29f4LhOXpBVdlnIZp2zSUY074ZnqJqzStF++N62Tb6Y7AygL3JjAxK9hvZWDi9cBDv/cSbIWc3meJDh7XMUFSZKE0LWdX2Ru0iTYo76LxO9l3c2+Bwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772851604; c=relaxed/simple;
	bh=qltDKB4UBJV3q00+O7k6Bwo/W1lDrad3Y7PXDd9U5ks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s0aSd+bkJRYSqTmJX7F8SjjuFUYxy5u+riUY/zPx1tGOv5Lxw/hgn5N0OUHu+pyZ4ERhJzPFNruq6XXW93rvM2zyWoyK55AXA0fQc7Qv7Hb3t/qOJtu9eoQvNlOoWCLDkvbTzMLutUnxPoY2UeDb7zWWbqRiqCXROq7mcvO802k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpcT7mIh; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpcT7mIh"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82987437624so1336056b3a.1
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2026 18:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772851603; x=1773456403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8td1Sjlb+KCtwLCz3PZqZLQsbEXKvM1x0KvB39hIL0=;
        b=RpcT7mIhDY/F3z0lP3g7C/EVqoXXTM921bZe/AaFDCtz8HPPzHJISBKeM2QymypeSK
         fIx7E7Oos2QsmameeV1ZHsRpFhmJeYTDIPLnartcy9tn8Qz0JtORQFM8+AaOnDsrcdeQ
         8Umbp9LZ84R/2yHK3P/x6IZGwXPPOReGZJ4AF98G1zEu5+cVczkHQBUpLb2FtJ7aulI6
         nAOpB4DY/tX6vg1KjZxKAhgvTZKCc8M5vl5lqNn/L+m3RPBl/o4dVY5nQQNtIvKx6n/L
         ZCJkJexjRqIA33PhhzDSC5v8qvIFcWZJRzCLnEEtl5RFzD9R8FtHRG1gNaoayOnHry6+
         xbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772851603; x=1773456403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g8td1Sjlb+KCtwLCz3PZqZLQsbEXKvM1x0KvB39hIL0=;
        b=Oyj3al6dU1JGlHF5jGt8qvRW87wA/D7Yaln20iMlB72Ye1TKtR8/YnNWxWcpMr+tJU
         UPX5qX8KtYv0sp9upQ278nP+DI6XM74kDGQHlC4x5O6MCxPQJBJ/B9yM5U7rXXjegd/5
         XYXfCRqm1ZNhxX9bpi8cyCOvw9U0Wygd0PiXzdihBV6Z6gFWsCDKX0A8Dh9T+VCisBAM
         I76YFiXT+TbTbDf2jQGAoUuA/MO9H2021qj1It/LnJBbw7m3pSuSAWlTIG0JxyvFwOxL
         H8p2FgaeBn7Ea357m/DU4L4VJ8zZ09Msgro6vz4ExaxbehZolpB2HJspA3CgPC/toULC
         3t7A==
X-Forwarded-Encrypted: i=1; AJvYcCXoCT9lo7aahvpbthM1lEZbD95yl0NYTL1fOFXPCFFCI71OZ6o+ZqGluZlPkNBPh32wd4UQdyIxPVMAbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVNtl8pR6luHsYNTghRy5dYtbkRTHklp6SRE1KdyWVPwdPfCXH
	mkeUQik3JQeE3rgylyQua15eMHhj8o5k58fAAKfZX+yQa1vX746WQYm1
X-Gm-Gg: ATEYQzw1WSalZl/OrUwgnNE+QoRCJ9XuDDc7lV6twmp147GKdmwmM9A8mEgpYWPcGvK
	430IlaLkJ1SAtbOVU6mwPVQeImHcLKyFD0JGKjsZ5de2zmSVAsvo+Zp6acrxWZg75PzIIiXEVfC
	gIngpwJWWebz9J0VGkj0ROkivM47oZ79L5RyvJ+CBwmihOMBaDz/dWFcU/kht5wYZQ5fWYA7Y0M
	x0JhIjU+9FJg6jNVsjYUUaingqStoRJP6qlK1Y+eOPfZtQLY4MW5/011kHqH2i91BKflpEUgDcu
	xdgH2ScC/y/NB9KRcqJGRWKrbAHVOZSWhVAksXtSej8lidMs2/su76QTUsC2z8zONraQWmnfMsf
	uj9hLIW8WSntEuUAyXy/UwzRVlGmWuLgJiEgbgaqEtIscmINyohW1ErSVlo6s8BhjPXzTTCJ4zT
	WdpOQfEsKbqAkfFGJNZIUSc42+OKgmyrpiUDDzvhjX+F+re26M2fSCAy15I3qowB0VQTmMGjLvP
	M0ZNGsoKpQD8B/ikS97VB9EApNo
X-Received: by 2002:a05:6a00:2396:b0:829:751b:4b06 with SMTP id d2e1a72fcca58-8298583ccb1mr7469171b3a.21.1772851602731;
        Fri, 06 Mar 2026 18:46:42 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:8207:3134:c1c0:ef7d:b1c8:1597])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4866763sm3086459b3a.38.2026.03.06.18.46.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Mar 2026 18:46:42 -0800 (PST)
From: phucduc.bui@gmail.com
To: krzk@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	geert+renesas@glider.be,
	hechtb@gmail.com,
	javier.carrasco@wolfvision.net,
	jeff@labundy.com,
	krzk+dt@kernel.org,
	krzysztof.kozlowski@oss.qualcomm.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	magnus.damm@gmail.com,
	phucduc.bui@gmail.com,
	robh@kernel.org,
	wsa+renesas@sang-engineering.com
Subject: Re: [PATCH v2 1/3] dt-bindings: input: touchscreen: sitronix,st1232: Add wakeup-source
Date: Sat,  7 Mar 2026 09:46:34 +0700
Message-Id: <20260307024634.1479-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <45fc7e39-3174-432a-9994-9de528759348@kernel.org>
References: <45fc7e39-3174-432a-9994-9de528759348@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

> Do not attach (thread) your patchsets to some other threads (unrelated
> or older versions). This buries them deep in the mailbox and might
> interfere with applying entire sets. See also:
> https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/submitting-patches.rst#L830
>


Thank you for the guidance.

I would like to apologize for the confusion. While I was reviewing v2 
myself, I realized there were technical issues and immediately worked on 
v3 to fix them. Ironically, the fixes I made in v3 were exactly what you 
suggested in your feedback for v2.

However, because I was so focused on the code, I sent out v3 before 
checking my inbox and seeing your comments. This led me to unintentionally 
repeat the same threading mistake you had just warned me about.

I have now carefully read the documentation you provided. I will ensure 
that v4 is sent as a fresh, un-threaded series.

Thank you for your patience with a newcomer.

Best regards,
Phuc
