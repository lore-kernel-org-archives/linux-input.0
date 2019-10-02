From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: add input_get_poll_interval()
Date: Wed, 2 Oct 2019 14:58:12 -0700
Message-ID: <20191002215812.GA135681@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Some drivers need to be able to know the current polling interval for
devices working in polling mode, let's allow them fetching it.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input-poller.c | 9 +++++++++
 include/linux/input.h        | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/input/input-poller.c b/drivers/input/input-poller.c
index 1b3d28964bb2..7d6b4e8879f1 100644
--- a/drivers/input/input-poller.c
+++ b/drivers/input/input-poller.c
@@ -123,6 +123,15 @@ void input_set_max_poll_interval(struct input_dev *dev, unsigned int interval)
 }
 EXPORT_SYMBOL(input_set_max_poll_interval);
 
+int input_get_poll_interval(struct input_dev *dev)
+{
+	if (!dev->poller)
+		return -EINVAL;
+
+	return dev->poller->poll_interval;
+}
+EXPORT_SYMBOL(input_get_poll_interval);
+
 /* SYSFS interface */
 
 static ssize_t input_dev_get_poll_interval(struct device *dev,
diff --git a/include/linux/input.h b/include/linux/input.h
index 31da4feaa1d8..a420324b7882 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -387,6 +387,7 @@ int input_setup_polling(struct input_dev *dev,
 void input_set_poll_interval(struct input_dev *dev, unsigned int interval);
 void input_set_min_poll_interval(struct input_dev *dev, unsigned int interval);
 void input_set_max_poll_interval(struct input_dev *dev, unsigned int interval);
+int input_get_poll_interval(struct input_dev *dev);
 
 int __must_check input_register_handler(struct input_handler *);
 void input_unregister_handler(struct input_handler *);
-- 
2.23.0.444.g18eeb5a265-goog


-- 
Dmitry
