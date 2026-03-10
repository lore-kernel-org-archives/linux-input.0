Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E472D3739
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 05:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773120035; cv=none; b=Q64kidYILFaTVg+Cfdiqd19Dnj+b4TDVJTqI94Ko+jPHndWq/OSfTRx23emk52e7tYs0FdFd/6rLmoQqvIs+WN+IAperGd1SJTTGRh7rFcjTUqWUxypxXH6zyZFt5aJi3UjHs9VHDTA1+wO0rQtgQ/sFCA7pJOAJO3SiLGv2Idc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773120035; c=relaxed/simple;
	bh=G1LiosFojr+2ZEtL2QqCqxGwM13y1FOldNSstW5+MJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9NQI0nbijExHpClQSFGCvoJVV0MW5EoLjwcTwV0EBmVhbgzepci/OiO4gv0658v8hto1An4H15ALw9w2PpFJoAeapH8ZCSQ0IXSvqZau4Y+Dq3DLk33hm2HrkquyJRtxWTzNTinph6SmDlZg5xyo5DjNw6b2sBrkgSryT/VzoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=Ikjxe0oM; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="Ikjxe0oM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1773120033; bh=G1LiosFojr+2ZEtL2QqCqxGwM13y1FOldNSstW5+MJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ikjxe0oMm92zHdkL7NJ+c2UJ71L8Pvpq+RwR2UKJ5eGDqmrWUz4pMx5CfNt1jXD7Q
	 ra6/k/kRLu5VYoh0b3WCp/Uf768JyQycyTMpFdeEUgMhYk+YVjn6nlm87v4TjvP5zz
	 RtPD1YLNOI4coBPhtvNi5uvh3gb9d5B1QcRDvy4FgItlYFuDvi7ezGhPX58iwsxL2L
	 I6UE/K+Kc2LZ3kzlE0lKvc5R/Xi1PSUiw63YP9dtKns/HDHdSjTQHB0Z5Kq2x1zf2w
	 KKCmy1HUWLH/lP2o13QhSuOHMnACPygS8Ot1zMpLoRj6++JVvIrdDCXrPmfwts7w8+
	 1+ufoN3iok27g==
Received: from microtis.vulpes.eutheria.net (71-212-14-89.tukw.qwest.net [71.212.14.89])
	by endrift.com (Postfix) with ESMTPSA id 9AFE9A0C0;
	Mon, 09 Mar 2026 22:20:33 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v3 05/10] Input: xbox_gip - Add battery support
Date: Mon,  9 Mar 2026 22:19:59 -0700
Message-ID: <20260310052017.1289494-6-vi@endrift.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310052017.1289494-1-vi@endrift.com>
References: <20260310052017.1289494-1-vi@endrift.com>
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
 drivers/input/joystick/gip/gip-core.c | 97 +++++++++++++++++++++++++++
 drivers/input/joystick/gip/gip.h      |  3 +
 2 files changed, 100 insertions(+)

diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joystick/gip/gip-core.c
index 7355737b29d19..89f8e0ed47344 100644
--- a/drivers/input/joystick/gip/gip-core.c
+++ b/drivers/input/joystick/gip/gip-core.c
@@ -262,6 +262,13 @@ static const struct gip_audio_format gip_audio_format_table[MAX_GIP_AUDIO_FORMAT
 };
 
 
+static enum power_supply_property gip_battery_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
+	POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_STATUS,
+};
+
 static const struct gip_quirks base_quirks[] = {
 	/* PDP Rock Candy */
 	{ 0x0e6f, 0x0246, 0, .quirks = GIP_QUIRK_NO_HELLO },
@@ -1205,6 +1212,92 @@ static int gip_guide_led_probe(struct gip_attachment *attachment, struct device
 }
 #endif
 
+static int gip_battery_get_property(struct power_supply *psy,
+	enum power_supply_property psp, union power_supply_propval *val)
+{
+	struct gip_attachment *attachment = power_supply_get_drvdata(psy);
+
+	guard(mutex)(&attachment->lock);
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
+	if (IS_ERR(attachment->battery))
+		return PTR_ERR(attachment->battery);
+
+	return power_supply_powers(attachment->battery, dev);
+}
+
 static bool gip_send_set_device_state(struct gip_attachment *attachment, uint8_t state)
 {
 	uint8_t buffer[] = { state };
@@ -1316,6 +1409,9 @@ static int gip_setup_input_device(struct gip_attachment *attachment)
 	if (rc)
 		dev_err(GIP_DEV(attachment), "Failed to register LEDs: %d\n", rc);
 #endif
+	rc = gip_battery_create(attachment, &input->dev);
+	if (rc)
+		dev_err(GIP_DEV(attachment), "Failed to register battery: %d\n", rc);
 
 	return 0;
 
@@ -2598,6 +2694,7 @@ static int gip_shutdown(struct gip_device *device)
 			hdev = rcu_dereference(attachment->hdev);
 			rcu_read_unlock();
 
+			attachment->battery = NULL;
 			rcu_assign_pointer(attachment->input, NULL);
 			rcu_assign_pointer(attachment->hdev, NULL);
 			synchronize_rcu();
diff --git a/drivers/input/joystick/gip/gip.h b/drivers/input/joystick/gip/gip.h
index c9d1c4f16c760..dd77f16b00fd8 100644
--- a/drivers/input/joystick/gip/gip.h
+++ b/drivers/input/joystick/gip/gip.h
@@ -17,6 +17,7 @@
 #include <linux/led-class-multicolor.h>
 #endif
 #include <linux/rcupdate.h>
+#include <linux/power_supply.h>
 #include <linux/usb/input.h>
 
 #define BASE_GIP_MTU 64
@@ -212,6 +213,8 @@ struct gip_attachment {
 	} guide_led;
 #endif
 
+	struct power_supply *battery;
+	struct power_supply_desc battery_desc;
 	struct gip_extended_status status;
 
 	enum gip_elite_button_format xbe_format;
-- 
2.53.0

