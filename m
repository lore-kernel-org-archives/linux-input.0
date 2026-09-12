Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FEE30ACF1
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 03:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789182382; cv=none; b=AuvXbETPunjqk8Gz0EHp+xKq2B1qfwOJOo+Dkdg364f84F5CO/kjnL8qAU68UDw9NaEXPUaVTc3eK71j4sLA4j0AR+E6p1UVQ6Vxm2ylMv+Y81kjZ4NwQ6WFXjl4UsGNiy5f3JFMAlK7aRBGSIl3mR5Z1mnlTub9/CvZELyHhPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789182382; c=relaxed/simple;
	bh=c0kDa8Lm0Z4CY4h9SwdyDaoHDkofwEvg1xcrVG+lV3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQHJrmHhylRVlN1tKgda+PrQFr0sXg8bD1M9qW5L8sxp2GH3t52Oi5dvko0C/cOvmWIeME/uFIAxSzyQVBIjphy3QQ/u4He8Mn0027zIvjwjRYS+Gwb64j4nVL+aIF0EXD+MGbMaIdwSHhuemfUOk6Hps+FTFMbDqCVWGX3C8o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=CmPry+3F; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="CmPry+3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1789182374; bh=c0kDa8Lm0Z4CY4h9SwdyDaoHDkofwEvg1xcrVG+lV3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CmPry+3F/ZI4wPzAqd038WP2uT85ZcLmSs+ez3NfFynZ0UD1uXH0FngEUZFi1GQwK
	 3lbC0GQoQzJVegbpRKetb9I+mt1oYKRdApz//aqd/r2Odt1lwg5FiqMYtk7LgDMOCv
	 NYhWbtYVXhoGeXVGyc43cbNBOYCDDySTk+KV5LlVSSHCFVzqHbJq2NcAeRtzmIM7rH
	 pmv9IsjA7mCyMS145WB0ufbpBRC+wb3xX3+HLRyl3cCmic1+ZibTtujoHIbmb8ioSX
	 droUActzXuwdJM0borucZjO1ij/Bk51ZJvNJ845EnJQaqeGIw4ChVaUgOkQeISboNX
	 Oy3wtUZI1Gqeg==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 26099132037;
	Fri, 11 Sep 2026 20:06:14 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v7 05/12] Input: xbox_gip - Add battery support
Date: Fri, 11 Sep 2026 20:04:16 -0700
Message-ID: <20260912030426.2997003-6-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260912030426.2997003-1-vi@endrift.com>
References: <20260912030426.2997003-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Controllers are required to give information about the battery in the
controller, if present. This patch exposes that information as a
power_supply device.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/input/joystick/gip/gip-core.c | 116 +++++++++++++++++++++++++-
 drivers/input/joystick/gip/gip.h      |   4 +
 2 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joystick/gip/gip-core.c
index 411b67399e01..92bfdd6d7682 100644
--- a/drivers/input/joystick/gip/gip-core.c
+++ b/drivers/input/joystick/gip/gip-core.c
@@ -255,6 +255,13 @@ static const struct gip_audio_format gip_audio_format_table[MAX_GIP_AUDIO_FORMAT
 };
 
 
+static enum power_supply_property gip_battery_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
+	POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_STATUS,
+};
+
 static const struct gip_quirks base_quirks[] = {
 	{ GIP_VID_PDP, GIP_PID_PDP_ROCK_CANDY, 0, .quirks = GIP_QUIRK_NO_HELLO },
 
@@ -1218,6 +1225,97 @@ static int gip_guide_led_probe(struct gip_attachment *attachment, struct device
 	return rc;
 }
 
+static int gip_battery_get_property(struct power_supply *psy,
+	enum power_supply_property psp, union power_supply_propval *val)
+{
+	struct gip_attachment *attachment = power_supply_get_drvdata(psy);
+
+	guard(spinlock_irqsave)(&attachment->battery_lock);
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = attachment->status.base.battery_type != GIP_BATTERY_ABSENT;
+		break;
+	case POWER_SUPPLY_PROP_SCOPE:
+		val->intval = POWER_SUPPLY_SCOPE_DEVICE;
+		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		if (attachment->status.base.battery_type == GIP_BATTERY_ABSENT) {
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		} else {
+			switch (attachment->status.base.charge) {
+			case GIP_CHARGING:
+				if (attachment->status.base.battery_level == GIP_BATTERY_FULL)
+					val->intval = POWER_SUPPLY_STATUS_FULL;
+				else
+					val->intval = POWER_SUPPLY_STATUS_CHARGING;
+				break;
+			case GIP_NOT_CHARGING:
+				val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+				break;
+			case GIP_CHARGE_ERROR:
+			default:
+				val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+				break;
+			}
+		}
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
+		if (attachment->status.base.battery_type == GIP_BATTERY_ABSENT) {
+			val->intval = POWER_SUPPLY_CAPACITY_LEVEL_FULL;
+		} else {
+			switch (attachment->status.base.battery_level) {
+			case GIP_BATTERY_CRITICAL:
+				val->intval = POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
+				break;
+			case GIP_BATTERY_LOW:
+				val->intval = POWER_SUPPLY_CAPACITY_LEVEL_LOW;
+				break;
+			case GIP_BATTERY_MEDIUM:
+				val->intval = POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
+				break;
+			case GIP_BATTERY_FULL:
+				val->intval = POWER_SUPPLY_CAPACITY_LEVEL_FULL;
+				break;
+			default:
+				val->intval = POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN;
+				break;
+			}
+			break;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int gip_battery_create(struct gip_attachment *attachment, struct device *dev)
+{
+	struct power_supply_config supply_config = { .drv_data = attachment, };
+	int rc;
+
+	attachment->battery_desc.properties = gip_battery_props;
+	attachment->battery_desc.num_properties = ARRAY_SIZE(gip_battery_props);
+	attachment->battery_desc.get_property = gip_battery_get_property;
+	attachment->battery_desc.type = POWER_SUPPLY_TYPE_BATTERY;
+	attachment->battery_desc.name = devm_kasprintf(dev, GFP_KERNEL, "gip-%s", dev_name(dev));
+
+	if (!attachment->battery_desc.name)
+		return -ENOMEM;
+
+	attachment->battery = devm_power_supply_register(dev,
+		&attachment->battery_desc, &supply_config);
+	if (IS_ERR(attachment->battery)) {
+		rc = PTR_ERR(attachment->battery);
+		attachment->battery = NULL;
+		devm_kfree(dev, attachment->battery_desc.name);
+		return rc;
+	}
+
+	power_supply_powers(attachment->battery, dev);
+	return 0;
+}
+
 static bool gip_send_set_device_state(struct gip_attachment *attachment, uint8_t state)
 {
 	uint8_t buffer[] = { state };
@@ -1331,6 +1429,9 @@ static int gip_setup_input_device(struct gip_attachment *attachment)
 	rc = gip_guide_led_probe(attachment, &input->dev);
 	if (rc)
 		gip_err(attachment, "Failed to register LEDs: %d\n", rc);
+	rc = gip_battery_create(attachment, &input->dev);
+	if (rc)
+		gip_err(attachment, "Failed to register battery: %d\n", rc);
 
 	return 0;
 
@@ -1514,6 +1615,8 @@ static void gip_free_devices(struct gip_attachment *attachment)
 
 	rcu_assign_pointer(attachment->input, NULL);
 	rcu_assign_pointer(attachment->hdev, NULL);
+	/* The following are freed by devres */
+	attachment->battery = NULL;
 	synchronize_rcu();
 
 	if (input)
@@ -1647,10 +1750,14 @@ static int gip_handle_command_status_device(struct gip_attachment *attachment,
 	if (num_bytes < 1)
 		return -EINVAL;
 
-	attachment->status.base.battery_level = bytes[0] & 3;
-	attachment->status.base.battery_type = (bytes[0] >> 2) & 3;
-	attachment->status.base.charge = (bytes[0] >> 4) & 3;
-	attachment->status.base.power_level = (bytes[0] >> 6) & 3;
+	scoped_guard(spinlock_irqsave, &attachment->battery_lock) {
+		attachment->status.base.battery_level = bytes[0] & 3;
+		attachment->status.base.battery_type = (bytes[0] >> 2) & 3;
+		attachment->status.base.charge = (bytes[0] >> 4) & 3;
+		attachment->status.base.power_level = (bytes[0] >> 6) & 3;
+	}
+	if (attachment->battery)
+		power_supply_changed(attachment->battery);
 
 	if (num_bytes >= 4) {
 		attachment->status.device_active = bytes[1] & 1;
@@ -2145,6 +2252,7 @@ static struct gip_attachment *gip_ensure_attachment(struct gip_device *device,
 		mutex_init(&attachment->lock);
 		guard(mutex)(&attachment->lock);
 		device->attachments[attachment_index] = attachment;
+		spin_lock_init(&attachment->battery_lock);
 		INIT_DELAYED_WORK(&attachment->in_fragment_timeout, gip_fragment_timeout);
 		INIT_DELAYED_WORK(&attachment->metadata_next, gip_retry_metadata);
 #ifdef CONFIG_JOYSTICK_XBOX_GIP_FF
diff --git a/drivers/input/joystick/gip/gip.h b/drivers/input/joystick/gip/gip.h
index 525d04b83837..42b46b473b7e 100644
--- a/drivers/input/joystick/gip/gip.h
+++ b/drivers/input/joystick/gip/gip.h
@@ -14,6 +14,7 @@
 
 #include <linux/hid.h>
 #include <linux/led-class-multicolor.h>
+#include <linux/power_supply.h>
 #include <linux/rcupdate.h>
 #include <linux/usb/input.h>
 
@@ -247,6 +248,9 @@ struct gip_attachment {
 		struct led_classdev_mc color;
 	} guide_led;
 
+	spinlock_t battery_lock;
+	struct power_supply *battery;
+	struct power_supply_desc battery_desc;
 	struct gip_extended_status status;
 
 	enum gip_elite_button_format xbe_format;
-- 
2.54.0

