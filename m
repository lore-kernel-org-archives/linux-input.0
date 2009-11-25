From: Onkalo Samu <samu.p.onkalo@nokia.com>
Subject: Re: [PATCH 1/1] TWL4030 keypad: keypad lock / unlock
Date: Wed, 25 Nov 2009 16:22:17 +0200
Message-ID: <1259158937.9055.6.camel@4fid08082>
References: <1257841448-12757-1-git-send-email-samu.p.onkalo@nokia.com>
	 <1257841448-12757-2-git-send-email-samu.p.onkalo@nokia.com>
	 <20091110134329.GB30911@sirena.org.uk>
	 <20091110172637.GB15263@core.coreip.homeip.net>
	 <1257933456.3507.42.camel@4fid08082>
	 <20091111100837.GA6263@rakim.wolfsonmicro.main>
	 <1258977955.5272.37.camel@4fid08082>
	 <20091123135435.GG24326@rakim.wolfsonmicro.main>
Reply-To: samu.p.onkalo@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37575 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934703AbZKYOWd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Nov 2009 09:22:33 -0500
In-Reply-To: <20091123135435.GG24326@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: ext Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, 2009-11-23 at 14:54 +0100, ext Mark Brown wrote:
> On Mon, Nov 23, 2009 at 02:05:55PM +0200, Onkalo Samu wrote:
> 
> > twl4030 keypad is more or less connected to omap based systems and this
> > kind of disabling and enabling feature is clearly targetted to embedded
> 
> There's rather a lot of embedded systems and off the shelf application
> stacks for them so having an interface that isn't driver-specific is
> also useful for them.
> 
> > systems. One more generic way could be to add ioctl to evdev driver
> > which calls chip-specific driver for disabling / enabling the keypad.
> > It is then up to chip specific driver to setup necessary callback
> > functions which makes actual job. Does this sound bad?
> 
> Something along these lines which makes the user space interface part of
> the common code, enabled if driver provides functions to implement the
> behaviour does seem like a good approach.
> 
> sysfs might be easier to use than an ioctl(), though.

Something like that:
diff --git a/drivers/input/input.c b/drivers/input/input.c
index cc763c9..94824a4 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1305,6 +1305,49 @@ static int input_dev_uevent(struct device
*device, struct kobj_uevent_env *env)
 		}						\
 	} while (0)
 
+/* SYSFS */
+static ssize_t input_dev_get_disable(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct input_dev *input_dev = to_input_dev(dev);
+	return sprintf(buf, "%u\n", input_dev->disabled);
+}
+
+static ssize_t input_dev_set_disable(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct input_dev *input_dev = to_input_dev(dev);
+	long i = 0;
+	int ret;
+
+	if (!(input_dev->disable && input_dev->enable))
+		return 0;
+
+	ret = strict_strtoul(buf, 0, &i);
+	if (ret)
+		return -EINVAL;
+	i = !!i;
+
+	mutex_lock(&input_dev->mutex);
+	if (input_dev->disabled == i) {
+		mutex_unlock(&input_dev->mutex);
+		return count;
+	}
+	input_dev->disabled = i;

should this be a counter or boolean? Or should this be in driver itself
and not in input system.

+
+	if (i)
+		input_dev->disable(input_dev);
+	else
+		input_dev->enable(input_dev);
+
+	mutex_unlock(&input_dev->mutex);
+	return count;
+}
+
+static DEVICE_ATTR(disable, S_IRUGO | S_IWUSR, input_dev_get_disable,
+		input_dev_set_disable);
+
 #ifdef CONFIG_PM
 static void input_dev_reset(struct input_dev *dev, bool activate)
 {
@@ -1539,6 +1582,13 @@ int input_register_device(struct input_dev *dev)
 		return error;
 	}
 
+	error = device_create_file(&dev->dev, &dev_attr_disable);
+	if (error < 0) {
+		device_del(&dev->dev);
+		mutex_unlock(&input_mutex);
+		return error;
+	}
+
 	list_add_tail(&dev->node, &input_dev_list);
 
 	list_for_each_entry(handler, &input_handler_list, node)
@@ -1578,6 +1628,8 @@ void input_unregister_device(struct input_dev
*dev)
 
 	mutex_unlock(&input_mutex);
 
+	device_remove_file(&dev->dev, &dev_attr_disable);
+
 	device_unregister(&dev->dev);
 }
 EXPORT_SYMBOL(input_unregister_device);
diff --git a/include/linux/input.h b/include/linux/input.h
index 0ccfc30..e6e1098 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -1048,6 +1048,11 @@ struct ff_effect {
  *	or EV_SND. The device is expected to carry out the requested
  *	action (turn on a LED, play sound, etc.) The call is protected
  *	by @event_lock and must not sleep
+ * @enable: method is called when user wants to enable driver which was
+ *	disabled using disable-method (optional).
+ * @disable: method is called when user wants to temporarily disable
the
+ *	driver (example: tell keyboard driver to disable scanning at
+ *	HW level) (optional).
  * @grab: input handle that currently has the device grabbed (via
  *	EVIOCGRAB ioctl). When a handle grabs a device it becomes sole
  *	recipient for all input events coming from the device
@@ -1116,6 +1121,8 @@ struct input_dev {
 	void (*close)(struct input_dev *dev);
 	int (*flush)(struct input_dev *dev, struct file *file);
 	int (*event)(struct input_dev *dev, unsigned int type, unsigned int
code, int value);
+	int (*enable)(struct input_dev *dev);
+	int (*disable)(struct input_dev *dev);
 
 	struct input_handle *grab;
 
@@ -1124,6 +1131,7 @@ struct input_dev {
 
 	unsigned int users;
 	bool going_away;
+	bool disabled;
 
 	struct device dev;
 

TWL4030 driver just setup the pointers to HW control functions.

-Samu
 




