From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH] Input: turbografx - fix reference counting
Date: Wed,  1 Dec 2010 22:05:01 +0900
Message-ID: <1291208701-3016-1-git-send-email-namhyung@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:47610 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755034Ab0LANFL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Dec 2010 08:05:11 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The ref-count of parport gained from parport_find_number()
was not released in normal path.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 drivers/input/joystick/turbografx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/joystick/turbografx.c b/drivers/input/joystick/turbografx.c
index d53b9e9..27b6a3c 100644
--- a/drivers/input/joystick/turbografx.c
+++ b/drivers/input/joystick/turbografx.c
@@ -245,6 +245,7 @@ static struct tgfx __init *tgfx_probe(int parport, int *n_buttons, int n_devs)
 		goto err_free_tgfx;
         }
 
+	parport_put_port(pp);
 	return tgfx;
 
  err_free_dev:
-- 
1.7.0.4

