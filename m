From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/4] Input: walkera0701 - set up input device's parent
Date: Sun, 06 Jan 2013 00:59:31 -0800
Message-ID: <20130106085931.18147.78960.stgit@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36992 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab3AFI7f (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 6 Jan 2013 03:59:35 -0500
Received: by mail-pa0-f54.google.com with SMTP id bi5so10183308pad.41
        for <linux-input@vger.kernel.org>; Sun, 06 Jan 2013 00:59:34 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Popovec <popovec@fei.tuke.sk>
Cc: linux-input@vger.kernel.org

This will place the joystick's input device into propoer place in sysfs
hierarchy as long as th port has device assigned to it (i.e. it is not
legacy port).

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/walkera0701.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/walkera0701.c b/drivers/input/joystick/walkera0701.c
index f8f892b..38386ce 100644
--- a/drivers/input/joystick/walkera0701.c
+++ b/drivers/input/joystick/walkera0701.c
@@ -241,6 +241,7 @@ static int walkera0701_connect(struct walkera_dev *w, int parport)
 	w->input_dev->id.vendor = 0x0001;
 	w->input_dev->id.product = 0x0001;
 	w->input_dev->id.version = 0x0100;
+	w->input_dev->dev.parent = w->parport->dev;
 	w->input_dev->open = walkera0701_open;
 	w->input_dev->close = walkera0701_close;
 

