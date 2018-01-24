From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] Input: appletouch: Delete an error message for a failed
 memory allocation in atp_geyser_init()
Date: Wed, 24 Jan 2018 20:56:11 +0100
Message-ID: <fd7ba984-5294-78f7-73e3-7f6a37ed9dee@users.sourceforge.net>
References: <a86a6a93-21eb-4571-465c-24d4c0687965@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <a86a6a93-21eb-4571-465c-24d4c0687965@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 24 Jan 2018 20:40:54 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/mouse/appletouch.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index 81a695d0b4e0..3a709d21ea93 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -280,10 +280,8 @@ static int atp_geyser_init(struct atp *dev)
 	int ret;
 
 	data = kmalloc(8, GFP_KERNEL);
-	if (!data) {
-		dev_err(&dev->intf->dev, "Out of memory\n");
+	if (!data)
 		return -ENOMEM;
-	}
 
 	size = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
 			ATP_GEYSER_MODE_READ_REQUEST_ID,
-- 
2.16.1

