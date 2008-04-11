From: David Brownell <david-b@pacbell.net>
Subject: [RESEND patch 2.6.25-rc8] gpio_keys irq handling
Date: Fri, 11 Apr 2008 00:35:55 -0700
Message-ID: <200804110035.55510.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:26397 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757495AbYDKHpX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Apr 2008 03:45:23 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Cc: Jiri Kosina <jkosina@suse.cz>, Phil Blundell <pb@handhelds.org>

From: David Brownell <dbrownell@users.sourceforge.net>

Cleanup IRQ handling in gpio_keys:  bail after handling the IRQ, and
report IRQ_NONE if we never handle it.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Cc: Phil Blundell <pb@handhelds.org>
Cc: Dmitry Torokhov <dtor@mail.ru>
---
No functional changes since the version sent 27-Dec-2007.
MAINTAINERS says "linux-input@vger" but the only archives
I could find seems to say "@atrey.karlin.mff.cuni.cz"...

 drivers/input/keyboard/gpio_keys.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- g26.orig/drivers/input/keyboard/gpio_keys.c	2008-04-10 19:39:15.000000000 -0700
+++ g26/drivers/input/keyboard/gpio_keys.c	2008-04-11 00:30:45.000000000 -0700
@@ -43,10 +43,11 @@ static irqreturn_t gpio_keys_isr(int irq
 
 			input_event(input, type, button->code, !!state);
 			input_sync(input);
+			return IRQ_HANDLED;
 		}
 	}
 
-	return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 static int __devinit gpio_keys_probe(struct platform_device *pdev)
