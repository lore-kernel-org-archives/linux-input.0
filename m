From: Oscar Campos <oscar.campos@member.fsf.org>
Subject: [PATCH] input: mouse: trackpoint: assume 3 buttons when buttons
 detection fails
Date: Mon, 29 May 2017 12:45:01 +0100
Message-ID: <20170529114458.GA28855@ThinkStation>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33989 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbdE2Lmq (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 29 May 2017 07:42:46 -0400
Received: by mail-lf0-f67.google.com with SMTP id q24so5993392lfb.1
        for <linux-input@vger.kernel.org>; Mon, 29 May 2017 04:42:46 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Trackpoint buttons detection fails on ThinkPad 570 and 470 series,
this makes the middle button of the trackpoint to not being recogized.
As I don't believe there is any trackpoint with less than 3 buttons this
patch just assumes three buttons when the extended button information
read fails.

Cc: linux-input@vger.kernel.org
Signed-off-by: Oscar Campos <oscar.campos@member.fsf.org>
---
 drivers/input/mouse/trackpoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
index 922ea02edcc3..20b5b21c1bba 100644
--- a/drivers/input/mouse/trackpoint.c
+++ b/drivers/input/mouse/trackpoint.c
@@ -380,8 +380,8 @@ int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
 		return 0;

 	if (trackpoint_read(ps2dev, TP_EXT_BTN, &button_info)) {
-		psmouse_warn(psmouse, "failed to get extended button data\n");
-		button_info = 0;
+		psmouse_warn(psmouse, "failed to get extended button data, assuming 3 buttons\n");
+		button_info = 0x33;
 	}

 	psmouse->private = kzalloc(sizeof(struct trackpoint_data), GFP_KERNEL);
--
2.13.0

