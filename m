From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: do not use WARN() in input_alloc_absinfo()
Date: Mon, 6 Aug 2018 15:18:34 -0700
Message-ID: <20180806221834.GA140172@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Vyukov <dvyukov@google.com>, Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Some of fuzzers set panic_on_warn=1 so that they can handle WARN()ings
the same way they handle full-blown kernel crashes. We used WARN() in
input_alloc_absinfo() to get a better idea where memory allocation
failed, but since then kmalloc() and friends started dumping call stack
on memory allocation failures anyway, so we are not getting anything
extra from WARN().

Because of the above, let's replace WARN with dev_err(). We use dev_err()
instead of simply removing message and relying on kcalloc() to give us
stack dump so that we'd know the instance of hardware device to which we
were trying to attach input device.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 90453e2ab6cf..260f00ebe34d 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -481,11 +481,19 @@ EXPORT_SYMBOL(input_inject_event);
  */
 void input_alloc_absinfo(struct input_dev *dev)
 {
-	if (!dev->absinfo)
-		dev->absinfo = kcalloc(ABS_CNT, sizeof(*dev->absinfo),
-					GFP_KERNEL);
+	if (dev->absinfo)
+		return;
 
-	WARN(!dev->absinfo, "%s(): kcalloc() failed?\n", __func__);
+	dev->absinfo = kcalloc(ABS_CNT, sizeof(*dev->absinfo), GFP_KERNEL);
+	if (!dev->absinfo) {
+		dev_err(dev->dev.parent ?: &dev->dev,
+			"%s: unable to allocate memory\n", __func__);
+		/*
+		 * We will handle this allocation failure in
+		 * input_register_device() when we refuse to register input
+		 * device with ABS bits but without absinfo.
+		 */
+	}
 }
 EXPORT_SYMBOL(input_alloc_absinfo);
 
-- 
2.18.0.597.ga71716f1ad-goog


-- 
Dmitry
