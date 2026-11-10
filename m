Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.255.198.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285288;
	b=2KdIJzzhXaNJMEQmCAx2dm33kz+uduOPyc7Iz7DGhO6kD6UrVZUnrLsL9AKuyN6VdQm0
	 4DAtmLp1DH5Fj9KPICrHI8ZTxHq0kbzO2uNKbWHdlKfN1SZ9Z1Q8FVJzc358wZj3o1MgO
	 CW7ko8CPXiV6c6jIn1telFfYK3pEhjXN5rkNEMegzjjfkrK/bFHN6HU92LGVX/h7Vb0ew
	 saBOBUNbxdeivx+hGcAIIOzSXFR0IbnFsBr+95xT1rjpD6dJ2JNJxfJJWr/mwciCD/L65
	 nFiDHt8hxJbqaq9fL8EPu4pzjjLS5KhrrFAV3x9WjZxgewZISNZ+lILcHEEo+kHWE/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285288;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=sdRBcjqieZeutypkfjNqG/2QY6KlwHoa3cjDsRbzaY4=;
	b=dXWDTXguF7kc8OT1lp54LXLDhvD/1HsL1qvki3iiMjRJSIit7MbU/2z09XE2NhqdHQ9d
	 Nj/UY8VC64rimcC6fmBuw2PcWAVpbrVxa2dgnpSK9dYPmimcgkz0L3t6sWRALzc/Tu5Ry
	 KQrvkaDPywlQaRkSB3Feh3y3XnTUeKU+fiGyicomp6Z7xvl+a1l3tTIHizteSbpQjH1WG
	 Hd9XE5XZMO8wlRfxrot0ffUJpBQ6bnKdenm1rNlvnrpD6L0t/G+X8F0MuMb+OEbHOT6Oj
	 MJh+quVHKwE6jI3L6iSUlhIiQiyR5Nq1Di1nN5e3JMZw7sVD//gKYF4SLejVHkqEYHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=endrift.com;
	spf=pass smtp.mailfrom=endrift.com;
	dkim=pass header.d=endrift.com header.i=@endrift.com header.a=rsa-sha256 header.s=2020 header.b=AHpz+SBg;
	arc=none smtp.remote-ip=173.255.198.10
Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858C2606A31C
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 04:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 858C2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.a=rsa-sha256 header.s=2020 header.b=AHpz+SBg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1794285286; bh=kguaeDrMA/GDHVAAMANmsX3iWIwgKIcJWSen4bgimF8=;
	h=From:To:Cc:Subject:Date:From;
	b=AHpz+SBgtPI+j6xtMEAB0RedslQxjFLH4JdStUKFm35J2JjiCLalxQwbHB8HMD5sZ
	 U6BXXdW85K3b1cM6xNa8+9RdImNzxB+TlbetCZFz4LghTsDlUCLFkFOcY1iOW9t+my
	 Bfmvu8+fLSqgBzSdPxsEMCJjNhr4bFuqFlnkDK7H/Y8gFu1Jn89nfozl51N6b8HhxA
	 /ShZfKCmtsnKaijZsPuGl51nOUmZZ52oLdHyI2AFyMx+hJBnQ4LUstd/0cTME05Bfq
	 Z2VokyGjFnYImhEq1rNcZbOQeKT2JDo5OiXvn1uYFAT1654YbczMquK8z/xkHqFRIz
	 Y8+sGQMBapzMA==
Received: from microtis.vulpes.eutheria.net (unknown [97.126.138.172])
	by endrift.com (Postfix) with ESMTPSA id 808CEA04D;
	Mon, 09 Nov 2026 20:34:46 -0800 (PST)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Noah Weinberger <noahweinberger2003@proton.me>
Subject: [PATCH] HID: nintendo-switch2-usb: Improve shutdown logic with inbound message work
Date: Mon,  9 Nov 2026 20:34:17 -0800
Message-ID: <20261110043420.2433197-1-vi@endrift.com>
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
 drivers/hid/hid-nintendo-switch2-usb.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-nintendo-switch2-usb.c b/drivers/hid/hid-nintendo-switch2-usb.c
index 8b3b6841035d..80c002a98d5a 100644
--- a/drivers/hid/hid-nintendo-switch2-usb.c
+++ b/drivers/hid/hid-nintendo-switch2-usb.c
@@ -71,16 +71,14 @@ static void switch2_bulk_in(struct urb *urb)
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
+			if (!ns2_usb->shutdown) {
 				ns2_usb->bulk_in[i].state = NS2_URB_IN;
+				schedule_work(&ns2_usb->message_in_work);
 				continue;
 			} else {
 				ns2_usb->bulk_in[i].state = NS2_URB_FREE;
@@ -115,9 +113,6 @@ static void switch2_bulk_in(struct urb *urb)
 		}
 	}
 	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
-
-	if (schedule)
-		schedule_work(&ns2_usb->message_in_work);
 }
 
 static void switch2_bulk_out(struct urb *urb)
@@ -294,6 +289,10 @@ static void switch2_usb_message_in_work(struct work_struct *work)
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

