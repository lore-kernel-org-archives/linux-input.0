Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F0B349B15;
	Tue, 24 Mar 2026 20:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774385023; cv=none; b=W17Djtnp/64iFK7ywwhFepdNLsZzVu7dlsL2y7zpEYAHzEqDL10XAXfeA+GrBvUNOOs7I+ZcgQK/JVE2yY5zdazJGw/mDqTK6/MUKYTwoCo3WJ79u2z++VeGq407o3ytnz0WbnLy8gKtEsUnX1P57v5/yo0oPXp4qKxstP92Cmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774385023; c=relaxed/simple;
	bh=zIjaFuHVsgATx3kOGS+yxxCDKfhOBnpZGownF3ywmCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A3/5nBbPmdBNu5Fbw103axDRcp0jKIdyvgHCIlQM/N47fXWaIiUkgtg+pC/S8nMJBiA4C6yuTmlthhIHheAWRQ8Qiuh0Nwns7+AN0Gnlv8lNLWV5DbwABnqHC70TPliY3BkTwyBzDbqhTpSGD16qwk/vPoo8uWcP1D5RkcYEfBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lodewillems.com; spf=pass smtp.mailfrom=lodewillems.com; dkim=pass (2048-bit key) header.d=lodewillems.com header.i=@lodewillems.com header.b=RNDsfnNj; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lodewillems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lodewillems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lodewillems.com header.i=@lodewillems.com header.b="RNDsfnNj"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fgMSh59NCz9tnT;
	Tue, 24 Mar 2026 21:43:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lodewillems.com;
	s=MBO0001; t=1774385012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vo0WoiOwSs1ZytETNhbzaLr+3NJA/ey1WnXjpVlnyTw=;
	b=RNDsfnNj+2ijdaVxtonf25IPl55rSFvnFMhb6ptZQCWEzb/bN8yiXOBYh1KOCj96bmYDO7
	7CNOTFaGSGzopFeJ3mFROhsuqr4fBsFZGKHM8B79tsD41sarkqo3I94htZefQN79yxuGd8
	x/khHwZmrX2YHwMhJTOm5FkDmB01S60yZ22HEbEmfH5gTAu/Zc098qc4JK6exmED3CC+88
	zMtF2YvAlRs/76zF/uAPzFuSydXuEyDpLEv7ftM6YPQv5QCF4TX58oB/yIYIZhSr3ZfxoJ
	AlMfUUkqSOsCgCnV7QPIo3K/hwBBA6kMOY7i+6BZc2a5X7IBAeCc6TcSD66Naw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of me@lodewillems.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=me@lodewillems.com
From: Lode Willems <me@lodewillems.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	linux-kernel@vger.kernel.org,
	Lode Willems <me@lodewillems.com>,
	Dominykas Svetikas <dominykas@svetikas.lt>
Subject: [PATCH] HID: Kysona: Add support for VXE Dragonfly R1 Pro
Date: Tue, 24 Mar 2026 21:43:06 +0100
Message-ID: <20260324204306.694760-1-me@lodewillems.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4fgMSh59NCz9tnT

Apparently this same protocol is used by more mice from different brands.

This patch adds support for the VXE Dragonfly R1 Pro.

Tested-by: Dominykas Svetikas <dominykas@svetikas.lt>
Signed-off-by: Lode Willems <me@lodewillems.com>
---
 drivers/hid/hid-ids.h    | 4 ++++
 drivers/hid/hid-kysona.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index afcee13bad61..772f24e80baa 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1471,6 +1471,10 @@
 #define USB_VENDOR_ID_VTL		0x0306
 #define USB_DEVICE_ID_VTL_MULTITOUCH_FF3F	0xff3f
 
+#define USB_VENDOR_ID_VXE		0x3554
+#define USB_DEVICE_ID_VXE_DRAGONFLY_R1_PRO_DONGLE	0xf58a
+#define USB_DEVICE_ID_VXE_DRAGONFLY_R1_PRO_WIRED	0xf58c
+
 #define USB_VENDOR_ID_WACOM		0x056a
 #define USB_DEVICE_ID_WACOM_GRAPHIRE_BLUETOOTH	0x81
 #define USB_DEVICE_ID_WACOM_INTUOS4_BLUETOOTH   0x00BD
diff --git a/drivers/hid/hid-kysona.c b/drivers/hid/hid-kysona.c
index 09bfe30d02cb..ccbd8380064e 100644
--- a/drivers/hid/hid-kysona.c
+++ b/drivers/hid/hid-kysona.c
@@ -272,6 +272,8 @@ static void kysona_remove(struct hid_device *hdev)
 static const struct hid_device_id kysona_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYSONA, USB_DEVICE_ID_KYSONA_M600_DONGLE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYSONA, USB_DEVICE_ID_KYSONA_M600_WIRED) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_VXE, USB_DEVICE_ID_VXE_DRAGONFLY_R1_PRO_DONGLE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_VXE, USB_DEVICE_ID_VXE_DRAGONFLY_R1_PRO_WIRED) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, kysona_devices);
-- 
2.53.0

