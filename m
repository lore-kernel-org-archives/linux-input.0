Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461534;
	b=Xqg4VC16EzdgN8atOKk9gwLCHwcJc/jOGqlhX5KDqW5PbHD8zUZvxlzxssLuSR4wtZPp
	 X8t/qUcG4UGPHaBdvAXUyQdALkHoOUZGTl/SsOqDkv6N/CN8F/QVQuUM+ElIpsSXlsroX
	 LvWb8L8V+GIDqjg0G7eIqoIBsvm+o7wIGg4Sm1vlKhdspvOcsF4tVj4MrLqjtxrL3ZwBf
	 cnS40BL/w0I+Rk9KEUa/JYdL673N5SyBbCtBv5uygnPusTY7CLsUZJqkLM/x+mLw3gsaQ
	 YutuBRefVmeLSgApzbYzaTcrDbFeOfzyr5lXHUTfmpR0mssYUXpTqAIAkTjP/O0TESQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8bdUIArMEVujVxSnFXg7ASEB4w5yQy9UWzwj4XRgu74=;
	b=kWdXdlVupo8TU1ewE/ztLGL3VlGi80XM4mQ4o8VfSd+duo8JbrEM0X722EZfM9KIqMJx
	 vp9+wykAbw1eGhYJ1nzJqat2majITFYpASWWQ2yVbBtP5ZvQeHAR3sXPwGnGva7VnCsSK
	 SEv7OrU14spkQ8oQt8CIKsp4wyhPLBk6zshJXGn1hEWIM7PaZwCBrmtsCNPdSZOAIa4rX
	 VNJXee1J0r4x7ouavhEO/5bagheedB/lieBN2XS2ZxJaQceHNBZkRVgf1Mvfblmam90Rf
	 sf77cBtDqldy8VN2XLeAlSLzhKK0doiewpAE3+MB1vroyrGekUG8+7Uyd2J1HSRu/tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KiVa2YK+;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AED9606A32D
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 05:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AED9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KiVa2YK+
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b197cd42b0so406037a91.2
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 21:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794461533; x=1795066333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8bdUIArMEVujVxSnFXg7ASEB4w5yQy9UWzwj4XRgu74=;
        b=KiVa2YK++8rPL+oDHtSbC6BXxg610PnN71TSFaCQMwH/7WEm10m1RZKAFK1g6LlMnF
         nbW+3+RfwUzWgD+d6i7L22JK/N87HiZPTpPbDhnjfMEXA275IkjSlNYSE769FL48ANrF
         PCwNR1nnrfDKWG6Qss/5VxsBk+quH/Vrp0dgBeDX00ZpaSFCG9QNHGeV104Kd3nDZnrq
         rIGJf+jMY9hu8xvTm2bCqEQ9Zu95m583Q6IM7pNuxVQloMQncqpbK0FzAV7m2dnF1Sn2
         V3T1MDFPqTorXyMwm0h6FM1WEguLp6ryEKiPydHS3SGwqqe/+h99W1Tbzu4IALH1exFm
         iwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794461533; x=1795066333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8bdUIArMEVujVxSnFXg7ASEB4w5yQy9UWzwj4XRgu74=;
        b=uZyuSdHB2YqakxBJEY0wooXPk3uIkxd2wDqvx7J/Pg9kK/ee07aralbqJpazhxdy9c
         jsxUJ9D+qun9pXaIjSyWDn09xUlkTO1sg5Agb8k3TyfH8G6VyPgsMhAy8MlTEJtDO01V
         ns9yOpsTChD7uZL8M8TjzRkDNDYNF+odWidrM3IClZqpYiFKHR3tR/02w8GL4eodMIqz
         j7uGALgF3XB3AmNFV7limLMz605TsuUg6qe5b7IsuzCVyeUTgsc9k4x19p9hws8hdUGZ
         TCdNjLfqCJCf3kp9JgYkT9fHwlI748xFvGhrXfkvBuPq7Q1cbbZMi6eIgsGDO+OJt/mL
         pHfA==
X-Forwarded-Encrypted: i=1; AL+hErEVFuhJw/TLzj7K4Sf2Vtv6jOQCPYQwfjqwmePZhnNsgJLVufJRzppT32L+eNLYX4c/EM1vk3P4Yua7ug==@vger.kernel.org
X-Gm-Message-State: APuU4Z9W2MNMdgzG3kAkC6M7qSDnIQXk1WwN3YxaDar0i79uW5ZLdhkA
	onOO7Vp+qNjpQ+QBQMtPYlEa/h1+Lr0NLKOLGy5LqJTMHPobjYgq111vy+RMuQ==
X-Gm-Gg: AYBFou3qGAC4PICAtspwlRu2LCWY1FGr5WegcVqbvJcIvuNmOXfQ7EkVDLghKBZGxOE
	1AXzo/v2edPip+JVdCiA0JGXD39EBuQGTdp1Fy7b+59XxAQ1lpb7lGtUgckcQP/KuTwOwU9lxY1
	wtTyV5U4yeFMzC4/rvtQFg6dBlYrc5qYL7GGeZILpm4N1gkZ6gUOQqVRth+ztZS2ltbYnT4cBGN
	jjmFovVjilaBgjyqGHyysh9JmhfhQ+U4FO14ERLlFfTeuuVZuKE3RzP67eW2y2a+6p2PAV2ritp
	tkslK7/Fp84jzuC8QsVF4NRsthgTqDpx2PeoSH4vyAOka0J46SxRC7LhxQA8tbD71xv/xP4hGCO
	Op5Z3fLiDcThchsGYiWrEIU9A43MSoL1mWJvqGUJtvxMRTFCFnzFCyemCTEy1Gs4KvwELEpUo0X
	8+mg3j+O4NyTwScuaPPtqw3VDayaxjKGCXxP9owO4uhSkYwothnIcxugaTQ4Nipm26T40Qs0574
	ft2mHpCaSBypp45A579+GuUm/uvi3nQRuoiIm3PgUroM9JZ7GlXyDlM3MeG9JW6pWPnz5oi7dLP
	gpMWFY1n0vnxl4wsd5Fqeju/M2gZTyq44ybp0eV3coKOUNVHBwIbkjfzT6B50DkSn5laWfSwIxy
	5VCYZMV6AKaBi9RRI
X-Received: by 2002:a17:90b:33c6:b0:3b0:9e2c:9b61 with SMTP id 98e67ed59e1d1-3b182ee21e0mr4536093a91.35.1794461533487;
        Wed, 11 Nov 2026 21:32:13 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b181b9419bsm3600558a91.0.2026.11.11.21.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 21:32:12 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Michael Zaidman <michael.zaidman@gmail.com>,
	Rishi Gupta <gupt21@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrej Shadura <andrew@shadura.me>,
	Johannes Roith <johannes@gnu-linux.rocks>,
	linux-input@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] HID: hidraw: Encapsulate struct hidraw and make hidraw.h private
Date: Wed, 11 Nov 2026 21:32:08 -0800
Message-ID: <20261112053208.1397505-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261016-test-hidraw-base-v2-0-153f67a20cad@gmail.com>
References: <20261016-test-hidraw-base-v2-0-153f67a20cad@gmail.com>
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

Hi Benjamin,

On Fri, Oct 16, 2026 at 03:41:47PM -0700, Dmitry Torokhov wrote:
> This series cleans up internal HID core and hidraw header boundaries.
> 
> First, internal HID core declarations and unused symbol exports are
> moved out of include/linux/hid.h into a private drivers/hid/hid-core.h
> header. Next, a hidraw_instance() accessor is introduced in
> include/linux/hidraw.h so HID drivers that only need the hidraw minor
> number for naming or debug logging no longer dereference struct hidraw
> directly. After converting the drivers and dropping unused
> linux/hidraw.h includes, hidraw.h is moved to drivers/hid/hidraw.h and
> struct hidraw along with its internal buffer and list structures are
> made private to drivers/hid/hidraw.c.

Gentle ping on v2 of this series. I verified that it still merges
cleanly onto next-20261109. Could you please take a look?

Thanks.

-- 
Dmitry
