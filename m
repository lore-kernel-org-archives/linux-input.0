Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676389;
	b=aEN0LcauAS7QljMnJDxSkTSi0JO2LqtHFVh/FbnX+oeYS86YVofzVfpMbE4rLPMAoBA8
	 qp6zjl4l0r8xsEA1KdmyJIs2qfyFC7hMJDOK38yQm4ckbgrLXE2fh1OB3d1XB0KdA5zKz
	 gnvMzrInYiJl3RoCgbwMbc/2HJjj19qVg+PIxAMA5j539bMdK1xXKJg8Z5Plo90a4XGb3
	 lKloE4qcI7Z2YJpOWfLAhDxnuaobzUYP1VCaucRx2RZ60fzBuNXaSF0UII+4Ng1zEjKEL
	 9vsAE7/7150ZFoDa7JPe/Zn6JuAmvP0oOUtqE36if9hKLa8p8dMSBPFau6FnurSge1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-B4-Tracking:
	 X-Change-Id:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=PhIrUCHACphB3JfI1J33l4nIMBCZM/xcTUwZ3X7IPJQ=;
	b=AYP4L9kFSycoTeJX94juZRoLsjPe7G6NrWsKVPW8IFAEj8qv3dtDGRzVh+yS3Y/KvH1k
	 Iqq54+hCLmtZIgfKnlhChegcNwVo6EGmb1stkAHVQ4RNJ9NdUU82UyZMD65V0Is+dGCm0
	 R4Ge4zFzz6o0FyLega1nmYIa6MiZ5u7zRDbu1hbozNfr0oFMRx82P7i8cLpWcC9CS4U2C
	 tZVVze8769vy6r84Kdqo5w/jfMxSwi+TQePwn3t8OJv2yMqcOjkT242jxTeF29RCGuyxb
	 rSulgKIrL7wt0VJDEsH66Dang37aRW2QwV1IKvR1W5hbiy+K4y4G2v475bKYX39+Ydg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--korneld.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="hK9qvA/2";
	arc=none smtp.remote-ip=209.85.167.69
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33003606A31B
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 13:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33003606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--korneld.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=hK9qvA/2
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5ba402bfbc5so1358701e87.0
        for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 06:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792676387; x=1793281187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PhIrUCHACphB3JfI1J33l4nIMBCZM/xcTUwZ3X7IPJQ=;
        b=hK9qvA/2wkDz3cUz12XiUq5KIVCnZFtzrRy1aK2CJFaMKcZ0PL5Y2oLtSj8bwZiRJv
         8lSDOAiKx4LbBiPx2GC/QiBmUpw0yXDRGIVb0bWKsNdvAlXNrrRGvy3TWqXwykkldBU5
         fusQE4A3NY+RHR2IT6RuHeyVcR0OPGoft1UEx7tilvq6Id3nP/FkRq/cbF3gfH4MQJav
         uf606f6m1eE28YW7vFcPcWtKkEJZLrPKZDDrcFcDB3fhQdCvyHp2pDV/Ix8r2bJluSSi
         CgVoFCDBEA+IjcxD9zWcMSVz5oPtNia5vxKp4aH/eu3GPeiqBsybmxxojeL3cXdqTzrl
         sLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792676387; x=1793281187;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PhIrUCHACphB3JfI1J33l4nIMBCZM/xcTUwZ3X7IPJQ=;
        b=XM8tSlG65MocMUfX4dmir4MvKmt9sGNLygTPRPFL1Yk1hK0sbRyqpHXq6SyiJMHONS
         t0Kjl6gm4lN+TeCT6jVedABP8NTVu5A/wI0d78bYx9SWaNXL98miN/j0p5wKAxXGptoE
         MBD6ZBH6eGBIJkVQcRESBCpgw7v2d/EC7O9HRMzCNmEinDeBJ6whfRvOjPRcY8nY7+tB
         nnxCTIQlbrHwBcQoyULSSFr4qxtiZlQl/jvxrDJSlUF9l7jA/KFLJAYkuTuWrZX2g9Bc
         Xx+LPP1DvcBSOrUtZVN0ibYFKGI/7FEWQeUCqh67NMxKfyvroTtOrlmg3Ac5rKq/w8Jf
         TsTA==
X-Gm-Message-State: AFq9FYL6uEIKbSAFkcQTqSEFQLzHgUgBzZslrqp6o7VTQ8IAA1kI1J5s
	JDFjWxDofC0WkbTH9zr9DnJflZKjEA6GJaOtCZdtswDkSmf0tEElEuwyHqXvt7uALG+uBfx2BPQ
	TK9jna9Z8Wg==
X-Received: from lfjj4-n2.prod.google.com ([2002:a05:6512:24c4:20b0:5bc:e5bc:7495])
 (user=korneld job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6512:158f:b0:5b8:f271:264f
 with SMTP id 2adb3069b0e04-5bfa1c43ab8mr2145106e87.45.1792676387137; Thu, 22
 Oct 2026 06:39:47 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:39:11 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAP8R2moC/x2MQQqAIBAAvyJ7TsiNNPpKRFRutRcVBSnCvycdZ
 2DmhUSRKcEoXoiUObF3FVQjYL9Wd5JkWxmwRa1aREnZUl7S42z0IZBdDr6l0V2P/WC00hvUNES q+t9OcykfEjgkOmYAAAA=
X-Change-Id: 20261022-evdev_syndropped_fix-76352587616b
X-Mailer: b4 0.14.3
Message-ID: <20261022-evdev_syndropped_fix-v1-0-b5400740e1f7@google.com>
Subject: [PATCH 0/2] input: evdev: Fix how SYN_DROPPED is generated
From: "=?utf-8?q?Kornel_Dul=C4=99ba?=" <korneld@google.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?utf-8?q?Kornel_Dul=C4=99ba?=" <korneld@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This series fixes two issues discovered while working with a gpio-keys
backed device on Android. In short:

1. When a gpio-keys backed device is opened, its initial state is
   immediately reported.
2. Android issues EVIOCSCLOCKID right after, before reading any data.
3. evdev flushes the queue, enqueues SYN_DROPPED, and caches the current
   time as the device timestamp. Notably, it does not enqueue a
   SYN_REPORT.
4. When the next real event is reported by hardware, it is enqueued with
   the stale cached timestamp and a prepended SYN_DROPPED.
5. The whole packet, up to the first legitimate SYN_REPORT, is then
   ignored by userspace.

SYN_DROPPED needs to be issued after EVIOCSCLOCKID to ensure that any
partially read packet is dropped. At the same time, evdev only defines
the batched events() callback, not the single-event event() one. All
events in a packet up to SYN_REPORT are written to a client's queue at
once while holding client->buffer_lock. The EVIOCSCLOCKID handler takes
the same lock when flushing the queue. Therefore, EVIOCSCLOCKID cannot
inject SYN_DROPPED in the middle of a packet while it is being written
to the queue.

Based on the above, I believe that the best fix here is to emit
SYN_REPORT right after SYN_DROPPED.

Patch 1: Always follow SYN_DROPPED with a SYN_REPORT.
Patch 2: Stamp the SYN_DROPPED+SYN_REPORT events with a timestamp read
         directly from the clock, bypassing the cache.

Signed-off-by: Kornel Dul=C4=99ba <korneld@google.com>
---
Kornel Dul=C4=99ba (2):
      input: evdev: Always terminate SYN_DROPPED with SYN_REPORT
      input: evdev: Read clock directly in __evdev_queue_syn_dropped()

 drivers/input/evdev.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)
---
base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
change-id: 20261022-evdev_syndropped_fix-76352587616b

Best regards,
--=20
Kornel Dul=C4=99ba <korneld@google.com>

