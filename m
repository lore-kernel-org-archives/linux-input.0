From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] uinput: allow events per packet to be specified
Date: Tue, 01 Mar 2011 15:47:23 +0000
Message-ID: <20110301154722.32433.45006.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:42389 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756125Ab1CAQJG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Mar 2011 11:09:06 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: aris@cathedrallabs.org, linux-input@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Implement an events per packet interface configuration. We do this by
adding a new ioctl that must be called before creation and follows the
pattern of the existing API.

The behaviour is:
	Not set:	input default or value computed by the uinput driver
	Set:		value used in preference if larger than computed
			value

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/input/misc/uinput.c |   25 +++++++++++++++++++++++--
 include/linux/uinput.h      |    3 +++
 2 files changed, 26 insertions(+), 2 deletions(-)


diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index b941078..2d36ad8 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -349,6 +349,7 @@ static int uinput_setup_device(struct uinput_device *udev, const char __user *bu
 	char			*name;
 	int			i, size;
 	int			retval;
+	int			epp = 0;
 
 	if (count != sizeof(struct uinput_user_dev))
 		return -EINVAL;
@@ -407,11 +408,19 @@ static int uinput_setup_device(struct uinput_device *udev, const char __user *bu
 		if (test_bit(ABS_MT_SLOT, dev->absbit)) {
 			int nslot = input_abs_get_max(dev, ABS_MT_SLOT) + 1;
 			input_mt_create_slots(dev, nslot);
-			input_set_events_per_packet(dev, 6 * nslot);
+			epp = 6 * nslot;
 		} else if (test_bit(ABS_MT_POSITION_X, dev->absbit)) {
-			input_set_events_per_packet(dev, 60);
+			epp =  60;
 		}
 	}
+	/* if the user forced the event information then honour their
+	 * request providing it is bigger than the value we have ascertained
+	 * is required */
+	if (udev->events_per_packet > epp)
+		epp = udev->events_per_packet;
+
+	if (epp)
+		input_set_events_per_packet(dev, epp);
 
 	udev->state = UIST_SETUP_COMPLETE;
 	retval = count;
@@ -705,6 +714,18 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
 			phys[length - 1] = '\0';
 			break;
 
+		case UI_SET_EPP:
+			if (udev->state == UIST_CREATED) {
+				retval = -EINVAL;
+				goto out;
+			}
+			if (arg < 1) {
+				retval = -EINVAL;
+				goto out;
+			}
+			udev->events_per_packet = arg;
+			break;
+			
 		case UI_BEGIN_FF_UPLOAD:
 			retval = uinput_ff_upload_from_user(p, &ff_up);
 			if (retval)
diff --git a/include/linux/uinput.h b/include/linux/uinput.h
index 05f7fed2..85c8b17 100644
--- a/include/linux/uinput.h
+++ b/include/linux/uinput.h
@@ -73,6 +73,8 @@ struct uinput_device {
 	struct uinput_request	*requests[UINPUT_NUM_REQUESTS];
 	wait_queue_head_t	requests_waitq;
 	spinlock_t		requests_lock;
+
+	int			events_per_packet;
 };
 #endif	/* __KERNEL__ */
 
@@ -104,6 +106,7 @@ struct uinput_ff_erase {
 #define UI_SET_FFBIT		_IOW(UINPUT_IOCTL_BASE, 107, int)
 #define UI_SET_PHYS		_IOW(UINPUT_IOCTL_BASE, 108, char*)
 #define UI_SET_SWBIT		_IOW(UINPUT_IOCTL_BASE, 109, int)
+#define UI_SET_EPP		_IOW(UINPUT_IOCTL_BASE, 110, int)
 
 #define UI_BEGIN_FF_UPLOAD	_IOWR(UINPUT_IOCTL_BASE, 200, struct uinput_ff_upload)
 #define UI_END_FF_UPLOAD	_IOW(UINPUT_IOCTL_BASE, 201, struct uinput_ff_upload)

