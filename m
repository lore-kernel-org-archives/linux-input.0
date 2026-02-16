Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5130F1D5CD1
	for <linux-input@vger.kernel.org>; Mon, 16 Feb 2026 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771249829; cv=none; b=oTz+4cbKhqmveq6vpM7V3mKhhcRxzVfSbwFyoNn39yiWLbJc3OdfB/BD28hRPfoSl8wWwC/4ulRXCuYMUcFZcwvr/7FYpZNVfBwB96j6+HooeVSi9/ItoWHaFyIkzFaA8/X9FuG5w1yU5F2OVkh0+2KI4bkedFkv7lOyqXCQiiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771249829; c=relaxed/simple;
	bh=echqq1pRvrs60C2gRetJufRIwXHL/RtUaVgssfvwe/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzJBw6Flclyh6ljTNaHkRooVJ7NHNugPWPH3QIaZdySeokwGNqkVxL/ozw/tcjAeF5kfx9VgMcqC48Y7rAekVOW6ZvikkygiFBZ4BoAFX1uevmbFoj0lmVWUJ1JDiOyeWw0m8qaGI18A9C/JSljrco74VZ4yqbg3sBCBrszG12M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=riMvUwn1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=riMvUwn1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="riMvUwn1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="riMvUwn1"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5DEB55BD2B;
	Mon, 16 Feb 2026 13:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771249808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pHrfCOZekvyO8/JgjOzXUxmiTbQTSm4DciZTeqhHf/E=;
	b=riMvUwn1qElDcQPdB8NZdyJ3Vx/RlegcRXkBtc7eyFmfj4cND6OOLy+6aLtxRyy47au+Gm
	mKXu8g7feLWWWM64rMkCtf70XmPWGIa2/q0oI8/MSxW/4kRCp0xy58ehfJMBLPnYB5V/+2
	DlxqwADORt1nDg4UIXv+h8kfPMhP0PY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771249808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pHrfCOZekvyO8/JgjOzXUxmiTbQTSm4DciZTeqhHf/E=;
	b=riMvUwn1qElDcQPdB8NZdyJ3Vx/RlegcRXkBtc7eyFmfj4cND6OOLy+6aLtxRyy47au+Gm
	mKXu8g7feLWWWM64rMkCtf70XmPWGIa2/q0oI8/MSxW/4kRCp0xy58ehfJMBLPnYB5V/+2
	DlxqwADORt1nDg4UIXv+h8kfPMhP0PY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A50B33EA65;
	Mon, 16 Feb 2026 13:50:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uA85J48gk2k3BAAAD6G6ig
	(envelope-from <oneukum@suse.com>); Mon, 16 Feb 2026 13:50:07 +0000
From: Oliver Neukum <oneukum@suse.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 2/2] hid: hid-pl: eliminate private debug macro
Date: Mon, 16 Feb 2026 14:44:01 +0100
Message-ID: <20260216134958.260648-3-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216134958.260648-1-oneukum@suse.com>
References: <20260216134958.260648-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Use proper dynamic debugging.

V2: resend full series

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/hid/hid-pl.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-pl.c b/drivers/hid/hid-pl.c
index dc11d5322fc0..4b6b33597d11 100644
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
+	dev_dbg(&dev->dev, "called with 0x%04x 0x%04x", left, right);
 
 	left = left * plff->maxval / 0xffff;
 	right = right * plff->maxval / 0xffff;
 
 	*plff->strong = left;
 	*plff->weak = right;
-	debug("running with 0x%02x 0x%02x", left, right);
+	dev_dbg(&dev->dev,"running with 0x%02x 0x%02x", left, right);
 	hid_hw_request(hid, plff->report, HID_REQ_SET_REPORT);
 
 	return 0;
@@ -119,7 +115,7 @@ static int plff_init(struct hid_device *hid)
 			report->field[0]->value[1] = 0x00;
 			strong = &report->field[0]->value[2];
 			weak = &report->field[0]->value[3];
-			debug("detected single-field device");
+			dev_dbg(&hid->dev, "detected single-field device");
 		} else if (report->field[0]->maxusage == 1 &&
 			   report->field[0]->usage[0].hid ==
 				(HID_UP_LED | 0x43) &&
@@ -134,7 +130,7 @@ static int plff_init(struct hid_device *hid)
 			weak = &report->field[3]->value[0];
 			if (hid->vendor == USB_VENDOR_ID_JESS2)
 				maxval = 0xff;
-			debug("detected 4-field device");
+			dev_dbg(&hid->dev, "detected 4-field device");
 		} else {
 			hid_err(hid, "not enough fields or values\n");
 			return -ENODEV;
-- 
2.53.0

