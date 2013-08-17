From: Ming Lei <ming.lei@canonical.com>
Subject: [PATCH v1 26/49] input: cm109: prepare for enabling irq in complete()
Date: Sun, 18 Aug 2013 00:24:51 +0800
Message-ID: <1376756714-25479-27-git-send-email-ming.lei@canonical.com>
References: <1376756714-25479-1-git-send-email-ming.lei@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:55852 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571Ab3HQQ3d (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Aug 2013 12:29:33 -0400
In-Reply-To: <1376756714-25479-1-git-send-email-ming.lei@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, Oliver Neukum <oliver@neukum.org>, Alan Stern <stern@rowland.harvard.edu>, Ming Lei <ming.lei@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Complete() will be run with interrupt enabled, so change to
spin_lock_irqsave().

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 drivers/input/misc/cm109.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/cm109.c b/drivers/input/misc/cm109.c
index 082684e..cac4e37 100644
--- a/drivers/input/misc/cm109.c
+++ b/drivers/input/misc/cm109.c
@@ -340,6 +340,7 @@ static void cm109_urb_irq_callback(struct urb *urb)
 	struct cm109_dev *dev = urb->context;
 	const int status = urb->status;
 	int error;
+	unsigned long flags;
 
 	dev_dbg(&dev->intf->dev, "### URB IRQ: [0x%02x 0x%02x 0x%02x 0x%02x] keybit=0x%02x\n",
 	     dev->irq_data->byte[0],
@@ -379,7 +380,7 @@ static void cm109_urb_irq_callback(struct urb *urb)
 
  out:
 
-	spin_lock(&dev->ctl_submit_lock);
+	spin_lock_irqsave(&dev->ctl_submit_lock, flags);
 
 	dev->irq_urb_pending = 0;
 
@@ -403,7 +404,7 @@ static void cm109_urb_irq_callback(struct urb *urb)
 				__func__, error);
 	}
 
-	spin_unlock(&dev->ctl_submit_lock);
+	spin_unlock_irqrestore(&dev->ctl_submit_lock, flags);
 }
 
 static void cm109_urb_ctl_callback(struct urb *urb)
@@ -411,6 +412,7 @@ static void cm109_urb_ctl_callback(struct urb *urb)
 	struct cm109_dev *dev = urb->context;
 	const int status = urb->status;
 	int error;
+	unsigned long flags;
 
 	dev_dbg(&dev->intf->dev, "### URB CTL: [0x%02x 0x%02x 0x%02x 0x%02x]\n",
 	     dev->ctl_data->byte[0],
@@ -421,7 +423,7 @@ static void cm109_urb_ctl_callback(struct urb *urb)
 	if (status)
 		dev_err(&dev->intf->dev, "%s: urb status %d\n", __func__, status);
 
-	spin_lock(&dev->ctl_submit_lock);
+	spin_lock_irqsave(&dev->ctl_submit_lock, flags);
 
 	dev->ctl_urb_pending = 0;
 
@@ -442,7 +444,7 @@ static void cm109_urb_ctl_callback(struct urb *urb)
 		}
 	}
 
-	spin_unlock(&dev->ctl_submit_lock);
+	spin_unlock_irqrestore(&dev->ctl_submit_lock, flags);
 }
 
 static void cm109_toggle_buzzer_async(struct cm109_dev *dev)
-- 
1.7.9.5

