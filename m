From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH 4/7] [media] ati_remote: fix check for a weird byte
Date: Sun,  7 Aug 2011 01:18:10 +0300
Message-ID: <1312669093-23771-5-git-send-email-anssi.hannula@iki.fi>
References: <4E3DB2C2.7040104@iki.fi>
 <1312669093-23771-1-git-send-email-anssi.hannula@iki.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1312669093-23771-1-git-send-email-anssi.hannula@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-media@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The ati_remote_dump() function tries to not print "Weird byte" warning
for 1-byte responses that contain 0xff or 0x00, but it doesn't work
properly as it simply falls back to the "Weird data" warning in the else
clause.

Fix that by adding an inner if clause.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 drivers/media/rc/ati_remote.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/rc/ati_remote.c b/drivers/media/rc/ati_remote.c
index 842dee4..74cc6b1 100644
--- a/drivers/media/rc/ati_remote.c
+++ b/drivers/media/rc/ati_remote.c
@@ -273,9 +273,10 @@ static struct usb_driver ati_remote_driver = {
 static void ati_remote_dump(struct device *dev, unsigned char *data,
 			    unsigned int len)
 {
-	if ((len == 1) && (data[0] != (unsigned char)0xff) && (data[0] != 0x00))
-		dev_warn(dev, "Weird byte 0x%02x\n", data[0]);
-	else if (len == 4)
+	if (len == 1) {
+		if (data[0] != (unsigned char)0xff && data[0] != 0x00)
+			dev_warn(dev, "Weird byte 0x%02x\n", data[0]);
+	} else if (len == 4)
 		dev_warn(dev, "Weird key %02x %02x %02x %02x\n",
 		     data[0], data[1], data[2], data[3]);
 	else
-- 
1.7.4.4
