Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E0C33AD9B
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 01:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788311067; cv=none; b=RRcg6Z8JxiUEG4sAaZQVBqwKkxt5PY+1Q1FxA1/vslcdidGkhOa/OpTjb8PsKREc94URBs9C4wtCik8qwDdMn2um3LxxKojAJekCZ2nhMuCe66QQOx34YoARjux2ju8sDDk77OqUDxGStQzmLvP5zRHEEiLRj6SSO5aqUeSXywA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788311067; c=relaxed/simple;
	bh=gof44P4sjcF1Yzf7yoca4JGaxqwmh/EA68nhUNgACes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vj8K5GsSNohvBHdbdpi1O5JPcja9JSNTjZUG77zlWu728Xr29jDtGa5xvvRPhLDCAFzDWTAupcy9vKnXfslf4+/LUdKofFtbLwhJjMZmr9F7l9S9fmI4frDGS5u+6MUpGAg+liSDrW+M+3kXiJrBCrZx2SQq613mQfZIQV/ZCkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=KXWQaByd; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="KXWQaByd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1788311059; bh=gof44P4sjcF1Yzf7yoca4JGaxqwmh/EA68nhUNgACes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KXWQaByd/rJvJPAy6cMwaNUzEArb8zI3BKMuwU7NlT4AdlVL2uqpuv3d8aDQm+mvt
	 9KfGJc9Pa72UeJlCeHwShPdYL6GNI7D/2D/BbafLIfODjMep7SqYlCNWrunkAvtM7E
	 eVII4ufRQFpPOITjxvnDqjDROJDgUBuwzjZiDB1IB3iqFE5MASjKr+xGtdPMS4qmUQ
	 ETbkipcyCK/fjUeqRywO9fA2QOg2pXu7qRhx4By244LNGgB0FxoGMtfAUAxKfOd2b0
	 +bBr4uqim4/Ukp+3mDrLZSHR2Dx6PsHIn/aPw2Y/NQyBwWTkWZnCcmZxCJSV3VapvN
	 qGt5ymmGmNCsg==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id C12F1132034;
	Tue, 01 Sep 2026 18:04:18 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v5 05/12] Input: xbox_gip - Add battery support
Date: Tue,  1 Sep 2026 18:02:26 -0700
Message-ID: <20260902010237.865772-6-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260902010237.865772-1-vi@endrift.com>
References: <20260902010237.865772-1-vi@endrift.com>
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
 drivers/input/joystick/gip/gip-core.c | 125 +++++++++++++++++++++++++-
 drivers/input/joystick/gip/gip.h      |   4 +
 2 files changed, 125 insertions(+), 4 deletions(-)

diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joystick/gip/gip-core.c
index 3b033fe65dc4..57d638408daf 100644
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
 
@@ -1199,6 +1206,106 @@ static int gip_guide_led_probe(struct gip_attachment *attachment, struct device
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
+	attachment->battery_desc.name = devm_kasprintf(dev, GFP_KERNEL,
+		"gip-battery-%s", dev_name(dev));
+
+	if (!attachment->battery_desc.name)
+		return -ENOMEM;
+
+	attachment->battery = devm_power_supply_register(dev,
+		&attachment->battery_desc, &supply_config);
+	if (IS_ERR(attachment->battery)) {
+		rc = PTR_ERR(attachment->battery);
+		goto err_out;
+	}
+
+	rc = power_supply_powers(attachment->battery, dev);
+	if (rc < 0) {
+		power_supply_unregister(attachment->battery);
+		goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	attachment->battery = NULL;
+	devm_kfree(dev, attachment->battery_desc.name);
+	return rc;
+}
+
 static bool gip_send_set_device_state(struct gip_attachment *attachment, uint8_t state)
 {
 	uint8_t buffer[] = { state };
@@ -1312,6 +1419,9 @@ static int gip_setup_input_device(struct gip_attachment *attachment)
 	rc = gip_guide_led_probe(attachment, &input->dev);
 	if (rc)
 		gip_err(attachment, "Failed to register LEDs: %d\n", rc);
+	rc = gip_battery_create(attachment, &input->dev);
+	if (rc)
+		gip_err(attachment, "Failed to register battery: %d\n", rc);
 
 	return 0;
 
@@ -1494,6 +1604,8 @@ static void gip_free_devices(struct gip_attachment *attachment)
 
 	rcu_assign_pointer(attachment->input, NULL);
 	rcu_assign_pointer(attachment->hdev, NULL);
+	/* The following are freed by devres */
+	attachment->battery = NULL;
 	synchronize_rcu();
 
 	if (input)
@@ -1629,10 +1741,14 @@ static int gip_handle_command_status_device(struct gip_attachment *attachment,
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
@@ -2122,6 +2238,7 @@ static struct gip_attachment *gip_ensure_attachment(struct gip_device *device,
 		device->attachments[attachment_index] = attachment;
 
 		mutex_init(&attachment->lock);
+		spin_lock_init(&attachment->battery_lock);
 		INIT_DELAYED_WORK(&attachment->in_fragment_timeout, gip_fragment_timeout);
 		INIT_DELAYED_WORK(&attachment->metadata_next, gip_retry_metadata);
 
diff --git a/drivers/input/joystick/gip/gip.h b/drivers/input/joystick/gip/gip.h
index fbcf66e18158..13a182145577 100644
--- a/drivers/input/joystick/gip/gip.h
+++ b/drivers/input/joystick/gip/gip.h
@@ -14,6 +14,7 @@
 
 #include <linux/hid.h>
 #include <linux/led-class-multicolor.h>
+#include <linux/power_supply.h>
 #include <linux/rcupdate.h>
 #include <linux/usb/input.h>
 
@@ -241,6 +242,9 @@ struct gip_attachment {
 		struct led_classdev_mc color;
 	} guide_led;
 
+	spinlock_t battery_lock;
+	struct power_supply *battery;
+	struct power_supply_desc battery_desc;
 	struct gip_extended_status status;
 
 	enum gip_elite_button_format xbe_format;
-- 
2.54.0

