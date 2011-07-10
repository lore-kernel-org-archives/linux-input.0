From: Edwin van Vliet <edwin@cheatah.nl>
Subject: [PATCH 3/3] drivers/input/tablet/aiptek: removed double define
Date: Mon, 11 Jul 2011 00:20:41 +0200
Message-ID: <1310336441-26893-1-git-send-email-edwin@cheatah.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Edwin van Vliet <edwin@cheatah.nl>
List-Id: linux-input@vger.kernel.org

Constant AIPTEK_TOOL_BUTTON_PEN_MODE was diefined twice

Signed-off-by: Edwin van Vliet <edwin@cheatah.nl>
---
 drivers/input/tablet/aiptek.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index 0a619c5..6d89fd1 100644
--- a/drivers/input/tablet/aiptek.c
+++ b/drivers/input/tablet/aiptek.c
@@ -225,7 +225,6 @@
 	/* toolMode codes
 	 */
 #define AIPTEK_TOOL_BUTTON_PEN_MODE			BTN_TOOL_PEN
-#define AIPTEK_TOOL_BUTTON_PEN_MODE			BTN_TOOL_PEN
 #define AIPTEK_TOOL_BUTTON_PENCIL_MODE			BTN_TOOL_PENCIL
 #define AIPTEK_TOOL_BUTTON_BRUSH_MODE			BTN_TOOL_BRUSH
 #define AIPTEK_TOOL_BUTTON_AIRBRUSH_MODE		BTN_TOOL_AIRBRUSH
-- 
1.7.5.4
