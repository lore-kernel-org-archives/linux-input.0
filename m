Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BCF1BBBFC;
	Thu,  9 Jul 2026 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606347; cv=none; b=KvbKUz3tWSfBeX9hVQgdb3vZST6bRc3U0IBf+PVzQSvzPwbHvCfRCsWl80bX7jljKYbr317JJUu9cKZqRPWnnvv+hLZSGk426pmc/HWkA/cORCOJLLGO1ra/FuxzDMrRvurNhTPvns0mflBH01skOsVR/tdu0BFy+1J/vM0fUwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606347; c=relaxed/simple;
	bh=bKJmCatGA7ehKpFGhiv9DNgSnHbjIzSjX6WjISnujLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvjg9tDuB4b1OSVMnoUiCjiI1Hw8b1RwI8ZdjuayJ9U11UQpn9v/lwT6PQcTDi4n8d8vNMaWh/fbFQDT3AWHy4tt8THk4lv5nNQxS8xlYTlak2DsnTheQPSaFyPl2nBtiu7oHAtuIJRb2HcOQWtp5UYjN74uCRfX2hqxHXppOJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=uKw73Sil; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=v6bEfY8y; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uKw73Sil";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="v6bEfY8y"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gwxjz2xGzzMlFh;
	Thu, 09 Jul 2026 16:12:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783606343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FXKGhu/GxUGmwajJSKWfBfg+3iLuYIY9+pV7YiBw+cQ=;
	b=uKw73Sil5nPoPIBJpmbX6wrOlXfPvMy7fD5QeHx9fMUIeCOlei/bBT1C78LW/hd9L8xUyr
	8TsnqYvcOUtwAt8e+ooWB1DIpuITnVHY/HxZFqtm/newvtbN6a0lsGYWJtTmaR1sgp26cE
	JOvv7CK6eti4w5pe4hWNvfbNyPHJ5cShIPulsC6W0iWj0NW5h/uKe++fsPuDRHM+UsoS1O
	AaWM9gllizPWEQqZt0E2Zh96dmNnqTLmWjAJPjBYO9vUTHd/CudnkLLmOcEWlAXSgSSWAb
	etYsTNWJJgwmnC8u+bU80gYHjJTStdRkHjVqJeu/g0+6wBTrpMKEo025LD31Fg==
From: Rosalie Wanders <rosalie@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783606341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FXKGhu/GxUGmwajJSKWfBfg+3iLuYIY9+pV7YiBw+cQ=;
	b=v6bEfY8y7yLfAZ5oXEos3Rh/+WzZrCVKbsJO/lksOzpJ/J4lm1roEx1pualIwA7ka3M9Gr
	nA+mYbFiwewZOO4LCtxPcGf2B9YlHRbWTN6eIotflEe0ZZuu5QFET5CdMHb4HI3SNQtpLU
	yCxquwqn0/PyLtebYSLv/uLrlwpQDlsOZFoCK72GHZsg1R46uQ3TmpJin1DW3tbHQz3RlL
	3fGQtZmAksRJUX5wHKJaRYJvgJy5yQD9I4jaIc+kxSuMBtJm5evM7uz+BKYOhDWi1iOokf
	XkyG+2yJmXGRF2ELOW5AQAKCsViLEtpgnSE+JcUW1T2bD4GK9wfMh3mYgqvoug==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Rosalie Wanders <rosalie@mailbox.org>
Cc: kernel test robot <lkp@intel.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: sony: add missing __packed to struct with static_assert()
Date: Thu,  9 Jul 2026 16:12:03 +0200
Message-ID: <20260709141202.5995-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d7e084ee16398fbe294
X-MBO-RS-META: gyuchebto746un1jhy9zp5w1fgoa8imn

Fixes: 4b9c410e7d6d ("HID: sony: fix style issues")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202607091026.R9Pxd3PG-lkp@intel.com/
Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>
---
 drivers/hid/hid-sony.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 253fff4066eb..b7392467191f 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -505,7 +505,7 @@ struct motion_output_report_02 {
 	u8 r, g, b;
 	u8 zero2;
 	u8 rumble;
-};
+} __packed;
 static_assert(sizeof(struct motion_output_report_02) == 7);
 
 #define SIXAXIS_REPORT_0xF2_SIZE 17
-- 
2.54.0

