Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386505;
	b=ljU48uls4EP5N/YUQKu8GtXSTE3D1roNdrexAJBMzYiwRJe7K2ScKhIaZEw7vFp4sKmC
	 SNrf6/AFUYV8z72gFu9rtHv4n9PV0K4RaaB2xvHHhA2MMyiwJTNOwZWkm4Qewza8kQLBU
	 D8SVmBWF1Rl2CvmYylX7emBF+1hGUCbVuYeUf/M+f4qZmp9Si4KJCzV1+JBmsaLGSjMAy
	 lt7hxVmhPIUf1aQ7U/U35VV/hE7Q2kKsKW3O0BZXJdneXuTHE7QHs8CdVu0lpTo8AGbTh
	 UR6L1kGgONPm35LYg0RGOyBE2tRzeSP8QHUqDzWXfBqPrythF9jkIRKJ15bIwve2BfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386505;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Yoi4i9vg2CiHwARiR9NTJMpFWV2ODOMylswWhd5Vj6o=;
	b=2mDguQOQvNOyIn0zybBImwbq2to/TqTw5k2YQJFHyqIUVUpN1dL0Xi22QBcvYdukc6My
	 SpT5gdHZKbKhPiskUCbnMr+VcS6uHxYa7Pcoe6q1UbhxwQJUIqh2o361HstltiREww2X6
	 sMu/3fGTZeJhAGJJzbt/X9mer/hDuisSu50Ypy723Oal4pWq9nhCItgy4zmwUetwXzvw7
	 avpoWrPR8LbBVG8UgmVNATxs97NFR2geJaqkAqOLZYr8h3F6xprkyFpbNya/6F/O2ip+N
	 hQhyiYc2gRzr80LBvKaf6PLxrYguOlXL898ylM6cZ5+bcDhkm/Oq9ZviedI1pkKjHvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ks1M1p62;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1D4606A320;
	Wed, 11 Nov 2026 08:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A1D4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ks1M1p62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=ks1M1p62GflYzFVLnIewoKhWaGAPp7XQ/UiiwvWrNyxbETB8A9sDJIEtTzn5LRwK+okMaPPXKATUC
	 3bJmbbO8jozwy7rDNMAXcpcZnwldiexM9UTr319+0/9QgBiIbsBXzm4PGpGkZCE63pFJrDeJTCXgJm
	 SyW0VAHTLG/CJqsM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46af42a46af9-769a8;
	Wed, 11 Nov 2026 16:41:43 +0800 (CST)
X-RM-TRANSID:2ee46af42a46af9-769a8
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36af42a45af8-d4cd3;
	Wed, 11 Nov 2026 16:41:43 +0800 (CST)
X-RM-TRANSID:2ee36af42a45af8-d4cd3
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+96605ccb04166cb6cfe8@syzkaller.appspotmail.com,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] Input: libps2 - annotate lockless command wait conditions
Date: Wed, 11 Nov 2026 16:41:42 +0800
Message-ID: <20261111084142.80954-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
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

PS/2 command waiters release the serio receive lock before waiting for
the interrupt handler to clear the command flags. Their wait conditions,
and the intermediate cmdcnt check, consequently race with the handler's
updates.

Sample these fields once and mark the intentionally lockless checks.
Keep the receive lock around response handling and flag updates, so
the final command result is still checked under the existing lock.

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 drivers/input/serio/libps2.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index 05b64277aecd..a60912224bfa 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -41,6 +41,12 @@
 #define PS2_FLAG_NAK		BIT(4)	/* Last transmission was NAKed */
 #define PS2_FLAG_PASS_NOACK	BIT(5)	/* Pass non-ACK byte to receive handler */
 
+static bool ps2_is_waiting(struct ps2dev *ps2dev, unsigned long flag)
+{
+	/* Waiters sample flags while the receive interrupt updates them. */
+	return data_race(READ_ONCE(ps2dev->flags)) & flag;
+}
+
 static int ps2_do_sendbyte(struct ps2dev *ps2dev, u8 byte,
 			   unsigned int timeout, unsigned int max_attempts)
 	__releases(&ps2dev->serio->lock) __acquires(&ps2dev->serio->lock)
@@ -62,7 +68,7 @@ static int ps2_do_sendbyte(struct ps2dev *ps2dev, u8 byte,
 				"failed to write %#02x: %d\n", byte, error);
 		else
 			wait_event_timeout(ps2dev->wait,
-					   !(ps2dev->flags & PS2_FLAG_ACK),
+					   !ps2_is_waiting(ps2dev, PS2_FLAG_ACK),
 					   msecs_to_jiffies(timeout));
 
 		serio_pause_rx(ps2dev->serio);
@@ -338,13 +344,17 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
 	timeout = msecs_to_jiffies(command == PS2_CMD_RESET_BAT ? 4000 : 500);
 
 	timeout = wait_event_timeout(ps2dev->wait,
-				     !(ps2dev->flags & PS2_FLAG_CMD1), timeout);
+				     !ps2_is_waiting(ps2dev, PS2_FLAG_CMD1),
+				     timeout);
 
-	if (ps2dev->cmdcnt && !(ps2dev->flags & PS2_FLAG_CMD1)) {
+	/* The interrupt may advance cmdcnt between the two waits. */
+	if (data_race(READ_ONCE(ps2dev->cmdcnt)) &&
+	    !ps2_is_waiting(ps2dev, PS2_FLAG_CMD1)) {
 
 		timeout = ps2_adjust_timeout(ps2dev, command, timeout);
 		wait_event_timeout(ps2dev->wait,
-				   !(ps2dev->flags & PS2_FLAG_CMD), timeout);
+				   !ps2_is_waiting(ps2dev, PS2_FLAG_CMD),
+				   timeout);
 	}
 
 	serio_pause_rx(ps2dev->serio);
-- 
2.51.0



