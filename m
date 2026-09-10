Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A44D3A0B36
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 03:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789010500; cv=none; b=KyLb5yHPklvB/0hEsX0Y0oQy9OyptgnHcSWTqPMNoQ7n0SeEvgv5p3kJKnL8RTKkXpvaqivdAAavSF25jXPwDG0d2aTXCoJ+w8IGb418M4CS8jKttEeQyo+08LD+BK9RDMGg4lVcVQA/aBpnPEb1FLnUfpK4uMemskxUYEvkTO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789010500; c=relaxed/simple;
	bh=LdBAAecAZ1OMl0W7f6TntsYbB4NODXa++UY4rORV7Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fg/CbFGWQIGixwJuTya7Ti0cHvbnPN7rLNYGZHbC3gqzR5xcIVbfgdoMx+1svH8c7DgZOretHXZXa8t6F7R/2L9CDbTDRXVzSIIf00bBguH00ufetz17LLax+OhkyaqYSKRRmjDHGWbG6lfs5OznCxMC30ydrZgAj2Jd8Nie1fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuzUXXcX; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuzUXXcX"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-7f4bdf4f0e8so645308a34.1
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 20:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789010497; x=1789615297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kyJeD3MenqHe8/v7HjjLsYU8Leth5wrcbz4y8p2ZViM=;
        b=XuzUXXcXxv3GM6VztOLRmyptG+gUUXvWz7PYGeisZ8ke/EoVl88nDDo5H6UBMaQyGl
         PxzWCb5/lPfsFkH7EVz/8uLBPrc/lvEWrYQGViVWr93LGvEk4YVmoTMEAyzSkZZ+XVvx
         viPKco7XvktUuNSmeR/9QjrN7up2ui8ibaBOVVuptoYJnpqBTCgyYOWHjYYB1/wdV72Z
         C18NJ3b61bJ2DzQejvhdMrm463ZzxackXoQ+96K6VJL8Njsx42gJ4TLGGHRfrxXhnf5T
         q7fGO7yU+W7uleM4J7C5atwBDfjatnWHyuSyFj9YL0eXaZ5u+dfkOH3Q1dgozf6weYsD
         ZkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789010497; x=1789615297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kyJeD3MenqHe8/v7HjjLsYU8Leth5wrcbz4y8p2ZViM=;
        b=jWQazhhsQCtQGrPmpXeTxk6r0ix8QzJC4bpKJ4XnR1+g2OLX7zRACJjRBMZysxI8CN
         WHWWKG5XIB/siciZ9vIAl+XtieYiuRFqvA9c5uHFoe9iY7fv0kg3Aef4JWlPV5HXfGAw
         CbwycrBQkhQtOtbDIHFuSEcDIOLjsjR/i7lr4c25gIhspeSE9zn4ukBG90x2JQ2hb97K
         pjbIcM7tLDNIwlqb08ALn/KapMrTLEcsleBstdPlO+FWXXgxZV3Rk73/ji45jP9B7hjV
         zWPiY24puR3eZR8spA4Dcg24VJxcLzlWQBCu1hT90Mnc+7yLMpGrxVngM4jpTVjIFwRA
         3xHA==
X-Gm-Message-State: AFuF++kqr77+DpOHDMx+A785DFDXxUELHj9dZVRY6w6c59yvLdfDev2k
	BS7bqDoJMwxx1joGR6T0aCVhmpxSayx3xGLw9DbItvQ85MVv4EqdM4sU
X-Gm-Gg: AYBFou25YUjaaC6XSD28YfafHNQWmDaVz+utxf/rSVaMKs3QjZe5Fd5SJttByvqFKXj
	ltTJcseoP17KJHkAyOgBeWyb/OgtgJuqliy0oksoLSjiykAWVjh8p75jXZ/EmkHG2aGH+ya2c9u
	pM5ECzjeQOlf3AaYZyn+UjD6rv9NH/xMOpjYUDyl3ZqXsnibA17ixHEdNaPhwNnKNVaoFXGIfF1
	QNfJyEj6/WsEmi4TdmYB0RKmftly6L6Co51oX7+qCjg9+kl8wy6VHEbYmi2plwEK2JEe8zw08A4
	PHFoPfLkQN5S0rEaLdB5A4j4JoycBn5/ZEzAumq/SnBJT6WqbUT+SnESMwwaDDqKMOlt9wdCrIw
	73l1Lt3EAd7P2lAJ+kHANCKA+gICr62iINLXeaEf+/ny3FyD2u4Q4oY2BqjWTgwWM/O0x5asO53
	uplnm/Tw/PdiEyYJnMG/O87tS/YAAWR8Ppvh6IIK8oxGDSxgfNckUWMNZswp8D8Md3bK1+Q86df
	jQoKk9+5KdHjPou6Ww0En5J0pnwwtUTbgUpA7J725qosNwZ1s38TRk=
X-Received: by 2002:a05:6830:91a:b0:7f4:5b0c:36a4 with SMTP id 46e09a7af769-7fb7be96d99mr19851635a34.3.1789010497206;
        Wed, 09 Sep 2026 20:21:37 -0700 (PDT)
Received: from localhost ([76.187.192.44])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f6da9a49sm19758315a34.13.2026.09.09.20.21.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 20:21:36 -0700 (PDT)
From: Andrei Aldea <andrei1998@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-leds@vger.kernel.org
Subject: [PATCH 10/15] HID: hid-oxp: handle controller reinitialization across suspend
Date: Wed,  9 Sep 2026 22:21:10 -0500
Message-ID: <20260910032115.28669-11-andrei1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910032115.28669-1-andrei1998@gmail.com>
References: <20260910032115.28669-1-andrei1998@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A Gen2 monocolor reply uses the same command value as the asynchronous MCU
reset notification. Treating every such report as a reset can schedule a
spurious controller reinitialization.

Track an outstanding monocolor write by command and zone under a per-HID
spinlock, and consume its matching acknowledgment before considering the
report a reset notification. Clear pending reply state during suspend and
teardown. A missing reply does not change legacy transport success
semantics.

For system suspend, disable and drain initialized configuration work and
reject new output while the device is suspended. Re-enable work on resume
and queue a fallback reinitialization after the documented MCU reset
interval. A qualifying reset notification can still bring that work
forward. Leave runtime autosuspend unchanged.

Fixes: 2f424f28fb39 ("HID: hid-oxp: Add Second Generation Gamepad Mode Switch")
Assisted-by: LLM
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Signed-off-by: Andrei Aldea <andrei1998@gmail.com>
---
 drivers/hid/hid-oxp.c | 116 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 107 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
index 7b36687..e26e6a9 100644
--- a/drivers/hid/hid-oxp.c
+++ b/drivers/hid/hid-oxp.c
@@ -16,6 +16,7 @@
 #include <linux/kstrtox.h>
 #include <linux/led-class-multicolor.h>
 #include <linux/mutex.h>
+#include <linux/spinlock.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
@@ -24,6 +25,7 @@
 
 #define OXP_PACKET_SIZE 64
 #define OXP_STATUS_HEADER_SIZE 6
+#define OXP_STATUS_ACK 0x20
 
 #define GEN1_MESSAGE_ID	0xff
 #define GEN2_MESSAGE_ID	0x3f
@@ -185,6 +187,10 @@ struct oxp_hid_cfg {
 	struct hid_device *hdev;
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
 	struct mutex rgb_mutex; /*serialize complete RGB transactions*/
+	spinlock_t rgb_reply_lock;
+	u8 rgb_reply_command;
+	u8 rgb_reply_zone;
+	bool rgb_reply_pending;
 	u8 rgb_brightness;
 	u8 gamepad_mode;
 	u8 rumble_intensity;
@@ -193,6 +199,7 @@ struct oxp_hid_cfg {
 	u8 rgb_en;
 	bool rgb_work_initialized;
 	bool gen2_work_initialized;
+	bool suspended;
 	bool removing;
 };
 
@@ -371,7 +378,7 @@ static void oxp_mcu_init_fn(struct work_struct *work)
 	u8 gp_mode_data[3] = { OXP_GP_MODE_DEBUG, 0x01, 0x02 };
 	int ret;
 
-	if (READ_ONCE(cfg->removing))
+	if (READ_ONCE(cfg->suspended) || READ_ONCE(cfg->removing))
 		return;
 
 	/* Re-apply the button mapping */
@@ -410,6 +417,7 @@ static int oxp_hid_raw_event_gen_2(struct hid_device *hdev,
 	struct oxp_hid_cfg *cfg = hid_get_drvdata(hdev);
 	struct led_classdev_mc *led_mc = cfg->led_mc;
 	struct oxp_gen_2_rgb_report *rgb_rep;
+	bool solicited = false;
 
 	if (size < OXP_STATUS_HEADER_SIZE)
 		return 0;
@@ -417,11 +425,26 @@ static int oxp_hid_raw_event_gen_2(struct hid_device *hdev,
 	if (data[0] != OXP_FID_GEN2_STATUS_EVENT)
 		return 0;
 
+	/* A monocolor acknowledgment is not an MCU reset notification. */
+	if (data[5] == OXP_STATUS_ACK) {
+		scoped_guard(spinlock_irqsave, &cfg->rgb_reply_lock) {
+			if (cfg->rgb_reply_pending &&
+			    data[3] == cfg->rgb_reply_command &&
+			    data[4] == cfg->rgb_reply_zone) {
+				cfg->rgb_reply_pending = false;
+				solicited = true;
+			}
+		}
+		if (solicited)
+			return 0;
+	}
+
 	/* Sent ~6s after resume event, indicating the MCU has fully reset.
 	 * Re-apply our settings after this has been received.
 	 */
 	if (data[3] == OXP_EFFECT_MONO_TRUE) {
 		if (READ_ONCE(cfg->gen2_work_initialized) &&
+		    !READ_ONCE(cfg->suspended) &&
 		    !READ_ONCE(cfg->removing))
 			mod_delayed_work(system_dfl_wq, &cfg->oxp_mcu_init,
 					 msecs_to_jiffies(50));
@@ -489,6 +512,7 @@ static int mcu_property_out(struct oxp_hid_cfg *cfg, u8 *header, size_t header_s
 			    size_t data_size, u8 *footer, size_t footer_size)
 {
 	unsigned char *dmabuf __free(kfree) = kzalloc(OXP_PACKET_SIZE, GFP_KERNEL);
+	bool rgb_write;
 	int ret;
 
 	if (!dmabuf)
@@ -500,6 +524,19 @@ static int mcu_property_out(struct oxp_hid_cfg *cfg, u8 *header, size_t header_s
 	guard(mutex)(&cfg->cfg_mutex);
 	if (READ_ONCE(cfg->removing))
 		return -ENODEV;
+	if (READ_ONCE(cfg->suspended))
+		return -EHOSTDOWN;
+
+	rgb_write = header_size && data_size > 1 &&
+		    header[0] == OXP_FID_GEN2_STATUS_EVENT &&
+		    data[0] == OXP_EFFECT_MONO_TRUE;
+	if (rgb_write) {
+		scoped_guard(spinlock_irqsave, &cfg->rgb_reply_lock) {
+			cfg->rgb_reply_command = data[0];
+			cfg->rgb_reply_zone = data[1];
+			cfg->rgb_reply_pending = true;
+		}
+	}
 
 	memcpy(dmabuf, header, header_size);
 	memcpy(dmabuf + header_size, data, data_size);
@@ -509,12 +546,18 @@ static int mcu_property_out(struct oxp_hid_cfg *cfg, u8 *header, size_t header_s
 	dev_dbg(&cfg->hdev->dev, "raw data: [%*ph]\n", OXP_PACKET_SIZE, dmabuf);
 
 	ret = hid_hw_output_report(cfg->hdev, dmabuf, OXP_PACKET_SIZE);
-	if (ret < 0)
-		return ret;
-
 	/* MCU takes 200ms to be ready for another command. */
 	msleep(200);
-	return ret == OXP_PACKET_SIZE ? 0 : -EIO;
+	if (ret >= 0)
+		ret = ret == OXP_PACKET_SIZE ? 0 : -EIO;
+
+	if (rgb_write) {
+		scoped_guard(spinlock_irqsave, &cfg->rgb_reply_lock) {
+			cfg->rgb_reply_pending = false;
+		}
+	}
+
+	return ret;
 }
 
 static int oxp_gen_1_property_out(struct oxp_hid_cfg *cfg, enum oxp_function_index fid, u8 *data,
@@ -748,7 +791,7 @@ static void oxp_btn_queue_fn(struct work_struct *work)
 					      struct oxp_hid_cfg, oxp_btn_queue);
 	int ret;
 
-	if (READ_ONCE(cfg->removing))
+	if (READ_ONCE(cfg->suspended) || READ_ONCE(cfg->removing))
 		return;
 
 	ret = oxp_set_buttons(cfg);
@@ -837,7 +880,7 @@ static ssize_t map_button_store(struct device *dev,
 	default:
 		return -EINVAL;
 	}
-	if (!READ_ONCE(cfg->removing))
+	if (!READ_ONCE(cfg->suspended) && !READ_ONCE(cfg->removing))
 		mod_delayed_work(system_dfl_wq, &cfg->oxp_btn_queue,
 				 msecs_to_jiffies(50));
 	return count;
@@ -1413,7 +1456,7 @@ static void oxp_rgb_queue_fn(struct work_struct *work)
 	u8 val = 4 * brightness / max_brightness;
 	int ret;
 
-	if (READ_ONCE(cfg->removing))
+	if (READ_ONCE(cfg->suspended) || READ_ONCE(cfg->removing))
 		return;
 
 	guard(mutex)(&cfg->rgb_mutex);
@@ -1442,7 +1485,7 @@ static void oxp_rgb_brightness_set(struct led_classdev *led_cdev,
 	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(led_cdev);
 	struct oxp_hid_cfg *cfg = container_of(mc_cdev, struct oxp_hid_cfg, cdev);
 
-	if (READ_ONCE(cfg->removing))
+	if (READ_ONCE(cfg->suspended) || READ_ONCE(cfg->removing))
 		return;
 
 	led_cdev->brightness = brightness;
@@ -1554,6 +1597,9 @@ static void oxp_drain_output(struct oxp_hid_cfg *cfg)
 static void oxp_quiesce_work(struct oxp_hid_cfg *cfg)
 {
 	WRITE_ONCE(cfg->removing, true);
+	scoped_guard(spinlock_irqsave, &cfg->rgb_reply_lock) {
+		cfg->rgb_reply_pending = false;
+	}
 	if (cfg->rgb_work_initialized)
 		disable_delayed_work_sync(&cfg->oxp_rgb_queue);
 	if (cfg->gen2_work_initialized) {
@@ -1584,6 +1630,7 @@ static int oxp_cfg_probe(struct hid_device *hdev, u16 up)
 	cfg->hdev = hdev;
 	mutex_init(&cfg->cfg_mutex);
 	mutex_init(&cfg->rgb_mutex);
+	spin_lock_init(&cfg->rgb_reply_lock);
 
 	/* Clear drvdata after registered callback objects have been released. */
 	hid_set_drvdata(hdev, cfg);
@@ -1714,6 +1761,54 @@ static void oxp_hid_remove(struct hid_device *hdev)
 	hid_hw_stop(hdev);
 }
 
+static int __maybe_unused oxp_hid_suspend(struct hid_device *hdev,
+					  pm_message_t message)
+{
+	struct oxp_hid_cfg *cfg = hid_get_drvdata(hdev);
+
+	if (!cfg || PMSG_IS_AUTO(message))
+		return 0;
+
+	WRITE_ONCE(cfg->suspended, true);
+	scoped_guard(spinlock_irqsave, &cfg->rgb_reply_lock) {
+		cfg->rgb_reply_pending = false;
+	}
+	if (cfg->rgb_work_initialized)
+		disable_delayed_work_sync(&cfg->oxp_rgb_queue);
+	if (cfg->gen2_work_initialized) {
+		disable_delayed_work_sync(&cfg->oxp_btn_queue);
+		disable_delayed_work_sync(&cfg->oxp_mcu_init);
+	}
+	oxp_drain_output(cfg);
+
+	return 0;
+}
+
+static int __maybe_unused oxp_hid_resume(struct hid_device *hdev)
+{
+	struct oxp_hid_cfg *cfg = hid_get_drvdata(hdev);
+
+	if (!cfg || !READ_ONCE(cfg->suspended) ||
+	    READ_ONCE(cfg->removing))
+		return 0;
+
+	if (cfg->rgb_work_initialized)
+		enable_delayed_work(&cfg->oxp_rgb_queue);
+	if (cfg->gen2_work_initialized) {
+		enable_delayed_work(&cfg->oxp_btn_queue);
+		enable_delayed_work(&cfg->oxp_mcu_init);
+	}
+	WRITE_ONCE(cfg->suspended, false);
+	if (!cfg->gen2_work_initialized)
+		return 0;
+
+	/* Allow the controller MCU to finish rebooting before restoring state. */
+	queue_delayed_work(system_dfl_wq, &cfg->oxp_mcu_init,
+			   msecs_to_jiffies(6500));
+
+	return 0;
+}
+
 static const struct hid_device_id oxp_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CRSC, USB_DEVICE_ID_ONEXPLAYER_GEN1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WCH, USB_DEVICE_ID_ONEXPLAYER_GEN2) },
@@ -1727,6 +1822,9 @@ static struct hid_driver hid_oxp = {
 	.probe = oxp_hid_probe,
 	.remove = oxp_hid_remove,
 	.raw_event = oxp_hid_raw_event,
+	.suspend = pm_ptr(oxp_hid_suspend),
+	.resume = pm_ptr(oxp_hid_resume),
+	.reset_resume = pm_ptr(oxp_hid_resume),
 };
 module_hid_driver(hid_oxp);
 
