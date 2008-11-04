From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH 1/2] input: add filter callback to input handlers.
Date: Tue,  4 Nov 2008 12:31:27 +1030
Message-ID: <1225764088-10761-2-git-send-email-peter.hutterer@who-t.net>
References: <1225764088-10761-1-git-send-email-peter.hutterer@who-t.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ipx-119-252-190-80.ipxserver.de ([80.190.252.119]:41906 "EHLO
	ipx10616.ipxserver.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751447AbYKDCCY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Nov 2008 21:02:24 -0500
In-Reply-To: <1225764088-10761-1-git-send-email-peter.hutterer@who-t.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Peter Hutterer <peter.hutterer@redhat.com>

From: Peter Hutterer <peter.hutterer@redhat.com>

The filter is called on all handlers before the event is passed to the
handlers for delivery. This allows such handlers to redirect the event to a
different device or trigger other actions based on the event.

If a filter returns non-zero, the event is discarded and not passed to the
event handlers.

Signed-off-by: Peter Hutterer <peter.hutterer@redhat.com>
---
 drivers/input/input.c |   44 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/input.h |    2 ++
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index c13ced3..fa19e6a 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -132,6 +132,44 @@ static void input_start_autorepeat(struct input_dev *dev, int code)
 	}
 }
 
+/**
+ * input_filter_event() - filter the event
+ * @dev: device that generated the event
+ * @type: type of the event
+ * @code: event code
+ * @value: value of the event
+ *
+ * This function takes the event and runs through all filter-handlers. The
+ * handlers may indicate that the event is to be filtered and not propagated
+ * any further.
+ * Returns 1, if the event is not to be sent to the actual event handlers.
+ */
+int input_filter_event(struct input_dev *dev, unsigned int type,
+			unsigned int code, int value)
+{
+	struct input_handle *handle;
+	int retval = 0;
+
+	rcu_read_lock();
+
+	handle = rcu_dereference(dev->grab);
+	if (handle) {
+		if (handle->handler->filter)
+			retval = handle->handler->filter(handle, type,
+							 code, value);
+		else
+			retval = 0;
+	} else
+		list_for_each_entry_rcu(handle, &dev->h_list, d_node)
+			if (handle->open && handle->handler->filter)
+				if (handle->handler->filter(handle, type,
+							    code, value))
+					retval = 1;
+	rcu_read_unlock();
+
+	return retval;
+}
+
 #define INPUT_IGNORE_EVENT	0
 #define INPUT_PASS_TO_HANDLERS	1
 #define INPUT_PASS_TO_DEVICE	2
@@ -248,8 +286,10 @@ static void input_handle_event(struct input_dev *dev,
 	if ((disposition & INPUT_PASS_TO_DEVICE) && dev->event)
 		dev->event(dev, type, code, value);
 
-	if (disposition & INPUT_PASS_TO_HANDLERS)
-		input_pass_event(dev, type, code, value);
+	if (disposition & INPUT_PASS_TO_HANDLERS) {
+		if (!input_filter_event(dev, type, code, value))
+			input_pass_event(dev, type, code, value);
+	}
 }
 
 /**
diff --git a/include/linux/input.h b/include/linux/input.h
index a5802c9..30a5b8a 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -1154,6 +1154,7 @@ struct input_handle;
  * @start: starts handler for given handle. This function is called by
  *	input core right after connect() method and also when a process
  *	that "grabbed" a device releases it
+ * @filter: filter the given event and do not call @event.
  * @fops: file operations this driver implements
  * @minor: beginning of range of 32 minors for devices this driver
  *	can provide
@@ -1178,6 +1179,7 @@ struct input_handler {
 	void *private;
 
 	void (*event)(struct input_handle *handle, unsigned int type, unsigned int code, int value);
+	int (*filter)(struct input_handle *handle, unsigned int type, unsigned int code, int value);
 	int (*connect)(struct input_handler *handler, struct input_dev *dev, const struct input_device_id *id);
 	void (*disconnect)(struct input_handle *handle);
 	void (*start)(struct input_handle *handle);
-- 
1.6.0.3

