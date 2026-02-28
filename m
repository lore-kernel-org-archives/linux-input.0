Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2392FA0DF
	for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772318204; cv=none; b=YD8W2qwMiIFmsVZ93UUcN9E+ytz1Tv7OWwjtHQOxP8i/wW62tBfaxVDUBUldMSKSvhfpQSOkuS1QLtdKPgWA/Lqwu2KdwT4tZIssccEIyAOc1NWDN6cIBMQ0GOkDrfg4CQvXIkrxj08X8yPd//H4szfVTzSNr+XD5VOyYJeQYE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772318204; c=relaxed/simple;
	bh=1L+kj9UJcELj2WH7mBt0bzlwtqGMf+P3GMx4NyrAiKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ohi5YxtfNZ0laKfp9Jklq20nHp2SA8vsWlnyHtqXZgIn1kC1v53Z0p4TKd1zq23Cnk9bfR4iyTjYr0dAzf8ZOwDEQ46zN0CZgVSnB+y5fF0/Wtnj+IdgV09QdJ+BFVSgU3yoJ1PsXFqS4gHVYrCs4l7FGbdryJfGBBJEY8ehP2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVwLwtYw; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVwLwtYw"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-389e71756d8so52593801fa.2
        for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 14:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772318201; x=1772923001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rYNJvGhKy9IG7jqDBgfRP5oiX2ACXOEUkxj/oyltGZk=;
        b=RVwLwtYwluvKw+shu3zDLqRvawEumy8wH9uwpnwg32wWVAK2bSL2ImR9bnlUSYgRua
         qsWyZrTy+xeMqchWNRFCRL3IxfFoBb0JvXZHVhxw4SjwOdrKDqgo+Nul4nfcq7l5cavi
         /6U/ovz6oO9rX7mv+idqv5TErOJgy7esswRXS6EHfLrAjQ9h0Muz31cRO+be4iKxWi4x
         YP2bZzCxNoi6C4+8r7eWR42UFLtnBe6Kfm3B2QmDI0jRtZodaCUA2X27dhqpN1TJl98E
         XhYMa7qPf5pJvFvq8sVnNBGTDqqxKFxPuFDV1dt5jfe0P/uKOqv+YWMVTVoU/3x0Q1He
         aX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772318201; x=1772923001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYNJvGhKy9IG7jqDBgfRP5oiX2ACXOEUkxj/oyltGZk=;
        b=lG7iV0ebwWdBjItygAw5tWZ3cJE0wHwAagIQQnaeSnOCiicOeHYpt1fuS8N+SSfsb0
         n3hPZc11Cgixf9H5aUBKFFD7JWzGXWFEO0tI+dvXcz0k5cFIZboO5WiJaLiox3re8SAg
         kkCaesHaEwuSdD57/w38v6AkpR/5mHbtCgqkFyG4T99UbxGzDrif0nDxuzBrSAu0eZXb
         /KVB38B6l5KESGoRHgAp6gogq9fyzR0hNOp3NeLY+J9tXwdkPSu5fKgBKuu416XSkwpv
         st6R8A82/+R6GUo4K4DZ/oZOwuD7r6ES54k3AXezfs5Cn1qY8WsceIdlXZpngi+rzSQS
         +r0A==
X-Gm-Message-State: AOJu0YwTseAj+kal4wyjFPPoOWh+oYEs++3FILU2x5a/lCGYD07NYa6E
	oIaIQvvRbayRSdTfyyDQtw2PnjId0EZVi44NhghunEuubdJEh+7YkkabnBMWyAsthNBpcw==
X-Gm-Gg: ATEYQzyRhX3CDEL9qFL+0pj+brMpnJLa4grUGFMZm9rWrHAFIWI1386dO6fi5ZWz3pN
	noeMwKl1et+OlI70Myt/F518apo2vGq8ZBOTxkVUDDndleH+cmAuBRUZAWa6AvpWe7/smja4Hey
	SaABnWWWinwRstHcQb+cuTB8xw4o1w93M5/7nLQWtlV+QqYoipk3kVid/jPFM3FALDlaAGPNgwr
	wEsKFsivSKWI3VnoRZ+OAKygSNFYyrDfHp4UPKRYuaCILKhhb7bZdP+JkcRdGHwk4YpaWX1mmX1
	kvBcW9vtsL9FqZ1H3V+Iwp3aJkwoF7CV3KEnmUTC4qeXV/2Ni4U1D8+D/abvNa5A+EoUHy0ImLQ
	OyU2ydZc+mC6TAu3Lv1gviK4qyo4uP0Y6wJUQfsxF8pJs373HQhxdk8ohG2zkUu+uVDc4e5kJfc
	7RMERV/wX5qc06fXYfqrXClCYmEoCl92iU9w==
X-Received: by 2002:a2e:9b19:0:b0:385:9b50:91a8 with SMTP id 38308e7fff4ca-389ff13b8a2mr32846831fa.15.1772318200745;
        Sat, 28 Feb 2026 14:36:40 -0800 (PST)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389f2ffdfdasm20580881fa.29.2026.02.28.14.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 14:36:39 -0800 (PST)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] Input: uinput - fix circular locking dependency with ff-core
Date: Sun,  1 Mar 2026 03:36:28 +0500
Message-ID: <20260228223628.472208-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A lockdep circular locking dependency warning can be triggered
reproducibly when using a force-feedback gamepad with uinput (for
example, playing ELDEN RING under Wine with a Flydigi Vader 5
controller):

  ff->mutex -> udev->mutex -> input_mutex -> dev->mutex -> ff->mutex

The cycle is caused by four lock acquisition paths:

1. ff upload: input_ff_upload() holds ff->mutex and calls
   uinput_dev_upload_effect() -> uinput_request_submit() ->
   uinput_request_send(), which acquires udev->mutex.

2. device create: uinput_ioctl_handler() holds udev->mutex and calls
   uinput_create_device() -> input_register_device(), which acquires
   input_mutex.

3. device register: input_register_device() holds input_mutex and
   calls kbd_connect() -> input_register_handle(), which acquires
   dev->mutex.

4. evdev release: evdev_release() calls input_flush_device() under
   dev->mutex, which calls input_ff_flush() acquiring ff->mutex.

Fix this by replacing udev->mutex with the existing
udev->requests_lock spinlock in uinput_request_send().  The function
only needs to atomically check device state and queue an input event
into the ring buffer via uinput_dev_event() -- both operations are safe
under a spinlock (ktime_get_ts64() and wake_up_interruptible() do not
sleep).  This breaks the ff->mutex -> udev->mutex link since a spinlock
is a leaf in the lock ordering and cannot form cycles with mutexes.

To keep state transitions visible to uinput_request_send(), protect
writes to udev->state in uinput_create_device() and
uinput_destroy_device() with the same spinlock.

Additionally, move init_completion(&request->done) from
uinput_request_send() to uinput_request_submit() before
uinput_request_reserve_slot().  Once the slot is allocated,
uinput_flush_requests() may call complete() on it at any time from
the destroy path, so the completion must be initialised before the
request becomes visible.

Lock ordering after the fix:

  ff->mutex -> requests_lock (spinlock, leaf)
  udev->mutex -> requests_lock (spinlock, leaf)
  udev->mutex -> input_mutex -> dev->mutex -> ff->mutex (no back-edge)

Link: https://lore.kernel.org/all/CABXGCsMoxag+kEwHhb7KqhuyxfmGGd0P=tHZyb1uKE0pLr8Hkg@mail.gmail.com/
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/input/misc/uinput.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index e589060db280..dcb855234049 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -146,19 +146,15 @@ static void uinput_request_release_slot(struct uinput_device *udev,
 static int uinput_request_send(struct uinput_device *udev,
 			       struct uinput_request *request)
 {
-	int retval;
+	int retval = 0;
 
-	retval = mutex_lock_interruptible(&udev->mutex);
-	if (retval)
-		return retval;
+	spin_lock(&udev->requests_lock);
 
 	if (udev->state != UIST_CREATED) {
 		retval = -ENODEV;
 		goto out;
 	}
 
-	init_completion(&request->done);
-
 	/*
 	 * Tell our userspace application about this new request
 	 * by queueing an input event.
@@ -166,7 +162,7 @@ static int uinput_request_send(struct uinput_device *udev,
 	uinput_dev_event(udev->dev, EV_UINPUT, request->code, request->id);
 
  out:
-	mutex_unlock(&udev->mutex);
+	spin_unlock(&udev->requests_lock);
 	return retval;
 }
 
@@ -175,6 +171,13 @@ static int uinput_request_submit(struct uinput_device *udev,
 {
 	int retval;
 
+	/*
+	 * Initialize completion before allocating the request slot.
+	 * Once the slot is allocated, uinput_flush_requests() may
+	 * complete it at any time, so it must be initialized first.
+	 */
+	init_completion(&request->done);
+
 	retval = uinput_request_reserve_slot(udev, request);
 	if (retval)
 		return retval;
@@ -289,7 +292,14 @@ static void uinput_destroy_device(struct uinput_device *udev)
 	struct input_dev *dev = udev->dev;
 	enum uinput_state old_state = udev->state;
 
+	/*
+	 * Update state under requests_lock so that concurrent
+	 * uinput_request_send() sees the state change before we
+	 * flush pending requests and tear down the device.
+	 */
+	spin_lock(&udev->requests_lock);
 	udev->state = UIST_NEW_DEVICE;
+	spin_unlock(&udev->requests_lock);
 
 	if (dev) {
 		name = dev->name;
@@ -366,7 +376,9 @@ static int uinput_create_device(struct uinput_device *udev)
 	if (error)
 		goto fail2;
 
+	spin_lock(&udev->requests_lock);
 	udev->state = UIST_CREATED;
+	spin_unlock(&udev->requests_lock);
 
 	return 0;
 
-- 
2.53.0

