From: Petri Gynther <pgynther@google.com>
Subject: [PATCH] Input: Add REP_MAX_COUNT to autorepeat parameters
Date: Mon, 21 Apr 2014 13:00:08 -0700 (PDT)
Message-ID: <20140421200008.CBC0F1007B4@puck.mtv.corp.google.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f202.google.com ([209.85.216.202]:62570 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435AbaDUUAK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2014 16:00:10 -0400
Received: by mail-qc0-f202.google.com with SMTP id m20so790054qcx.1
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2014 13:00:09 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

Add REP_MAX_COUNT to autorepeat parameters. This enables an input device to be
configured for maximum autorepeat count, so that a keypress is not repeated
forever. This is important for Bluetooth keyboards and remote controls that may
lose the Bluetooth link at any time, e.g. right after sending a key-down event
but before sending the corresponding key-up event.

Signed-off-by: Petri Gynther <pgynther@google.com>
---
 drivers/input/evdev.c      | 11 ++++++++++-
 drivers/input/input.c      |  6 +++++-
 include/linux/input.h      |  1 +
 include/uapi/linux/input.h |  5 ++++-
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index a06e125..be1887e 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -847,25 +847,34 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 		return 0;
 
 	case EVIOCGREP:
+	case EVIOCGREP_V2:
 		if (!test_bit(EV_REP, dev->evbit))
 			return -ENOSYS;
 		if (put_user(dev->rep[REP_DELAY], ip))
 			return -EFAULT;
 		if (put_user(dev->rep[REP_PERIOD], ip + 1))
 			return -EFAULT;
+		if (cmd == EVIOCGREP_V2 &&
+		    put_user(dev->rep[REP_MAX_COUNT], ip + 2))
+			return -EFAULT;
 		return 0;
 
 	case EVIOCSREP:
+	case EVIOCSREP_V2:
 		if (!test_bit(EV_REP, dev->evbit))
 			return -ENOSYS;
 		if (get_user(u, ip))
 			return -EFAULT;
 		if (get_user(v, ip + 1))
 			return -EFAULT;
+		if (cmd == EVIOCSREP_V2 && get_user(t, ip + 2))
+			return -EFAULT;
 
 		input_inject_event(&evdev->handle, EV_REP, REP_DELAY, u);
 		input_inject_event(&evdev->handle, EV_REP, REP_PERIOD, v);
-
+		if (cmd == EVIOCSREP_V2)
+			input_inject_event(&evdev->handle, EV_REP,
+					   REP_MAX_COUNT, t);
 		return 0;
 
 	case EVIOCRMFF:
diff --git a/drivers/input/input.c b/drivers/input/input.c
index 1c4c0db..a5314c5 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -78,6 +78,7 @@ static void input_start_autorepeat(struct input_dev *dev, int code)
 	    dev->rep[REP_PERIOD] && dev->rep[REP_DELAY] &&
 	    dev->timer.data) {
 		dev->repeat_key = code;
+		dev->repeat_count = 0;
 		mod_timer(&dev->timer,
 			  jiffies + msecs_to_jiffies(dev->rep[REP_DELAY]));
 	}
@@ -191,7 +192,8 @@ static void input_repeat_key(unsigned long data)
 
 		input_pass_values(dev, vals, ARRAY_SIZE(vals));
 
-		if (dev->rep[REP_PERIOD])
+		if (dev->rep[REP_PERIOD] && (dev->rep[REP_MAX_COUNT] == 0 ||
+		    ++dev->repeat_count <= dev->rep[REP_MAX_COUNT]))
 			mod_timer(&dev->timer, jiffies +
 					msecs_to_jiffies(dev->rep[REP_PERIOD]));
 	}
@@ -1640,6 +1642,7 @@ static void input_dev_toggle(struct input_dev *dev, bool activate)
 	if (activate && test_bit(EV_REP, dev->evbit)) {
 		dev->event(dev, EV_REP, REP_PERIOD, dev->rep[REP_PERIOD]);
 		dev->event(dev, EV_REP, REP_DELAY, dev->rep[REP_DELAY]);
+		dev->event(dev, EV_REP, REP_MAX_COUNT, dev->rep[REP_MAX_COUNT]);
 	}
 }
 
@@ -2110,6 +2113,7 @@ int input_register_device(struct input_dev *dev)
 		dev->timer.function = input_repeat_key;
 		dev->rep[REP_DELAY] = 250;
 		dev->rep[REP_PERIOD] = 33;
+		dev->rep[REP_MAX_COUNT] = 0;
 	}
 
 	if (!dev->getkeycode)
diff --git a/include/linux/input.h b/include/linux/input.h
index 82ce323..5f98714 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -151,6 +151,7 @@ struct input_dev {
 	struct ff_device *ff;
 
 	unsigned int repeat_key;
+	unsigned int repeat_count;
 	struct timer_list timer;
 
 	int rep[REP_CNT];
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index bd24470..d7e08ff 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -100,7 +100,9 @@ struct input_keymap_entry {
 #define EVIOCGVERSION		_IOR('E', 0x01, int)			/* get driver version */
 #define EVIOCGID		_IOR('E', 0x02, struct input_id)	/* get device ID */
 #define EVIOCGREP		_IOR('E', 0x03, unsigned int[2])	/* get repeat settings */
+#define EVIOCGREP_V2		_IOR('E', 0x03, unsigned int[3])
 #define EVIOCSREP		_IOW('E', 0x03, unsigned int[2])	/* set repeat settings */
+#define EVIOCSREP_V2		_IOW('E', 0x03, unsigned int[3])
 
 #define EVIOCGKEYCODE		_IOR('E', 0x04, unsigned int[2])        /* get keycode */
 #define EVIOCGKEYCODE_V2	_IOR('E', 0x04, struct input_keymap_entry)
@@ -900,7 +902,8 @@ struct input_keymap_entry {
 
 #define REP_DELAY		0x00
 #define REP_PERIOD		0x01
-#define REP_MAX			0x01
+#define REP_MAX_COUNT		0x02
+#define REP_MAX			0x02
 #define REP_CNT			(REP_MAX+1)
 
 /*
-- 
1.9.1.423.g4596e3a

