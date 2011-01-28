From: riyer@nvidia.com
Subject: [PATCH v1] input: tegra-kbc: Fix keymap for LeftMeta key.
Date: Fri, 28 Jan 2011 12:01:44 -0800
Message-ID: <1296244904-31118-1-git-send-email-riyer@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: olof@lixom.net, achew@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Rakesh Iyer <riyer@nvidia.com>
List-Id: linux-input@vger.kernel.org

From: Rakesh Iyer <riyer@nvidia.com>

Correct key mapping for Left Meta key.

Signed-off-by: Rakesh Iyer <riyer@nvidia.com>
---
 drivers/input/keyboard/tegra-kbc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 9394766..6ca903a 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -86,7 +86,7 @@ static const u32 tegra_kbc_default_keymap[] = {
 	KEY(0, 5, KEY_Z),
 	KEY(0, 7, KEY_FN),
 
-	KEY(1, 7, KEY_MENU),
+	KEY(1, 7, KEY_LEFTMETA),
 
 	KEY(2, 6, KEY_RIGHTALT),
 	KEY(2, 7, KEY_LEFTALT),
-- 
1.7.0.4
