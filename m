Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676390;
	b=eO8aOBoLRES57OGUJ8sy1Psjr6XEA/uaIpZA258lrMsm7StY2Ver8ZzUVqm6Zi8Y8aTI
	 XvVgsHuIkOdyjzjU5PYNsPy/bmYgr8ccpL3SLG8tvvmOE9VQZcDhBJ4d+wzmGdUMWSIvI
	 aaeiv61NhFNmuK9JWTPZDDWWi0++ZkaPUXDBzE2d/FHgVcSfztK8yffhAfkZq8j+qvyyc
	 CT/7F/WD6f/UYWPPtGaKvU+SBcfAsx3i7B7Qou8Fruk1dapO20UMJg7/1HWCaqWlEGr7l
	 XJ1b/Zdw64s8ks0mWaSObX63TfpIurRsYvE4wJscYwqaGpVHcGRFchf9ncWudKMCIAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=iS9Ptv4gJD9ISiPFn7gETnJRBJhb+zthiQ0gRNLw8KM=;
	b=XJp+hz1HmsSxLbxbnIRSxDYs/r07AchL+vE9mCB2ChuMP5fiQGZv1vUNw+YEWxMjIN4V
	 sShj0I4mq0Y4QCIb5mf+iPnn8Vfc8a47kOyPX5p3JY1iXMaaCld+/oeir9wJ3OQsJdWbq
	 0ivsZsbuSMWfcO8n6spXFXvc1S/tWiQ5BJUyOsj2z+QnO9lEBG9StC6O+ftR5ZJr1J7BC
	 b5S9KkDE9z8BCnwL1NU10+bfzKX/CelT33i60KKz4XwlqTogYSNYjE2HhjYrX/WY10HTe
	 V1owUJCs2SzwuXvYq7+0RdIlDs2n6eWMcqEFi79l/y+LgQn1w6RmG/4+CmJfI0i0HtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--korneld.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ntUxXo4C;
	arc=none smtp.remote-ip=209.85.208.69
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11384606A31E
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 13:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11384606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--korneld.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ntUxXo4C
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6b1d818b501so2330515a12.0
        for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 06:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792676388; x=1793281188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iS9Ptv4gJD9ISiPFn7gETnJRBJhb+zthiQ0gRNLw8KM=;
        b=ntUxXo4CAIFgiTl+mB+ZQdJMfe1A/Zpa0HXlouJZsfldUSvRUHoLlmgO2NUE9Yn1Gp
         ZTDquvLfsKpKmSH/HQ+h3gQP+ATKihzsrU0GYcDOUAvtR0G23gMc9OhtK+N+bAVAVdIA
         FJAFfnmGXk4NnMmhswVWoPmwZwesAatpNQcaX9hLgyuXMjFVWv7ZxAlOHGULca1GEhlG
         w1wnU6RMDimY+XhTpUBSaz7Gu7hByE10cz398aIcwj+VAz6zOiSnMVA2Rn5SbuC9DXQ0
         oIcMrPSDmqSl+EMGv8LkiO8lf+GQ0Wr4/7hlPjxELTyXn0l2ZUakB39nNh/Pgdh4iWF9
         1l2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792676388; x=1793281188;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iS9Ptv4gJD9ISiPFn7gETnJRBJhb+zthiQ0gRNLw8KM=;
        b=kEHdFAeTdzezQbd2hsgMGBP0H6RrLGNsP2HcUutPCPTjMjUsvEkj/VQdfXiPvpCGdD
         nqoXyobONLZT4EQ6Ao+rwxScD+SKaUtEhBQ31U/3HHsLcb2naQ//1zq6QmZtCDE2ECe9
         ngWMRFoVhURZ6WECzeVMy5k7Z1JsXq5O4uwZrgfBDB0Pd9MsK8dLCZ+C02DKuVO2IU6C
         MHs4GaT5qIomkK1sV+sbWQBFumGCch6Wesjg7E3QpqMJj1cNWO+pqfyasg+L+tfOOeWV
         u1JKR28uuKYHwhZsLcosgoUoS86MvcePB3oN2gkEUTfJ5ciWj7VEWtpq5m0cknhVtSY9
         aNRg==
X-Gm-Message-State: AFq9FYIM3rl+h8PJpgLlBh3yqaZnGsbgqaASeiKdJRoBIbH9zRTNLd+8
	K4fA5tVuTo6NxkbdVR2ng74BH7move20HHeye/RMvMaTLMhNnI2tNB8Rc0Jxuc/JxNgJCLlILq9
	l/22uYGK77Q==
X-Received: from edrd18.prod.google.com ([2002:aa7:d692:0:b0:6b4:1721:3ad7])
 (user=korneld job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:1d53:b0:6b3:c434:b8e9
 with SMTP id 4fb4d7f45d1cf-6b41bbb061emr3468614a12.9.1792676388370; Thu, 22
 Oct 2026 06:39:48 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:39:12 +0000
In-Reply-To: <20261022-evdev_syndropped_fix-v1-0-b5400740e1f7@google.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022-evdev_syndropped_fix-v1-0-b5400740e1f7@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20261022-evdev_syndropped_fix-v1-1-b5400740e1f7@google.com>
Subject: [PATCH 1/2] input: evdev: Always terminate SYN_DROPPED with SYN_REPORT
From: "=?utf-8?q?Kornel_Dul=C4=99ba?=" <korneld@google.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?utf-8?q?Kornel_Dul=C4=99ba?=" <korneld@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Per Documentation/input/event-codes.rst, on SYN_DROPPED:
"Client should ignore all events up to and including next SYN_REPORT
event and query the device (using EVIOCG* ioctls) to obtain its
current state."

Currently, __evdev_queue_syn_dropped() queues a standalone SYN_DROPPED
event without a terminating SYN_REPORT. This causes two issues:

1. The queued SYN_DROPPED event remains unreadable until the next
   hardware event frame arrives and finishes with SYN_REPORT.
2. When the next hardware event frame arrives, SYN_DROPPED is prepended
   to it in the same packet. Compliant userspace clients then discard
   the entire hardware event frame up to its SYN_REPORT.

This was discovered on an Android system with a gpio-keys backed device:
1. gpio_keys_open() reports the initial state on open().
2. Android follows open() with EVIOCSCLOCKID.
3. This creates an unterminated SYN_DROPPED, causing the subsequent
   event to be discarded by userspace.

Fix this by appending SYN_REPORT after SYN_DROPPED in
__evdev_queue_syn_dropped() and updating client->packet_head
accordingly.

Signed-off-by: Kornel Dul=C4=99ba <korneld@google.com>
---
 drivers/input/evdev.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 8bfaaa45e0b9..c6da2601480f 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -147,6 +147,7 @@ static void __evdev_queue_syn_dropped(struct evdev_clie=
nt *client)
 {
 	ktime_t *ev_time =3D input_get_timestamp(client->evdev->handle.dev);
 	struct timespec64 ts =3D ktime_to_timespec64(ev_time[client->clk_type]);
+	unsigned int buf_mask =3D client->bufsize - 1;
 	struct input_event ev;
=20
 	memset(&ev, 0, sizeof(ev));
@@ -156,13 +157,24 @@ static void __evdev_queue_syn_dropped(struct evdev_cl=
ient *client)
 	ev.code =3D SYN_DROPPED;
=20
 	client->buffer[client->head++] =3D ev;
-	client->head &=3D client->bufsize - 1;
+	client->head &=3D buf_mask;
=20
 	if (unlikely(client->head =3D=3D client->tail)) {
 		/* drop queue but keep our SYN_DROPPED event */
-		client->tail =3D (client->head - 1) & (client->bufsize - 1);
-		client->packet_head =3D client->tail;
+		client->tail =3D (client->head - 1) & buf_mask;
 	}
+
+	ev.code =3D SYN_REPORT;
+
+	client->buffer[client->head++] =3D ev;
+	client->head &=3D buf_mask;
+
+	if (unlikely(client->head =3D=3D client->tail)) {
+		/* drop queue but keep our SYN_DROPPED and SYN_REPORT events */
+		client->tail =3D (client->head - 2) & buf_mask;
+	}
+
+	client->packet_head =3D client->head;
 }
=20
 static void evdev_queue_syn_dropped(struct evdev_client *client)

--=20
2.56.0.307.g5fe7bd680c-goog

