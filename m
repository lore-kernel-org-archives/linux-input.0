From: Wan ZongShun <mcuos.com@gmail.com>
Subject: [PATCH] keypad/nuc900: change keypad driver name from 'nuc900-keypad'
 to 'nuc900-kpi'
Date: Sun, 18 Jul 2010 22:39:13 +0800
Message-ID: <4C431211.6030706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:39051 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755818Ab0GROjX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Jul 2010 10:39:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi Dmitry,

I ever changed the keypad platform device name from 'nuc900-keypad' to
'nuc900-kpi', but I forget to modify the related keypad driver name,so
the keypad driver does not work,I have to send the patch to fix this issue.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
---
 drivers/input/keyboard/w90p910_keypad.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/w90p910_keypad.c b/drivers/input/keyboard/w90p910_keypad.c
index 4ef764c..ee2bf6b 100644
--- a/drivers/input/keyboard/w90p910_keypad.c
+++ b/drivers/input/keyboard/w90p910_keypad.c
@@ -258,7 +258,7 @@ static struct platform_driver w90p910_keypad_driver = {
 	.probe		= w90p910_keypad_probe,
 	.remove		= __devexit_p(w90p910_keypad_remove),
 	.driver		= {
-		.name	= "nuc900-keypad",
+		.name	= "nuc900-kpi",
 		.owner	= THIS_MODULE,
 	},
 };
-- 
1.6.3.3
