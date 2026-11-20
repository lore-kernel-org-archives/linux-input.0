Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177952;
	b=zzJZDOBSC3qYd2idWtD2jYwXcrNRRfyQIqDq8gnTMJ5DBdC+q+5muoR1Xypt9MdJcnOq
	 6xCDV17JR0ki5qH/kaEgxSxUx13UB4qGh8vTw/hP4phPtlxNVj3b5whGIemo8zh77bdnY
	 rOO5AMmyz2Svec8QQuJzN87/+UNYEF3v0ci6CmlpxchTwcZdkiGGoc5QHSPZE/Bj/UqoV
	 dAIcJM+Zhh8w+ooHArxWqeQbRV9PAitTu7B7nbf0W/zO6Po6nkqpVw8OGh6ugiYXNyx0S
	 ICG8v8HmVJHgKM1OkOkBHbmYjkNDdyfW9RcBPfAxGBsu5OHygxHSyoe+C6doOF1h5UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177952;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:Date:Message-ID:
	 In-Reply-To:References:To:Cc:Subject:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xJgqJ1GzLT0Cz85cGPOr0HyND/H8SVlikDVF2XvQ3RU=;
	b=v/dBbP4y6VH83QKUvV+4nMtg0vxlL2qlAY5crtiVUngdjM3g0MZnFe0mAUZljTtHQ47E
	 L+k7uQXXPEicgSxZMjjBrAs+zPhz4tn0lH+GpdxL6jGVcin9VEdf7R/BW7v3mV6Fg82Au
	 5LV6KdKaYb7/hYak9xRaD4Ez4DpAIabjlszuzRNP5Z9gNvtEWhPgbFt1FKK0NSb49eH0t
	 NFoQ5+9bexBVgeTQgwidhk7bez6Owk5ScjLtSSDno6Zthj8z9RgS2DCfrA7XGPjBZTFTl
	 Ws+oppkOla6Re1j2bqUedHCdhdp0X7ocmaZqLPCl/hbcvo8jZhlhYqvyWesoefnsgfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aclaesson.com;
	spf=pass smtp.mailfrom=aclaesson.com;
	dkim=pass header.d=aclaesson.com header.i=@aclaesson.com header.a=rsa-sha256 header.s=protonmail header.b=dQdQelpQ;
	arc=none smtp.remote-ip=109.224.244.108
Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E681F606A320
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 12:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E681F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aclaesson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aclaesson.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aclaesson.com header.i=@aclaesson.com header.a=rsa-sha256 header.s=protonmail header.b=dQdQelpQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aclaesson.com;
	s=protonmail; t=1795177948; x=1795437148;
	bh=xJgqJ1GzLT0Cz85cGPOr0HyND/H8SVlikDVF2XvQ3RU=;
	h=From:Date:Message-ID:In-Reply-To:References:To:Cc:Subject:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=dQdQelpQE6ziXihNgnYqxdHRHwR4Ng0knHbXzOlXKtBgb3AClyGog0tku0wLWcOJA
	 ALeYMY1F0zEP29de/HxmWxgzh/HFOCt738weODI/naeYiIwZCuwDGkzFvkX0F6MuFA
	 4SZg1l9HBO61dFpDuMCPvncc6jGNbzqvvmbnOw7o91tx6OwjqkTMX+V1S9u54yTtsb
	 j5dKbwwkFKG0MlxEeC/hAxVweEit577pLna8IbHNWYhMHIhAVWXwvw/yuHn/IK78JE
	 gDoX350uKaZqFn8KjFJ7tXHbwvLE2jFECOkNyFO2CC1AOHzlMJP/kMC5p9K2tv1w5l
	 mHfw48bFsto8g==
X-Pm-Submission-Id: 4jWF8n1n5Zz1DDr2
From: Andreas Claesson <andreas@aclaesson.com>
Date: Fri, 20 Nov 2026 12:32:24 +0000
Message-ID: <179517794443.913379.16756320627305412346@aclaesson.com>
In-Reply-To: <30po4s0s-7n8n-1q84-40r3-623n6n45p005@xreary.bet>
References: <20261109-hid-corsair-k90-uaf-v1-1-0621c2c5c451@aclaesson.com>
 <30po4s0s-7n8n-1q84-40r3-623n6n45p005@xreary.bet>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
 Chen Changcheng <chenchangcheng@kylinos.cn>,
 Danish Khateeb <danishkhateeb03@gmail.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] HID: corsair: cancel LED work again after unregistering the LED
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

On Thu, 19 Nov 2026, Jiri Kosina wrote:
> Applied to hid.git#for-7.4/upstream-fixes, thanks.

Thanks, but I think this one should be dropped again, sorry for the
noise.

for-7.4/upstream-fixes also has cc8d022e8679 ("HID: corsair: use
disable_work_sync() to tear down the LED workers") from Danish, which
fixes the same bug and which I had missed when I sent mine. With the
work disabled before led_classdev_unregister(), the LED-off request can
no longer queue it, so the cancel_work_sync() calls my patch adds on
top (e624a56578e5) do nothing, and the comment it adds is no longer
true.

It is harmless, so if dropping it is inconvenient I can send a revert
instead, whichever you prefer.

Thanks,
Andreas
