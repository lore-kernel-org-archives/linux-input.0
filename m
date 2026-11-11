Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.255.198.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379828;
	b=EJ7eiyNFqlw248/39VJ73aJumzMi2Fzr0EBKLjxn3ZGjvo31vl3xHPEesi/Xjar1RsFi
	 jJ+oGiIPol5zfLGVNaDFWvyvgyZDMrgpT4ppmnoaXxcUXYnyv7DqXpAoOFVZZ2nkeW2ub
	 l+2xVjh3nCe4ZIUM/lcSE2Rk7FluPnONMzdsDDnhaGsTj9kdX1EfLWTC29E/qyxI6wIQy
	 zVSKtUgFyvytKJp2CrxKNAXdTNY6kZsSeC/Uw5M6jrncn9err6AQsu1SyZQiyTLA3MjZH
	 Bwap/fJJqDTsFX3Ioyp4IRecq7SdPdAEzpAO6Gzpcs6K4Jx3RcmxA/3nCfof74+6HRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379828;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mgPrlTF/dGGd0bHTe22KvCz7Xj/Rfv22wqjUHdcLMrM=;
	b=YcaM54MMmBN6JRfGmZGFK4RHbPRfX6W8J3HneV9JXjWPPf13kCtHnUOXFBfL0T9cngsh
	 +7jS8ZSthR99jo+J0pXkFiHUEyTqrIWh5uTglUjYHcNB464eBljuPh97/3F+ZkcBBWrNB
	 OWjQCp3eWsG2NtsbTHwsfhILrtyyTw/nrtfjLoqIe3TuU9m6GXg4TZ7Pz7SnPcwc8U8Ip
	 zHRY7cJvEatTyYUANnkfjHY2aRAAhhjSljuXqQDZcHwk9NFH6X86u5jZ6TVl1RAda6gCF
	 0BNkwzLxeWUoS3VLLFxPXSEZKLB2cq02DP71hATwfjDkL2psStlhonti3Cw3whlSGBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=endrift.com;
	spf=pass smtp.mailfrom=endrift.com;
	dkim=pass header.d=endrift.com header.i=@endrift.com header.a=rsa-sha256 header.s=2020 header.b=xt6dkelI;
	arc=none smtp.remote-ip=173.255.198.10
Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FA9606A988
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18FA9606A988
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.a=rsa-sha256 header.s=2020 header.b=xt6dkelI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1794379827; bh=FNh3lgO/bQhAHi/rV+FZd7ass8KgvS0qsHJQwZ12gUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xt6dkelIYx/5lL/COEs6RYfB2bIMAdTfjWgOOK8tXiEzRh6PfI3mZ2m0dp54WDNe+
	 b/Ke9YxgEdLJIneDSKx0dX/qFV/sc1grMYaRyiEY9EgFZLSQCvb5ZgZnPboW4X5Biz
	 bTabluN2bh/l8BRH6/20baTGUhFFsgZOeoCypk91JujBWMY6xooy+7JuM7AUGIuHNK
	 ggn7XMgurqZ9PHEYL4vsc8tu+M3fgQWAvfWsbH/YmAaP3VsPbKtGTPJAJXG0A2ULvg
	 ab4Z0NFLiEKLyuJowd1/aEUjLgodgY9IdmBf8wk7iSdP9QEMMm010vAMX1RNVlgfEP
	 zPV0ZIEAEaHjQ==
Received: from microtis.vulpes.eutheria.net (unknown [97.126.138.172])
	by endrift.com (Postfix) with ESMTPSA id 3B0F1A0FB;
	Tue, 10 Nov 2026 22:50:27 -0800 (PST)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Noah Weinberger <noahweinberger2003@proton.me>
Subject: [PATCH v2 2/3] HID: nintendo-switch2-usb: Improve shutdown logic with inbound message work
Date: Tue, 10 Nov 2026 22:49:55 -0800
Message-ID: <20261111065001.3626071-2-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111065001.3626071-1-vi@endrift.com>
References: <20261111065001.3626071-1-vi@endrift.com>
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

When detaching the USB interface the driver marks the interface as shutdown
to prevent work that may be executing in parallel from attempting to use
the URBs before freeing the URBs. There is theoretically a very narrow
window in which the work could be scheduled while the shutdown is running
in a separate thread, starting to execute before the shutdown cancels the
work.

By ensuring the scheduling happens within the locked scope and adding an
additional shutdown check, this closes the window entirely.

Reported-by: Noah Weinberger <noahweinberger2003@proton.me>
Link: https://lore.kernel.org/linux-input/a2dc00e7-9cab-4315-87a4-795f256c1e03@endrift.com/T/
Fixes: 9417132df63e ("HID: nintendo: Add preliminary Switch 2 controller driver")
Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-nintendo-switch2-usb.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-nintendo-switch2-usb.c b/drivers/hid/hid-nintendo-switch2-usb.c
index 8b3b6841035d..f53cbf0a3e15 100644
--- a/drivers/hid/hid-nintendo-switch2-usb.c
+++ b/drivers/hid/hid-nintendo-switch2-usb.c
@@ -52,12 +52,10 @@ static void switch2_bulk_in(struct urb *urb)
 {
 	struct switch2_usb *ns2_usb = urb->context;
 	int i;
-	bool schedule = false;
 	unsigned long flags;
 
 	switch (urb->status) {
 	case 0:
-		schedule = true;
 		break;
 	case -ECONNRESET:
 	case -ENOENT:
@@ -71,16 +69,14 @@ static void switch2_bulk_in(struct urb *urb)
 	}
 
 	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
-	if (ns2_usb->shutdown)
-		schedule = false;
-
 	for (i = 0; i < NS2_IN_URBS; i++) {
 		int err;
 		struct switch2_urb *ns2_urb;
 
 		if (ns2_usb->bulk_in[i].urb == urb) {
-			if (schedule) {
+			if (urb->status == 0 && !ns2_usb->shutdown) {
 				ns2_usb->bulk_in[i].state = NS2_URB_IN;
+				schedule_work(&ns2_usb->message_in_work);
 				continue;
 			} else {
 				ns2_usb->bulk_in[i].state = NS2_URB_FREE;
@@ -115,9 +111,6 @@ static void switch2_bulk_in(struct urb *urb)
 		}
 	}
 	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
-
-	if (schedule)
-		schedule_work(&ns2_usb->message_in_work);
 }
 
 static void switch2_bulk_out(struct urb *urb)
@@ -295,6 +288,9 @@ static void switch2_usb_message_in_work(struct work_struct *work)
 
 	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
 	for (i = 0; i < NS2_IN_URBS; i++) {
+		if (ns2_usb->shutdown)
+			break;
+
 		urb = &ns2_usb->bulk_in[i];
 		if (urb->state != NS2_URB_IN)
 			continue;
@@ -311,7 +307,7 @@ static void switch2_usb_message_in_work(struct work_struct *work)
 		}
 
 		spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
-		if (!urb->urb)
+		if (ns2_usb->shutdown || !urb->urb)
 			/* We're shutting down and this URB was freed */
 			break;
 
-- 
2.54.0

