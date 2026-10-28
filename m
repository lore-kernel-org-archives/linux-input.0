Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793186344;
	b=dZMp5IF7eBCXIKxpyAdj1whnAEMUatJPffD9rZKkpfAlK/7P2Zbe0jUsF2Vxa8yKgfsf
	 CWhYnxZlJWewOLcmL5PyZjCVg/JJLWJJHiKGxSOv69Gybhe1v7uxOTVNQDO8ntnxi+3kW
	 BcqxdGTd5UYCVvm1n3nS0TTZa9GhMLn8+9Ppbd91S9bGEZsUzichXjsah9g8WhyPnkjeg
	 8cZbc4obigHnCM2YrQYmbJ/g8RRKN8S7+dZh3tOz36krlEvpVveASrpCzrHe0WYfEOmJY
	 jiZvpjUsWPvbXB+upBG3dnVlQcDSe+/IvViI0XesnyEYDthceTPJrl+5x3Eiwp4caAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iMMtJqFO/Qle89nnsy9oUzaGg14r9OuaMM5bIBVnCI4=;
	b=bPq9+GNrBBl9bfTSKWcToMzd18bhmreeolAQ4P87kgUJNbIPQMWydLSyGfr+D8qFZuqb
	 dJJ85d5bvSVTscUS5v0mSmGgyK1THGpAxSqdhZBVSikgMoCEDL9wl1TYiFhAqxOz9GSQJ
	 oCPL+/rELrLj3++t2B3yAG4hoEjy0xPPv9ZKWebbgzYaN0iFCDmvxJaYPCXqv9/32Iv+Q
	 7N9TKu4jQRn7DRZPVbRaOChBenrqc9Rtcpx9SYDJZCkA8hzhOO0KXARxya8kqiK/XVHh+
	 xpc9MC+VOkbQVRhL28McYioihL8b1eOWfOFi6mHvOVzrCdgSbYKVPyCycZklvHH917Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nkwwcWkz;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C35606A31C
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 11:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73C35606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nkwwcWkz
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so7811585e9.2
        for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 04:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793186343; x=1793791143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iMMtJqFO/Qle89nnsy9oUzaGg14r9OuaMM5bIBVnCI4=;
        b=nkwwcWkz8TNjDDmqiqeh7iSi35qTG52KVnUwUyq3juIbScLJ+AtgE+8FpSs/GrwfpN
         aaYgGMgKgdVnCVpZQTBxWLF3VC8m5QYDm2bXhQ1lVFBng4sAITE/w0CLACbT8n5a0PQ2
         CSHfNFcARY6Nzomg2KFE9o6jE5LtssDHcXRqweXtbMUBkwrj4DWYMz9lLHPQfXhF5fzr
         HemaxwiRGYR6CzW5RVtAuDQcjWbeGwkh7z3cuZBdOxdNWengtMra9XmmmskQCRjHbgzO
         OK+kMJ75s3nSSWdUpJVK66MkJZsblOh3pbSBI3ACJOzC0kaJwTu8CUS6XpuZgWgPNBf8
         E9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793186343; x=1793791143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iMMtJqFO/Qle89nnsy9oUzaGg14r9OuaMM5bIBVnCI4=;
        b=Q4WgMuiBBqqBdMPeEUqceMiiNjkQCW4PmvbH1kRtU47byPVx/Wps8SBXarE5qsL/sK
         Yf0jso2lQfLELV3TSISbuLQMfNMMb2nKGaaBmZe89dQA3eykq/O5EfZBU+k7Ke9Q1Med
         9bj2gFlkOLKkVcF0SkXd1Y68Rx2Is3FSPrAH4c9lF9Bge4rtXQs+mL2qiVK3/Gh3FKlF
         QP049CRZuXjs7767uqHNStCwqwqt+HcaCiLgliSZtcggSsCzof15Lgekr6dRSyl8CfdG
         8Dg+F1yKnG+Y0FKZHicQenRPldfYJdyQBSsunPyzwhCeWtIZ7or/QP0JNFBqA4a0Xv1n
         Etqw==
X-Forwarded-Encrypted: i=1; AKwUvBwTwFMWvmvaVMwXzXSzgy/CPUXJVkcI5b3Lzsf8lQvK4fchSYZl44FqALg460Y1Lfl+UNcNYRjkIlDe5g==@vger.kernel.org
X-Gm-Message-State: AFq9FYKi0IM4ORRwMq2w8GGLORWX00f1ONrG/X0wtGod5PskVbJ+ei1h
	y2weLC4/wZTKWRIF5syr8rZON3IE8ALF28wowe8aTsp5T1CyTNtB+wfAffCx/w==
X-Gm-Gg: AYBFou3K4SDJalRDSVSVFUX5WS1ewN7nO+fI6eBj6JUSlltIkrZA8Gtjew5/rX4C8iy
	DTmnU++K2HUXctmThd0SmVAfeGnrpyJPaFU053p4UxbvDxYq5axETp/UO6tJ++JmcwKQvAj4Yfn
	qO4Uy+RjTQjlEneemzrNsfXQSLh6nNjWOR9rY3oEzF3vCNrpMNUnB/ZwbV6OZWlqf65A57gjm9m
	aNL03KNfH854XJDChfBFj8on4anpTFtVD58RXIdduIjoHH+fyFIZnFyTgE+YQJ8ZUia0mm+OMbz
	45sXFJsM8+lTzEY3VG6hcGckalN+c96qIGKWkj+5EVRH1XVp0T/rizlEjIyeTMPd0GmaVoBl43H
	O67dPPNtvwdlJg/is3I72eNNKNzHecgVj5q2meE4uC/+k2Y8prbXyHE+Tz0ejGdZDuqplJ0joGJ
	C1VXznxuef2PLBFgr9zrbPeVfsw1uqFRLnyIcV2Gqb/jDoB5Xezvz/A1AyQLY4hXvP74tMbairD
	F/llYHdUQkrpKV7Ml4EkWaYCLVUaig9AUEFs/99okrViPzeoKdNbKcXZxmGv8OUsqnkkbj8LeCN
	Ze81QhXsS17E5hnKtg==
X-Received: by 2002:a05:600c:46cd:b0:4a1:ddaa:571e with SMTP id 5b1f17b1804b1-4a96695ec9cmr36091795e9.15.1793186342385;
        Wed, 28 Oct 2026 04:19:02 -0700 (PDT)
Received: from fedora ([2a02:587:85d1:a500:5135:1deb:a9ab:fb3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a978d57b39sm64197635e9.10.2026.10.28.04.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:19:01 -0700 (PDT)
From: George Karagounis <taterraster@gmail.com>
X-Google-Original-From: George Karagounis <mail@taterr.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mail@taterr.org
Subject: [PATCH 0/3] HID: Replace deprecated create_singlethread_workqueue
Date: Wed, 28 Oct 2026 13:18:50 +0200
Message-ID: <20261028111853.22429-1-mail@taterr.org>
X-Mailer: git-send-email 2.56.0
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

Hi maintainers,

This patch series replaces the deprecated create_singlethread_workqueue()
with the more efficient alloc_ordered_workqueue() in three HID drivers.

WQ_MEM_RECLAIM is added to ensure the workqueues can process hardware
events under memory pressure.

All three patches have been compile-tested with W=1 and produce no warnings.

Best regards,
George

George Karagounis (3):
  HID: haptic: Replace create_singlethread_workqueue with
    alloc_ordered_workqueue
  HID: elo: Replace create_singlethread_workqueue with
    alloc_ordered_workqueue
  HID: logitech-hidpp: Replace create_singlethread_workqueue with
    alloc_ordered_workqueue

 drivers/hid/hid-elo.c            | 2 +-
 drivers/hid/hid-haptic.c         | 2 +-
 drivers/hid/hid-logitech-hidpp.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.56.0

