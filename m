Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FC636B044
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770633880; cv=none; b=e78z/kqrfB1PfYCPTJdJ/gABkvDvcKGZdhlIpeBWYUwI9yngUuYxb2z4UMNf9F9HBZPP+6N8EOgUtwl9wbfP1bi+FHwe43bVnM7N9NM+gEqvohH95mXwr6Lf+IVF6RsyMuPR1GWqQpreic8mylXlSjJJKRI0WpI90l+tm/HeeIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770633880; c=relaxed/simple;
	bh=FsJ+X3k1e9X8sla61EI4zubOpztm+0MUD/QW/rZ5kcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYqD9XgE3IcwmKXP+D+S5znYScLSgQ/4w8Dv2cJGqKC2/FzetYO+TSuhcofpfFFS54Id//4J+yYZa1X+s06sOEPqhG6Mubcp3MdjoXYil7dP+zlwvRrQ++DW3Fe8HDQ6crEUIH12Tyfx8eikxzO87y9jU+Ti/TDnKGMUL5KrNig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuBaKhpk; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuBaKhpk"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59ddb31ddcaso4823443e87.2
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 02:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770633877; x=1771238677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHqilh4OCO0Ejn0Cq4d6My+FDfTClRdKat9V/LZP6I4=;
        b=IuBaKhpkMhlFE4Ttcl0bvx9JgPcRudDCZ0GMEDR7QfRFDsLmOxx5UxANsLSbXcTTgH
         +NHQ26IgI5wvLmANg7DedOyHqnwUVkiiO1A/CL2Kz/X4J71qpmZk0jLypmW0GYDDfg8x
         R02OZGN1K1bo1+FvyNEQq8EQ7jPPG9kaJtYgFnNurVEHAhEt/PhG53rSjebJkt5gZcee
         L8q1aMb8mIXQiM2zICUllGjOAlivQZBzAik9E91o+dlIbWfyjOUNb1uksLWUWuInTM8c
         /8vWXjU9dRUglLG+S66ojN9jhlciZeD3SiSwZiETNRCAJQr6ohLSl0eszWomqnc5bA+C
         pjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770633877; x=1771238677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cHqilh4OCO0Ejn0Cq4d6My+FDfTClRdKat9V/LZP6I4=;
        b=InlYnWDFNGV50P74KSWZhGKgCa8TTO/5MbzC9/Jxq50VNUgiFkaZz9MXT1Lew+RS45
         fud85VjmnqzBJiiijDyW+q1f4kI+v4M8dgpcsuEgRRjj67JmuYNivLNY8ZeYmyzPKIjl
         SeL1Zjzww0HGCBxt8r8qm34/SzUObzzxU6j4II91VzPwpV9g16r78XpNptKOQJNqNRCY
         RHpN8F1PlsaVDxxhxtd3W9ijFEfRSDQBfyY1rUflOwxOD4P+hJrMCOYzRQlP3fV7KHFi
         ZfRpPMKP3M8lleplLAGdc9imQdOKsb//mpJUDEC2JPzPzWHHoO3P4NPqHot+VT7iNDnO
         V13Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUAYPa66qscIJCwJiUyLlZVp8Nag/Tc05atM3208Kt4okxij/QaJJEuF0387IhwIbyRsZfIE99urGYiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0gwIWIb0AbhSiZtRP6k5kl/zYUGUBMUQbqaL3SE46WYsrkOno
	G91vpj1Of3tWiW79SRlXGAYSktQ+BE7XgEaQW8mUUxrp5H3Efbh2i6Ye
X-Gm-Gg: AZuq6aKF4Mx1aDvAfE6E5h3GS4ZXVQ/cxbVyy4h/weGNtmk2mqJEzCvM8wKi1GkrDjY
	j4nNGqDTuDw44yIoRDYI2lI6nszj0u2qjrm27xs+qwasfTGB7EOmyUQz0stpE3SoKvZ5FrXUhjI
	fcf91N5DrRC5rTukWTQptzs4hsa52YDwaD2MZFHydBQ38jFbpuWayOioG7eSJFBFE0oQi6RkcPZ
	oVnUJnUGgAIFzwXLBsAZ6ioxpTig9Ef00GBaRalh6OD7LbPErxLbFkOI5ooX8NIg7mtoY+ILOdy
	rNvFiwm1owE+xt7duSfCtmYaQWh71ilt2dfa/TJIQjygff6NEcUehNxKXwMmA/SUTPxRDIa5jq1
	1taLK94P74OeQSaplitBEmONfzvcU7moCN7kQAu6h2EUt/IH6+cjfsEyRHPfcL+heMiOa9J+o7L
	UO
X-Received: by 2002:a05:6512:b1d:b0:59e:aba:d1b5 with SMTP id 2adb3069b0e04-59e45152f35mr4051611e87.31.1770633876454;
        Mon, 09 Feb 2026 02:44:36 -0800 (PST)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44cf6f88sm2501469e87.21.2026.02.09.02.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 02:44:36 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Ion Agorria <ion@agorria.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 8/9] power: supply: Add driver for Asus Transformer battery
Date: Mon,  9 Feb 2026 12:44:06 +0200
Message-ID: <20260209104407.116426-9-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209104407.116426-1-clamor95@gmail.com>
References: <20260209104407.116426-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Driver implements one battery cell per EC controller and supports reading
of battery status for Asus Transformer's pad and mobile dock.

Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/Kconfig           |  11 +
 drivers/power/supply/Makefile          |   1 +
 drivers/power/supply/asus-ec-battery.c | 283 +++++++++++++++++++++++++
 3 files changed, 295 insertions(+)
 create mode 100644 drivers/power/supply/asus-ec-battery.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 81fadb0695a9..bcf6a23858be 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -122,6 +122,17 @@ config BATTERY_CHAGALL
 	  This driver can also be built as a module. If so, the module will be
 	  called chagall-battery.
 
+config BATTERY_ASUSEC
+	tristate "Asus Transformer's battery driver"
+	depends on MFD_ASUSEC
+	help
+	  Say Y here to enable support APM status emulation using
+	  battery class devices.
+
+	  This sub-driver supports battery cells found in Asus Transformer
+	  tablets and mobile docks and controlled by special embedded
+	  controller.
+
 config BATTERY_CPCAP
 	tristate "Motorola CPCAP PMIC battery driver"
 	depends on MFD_CPCAP && IIO
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 41c400bbf022..0a2cbfa96ed9 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_TEST_POWER)	+= test_power.o
 obj-$(CONFIG_BATTERY_88PM860X)	+= 88pm860x_battery.o
 obj-$(CONFIG_CHARGER_ADP5061)	+= adp5061.o
 obj-$(CONFIG_BATTERY_ACT8945A)	+= act8945a_charger.o
+obj-$(CONFIG_BATTERY_ASUSEC)	+= asus-ec-battery.o
 obj-$(CONFIG_BATTERY_AXP20X)	+= axp20x_battery.o
 obj-$(CONFIG_CHARGER_AXP20X)	+= axp20x_ac_power.o
 obj-$(CONFIG_BATTERY_CHAGALL)	+= chagall-battery.o
diff --git a/drivers/power/supply/asus-ec-battery.c b/drivers/power/supply/asus-ec-battery.c
new file mode 100644
index 000000000000..36ebc5093730
--- /dev/null
+++ b/drivers/power/supply/asus-ec-battery.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ASUS EC driver - battery monitoring
+ */
+
+#include <linux/array_size.h>
+#include <linux/devm-helpers.h>
+#include <linux/err.h>
+#include <linux/mfd/asus-ec.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/property.h>
+#include <linux/unaligned.h>
+
+#define ASUSEC_BATTERY_DATA_FRESH_MSEC		5000
+
+#define ASUSEC_BATTERY_DISCHARGING		0x40
+#define ASUSEC_BATTERY_FULL_CHARGED		0x20
+#define ASUSEC_BATTERY_NOT_CHARGING		0x10
+
+#define TEMP_CELSIUS_OFFSET			2731
+
+struct asus_ec_battery_data {
+	const struct asusec_info *ec;
+	struct power_supply *battery;
+	struct power_supply_desc psy_desc;
+	struct delayed_work poll_work;
+	struct mutex battery_lock; /* for data refresh */
+	unsigned long batt_data_ts;
+	int last_state;
+	u8 batt_data[DOCKRAM_ENTRY_BUFSIZE];
+};
+
+static int asus_ec_battery_refresh(struct asus_ec_battery_data *priv)
+{
+	int ret = 0;
+
+	guard(mutex)(&priv->battery_lock);
+
+	if (time_before(jiffies, priv->batt_data_ts))
+		return ret;
+
+	ret = asus_dockram_read(priv->ec->dockram, ASUSEC_DOCKRAM_BATT_CTL,
+				priv->batt_data);
+	if (ret < 0)
+		return ret;
+
+	priv->batt_data_ts = jiffies +
+		msecs_to_jiffies(ASUSEC_BATTERY_DATA_FRESH_MSEC);
+
+	return ret;
+}
+
+static enum power_supply_property asus_ec_battery_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
+	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
+	POWER_SUPPLY_PROP_PRESENT,
+};
+
+static const unsigned int asus_ec_battery_prop_offs[] = {
+	[POWER_SUPPLY_PROP_STATUS] = 1,
+	[POWER_SUPPLY_PROP_VOLTAGE_MAX] = 3,
+	[POWER_SUPPLY_PROP_CURRENT_MAX] = 5,
+	[POWER_SUPPLY_PROP_TEMP] = 7,
+	[POWER_SUPPLY_PROP_VOLTAGE_NOW] = 9,
+	[POWER_SUPPLY_PROP_CURRENT_NOW] = 11,
+	[POWER_SUPPLY_PROP_CAPACITY] = 13,
+	[POWER_SUPPLY_PROP_CHARGE_NOW] = 15,
+	[POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW] = 17,
+	[POWER_SUPPLY_PROP_TIME_TO_FULL_NOW] = 19,
+};
+
+static int asus_ec_battery_get_value(struct asus_ec_battery_data *priv,
+				     enum power_supply_property psp)
+{
+	int ret, offs;
+
+	if (psp >= ARRAY_SIZE(asus_ec_battery_prop_offs))
+		return -EINVAL;
+
+	offs = asus_ec_battery_prop_offs[psp];
+	if (!offs)
+		return -EINVAL;
+
+	ret = asus_ec_battery_refresh(priv);
+	if (ret < 0)
+		return ret;
+
+	if (offs >= priv->batt_data[0])
+		return -ENODATA;
+
+	return get_unaligned_le16(priv->batt_data + offs);
+}
+
+static int asus_ec_battery_get_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					union power_supply_propval *val)
+{
+	struct asus_ec_battery_data *priv = power_supply_get_drvdata(psy);
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = 1;
+		break;
+
+	default:
+		ret = asus_ec_battery_get_value(priv, psp);
+		if (ret < 0)
+			return ret;
+
+		val->intval = (s16)ret;
+
+		switch (psp) {
+		case POWER_SUPPLY_PROP_STATUS:
+			if (ret & ASUSEC_BATTERY_FULL_CHARGED)
+				val->intval = POWER_SUPPLY_STATUS_FULL;
+			else if (ret & ASUSEC_BATTERY_NOT_CHARGING)
+				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			else if (ret & ASUSEC_BATTERY_DISCHARGING)
+				val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+			else
+				val->intval = POWER_SUPPLY_STATUS_CHARGING;
+			break;
+
+		case POWER_SUPPLY_PROP_TEMP:
+			val->intval -= TEMP_CELSIUS_OFFSET;
+			break;
+
+		case POWER_SUPPLY_PROP_CHARGE_NOW:
+		case POWER_SUPPLY_PROP_CURRENT_NOW:
+		case POWER_SUPPLY_PROP_CURRENT_MAX:
+		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+			val->intval *= 1000;
+			break;
+
+		case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
+		case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
+			val->intval *= 60;
+			break;
+
+		default:
+			break;
+		}
+
+		break;
+	}
+
+	return 0;
+}
+
+static void asus_ec_battery_poll_work(struct work_struct *work)
+{
+	struct asus_ec_battery_data *priv =
+		container_of(work, struct asus_ec_battery_data, poll_work.work);
+	int state;
+
+	state = asus_ec_battery_get_value(priv, POWER_SUPPLY_PROP_STATUS);
+	if (state < 0)
+		return;
+
+	if (state & ASUSEC_BATTERY_FULL_CHARGED)
+		state = POWER_SUPPLY_STATUS_FULL;
+	else if (state & ASUSEC_BATTERY_DISCHARGING)
+		state = POWER_SUPPLY_STATUS_DISCHARGING;
+	else
+		state = POWER_SUPPLY_STATUS_CHARGING;
+
+	if (priv->last_state != state) {
+		priv->last_state = state;
+		power_supply_changed(priv->battery);
+	}
+
+	/* continuously send uevent notification */
+	schedule_delayed_work(&priv->poll_work,
+			      msecs_to_jiffies(ASUSEC_BATTERY_DATA_FRESH_MSEC));
+}
+
+static const struct power_supply_desc asus_ec_battery_desc = {
+	.name = "asus-ec-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = asus_ec_battery_properties,
+	.num_properties = ARRAY_SIZE(asus_ec_battery_properties),
+	.get_property = asus_ec_battery_get_property,
+	.external_power_changed = power_supply_changed,
+};
+
+static int asus_ec_battery_probe(struct platform_device *pdev)
+{
+	struct asus_ec_battery_data *priv;
+	struct device *dev = &pdev->dev;
+	struct power_supply_config cfg = { };
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	mutex_init(&priv->battery_lock);
+
+	priv->ec = cell_to_ec(pdev);
+	priv->batt_data_ts = jiffies - 1;
+	priv->last_state = POWER_SUPPLY_STATUS_UNKNOWN;
+
+	cfg.fwnode = dev_fwnode(dev);
+	cfg.drv_data = priv;
+
+	memcpy(&priv->psy_desc, &asus_ec_battery_desc, sizeof(priv->psy_desc));
+	priv->psy_desc.name = devm_kasprintf(dev, GFP_KERNEL, "%s-battery",
+					     priv->ec->name);
+
+	priv->battery = devm_power_supply_register(dev, &priv->psy_desc, &cfg);
+	if (IS_ERR(priv->battery))
+		return dev_err_probe(dev, PTR_ERR(priv->battery),
+				     "Failed to register power supply\n");
+
+	ret = devm_delayed_work_autocancel(dev, &priv->poll_work,
+					   asus_ec_battery_poll_work);
+	if (ret)
+		return ret;
+
+	schedule_delayed_work(&priv->poll_work,
+			      msecs_to_jiffies(ASUSEC_BATTERY_DATA_FRESH_MSEC));
+
+	return 0;
+}
+
+static int __maybe_unused asus_ec_battery_suspend(struct device *dev)
+{
+	struct asus_ec_battery_data *priv = dev_get_drvdata(dev);
+
+	cancel_delayed_work_sync(&priv->poll_work);
+
+	return 0;
+}
+
+static int __maybe_unused asus_ec_battery_resume(struct device *dev)
+{
+	struct asus_ec_battery_data *priv = dev_get_drvdata(dev);
+
+	schedule_delayed_work(&priv->poll_work,
+			      msecs_to_jiffies(ASUSEC_BATTERY_DATA_FRESH_MSEC));
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(asus_ec_battery_pm_ops,
+			 asus_ec_battery_suspend, asus_ec_battery_resume);
+
+static const struct of_device_id asus_ec_battery_match[] = {
+	{ .compatible = "asus,ec-battery" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, asus_ec_battery_match);
+
+static struct platform_driver asus_ec_battery_driver = {
+	.driver = {
+		.name = "asus-ec-battery",
+		.of_match_table = asus_ec_battery_match,
+		.pm = &asus_ec_battery_pm_ops,
+	},
+	.probe = asus_ec_battery_probe,
+};
+module_platform_driver(asus_ec_battery_driver);
+
+MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
+MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
+MODULE_DESCRIPTION("ASUS Transformer's battery driver");
+MODULE_LICENSE("GPL");
-- 
2.51.0

