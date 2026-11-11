Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.255.198.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367317;
	b=xmSwj1VhtmYG1URS8aP044Zcecwx/ZwhJvsCwN20h5eASS827UxWGNErVurKmNcOye/I
	 BZZOwIW1yPzbbda1r30uHcdmg97P8OMi0GKsFhyVR09K2beaznvOqLaNtud0Yn6vmuYKg
	 Ggby6QlgyEMThPKgsNlldLa64xHCtLyDfKoV07G38jELvYvLDEdeznrIAepGdfHqaxUP/
	 5+64681Fjjtg6NLVeMtgGrEocZqgUtMYy6MbOEWtfTtsfUX/Nle47zUqwLzNyITZQ/8Xk
	 FFDiTSd4JRtC3TMdgVM0DhLMmocIT+f3z7J5ReTCkBXYia/WvZgABQDQ2eDcwRTy5AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367317;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=xRgSWDpjE8xBjvUslQtDw7piraYXwlb85ckzRO7XchM=;
	b=v68En3AZjX+1nGJeqG7SX/Y9Zl6kAWeS/kfeARtQeTN9zHrZrC8n0lAIbmVQFxKdILU8
	 hoH7iyetoq1jcCzokcq9QDVoLhpUOiNhlHV9kTOaBvhZq1xp+xB8hyjtQsA6u1bwXMIcB
	 DvE1MpP7RoXeY8ZzuXiZ/dTZLBYLvC6EyX8HEUICSwFPhVjQ2ZcIX31eeCeDmKxifwoRR
	 N8oJCOtcOjNcNUZ8S8NAVb7c0vUckhbc10HoBofulbFBl3FwpAXIKmqonjflFqzK2txl4
	 DGS2WacMGnQfvlWUeqZb/RjQkRX/lXwvedmP/wzZNqiu6Kh5haKzQuwFq+mNcbaWnbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=endrift.com;
	spf=pass smtp.mailfrom=endrift.com;
	dkim=pass header.d=endrift.com header.i=@endrift.com header.a=rsa-sha256 header.s=2020 header.b=FV6wvRUB;
	arc=none smtp.remote-ip=173.255.198.10
Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8D260A2618
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 03:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A8D260A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=endrift.com header.i=@endrift.com header.a=rsa-sha256 header.s=2020 header.b=FV6wvRUB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1794367310; bh=NjTYDVeWqjqsLD96ZMaOjaXin2VXC7+Xya3LKXfquDE=;
	h=From:To:Cc:Subject:Date:From;
	b=FV6wvRUB66xSy98b0du+zoAVlx5EyGUmXt7YQgNa2nvDMOJ3wDoO7zG6wduddnBkp
	 gudXKP07sAoINAahuZv5Wg4WFCFuuDUou4p+DzTWHb88R4EWWpZKPYIACYIK44zji8
	 ZkI2xTTqgF33gWfciuu7/Asp2L18WEOoj3J9U0RMupdyDnaOjObmZFkdEVziV7gnYe
	 ePiL3PsR5c8fGaGf37PfQnsSfsOwd2wq6g1V1lAgSOQn7ClqtBEGWcvCZp7RuaMpMT
	 Z/+V3UtoYwzmQq/6WRnXURTvEuwHRNJQNBWEnxlTpZd4jjwj44O6oCGcBwZkJ3w8vD
	 pJgqIvMh/VB0w==
Received: from microtis.vulpes.eutheria.net (unknown [97.126.138.172])
	by endrift.com (Postfix) with ESMTPSA id C8731A021;
	Tue, 10 Nov 2026 19:21:49 -0800 (PST)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 1/2] HID: nintendo-switch2-usb: Fix potential deadlock on teardown
Date: Tue, 10 Nov 2026 19:20:31 -0800
Message-ID: <20261111032125.2888320-1-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
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

As reported by Sashiko, there is a narrow window in which cancel_work_sync
on the message in work can block due to the work waiting on the mutex that
the canceling thread holds. We work around this by replacing it with a
non-sync cancel and a sync cancel later on, to ensure it's actually exited.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/message/20261006063000.A0B821F000FF%40smtp.kernel.org
Fixes: 9417132df63e ("HID: nintendo: Add preliminary Switch 2 controller driver")
Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-nintendo-switch2-usb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-nintendo-switch2-usb.c b/drivers/hid/hid-nintendo-switch2-usb.c
index 8b3b6841035d..d747000336dc 100644
--- a/drivers/hid/hid-nintendo-switch2-usb.c
+++ b/drivers/hid/hid-nintendo-switch2-usb.c
@@ -217,7 +217,7 @@ static void switch2_usb_free_in_urbs(struct switch2_usb *ns2_usb)
 	ns2_usb->shutdown = true;
 	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
 
-	cancel_work_sync(&ns2_usb->message_in_work);
+	cancel_work(&ns2_usb->message_in_work);
 
 	usb_kill_anchored_urbs(&ns2_usb->bulk_in_anchor);
 	for (i = 0; i < NS2_IN_URBS; i++) {
@@ -276,7 +276,7 @@ static void switch2_usb_shutdown(struct switch2_cfg_intf *intf)
 	ns2_usb->shutdown = true;
 	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
 
-	cancel_work_sync(&ns2_usb->message_in_work);
+	cancel_work(&ns2_usb->message_in_work);
 
 	usb_kill_anchored_urbs(&ns2_usb->bulk_in_anchor);
 	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
@@ -447,6 +447,7 @@ static int switch2_usb_probe(struct usb_interface *intf, const struct usb_device
 	switch2_usb_free_out_urbs(ns2_usb);
 err_free_in:
 	switch2_usb_free_in_urbs(ns2_usb);
+	cancel_work_sync(&ns2_usb->message_in_work);
 	devm_kfree(&intf->dev, ns2_usb);
 
 	return ret;
@@ -466,6 +467,8 @@ static void switch2_usb_disconnect(struct usb_interface *intf)
 		switch2_controller_detach_cfg(ns2_usb->cfg.parent);
 
 	switch2_usb_free_out_urbs(ns2_usb);
+
+	cancel_work_sync(&ns2_usb->message_in_work);
 }
 
 #define SWITCH2_CONTROLLER(vend, prod) \
-- 
2.54.0

