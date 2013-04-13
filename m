From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 17/21] HID: wiimote: add Motion Plus extension module
Date: Sat, 13 Apr 2013 12:47:58 +0200
Message-ID: <1365850082-3585-18-git-send-email-dh.herrmann@gmail.com>
References: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f179.google.com ([209.85.215.179]:48206 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab3DMKs5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Apr 2013 06:48:57 -0400
Received: by mail-ea0-f179.google.com with SMTP id f15so1532995eak.24
        for <linux-input@vger.kernel.org>; Sat, 13 Apr 2013 03:48:56 -0700 (PDT)
In-Reply-To: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

Add parsers for motion plus data so we can hotplug motion plus extensions
and make use of them. This is mostly the same as the old static motion
plus parser.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-modules.c | 144 ++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-wiimote.h         |   1 +
 2 files changed, 145 insertions(+)

diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index a1a4438..c3e823d 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -1475,11 +1475,155 @@ static const struct wiimod_ops wiimod_bboard = {
 
 /*
  * Motion Plus
+ * The Motion Plus extension provides rotation sensors (gyro) as a small
+ * extension device for Wii Remotes. Many devices have them built-in so
+ * you cannot see them from the outside.
+ * Motion Plus extensions are special because they are on a separate extension
+ * port and allow other extensions to be used simultaneously. This is all
+ * handled by the Wiimote Core so we don't have to deal with it.
  */
 
+static void wiimod_mp_in_mp(struct wiimote_data *wdata, const __u8 *ext)
+{
+	__s32 x, y, z;
+
+	/*        |   8    7    6    5    4    3 |  2  |  1  |
+	 *   -----+------------------------------+-----+-----+
+	 *    1   |               Yaw Speed <7:0>            |
+	 *    2   |              Roll Speed <7:0>            |
+	 *    3   |             Pitch Speed <7:0>            |
+	 *   -----+------------------------------+-----+-----+
+	 *    4   |       Yaw Speed <13:8>       | Yaw |Pitch|
+	 *   -----+------------------------------+-----+-----+
+	 *    5   |      Roll Speed <13:8>       |Roll | Ext |
+	 *   -----+------------------------------+-----+-----+
+	 *    6   |     Pitch Speed <13:8>       |  1  |  0  |
+	 *   -----+------------------------------+-----+-----+
+	 * The single bits Yaw, Roll, Pitch in the lower right corner specify
+	 * whether the wiimote is rotating fast (0) or slow (1). Speed for slow
+	 * roation is 440 deg/s and for fast rotation 2000 deg/s. To get a
+	 * linear scale we multiply by 2000/440 = ~4.5454 which is 18 for fast
+	 * and 9 for slow.
+	 * If the wiimote is not rotating the sensor reports 2^13 = 8192.
+	 * Ext specifies whether an extension is connected to the motionp.
+	 * which is parsed by wiimote-core.
+	 */
+
+	x = ext[0];
+	y = ext[1];
+	z = ext[2];
+
+	x |= (((__u16)ext[3]) << 6) & 0xff00;
+	y |= (((__u16)ext[4]) << 6) & 0xff00;
+	z |= (((__u16)ext[5]) << 6) & 0xff00;
+
+	x -= 8192;
+	y -= 8192;
+	z -= 8192;
+
+	if (!(ext[3] & 0x02))
+		x *= 18;
+	else
+		x *= 9;
+	if (!(ext[4] & 0x02))
+		y *= 18;
+	else
+		y *= 9;
+	if (!(ext[3] & 0x01))
+		z *= 18;
+	else
+		z *= 9;
+
+	input_report_abs(wdata->mp, ABS_RX, x);
+	input_report_abs(wdata->mp, ABS_RY, y);
+	input_report_abs(wdata->mp, ABS_RZ, z);
+	input_sync(wdata->mp);
+}
+
+static int wiimod_mp_open(struct input_dev *dev)
+{
+	struct wiimote_data *wdata = input_get_drvdata(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->state.flags |= WIIPROTO_FLAG_MP_USED;
+	wiiproto_req_drm(wdata, WIIPROTO_REQ_NULL);
+	__wiimote_schedule(wdata);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	return 0;
+}
+
+static void wiimod_mp_close(struct input_dev *dev)
+{
+	struct wiimote_data *wdata = input_get_drvdata(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->state.flags &= ~WIIPROTO_FLAG_MP_USED;
+	wiiproto_req_drm(wdata, WIIPROTO_REQ_NULL);
+	__wiimote_schedule(wdata);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+}
+
+static int wiimod_mp_probe(const struct wiimod_ops *ops,
+			   struct wiimote_data *wdata)
+{
+	int ret;
+
+	wdata->mp = input_allocate_device();
+	if (!wdata->mp)
+		return -ENOMEM;
+
+	input_set_drvdata(wdata->mp, wdata);
+	wdata->mp->open = wiimod_mp_open;
+	wdata->mp->close = wiimod_mp_close;
+	wdata->mp->dev.parent = &wdata->hdev->dev;
+	wdata->mp->id.bustype = wdata->hdev->bus;
+	wdata->mp->id.vendor = wdata->hdev->vendor;
+	wdata->mp->id.product = wdata->hdev->product;
+	wdata->mp->id.version = wdata->hdev->version;
+	wdata->mp->name = WIIMOTE_NAME " Motion Plus";
+
+	set_bit(EV_ABS, wdata->mp->evbit);
+	set_bit(ABS_RX, wdata->mp->absbit);
+	set_bit(ABS_RY, wdata->mp->absbit);
+	set_bit(ABS_RZ, wdata->mp->absbit);
+	input_set_abs_params(wdata->mp,
+			     ABS_RX, -16000, 16000, 4, 8);
+	input_set_abs_params(wdata->mp,
+			     ABS_RY, -16000, 16000, 4, 8);
+	input_set_abs_params(wdata->mp,
+			     ABS_RZ, -16000, 16000, 4, 8);
+
+	ret = input_register_device(wdata->mp);
+	if (ret)
+		goto err_free;
+
+	return 0;
+
+err_free:
+	input_free_device(wdata->mp);
+	wdata->mp = NULL;
+	return ret;
+}
+
+static void wiimod_mp_remove(const struct wiimod_ops *ops,
+			     struct wiimote_data *wdata)
+{
+	if (!wdata->mp)
+		return;
+
+	input_unregister_device(wdata->mp);
+	wdata->mp = NULL;
+}
+
 const struct wiimod_ops wiimod_mp = {
 	.flags = 0,
 	.arg = 0,
+	.probe = wiimod_mp_probe,
+	.remove = wiimod_mp_remove,
+	.in_mp = wiimod_mp_in_mp,
 };
 
 /* module table */
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 324d442..46457f6 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -139,6 +139,7 @@ struct wiimote_data {
 	struct input_dev *accel;
 	struct input_dev *ir;
 	struct power_supply battery;
+	struct input_dev *mp;
 	struct timer_list timer;
 	struct wiimote_ext *ext;
 	struct wiimote_debug *debug;
-- 
1.8.2.1

