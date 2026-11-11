Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.255.198.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367317;
	b=Cn/8qAwGwK1AiL1Glypfzccj8dP6wX6NKiWI5Ba7Ap1+mRcB30175wVHo1tWXooqZhn6
	 sfTwT7cC5faU6tC4KqCX+JcZ6CkTlvdAP1CjyjqvuJc5mQkEnX4leJ++GQ5V1JD7l8FBS
	 rVJLB0BJunpeTVl/+DVgxN/Z2DMHC047CkXXh/SZ9tyVJJR1Q41XGxQkBb5yuT5S+XhEe
	 nEoe2we1/OlQJvWmCtq+IG+n2mHU8KlmJawsA+vUUcT8m/+4GDDng3qUjFoCtuqB2ddyp
	 XxKFLpHd/qgyKq7UJJlTcWfwMvHBZKAhsI1A8QO3HfJALJxj+MBQ17/jpy4A1hM12JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367317;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IoaP880Ijpmh76o1qWFNI1jVvO4QyFtFlRBoi4XzgyI=;
	b=XmAjdXOySdGKxitRw8SOHGfaS5th6bftweAjXeSUAPFMEX4mZT8QD2ddkBQy1PkshJ3z
	 zQzVZU/gsDgPat3kJGC3O0tZ3GE4QG8CxtoNWoqzLpKWuxhvt4nmDsMcEIJN8RHPtq5y1
	 CmfehCMTVl4uQpks7WzNQjWfvLH44TUBgPXQta/9R7+ojwu3AtNkyeEUgUPef8Bzaa+Ig
	 VYWjF6S2Bod1AHGwbVd1Pu9dIhc3Xp7p+j65b86lr/j3Y3Nz+iyk0drIL5Ho6+qXb3Ck+
	 ytokbuUHVXKMGv3sYiuuWJ+5Ngz5k9jTZqkAO4uyEphoRs1wD5szY4VzHIYZVKQ3FiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=endrift.com;
	spf=pass smtp.mailfrom=endrift.com;
	dkim=pass header.d=endrift.com header.i=@endrift.com header.a=rsa-sha256 header.s=2020 header.b=JZ2BF7oe;
	arc=none smtp.remote-ip=173.255.198.10
Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A97760A2619
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 03:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A97760A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.a=rsa-sha256 header.s=2020 header.b=JZ2BF7oe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1794367310; bh=wq+In06zxGTGHgnaHh1KRx2uwAFelUNCDIFQ5I1pTcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JZ2BF7oeX1Wrwf8hRuI1JNsUY2DQ0/yvmA7S1szARu4xRPdN0cWWj3V0cJVBP5qGg
	 Dv4HzJBcZ2i4vGXbuDGZPxUnTrzO/9vxDwG6/SciXlRDL7V2W8Wc7UGegQlBFVJ3PQ
	 98D/x3eR813uru81jWhVGCW+dR1BovS8EY8vg+JJVotIF56JzNrxulWVW7sujrjbBE
	 KzK2L9PvwxeU7E2/aQn1C9xXnWPFvNz3MrcbeqUHInEkrpNXl+2gB1dOuSrFiZMsLi
	 VMVT5nvHvdw50fCb9GniI5eVetayk3l0rf0N1flwqXCACdi8H0QgE03y9BuRTJdK6u
	 4obNO56BrxmNg==
Received: from microtis.vulpes.eutheria.net (unknown [97.126.138.172])
	by endrift.com (Postfix) with ESMTPSA id 3AB23A0FB;
	Tue, 10 Nov 2026 19:21:50 -0800 (PST)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Noah Weinberger <noahweinberger2003@proton.me>
Subject: [PATCH 2/2] HID: nintendo-switch2-usb: Improve shutdown logic with inbound message work
Date: Tue, 10 Nov 2026 19:20:32 -0800
Message-ID: <20261111032125.2888320-2-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111032125.2888320-1-vi@endrift.com>
References: <20261111032125.2888320-1-vi@endrift.com>
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
 drivers/hid/hid-nintendo-switch2-usb.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-nintendo-switch2-usb.c b/drivers/hid/hid-nintendo-switch2-usb.c
index d747000336dc..5dba25c738e1 100644
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
@@ -294,6 +287,10 @@ static void switch2_usb_message_in_work(struct work_struct *work)
 	unsigned long flags;
 
 	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
+	if (ns2_usb->shutdown) {
+		spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
+		return;
+	}
 	for (i = 0; i < NS2_IN_URBS; i++) {
 		urb = &ns2_usb->bulk_in[i];
 		if (urb->state != NS2_URB_IN)
-- 
2.54.0

