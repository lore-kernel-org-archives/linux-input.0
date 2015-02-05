From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] Input: Delete an unnecessary check before the function call
 "input_free_device"
Date: Thu, 05 Feb 2015 17:40:20 +0100
Message-ID: <54D39CF4.7030204@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net> <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.so
 urceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5317A59D.4@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 5 Feb 2015 17:35:35 +0100

The input_free_device() function tests whether its argument is NULL and then
returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/joystick/adi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/joystick/adi.c b/drivers/input/joystick/adi.c
index b784257..d09cefa 100644
--- a/drivers/input/joystick/adi.c
+++ b/drivers/input/joystick/adi.c
@@ -535,8 +535,7 @@ static int adi_connect(struct gameport *gameport, struct gameport_driver *drv)
 		}
 	}
  fail2:	for (i = 0; i < 2; i++)
-		if (port->adi[i].dev)
-			input_free_device(port->adi[i].dev);
+		input_free_device(port->adi[i].dev);
 	gameport_close(gameport);
  fail1:	gameport_set_drvdata(gameport, NULL);
 	kfree(port);
-- 
2.2.2
