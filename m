Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB71D2C027B
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365207; cv=none; b=dpq1fo5RHyvCel/VldZUNEvTIZwY/rAL13oltar8MR46Q980sXI54eVChMgCGL46c82LQDNd9tVFVNw6a4AiAWSYhhKl3eBUjdPSbiTLIZvkCqP1v/toEo3CPKGBkMV/lzUL0i2bUCUN4Sjs7qJHIqlwCtLJVd1k3FDQhKNq9Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365207; c=relaxed/simple;
	bh=hgnOWHbUhU+WFGOOC9rw6+qIFxqIv4vblQzW5vZ4ryE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DwtfyJw92bJBmVadBQo4LOUq+TH2uBN8JlG0kTF7iUsFSj52AUbLd8NJpesA484mnhpkr4ArkMjYkD2oBbgxEgurzSCZtdh0iFGb+nxubDsma0IZqHqCqjgs4SiJN62AXMKLis/e5N1AghZfJ3VB25BaZS+yLXS0p4RXhYw0CFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r2HLICPP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Bd5WQkvF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZIy1K9w8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pN6QajiR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r2HLICPP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Bd5WQkvF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZIy1K9w8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pN6QajiR"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E8D4B6A855;
	Tue, 28 Apr 2026 08:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777365204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ty+HdPAzuif0P2Azj4V0RzT3LuARwUbqAyO91xg9BFQ=;
	b=r2HLICPPnNnWXIl1aKeWtbCfAjpRJ38e9bXTuB6hXPmq3q0X9hHzXwsxxJofmBwtUbVek4
	VHUI2xV7IYHGflWGDnMH4FAUUH56edCWa9McHf3KZKC4+YL4yWargwDPgOzNKk/sKEYjrR
	hJ2W7vvzJte+XM6Lj1CysNbCTz8LiU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777365204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ty+HdPAzuif0P2Azj4V0RzT3LuARwUbqAyO91xg9BFQ=;
	b=Bd5WQkvFtqmPX/IJ15mzhGvGc9uEtUCWRr+uZ5wqHvbgZMATwogXryeMIcTXWulX43Uj3u
	tdT5TmBcTK9Zl9DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZIy1K9w8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pN6QajiR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777365203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ty+HdPAzuif0P2Azj4V0RzT3LuARwUbqAyO91xg9BFQ=;
	b=ZIy1K9w8hTHw7g+EnzVsPfMtJl6NJaxRrHvi5EhI7rsvcKC/RuTm1O7S98OB+nfQiJlLnA
	ofwXW4ZvAy06xqrGp25EXGxqrf0pK7194AQvlXSIhT5hecEXMY3+n1JlCKmFWzxV5bdEXy
	FSq4JEMbb1jGGwfC/9ZAipAuc5sApMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777365203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ty+HdPAzuif0P2Azj4V0RzT3LuARwUbqAyO91xg9BFQ=;
	b=pN6QajiRtpj8ct18K9aIq0SbghodeHd1RFdOtIq4B+cY8buK25rOt5ht8D1y4PdeJEcI4c
	GdMv/BQeTFv5fGBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8B0E593B0;
	Tue, 28 Apr 2026 08:33:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KK/cK9Nw8GmrOwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 28 Apr 2026 08:33:23 +0000
From: Takashi Iwai <tiwai@suse.de>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Henry Martin <bsdhenrymartin@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: uclogic: Fix regression of input name assignment
Date: Tue, 28 Apr 2026 10:33:16 +0200
Message-ID: <20260428083321.126674-1-tiwai@suse.de>
X-Mailer: git-send-email 2.54.0
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
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E8D4B6A855

The previous fix for adding the devm_kasprintf() return check in the
commit bd07f751208b ("HID: uclogic: Add NULL check in
uclogic_input_configured()") changed the condition of hi->input->name
assignment, and it resulted in missing the proper input device name
when no custom suffix is defined.

Restore the conditional to the original content to address the
regression.

Fixes: bd07f751208b ("HID: uclogic: Add NULL check in uclogic_input_configured()")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/hid/hid-uclogic-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index bd7f93e96e4e..b73f09d26688 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -184,7 +184,9 @@ static int uclogic_input_configured(struct hid_device *hdev,
 			suffix = "System Control";
 			break;
 		}
-	} else {
+	}
+
+	if (suffix) {
 		hi->input->name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
 						 "%s %s", hdev->name, suffix);
 		if (!hi->input->name)
-- 
2.54.0

