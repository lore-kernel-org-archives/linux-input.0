Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F88637AA91
	for <linux-input@vger.kernel.org>; Tue,  3 Mar 2026 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772527445; cv=none; b=CvZf4osGZo+4x6rq91EycrWL4lvOYqO4fpqRxO3i0mjJks2lEcUL/TrdH+y6iH8Btxjy05aG1zrkPwddoC24e2tjXD4xuX3b00Hylu5cNqBV2AiBY3eKyyXRjluHlLWwRO/AeiHWtfFfW4RETGVbUhcbMANf5JALn3Ya9dD3xj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772527445; c=relaxed/simple;
	bh=JDFEml+AqpRS6YnagYec2U2uKDWe6JxynbYiJoktS74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MVEGXYmrYk8Z3YI0v8AuOmiIRZad7pymUavOxyGxg11xVljvZV9T2tQ9xLIlS/znz7bfwEgIWEfd8031XhEx/sN8M+9xmUMyZgri2CG5YAPm1bM5ix41Yl/SxMdFaD3bnqEmtTaHb4qHOsPNs+zIxEmmU+WZX1Ppa/ILpEYqYa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aVuDAmEY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aVuDAmEY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aVuDAmEY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aVuDAmEY"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C2ED95BDEF;
	Tue,  3 Mar 2026 08:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772527442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wKO7ZIuSrzeLEJbPWlROwZSNatuF8mUT1FeTzpAgYCc=;
	b=aVuDAmEYgGKSDAzdZlxmfB5+4tC04kBnv7JxTk1bJtz797b/QcCYn5WoqC0DM/LZW6cbYN
	sEAl1VUmmEGXArg1kheQtcUeJN0I5LA62nSgsD0kHY+VmM0MiBvMdBkiK4TPw0QGrWuihx
	U0f2odq5KVPlS8811RP9CZ//xKoKhV8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772527442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wKO7ZIuSrzeLEJbPWlROwZSNatuF8mUT1FeTzpAgYCc=;
	b=aVuDAmEYgGKSDAzdZlxmfB5+4tC04kBnv7JxTk1bJtz797b/QcCYn5WoqC0DM/LZW6cbYN
	sEAl1VUmmEGXArg1kheQtcUeJN0I5LA62nSgsD0kHY+VmM0MiBvMdBkiK4TPw0QGrWuihx
	U0f2odq5KVPlS8811RP9CZ//xKoKhV8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 800C13EA69;
	Tue,  3 Mar 2026 08:44:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U/HKHFKfpmmiGQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 03 Mar 2026 08:44:02 +0000
From: Oliver Neukum <oneukum@suse.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCHv2] hid: hid-pl: eliminate private debug macro
Date: Tue,  3 Mar 2026 09:43:38 +0100
Message-ID: <20260303084359.1206434-1-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

Use proper dynamic debugging.

V2: use hid_dbg() instead of dev_dbg()

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/hid/hid-pl.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-pl.c b/drivers/hid/hid-pl.c
index c6c2961dd574..8bba29ef6c7a 100644
--- a/drivers/hid/hid-pl.c
+++ b/drivers/hid/hid-pl.c
@@ -24,10 +24,6 @@
  */
 
 
-/* #define DEBUG */
-
-#define debug(format, arg...) pr_debug("hid-plff: " format "\n" , ## arg)
-
 #include <linux/input.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -53,14 +49,14 @@ static int hid_plff_play(struct input_dev *dev, void *data,
 
 	left = effect->u.rumble.strong_magnitude;
 	right = effect->u.rumble.weak_magnitude;
-	debug("called with 0x%04x 0x%04x", left, right);
+	hid_dbg(dev, "called with 0x%04x 0x%04x", left, right);
 
 	left = left * plff->maxval / 0xffff;
 	right = right * plff->maxval / 0xffff;
 
 	*plff->strong = left;
 	*plff->weak = right;
-	debug("running with 0x%02x 0x%02x", left, right);
+	hid_dbg(dev, "running with 0x%02x 0x%02x", left, right);
 	hid_hw_request(hid, plff->report, HID_REQ_SET_REPORT);
 
 	return 0;
@@ -119,7 +115,7 @@ static int plff_init(struct hid_device *hid)
 			report->field[0]->value[1] = 0x00;
 			strong = &report->field[0]->value[2];
 			weak = &report->field[0]->value[3];
-			debug("detected single-field device");
+			hid_dbg(hid, "detected single-field device");
 		} else if (report->field[0]->maxusage == 1 &&
 			   report->field[0]->usage[0].hid ==
 				(HID_UP_LED | 0x43) &&
@@ -134,7 +130,7 @@ static int plff_init(struct hid_device *hid)
 			weak = &report->field[3]->value[0];
 			if (hid->vendor == USB_VENDOR_ID_JESS2)
 				maxval = 0xff;
-			debug("detected 4-field device");
+			hid_dbg(hid, "detected 4-field device");
 		} else {
 			hid_err(hid, "not enough fields or values\n");
 			return -ENODEV;
-- 
2.53.0

