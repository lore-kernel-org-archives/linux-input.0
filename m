Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C6839936D;
	Tue, 16 Jun 2026 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781643080; cv=none; b=EugdLcfUz4tOtmENLh/J97HoiN4k2Jn7xfRQESJLBQR1GX4W2qKhGlQobJlaAh0nWMtCklxQQKuURSAqUGwGgdDte6gIIBBkXfrIn3QZdc2bRThQVFe0QKWgNtajhJUEEbg1OBQwqO75HhpiWewVel7MSVcAdrk6qb+5tjnpYQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781643080; c=relaxed/simple;
	bh=tnupkzwy2fP5SwHv5stmI957/nksX38wBEKhQh2muys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMdIdYyvGD6EBRRDCLf3wBrHAeECFufrBU8u7W7sXwtWy73gaiZfhyghtSPBJtS5aYv58zf5mwudtjXcXDYZBDolxs+mPqXt+XQZRsGet7slvFljKzlkedVGupxwslM6ZwA3U/HBwHjmIerJcFlV8LD0BUJyzRdt1tZu6ho9OGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=XGXjtcxg; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=FBHpJNGb; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XGXjtcxg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FBHpJNGb"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gfzfp5VkVz9tRk;
	Tue, 16 Jun 2026 22:51:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781643074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0IzdGvudwRTyPm0tm0GsEwNvsY9TlUW4g3dicT/2fzc=;
	b=XGXjtcxgtIw7Exbz2SgG5OfbtBw8DbUFZvpcP1WHb0BT8WdVlJvA/eqnHhZHEyOc0eOxms
	8X4HKOUBUPS9hbKLwQHaqNCuznTbEoxPtplmBOWre/BRegsiIwnYPfnJSqdj3wwY99wepw
	hM3Kt6JB1skvj4ivpDOKJ8T5//98GvPLvytZKtma3OiVCmlszr6cMiLXOVOUDhR9ysyBNi
	mgi+05c49vOORO+b1S8LhlKVtKbauf3cxfJ/tKrlYnaGKQzNBnPdZ2uPMtYu1/qJDF/ElF
	5o3/JFjdDb8TuzUnI0F7XY69+PR56Hub2XL/4oiBRZvtwPjyRHGNab1merGayA==
From: Rosalie Wanders <rosalie@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781643073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0IzdGvudwRTyPm0tm0GsEwNvsY9TlUW4g3dicT/2fzc=;
	b=FBHpJNGbKPSBTXB59sr2nkN9l5zhgu9QisWBU0Oa5UHjhoyY6OfMmiTsAuj4dBYvd1Dcyh
	YXAwvKYCQFlNiRDE7j+DEPNTwjPCUSMhgoiPXcNkL+hltDQDvNAYET7D8u7HV8oI18uh4x
	Lj+imB2YXphtYaKr4ILeT1AI2UmkTHFdH0bhvd8UUtwfjaZFM/6tZCcqlOTVbEJvpT/Bws
	JllXnvVH/V3ZlRYRkP5T2dH42EDPaWhgBYejbTS6dxQCDI/4nbrdFhsHfvDZjkSlPIpRIH
	D4zAUF+je/cGPUrnR/WMKMHzsmZ62aYMWHztDsagMhrGwJ2qmGtGNxSCtEj0Xw==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rosalie Wanders <rosalie@mailbox.org>
Subject: [PATCH v2 0/4] HID: sony: more cleanup
Date: Tue, 16 Jun 2026 22:50:39 +0200
Message-ID: <20260616205042.6671-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4noxtacimhocu6qx7n5a3wu1escheadx
X-MBO-RS-ID: 9806fc0fa6aea3e5222

This series cleans up hid-sony by utilizing modern helper functions.

v2: the dependent patches have been included in this series

Rosalie Wanders (4):
  HID: sony: use dedicated raw_event() handlers in sony_raw_event()
  HID: sony: use guard() and scoped_guard()
  HID: sony: remove unneeded which argument from sony_schedule_work()
  HID: sony: use devm_kasprintf()

 drivers/hid/hid-sony.c | 245 +++++++++++++++++++++--------------------
 1 file changed, 126 insertions(+), 119 deletions(-)

-- 
2.54.0

