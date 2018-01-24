From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] Input: bcm5974: Return directly after a failed kmalloc()
 in bcm5974_wellspring_mode()
Date: Wed, 24 Jan 2018 21:31:09 +0100
Message-ID: <8befb181-9f0e-84f4-9080-4bde3d666a3b@users.sourceforge.net>
References: <0505482c-287f-8809-76e3-960cf45b3c0a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <0505482c-287f-8809-76e3-960cf45b3c0a@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 24 Jan 2018 21:14:51 +0100

Return directly after a call of the function "kmalloc" failed
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/mouse/bcm5974.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 994805513df9..685f56c08931 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -669,10 +669,8 @@ static int bcm5974_wellspring_mode(struct bcm5974 *dev, bool on)
 		return 0;
 
 	data = kmalloc(c->um_size, GFP_KERNEL);
-	if (!data) {
-		retval = -ENOMEM;
-		goto out;
-	}
+	if (!data)
+		return -ENOMEM;
 
 	/* read configuration */
 	size = usb_control_msg(dev->udev, usb_rcvctrlpipe(dev->udev, 0),
-- 
2.16.1

