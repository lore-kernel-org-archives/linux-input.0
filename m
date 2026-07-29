Received: from va-2-112.ptr.blmpb.com (va-2-112.ptr.blmpb.com [209.127.231.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C168039C006
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317298; cv=none; b=rtQvdl6r8YEOP05+QmRtgZxOqfi+xFp/g6A4t4Yb0FoDgZQGVjS6EfNPwgNUjX0DZNQzbDBaFa9NiPaevkyBbzKnANReV9MbSu8i4f9do/MFGuOPnmPe//NqO8nXii5fEUt4QpN/jmY8XbdzB8zTJ/IQlrc0Wn7R1+bHTe+PVCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317298; c=relaxed/simple;
	bh=NcVtYa1SODLOg+LOljapuoSqH1gfvmRzOG8qgj83U8c=;
	h=Subject:Date:Message-Id:Content-Type:Cc:From:Mime-Version:To; b=c4APDIm7xIXbxRS66fUou8yXz8z3kTHZafKp7d2GVyVPU8TpdzaH9dYdxLTHk7mHLw1sMQuJkrO81ObDLjyTyoSEWJUnsO0OHbRopq2UOaS4fCFXW5e0V3LakafqGCQ4g0+6OUbzgTrpO8pWMlaXgFO7EP97I73E/1aQIaENa7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=qCSfug2x; arc=none smtp.client-ip=209.127.231.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="qCSfug2x"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785317283; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=vnNsAYs6b7ptyFZvEBrzvQEi+czUa6EJJRtKP7dO5U4=;
 b=qCSfug2xs4bF+dZG+SL7Mjpy2sNVd4Q8mpdaWpKPy6O0ai+66qKK56JWYcGwuNoNQ+te+T
 Boi6XnSxGxgQhOFTnsmnFUCBhKr5npzOemgax6WedS2X8GKrfUssC65/cjMLSMDuODP4pN
 9Px9pFsnaHxBydKdZFfbq9Oibm8lRt/JcnIsPiCnZjyQ0RGaRmj3GWZcB1R27IJ2hK4UM3
 4yVa6uJOuTt64rD43yICT/hdOsU33EZSBW54xrCqc7/Blrg2q7aLV2ouN0lPEEHNpxe+EV
 ooqK+F31edX2lqe4ylpAAl+gvkwlL7lSE4b9EdoUOlKOCk8S1rY3a9Ka3VMILw==
Content-Transfer-Encoding: 7bit
Subject: [PATCH] Input: evdev: drain queued events before reporting device removal
Date: Wed, 29 Jul 2026 17:27:53 +0800
Message-Id: <20260729092753.1596400-1-zhangliuyang.zly@bytedance.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset=UTF-8
Cc: <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"zhangliuyang.zly" <zhangliuyang.zly@bytedance.com>
From: "zhangliuyang.zly" <zhangliuyang.zly@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a69c7a1+1667db+vger.kernel.org+zhangliuyang.zly@bytedance.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
X-Original-From: "zhangliuyang.zly" <zhangliuyang.zly@bytedance.com>

When an input device is unregistered, the input core calls
input_dev_release_keys() and sends a SYN_REPORT before closing the input
handles. This is intended to deliver synthetic key-up events for keys that
are still pressed when the device disappears.

However, evdev_read() currently checks evdev->exist before draining the
per-client event queue. If evdev_disconnect() marks the evdev node dead
before userspace reads the queued synthetic release packet, read() returns
-ENODEV immediately and the queued key-up events are lost from userspace's
point of view.

This can happen on Android with USB OTG 2.4G keyboard receivers. The input
core generates the release event during disconnect, but Android EventHub 
may observe the evdev hangup/removal first and then fail to read the 
pending EV_KEY value=0 event. The framework then falls back to device 
reset/cancel semantics instead of dispatching a normal ACTION_UP.

Allow evdev_read() to drain already queued events even after evdev->exist 
is cleared. Return -ENODEV only when the client queue is empty, or when 
the client has been revoked. Keep zero-length reads compatible with the 
previous error-checking behavior.

Signed-off-by: zhangliuyang.zly <zhangliuyang.zly@bytedance.com>
---
 drivers/input/evdev.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index c7325226cb86..89bdd7a2c763 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -565,20 +565,38 @@ static ssize_t evdev_read(struct file *file, char __user *buffer,
 	if (count != 0 && count < input_event_size())
 		return -EINVAL;
 
-	for (;;) {
+	/*
+	 * count == 0 is special - no IO is done but we still check for
+	 * error conditions, preserving the historical behavior.
+	 */
+	if (count == 0) {
 		if (!evdev->exist || client->revoked)
 			return -ENODEV;
 
-		if (client->packet_head == client->tail &&
-		    (file->f_flags & O_NONBLOCK))
-			return -EAGAIN;
+		return 0;
+	}
 
+	for (;;) {
 		/*
-		 * count == 0 is special - no IO is done but we check
-		 * for error conditions (see above).
+		 * A revoked client must not consume any more events.
 		 */
-		if (count == 0)
-			break;
+		if (client->revoked)
+			return -ENODEV;
+
+		/*
+		 * The input core may queue synthetic release events during
+		 * device unregister before evdev_disconnect() marks the evdev
+		 * node dead. Do not drop those already queued events by
+		 * returning -ENODEV too early. Drain the client queue first and
+		 * report -ENODEV only when there is nothing left to read.
+		 */
+		if (client->packet_head == client->tail) {
+			if (!evdev->exist)
+				return -ENODEV;
+
+			if (file->f_flags & O_NONBLOCK)
+				return -EAGAIN;
+		}
 
 		while (read + input_event_size() <= count &&
 		       evdev_fetch_next_event(client, &event)) {
-- 
2.54.0
