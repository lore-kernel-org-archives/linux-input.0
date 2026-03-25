Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF25435A3B7
	for <linux-input@vger.kernel.org>; Wed, 25 Mar 2026 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449194; cv=none; b=HYtfvz5HOCKwAMeJKWRyjjmC1yRknqaNeyZJ3hXl7J5Dj883GaeeTKSn88vKIKZSsdlfWEz86foBeF1F9Ek8vwlnRZBT4/IQNHGqzsxA8Rwzq8i1i0lKT3k14i8znxAQ1Y7QTI0J6K+M9m+958q6YOBUpxakZfFp1AquKfo7VfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449194; c=relaxed/simple;
	bh=dPvxvX9nQc9FpsbTO0SBzKoc2D8QHIuieg+Bz2G1nFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hr0C9AdwI2P2OwzhSgNrrZIl04lm2sq9ZNUJSIcS/o3BFMTqbNt2BK8NWpFJgrz+G7e4Mn7Mj35MSJ71m/Fbz6x46nbSqMpdGzN7ZVu6I995t5BfF8FCb3yuPxDagtevngwuRUaFROzDDr4yjqE2IZt62bNivD8gzg9akAL07rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IfuUQjy5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mkSFR5ar; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IfuUQjy5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mkSFR5ar"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C670D4D24A;
	Wed, 25 Mar 2026 14:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1774449184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RyeMdoMN2/0nPvf5qPhfrPzPhrKhmgc0Nle6QK4eJS8=;
	b=IfuUQjy5dK0TruJdjB93ZJbRGPK5k4uWUOgDmgCMSbu7QOBP61dwfoE2qbkueMcBXgQESu
	evdDi5V+4DvQCtJCQNg1dyQlhyT/6yRb3FVpT/8JRmL1/5rBZwSMWNpU3cJCNkWInM+anw
	R+0/PRcGcUiFRB1Pg6hzS6V1bqsXlNI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1774449183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RyeMdoMN2/0nPvf5qPhfrPzPhrKhmgc0Nle6QK4eJS8=;
	b=mkSFR5argTv2xjaphXyJFF/8uhDx6y2TB5WDV95EEmtx4I+zf2W+e5PMjFKzxf2qLnBagX
	EA5CnYW8dhje0+xAZAGsaOc9o8g3i8sY2mI311oG6nwIfCzW6dW+cd78LURbRfYH6EBK31
	2bGLd1sGKzW6360651pkYRcTVd+epqw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A27F14444E;
	Wed, 25 Mar 2026 14:33:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YKKfJh/yw2lSTAAAD6G6ig
	(envelope-from <oneukum@suse.com>); Wed, 25 Mar 2026 14:33:03 +0000
From: Oliver Neukum <oneukum@suse.com>
To: dmitry.torokhov@gmail.com,
	kees@kernel.org,
	linux-input@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 2/2] input: pegasus_notetaker: use HID defines
Date: Wed, 25 Mar 2026 15:32:47 +0100
Message-ID: <20260325143256.371854-2-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325143256.371854-1-oneukum@suse.com>
References: <20260325143256.371854-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -5.30
X-Spam-Level: 
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO

The driver uses its own definitions for HID requests.
This leads to duplication and obfuscation. Use HID's
definitions.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/input/tablet/pegasus_notetaker.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
index 3a8493ed5e44..6415bfe1886e 100644
--- a/drivers/input/tablet/pegasus_notetaker.c
+++ b/drivers/input/tablet/pegasus_notetaker.c
@@ -36,6 +36,7 @@
  * T	Tip
  */
 
+#include <linux/hid.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/input.h>
@@ -44,10 +45,6 @@
 #include <linux/workqueue.h>
 #include <linux/mutex.h>
 
-/* USB HID defines */
-#define USB_REQ_GET_REPORT		0x01
-#define USB_REQ_SET_REPORT		0x09
-
 #define USB_VENDOR_ID_PEGASUSTECH	0x0e20
 #define USB_DEVICE_ID_PEGASUS_NOTETAKER_EN100	0x0101
 
@@ -108,7 +105,7 @@ static int pegasus_control_msg(struct pegasus *pegasus, u8 *data, int len)
 
 	result = usb_control_msg(pegasus->usbdev,
 				 usb_sndctrlpipe(pegasus->usbdev, 0),
-				 USB_REQ_SET_REPORT,
+				 HID_REQ_SET_REPORT,
 				 USB_TYPE_VENDOR | USB_DIR_OUT,
 				 0, 0, cmd_buf, sizeof_buf,
 				 USB_CTRL_SET_TIMEOUT);
-- 
2.53.0

