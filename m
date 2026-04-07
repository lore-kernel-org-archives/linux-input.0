Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6083A3802
	for <linux-input@vger.kernel.org>; Tue,  7 Apr 2026 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775548243; cv=none; b=FuLg2kSXDLvvKiS7bQ3jvzhwemNxV4o+rqQ3eWMGSXIEldsgfSZIxMVWN3WY3ymWtxrkh4HveM36bCHtFxyaqO8huqBQ0+bF5TLZfd/c+dDyReZs+4NsPUKg/WP93taPVj6MsulWWSY1SpLmba1hZNAjlls3mLEWM9YLttM8EZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775548243; c=relaxed/simple;
	bh=IdWuS85toG2XB88l83aLIKH1J6yNHDj+tjm+o0igdrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ISuSULMOhJ9UFVyMfVl/i+GZdk7qjEou93aq2aQXJobnux5HwkCoxwU9XT5hTDJbC7XkMR5FPmRrzqL8gflfoij99ghpKW2ukN45Y+THv3dFeOuqEGlNGMmQXGVF/yRJarKE7KILulgAZX0j6Bf9pWahkQK06sf0pyeV3fx7pd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G13xeWcv; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G13xeWcv"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38c620f1699so50534641fa.0
        for <linux-input@vger.kernel.org>; Tue, 07 Apr 2026 00:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775548240; x=1776153040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=unfP0Io+eWCdwZ48Sql8cCkVMUb4bc5MzgzrzSKUpi4=;
        b=G13xeWcvZFDw0Xh+1xVbLWgukSCj29I1HQmfZwONtjQXufSiiADJ9iUV3YXk0vO4IV
         ornxOYJWZ83+XzxCSA4JL0WUi09uji1QYpJ1uvEknMa3qAJjAQpLTtbpJ+CaAVKPB7/m
         hcllfU6GaJm0cuAuTTHFdAIbmpyQ/7LZHJEcmpKW6wdQo1xXOmT8EGCdj/V347TH0rbc
         5SJR09E75Nwk/2kX43vEX19J01p3fS6BRSSz49alF6EWTXxTkC2DYQLvTRTTLdSigi2N
         q20/p700y83oKypb9mY0PdwxxfmwZY+A4J8QxAKGbQf2x7NJBsvbHsp4vRf2OR+TROlH
         ADjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775548240; x=1776153040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unfP0Io+eWCdwZ48Sql8cCkVMUb4bc5MzgzrzSKUpi4=;
        b=FmrLSjHf0xZ5VoVrQkuwPCNQ1F+zkWsoUnPrLkuuIsScCkxqfHz7ygLFeBWDZOaelH
         yHyjEOWZ+neRn4j7ObaZReQ3IEMgZgxIAQ+VgZgnu4NXTnc+th58n8sDFp7j97Y49Bgs
         gfUlFLc8I0s0reU3Qe2CvgR5mye8ROzhYUn7WHurGQJZ8vsKz36fnL7/ZBCYB6N2J78B
         bwY5tb0SosXciKcdqHfKv5hXrVVSepTB9yPuRpYS3+DGgoL9jea/Yb6BfnEmaiQz+hh9
         Epz11HtSRZUOuv46yNNpGFo64FIR8oOwxOCYchM1mCaFeZwApd/J+vcF3h5byobAJS3M
         J7fQ==
X-Gm-Message-State: AOJu0YzCck7nHIXbP8SXJdjI3+iJvJtdiYjdrLHuxJhJARqiNS/WgGUB
	6YyQAeqpG24bsGoB19eQuGzrdSbeb3qWWeg9ugglEFX/HZhf5TStJybw
X-Gm-Gg: AeBDiet45/J299Ob62M5Z2xbIsfeS8qiqc8l0SjSv81HC9h1wch9+na/Z6OstLZHbZq
	UhVaktuea6YCf4oLg3UF0po7XpJqKCk3jzdvv5F6aNGnvJ7DHxymauBni75BfOiRA3A64BZ03ls
	dfF94jW2Ex5dAuPLx6aLGldgi2Qo7zNMkIoG85i97pCOO9jwOoqm23vGHd8oxM9VJ4HHdr6gFSi
	EF4XRuD7k0xWJpsBc6D5ZKEMfUvttWPjd0wW4EtGnuAU+2X731Mv67JgUpw9wYSzNe5SWtHKgvo
	QemjDF7RDNSz6jJuXK88Ksku7h8uOqb1PFS/7NqiwSKWARSs+bHh3akwm+afpnU02YNckyeW13I
	rQrlf9MbVB0byDm54ZMrtyq8viIa9sZlswE6FIRUVvD/sc8oS9oo60JznwiZ9LwzK0AZWmbjC67
	sOR9sC5/UlELLKDbsMN/j+dGncUy3wFe8Fcw==
X-Received: by 2002:a05:6512:124e:b0:5a2:a753:8f0a with SMTP id 2adb3069b0e04-5a337591ec2mr4435727e87.34.1775548239590;
        Tue, 07 Apr 2026 00:50:39 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6c9519bsm3960950e87.8.2026.04.07.00.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 00:50:38 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v2] Input: uinput - fix circular locking dependency with ff-core
Date: Tue,  7 Apr 2026 12:50:31 +0500
Message-ID: <20260407075031.38351-1-mikhail.v.gavrilov@gmail.com>
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

Fix this by introducing a new state_lock spinlock to protect
udev->state and udev->dev access in uinput_request_send() instead of
acquiring udev->mutex.  The function only needs to atomically check
device state and queue an input event into the ring buffer via
uinput_dev_event() -- both operations are safe under a spinlock
(ktime_get_ts64() and wake_up_interruptible() do not sleep).  This
breaks the ff->mutex -> udev->mutex link since a spinlock is a leaf in
the lock ordering and cannot form cycles with mutexes.

To keep state transitions visible to uinput_request_send(), protect
writes to udev->state in uinput_create_device() and
uinput_destroy_device() with the same state_lock spinlock.

Additionally, move init_completion(&request->done) from
uinput_request_send() to uinput_request_submit() before
uinput_request_reserve_slot().  Once the slot is allocated,
uinput_flush_requests() may call complete() on it at any time from
the destroy path, so the completion must be initialised before the
request becomes visible.

Lock ordering after the fix:

  ff->mutex -> state_lock (spinlock, leaf)
  udev->mutex -> state_lock (spinlock, leaf)
  udev->mutex -> input_mutex -> dev->mutex -> ff->mutex (no back-edge)

Fixes: ff462551235d ("Input: uinput - switch to the new FF interface")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/CABXGCsMoxag+kEwHhb7KqhuyxfmGGd0P=tHZyb1uKE0pLr8Hkg@mail.gmail.com/
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

Changes since v1:
https://lore.kernel.org/all/20260228223628.472208-1-mikhail.v.gavrilov@gmail.com/

- Use a dedicated state_lock spinlock instead of reusing requests_lock,
  as suggested by Dmitry Torokhov
- Add Fixes and Cc: stable tags

 drivers/input/misc/uinput.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index e589060db280..e24caf6fc8e8 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -57,6 +57,7 @@ struct uinput_device {
 	struct input_dev	*dev;
 	struct mutex		mutex;
 	enum uinput_state	state;
+	spinlock_t		state_lock;
 	wait_queue_head_t	waitq;
 	unsigned char		ready;
 	unsigned char		head;
@@ -146,19 +147,15 @@ static void uinput_request_release_slot(struct uinput_device *udev,
 static int uinput_request_send(struct uinput_device *udev,
 			       struct uinput_request *request)
 {
-	int retval;
+	int retval = 0;
 
-	retval = mutex_lock_interruptible(&udev->mutex);
-	if (retval)
-		return retval;
+	spin_lock(&udev->state_lock);
 
 	if (udev->state != UIST_CREATED) {
 		retval = -ENODEV;
 		goto out;
 	}
 
-	init_completion(&request->done);
-
 	/*
 	 * Tell our userspace application about this new request
 	 * by queueing an input event.
@@ -166,7 +163,7 @@ static int uinput_request_send(struct uinput_device *udev,
 	uinput_dev_event(udev->dev, EV_UINPUT, request->code, request->id);
 
  out:
-	mutex_unlock(&udev->mutex);
+	spin_unlock(&udev->state_lock);
 	return retval;
 }
 
@@ -175,6 +172,13 @@ static int uinput_request_submit(struct uinput_device *udev,
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
@@ -289,7 +293,14 @@ static void uinput_destroy_device(struct uinput_device *udev)
 	struct input_dev *dev = udev->dev;
 	enum uinput_state old_state = udev->state;
 
+	/*
+	 * Update state under state_lock so that concurrent
+	 * uinput_request_send() sees the state change before we
+	 * flush pending requests and tear down the device.
+	 */
+	spin_lock(&udev->state_lock);
 	udev->state = UIST_NEW_DEVICE;
+	spin_unlock(&udev->state_lock);
 
 	if (dev) {
 		name = dev->name;
@@ -366,7 +377,9 @@ static int uinput_create_device(struct uinput_device *udev)
 	if (error)
 		goto fail2;
 
+	spin_lock(&udev->state_lock);
 	udev->state = UIST_CREATED;
+	spin_unlock(&udev->state_lock);
 
 	return 0;
 
@@ -384,6 +397,7 @@ static int uinput_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 
 	mutex_init(&newdev->mutex);
+	spin_lock_init(&newdev->state_lock);
 	spin_lock_init(&newdev->requests_lock);
 	init_waitqueue_head(&newdev->requests_waitq);
 	init_waitqueue_head(&newdev->waitq);
-- 
2.53.0

