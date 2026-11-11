Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380214;
	b=VRFiFfoORPIUtNbqkOfGQUjX/L+BRR4uIY8TXsFBKHubDSaUxVDq28XuWp9qkypl5OV1
	 nFc0Rtq2Jg9UCkZ7ydLThAWCs/qD7P9CzNC6pofjTYHEktmHweQl3YGUpIMvYgS0OoIdY
	 TLed9VV57Xz/ZEEk9gJvQfOjqrfO/+14SB/CBGCFUi9Cp9fdN3u7HtkLksMNtrBz9fWQ2
	 ZjIjBLXXVOeRivcoA8MKhx/8qGsnl8zUokmeohaBSaEq5yTRTVXXJ+vzbxWGqsWX3Gush
	 9zrixuRjcSEs9bsU8btGqmyBqormyoVD6NvXWimCWBCPZ3DUCkBUX1Z/1zK4a8rDgVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=zHuCr2plkvodUEXTgueuoO9GfK6YoD/oOJ8xzsmmCK4=;
	b=DUEmVkln9NS9GcT2cM4VPWsPXlhiSJZ9kNFpLAH0xARzWcikNQTQrCECleEm3s5VNsbL
	 Kq9xIfQ5VeCM/iLrQbnyqIu2qzfzP0d394AbJwIzkHAyjSqb4AYr/YxGCiItEWnJasinn
	 7M5bJuqoblWtsUkwB8pWzC0gyuXZd+fpNIXT2FfIAWNV+F9sMpyoBgWJiJk/Cj8GkvN6D
	 vdy0B1jxi+Tb5ILdBU+AKC9bU0kTtvsegp47xaB7wJiZFHA+j7yI73GOhKMJoQq/F3O/2
	 5oJGh3wkizySDOOdHkRkeQW4qjtkQJa7z3t7kqAGbWJSb+DYh/jtro7OGzxsOwROgsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jVe6Bdp2;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC20606A9B6
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CC20606A9B6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jVe6Bdp2
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1931ff67a29so4165449c88.1
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380213; x=1794985013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zHuCr2plkvodUEXTgueuoO9GfK6YoD/oOJ8xzsmmCK4=;
        b=jVe6Bdp2sNm0k+C/GX12pdk4KXYcOPsztyIv9so5EY6mqQHF6+kC3OFzO3Qe73FjoL
         1KbE7iEJpTp4yBSjx3UUh5DC3Vfq0Y3qeGu7RneFMCE5LQUMWzpPFqTVws3I99By16Ux
         S+XAOuVte8kVdmPtvRdLHUtGKdNMjDm51wBDutbRBjXZS/ERpliy3V9K7GAwadeCquWw
         JFT2g07mHtwjflMZ5PylOF//4mzOr5ktFyXqFLViZjlm/yocC+hMolFjSQFTTpFjWRz5
         cyo/Zdcz1RkZmgPXk2e9GSvF868xeVgGN+VD8jU1cue32+R/n3P0fBWjgzB9Jlu8YtSP
         kQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380213; x=1794985013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zHuCr2plkvodUEXTgueuoO9GfK6YoD/oOJ8xzsmmCK4=;
        b=foH1giXp+48e+CrJ73WPvwvtT2mG+oZCuGO4nKToy4B2eYzt48bBy8k0KMd8+mD3eI
         SkmpEQQhigcG6U+arCmUbiH6FF/4dk1WJM7k8eStxaeuSYj5PZvZMV4cONL8+2rOt5ng
         qVEgkVam2obT6sPJdG02xRjTZvyvLz39qlSF76E5rpoN+/u4J1Ykf1dttewt+loBszt3
         ouJXTRBBsEjPg/gboXvv4fx8vNNTHt9fsniXQXnM6lQZfNRh3dwvkxLKZo4X7cFjySIq
         bZk/hb8NFBp9xw9fU5N6D9jgXEW6U0zIq50IGhvxi5bWqB5x1SxjgKxfSio723ud9qnb
         d4Uw==
X-Forwarded-Encrypted: i=1; AL+hErHaFyPEcp5dugEBtO+Li+VtTeZc92vwIRO/+ceJY3VCG4EKrGzzOtTJslrEYVDqz0c9RY70CSj6MvxIgQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8yb60tJsGxATtzN/BrPgs4wsLoPi3WSKahCmy1I0tT8JInvqij
	AHQ+j+UwQjZPWuFJmcbzjVXVwokhApoCxBw2L7rkyZP9GOeiQhDOEl3R
X-Gm-Gg: AYBFou1QW4TswFq5GJBGeMXz2LXCwiL3qpH8K9pk5CDdhmihGADyR99hx5hkMGrHGEL
	bmaucd8PPtRcKUneIX+RfpxLSxXJie5HZACED/qbNVNzMwulvBR0h4fiz0ObiepG/YRtm+xKDcI
	DB8TarRko3SjHH0bYnqu+Gx3l1BErL7yacg7wietRYam39dPbcrgQAmIS42vIfeq40bBGs+Gr8A
	qWFmEoP6BSAEOQuTtm6erduwHy9p7xOS4eNy32DERVjlhv2kyVKzicBO12QPvzAoQHtIfHdZYyg
	pvwGnHdq7bP73+pcKtyDCMZoXu1yIp3+Cco9kHZBz8VVdej/sMCtjaDLdNzNanxyZViR5bRzrAT
	KcpvR+wQl4RyMwqVswkIC7WWp4Yi2JfZHUGN1G8+PP4Zpi20vTemZMyPg2jNTET/f7ndhIYq3BK
	QAn/JiKMCmS8e0+YRY539R4waIGTIbb7XHOEhHZ/qU4eMbQhLuZXitu70t+hXiH15jLZ1IKLA63
	WZU+gOpEGvS7A7u7/Opv1p9WicQe9cJCHMJ1l0c4HFYb1Gu+6ThxCGYfYWTNi9zVkfApk4Lz/D2
	DT3TnYSwz6D4z7+6SzPb+1Xgy9ZcVWCMVZ0MLy4VHBAakSUuTfxr6dIjILbtuPf04g8RJR0e6Hc
	EWuFJlH+BRaTHfVTNgw==
X-Received: by 2002:a05:701b:2903:b0:181:73fc:e53 with SMTP id a92af1059eb24-1b3c03390efmr1487945c88.29.1794380212739;
        Tue, 10 Nov 2026 22:56:52 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:52 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:17 -0800
Subject: [PATCH v2 19/33] HID: logitech-hidpp: use sysfs_emit() in
 hidpp_ff_range_show()
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-hid-logitech-hidpp-v2-19-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Formatting the G920 wheel range sysfs output with scnprintf() passes
buffer sizes manually instead of using the standard sysfs helper. Use
sysfs_emit() in hidpp_ff_range_show() to align with current kernel sysfs
conventions.

Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index bad6739c618c..03d2e9077675 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2724,7 +2724,7 @@ static ssize_t hidpp_ff_range_show(struct device *dev, struct device_attribute *
 	struct hidpp_device *hidpp = hid_get_drvdata(hid);
 	struct g920_data *g920 = hidpp->private_data;
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", g920->range);
+	return sysfs_emit(buf, "%u\n", g920->range);
 }
 
 static ssize_t hidpp_ff_range_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)

-- 
2.56.0.542.g3ef89b7020-goog

