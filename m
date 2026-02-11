Received: from mail.cock.li (unknown [37.120.193.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92B0338F4A;
	Wed, 11 Feb 2026 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.193.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770807092; cv=none; b=o5WJCm5kibazednfCGm7j4ZUP/XNqiEKxmHxR/3U6v52DHJi+oEvFdcq38CLbEDnV9EFghw1Ji9AQFdYFQBkYQ8iEM7Tb6qnnVtVTA51Vqir8tke9wWDkamFQPCQyREM6NnRwOdpubkLTY3U0wmpxxCWSfQjrw1MjYoUdMAEmig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770807092; c=relaxed/simple;
	bh=aH+oM3kQl4R9J6qc74bliGxfT/qYPbqrFR/OH+LR3jo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kq+8ez4KvMGw0NuLNZgdVmp1kKUJ/e5oXcciqtsBc1wIlf9x6pXV00spYQlUsiYnsKFBQZxYXaU8inc9MCaa/SH6qdFMKupPIsvFbcRECV86ZNBAxCMVvCVtgVM/CgDtfTmehLPG/hv68SzRp7noMsNfhr9U60A1fKTDDcCi7no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airmail.cc; spf=pass smtp.mailfrom=airmail.cc; dkim=pass (2048-bit key) header.d=airmail.cc header.i=@airmail.cc header.b=ZBjT/ySj; arc=none smtp.client-ip=37.120.193.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airmail.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airmail.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=airmail.cc header.i=@airmail.cc header.b="ZBjT/ySj"
From: Hans Anda <hansa@airmail.cc>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=airmail.cc; s=mail;
	t=1770807084; bh=aH+oM3kQl4R9J6qc74bliGxfT/qYPbqrFR/OH+LR3jo=;
	h=From:To:Cc:Subject:Date:From;
	b=ZBjT/ySj5/y/xhGuN/iJ8TFRd4jhVzLnpYoO3ma0vezUwATsYmPIqMRac/mE61BIn
	 yI0SdqbEFj+vA5EZVI94VtMlMLh3Jbb2WbFwcrM9sqJNPvyxRilGkLM5xpFIIjzZq5
	 Q28d4drSLLM0nVZ1iMttyfoqx15/2SZTheMMOcrZfVBbHaaYFXrIf7GQQjVgeRM7cM
	 yjKq/EdovITBX6dtlHYT74XcIUnero254/yLkfmRJdpjDPdGV9SWDyjX110F4OrGxr
	 xQY5wPKLEm2wgb0s4BtLgdVSV7REQOABmYtFclcI8zB1UGCYdb7N6dZpHeCtP0skvw
	 0/giwraTYLhCA==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes <johannes@gnu-linux.rocks>,
	Hans Anda <hansa@airmail.cc>
Subject: [PATCH] HID: hid-mcp-2200.c: fix typos in comments
Date: Wed, 11 Feb 2026 11:49:07 +0100
Message-ID: <20260211104906.21855-2-hansa@airmail.cc>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

