From: Scott James Remnant <scott@canonical.com>
Subject: [PATCH 13/31] input: Auto-load mousedev module when /dev/input/mice opened.
Date: Mon, 2 Mar 2009 18:16:04 +0000
Message-ID: <3d6d5cb4a350d9202ee4a36c076eaab69c8bdfc8.1236702228.git.scott@canonical.com>
References: <cover.1236702228.git.scott@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zelda.netsplit.com ([87.194.19.211]:34601 "EHLO
	zelda.netsplit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754967AbZCJQnj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Mar 2009 12:43:39 -0400
In-Reply-To: <cover.1236702228.git.scott@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

The mousedev module is missing the char-major-13-31 alias that would
cause it to be auto-loaded when the /dev/input/mice device is opened.
This patch adds the alias.

Signed-off-by: Scott James Remnant <scott@canonical.com>
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 drivers/input/mousedev.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index dfde8ee..a290e90 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -29,6 +29,7 @@
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Mouse (ExplorerPS/2) device interfaces");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_CHARDEV(INPUT_MAJOR, MOUSEDEV_MIX);
 
 #ifndef CONFIG_INPUT_MOUSEDEV_SCREEN_X
 #define CONFIG_INPUT_MOUSEDEV_SCREEN_X	1024
-- 
1.6.0.5

