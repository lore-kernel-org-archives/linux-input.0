Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466279;
	b=n5exiwNWc40TFs4RG6NYHU4j96+bxhgBk6+HzRs0np7xDI1yVX0r4gnMSqqhL75ffQtn
	 0UK9d1dflbBUKZ8lJcbsgO7yDKNaICh1/N5HIKU9kixQWp5o6VxfRl7O13uDKPVzjnDgs
	 /uJ6eMTAgEnr0wxAxmP4EXOlUAYvdtgcTVY7HkSZEwNzs3HYHviPWla4Yxt2sJldC8/tE
	 47opX5llyjKmJJsSyJPdZClsLYh4erZVF8RbB09T0/5AzX5sw2wF5jX/hWC8bJ4VnCvAR
	 5xOXSEWxpg38AlzPGC7IdKW5qSjPjT7+RZOmUiF3cbkyxOiokW52l+fsTtMwZ8faIxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y4XjNgQPHn8vfXK6a1wosIhFOQwX7Ap8Le+1JlmH6b4=;
	b=R4DhOYb6xNPfJCyTqtKIkZEDgsStjzBSBRCLoBZKW9oAnMH6WpoxI6WDfmoj7lhpNcwg
	 sK2cnqrdxdZHup4nm58yok8nhruwxvWQHX3bu8/xJMqEVXL+71UKmqbcSHwfyGKbYA+ER
	 6a24suZUWiYeRfI2QL2Eb9INW9TN6433R14BJyK80aLqnQo+/K/ZwzWmuLZnvWSv2PtGK
	 3Fd2Ahy19akEHBdtZJR7SBRGa4uj/GpiVgKwHmGGIW3QU1Xz+XkYRHYKeX6OyYkLSBeWS
	 ntWuwyHbyUYLbyACle0RFoLaaB2GZuK4qvZCZDsmYweLTlVd1tvtv0wIWIjEuRgsuDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sv+lNKsz;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE93606A333
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 06:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CE93606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sv+lNKsz
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-37600b0db49so506187eec.1
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 22:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466279; x=1795071079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y4XjNgQPHn8vfXK6a1wosIhFOQwX7Ap8Le+1JlmH6b4=;
        b=sv+lNKszUjGRjLU71mdMXRs6USKmf+ajpNsLredZ5TwyQnpfJqCZv+g/swdX7GHqjV
         QNYIR/4Bdcemq7WYZts6iLR2Mv5fJx4rur2UfNvISKUR1ZvyJLr+ZbTF8rP68LO4Yv7v
         IsVL2GWFfmaIgvFl9Dv4k95WBjE6h2Y55Eu0u0yTCYHPX7LwbLJzS7vxZeKsCjW9HKxZ
         tKHA6aGGZ7kO3ToVfzU0R+AbuTLxBxz8lCrlAmhTH+UHEN0zbSm6jdRr02tfJBuwIAw5
         M/ruwW0zfq5WPBNQRvy2rAB01xh6RxDjsoIwayKZ5M8BwT7/iVwMWhVK/mKGoQGlFDxX
         rnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466279; x=1795071079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y4XjNgQPHn8vfXK6a1wosIhFOQwX7Ap8Le+1JlmH6b4=;
        b=Jq2exOdF+lq32Ju8MXaxYXsGVufKogbWnSQAiu6oiJ4sWknhOFBIMbUhL5bD0GyTbH
         updZFppsL4xTlQwv77QXPRNakFBWUp2accaN2q8YvVlbSVbEeJ+yaBIputYbMnEg8pRW
         +Fi0P9uAlLzjxoGh5iYmFspLhw4wvZCppMbFNNcdy+9lx1/hWRX9Ex67ea8b+Qwv4WkU
         2cWzNm8PJtyPLmpQVrPkHZkTEFohJX6CcFxnIgsw+BdkeNQmEn/3fnUcp/8d041MrpPy
         4GrONg1P8CMbnRAy7EjyFB6JIZba8xW8L2WI1ZDIIZ5ujqyiWK2pBrifzJtpTRvQjisb
         uxeA==
X-Forwarded-Encrypted: i=1; AL+hErEVUKmscsZdu+GKkScfqkVpjRagl4NlhGRZxCe99lnmfwsVtnFKgU6d/Obj0B65KdWkS1KLURlU2k11SA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+zUtqxsBPLLQ/HbMR+DyACngPe7XztSoHHwlHU8XtRrzHXw/zb
	Tn2EryqToWkL3SoFOSgfXxH9fIu64YI5Gygjr9m0qw/Ki1S4hZ3zguVF
X-Gm-Gg: AYBFou3IfD5Q+jVm++x+JFDKwTMMh7aM/HciIdVNFwR6QAy6+i3jFMcHM+Wbo45Q8lm
	LnCisSEtDy/ownauN7RwUgyaSb1FG5iy0j7o8D1jYRE45q4KP89n9yiml7nFpGqhTowubPx6qJI
	UZozbRwIU0jK/RAKzzQR5o+G9WAwLoOqfOp9BKTouOU6ZEKVGpTtFhFHO5epRKpmFgKCrGBns2R
	uAdKG4JMqwnQGptJaTcqhZeeMQFZRGGvhcodOlZrpBL/RhpvRQsbbf2BQ3EG0LTQz74p3zysSQe
	CUrnfBTAsO/uExv7Zn77Io9wQ9e/zjdgbpq7kzAyRryDktTe2JLEZ683cRAqMo/wI0dwaebtisM
	65MhkwujxatQJ5BB2mGsNtPBaxxShL7WWpItEDhLpo+PEuIb/ehmOEMAdIPgiwnjkK9BL7V4gBF
	+Yo1Sw+ChqBClbRX2exMbdt78jyQud0xwdhgASULsS7yUkaf7CRnFZka/YBfmZffd0GadX9MDo3
	e7h6aeY8cB5zyzDVF/VxLW2dG6z9wrR439ArTMoPnwIyaLJ3PDW1nsSOyf6q1zxRuW6JLukbC6K
	aK9VOxXummGs2pC2Yz6hSljRLcLlmIcZunWxj7QJtjrFhcqP4Po7L+xVZ/yg9fSZOazX75zcaIX
	/tBYEOcvZkSCdwDXp
X-Received: by 2002:a05:7301:4104:b0:36d:dcdb:70c5 with SMTP id 5a478bee46e88-377e15f06femr2247708eec.20.1794466278411;
        Wed, 11 Nov 2026 22:51:18 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375215d8889sm24547205eec.27.2026.11.11.22.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:51:17 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jaewon Kim <jaewon02.kim@samsung.com>,
	Hyunhee Kim <hyunhee.kim@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Pankaj Dubey <pankaj.dubey@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Input: regulator-haptic - drop platform data support and style fixes
Date: Wed, 11 Nov 2026 22:51:13 -0800
Message-ID: <20261112065115.1803973-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
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

This short series removes unused legacy platform data support and its
header file from the regulator-haptic driver (as all users configure the
device via Device Tree) and fixes minor coding style issues.

Thanks.

Dmitry Torokhov (2):
  Input: regulator-haptic - drop platform data support
  Input: regulator-haptic - fix coding style issues

 drivers/input/misc/regulator-haptic.c         | 29 ++++++-------------
 .../linux/platform_data/regulator-haptic.h    | 26 -----------------
 2 files changed, 9 insertions(+), 46 deletions(-)
 delete mode 100644 include/linux/platform_data/regulator-haptic.h

-- 
2.56.0.567.gdb80ae8cd5-goog

