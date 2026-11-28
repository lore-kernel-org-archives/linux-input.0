Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795863981;
	b=IhLQxBea9OXwYoDl0vJZsV3ARi14bpH2bvaWbOSxr7Vmg6lE7X7Q1K2GwAFNPDzZ96vN
	 HXeUvg54aqTTZxNVbiSH+OIz0lwHOsQsIsP654/Tq9ZqZv/7CsiByvP32pNZCroQFkJkN
	 lJNUQvIoTitRcMrGz4o9zfLnMv/S+EjYS724FAZnu7mqwY5JXGYJPp0vW1joO36z45eXw
	 Fth3wkaOkBgQkBdO6H2Tk47yDyiZy0xaqamGeYUOcqmpRMPkGSf0EqhunnKSXzYueLEH7
	 t01G+DhTfg781HYyNSujiUZFUgP60LsFkzcd3Q/vfy0XbbUvyBRWfA64cY2eS5ZFxng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795863981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hBmsLpccqSYtfeFqDArwX/Cjh8UQaY86qSPYDgJAT6I=;
	b=jaXECqd6FRl1irkjMBb3X0MQXPhXn8ufzZzx4ttsfMBj9mp7BsUtxmIXNwJPs29zMkzn
	 QSwY9LkN2tMfWzDaR770cgplyNIpQX1zG1LW+x18/tKWn5aDpSGi0pWX18swsp0h64yH8
	 UArQzZFpz9j0x3DQ43kiml6cqXMQDVD252GPMkdGTngM8UaUnVpUtpWBjjeERgkBcyRam
	 Yu1vf4ZszkvmiTip8G/cD8/OhLnH9Xe1WU8QKBlQ0EyDbc0Agm2JPc3YcnkgrRi9duVep
	 B7FGUUIVJzqduuKuIWM3OKJ/pTBo/8t5Mclcveya9l8Tkd8bP0RVobb5HRgFfXumRSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B0ajgfau;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6BF606A337
	for <linux-input@vger.kernel.org>; Sat, 28 Nov 2026 11:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E6BF606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B0ajgfau
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-386c4d2e2ccso7279460eec.0
        for <linux-input@vger.kernel.org>; Sat, 28 Nov 2026 03:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795863981; x=1796468781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hBmsLpccqSYtfeFqDArwX/Cjh8UQaY86qSPYDgJAT6I=;
        b=B0ajgfauXmNsKGAfCGeuV0oWYZhmecn9WdJJRKopeJnSAKBDGwBCvz17dNHqXuAiWu
         5ryQffGo7gIURs/1WMuZcDMpUYKHoyOk+3hPhp4h0ODWbLaKt3O9Bx73lf6HDsM/ODWd
         FGOIeI+pKYtYQunF3ECJq0OEf/49igS9Bmpl8V+PPseRFoHSlrHnfPpgif8eTz5WKKxl
         STsGOxGxJKq7neUXshXAfC9fby2dsUECpW67VcRKR0DchIOT4NgeRsq7I/N6FiUo4yAI
         Nqr8RD24fHOo/dItBTTplpEOiorQ4VLYuhgi8ebHHPh9JryV3ZpU8zlOXVAwVD300LbE
         z9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795863981; x=1796468781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hBmsLpccqSYtfeFqDArwX/Cjh8UQaY86qSPYDgJAT6I=;
        b=1ad9JutBxV45hvvE5EXWuRNAQnvkyk5oM6PWm5U0ppUyTZ7RjnLq33mQL2J1OKRykX
         QD1DX5OPdzhH4YKlLdy/HkyAJKgQ3gEsZI1qgyBfWIf2+2q1jnynamMwW1gOyTMWaDMN
         Ds7O5kYvwfiRCvSnfF66u6gSsWb7+L6/ZSe0fcghACz5We1v2s8P1KcISMyNqE1mI015
         pEWWpxm06d1BpP5eDG8c//GxE+yZanwRpT5HMOnBka9IYmclfGooANgwe05/1qHyI8Zb
         R4BDziqUJEMKz1W+cwUM3ZvqqTqjAhrBO0QXNV9nJ6jEdaxOK39MaFohfpF4za5nBLd0
         Ujmg==
X-Forwarded-Encrypted: i=1; AL+hErFL3JFFEkzKNVo9oYZyJRpYatpP1re4l4KSvwbfotqWHpiSDvJxiaurfHVLTwbgh5xQxYwtOppj0iOxPg==@vger.kernel.org
X-Gm-Message-State: APuU4Z91fLvrfMCpDm1X0MFoGYiJsNxWQRDIHVKyxQgYz92yo2IfTSyH
	Y/fed0sqVyoWZ5INKWfky3F5jYM1yrtJ9CW9Lir0d9Hk/N7jlMNIiC04
X-Gm-Gg: AZFdTZd0K/BsmSE/ytTl6jzZXn0GBwIIkukFg7YqPEzX7DUA6guPftfC//c/vYOEU92
	Fidal9NTzDRNF4UDd0Y54Z7nSZD+9xJAcXNeKV5jw8vVWv/+frOh0ZsdXmQ030lGbi+NvqF8N7G
	8E54DKDNT9iRpb2IqwQ6xuxN7aZQZ0eojOdEnLC3EO2GwEvMBlnZOm63GUqZyLR88qdaTgrW7fI
	hYH5mQAEd/He/QcozDAUz1W5iX/RUPyS2i0NJ/K6FUpSXljiGtaOqiKvCryqf5AXmOV1LIz50HZ
	ndzsd164ydWthXbKucVV4T0RowIgKiJG5gK3dJ5yHXlOi5RTq8tqTLUU33nMkNnGDPGEdT/Tna/
	jdbQcz4dEy0aG/DQ1rngi4nHrYOecw2Xy+Jioj4Z9EYjBMpqDdNckDycDS0iyWaGbg6KQ+7GT8W
	Hydzl+2tsVH2mIXWdifQ/QLhJVlvAF4maPYtQLI85oNlGFSNFh6MR2p7bqQkt6T6uYshqisRoDe
	izjlPlRj5zGvvbZH95bM8e3YbFs1cfi0zeFF3nuqA7tHOrYNOYKdQKaTWyT5xjswJAB5nVKlrgW
	q42t1bvkGun8sgB07qPW49tyaPARlqKSiNmH61uCqjGdB5ZK+2NnI+9yUItyLbkIV4k3DFVnzEs
	seLyxjlqlFLpoi8CWMqKFG6GsnedenWvKKJtBQne/occfxW/1C03qFVkt4V1LdrmPMjK9cR7A4I
	YD6+JpnIacaWN4izACtDQmgf2wtf5RlcFoA4L3OF2r/vJJ/RYPe2kfUXBfaek8QtIwQvg=
X-Received: by 2002:a05:7300:2301:b0:385:4c54:3c8c with SMTP id 5a478bee46e88-3856c0c9403mr38890998eec.1.1795863980420;
        Sat, 28 Nov 2026 03:06:20 -0800 (PST)
Received: from spark-da2e.tail8e743c.ts.net ([211.105.22.106])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm40958970eec.17.2026.11.28.03.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 03:06:19 -0800 (PST)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Jinmo Yang <jinmo44.yang@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: HID: magicmouse: battery timer makes a sleeping HID request
Date: Sat, 28 Nov 2026 11:04:06 +0000
Message-ID: <20261128110415.772810-4-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Found by coverage-guided fuzzing of the HID subsystem through /dev/uhid.
No patch is attached; I am reporting the context bug first and can test
candidate fixes with the standalone reproducer.

Kernel: mainline 7.2.0-ge46c86b19f4b (arm64, KASAN)
File:   drivers/hid/hid-magicmouse.c
Impact: scheduling while atomic and subsequent scheduler corruption; DoS
Repro:  standalone C, approximately 62 seconds

## Report

  BUG: scheduling while atomic: swapper/1/0/0x00000102
   schedule_timeout
   __uhid_report_queue_and_wait
   uhid_hid_get_report
   uhid_hid_raw_request
   hid_hw_raw_request
   hid_hw_request
   magicmouse_fetch_battery
   magicmouse_battery_timer_tick
   call_timer_fn
   run_timer_softirq

The preempt count 0x102 and PID 0 show that the request slept while a timer
softirq was running in the idle task.

## Analysis

magicmouse_battery_timer_tick() is a timer callback and therefore runs in
atomic context.  It directly calls magicmouse_fetch_battery(), which issues:

  hid_hw_request(hdev, report, HID_REQ_GET_REPORT);

Whether this sleeps depends on the transport.  With uhid,
uhid_hid_raw_request() waits for a userspace UHID_GET_REPORT_REPLY through
__uhid_report_queue_and_wait(), which uses schedule_timeout().  hid_hw_request
therefore cannot be assumed atomic-safe.

The standalone reproducer creates a USB Magic Trackpad 2 uhid device with a
battery feature report, permits the probe-time request to finish, then keeps
the fd open without replying to the request made by the 60-second battery
timer.  It reproduced the warning at about 62 seconds.  Subsequent reports in
the same runs showed failures in __schedule and unrelated task stacks, so I
classify the impact as denial of service rather than a harmless warning.

The usual shape of a fix would be to have the timer schedule work and perform
the HID request in process context, with teardown synchronously cancelling
both timer and work.

## Upstream status

Rechecked against mainline, linux-next, HID maintainer branches, including
the magicmouse branch, and lore through 2026-11-28.  The defect remains
unpatched and I found no matching submission.
