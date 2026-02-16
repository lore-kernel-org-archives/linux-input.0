Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAADA2C0F8E
	for <linux-input@vger.kernel.org>; Mon, 16 Feb 2026 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771249823; cv=none; b=bXKcMJRmgKZIPeos0mcFnJOf00FOlr2Uhsmh3/6CRB60dOc4hwDMnsGhgVbK2CFaIbRy5QZdD95LnOlO0hbG2/fzmRK1M6SEu2pWV4Z6DVnP3okVfoXsd2kLfMngzBlOOljlaIbw/hT9Kj6RLH5WFKj3KVCFdmbYkCKffgkhbxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771249823; c=relaxed/simple;
	bh=EdySwl7INbiW37OAVmD6OlVMBRe3VgamUvWf/zzBXNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z32+OnQOOqBmcAO/AutW4GMsdNESxM+DAuyeelmam4Uj7ossgOP7B0hSM5q2hLZ1UKXl9+LO63imhsp9Vmsu3j7Bsz0GuZDbBVBtsYDoeYOX88SKRARD4N/E9Ho5SjHUWZw2Ozmk1QKE0UW2h/E+Z3R0PEiLng5i6pW6rlK9iHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WCTFXue3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WCTFXue3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WCTFXue3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WCTFXue3"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2C0C05BD82;
	Mon, 16 Feb 2026 13:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771249808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJQHaPDeQnQT1UVWU+fCmZAgJxcNcQSnSfiOuzlQq50=;
	b=WCTFXue3smNJAdZnXO5RRzCVYaK9BIzEMYaumyPkOlo4ZZELt6CVKXVKvz4q4cqdmzrjUe
	jLej6DBH7QiSarZzURLnOi3jBCUpRccY7u+uCtDXcIsJCRfJieFgn2O/UZPicJJRxsNlbP
	Tq5oIEf7jyeRXq8y/RFPoEL7FKnrBis=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771249808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJQHaPDeQnQT1UVWU+fCmZAgJxcNcQSnSfiOuzlQq50=;
	b=WCTFXue3smNJAdZnXO5RRzCVYaK9BIzEMYaumyPkOlo4ZZELt6CVKXVKvz4q4cqdmzrjUe
	jLej6DBH7QiSarZzURLnOi3jBCUpRccY7u+uCtDXcIsJCRfJieFgn2O/UZPicJJRxsNlbP
	Tq5oIEf7jyeRXq8y/RFPoEL7FKnrBis=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79F8A3EA64;
	Mon, 16 Feb 2026 13:50:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iJOQHI8gk2k3BAAAD6G6ig
	(envelope-from <oneukum@suse.com>); Mon, 16 Feb 2026 13:50:07 +0000
From: Oliver Neukum <oneukum@suse.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>,
	stable@vger.kernel.org
Subject: [PATCHv2 1/2] hid: hid-pl: handle probe errors
Date: Mon, 16 Feb 2026 14:44:00 +0100
Message-ID: <20260216134958.260648-2-oneukum@suse.com>
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
X-Spam-Score: -2.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

Errors in init must be reported back or we'll
follow a NULL pointer the first time FF is used,
because plff_init() initializes the private member.

V2: resend full series

Fixes: 20eb127906709 ("hid: force feedback driver for PantherLord USB/PS2 2in1 Adapter")
Cc: <stable@vger.kernel.org>
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/hid/hid-pl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-pl.c b/drivers/hid/hid-pl.c
index 3c8827081dea..dc11d5322fc0 100644
--- a/drivers/hid/hid-pl.c
+++ b/drivers/hid/hid-pl.c
@@ -194,9 +194,14 @@ static int pl_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err;
 	}
 
-	plff_init(hdev);
+	ret = plff_init(hdev);
+	if (ret)
+		goto stop;
 
 	return 0;
+
+stop:
+	hid_hw_stop(hdev);
 err:
 	return ret;
 }
-- 
2.53.0

