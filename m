Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E276F33A9E1
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923612; cv=none; b=bqh8iODYwbroZdIu9IcMneIvFNhTlqOa7w7THbsNFnhDib4fZZz72/XJ8KTwtXIhiFEqJ6ncvhKwTQ5e6EQLHTODTzCev+Jf0GLX/VPX+m/yy3LS91OgAJyZXUgO6eE/xiDJV6LKrcsyjoQ1I7u85banU+fGr3qwCqpJW/T6r7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923612; c=relaxed/simple;
	bh=cJRugB3CPiym1JlnG/8lBfKyOJA2m1cUoX+aWazZSgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HY32voluZdNayHB4HOBiEvi5G+6fTNkzcva97djPl5Z8zcpxafQD+YDrLASG5MbBJKC5iRYMQPNYACTA6HNFo+LZAPIFmgL3EnY4yv6sqzWVN84kwDZkOijFGZ6r/ce1SN/rEELJjUFjiVpTELO64FmZlBHABx1BaNcsVrf5aZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OWOrYEKK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ax9LJiuF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OWOrYEKK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ax9LJiuF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OWOrYEKK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ax9LJiuF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OWOrYEKK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ax9LJiuF"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B6AF3F125;
	Tue, 24 Feb 2026 09:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771923608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Pt0r6RhEhoDp/J7S72e3AZTYIZOvKqrKEC0/7Zna2c0=;
	b=OWOrYEKKA+NnmnlcYrguclutXsnExxtTkh7WEtQDAkpPcmgRMJJ3TeRncqGBRT88UXmdKt
	nENoryw65Bx2++7wbDV/FdvtFYKJYWM6F+tWhbP2oefdWfSbtD0Mv8d6UCDYDWpdKt6cjC
	OFb12SkYNCV4OAGACwakvotM+ovOgGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771923608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Pt0r6RhEhoDp/J7S72e3AZTYIZOvKqrKEC0/7Zna2c0=;
	b=Ax9LJiuFMo8S/pvpOUzEOhyrssrRGdsSoeu9TrrbbioQ+G/UqbBsVPO8Due78fnLxjN+pE
	pIkpEf0RYbu4+rCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771923608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Pt0r6RhEhoDp/J7S72e3AZTYIZOvKqrKEC0/7Zna2c0=;
	b=OWOrYEKKA+NnmnlcYrguclutXsnExxtTkh7WEtQDAkpPcmgRMJJ3TeRncqGBRT88UXmdKt
	nENoryw65Bx2++7wbDV/FdvtFYKJYWM6F+tWhbP2oefdWfSbtD0Mv8d6UCDYDWpdKt6cjC
	OFb12SkYNCV4OAGACwakvotM+ovOgGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771923608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Pt0r6RhEhoDp/J7S72e3AZTYIZOvKqrKEC0/7Zna2c0=;
	b=Ax9LJiuFMo8S/pvpOUzEOhyrssrRGdsSoeu9TrrbbioQ+G/UqbBsVPO8Due78fnLxjN+pE
	pIkpEf0RYbu4+rCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 514173EA68;
	Tue, 24 Feb 2026 09:00:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IN1wEphonWniYQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 24 Feb 2026 09:00:08 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: apple: Add EPOMAKER TH87 to the non-apple keyboards list
Date: Tue, 24 Feb 2026 10:00:02 +0100
Message-ID: <20260224090004.73980-1-tiwai@suse.de>
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
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

EPOMAKER TH87 has the very same ID as Apple Aluminum keyboard
(05ac:024f) although it doesn't work as expected in compatible way.

Put three entries to the non-apple keyboards list to exclude this
device: one for BT ("TH87"), one for USB ("HFD Epomaker TH87") and one
for dongle ("2.4G Wireless Receiver").

Link: https://bugzilla.suse.com/show_bug.cgi?id=1258455
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/hid/hid-apple.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index b949b767cf08..72d98a086647 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -365,6 +365,9 @@ static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
 	{ "A3R" },
 	{ "hfd.cn" },
 	{ "WKB603" },
+	{ "TH87" },			/* EPOMAKER TH87 BT mode */
+	{ "HFD Epomaker TH87" },	/* EPOMAKER TH87 USB mode */
+	{ "2.4G Wireless Receiver" },	/* EPOMAKER TH87 dongle */
 };
 
 static bool apple_is_non_apple_keyboard(struct hid_device *hdev)
-- 
2.53.0

