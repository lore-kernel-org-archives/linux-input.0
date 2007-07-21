From: Jesper Juhl <jesper.juhl@gmail.com>
Subject: [PATCH][08/37] Clean up duplicate includes in drivers/input/
Date: Sat, 21 Jul 2007 17:02:25 +0200
Message-ID: <200707211702.25926.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jesper Juhl <jesper.juhl@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@mail.ru, linux-input@atrey.karlin.mff.cuni.cz, Philip Blundell <philb@gnu.org>
List-Id: linux-input@vger.kernel.org

Hi,

This patch cleans up duplicate includes in
	drivers/input/


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 7392122..f0b22b8 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -22,7 +22,6 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/input.h>
-#include <linux/irq.h>
 #include <linux/gpio_keys.h>
 
 #include <asm/gpio.h>
