Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495212FFDD5
	for <linux-input@vger.kernel.org>; Mon, 16 Feb 2026 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771249812; cv=none; b=dHLTc93DtXWaZnf7wbTAqpY7zRjf9iWUtnUtiJ3D1TqyDR8nWdAd+MP0A8JvOzjDS5KADdodg4rG2BJresJKC/vtt1vQ7NqZ1ROI39yzNa84T5AuQW9EaC94cqdFJHXtgWRZgVgE6p0uOumESmmxIfAVAEgsYk4MwwfEENjNnCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771249812; c=relaxed/simple;
	bh=sUheDx+jFpdcOOXNRUwWwpTjxD6KJLuI7Tf5F0Uu2ck=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sI5ZqaPF2WTfnr52QAYp2iH2Wxzztr3L8/atLmnlwuIRbEP8n4mFY2jlRTPwZ6mC1Qk9EG70f/aswPpvR5ZdS2sQXKeeE5OxtlbgoCxu6cZWuvPStxkRk8kco2lmRGWKSPKFtqTk7lT6huXjhuwoG/fzRN9qD85KpmICJTGbqn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S7uc1TRl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S7uc1TRl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S7uc1TRl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S7uc1TRl"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7D1F43E828;
	Mon, 16 Feb 2026 13:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771249807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sUheDx+jFpdcOOXNRUwWwpTjxD6KJLuI7Tf5F0Uu2ck=;
	b=S7uc1TRlnpAFZKzK5ItZl3o/fmjZTLjBhde5mi3OXtVofTYfqBT2nPSM5hpI6aPEwM1EGw
	JFfEmQ14jxIoBFDMoFce99JTvWxc4vv3zcDLGqtz+NsaEQCM0vO0VM5W76WIyOXBkSP15C
	fXYdF1pOJB5JpkQ36TmdRlt1CGFNXZg=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=S7uc1TRl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771249807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sUheDx+jFpdcOOXNRUwWwpTjxD6KJLuI7Tf5F0Uu2ck=;
	b=S7uc1TRlnpAFZKzK5ItZl3o/fmjZTLjBhde5mi3OXtVofTYfqBT2nPSM5hpI6aPEwM1EGw
	JFfEmQ14jxIoBFDMoFce99JTvWxc4vv3zcDLGqtz+NsaEQCM0vO0VM5W76WIyOXBkSP15C
	fXYdF1pOJB5JpkQ36TmdRlt1CGFNXZg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C6BE3EA62;
	Mon, 16 Feb 2026 13:50:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EpH3Bo8gk2k3BAAAD6G6ig
	(envelope-from <oneukum@suse.com>); Mon, 16 Feb 2026 13:50:07 +0000
From: Oliver Neukum <oneukum@suse.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCHv2 0/2] hid: hid-pl.c update
Date: Mon, 16 Feb 2026 14:43:59 +0100
Message-ID: <20260216134958.260648-1-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-2.99)[99.96%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Score: -3.00
X-Rspamd-Queue-Id: 7D1F43E828
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

This seems to have fallen through the cracks. The first
patch eliminates a failure to properly handle errors
in probe. We have to give up in the error case or
a pointer will remain uninitialized and wil eventually be followed.
Secondly we fix a debug macro by going to dynamic debugging.

V2: resend the full series
