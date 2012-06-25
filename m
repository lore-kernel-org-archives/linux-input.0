From: Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH] samples/hidraw: ignore hid-example file
Date: Mon, 25 Jun 2012 13:35:55 +0200
Message-ID: <m2hatz1v50.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:36102 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab2FYLf5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 07:35:57 -0400
Received: from frontend4.mail.m-online.net (unknown [192.168.8.183])
	by mail-out.m-online.net (Postfix) with ESMTP id 3WLSxv2DMTz4KKBn
	for <linux-input@vger.kernel.org>; Mon, 25 Jun 2012 13:36:03 +0200 (CEST)
Received: from igel.home (ppp-93-104-154-81.dynamic.mnet-online.de [93.104.154.81])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3WLSxl51hzzbbcs
	for <linux-input@vger.kernel.org>; Mon, 25 Jun 2012 13:35:55 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 samples/hidraw/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 samples/hidraw/.gitignore

diff --git a/samples/hidraw/.gitignore b/samples/hidraw/.gitignore
new file mode 100644
index 0000000..05e51a6
--- /dev/null
+++ b/samples/hidraw/.gitignore
@@ -0,0 +1 @@
+hid-example
-- 
1.7.11.1


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
