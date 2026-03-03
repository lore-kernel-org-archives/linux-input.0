Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC47A38F62B
	for <linux-input@vger.kernel.org>; Tue,  3 Mar 2026 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772531400; cv=none; b=CDTMe6u9mG52UjQW1N4wepr7SMp3FP0VKz+RGGdYWone0kaSG+iAUAUbYSfwlNWFyG9rqbG6wfiymHHhiWNTIBw4Lal8PbvDvhnQR7SV9CBSzHKQ3ckdJ9GXXBczFqopI6n+ehaHj6IojZFgEAAB4GYqN97XIl7dXvOev7GBuQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772531400; c=relaxed/simple;
	bh=HN+1ykjS4uZGa6AJ10CG+0GjwxC3kRCvZ19HKezkyAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jjptjbWA1p5PcwV3vKb+PWHPcy4jtA7XeXZuKhh+xLZ9DDoWgGLpxmpOLKUkjIKmZ3FNpZCWm33HFqoYAsaMalVYWRGSNPcB6GMwKPRmd/mYGXrAiK3AQ255YNWzMO/yIlJY/Gajyg1e2ccq1uZSz5mqBqBMJC8KPYy+5hZIPkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=K6nXISYx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N5VlYItW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="K6nXISYx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N5VlYItW"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 260533F9E3;
	Tue,  3 Mar 2026 09:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772531393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R7ZqviDvm8kt/HwDB/L6cnHJwIiYENkqTHiLibK9k7k=;
	b=K6nXISYxKW++eZz0BMSu2VRieEWIUo+HB077Cd+Kagcvuqeen05iGTbtdufRUcjO/P0lNn
	bbNmaccEVa8rAZIRT1NtsSmveb5LCIqWFtTve5s6ihiVpaw77Umggjg0zqyJ0eITrppEX1
	NMrTnTRlDXvREqTdzt56eXhVvIBPEd4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=N5VlYItW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772531392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R7ZqviDvm8kt/HwDB/L6cnHJwIiYENkqTHiLibK9k7k=;
	b=N5VlYItWZImZ0ZBx7ZUyGB//lQDgxRlemdOG+ERbFxNp8pRbSPT5t062Ksb85NLw9PkuBL
	AOVFJ86UN3eqFn4KULWVubMqJ/qRQlm2nmdlCCHlXVce9ojDIXo/QarrR7puuan4FyubLd
	co4HKrVLUfBFuC4OaOkv0w9Jo0qYHhY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02F8C3EA69;
	Tue,  3 Mar 2026 09:49:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WFpFO7+upmnMYgAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 03 Mar 2026 09:49:51 +0000
From: Oliver Neukum <oneukum@suse.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	jussi.kivilinna@mbnet.fi,
	linux-input@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFC] hid: hid-sjoy: race between init and usage
Date: Tue,  3 Mar 2026 10:48:54 +0100
Message-ID: <20260303094906.1214359-1-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 260533F9E3

The driver uses an initial IO to set the device to a default
state. That initialization is currently being done after the device
node has been created. That means that the single buffer used
for output can be altered while IO is in progress.
Move the intialization before announcement to user space.

Fixes: fac733f029251 ("HID: force feedback support for SmartJoy PLUS PS2/USB adapter")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/hid/hid-sjoy.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-sjoy.c b/drivers/hid/hid-sjoy.c
index bab93d71b760..963c45113204 100644
--- a/drivers/hid/hid-sjoy.c
+++ b/drivers/hid/hid-sjoy.c
@@ -91,17 +91,17 @@ static int sjoyff_init(struct hid_device *hid)
 
 		set_bit(FF_RUMBLE, dev->ffbit);
 
-		error = input_ff_create_memless(dev, sjoyff, hid_sjoyff_play);
-		if (error) {
-			kfree(sjoyff);
-			return error;
-		}
-
 		sjoyff->report = report;
 		sjoyff->report->field[0]->value[0] = 0x01;
 		sjoyff->report->field[0]->value[1] = 0x00;
 		sjoyff->report->field[0]->value[2] = 0x00;
 		hid_hw_request(hid, sjoyff->report, HID_REQ_SET_REPORT);
+
+		error = input_ff_create_memless(dev, sjoyff, hid_sjoyff_play);
+		if (error) {
+			kfree(sjoyff);
+			return error;
+		}
 	}
 
 	hid_info(hid, "Force feedback for SmartJoy PLUS PS2/USB adapter\n");
-- 
2.53.0

