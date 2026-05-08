Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34B6330D22;
	Fri,  8 May 2026 04:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778216148; cv=none; b=fa+Hx4wGKD7Pa/Qs6M0SWyi3duWG2uT7EiLqrffUTXVhC+/Opm9J/SjMcLVc65qO8UXtMcsmnywRAxmOUsypn+ErppwU4kBVClkTtkEgsYJF4ouYqFLRvA/m2NIfCD2os8tqvmgBy50GaBLnNix3V0PCGNrJuXNst4VuGH2tKec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778216148; c=relaxed/simple;
	bh=J1zgZO+/2447tRaMre3pgc6Vifppsh5aALstEuVdlMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E6f58/RAwTJhUCqGB08jUmGucxY1tVDZxeEKkZbiuZPHhnNRqozuyS1B88mZ8B0EVuQTV7I1iJT2ZX1+8Usi0w6mSY9tHz1MI21xfNlkQdmreSdQIdpU94+oeBiRXvs32p34+7y53gYDEH2OtD8iAW2rt3MlJkiGBfj3NHWuGLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SeIzjINe; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=eAkZ0069; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SeIzjINe";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eAkZ0069"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gBcJ95H3cz9tWS;
	Fri,  8 May 2026 06:55:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1778216137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+tIszHbXTnj825TmQYQJVRkpkWfza0VUSXkzJfEbQxM=;
	b=SeIzjINe44/pf3WOYpJ6pRjmez90QEyAPnpxr3zoW73OBGputvyrJ62JqztHCcTb2k/YDx
	+JhkIKILrWMOQ/lAipAAneAyabuPD5bn+F1JBj+9k9YOj03ga7FzL1QfnmDjWirW+p20VR
	b2qJcoAKJIbcNwSFtDCZcnIx5J8XdZMKAKCMmWv2tdM6vLVpOpteOB7JuFKj6Mb5wKKa/E
	bM7cl53qFhHgS4dRdMZSMCiNXf7vGwGo8310XsUpPiT3Eex63R/DTLdiyq2sIy8GNPt+29
	o3yfT2QCqdC907SjH4ms/F6b9rMi+Cf+6lQS7R7n9ZKM8K0Ih8LbqXnoA8iwwg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=eAkZ0069;
	spf=pass (outgoing_mbo_mout: domain of rosalie@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=rosalie@mailbox.org
From: Rosalie Wanders <rosalie@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1778216136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+tIszHbXTnj825TmQYQJVRkpkWfza0VUSXkzJfEbQxM=;
	b=eAkZ0069oYd7dh5V1iUA2A/pfZsPaAXGyO4QXppK+W4usVH05qOKP4GDgwF3/774w83xIP
	DFI66A/wH3T1kaG0bEpKLeBjxMRnaN8a04MmHWTmRu3QdSNCU/4cXK8waq+/x2V8pcDARW
	ckbgufe2t5kRWxQpzkiiYrUCoQv5BcAK5+f1QzFW+OHWx4A5Z9jff83FgIpbCW06cslrOQ
	fk+TNF8WPVpQuHru8QMOeDPDgbvMq6+BIdOBXpHSq/7twgOUuWG3ZV9r+iO5KILQtMao8H
	/Jc9Bu+wXMemWieKqFxxaRtCwfxC+SG/CCctrRcyjexJjdNqZ5apHanbmUk/Vw==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rosalie Wanders <rosalie@mailbox.org>
Subject: [PATCH 0/3] HID: sony: more cleanup
Date: Fri,  8 May 2026 06:51:08 +0200
Message-ID: <20260508045111.495032-1-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 7mupm61p1mm56rwx149gwzkcrteuth51
X-MBO-RS-ID: ab6d17b0696edcaa92b
X-Rspamd-Queue-Id: 4gBcJ95H3cz9tWS

This series cleans up hid-sony by utilizing modern helper functions.

This series depends on the following patches:
- HID: sony: use input_dev from sc struct in sony_init_ff()
- HID: sony: use dedicated raw_event() handlers in sony_raw_event()

Rosalie Wanders (3):
  HID: sony: use guard() and scoped_guard()
  HID: sony: remove unneeded which argument from sony_schedule_work()
  HID: sony: use devm_kasprintf()

 drivers/hid/hid-sony.c | 100 +++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 64 deletions(-)

-- 
2.54.0

