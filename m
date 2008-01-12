From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH] input: check return value of input_register_device() in
 hil_ptr.c's init
Date: Sat, 12 Jan 2008 15:13:07 -0500
Message-ID: <20080112151307.62cd958e@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762835AbYALUM7@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: dtor@mail.ru, linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/input/mouse/hil_ptr.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/input/mouse/hil_ptr.c b/drivers/input/mouse/hil_ptr.c
index 27f88fb..de8b836 100644
--- a/drivers/input/mouse/hil_ptr.c
+++ b/drivers/input/mouse/hil_ptr.c
@@ -380,7 +380,10 @@ static int hil_ptr_connect(struct serio *serio, struct serio_driver *driver)
 	ptr->dev->id.version	= 0x0100; /* TODO: get from ptr->rsc */
 	ptr->dev->dev.parent	= &serio->dev;
 
-	input_register_device(ptr->dev);
+	if (input_register_device(ptr->dev)) {
+		printk(KERN_INFO PREFIX "Unable to register input device\n");
+		goto bail2;
+	}
 	printk(KERN_INFO "input: %s (%s), ID: %d\n",
 		ptr->dev->name,
 		(btntype == BTN_MOUSE) ? "HIL mouse":"HIL tablet or touchpad",
-- 
1.5.3.5

