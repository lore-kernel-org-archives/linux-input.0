Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B549B3264EF
	for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774362319; cv=none; b=rKjIeq/x8ndQ6ljgEXWLUetpKkPrDWpRD38uKhP8ufsNKTUCGa+OaYnPvjMjhPfsqkoiB6pYJ7LpvmLtXU3QK0Z4B4DDG3Dt0af3v8F0qGjYs9QPkv9Zpc13DKbPiHGzY1Q7j5Ixmx2L30qEvttvfZem1wps+3fbv9ssX+cijDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774362319; c=relaxed/simple;
	bh=3QvBchthoOHVbCy8CfjbKSzVJSPT+5XJuQlt/tUBvdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dd8OD4ROSiiYS4Yl2xlUoQeWLzwHYiXNDlOXvi9IblXhKJqBwJgZ9t/YOPB7CWg320f5b/dn7KnPmMZPot0M8Db9NDSHoUJsOKJ88dqWPqnI3G/1M8m4lKYIKj/p2TRLttZAz1eM7qJ8GvBYCI6U/J5fmeGMPX20nB0Il4TMypw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=D4etKWb4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BHbHHLUb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="D4etKWb4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BHbHHLUb"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D13465BCEB;
	Tue, 24 Mar 2026 14:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1774362316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ufxtf7QTVkGvh2epedeXnvaSsWiKPcKKXdefsHTouoY=;
	b=D4etKWb4/vWKn/x7ZMxIyqHIGHOIu0selQHEDALB8CW0wv0SvxMqZEozjYFg5tcfe33BDR
	RyyRZM/Bv+Anp1q3lYDxlnz57SlNpQ7F+K068l/L3DghW+VAHl0WCnOEi1JbCCx6AOHPGR
	LMD6S68s6szxTck13cbx3Yp/2JR4+1s=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=BHbHHLUb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1774362314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ufxtf7QTVkGvh2epedeXnvaSsWiKPcKKXdefsHTouoY=;
	b=BHbHHLUb2U/y8N//z0TSLdbkc9TOJJDA+IniHHoQ1TSduO3i7agvwssH1nkvCO4TQyST1E
	/Ou89xibQ0l8luHYsfWB09VKxDKNoqxoqx2a3AHxI+Vd/dNc8QBbMo6fgvsYiVPZlUFFSg
	p1wRwKC1J+GfvpXM335FBkBMKla+XeM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABA5F43EA6;
	Tue, 24 Mar 2026 14:25:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UJfDKMqewml8ZAAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 24 Mar 2026 14:25:14 +0000
From: Oliver Neukum <oneukum@suse.com>
To: bentiss@kernel.org,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] hid: usbhid: fix deadlock in hid_post_reset()
Date: Tue, 24 Mar 2026 15:24:54 +0100
Message-ID: <20260324142507.74873-1-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid,suse.com:email];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid,suse.com:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Queue-Id: D13465BCEB
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

You can build a USB device that includes a HID component
and a storage or UAS component. The components can be reset
only together. That means that hid_pre_reset() and hid_post_reset()
are in the block IO error handling. Hence no memory allocation
used in them may do block IO because the IO can deadlock
on the mutex held while resetting a device and calling the
interface drivers.
Use GFP_NOIO for all allocations in them.

Fixes: dc3c78e434690 ("HID: usbhid: Check HID report descriptor contents after device reset")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/hid/usbhid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index ddd5d77fb5a5..fd3e1aedc5cb 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1552,7 +1552,7 @@ static int hid_post_reset(struct usb_interface *intf)
 	 * configuration descriptors passed, we already know that
 	 * the size of the HID report descriptor has not changed.
 	 */
-	rdesc = kmalloc(hid->dev_rsize, GFP_KERNEL);
+	rdesc = kmalloc(hid->dev_rsize, GFP_NOIO);
 	if (!rdesc)
 		return -ENOMEM;
 
-- 
2.53.0

