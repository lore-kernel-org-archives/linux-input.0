From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 50/76] HID: cp2112: prevent sleeping function called from invalid context
Date: Thu, 29 Aug 2019 14:12:45 -0400
Message-ID: <20190829181311.7562-50-sashal@kernel.org>
References: <20190829181311.7562-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829181311.7562-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

[ Upstream commit 2d05dba2b25ecb0f8fc3a0b4eb2232da6454a47b ]

When calling request_threaded_irq() with a CP2112, the function
cp2112_gpio_irq_startup() is called in a IRQ context.

Therefore we can not sleep, and we can not call
cp2112_gpio_direction_input() there.

Move the call to cp2112_gpio_direction_input() earlier to have a working
driver.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-cp2112.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 8bbe3d0cbe5d9..8fd44407a0df7 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -1152,8 +1152,6 @@ static unsigned int cp2112_gpio_irq_startup(struct irq_data *d)
 
 	INIT_DELAYED_WORK(&dev->gpio_poll_worker, cp2112_gpio_poll_callback);
 
-	cp2112_gpio_direction_input(gc, d->hwirq);
-
 	if (!dev->gpio_poll) {
 		dev->gpio_poll = true;
 		schedule_delayed_work(&dev->gpio_poll_worker, 0);
@@ -1201,6 +1199,12 @@ static int __maybe_unused cp2112_allocate_irq(struct cp2112_device *dev,
 		return PTR_ERR(dev->desc[pin]);
 	}
 
+	ret = cp2112_gpio_direction_input(&dev->gc, pin);
+	if (ret < 0) {
+		dev_err(dev->gc.parent, "Failed to set GPIO to input dir\n");
+		goto err_desc;
+	}
+
 	ret = gpiochip_lock_as_irq(&dev->gc, pin);
 	if (ret) {
 		dev_err(dev->gc.parent, "Failed to lock GPIO as interrupt\n");
-- 
2.20.1
