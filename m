Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD043B6347;
	Mon, 17 Aug 2026 07:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786951453; cv=none; b=ShdC12gnz9KArWxpbSVK2nkc9GAYs9kmYCM+wX90NWNS5+dOmj2DtjieJBrJ7FD8OSsOQhGQKfnoipYLCpGBsLiWI9KL4GDCqCnkSg8J/YM2ioZVhw3U5NYowWd5tlJvY+VtWCMRHq7J0a3oU79mHiIZ7bneLMP5K17Jqi86BVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786951453; c=relaxed/simple;
	bh=iBkmqRohZDMCGIR0bhHm6jQCCxKZdTFBO6P8B/3by50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yv49UR7iTPoNQJ2Plc/D+pYbX8XsBAZCANrngatqa/32PcQ2NX2RKbDpma7TmIveQSw6+RviWHOIV7BRV5N022MKvE65/yP7GPZhzYbArTabYTLTe5Q7ey/+ZCTtM+9RTu/xroOF2ZpdEjVS91ZIUhgBbawWd+JB5ZNQDODJCCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HAv6JHkO; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HAv6JHkO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=xf
	nipWVIz56Ov4VlkVxJPvNt51YoKPgj3wY/EDSPzZA=; b=HAv6JHkOEXZ6LFfeum
	RTSrZohthVdRQhScu7tCeK4fTg1Hpf3y61oGnGHYJ6/1iOCvKt4jLT21L3IFWWGO
	JxrA9EYZ0TnM7/hWT25e4q/F8PcP+gRIWU7/S2fugbhWU2K6Y/BkRt3yk281J2gc
	ZhmTrugp1EV9bo3gq8ZQjjMDc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCnw8cKt4JqOAFhQQ--.29595S2;
	Mon, 17 Aug 2026 15:23:55 +0800 (CST)
From: Chen Changcheng <ccc194101@163.com>
To: jeffinphilip14@gmail.com
Cc: bentiss@kernel.org,
	chenchangcheng@kylinos.cn,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	ccc194101@163.com
Subject: Re: [PATCH 0/2] HID: corsair: fix two use-after-free bugs on device removal
Date: Mon, 17 Aug 2026 15:23:54 +0800
Message-Id: <20260817072354.139154-1-ccc194101@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260815181223.686663-1-jeffinphilip14@gmail.com>
References: <20260815181223.686663-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnw8cKt4JqOAFhQQ--.29595S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw1UJF4kCw48uFWxtF18Xwb_yoW3ArX_ua
	9293Wakw4DGrs3K3Z0kFWjvFWkWa1xKr17Wrs0yrn7K348XFZ7Xrsaqa1Syw1Sgws2v3Wx
	trySkF9093y7KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUQBMPUUUUU==
X-CM-SenderInfo: 5fffimiurqiqqrwthudrp/xtbC8gsrCmqCtws2WAAA3i

Hi Jeffin,

Thanks for the review and for the pointer to the syzbot report.

You are right: led_classdev_unregister() internally calls
led_set_brightness(LED_OFF), which reaches k90_brightness_set() and
re-schedules the worker after cancel_work_sync() has returned, so the
work_struct can still be queued when kfree() is called.  This is the
issue syzbot reported (extid=0a031a76585d1c7e737d).

The follow-up patch below makes k90_brightness_set() a no-op once
removed is set, so the LED_OFF update from led_classdev_unregister()
cannot re-schedule the worker after it has been cancelled.  It also
applies the same cancel-before-unregister ordering to the probe error
path in k90_init_macro_functions() for consistency.

Thanks,
Chen Changcheng

