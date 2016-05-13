From: Florian Echtler <floe@butterbrot.org>
Subject: [PATCH 2/3] lower poll interval to fix occasional FPS drops to ~56 FPS
Date: Fri, 13 May 2016 11:41:45 -0700
Message-ID: <1463164906-6273-2-git-send-email-floe@butterbrot.org>
References: <1463164906-6273-1-git-send-email-floe@butterbrot.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:33795 "EHLO butterbrot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753443AbcEMSrm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 May 2016 14:47:42 -0400
In-Reply-To: <1463164906-6273-1-git-send-email-floe@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, hverkuil@xs4all.nl
Cc: Florian Echtler <floe@butterbrot.org>, Martin Kaltenbrunner <modin@yuri.at>

The framerate sometimes drops below 60 Hz if the poll interval is too high.
Lowering it to the minimum of 1 ms fixes this.

Signed-off-by: Martin Kaltenbrunner <modin@yuri.at>
Signed-off-by: Florian Echtler <floe@butterbrot.org>
---
 drivers/input/touchscreen/sur40.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index fcc5934..7b1052a1 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -126,7 +126,7 @@ struct sur40_image_header {
 #define VIDEO_PACKET_SIZE  16384
 
 /* polling interval (ms) */
-#define POLL_INTERVAL 4
+#define POLL_INTERVAL 1
 
 /* maximum number of contacts FIXME: this is a guess? */
 #define MAX_CONTACTS 64
-- 
1.9.1

