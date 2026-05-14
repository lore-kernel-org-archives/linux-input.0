Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2305C3955FC;
	Thu, 14 May 2026 12:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778763592; cv=none; b=k1wkXEC11eR+aNqjAbLAUM2us1LoV/yx/wDQOQ1cqP3H22UDctitKpryHIoG7ai+D5bylEvcuDXjz2ksdTgHAcmWRX9EY88xZlflb9VKbPIPcOQqUraC0Tf/2VRn7VM/Q1NWKBWQ7VOhZLmcLb2ZBpuSlHNCLnT9iuRHZEw8CsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778763592; c=relaxed/simple;
	bh=SPbg9e+gU2ru+UIHKUqFcMLEWFTvfPBt3w1CZEYwcjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDXjVt4tZCAVQBwiX03ESgnj+FGUktEcWJ913OLQN1HsXhKu9HUYOxXCAMkxzB/pBKOi2RE/gf0Im26KUrRUWWNnR8k++FUrl2y4bwwVXSGswn5Rpukg72xRKl/8GB2L6CMd3qcZ1kL5o4d9DoGAlTU3ksLYnQK6fGE8Ba4Fyhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HRWr5Z78; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HRWr5Z78"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Gm
	eFscXKgZNM22oNwYh5EA9UGPIevNV0cEQBsvl9dxo=; b=HRWr5Z78BgZ3oe/oz/
	rEvQQIGatZASKc9TpJ8XWEnvS5goFez6N6XTur21E+UYmlCQGPPFKURciK4pJcHJ
	8K3aoVkEuFCqB+V1Dxjl85dgmDhVIc54WxT5pfS0eRxAMcc47nXC6iI5lmmQH95p
	lUpkCQO1LeRfLqITZJBpWBQEM=
Received: from debian (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD39O8CxwVqta1SBQ--.5314S2;
	Thu, 14 May 2026 20:58:42 +0800 (CST)
From: Kean <rh_king@163.com>
To: sashiko-bot@kernel.org,
	derekjohn.clark@gmail.com
Cc: linux-input@vger.kernel.org,
	mpearson-lenovo@squebb.ca,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-kernel@vger.kernel.org,
	Kean <rh_king@163.com>
Subject: [PATCH] HID: lenovo: Fix buffer over-read and unaligned access in X12 Tab raw_event handler
Date: Thu, 14 May 2026 20:58:38 +0800
Message-ID: <20260514125838.3307386-1-rh_king@163.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512044911.99B6DC2BCB0@smtp.kernel.org>
References: <20260512044911.99B6DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD39O8CxwVqta1SBQ--.5314S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr1kJFWkWr15uFy7GF4fAFb_yoW8CryxpF
	WDCFZ8trZ8tw17CF1jvw1v9a45tan7Jry7Cry7tw15ZF9Iyrn3XryS93WYvrn5WFWkur1a
	9r4UKr43uF4jq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEJKsUUUUUU=
X-CM-SenderInfo: 5ukbyxlqj6il2tof0z/xtbC4ATOfWoFxwSpuAAA3q

In lenovo_raw_event(), the X12 Tab keyboard handler reads a 4-byte
little-endian value from the raw HID report buffer but:

  1. The size guard is size >= 3, while the access reads 4 bytes.
     A malformed 3-byte report with ID 0x03 would over-read the
     buffer by one byte.

  2. Casting u8 *data directly to __le32 * can trigger unaligned
     access faults on architectures like ARM, MIPS, and SPARC,
     because HID input buffers carry no alignment guarantee.
     (e.g. uhid payloads start at offset 6 in struct uhid_event,
     giving only 2-byte alignment.)

Fix both by tightening the size check to >= 4 and replacing the
open-coded cast + le32_to_cpu() with get_unaligned_le32(), which
handles the LE-to-CPU conversion safely regardless of alignment.

Link: https://sashiko.dev/#/message/20260512044911.99B6DC2BCB0%40smtp.kernel.org
Assisted-by: CLAUDE:claude-4-sonnet
Signed-off-by: Kean <rh_king@163.com>
---
 drivers/hid/hid-lenovo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index a6b73e03c16b..c11957ae8b77 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -30,6 +30,7 @@
 #include <linux/hid.h>
 #include <linux/input.h>
 #include <linux/leds.h>
+#include <linux/unaligned.h>
 #include <linux/workqueue.h>
 
 #include "hid-ids.h"
@@ -793,8 +794,8 @@ static int lenovo_raw_event(struct hid_device *hdev,
 	 */
 	if (unlikely((hdev->product == USB_DEVICE_ID_LENOVO_X12_TAB
 			|| hdev->product == USB_DEVICE_ID_LENOVO_X12_TAB2)
-			&& size >= 3 && report->id == 0x03))
-		return lenovo_raw_event_TP_X12_tab(hdev, le32_to_cpu(*(__le32 *)data));
+			&& size >= 4 && report->id == 0x03))
+		return lenovo_raw_event_TP_X12_tab(hdev, get_unaligned_le32(data));
 
 	return 0;
 }
-- 
2.53.0

