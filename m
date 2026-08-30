Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98B5314D35
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 20:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788123186; cv=none; b=QpohPd7H7P+bVfi7J+OD1fN1NbV6/Iolj4ZHADcmciFTuXIP6xCFVcUrGsbD5cSvcyRyfhC4bQyroXVMbf9Z/O6KDED2dZupQd4I7fu481iMyWW9BSKOiBCPCCoJQeGuEaVaYrJwLvBq9fZW9PUcpLwEQ0Bw52lvjjin6DHcHwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788123186; c=relaxed/simple;
	bh=bs9mrsFzM//ZHvK7snT2+IBTMQyZXvEiQ5+GAtaAmBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ks3BwHcnGOtCkoTi7dT7xftqzMmU8VD4Up0ub+PeOmwBsnCTxvTmiXrtVTY2CBkfWQZxTRBRojx/BpLxsilK36TLE2uvuQo1r99DF/KqdNGb0/SSf0ZoIlnrq3zVmGNqfKt7aYsHHJrPuS1cXkGi12PwFkDRWvKcsErrlxQ2uyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHef68uN; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHef68uN"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbedf433a99so3083621a12.2
        for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 13:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788123181; x=1788727981; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gMm1bV3fk8RuJ0iH9m0xwNjD31eH6ofBYEV7LvqwZ1I=;
        b=mHef68uNPpJMJrLW6Y9KqF0Td3KB8RuJfcXUcd95VmE5yWkYJ6POHwKmL1ZapalBb8
         XE92rnbY6FgkxmgW28eaE425O4pgrCixhs2f9vEyrzeIkzQRNi71XKeeQ6ZSUlDr7+Wx
         HWR3dW6+SEU+ektyeujJ9ACnBO/mqrSLKq+1V3mZBBOFXq2HjO4uORBSgUyCHyjiMDuZ
         C3FX/SkLkGrWJHqEbgg/UKaQXjC87IniWEKPpqJyaVSCVFwqkfGc3Fq4mKDYdRrUq8+Y
         afwkpQo8Bs2N8At77shiGq2+11HCK0RmOSKG/bbLjqxaLV1dZ3rxMQVbB4Tg1RzRVPOi
         3/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788123181; x=1788727981;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gMm1bV3fk8RuJ0iH9m0xwNjD31eH6ofBYEV7LvqwZ1I=;
        b=GwJ9Akw2nz2Hm5F5/zeajkvqJPwiJhT7r9fd/ngdgSDPK3Z0QxfL2/qq3WHbU729mg
         P1xUQksGJsBnuSb11HqBsrGYfQ5NyZ3PiPUPiG1S0IjEyJe2cjzk0fgdqudpHCe5727O
         U86H9FSg9+txLwuvY99fMnOpYnvYvUSP27JzFb7ffGOk6hprbpWCOKMhySzqOgcyWSfV
         4OmdihUneDJX6sTkA3cNu41UtRzHVnhc4jZnBH6/+a1Jo2U23nXv9Hu5i8vRF3+cmA13
         sYuIgFX/YtKAdtJ4sn9ZCBn+pctwq0CGYwSuCrO3kt0EYJ1MElUQXvinruZskOI/JuSo
         AqEw==
X-Forwarded-Encrypted: i=1; AHgh+RptEGwiiSr/Dl84mIsNT0D7dAdd7cztvVnFelHt9RgLjmityDHkF13KkRsDhX88dwao9/6UGkg6FASKyw==@vger.kernel.org
X-Gm-Message-State: AFuF++lMlyZc1IZcYSDhVyntMttvwd1szjnFaRRx43Iy1r0Bbq0VVXfu
	lf2NDeeUESRrnqw/1TlmXWpqb2Ig5XQ230OymIiSUITuxCvD8y8Td5Pp
X-Gm-Gg: AR+sD12TFNeougAzNhvQ3WgIeWHhJPJwc16RcF0X6BH8Oo+PFLKhuAdYEQiONqTHeMj
	LxWdSgvxcjq1eH78V0Hfe4xeVbxLys/O+vRjcc39IaCKycnhBLk6G5y6ASpbupLFXFetDYKyb8O
	eNDaW0relQGDl1TVu7CTcbb+EbC6PfXcqupeegH7lwztv7uwWBX3MDHc8LUOYJL58dWihQK66sK
	LWYWzQPh5Cl4NAv62UyXEUkRxJcGPSNbLPafQj4PmAZ2NP5mNgTJfoxXf9F/NxTbElqrpcYDxN6
	N3J3ueWlxPG03T538pJRnSAlAetAemQ4MWk5dwY89719MxFLLRLaBOjz+lsnAwV6G6Wj/Ihqb9i
	JeLcknPSRJpGZcFCtV2mwsPgzDS+TtAAz0pjwsSlYbN7iDO1wtV+DT+Iv9rRB89AxahlxXd1+8h
	Z1Egf/FQJ6/KEFs9dkyxuYcfwuCNN+fnJnTLpkmHNCcZhrPo96V38TD6SdeTyHKrTuq0SGaIRhs
	jslIIEbUa3us+9oysz8paOwKvjv6Ctr8i2bHqgN+0bPl9tu9/o=
X-Received: by 2002:a05:6a20:7345:b0:3d1:7238:33d9 with SMTP id adf61e73a8af0-3d26532756amr33302467637.3.1788123181468;
        Sun, 30 Aug 2026 13:53:01 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:c021:485f:75be:3c7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9e3cf8sm26849437eec.24.2026.08.30.13.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 13:53:00 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 30 Aug 2026 13:52:51 -0700
Subject: [PATCH 6/7] Input: gscps2 - serialize concurrent interrupt
 handlers
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-gscps2-v1-6-c733d4cae7f9@gmail.com>
References: <20260830-gscps2-v1-0-c733d4cae7f9@gmail.com>
In-Reply-To: <20260830-gscps2-v1-0-c733d4cae7f9@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-parisc@vger.kernel.org, sashiko-bot@kernel.org
X-Mailer: b4 0.16-dev-b242f

gscps2_interrupt() may be invoked concurrently from a hardware interrupt
on one CPU and from process context via gscps2_writeb_output() on another
CPU. In gscps2_report_data(), ps2port->lock is released before calling
serio_interrupt() to avoid recursive deadlocks. However, if two execution
contexts run gscps2_report_data() concurrently for the same port, they
could race to acquire serio->lock inside serio_interrupt(), potentially
delivering multi-byte scancodes out of order.

Serialize execution of gscps2_interrupt() using gscps2_interrupt_lock
with ACQUIRE(spinlock_irqsave_try). Using spin_trylock prevents
overlapping executions and guarantees in-order packet delivery without
risking recursive deadlocks if an input driver synchronously sends a
command back via serio_write(). If the lock cannot be acquired, return
IRQ_NONE to preserve spurious interrupt detection on shared IRQ lines.

Reported-by: sashiko-bot@kernel.org
Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/gscps2.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
index 907fb1537595..2afd53a163ff 100644
--- a/drivers/input/serio/gscps2.c
+++ b/drivers/input/serio/gscps2.c
@@ -288,6 +288,8 @@ static bool gscps2_report_data(struct gscps2port *ps2port)
 	}
 }
 
+static DEFINE_SPINLOCK(gscps2_interrupt_lock);
+
 /**
  * gscps2_interrupt() - Interruption service routine
  * @irq: interrupt number which triggered (unused)
@@ -305,21 +307,31 @@ static irqreturn_t gscps2_interrupt(int irq, void *dev)
 {
 	struct gscps2port *ps2port;
 	bool handled = false;
+	bool more_data;
+
+	ACQUIRE(spinlock_irqsave_try, lock)(&gscps2_interrupt_lock);
+	if (ACQUIRE_ERR(spinlock_irqsave_try, &lock))
+		return IRQ_NONE;
 
 	guard(rcu)();
 
-	list_for_each_entry_rcu(ps2port, &ps2port_list, node) {
-		if (gscps2_read_data(ps2port))
-			handled = true;
-	}
+	do {
+		more_data = false;
 
-	/* all data was read from the ports - now report the data to upper layer */
-	list_for_each_entry_rcu(ps2port, &ps2port_list, node) {
-		if (gscps2_report_data(ps2port)) {
-			/* More data ready - break early to restart interrupt */
-			break;
+		list_for_each_entry_rcu(ps2port, &ps2port_list, node) {
+			if (gscps2_read_data(ps2port))
+				handled = true;
 		}
-	}
+
+		/* all data was read from the ports - now report the data to upper layer */
+		list_for_each_entry_rcu(ps2port, &ps2port_list, node) {
+			if (gscps2_report_data(ps2port)) {
+				/* More data ready - restart loop to read new data */
+				more_data = true;
+				break;
+			}
+		}
+	} while (more_data);
 
 	return IRQ_RETVAL(handled);
 }

-- 
2.55.0.897.gb25b4bd76c-goog

