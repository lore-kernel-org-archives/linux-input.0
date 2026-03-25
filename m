Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822153D3CF7
	for <linux-input@vger.kernel.org>; Wed, 25 Mar 2026 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449187; cv=none; b=cWFUFA15ql/CoE5v3Na9c/cVRy2n46pA6OnYGd9FCFULTvSlM4t3OF8gJOCsKLkvW6ohbJ6jzaBKiCG1N2dCNF87W01H0ibFByEbcvfk50eoFUxDRZwjsXb3TLMNre7t8KKukD+Aq3u0aXPo1aFXqUr3Qk9Gk6/ehGI1YewMrGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449187; c=relaxed/simple;
	bh=U4esxdglBSV+XB12gtAnnXOGYASNejWT7joUf4KW/tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mnNWKNahl8y73bvFkp0EQ3BMM5qoSy69DA7yIed2rwFcHDcAE1Rrn6s1NaZZPeyZNrJ6f4SZfPXWZ2hpMO0V2X+yQBKFJEcmRqFo4odgy7bMQEAyOnMOukCRBD7MgAElseTxZmF2H83ytmvMsOJtiKVSWz6EXCK8X1R8frvNOrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vUK+XB/n; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=r99mmW4v; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vUK+XB/n";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="r99mmW4v"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D19D4D247;
	Wed, 25 Mar 2026 14:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1774449184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AzVGuJIrsSUKUkzeVgwVMDljJqZvoGpf7rRrmZ8TLqk=;
	b=vUK+XB/nXxLfIMk9yY0ruNhHSkPNW8Imo5lX+6HwGVHxKBgzfoFDNThB1ZTTMfdW709EFG
	795WQui8d8rGWyCmuzz3iZl8PqYrU0KE3kj8LNVa5B4fStYKJY+yl/pFrtqYAuy/cMxVIq
	6jPljS2FQaj1fe6sGcNWj0CjeA7/Lrc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1774449183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AzVGuJIrsSUKUkzeVgwVMDljJqZvoGpf7rRrmZ8TLqk=;
	b=r99mmW4vSImsIfl8jbohr9MIbx75SCAiuc0g8q7iqvJ3tsmytd46ItZrfFC61yq+pJvYC9
	HfUWfbnoTQdey0YhOGDIShf/6G7zxGPzKxVo3Mb64SvLMALktXHNS+znBAnrJvwF9kN5AI
	lINTtDGWD9pESWqnEGDz9VnOR+I8gbA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F28E4444C;
	Wed, 25 Mar 2026 14:33:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FJ/4HR/yw2lSTAAAD6G6ig
	(envelope-from <oneukum@suse.com>); Wed, 25 Mar 2026 14:33:03 +0000
From: Oliver Neukum <oneukum@suse.com>
To: dmitry.torokhov@gmail.com,
	kees@kernel.org,
	linux-input@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 1/2] input: aiptek: use HID headers
Date: Wed, 25 Mar 2026 15:32:46 +0100
Message-ID: <20260325143256.371854-1-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spam-Level: 

The driver uses its own definitions for HID requests.
This leads to duplication and obfuscation. Use HID's
definitions.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/input/tablet/aiptek.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index 6df24cee3c9d..1ad3c19aa155 100644
--- a/drivers/input/tablet/aiptek.c
+++ b/drivers/input/tablet/aiptek.c
@@ -57,6 +57,7 @@
  *      http://aiptektablet.sourceforge.net.
  */
 
+#include <linux/hid.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -164,8 +165,6 @@
 
 #define USB_VENDOR_ID_AIPTEK				0x08ca
 #define USB_VENDOR_ID_KYE				0x0458
-#define USB_REQ_GET_REPORT				0x01
-#define USB_REQ_SET_REPORT				0x09
 
 	/* PointerMode codes
 	 */
@@ -856,7 +855,7 @@ aiptek_set_report(struct aiptek *aiptek,
 
 	return usb_control_msg(udev,
 			       usb_sndctrlpipe(udev, 0),
-			       USB_REQ_SET_REPORT,
+			       HID_REQ_SET_REPORT,
 			       USB_TYPE_CLASS | USB_RECIP_INTERFACE |
 			       USB_DIR_OUT, (report_type << 8) + report_id,
 			       aiptek->ifnum, buffer, size, 5000);
@@ -871,7 +870,7 @@ aiptek_get_report(struct aiptek *aiptek,
 
 	return usb_control_msg(udev,
 			       usb_rcvctrlpipe(udev, 0),
-			       USB_REQ_GET_REPORT,
+			       HID_REQ_GET_REPORT,
 			       USB_TYPE_CLASS | USB_RECIP_INTERFACE |
 			       USB_DIR_IN, (report_type << 8) + report_id,
 			       aiptek->ifnum, buffer, size, 5000);
-- 
2.53.0

