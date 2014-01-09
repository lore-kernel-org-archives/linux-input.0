From: Aniroop Mathur <a.mathur@samsung.com>
Subject: [PATCH] Introduce Naming Convention in Input Subsystem
Date: Thu, 09 Jan 2014 10:27:56 +0530
Message-ID: <1389243476-11196-1-git-send-email-a.mathur@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:49531 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849AbaAIE7p (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jan 2014 23:59:45 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MZ4004C9B7KXK00@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Thu, 09 Jan 2014 13:59:44 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, dtor@mail.ru
Cc: cpgs@samsung.com, a.mathur@samsung.com, a.anurag@samsung.com, naveen.sel@samsung.com, aniroop.mathur@gmail.com, vikas.kala@samsung.com, narendra.m1@samsung.com, poorva.s@samsung.com

This patch allows user(driver) to set sysfs node name of input devices.
To set sysfs node name, user(driver) just needs to set node_name_unique variable.
If node_name_unique is not set, default name is given(as before).
So, this patch is completely backward-compatible.

Sysfs Input node name format is: input_<name>
Sysfs Event node name format is: event_<name>
This "name" is given by user and automatically, prefix(input and event) is added by input core.

This name must be unique among all input devices and driver(user) has the responsibility to ensure it.
If same name is used again for other input device, registration of that input device will fail because
two input devices cannot have same name.

Advantages of this patch are:

1. Reduces Booting Time of HAL/Upper-Layer because now HAL or Upper-Layer do not need to search input/event number
corresponding to each input device in /dev/input/...
This searching in /dev/input/ was taking too much time.
(Especially in mobile devices, where there are many input devices (many sensors, touchscreen, etc),
it reduces a lot of booting time)

2. Improves Readabilty of input and event sysfs node paths because names are used instead of numbers.

3. Removes Input Devices Dependency. If one input device probe fails, other input devices still work.
Before this patch, if one input device probe fails before input_register_device, then
input number of other input devices changes and due to this permission settings are disturbed
and hence HAL or upper layer cannot open the required sysfs node because permission denied error comes.

This patch is applicable upto kernel version 3.11

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
---
 drivers/input/evdev.c |   11 ++++++++++-
 drivers/input/input.c |   12 +++++++++++-
 include/linux/input.h |    4 ++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index b6ded17..b6a5848 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -1131,7 +1131,16 @@ static int evdev_connect(struct input_handler *handler, struct input_dev *dev,
 	/* Normalize device number if it falls into legacy range */
 	if (dev_no < EVDEV_MINOR_BASE + EVDEV_MINORS)
 		dev_no -= EVDEV_MINOR_BASE;
-	dev_set_name(&evdev->dev, "event%d", dev_no);
+
+	/*
+	* As per user choice (driver),
+	* name of sysfs node is set, as mentioned in node_name_unique variable.
+	* If node_name_unique is not set, default name is given.
+	*/
+	if (dev->node_name_unique)
+		dev_set_name(&evdev->dev, "event_%s", dev->node_name_unique);
+	else
+		dev_set_name(&evdev->dev, "event%d", dev_no);
 
 	evdev->handle.dev = input_get_device(dev);
 	evdev->handle.name = dev_name(&evdev->dev);
diff --git a/drivers/input/input.c b/drivers/input/input.c
index c044699..c8126b3 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -2073,7 +2073,17 @@ int input_register_device(struct input_dev *dev)
 	if (!dev->setkeycode)
 		dev->setkeycode = input_default_setkeycode;
 
-	dev_set_name(&dev->dev, "input%ld",
+	/*
+	* As per user choice (driver),
+	* name of sysfs node is set, as mentioned in node_name_unique variable.
+	* If node_name_unique is not set, default name is given.
+	*/
+	if (dev->node_name_unique) {
+		atomic_inc_return(&input_no);
+		dev_set_name(&dev->dev, "input_%s",
+		     dev->node_name_unique);
+	} else
+		dev_set_name(&dev->dev, "input%ld",
 		     (unsigned long) atomic_inc_return(&input_no) - 1);
 
 	error = device_add(&dev->dev);
diff --git a/include/linux/input.h b/include/linux/input.h
index 82ce323..fe44643 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -43,6 +43,9 @@ struct input_value {
  * @uniq: unique identification code for the device (if device has it)
  * @id: id of the device (struct input_id)
  * @propbit: bitmap of device properties and quirks
+ * @node_name_unique: name of input and event sysfs device node (char *).
+ *	This name must be unique among all input devices and driver(user)
+ *	has the responsibility to ensure it (if using).
  * @evbit: bitmap of types of events supported by the device (EV_KEY,
  *	EV_REL, etc.)
  * @keybit: bitmap of keys/buttons this device has
@@ -123,6 +126,7 @@ struct input_dev {
 	const char *phys;
 	const char *uniq;
 	struct input_id id;
+	char *node_name_unique;
 
 	unsigned long propbit[BITS_TO_LONGS(INPUT_PROP_CNT)];
 
-- 
1.7.0.4

