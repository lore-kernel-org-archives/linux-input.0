From: Dima Ryazanov <dima@gmail.com>
Subject: [PATCH] input: ALPS - Invert the Y axis and adjust scaling on SS5 tracksticks
Date: Mon,  9 Jan 2017 23:35:55 -0800
Message-ID: <20170110073555.31004-1-dima@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34650 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbdAJHgH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 10 Jan 2017 02:36:07 -0500
Received: by mail-pf0-f193.google.com with SMTP id y143so6556712pfb.1
        for <linux-input@vger.kernel.org>; Mon, 09 Jan 2017 23:36:06 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dima Ryazanov <dima@gmail.com>

This patch fixes the trackstick on my Dell Latitude E7470. Currently, it's
upside down and too fast (that is, much faster than when using the generic
PS/2 driver).

It also matches the trackpoint logic in alps_process_packet_v6.
---
(I'm aware that scaling in the driver is not ideal - but at least the vertical
orientation should be fixed.)

Signed-off-by: Dima Ryazanov <dima@gmail.com>
---
 drivers/input/mouse/alps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 328edc8..5fa7a15 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1346,8 +1346,8 @@ static void alps_process_packet_ss4_v2(struct psmouse *psmouse)
 			return;
 		}
 
-		input_report_rel(dev2, REL_X, SS4_TS_X_V2(packet));
-		input_report_rel(dev2, REL_Y, SS4_TS_Y_V2(packet));
+		input_report_rel(dev2, REL_X, SS4_TS_X_V2(packet) / 4);
+		input_report_rel(dev2, REL_Y, -SS4_TS_Y_V2(packet) / 4);
 		input_report_abs(dev2, ABS_PRESSURE, SS4_TS_Z_V2(packet));
 
 		input_report_key(dev2, BTN_LEFT, f->ts_left);
-- 
2.9.3

