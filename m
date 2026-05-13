Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120F2317155;
	Wed, 13 May 2026 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778687408; cv=none; b=Te0gZ7r06xvERlHK648/9tHknXvNhMbq1Lh5eVQtzguTfkgVCw03Vzp94PouSGCHiOKevm5CgwmUe922svjsCL8ArYNup7/t4Po1pyMMxiw07dUMQDaqn8ijl09C+ozB3j0FoUCpIB83o35tQSCICRM6S/yEYI0NvMicP2J9GW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778687408; c=relaxed/simple;
	bh=5puekVyUhNpxzfjY2m1ee8QpGBPQKmMRAe5jVLv3xEE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MrllRpwvEnyCf7Lmc3pyzdvAhNWZDecGdMq4Lb+erCIjbWOKsTEUMvNUPOGTwqoXV+N8W7CoN3RYp8ScKA+wcXdrhFBVgBbykt74DdiSQ67NespEWUYCbgiVqSjxvjuc9noxkTCQvRtq5U+xPc5aYKvsM32GoB/Yl9b3F3n2+XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=YcNpLmG2; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="YcNpLmG2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=qbSLyEOe4/hrnp8fXr/gh0gT6cWNpDxmS5qnzohKBeo=; b=YcNpLmG2/6qRRQPgQ69rUvlO8t
	6Krm+LWMWjeA0l53M5i6YHxe+SJxO0WZOiVgywqe0z3MhC46vPvCnOk+He7y9xLlXMXkQ7iESMhXS
	xMtirJcFpuF1TBVS6BE+qhJ2EvVq+ezdrckfxJV2srwbIFJcmx3vZRSkQeB5IXOdqXfoTvyKHYHo7
	+EBMFf4aT1Y2l1NHgmgCpk7RHFFVQiBi1aA54CITJu7wTqUqNQ27bAp7taeQ2E464osC+uCBhI+F9
	hbqGG0qf3UxhMdQ5C8OFg0omxAuPoQKN/X8lS+EVVTHOG2M7ZY4ENqnSj0XbBePih4WW9OJ/s31gC
	mDL029eg==;
Received: from [2601:18c:8180:83cc:5a47:caff:fe78:8708] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wNBqS-000000005oP-225O;
	Wed, 13 May 2026 11:50:00 -0400
Date: Wed, 13 May 2026 11:50:00 -0400
From: Rik van Riel <riel@surriel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: [PATCH] input/evdev: move kill_fasync() outside buffer_lock to fix
 SOFTIRQ deadlock
Message-ID: <20260513115000.77ec5975@fangorn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

buffer_lock is a SOFTIRQ-safe spinlock. kill_fasync() acquires fa_lock
(SOFTIRQ-unsafe), creating a potential SOFTIRQ-safe->SOFTIRQ-unsafe lock
ordering violation that lockdep flags as a deadlock.

Fix by moving the kill_fasync() call to evdev_pass_values() after
buffer_lock is released, alongside the existing wake_up_interruptible_poll().

The wakeup condition check is the same in __pass_event() and
evdev_pass_values()

Found by syzkaller

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 drivers/input/evdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index c7325226cb86..bda63f7a507a 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -235,10 +235,8 @@ static void __pass_event(struct evdev_client *client,
 		client->packet_head = client->tail;
 	}
 
-	if (event->type == EV_SYN && event->code == SYN_REPORT) {
+	if (event->type == EV_SYN && event->code == SYN_REPORT)
 		client->packet_head = client->head;
-		kill_fasync(&client->fasync, SIGIO, POLL_IN);
-	}
 }
 
 static void evdev_pass_values(struct evdev_client *client,
@@ -280,9 +278,11 @@ static void evdev_pass_values(struct evdev_client *client,
 
 	spin_unlock(&client->buffer_lock);
 
-	if (wakeup)
+	if (wakeup) {
+		kill_fasync(&client->fasync, SIGIO, POLL_IN);
 		wake_up_interruptible_poll(&client->wait,
 			EPOLLIN | EPOLLOUT | EPOLLRDNORM | EPOLLWRNORM);
+	}
 }
 
 /*
-- 
2.53.0-Meta


