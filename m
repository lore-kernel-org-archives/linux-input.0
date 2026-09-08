Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F283164B4
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 03:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788837827; cv=none; b=NFc11qMtHEO3N5Gc1FdIQ63bGXa1lvzjzWCOtfzR3KAZlMFZ782OeI4cYVX48H9HK8mDT7UMVChhf8mJ5MaQ9PHWniFXXYqKxSHDxShMO5m+VARfWg455aTvAHz/73e1+BFTWxMAEKNe+V/E6K6JDn9qVLOmjm0ESreoTuStmE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788837827; c=relaxed/simple;
	bh=sONf86a9cao69KZCV4/4j39xvjqKLyhbZZMrjdt5Ynw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IHUsA48YZiAzHMiB2GuOGsxt5BXBDah5VgQvkFSAbgDRRN/r4jhu457J9Bl/lSZgR9lRzYItHa0OcMGw65saOXlA9+B9E5jHWU03esfDJp0ysx3z+jh/9osSW8SpKTFgB0OKjQ/eUJKrKZm/P6BcheZ2aWkJZMWZU85S0pWqRJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=U8wTf8Qn; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="U8wTf8Qn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1788837817; bh=sONf86a9cao69KZCV4/4j39xvjqKLyhbZZMrjdt5Ynw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U8wTf8Qn3HS5G6YLLZGK7URF53h1GOsXipeIM7ff0IsWC3HrBFKd3tTQJxn8x7NA6
	 7640HhxRSZ6to63lfIW8M8sp1fpYzoNpNAAOM4r5bv1O5rzfabQ+D6GWmyvY/JibtI
	 jXfJiKmZ4UI9W1d9/quCShSg0+9wjjG/QhXvHsa9HEGk4yZuZCRCujT3+02U7LYxBS
	 pVBGOlS/x7fc5Sj7mZJJ1GRKoQFNfJWD+qN6H8gtWtyzsXKtI4NCUTgiRvCH8WXjon
	 K7P0A7IQ8bw+xVmnxzcxfbSDj6WDd0oiX4wUB0PmQAzg/wMvxL4F6eb9hXxikgK3N9
	 w9NdjCEps59BQ==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 583DA132035;
	Mon, 07 Sep 2026 20:23:37 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v6 05/12] Input: xbox_gip - Add battery support
Date: Mon,  7 Sep 2026 20:21:36 -0700
Message-ID: <20260908032145.2118234-6-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260908032145.2118234-1-vi@endrift.com>
References: <20260908032145.2118234-1-vi@endrift.com>
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
index dc174560ee49..568877a4ce4b 100644
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
 
@@ -1206,6 +1213,97 @@ static int gip_guide_led_probe(struct gip_attachment *attachment, struct device
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
@@ -1319,6 +1417,9 @@ static int gip_setup_input_device(struct gip_attachment *attachment)
 	rc = gip_guide_led_probe(attachment, &input->dev);
 	if (rc)
 		gip_err(attachment, "Failed to register LEDs: %d\n", rc);
+	rc = gip_battery_create(attachment, &input->dev);
+	if (rc)
+		gip_err(attachment, "Failed to register battery: %d\n", rc);
 
 	return 0;
 
@@ -1501,6 +1602,8 @@ static void gip_free_devices(struct gip_attachment *attachment)
 
 	rcu_assign_pointer(attachment->input, NULL);
 	rcu_assign_pointer(attachment->hdev, NULL);
+	/* The following are freed by devres */
+	attachment->battery = NULL;
 	synchronize_rcu();
 
 	if (input)
@@ -1633,10 +1736,14 @@ static int gip_handle_command_status_device(struct gip_attachment *attachment,
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
@@ -2129,6 +2236,7 @@ static struct gip_attachment *gip_ensure_attachment(struct gip_device *device,
 		device->attachments[attachment_index] = attachment;
 
 		mutex_init(&attachment->lock);
+		spin_lock_init(&attachment->battery_lock);
 		INIT_DELAYED_WORK(&attachment->in_fragment_timeout, gip_fragment_timeout);
 		INIT_DELAYED_WORK(&attachment->metadata_next, gip_retry_metadata);
 
diff --git a/drivers/input/joystick/gip/gip.h b/drivers/input/joystick/gip/gip.h
index e2571fb43aea..1c6854540f08 100644
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

