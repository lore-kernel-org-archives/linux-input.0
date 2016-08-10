From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [PATCHv3 1/2] kernel-parameters: Update i8042.reset parameter documentation
Date: Wed, 10 Aug 2016 00:25:44 -0300
Message-ID: <1470799545-1102-2-git-send-email-marcos.souza.org@gmail.com>
References: <1470799545-1102-1-git-send-email-marcos.souza.org@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33139 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932544AbcHJD0a (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Aug 2016 23:26:30 -0400
Received: by mail-qk0-f193.google.com with SMTP id x189so2557567qkd.0
        for <linux-input@vger.kernel.org>; Tue, 09 Aug 2016 20:26:29 -0700 (PDT)
In-Reply-To: <1470799545-1102-1-git-send-email-marcos.souza.org@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: Marcos Paulo de Souza <marcos.souza.org@gmail.com>

---
 Documentation/kernel-parameters.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 46c030a..9526854 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1457,7 +1457,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 	i8042.nopnp	[HW] Don't use ACPIPnP / PnPBIOS to discover KBD/AUX
 			     controllers
 	i8042.notimeout	[HW] Ignore timeout condition signalled by controller
-	i8042.reset	[HW] Reset the controller during init and cleanup
+	i8042.reset	[HW] Reset the controller during init and cleanup, only
+			     on cleanup, or never reset
+			Format: { 1 | Y | y | 0 | N | n }
+			1, Y, y: init and cleanup
+			0, N, n: don't reset controller
+			Default: only on cleanup
 	i8042.unlock	[HW] Unlock (ignore) the keylock
 	i8042.kbdreset  [HW] Reset device connected to KBD port
 
-- 
2.7.4

