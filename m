From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: [PATCH] tsc40: remove wrong announcement of pressure support
Date: Fri, 26 Oct 2012 09:35:57 +0200
Message-ID: <3551576.vuikKUmT5K@devpool02>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.sf-mail.de ([62.27.20.61]:33196 "EHLO mail.sf-mail.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756554Ab2JZHeq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Oct 2012 03:34:46 -0400
Received: from unknown ([::ffff:80.150.94.234]:54969 HELO devpool02.localnet) (auth=eike@sf-mail.de)
	by mail.sf-mail.de (Qsmtpd 0.22svn) with (DHE-RSA-AES256-SHA encrypted) ESMTPSA
	for <linux-input@vger.kernel.org>; Fri, 26 Oct 2012 09:34:43 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

The tsc40 driver announces it supports the pressure event, but will never send
one. The announcement will cause tslib to wait for such events and sending all
touch events with a pressure of 0. Removing the announcement will make tslib
fall back to emulating the pressure on touch events so everything works as
expected.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: stable@vger.kernel.org
---
 drivers/input/touchscreen/tsc40.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/touchscreen/tsc40.c b/drivers/input/touchscreen/tsc40.c
index 63209aa..eb96f16 100644
--- a/drivers/input/touchscreen/tsc40.c
+++ b/drivers/input/touchscreen/tsc40.c
@@ -107,7 +107,6 @@ static int tsc_connect(struct serio *serio, struct serio_driver *drv)
 	__set_bit(BTN_TOUCH, input_dev->keybit);
 	input_set_abs_params(ptsc->dev, ABS_X, 0, 0x3ff, 0, 0);
 	input_set_abs_params(ptsc->dev, ABS_Y, 0, 0x3ff, 0, 0);
-	input_set_abs_params(ptsc->dev, ABS_PRESSURE, 0, 0, 0, 0);
 
 	serio_set_drvdata(serio, ptsc);
 
-- 
1.7.11.5


