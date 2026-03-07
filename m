Received: from hognose1.porkbun.com (hognose1.porkbun.com [35.82.102.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A47B33D512;
	Sat,  7 Mar 2026 05:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.82.102.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772861406; cv=none; b=dwS3JoEAKb4L9BYG7X0XYG7eNCKXvS0T9+/R9YAT8bogS/YGbc3gAoBZY8G7mn5fTmUYj/ztBOqmCwToLITmrHryksyDIbEg/rinGSrntOYn0q6mgrxsrfF4/v40z2h2k6+dUUFmPKO3rFL7XC0Nv22wmhP6tUDdqJ8qJf8kqUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772861406; c=relaxed/simple;
	bh=0aWM4pzcPu12J86swN6uhXeWZIYBO4/eGBM7rzwJOUk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d8Y20nEuQg32icpuZdTq0fWyif8uHHY75hmdPhSp4rhJ4IQ82G+F7RW9aR1Fmu0xZjSNkl2RakPre+0rKlp5cMpMyH6ONSpf2GLM50lBzatobXiuq0dOpFyPzhTbo02aiai+651/DgDz+P2QvdtW7RMgdjVQhjZ90Vyk1PKWTbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=altimeter.info; spf=pass smtp.mailfrom=altimeter.info; dkim=pass (1024-bit key) header.d=altimeter.info header.i=@altimeter.info header.b=KSE0K3mU; arc=none smtp.client-ip=35.82.102.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=altimeter.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altimeter.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=altimeter.info header.i=@altimeter.info header.b="KSE0K3mU"
Received: from altimeter-info (unknown [45.55.225.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: linux-kernel@altimeter.info)
	by hognose1.porkbun.com (Postfix) with ESMTPSA id 65723461F97;
	Sat,  7 Mar 2026 05:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altimeter.info;
	s=default; t=1772860968;
	bh=l8kvMkrDOiaSMv0LXY/178y7A3wVVS/AbOE9Mi5qRqM=;
	h=Date:From:To:Cc:Subject;
	b=KSE0K3mUmuXe7V31GOv9kxTt6GEVYWKWYcVCin0VDD14yPkoC9dXYvkv1Cx0d3cjf
	 fSTq9s5o1s9yOxKk/Axk4EuJ4m77gCKpC6TL4mgLJUecwK3puD9Om06rpjOwYJsyG1
	 mySBFMOR5SGnhxqkXRBQBsR0PsJw72xz4G1MgOuk=
Date: Sat, 7 Mar 2026 05:22:46 +0000
From: Ivan Gorinov <linux-kernel@altimeter.info>
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] HID: winwing: Enable rumble effects
Message-ID: <20260307052246.GA21987@altimeter-info>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.24 (2015-08-30)

Enable rumble motor control on TGRIP-15E and TGRIP-15EX throttle grips
by sending haptic feedback commands (EV_FF events) to the input device.

Signed-off-by: Ivan Gorinov <linux-kernel@altimeter.info>
---

    Changes since v2:
       - Add comments about USB requests for LED and rumble control

    Changes since v1:
       - Fix possible NULL pointer dereference


---
 drivers/hid/hid-winwing.c | 196 +++++++++++++++++++++++++++++++++++---
 1 file changed, 182 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-winwing.c b/drivers/hid/hid-winwing.c
index ab65dc12d1e0..9cd25a77999e 100644
--- a/drivers/hid/hid-winwing.c
+++ b/drivers/hid/hid-winwing.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/workqueue.h>
 
 #define MAX_REPORT 16
 
@@ -35,10 +36,14 @@ static const struct winwing_led_info led_info[3] = {
 
 struct winwing_drv_data {
 	struct hid_device *hdev;
-	__u8 *report_buf;
-	struct mutex lock;
-	int map_more_buttons;
-	unsigned int num_leds;
+	struct mutex lights_lock;
+	__u8 *report_lights;
+	__u8 *report_rumble;
+	struct work_struct rumble_work;
+	struct ff_rumble_effect rumble;
+	int rumble_left;
+	int rumble_right;
+	int has_grip15;
 	struct winwing_led leds[];
 };
 
@@ -47,11 +52,15 @@ static int winwing_led_write(struct led_classdev *cdev,
 {
 	struct winwing_led *led = (struct winwing_led *) cdev;
 	struct winwing_drv_data *data = hid_get_drvdata(led->hdev);
-	__u8 *buf = data->report_buf;
+	__u8 *buf = data->report_lights;
 	int ret;
 
-	mutex_lock(&data->lock);
+	mutex_lock(&data->lights_lock);
 
+	/*
+	 * Mimicking requests captured by usbmon when LEDs
+	 * are controlled by the vendor's app in a VM.
+	 */
 	buf[0] = 0x02;
 	buf[1] = 0x60;
 	buf[2] = 0xbe;
@@ -69,7 +78,7 @@ static int winwing_led_write(struct led_classdev *cdev,
 
 	ret = hid_hw_output_report(led->hdev, buf, 14);
 
-	mutex_unlock(&data->lock);
+	mutex_unlock(&data->lights_lock);
 
 	return ret;
 }
@@ -87,9 +96,9 @@ static int winwing_init_led(struct hid_device *hdev,
 	if (!data)
 		return -EINVAL;
 
-	data->report_buf = devm_kmalloc(&hdev->dev, MAX_REPORT, GFP_KERNEL);
+	data->report_lights = devm_kzalloc(&hdev->dev, MAX_REPORT, GFP_KERNEL);
 
-	if (!data->report_buf)
+	if (!data->report_lights)
 		return -ENOMEM;
 
 	for (i = 0; i < 3; i += 1) {
@@ -117,7 +126,7 @@ static int winwing_init_led(struct hid_device *hdev,
 	return ret;
 }
 
-static int winwing_map_button(int button, int map_more_buttons)
+static int winwing_map_button(int button, int has_grip15)
 {
 	if (button < 1)
 		return KEY_RESERVED;
@@ -141,7 +150,7 @@ static int winwing_map_button(int button, int map_more_buttons)
 		return (button - 65) + BTN_TRIGGER_HAPPY17;
 	}
 
-	if (!map_more_buttons) {
+	if (!has_grip15) {
 		/*
 		 * Not mapping numbers [33 .. 64] which
 		 * are not assigned to any real buttons
@@ -194,13 +203,149 @@ static int winwing_input_mapping(struct hid_device *hdev,
 	/* Button numbers start with 1 */
 	button = usage->hid & HID_USAGE;
 
-	code = winwing_map_button(button, data->map_more_buttons);
+	code = winwing_map_button(button, data->has_grip15);
 
 	hid_map_usage(hi, usage, bit, max, EV_KEY, code);
 
 	return 1;
 }
 
+/*
+ * If x ≤ 0, return 0;
+ * if x is in [1 .. 65535], return a value in [1 .. 255]
+ */
+static inline int convert_magnitude(int x)
+{
+	if (x < 1)
+		return 0;
+
+	return ((x * 255) >> 16) + 1;
+}
+
+static int winwing_haptic_rumble(struct winwing_drv_data *data)
+{
+	__u8 *buf;
+	__u8 m;
+
+	if (!data)
+		return -EINVAL;
+
+	if (!data->hdev)
+		return -EINVAL;
+
+	buf = data->report_rumble;
+
+	if (!buf)
+		return -EINVAL;
+
+	m = convert_magnitude(data->rumble.strong_magnitude);
+	if (m != data->rumble_left) {
+		int ret;
+
+		/*
+		 * Mimicking requests captured by usbmon when rumble
+		 * is activated by the vendor's app in a VM.
+		 */
+		buf[0] = 0x02;
+		buf[1] = 0x01;
+		buf[2] = 0xbf;
+		buf[3] = 0x00;
+		buf[4] = 0x00;
+		buf[5] = 0x03;
+		buf[6] = 0x49;
+		buf[7] = 0x00;
+		buf[8] = m;
+		buf[9] = 0x00;
+		buf[10] = 0;
+		buf[11] = 0;
+		buf[12] = 0;
+		buf[13] = 0;
+
+		ret = hid_hw_output_report(data->hdev, buf, 14);
+		if (ret < 0) {
+			hid_err(data->hdev, "error %d (%*ph)\n", ret, 14, buf);
+			return ret;
+		}
+		data->rumble_left = m;
+	}
+
+	m = convert_magnitude(data->rumble.weak_magnitude);
+	if (m != data->rumble_right) {
+		int ret;
+
+		/*
+		 * Mimicking requests captured by usbmon when rumble
+		 * is activated by the vendor's app in a VM.
+		 */
+		buf[0] = 0x02;
+		buf[1] = 0x03;
+		buf[2] = 0xbf;
+		buf[3] = 0x00;
+		buf[4] = 0x00;
+		buf[5] = 0x03;
+		buf[6] = 0x49;
+		buf[7] = 0x00;
+		buf[8] = m;
+		buf[9] = 0x00;
+		buf[10] = 0;
+		buf[11] = 0;
+		buf[12] = 0;
+		buf[13] = 0;
+
+		ret = hid_hw_output_report(data->hdev, buf, 14);
+		if (ret < 0) {
+			hid_err(data->hdev, "error %d (%*ph)\n", ret, 14, buf);
+			return ret;
+		}
+		data->rumble_right = m;
+	}
+
+	return 0;
+}
+
+
+static void winwing_haptic_rumble_cb(struct work_struct *work)
+{
+	struct winwing_drv_data *data;
+
+	data = container_of(work, struct winwing_drv_data, rumble_work);
+	winwing_haptic_rumble(data);
+}
+
+static int winwing_play_effect(struct input_dev *dev, void *context,
+		struct ff_effect *effect)
+{
+	struct winwing_drv_data *data = (struct winwing_drv_data *) context;
+
+	if (effect->type != FF_RUMBLE)
+		return 0;
+
+	if (!data)
+		return -EINVAL;
+
+	data->rumble = effect->u.rumble;
+
+	return schedule_work(&data->rumble_work);
+}
+
+static int winwing_init_ff(struct hid_device *hdev, struct hid_input *hidinput)
+{
+	struct winwing_drv_data *data;
+
+	data = (struct winwing_drv_data *) hid_get_drvdata(hdev);
+	if (!data)
+		return -EINVAL;
+
+	data->report_rumble = devm_kzalloc(&hdev->dev, MAX_REPORT, GFP_KERNEL);
+	data->rumble_left = -1;
+	data->rumble_right = -1;
+
+	input_set_capability(hidinput->input, EV_FF, FF_RUMBLE);
+
+	return input_ff_create_memless(hidinput->input, data,
+			winwing_play_effect);
+}
+
 static int winwing_probe(struct hid_device *hdev,
 		const struct hid_device_id *id)
 {
@@ -219,10 +364,12 @@ static int winwing_probe(struct hid_device *hdev,
 	if (!data)
 		return -ENOMEM;
 
-	data->map_more_buttons = id->driver_data;
-
+	data->hdev = hdev;
+	data->has_grip15 = id->driver_data;
 	hid_set_drvdata(hdev, data);
 
+	INIT_WORK(&data->rumble_work, winwing_haptic_rumble_cb);
+
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
@@ -232,19 +379,39 @@ static int winwing_probe(struct hid_device *hdev,
 	return 0;
 }
 
+static void winwing_remove(struct hid_device *hdev)
+{
+	struct winwing_drv_data *data;
+
+	data = (struct winwing_drv_data *) hid_get_drvdata(hdev);
+
+	if (data)
+		cancel_work_sync(&data->rumble_work);
+
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+}
+
 static int winwing_input_configured(struct hid_device *hdev,
 		struct hid_input *hidinput)
 {
+	struct winwing_drv_data *data;
 	int ret;
 
+	data = (struct winwing_drv_data *) hid_get_drvdata(hdev);
+
 	ret = winwing_init_led(hdev, hidinput->input);
 
 	if (ret)
 		hid_err(hdev, "led init failed\n");
 
+	if (data->has_grip15)
+		winwing_init_ff(hdev, hidinput);
+
 	return ret;
 }
 
+/* Set driver_data to 1 for grips with rumble motor and more than 32 buttons */
 static const struct hid_device_id winwing_devices[] = {
 	{ HID_USB_DEVICE(0x4098, 0xbd65), .driver_data = 1 },  /* TGRIP-15E  */
 	{ HID_USB_DEVICE(0x4098, 0xbd64), .driver_data = 1 },  /* TGRIP-15EX */
@@ -261,6 +428,7 @@ static struct hid_driver winwing_driver = {
 	.input_configured = winwing_input_configured,
 	.input_mapping = winwing_input_mapping,
 	.probe = winwing_probe,
+	.remove = winwing_remove,
 };
 module_hid_driver(winwing_driver);
 
-- 
2.43.0

