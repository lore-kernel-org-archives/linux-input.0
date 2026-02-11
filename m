Received: from mail.cock.li (unknown [37.120.193.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E064E29E115;
	Wed, 11 Feb 2026 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.193.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770820422; cv=none; b=Ft0+aXJHNB/UKb76ED8JETOOTpx5Scefp8wuC8h+iGIzSv21A4+M3IuS90K1iLcz01TP7yzR3AznmrmYAPdInlSukewC0CGwsUX+hz0KPlgWrN3fA3785xrFVzdt7lpj/puxL4oZ5TJQfw5WPOgDvoYGeNarW8eLh4KE7R4oAk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770820422; c=relaxed/simple;
	bh=ip0Umi0Tk+RZZ6fpMwSZekX5kkW1Qe3jS0EijFoK18g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DpXbGv7DHaDUAWTHTEJdIVY/AJ2oJbgAsvqQA8j+0cZx7fam0WfL47JdL7XQvqIzd0Tblwqx/jBaDvyH4jWU82r/+KpdQTYlbCQvnNSiBObB2HXTvrQ2iOaoCvAmvjnGug8pjAR3pMqsP6FVgvXd2/ATcSEqNTmz54ATIkK1G9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airmail.cc; spf=pass smtp.mailfrom=airmail.cc; dkim=pass (2048-bit key) header.d=airmail.cc header.i=@airmail.cc header.b=lSaZOm3f; arc=none smtp.client-ip=37.120.193.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airmail.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airmail.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=airmail.cc header.i=@airmail.cc header.b="lSaZOm3f"
From: Hans Anda <hansa@airmail.cc>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=airmail.cc; s=mail;
	t=1770820408; bh=ip0Umi0Tk+RZZ6fpMwSZekX5kkW1Qe3jS0EijFoK18g=;
	h=From:To:Cc:Subject:Date:From;
	b=lSaZOm3fRbAeA8IfdF1WgdkGYV4PFIVVprQZBQg1FY3zbx7WqQql18OmECNN2vvLW
	 zqf9pucbIA8LE91rua6D5X6c2o9qDanK9h+FxFfryslmG9+bT9kyX1IrETIoim208a
	 H+kxJcr5C5T75NDj96GuBMOLI5E7vtQNbr+sd9VIZhtCeyfr2guUBrXsfQVHsl3UD9
	 hPKdmXZ/+uCABPcdFUjbWJKcehoj0XHR3t4sC8p0B0wYMmAm80mmZK0VvHPJsI6Nnr
	 zWn2dwpTJFdDbWesuUgPr5roWqs/ZYWosArqF6KXkJ/y7MfCWHzeZHvos6cAyHXY1r
	 ByXEgiaDcTPTw==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes <johannes@gnu-linux.rocks>,
	Hans Anda <hansa@airmail.cc>
Subject: [PATCH] HID: hid-mcp-2200.c: fix typos in comments
Date: Wed, 11 Feb 2026 15:32:54 +0100
Message-ID: <20260211143253.22829-2-hansa@airmail.cc>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments
drivers/hid/hid-mcp2200.c: "Commands" -> "Command", "Altternative" -> "Alternative"

Signed-off-by: Hans Anda <hansa@airmail.cc>
---
 drivers/hid/hid-mcp2200.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-mcp2200.c b/drivers/hid/hid-mcp2200.c
index dafdd5b4a079..7e2f5e37a85a 100644
--- a/drivers/hid/hid-mcp2200.c
+++ b/drivers/hid/hid-mcp2200.c
@@ -17,7 +17,7 @@
 #include <linux/mutex.h>
 #include "hid-ids.h"
 
-/* Commands codes in a raw output report */
+/* Command codes in a raw output report */
 #define SET_CLEAR_OUTPUTS	0x08
 #define CONFIGURE		0x10
 #define READ_EE			0x20
@@ -30,7 +30,7 @@ enum MCP_IO_DIR {
 	MCP2200_DIR_IN  = 0x01,
 };
 
-/* Altternative pin assignments */
+/* Alternative pin assignments */
 #define TXLED		2
 #define RXLED		3
 #define USBCFG		6
-- 
2.52.0

