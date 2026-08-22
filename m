Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E052D6E5A
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 02:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787364807; cv=none; b=OQwjHCovqlSZ6x6gqd80jtTzoRnlZHczktMi1ZPuaY3g5EhO+Xek/CHBsmrno6bO3qzyN9OTfWKWzazFQHnQS+6iM2EUhcd9Mk79As5wgGTfHmdpVgNWxjHH9duqHwYRfEXsrv35mHj5+y59m+IHHJcM1lF0LxncC6Dbukh4O38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787364807; c=relaxed/simple;
	bh=KluTec1WKEsFaFvTfLl10IS402EZeZel7k6Zwr1iG5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTl1jzYp73laRpN9A5Tr820YTIZL9mA1NhIXtf3oHREd2LA8OXFGuBbpdQlprAb8H2/qH1K3NkkaJPto3Fvn/0572Q/mi4J6TQ4xTx1v3hFZHq3LV7aUc6guSLDdhTkeIhGSTHTz+PkHhnw1fKxoOEYGDF9dlvx2sTQhjHFd7tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=lJMp+xWo; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="lJMp+xWo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1787364799; bh=KluTec1WKEsFaFvTfLl10IS402EZeZel7k6Zwr1iG5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lJMp+xWoc9bQgdBO+FgwgehZ1DqpPJgH8Kef5zw/UIRbfSUUNPGBDRIYTOdahZivj
	 VRPC5bFgBWv9IIj10muhSlT25qnIW/A7XEnW9uzyc20DVNiS5uO0yrtWtbwdMfUxbD
	 W6yhqUC10jVQWFJDsICA1ctT7gHbsP43XC1O//upBKYChfQ9RCvk+zHFW9Ua7SNDsM
	 cYKwQ1x8radxeKBcP9j4fDKdDUfbYGgktNAcc6bZy5oRDlL+jKIxN+2NL5Qaa2VzPY
	 AoAlxXQENvjYOXK3w6+x2AlaM+jj0V3RHdwOTdCcH8WmZPxyIj/JryPWJaKFey3SfS
	 vsd8wD09YQkag==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id A0E77132034;
	Fri, 21 Aug 2026 19:13:19 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v4 05/12] Input: xbox_gip - Add battery support
Date: Fri, 21 Aug 2026 19:11:29 -0700
Message-ID: <20260822021140.1149546-6-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260822021140.1149546-1-vi@endrift.com>
References: <20260822021140.1149546-1-vi@endrift.com>
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
index c833b10259ab..d694ac551639 100644
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
 
@@ -1196,6 +1203,92 @@ static int gip_guide_led_probe(struct gip_attachment *attachment, struct device
 	return rc;
 }
 
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
@@ -1308,6 +1401,9 @@ static int gip_setup_input_device(struct gip_attachment *attachment)
 	rc = gip_guide_led_probe(attachment, &input->dev);
 	if (rc)
 		gip_err(attachment, "Failed to register LEDs: %d\n", rc);
+	rc = gip_battery_create(attachment, &input->dev);
+	if (rc)
+		gip_err(attachment, "Failed to register battery: %d\n", rc);
 
 	return 0;
 
@@ -2623,6 +2719,7 @@ static int gip_shutdown(struct gip_device *device)
 			hdev = rcu_dereference(attachment->hdev);
 			rcu_read_unlock();
 
+			attachment->battery = NULL;
 			rcu_assign_pointer(attachment->input, NULL);
 			rcu_assign_pointer(attachment->hdev, NULL);
 			synchronize_rcu();
diff --git a/drivers/input/joystick/gip/gip.h b/drivers/input/joystick/gip/gip.h
index fbcf66e18158..e7953c683c51 100644
--- a/drivers/input/joystick/gip/gip.h
+++ b/drivers/input/joystick/gip/gip.h
@@ -14,6 +14,7 @@
 
 #include <linux/hid.h>
 #include <linux/led-class-multicolor.h>
+#include <linux/power_supply.h>
 #include <linux/rcupdate.h>
 #include <linux/usb/input.h>
 
@@ -241,6 +242,8 @@ struct gip_attachment {
 		struct led_classdev_mc color;
 	} guide_led;
 
+	struct power_supply *battery;
+	struct power_supply_desc battery_desc;
 	struct gip_extended_status status;
 
 	enum gip_elite_button_format xbe_format;
-- 
2.54.0

