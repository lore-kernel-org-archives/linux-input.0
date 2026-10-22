Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676392;
	b=cJpjS9MP/LMjVSkKqil52YfE0kDZUmlOwMzMdeCFdJjGYNH0rbc6LvpDThCJSEbAonME
	 to7XKT53upzkQHHU34WR8LOsPYxMs7QROBLYlM3HVUUO7Q//mSxJnuSJEG2If5RqOSThg
	 nZY4fw6wkjPojnO5DNQ4w+9ZzEJatksvIvlhRufgLx2ty3Qs6kmkw0GBOkU3O749xnsH8
	 bpxvcp3VfZGHxKPqJUqVtjL45YO8oILLRu3ugUSB+XNHt92Lf5EL/Akx1Zt+qxzMlxFKP
	 04TLj9ZE+z0HhnFJ3uoVsbMIFn/KaL9Ogc9qvZmLcdhliKJJAw8V6iXVEoG1DLKHP+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=E7ldbha61mP8s1NIQkWTBtWS7iGHbMi8BBAljC+krWo=;
	b=pmOoAnoV42pgJ+WLciIiZO0mPYR5vPBiIvppAJa6kPTcG/2SPKVCKeRgF2EPKmQvp970
	 7RnVgghCUF56CV+EgH5oeCNTaEL7Q3mGv5gVep0wf21ExqBGA6QLJGHR/RiKVSz4JWM3m
	 RbyqDuvGqbj63YOcS2LoAsUecYw8nK16E8dyQwe37jLYY2euORbYoG2WVN2IAz9iOY+jT
	 U2oqBZeRo6rfXEcy99wBSV9FeOp0DZft9uUVEpxbpr3CBalFQkz5AHdkKDZObFPxJmR3V
	 rhMY+7re9LAtCGtL5AdNNPOiguvKvhIV5/nuSPnSxG6+KqhyT5Y755GY1mM4vKumL7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--korneld.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uvCDJ9yQ;
	arc=none smtp.remote-ip=209.85.218.71
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47194606A31F
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 13:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47194606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--korneld.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uvCDJ9yQ
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c3a4da6437bso185573466b.1
        for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 06:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792676391; x=1793281191; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E7ldbha61mP8s1NIQkWTBtWS7iGHbMi8BBAljC+krWo=;
        b=uvCDJ9yQLoNKcbIxMgOplqnLOfad0D6J8m+YUxNVf3H5Mfc9TprbVTHr+jQX2Ar3AE
         sdaY6nVKaAfWO0UPgVztBH3+vsQi2eWmkRjsw0XJv0MvcB2rgYM0+71yV9PcJqtmXK/0
         Do5dwnnxBkug7NintG8UB70bbzlmy+MmAm0NTHpeGP5kRZUTI0AEw8npCinudlFUMir9
         m/gTmku3jR6bi94Cw4RnsQ8mGEFoGL63GvxfFRxN6CMBB8vZYh0rxbGJ6KDKUcsPzG4W
         tbi/3h0ShbLGt7nQqjw+CWMczXzK/7YE2pmIUV4kfDWAHhKkXop2wQIfwODlkBov0rce
         pQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792676391; x=1793281191;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E7ldbha61mP8s1NIQkWTBtWS7iGHbMi8BBAljC+krWo=;
        b=qLrW71dOti+wkdjMyRKY8YZVRmVE0m6avqQFV+RArmRNtijgpDbwLpOPH5JglRyWLL
         fKIyg3cKJK6I/mREoYp9buhAvmBgXk1D9bWA78fd4pjokuldzHwzwpioQEjnXpCzG9hX
         l34e3H55Gztyfh0wcubdJoAdqFg8TYZJfrhGuJsW4njziCHmnGH6xu64C3+47OvDU3gc
         wgdLwV2bftonIIvFAPtI5dLDXVT3aUlAIhHcYbeIr3xB9A/f+hcC1Meh4A0r7ffAW+Hb
         yWgee2f5DDf1YYfBJPy5e/k365TWKYpepaUvkUcsnSQa6NVSfKDkZN1fMx4fSe18hEBF
         2H4Q==
X-Gm-Message-State: AFq9FYJLq7ujvyxJd4f0KMX70xNb+Uha/LzMQ3s8mqq9AA8iGtS6oqUX
	rkTlOxcKXs2kxVWiL7mMB5lF98MTHmgJDxs0A61AtmJ6IV7sM7B9U/FaOcmILzReJgujnIFFvzl
	TI/WPa0vbYg==
X-Received: from ejhf27.prod.google.com ([2002:a17:906:2c5b:b0:c3f:eb49:ea45])
 (user=korneld job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:3da0:b0:c40:6ed9:b961
 with SMTP id a640c23a62f3a-c467917493fmr570354366b.5.1792676390076; Thu, 22
 Oct 2026 06:39:50 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:39:13 +0000
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
Message-ID: <20261022-evdev_syndropped_fix-v1-2-b5400740e1f7@google.com>
Subject: [PATCH 2/2] input: evdev: Read clock directly in __evdev_queue_syn_dropped()
From: "=?utf-8?q?Kornel_Dul=C4=99ba?=" <korneld@google.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?utf-8?q?Kornel_Dul=C4=99ba?=" <korneld@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Currently, __evdev_queue_syn_dropped() calls input_get_timestamp() on
the underlying input_dev to obtain the event timestamp. If no timestamp
is set, input_get_timestamp() caches the current time and returns it;
otherwise, it returns the cached value.

There are two problems with this approach:

1. Locking. The timestamp is obtained in the same way in
   evdev_events(), which is called with dev->event_lock held. Calls to
   __evdev_queue_syn_dropped() are only serialized with
   client->buffer_lock. This makes both accesses likely racy.
2. If no timestamp is cached yet, the subsequent hardware event
   generated after __evdev_queue_syn_dropped() is called will receive
   the stale cached timestamp.

Fix this by reading the current time directly based on the value of
client->clk_type. Open-coding this is not the prettiest solution, but I
couldn't figure out anything better.

I initially thought about fixing this by resetting the input timestamp
in this function instead, similarly to how INPUT_FLUSH handles it.
However, I decided against it, as that would require non-trivial
locking changes.

Signed-off-by: Kornel Dul=C4=99ba <korneld@google.com>
---
 drivers/input/evdev.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index c6da2601480f..da7396c19188 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -145,11 +145,18 @@ static void __evdev_flush_queue(struct evdev_client *=
client, unsigned int type)
=20
 static void __evdev_queue_syn_dropped(struct evdev_client *client)
 {
-	ktime_t *ev_time =3D input_get_timestamp(client->evdev->handle.dev);
-	struct timespec64 ts =3D ktime_to_timespec64(ev_time[client->clk_type]);
 	unsigned int buf_mask =3D client->bufsize - 1;
 	struct input_event ev;
+	ktime_t time;
+	struct timespec64 ts;
+
+	time =3D client->clk_type =3D=3D INPUT_CLK_REAL ?
+			ktime_get_real() :
+			client->clk_type =3D=3D INPUT_CLK_MONO ?
+				ktime_get() :
+				ktime_get_boottime();
=20
+	ts =3D ktime_to_timespec64(time);
 	memset(&ev, 0, sizeof(ev));
 	ev.input_event_sec =3D ts.tv_sec;
 	ev.input_event_usec =3D ts.tv_nsec / NSEC_PER_USEC;

--=20
2.56.0.307.g5fe7bd680c-goog

