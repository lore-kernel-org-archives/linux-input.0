From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH 17/51] Input: atmel_mxt_ts - Improve bootloader progress output
Date: Thu, 27 Jun 2013 13:48:52 +0100
Message-ID: <1372337366-9286-18-git-send-email-nick.dyer@itdev.co.uk>
References: <1372337366-9286-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1372337366-9286-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan Bowens <Alan.Bowens@atmel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>, Benson Leung <bleung@chromium.org>, Olof Johansson <olofj@chromium.org>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

By implementing a frame counter, print out fewer debug messages (the
firmware may contain hundreds of frames).

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
Acked-by: Benson Leung <bleung@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 3172610..99ebdec 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1456,6 +1456,7 @@ static int mxt_load_fw(struct device *dev, const char *fn)
 	unsigned int frame_size;
 	unsigned int pos = 0;
 	unsigned int retry = 0;
+	unsigned int frame = 0;
 	int ret;
 
 	ret = request_firmware(&fw, fn, dev);
@@ -1515,9 +1516,12 @@ static int mxt_load_fw(struct device *dev, const char *fn)
 		} else {
 			retry = 0;
 			pos += frame_size;
+			frame++;
 		}
 
-		dev_dbg(dev, "Updated %d bytes / %zd bytes\n", pos, fw->size);
+		if (frame % 50 == 0)
+			dev_info(dev, "Sent %d frames, %d/%zd bytes\n",
+				 frame, pos, fw->size);
 	}
 
 	/* Wait for flash. */
@@ -1526,6 +1530,8 @@ static int mxt_load_fw(struct device *dev, const char *fn)
 	if (ret)
 		goto disable_irq;
 
+	dev_info(dev, "Sent %d frames, %zd bytes\n", frame, pos);
+
 	/* Wait for device to reset. Some bootloader versions do not assert
 	 * the CHG line after bootloading has finished, so ignore error */
 	mxt_wait_for_completion(data, &data->bl_completion,
-- 
1.7.10.4
