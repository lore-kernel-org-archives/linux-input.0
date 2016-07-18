From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH 3/4] input: tablet: pegasus_notetaker: Cancel workqueue's work in suspend()
Date: Mon, 18 Jul 2016 16:29:08 +0200
Message-ID: <1468852149-2614-4-git-send-email-martink@posteo.de>
References: <1468852149-2614-1-git-send-email-martink@posteo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468852149-2614-1-git-send-email-martink@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Martin Kepplinger <martink@posteo.de>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 drivers/input/tablet/pegasus_notetaker.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
index fdbc5e8..07436c6 100644
--- a/drivers/input/tablet/pegasus_notetaker.c
+++ b/drivers/input/tablet/pegasus_notetaker.c
@@ -377,6 +377,7 @@ static int pegasus_suspend(struct usb_interface *intf, pm_message_t message)
 
 	mutex_lock(&pegasus->dev->mutex);
 	usb_kill_urb(pegasus->irq);
+	cancel_work_sync(&pegasus->init);
 	mutex_unlock(&pegasus->dev->mutex);
 
 	return 0;
-- 
2.1.4
