From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [PATCH v4 2/2] kernel-parameters: Update i8042.reset parameter documentation
Date: Sun, 25 Sep 2016 10:25:44 -0300
Message-ID: <1474809944-7357-3-git-send-email-marcos.souza.org@gmail.com>
References: <1474809944-7357-1-git-send-email-marcos.souza.org@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474809944-7357-1-git-send-email-marcos.souza.org@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 Documentation/kernel-parameters.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index a4f4d69..5ee70bd 100644
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
