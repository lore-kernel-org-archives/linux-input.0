From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 13/21] HID: wiimote: add extension hotplug support
Date: Sat, 13 Apr 2013 12:47:54 +0200
Message-ID: <1365850082-3585-14-git-send-email-dh.herrmann@gmail.com>
References: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:59919 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab3DMKsu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Apr 2013 06:48:50 -0400
Received: by mail-ee0-f48.google.com with SMTP id b15so1624724eek.21
        for <linux-input@vger.kernel.org>; Sat, 13 Apr 2013 03:48:49 -0700 (PDT)
In-Reply-To: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

The Wii Remote has several extension ports. The first port (EXT) provides
hotplug events whenever an extension is plugged. The second port (MP)
does not provide hotplug events by default. Instead, we have to map MP
into EXT to get events for it.

This patch introduces hotplug support for extensions. It is fairly
complicated to get this right because the Wii Remote sends a lot of
noise-hotplug events while activating extension ports. We need to filter
the events and only handle the events that are real hotplug events.

Mapping MP into EXT is easy. But if we want both, MP _and_ EXT at the same
time, we need to map MP into EXT and enable a passthrough-mode. This will
then send real EXT events through the mapped MP interleaved with real MP
events. But once MP is mapped, we no longer have access to the real EXT
registers so we need to perform setup _before_ mapping MP. Furthermore, we
no longer can read EXT IDs so we cannot verify if EXT is still the same
extension that we expect it to be.
We deal with this by unmapping MP whenever we got into a situation where
EXT might have changed. We then re-read EXT and MP and remap everything.

The real Wii Console takes a fairly easy approach: It simply reconnects to
the device on hotplug events that it didn't expect. So if a program wants
MP events, but MP is disconnected, it fails and reconnects so it can wait
for MP hotplug events again.
This simplifies hotplugging a lot because we just react on PLUG events and
ignore UNPLUG events.
The more sophisticated Wii applications avoid reconnection (well, they
still reconnect during many weird events, but at least not during UNPLUG)
but they start polling the device. This allows them to disable the device,
poll for the extension ports to settle and then initialize them again.
Unfortunately, this approach fails whenever an extension is replugged
while it is initialized. We would loose UNPLUG events and polling the
device later will give unreliable results because the extension port might
be in some weird state, even though it's actually unplugged.

Our approach is a real HOTPLUG approch. We keep track of the EXT and
mapped MP hotplug events whenever they occur. We then re-evaluate the
device state and initialize any possible new extension or deinitialize any
gone extension. Only during initialization, we set an extension port
ACTIVE. However, during an unplug event we mark them as INACTIVE. This
guarantess that a fast UNPLUG -> PLUG event sequence doesn't keep them
marked as PLUGGED+ACTIVE but only PLUGGED.
To deal with annoying noise-hotplug events during extension mapping, we
simply rescan the device before performing any mapping. This allows us to
ignore all the noise events as long as the device is in the correct state.

Long story short: EXT and MP registers are sparsely known and we need to
jump through hoops to get reliable HOTPLUG working. But while Nintendo
needs *FOUR* Bluetooth reconnections for the shortest imaginable
boot->menu->game->menu->shutdown sequence, we now need *ZERO*.

As always, 3rd party devices tend to break whenever we behave differently
than the original Wii. So there are also devices which _expect_ a
disconnect after UNPLUG. Obviously, these devices won't benefit from this
patch. But all official devices were tested extensively and work great
during any hotplug sequence. Yay!

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-core.c    | 635 ++++++++++++++++++++++++++++++++++++--
 drivers/hid/hid-wiimote-modules.c |  16 +
 drivers/hid/hid-wiimote.h         |  25 ++
 3 files changed, 655 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index f4e5c83..1f7a550 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -179,11 +179,24 @@ void wiiproto_req_leds(struct wiimote_data *wdata, int leds)
  * Check what peripherals of the wiimote are currently
  * active and select a proper DRM that supports all of
  * the requested data inputs.
+ *
+ * Not all combinations are actually supported. The following
+ * combinations work only with limitations:
+ *  - IR cam in extended or full mode disables any data transmission
+ *    of extension controllers. There is no DRM mode that supports
+ *    extension bytes plus extended/full IR.
+ *  - IR cam with accelerometer and extension *_EXT8 is not supported.
+ *    However, all extensions that need *_EXT8 are devices that don't
+ *    support IR cameras. Hence, this shouldn't happen under normal
+ *    operation.
  */
 static __u8 select_drm(struct wiimote_data *wdata)
 {
 	__u8 ir = wdata->state.flags & WIIPROTO_FLAGS_IR;
-	bool ext = wiiext_active(wdata);
+	bool ext;
+
+	ext = (wdata->state.flags & WIIPROTO_FLAG_EXT_USED) ||
+	      (wdata->state.flags & WIIPROTO_FLAG_MP_USED);
 
 	if (ir == WIIPROTO_FLAG_IR_BASIC) {
 		if (wdata->state.flags & WIIPROTO_FLAG_ACCEL)
@@ -399,9 +412,8 @@ static int wiimote_cmd_init_ext(struct wiimote_data *wdata)
 }
 
 /* requires the cmd-mutex to be held */
-static __u8 wiimote_cmd_read_ext(struct wiimote_data *wdata)
+static __u8 wiimote_cmd_read_ext(struct wiimote_data *wdata, __u8 *rmem)
 {
-	__u8 rmem[6];
 	int ret;
 
 	/* read extension ID */
@@ -416,6 +428,89 @@ static __u8 wiimote_cmd_read_ext(struct wiimote_data *wdata)
 	return WIIMOTE_EXT_UNKNOWN;
 }
 
+/* requires the cmd-mutex to be held */
+static int wiimote_cmd_init_mp(struct wiimote_data *wdata)
+{
+	__u8 wmem;
+	int ret;
+
+	/* initialize MP */
+	wmem = 0x55;
+	ret = wiimote_cmd_write(wdata, 0xa600f0, &wmem, sizeof(wmem));
+	if (ret)
+		return ret;
+
+	/* disable default encryption */
+	wmem = 0x0;
+	ret = wiimote_cmd_write(wdata, 0xa600fb, &wmem, sizeof(wmem));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/* requires the cmd-mutex to be held */
+static bool wiimote_cmd_map_mp(struct wiimote_data *wdata, __u8 exttype)
+{
+	__u8 wmem;
+
+	/* map MP with correct pass-through mode */
+	switch (exttype) {
+	default:
+		wmem = 0x04;
+		break;
+	}
+
+	return wiimote_cmd_write(wdata, 0xa600fe, &wmem, sizeof(wmem));
+}
+
+/* requires the cmd-mutex to be held */
+static bool wiimote_cmd_read_mp(struct wiimote_data *wdata, __u8 *rmem)
+{
+	int ret;
+
+	/* read motion plus ID */
+	ret = wiimote_cmd_read(wdata, 0xa600fa, rmem, 6);
+	if (ret != 6)
+		return false;
+
+	if (rmem[5] == 0x05)
+		return true;
+
+	hid_info(wdata->hdev, "unknown motion plus ID: %02x:%02x %02x:%02x %02x:%02x\n",
+		 rmem[0], rmem[1], rmem[2], rmem[3], rmem[4], rmem[5]);
+
+	return false;
+}
+
+/* requires the cmd-mutex to be held */
+static __u8 wiimote_cmd_read_mp_mapped(struct wiimote_data *wdata)
+{
+	int ret;
+	__u8 rmem[6];
+
+	/* read motion plus ID */
+	ret = wiimote_cmd_read(wdata, 0xa400fa, rmem, 6);
+	if (ret != 6)
+		return WIIMOTE_MP_NONE;
+
+	if (rmem[0] == 0xff && rmem[1] == 0xff && rmem[2] == 0xff &&
+	    rmem[3] == 0xff && rmem[4] == 0xff && rmem[5] == 0xff)
+		return WIIMOTE_MP_NONE;
+
+	if (rmem[4] == 0x04 && rmem[5] == 0x05)
+		return WIIMOTE_MP_SINGLE;
+	else if (rmem[4] == 0x05 && rmem[5] == 0x05)
+		return WIIMOTE_MP_PASSTHROUGH_NUNCHUK;
+	else if (rmem[4] == 0x07 && rmem[5] == 0x05)
+		return WIIMOTE_MP_PASSTHROUGH_CLASSIC;
+
+	hid_info(wdata->hdev, "unknown motion plus ID: %02x:%02x %02x:%02x %02x:%02x\n",
+		 rmem[0], rmem[1], rmem[2], rmem[3], rmem[4], rmem[5]);
+
+	return WIIMOTE_MP_UNKNOWN;
+}
+
 /* device module handling */
 
 static const __u8 * const wiimote_devtype_mods[WIIMOTE_DEV_NUM] = {
@@ -561,6 +656,81 @@ static void wiimote_modules_unload(struct wiimote_data *wdata)
 	}
 }
 
+/* device extension handling */
+
+static void wiimote_ext_load(struct wiimote_data *wdata, unsigned int ext)
+{
+	unsigned long flags;
+	const struct wiimod_ops *ops;
+	int ret;
+
+	ops = wiimod_ext_table[ext];
+
+	if (ops->probe) {
+		ret = ops->probe(ops, wdata);
+		if (ret)
+			ext = WIIMOTE_EXT_UNKNOWN;
+	}
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->state.exttype = ext;
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+}
+
+static void wiimote_ext_unload(struct wiimote_data *wdata)
+{
+	unsigned long flags;
+	const struct wiimod_ops *ops;
+
+	ops = wiimod_ext_table[wdata->state.exttype];
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->state.exttype = WIIMOTE_EXT_UNKNOWN;
+	wdata->state.flags &= ~WIIPROTO_FLAG_EXT_USED;
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	if (ops->remove)
+		ops->remove(ops, wdata);
+}
+
+static void wiimote_mp_load(struct wiimote_data *wdata)
+{
+	unsigned long flags;
+	const struct wiimod_ops *ops;
+	int ret;
+	__u8 mode = 2;
+
+	ops = &wiimod_mp;
+	if (ops->probe) {
+		ret = ops->probe(ops, wdata);
+		if (ret)
+			mode = 1;
+	}
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->state.mp = mode;
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+}
+
+static void wiimote_mp_unload(struct wiimote_data *wdata)
+{
+	unsigned long flags;
+	const struct wiimod_ops *ops;
+
+	if (wdata->state.mp < 2)
+		return;
+
+	ops = &wiimod_mp;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->state.mp = 0;
+	wdata->state.flags &= ~WIIPROTO_FLAG_MP_USED;
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	if (ops->remove)
+		ops->remove(ops, wdata);
+}
+
 /* device (re-)initialization and detection */
 
 static const char *wiimote_devtype_names[WIIMOTE_DEV_NUM] = {
@@ -617,7 +787,7 @@ done:
 
 static void wiimote_init_detect(struct wiimote_data *wdata)
 {
-	__u8 exttype = WIIMOTE_EXT_NONE;
+	__u8 exttype = WIIMOTE_EXT_NONE, extdata[6];
 	bool ext;
 	int ret;
 
@@ -641,11 +811,291 @@ static void wiimote_init_detect(struct wiimote_data *wdata)
 		goto out_release;
 
 	wiimote_cmd_init_ext(wdata);
-	exttype = wiimote_cmd_read_ext(wdata);
+	exttype = wiimote_cmd_read_ext(wdata, extdata);
 
 out_release:
 	wiimote_cmd_release(wdata);
 	wiimote_init_set_type(wdata, exttype);
+	/* schedule MP timer */
+	mod_timer(&wdata->timer, jiffies + HZ * 4);
+}
+
+/*
+ * MP hotplug events are not generated by the wiimote. Therefore, we need
+ * polling to detect it. We use a 4s interval for polling MP registers. This
+ * seems reasonable considering applications can trigger it manually via
+ * sysfs requests.
+ */
+static void wiimote_init_poll_mp(struct wiimote_data *wdata)
+{
+	bool mp;
+	__u8 mpdata[6];
+
+	wiimote_cmd_acquire_noint(wdata);
+	wiimote_cmd_init_mp(wdata);
+	mp = wiimote_cmd_read_mp(wdata, mpdata);
+	wiimote_cmd_release(wdata);
+
+	/* load/unload MP module if it changed */
+	if (mp) {
+		if (!wdata->state.mp) {
+			hid_info(wdata->hdev, "detected extension: Nintendo Wii Motion Plus\n");
+			wiimote_mp_load(wdata);
+		}
+	} else {
+		if (wdata->state.mp)
+			wiimote_mp_unload(wdata);
+	}
+
+	mod_timer(&wdata->timer, jiffies + HZ * 4);
+}
+
+/*
+ * Check whether the wiimote is in the expected state. The extension registers
+ * may change during hotplug and initialization so we might get hotplug events
+ * that we caused by remapping some memory.
+ * We use some heuristics here to check known states. If the wiimote is in the
+ * expected state, we can ignore the hotplug event.
+ *
+ * Returns "true" if the device is in expected state, "false" if we should
+ * redo hotplug handling and extension initialization.
+ */
+static bool wiimote_init_check(struct wiimote_data *wdata)
+{
+	__u32 flags;
+	__u8 type, data[6];
+	bool ret, poll_mp;
+
+	spin_lock_irq(&wdata->state.lock);
+	flags = wdata->state.flags;
+	spin_unlock_irq(&wdata->state.lock);
+
+	wiimote_cmd_acquire_noint(wdata);
+
+	/* If MP is used and active, but the extension is not, we expect:
+	 *   read_mp_mapped() == WIIMOTE_MP_SINGLE
+	 *   state.flags == !EXT_ACTIVE && !MP_PLUGGED && MP_ACTIVE
+	 * We do not check EXT_PLUGGED because it might change during
+	 * initialization of MP without extensions.
+	 *  - If MP is unplugged/replugged, read_mp_mapped() fails
+	 *  - If EXT is plugged, MP_PLUGGED will get set */
+	if (wdata->state.exttype == WIIMOTE_EXT_NONE &&
+	    wdata->state.mp > 0 && (flags & WIIPROTO_FLAG_MP_USED)) {
+		type = wiimote_cmd_read_mp_mapped(wdata);
+		ret = type == WIIMOTE_MP_SINGLE;
+
+		spin_lock_irq(&wdata->state.lock);
+		ret = ret && !(wdata->state.flags & WIIPROTO_FLAG_EXT_ACTIVE);
+		ret = ret && !(wdata->state.flags & WIIPROTO_FLAG_MP_PLUGGED);
+		ret = ret && (wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE);
+		spin_unlock_irq(&wdata->state.lock);
+
+		/* while MP is mapped, we get EXT_PLUGGED events */
+		poll_mp = false;
+
+		goto out_release;
+	}
+
+	/* If MP is unused, but the extension port is used, we expect:
+	 *   read_ext == state.exttype
+	 *   state.flags == !MP_ACTIVE && EXT_ACTIVE
+	 * - If MP is plugged/unplugged, our timer detects it
+	 * - If EXT is unplugged/replugged, EXT_ACTIVE will become unset */
+	if (!(flags & WIIPROTO_FLAG_MP_USED) &&
+	    wdata->state.exttype != WIIMOTE_EXT_NONE) {
+		type = wiimote_cmd_read_ext(wdata, data);
+		ret = type == wdata->state.exttype;
+
+		spin_lock_irq(&wdata->state.lock);
+		ret = ret && !(wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE);
+		ret = ret && (wdata->state.flags & WIIPROTO_FLAG_EXT_ACTIVE);
+		spin_unlock_irq(&wdata->state.lock);
+
+		/* poll MP for hotplug events */
+		poll_mp = true;
+
+		goto out_release;
+	}
+
+	/* If neither MP nor an extension are used, we expect:
+	 *   read_ext() == WIIMOTE_EXT_NONE
+	 *   state.flags == !MP_ACTIVE && !EXT_ACTIVE && !EXT_PLUGGED
+	 * No need to perform any action in this case as everything is
+	 * disabled already.
+	 * - If MP is plugged/unplugged, our timer detects it
+	 * - If EXT is plugged, EXT_PLUGGED will be set */
+	if (!(flags & WIIPROTO_FLAG_MP_USED) &&
+	    wdata->state.exttype == WIIMOTE_EXT_NONE) {
+		type = wiimote_cmd_read_ext(wdata, data);
+		ret = type == wdata->state.exttype;
+
+		spin_lock_irq(&wdata->state.lock);
+		ret = ret && !(wdata->state.flags & WIIPROTO_FLAG_EXT_ACTIVE);
+		ret = ret && !(wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE);
+		ret = ret && !(wdata->state.flags & WIIPROTO_FLAG_EXT_PLUGGED);
+		spin_unlock_irq(&wdata->state.lock);
+
+		/* poll MP for hotplug events */
+		poll_mp = true;
+
+		goto out_release;
+	}
+
+	/* The trickiest part is if both EXT and MP are active. We cannot read
+	 * the EXT ID, anymore, because MP is mapped over it. However, we use
+	 * a handy trick here:
+	 *   - EXT_ACTIVE is unset whenever !MP_PLUGGED is sent
+	 * MP_PLUGGED might be re-sent again before we are scheduled, but
+	 * EXT_ACTIVE will stay unset.
+	 * So it is enough to check for mp_mapped() and MP_ACTIVE and
+	 * EXT_ACTIVE. EXT_PLUGGED is a sanity check. */
+	if (wdata->state.exttype != WIIMOTE_EXT_NONE &&
+	    wdata->state.mp > 0 && (flags & WIIPROTO_FLAG_MP_USED)) {
+		type = wiimote_cmd_read_mp_mapped(wdata);
+		ret = type != WIIMOTE_MP_NONE;
+		ret = ret && type != WIIMOTE_MP_UNKNOWN;
+		ret = ret && type != WIIMOTE_MP_SINGLE;
+
+		spin_lock_irq(&wdata->state.lock);
+		ret = ret && (wdata->state.flags & WIIPROTO_FLAG_EXT_PLUGGED);
+		ret = ret && (wdata->state.flags & WIIPROTO_FLAG_EXT_ACTIVE);
+		ret = ret && (wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE);
+		spin_unlock_irq(&wdata->state.lock);
+
+		/* while MP is mapped, we get EXT_PLUGGED events */
+		poll_mp = false;
+
+		goto out_release;
+	}
+
+	/* unknown state */
+	ret = false;
+
+out_release:
+	wiimote_cmd_release(wdata);
+
+	/* only poll for MP if requested and if state didn't change */
+	if (ret && poll_mp)
+		wiimote_init_poll_mp(wdata);
+
+	return ret;
+}
+
+static const char *wiimote_exttype_names[WIIMOTE_EXT_NUM] = {
+	[WIIMOTE_EXT_NONE] = "None",
+	[WIIMOTE_EXT_UNKNOWN] = "Unknown",
+};
+
+/*
+ * Handle hotplug events
+ * If we receive an hotplug event and the device-check failed, we deinitialize
+ * the extension ports, re-read all extension IDs and set the device into
+ * the desired state. This involves mapping MP into the main extension
+ * registers, setting up extension passthrough modes and initializing the
+ * requested extensions.
+ */
+static void wiimote_init_hotplug(struct wiimote_data *wdata)
+{
+	__u8 exttype, extdata[6], mpdata[6];
+	__u16 flags;
+	bool mp;
+
+	wiimote_cmd_acquire_noint(wdata);
+
+	spin_lock_irq(&wdata->state.lock);
+
+	/* get state snapshot that we will then work on */
+	flags = wdata->state.flags;
+
+	/* disable event forwarding temporarily */
+	wdata->state.flags &= ~WIIPROTO_FLAG_EXT_ACTIVE;
+	wdata->state.flags &= ~WIIPROTO_FLAG_MP_ACTIVE;
+
+	spin_unlock_irq(&wdata->state.lock);
+
+	/* init extension and MP (deactivates current extension or MP) */
+	wiimote_cmd_init_ext(wdata);
+	wiimote_cmd_init_mp(wdata);
+
+	/* read extension and MP IDs */
+	mp = wiimote_cmd_read_mp(wdata, mpdata);
+	exttype = wiimote_cmd_read_ext(wdata, extdata);
+
+	wiimote_cmd_release(wdata);
+
+	/* load/unload extension module if it changed */
+	if (exttype != wdata->state.exttype) {
+		/* unload previous extension */
+		wiimote_ext_unload(wdata);
+
+		if (exttype == WIIMOTE_EXT_UNKNOWN) {
+			hid_info(wdata->hdev, "cannot detect extension; %02x:%02x %02x:%02x %02x:%02x\n",
+				 extdata[0], extdata[1], extdata[2],
+				 extdata[3], extdata[4], extdata[5]);
+		} else if (exttype == WIIMOTE_EXT_NONE) {
+			spin_lock_irq(&wdata->state.lock);
+			wdata->state.exttype = WIIMOTE_EXT_NONE;
+			spin_unlock_irq(&wdata->state.lock);
+		} else {
+			hid_info(wdata->hdev, "detected extension: %s\n",
+				 wiimote_exttype_names[exttype]);
+			/* try loading new extension */
+			wiimote_ext_load(wdata, exttype);
+		}
+	}
+
+	/* load/unload MP module if it changed */
+	if (mp) {
+		if (!wdata->state.mp) {
+			hid_info(wdata->hdev, "detected extension: Nintendo Wii Motion Plus\n");
+			wiimote_mp_load(wdata);
+		}
+	} else {
+		if (wdata->state.mp)
+			wiimote_mp_unload(wdata);
+	}
+
+	/* if MP is not used, do not map or activate it */
+	if (!(flags & WIIPROTO_FLAG_MP_USED))
+		mp = false;
+
+	/* Map MP into main extension registers if used. This causes the
+	 * device to send an hotplug event which we _must_ wait for. Otherwise,
+	 * we get invalid data from the device. But the device doesn't send
+	 * the hotplug event if it is already plugged. In this case, we also
+	 * get an MP hotplug event later so it will be rescheduled, anyway. */
+	if (mp) {
+		wiimote_cmd_acquire_noint(wdata);
+		wiimote_cmd_map_mp(wdata, exttype);
+		wiimote_cmd_release(wdata);
+
+		/* delete MP hotplug timer */
+		del_timer_sync(&wdata->timer);
+	} else {
+		/* reschedule MP hotplug timer */
+		mod_timer(&wdata->timer, jiffies + HZ * 4);
+	}
+
+	spin_lock_irq(&wdata->state.lock);
+
+	/* enable data forwarding again and set expected hotplug state */
+	if (mp) {
+		wdata->state.flags |= WIIPROTO_FLAG_MP_ACTIVE;
+		if (wdata->state.exttype == WIIMOTE_EXT_NONE) {
+			wdata->state.flags &= ~WIIPROTO_FLAG_EXT_PLUGGED;
+		} else {
+			wdata->state.flags |= WIIPROTO_FLAG_EXT_PLUGGED;
+			wdata->state.flags |= WIIPROTO_FLAG_MP_PLUGGED;
+			wdata->state.flags |= WIIPROTO_FLAG_EXT_ACTIVE;
+		}
+	} else if (wdata->state.exttype != WIIMOTE_EXT_NONE) {
+		wdata->state.flags |= WIIPROTO_FLAG_EXT_ACTIVE;
+	}
+
+	/* explicit protocol barrier for hotplug events */
+	wiiproto_req_status(wdata);
+
+	spin_unlock_irq(&wdata->state.lock);
 }
 
 static void wiimote_init_worker(struct work_struct *work)
@@ -655,6 +1105,30 @@ static void wiimote_init_worker(struct work_struct *work)
 
 	if (wdata->state.devtype == WIIMOTE_DEV_PENDING)
 		wiimote_init_detect(wdata);
+	if (!wiimote_init_check(wdata))
+		wiimote_init_hotplug(wdata);
+}
+
+void __wiimote_schedule(struct wiimote_data *wdata)
+{
+	if (!(wdata->state.flags & WIIPROTO_FLAG_EXITING))
+		schedule_work(&wdata->init_worker);
+}
+
+static void wiimote_schedule(struct wiimote_data *wdata)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	__wiimote_schedule(wdata);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+}
+
+static void wiimote_init_timeout(unsigned long arg)
+{
+	struct wiimote_data *wdata = (void*)arg;
+
+	wiimote_schedule(wdata);
 }
 
 /* protocol handlers */
@@ -664,6 +1138,12 @@ static void handler_keys(struct wiimote_data *wdata, const __u8 *payload)
 	const __u8 *iter, *mods;
 	const struct wiimod_ops *ops;
 
+	ops = wiimod_ext_table[wdata->state.exttype];
+	if (ops->in_keys) {
+		ops->in_keys(wdata, payload);
+		return;
+	}
+
 	mods = wiimote_devtype_mods[wdata->state.devtype];
 	for (iter = mods; *iter != WIIMOD_NULL; ++iter) {
 		ops = wiimod_table[*iter];
@@ -679,6 +1159,12 @@ static void handler_accel(struct wiimote_data *wdata, const __u8 *payload)
 	const __u8 *iter, *mods;
 	const struct wiimod_ops *ops;
 
+	ops = wiimod_ext_table[wdata->state.exttype];
+	if (ops->in_accel) {
+		ops->in_accel(wdata, payload);
+		return;
+	}
+
 	mods = wiimote_devtype_mods[wdata->state.devtype];
 	for (iter = mods; *iter != WIIMOD_NULL; ++iter) {
 		ops = wiimod_table[*iter];
@@ -695,6 +1181,12 @@ static void handler_ir(struct wiimote_data *wdata, const __u8 *payload,
 	const __u8 *iter, *mods;
 	const struct wiimod_ops *ops;
 
+	ops = wiimod_ext_table[wdata->state.exttype];
+	if (ops->in_ir) {
+		ops->in_ir(wdata, payload, packed, id);
+		return;
+	}
+
 	mods = wiimote_devtype_mods[wdata->state.devtype];
 	for (iter = mods; *iter != WIIMOD_NULL; ++iter) {
 		ops = wiimod_table[*iter];
@@ -705,6 +1197,93 @@ static void handler_ir(struct wiimote_data *wdata, const __u8 *payload,
 	}
 }
 
+static void handler_ext(struct wiimote_data *wdata, const __u8 *payload,
+			size_t len)
+{
+	const __u8 *iter, *mods;
+	const struct wiimod_ops *ops;
+	bool is_mp;
+
+	if (len < 6)
+		return;
+
+	/* if MP is active, track MP slot hotplugging */
+	if (wdata->state.flags & WIIPROTO_FLAG_MP_ACTIVE) {
+		/* this bit is set for invalid events (eg. during hotplug) */
+		if (payload[5] & 0x01)
+			return;
+
+		if (payload[4] & 0x01) {
+			if (!(wdata->state.flags & WIIPROTO_FLAG_MP_PLUGGED)) {
+				wdata->state.flags |= WIIPROTO_FLAG_MP_PLUGGED;
+				__wiimote_schedule(wdata);
+			}
+		} else {
+			if (wdata->state.flags & WIIPROTO_FLAG_MP_PLUGGED) {
+				wdata->state.flags &= ~WIIPROTO_FLAG_MP_PLUGGED;
+				wdata->state.flags &= ~WIIPROTO_FLAG_EXT_ACTIVE;
+				__wiimote_schedule(wdata);
+			}
+		}
+
+		/* detect MP data that is sent interleaved with EXT data */
+		is_mp = payload[5] & 0x02;
+
+		/* ignore EXT events if no extension is active */
+		if (!(wdata->state.flags & WIIPROTO_FLAG_EXT_ACTIVE) && !is_mp)
+			return;
+	} else {
+		is_mp = false;
+
+		/* ignore EXT events if no extension is active */
+		if (!(wdata->state.flags & WIIPROTO_FLAG_EXT_ACTIVE))
+			return;
+	}
+
+	/* try forwarding to extension handler, first */
+	ops = wiimod_ext_table[wdata->state.exttype];
+	if (!is_mp && ops->in_ext) {
+		if (!(ops->flags & WIIMOD_FLAG_EXT8) || len >= 8) {
+			ops->in_ext(wdata, payload);
+			return;
+		}
+	} else if (is_mp && ops->in_mp) {
+		ops->in_mp(wdata, payload);
+		return;
+	}
+
+	/* try forwarding to MP handler */
+	ops = &wiimod_mp;
+	if (!is_mp && ops->in_ext) {
+		if (!(ops->flags & WIIMOD_FLAG_EXT8) || len >= 8) {
+			ops->in_ext(wdata, payload);
+			return;
+		}
+	} else if (is_mp && ops->in_mp) {
+		ops->in_mp(wdata, payload);
+		return;
+	}
+
+	/* try forwarding to loaded modules */
+	mods = wiimote_devtype_mods[wdata->state.devtype];
+	for (iter = mods; *iter != WIIMOD_NULL; ++iter) {
+		ops = wiimod_table[*iter];
+		if (is_mp && !ops->in_mp)
+			continue;
+		if (!is_mp && !ops->in_ext)
+			continue;
+		if (!is_mp && (ops->flags & WIIMOD_FLAG_EXT8) && len < 8)
+			continue;
+
+		if (is_mp)
+			ops->in_mp(wdata, payload);
+		else
+			ops->in_ext(wdata, payload);
+
+		break;
+	}
+}
+
 #define ir_to_input0(wdata, ir, packed) handler_ir((wdata), (ir), (packed), 0)
 #define ir_to_input1(wdata, ir, packed) handler_ir((wdata), (ir), (packed), 1)
 #define ir_to_input2(wdata, ir, packed) handler_ir((wdata), (ir), (packed), 2)
@@ -727,11 +1306,18 @@ static void handler_status(struct wiimote_data *wdata, const __u8 *payload)
 
 	/* update extension status */
 	if (payload[2] & 0x02) {
-		wdata->state.flags |= WIIPROTO_FLAG_EXT_PLUGGED;
-		wiiext_event(wdata, true);
+		if (!(wdata->state.flags & WIIPROTO_FLAG_EXT_PLUGGED)) {
+			wdata->state.flags |= WIIPROTO_FLAG_EXT_PLUGGED;
+			__wiimote_schedule(wdata);
+		}
 	} else {
-		wdata->state.flags &= ~WIIPROTO_FLAG_EXT_PLUGGED;
-		wiiext_event(wdata, false);
+		if (wdata->state.flags & WIIPROTO_FLAG_EXT_PLUGGED) {
+			wdata->state.flags &= ~WIIPROTO_FLAG_EXT_PLUGGED;
+			wdata->state.flags &= ~WIIPROTO_FLAG_MP_PLUGGED;
+			wdata->state.flags &= ~WIIPROTO_FLAG_EXT_ACTIVE;
+			wdata->state.flags &= ~WIIPROTO_FLAG_MP_ACTIVE;
+			__wiimote_schedule(wdata);
+		}
 	}
 
 	wdata->state.cmd_battery = payload[5];
@@ -791,7 +1377,7 @@ static void handler_drm_KA(struct wiimote_data *wdata, const __u8 *payload)
 static void handler_drm_KE(struct wiimote_data *wdata, const __u8 *payload)
 {
 	handler_keys(wdata, payload);
-	wiiext_handle(wdata, &payload[2]);
+	handler_ext(wdata, &payload[2], 8);
 }
 
 static void handler_drm_KAI(struct wiimote_data *wdata, const __u8 *payload)
@@ -807,7 +1393,7 @@ static void handler_drm_KAI(struct wiimote_data *wdata, const __u8 *payload)
 static void handler_drm_KEE(struct wiimote_data *wdata, const __u8 *payload)
 {
 	handler_keys(wdata, payload);
-	wiiext_handle(wdata, &payload[2]);
+	handler_ext(wdata, &payload[2], 19);
 }
 
 static void handler_drm_KIE(struct wiimote_data *wdata, const __u8 *payload)
@@ -817,14 +1403,14 @@ static void handler_drm_KIE(struct wiimote_data *wdata, const __u8 *payload)
 	ir_to_input1(wdata, &payload[4], true);
 	ir_to_input2(wdata, &payload[7], false);
 	ir_to_input3(wdata, &payload[9], true);
-	wiiext_handle(wdata, &payload[12]);
+	handler_ext(wdata, &payload[12], 9);
 }
 
 static void handler_drm_KAE(struct wiimote_data *wdata, const __u8 *payload)
 {
 	handler_keys(wdata, payload);
 	handler_accel(wdata, payload);
-	wiiext_handle(wdata, &payload[5]);
+	handler_ext(wdata, &payload[5], 16);
 }
 
 static void handler_drm_KAIE(struct wiimote_data *wdata, const __u8 *payload)
@@ -835,12 +1421,12 @@ static void handler_drm_KAIE(struct wiimote_data *wdata, const __u8 *payload)
 	ir_to_input1(wdata, &payload[7], true);
 	ir_to_input2(wdata, &payload[10], false);
 	ir_to_input3(wdata, &payload[12], true);
-	wiiext_handle(wdata, &payload[15]);
+	handler_ext(wdata, &payload[15], 6);
 }
 
 static void handler_drm_E(struct wiimote_data *wdata, const __u8 *payload)
 {
-	wiiext_handle(wdata, payload);
+	handler_ext(wdata, payload, 21);
 }
 
 static void handler_drm_SKAI1(struct wiimote_data *wdata, const __u8 *payload)
@@ -960,16 +1546,27 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	wdata->state.cmd_battery = 0xff;
 
 	INIT_WORK(&wdata->init_worker, wiimote_init_worker);
+	setup_timer(&wdata->timer, wiimote_init_timeout, (long)wdata);
 
 	return wdata;
 }
 
 static void wiimote_destroy(struct wiimote_data *wdata)
 {
+	unsigned long flags;
+
 	wiidebug_deinit(wdata);
-	wiiext_deinit(wdata);
+
+	/* prevent init_worker from being scheduled again */
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->state.flags |= WIIPROTO_FLAG_EXITING;
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
 
 	cancel_work_sync(&wdata->init_worker);
+	del_timer_sync(&wdata->timer);
+
+	wiimote_mp_unload(wdata);
+	wiimote_ext_unload(wdata);
 	wiimote_modules_unload(wdata);
 	cancel_work_sync(&wdata->queue.worker);
 	hid_hw_close(wdata->hdev);
@@ -1010,10 +1607,6 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 		goto err_stop;
 	}
 
-	ret = wiiext_init(wdata);
-	if (ret)
-		goto err_free;
-
 	ret = wiidebug_init(wdata);
 	if (ret)
 		goto err_free;
@@ -1021,7 +1614,7 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 	hid_info(hdev, "New device registered\n");
 
 	/* schedule device detection */
-	schedule_work(&wdata->init_worker);
+	wiimote_schedule(wdata);
 
 	return 0;
 
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index 5cc593a..d3eef77 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -788,8 +788,19 @@ static const struct wiimod_ops wiimod_ir = {
 	.in_ir = wiimod_ir_in_ir,
 };
 
+/*
+ * Motion Plus
+ */
+
+const struct wiimod_ops wiimod_mp = {
+	.flags = 0,
+	.arg = 0,
+};
+
 /* module table */
 
+static const struct wiimod_ops wiimod_dummy;
+
 const struct wiimod_ops *wiimod_table[WIIMOD_NUM] = {
 	[WIIMOD_KEYS] = &wiimod_keys,
 	[WIIMOD_RUMBLE] = &wiimod_rumble,
@@ -801,3 +812,8 @@ const struct wiimod_ops *wiimod_table[WIIMOD_NUM] = {
 	[WIIMOD_ACCEL] = &wiimod_accel,
 	[WIIMOD_IR] = &wiimod_ir,
 };
+
+const struct wiimod_ops *wiimod_ext_table[WIIMOTE_EXT_NUM] = {
+	[WIIMOTE_EXT_NONE] = &wiimod_dummy,
+	[WIIMOTE_EXT_UNKNOWN] = &wiimod_dummy,
+};
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 07a6531..2b0d00c 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -22,6 +22,7 @@
 #include <linux/mutex.h>
 #include <linux/power_supply.h>
 #include <linux/spinlock.h>
+#include <linux/timer.h>
 
 #define WIIMOTE_NAME "Nintendo Wii Remote"
 #define WIIMOTE_BUFSIZE 32
@@ -36,6 +37,12 @@
 #define WIIPROTO_FLAG_IR_EXT		0x80
 #define WIIPROTO_FLAG_IR_FULL		0xc0 /* IR_BASIC | IR_EXT */
 #define WIIPROTO_FLAG_EXT_PLUGGED	0x0100
+#define WIIPROTO_FLAG_EXT_USED		0x0200
+#define WIIPROTO_FLAG_EXT_ACTIVE	0x0400
+#define WIIPROTO_FLAG_MP_PLUGGED	0x0800
+#define WIIPROTO_FLAG_MP_USED		0x1000
+#define WIIPROTO_FLAG_MP_ACTIVE		0x2000
+#define WIIPROTO_FLAG_EXITING		0x4000
 
 #define WIIPROTO_FLAGS_LEDS (WIIPROTO_FLAG_LED1 | WIIPROTO_FLAG_LED2 | \
 					WIIPROTO_FLAG_LED3 | WIIPROTO_FLAG_LED4)
@@ -75,6 +82,14 @@ enum wiimote_exttype {
 	WIIMOTE_EXT_NUM,
 };
 
+enum wiimote_mptype {
+	WIIMOTE_MP_NONE,
+	WIIMOTE_MP_UNKNOWN,
+	WIIMOTE_MP_SINGLE,
+	WIIMOTE_MP_PASSTHROUGH_NUNCHUK,
+	WIIMOTE_MP_PASSTHROUGH_CLASSIC,
+};
+
 struct wiimote_buf {
 	__u8 data[HID_MAX_BUFFER_SIZE];
 	size_t size;
@@ -94,6 +109,8 @@ struct wiimote_state {
 	__u8 accel_split[2];
 	__u8 drm;
 	__u8 devtype;
+	__u8 exttype;
+	__u8 mp;
 
 	/* synchronous cmd requests */
 	struct mutex sync;
@@ -115,6 +132,7 @@ struct wiimote_data {
 	struct input_dev *accel;
 	struct input_dev *ir;
 	struct power_supply battery;
+	struct timer_list timer;
 	struct wiimote_ext *ext;
 	struct wiimote_debug *debug;
 
@@ -140,6 +158,7 @@ enum wiimod_module {
 };
 
 #define WIIMOD_FLAG_INPUT		0x0001
+#define WIIMOD_FLAG_EXT8		0x0002
 
 struct wiimod_ops {
 	__u16 flags;
@@ -153,9 +172,13 @@ struct wiimod_ops {
 	void (*in_accel) (struct wiimote_data *wdata, const __u8 *accel);
 	void (*in_ir) (struct wiimote_data *wdata, const __u8 *ir, bool packed,
 		       unsigned int id);
+	void (*in_mp) (struct wiimote_data *wdata, const __u8 *mp);
+	void (*in_ext) (struct wiimote_data *wdata, const __u8 *ext);
 };
 
 extern const struct wiimod_ops *wiimod_table[WIIMOD_NUM];
+extern const struct wiimod_ops *wiimod_ext_table[WIIMOTE_EXT_NUM];
+extern const struct wiimod_ops wiimod_mp;
 
 /* wiimote requests */
 
@@ -189,6 +212,8 @@ enum wiiproto_reqs {
 #define dev_to_wii(pdev) hid_get_drvdata(container_of(pdev, struct hid_device, \
 									dev))
 
+void __wiimote_schedule(struct wiimote_data *wdata);
+
 extern void wiiproto_req_drm(struct wiimote_data *wdata, __u8 drm);
 extern void wiiproto_req_rumble(struct wiimote_data *wdata, __u8 rumble);
 extern void wiiproto_req_leds(struct wiimote_data *wdata, int leds);
-- 
1.8.2.1

