From: Bill Gatliff <bgat@billgatliff.com>
Subject: [PATCH] input: evdev: Add a read() callback
Date: Mon, 21 Feb 2011 08:18:50 -0600
Message-ID: <1298297930-3937-1-git-send-email-bgat@billgatliff.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46357 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266Ab1BUORX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Feb 2011 09:17:23 -0500
Received: by iwn8 with SMTP id 8so1930906iwn.19
        for <linux-input@vger.kernel.org>; Mon, 21 Feb 2011 06:17:23 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Bill Gatliff <bgat@billgatliff.com>

Some devices, like accelerometers, can manufacture as many input
events as userspace can consume.  The traditional method for limiting
the number of input events sent to userspace by such devices is to use
a kernel thread looping around an idle timer, to "throttle" the
creation and queuing of input events to a manageable rate.  Such
drivers often also provide a sysfs attribute (or similar means) that
allows userspace to indicate a desired event rate.

Some operating systems and/or applications e.g. Android, might prefer
to control input event creation rates themselves.  They frequently
attempt to do so by implementing a userspace polling thread that loops
around an idle timer; this idle timer throttles the rate of calls to
the input devices' read() method, which (at least in theory) limits
the rate of input events arriving at the application to a desired
level.

In practice, you want to use only one of the two aforementioned
approaches; if you try to do both, you'll get event buffer overflows,
weird behaviors, and delay stackups as the two timers apply their rate
limiting throttles against each other.

Userspace throttling of input events doesn't work very well with the
Linux kernel's current input event buffering scheme, because there is
no direct connection between the read() system call and the driver for
the input device being queried.  Put simply, current input device
drivers simply cannot tell when--- or even if--- userspace is polling
for an input event.

But implementing a rate-specifying sysfs attribute isn't enough,
however.  Under the Linux kernel's current input device buffering
scheme, drivers and applications can create and consume input events
every 100ms, for example, but there is always the possibility that an
input event will sit in the queue for 99ms waiting for an application
to retrieve it.  For devices and applications where this potential
delay causes problems, drivers must implement an external means for
applications to trigger the timely production of an input event.

The enclosed patch address all of the above problems by implementing
an advisory callback from the evdev read() and poll() methods to the
associated input device driver.  The driver may then choose to
populate the input event buffer at that time, rather than on a
schedule implemented by a polling loop, sysfs trigger, or other means.

Use of this callback by a driver naturally synchronizes the generation
of input events to requests from userspace, because the driver now
"knows" when userspace is attempting to retrieve an input event and
can therefore produce one just-in-time.  It also allows the driver to
easily match the rate of input event generation, by simply sampling the
hardware only during this callback.

If an input device driver chooses to use only the read() callback as
its signal to produce an input event, then the driver need not
implement a polling kernel thread or other means of pacing its event
generation rate.  The driver also has no need to provide a sysfs
attribute to allow userspace to request a polling rate or to trigger a
measurement: userspace must only read() or poll() the interface at the
desired rate.  This can greatly simplify input device driver
implementation, while conveniently leaving the incoming event rate and
synchronization issues completely up to the application. (See POSIX.1b
interval timers and scheduler options for APIs allowing precise timing
within user applications).

Finally, input device drivers might choose to implement a holdoff
timer that gets reset in the read() callback; expiration of this timer
would mean that userspace is no longer actively reading from the
device, even though the interface itself might still be open.  In such
cases the driver might wish to invoke a power-management method to
idle the hardware until the next  callback occurs.

Polled devices like accelerometers and compasses (and perhaps some
types of pushbuttons or switch inputs) will get the most benefit from
utilizing the read() callback.  Other devices, like USB keyboards and
mice, will have no use for it and may safely ignore it.

Signed-off-by: Bill Gatliff <bgat@billgatliff.com>
---
 drivers/input/evdev.c |   10 ++++++++++
 include/linux/input.h |    1 +
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index c8471a2..b49b601 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -370,12 +370,19 @@ static ssize_t evdev_read(struct file *file, char __user *buffer,
 {
 	struct evdev_client *client = file->private_data;
 	struct evdev *evdev = client->evdev;
+	struct input_dev *dev = evdev->handle.dev;
 	struct input_event event;
 	int retval;
 
 	if (count < input_event_size())
 		return -EINVAL;
 
+	if (client->head == client->tail && dev->read) {
+		retval = dev->read(dev);
+		if (retval)
+			return retval;
+	}
+
 	if (client->head == client->tail && evdev->exist &&
 	    (file->f_flags & O_NONBLOCK))
 		return -EAGAIN;
@@ -407,6 +414,9 @@ static unsigned int evdev_poll(struct file *file, poll_table *wait)
 	struct evdev *evdev = client->evdev;
 	unsigned int mask;
 
+	if (client->head == client->tail && dev->read)
+		dev->read(dev);
+
 	poll_wait(file, &evdev->wait, wait);
 
 	mask = evdev->exist ? POLLOUT | POLLWRNORM : POLLHUP | POLLERR;
diff --git a/include/linux/input.h b/include/linux/input.h
index e428382..eac7f77 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -1264,6 +1264,7 @@ struct input_dev {
 
 	int (*open)(struct input_dev *dev);
 	void (*close)(struct input_dev *dev);
+	int (*read)(struct input_dev *dev);
 	int (*flush)(struct input_dev *dev, struct file *file);
 	int (*event)(struct input_dev *dev, unsigned int type, unsigned int code, int value);
 
-- 
1.7.2.3

