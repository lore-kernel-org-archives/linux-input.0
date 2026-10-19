Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F264D0CF0
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792404280; cv=none; b=K9rRhTD2MP9lw6Adt7/nuQ8oEUpJGIZqA4wQ8TLJnJD9S6sVw8U677xkHBjpCWxkxR0dPwHS/WPnrHWWX0PxIcRsZolaSZI3jJuForyD0jupCD1SG+QrA27wsFuIA5uRFgGiDUzuztYhf2iHRRWnld21XDw8UPhvNxnHw3bGpCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792404280; c=relaxed/simple;
	bh=Re6jchBlgahLds5K7l2AicFbqwPcBuTnwAD5QxoS8QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JcsJQn7zCKq4QyEtGwKPq+2p2c4Rc8goVO33WHwaxK4OXgTkq711T2DvpvB1wIVluaSQmYOFSHo5X6BVvx5wCDTvGFuQWspjxk7Rf6ehnWSU8zW4QMtmmGkb6bHn9q0Ir78aoDb0Ct+ELRKq4LVOLoWL7DWSTC3V3SNf6X3xpdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GF6fW0wm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GF6fW0wm"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so19021185e9.2
        for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 03:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792404275; x=1793009075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WFDlyoZB7f18B/lPyVmWgAS81CxVxhcEOqRbakazlQ4=;
        b=GF6fW0wmCKZrv8n+z08WTH1ftJ2kXo7yaM4EsvhZ8yszkHGADabotqIf/sIvgcZF0l
         cBC3TiEddYmeu2lQP9lPdtOQwNq7pSn7X/N/VlMQlEZYaL8Q2TSe3iQb/AQZSavXXIV9
         E9+E+vqsSLUFpMuVtNPQJah20Qf8DxvWCG3ymfPNAKegtKJsJAps0n19/8gk/e5s9sGg
         1fcPiNWFgUH0n+ckLkTIxPB0UQKeq0rGQ4neuq0RiQbrhJnjxhRcALlRGbXhaxMOxaxq
         /6tDGhB7LYGUUQK+N136kj3zxlrVmABkei2rOSLmVqCm4RWIin/bDnf0oMbTFyFsZK2G
         ++XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792404275; x=1793009075;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WFDlyoZB7f18B/lPyVmWgAS81CxVxhcEOqRbakazlQ4=;
        b=jvzinbmB7Q6WCnNNL2wiUVZzDkLc9ar6i3jTPapsIs+/8kcPiNVKC9t6vw18Js5/Ts
         YsK1wGF/PpmG+FUmnJ8qAhSecLSpSjqgCA0OtzsKzmkkEUFZ5QcHoaGdT73B3R979Bh+
         tE1OEc/lSUgYqy19InmUF/fmvDKqvr5Xci5jTqClA4r2oEP4oqfEWJR4EDp/YfF69vO+
         /ptGJoFQBwAVzC1LwL5R/RPpzfynAUyPuMdAhefMJT7L9KVxxZSfFbS4zeteln8wT1aQ
         YUzKI6wKMNWq3mTTlc6EQSr2v8x/vwk9DQMys5uNryDQyicffZK31DO7XI9h28p2YYEJ
         G8Pw==
X-Forwarded-Encrypted: i=1; AKwUvBzOWML/FC+AooYkS2galZAMRZVCcXLGvXIS+UCkyXWy4+n3EO3Z/YGXIHJZLrmD5cRHFn24YSzrLkJR9Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYKU0rOAVH7zPd5d98EoYeC7ED4CdfeU3DMTFbAZCpza8jLTmLE6
	iezcnx/9GIWJzUcf8M3BTIzNXkPkm+iuZgbJiKmXzsdqtWcOKyvfhNgw
X-Gm-Gg: AYBFou0NryRbY9WO4rxy9m14m09+oVP245qerRlcyGu6HF2kwVfIRdIRQb4L4EdUl2y
	Glx9MA4hwx/SnQSBpfo283TR6n6mDgFN93iBvrmtbg5z+RAJALgZ67FBKqr187+scVqW9nLLrgV
	SJWue8VcfN0ImXNb0olVJoE7eCEZ8/z3HEmlxsz4edvQXxPEgL3aHoGADPGCpCFUPgl1voUcuYE
	KvCA6EH/KM2JuZ3tgwRQ8Lc2aQVDpL2uTK7u+Y3BKx2PcCRXjvPyJUD9L7r62KbKNWRjfg5kC6n
	Zs48+r3fX1hRGiuOYWlWUpj3JNTyIe2eJuSZCx8zexVQKKiJbARgZkjcOQW97uewmdfdZ8WLJhP
	rRljs50yo0+Y64nId0TgYGXvoJ8oiN3PNo3wto076YmKiiOd9y6eFXLdET8VqBL0G6uhZ5uN5m1
	Gb3YAAxNkOnhED8Lskp8h53LlCQKR01zl7GJv/jTaNA1fpRyLh+jlmMrKGLtw/dNrQ6k1NzUsqU
	wMhhf/BzgTWcSG9cVc=
X-Received: by 2002:a05:600c:3b91:b0:4a1:dfd4:9430 with SMTP id 5b1f17b1804b1-4a1dfd4955fmr125425345e9.28.1792404275067;
        Mon, 19 Oct 2026 03:04:35 -0700 (PDT)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1df164777sm177811485e9.5.2026.10.19.03.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 03:04:33 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Florian Krischer <florian.krischer@fkr.dev>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v12 6/7] power: supply: Add driver for ASUS Transformer battery
Date: Mon, 19 Oct 2026 13:04:05 +0300
Message-ID: <20261019100406.103687-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019100406.103687-1-clamor95@gmail.com>
References: <20261019100406.103687-1-clamor95@gmail.com>
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
of battery status for ASUS Transformer's pad and mobile dock.

Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/Kconfig                  |  11 +
 drivers/power/supply/Makefile                 |   1 +
 .../supply/asus-transformer-ec-battery.c      | 289 ++++++++++++++++++
 3 files changed, 301 insertions(+)
 create mode 100644 drivers/power/supply/asus-transformer-ec-battery.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index ee7dc5f2617a4..856eb81c97ae9 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -122,6 +122,17 @@ config BATTERY_CHAGALL
 	  This driver can also be built as a module. If so, the module will be
 	  called chagall-battery.
 
+config BATTERY_ASUS_TRANSFORMER_EC
+	tristate "Asus Transformer's battery driver"
+	depends on MFD_ASUS_TRANSFORMER_EC
+	help
+	  Say Y to enable support for battery status access on Tegra based
+	  ASUS Transformer devices.
+
+	  This sub-driver supports battery cells found in Asus Transformer
+	  tablets and mobile docks and controlled by a special embedded
+	  controller.
+
 config BATTERY_CPCAP
 	tristate "Motorola CPCAP PMIC battery driver"
 	depends on MFD_CPCAP && IIO
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index f3c0d1006c1a2..bec4a6263048c 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_TEST_POWER)	+= test_power.o
 obj-$(CONFIG_BATTERY_88PM860X)	+= 88pm860x_battery.o
 obj-$(CONFIG_CHARGER_ADP5061)	+= adp5061.o
 obj-$(CONFIG_BATTERY_ACT8945A)	+= act8945a_charger.o
+obj-$(CONFIG_BATTERY_ASUS_TRANSFORMER_EC)	+= asus-transformer-ec-battery.o
 obj-$(CONFIG_BATTERY_AXP20X)	+= axp20x_battery.o
 obj-$(CONFIG_CHARGER_AXP20X)	+= axp20x_ac_power.o
 obj-$(CONFIG_BATTERY_CHAGALL)	+= chagall-battery.o
diff --git a/drivers/power/supply/asus-transformer-ec-battery.c b/drivers/power/supply/asus-transformer-ec-battery.c
new file mode 100644
index 0000000000000..46bd50001e47d
--- /dev/null
+++ b/drivers/power/supply/asus-transformer-ec-battery.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/array_size.h>
+#include <linux/devm-helpers.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/mfd/asus-transformer-ec.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/property.h>
+#include <linux/unaligned.h>
+
+#define ASUSEC_BATTERY_DATA_FRESH_MSEC		5000
+
+#define ASUSEC_BATTERY_DISCHARGING		BIT(6)
+#define ASUSEC_BATTERY_FULL_CHARGED		BIT(5)
+#define ASUSEC_BATTERY_NOT_CHARGING		BIT(4)
+
+#define TEMP_CELSIUS_OFFSET			2731
+
+struct asus_ec_battery_data {
+	struct asusec_core *ec;
+	struct power_supply *battery;
+	struct power_supply_desc psy_desc;
+	struct delayed_work poll_work;
+	struct mutex battery_lock; /* for data refresh */
+	unsigned long batt_data_ts;
+	int last_state;
+	u8 batt_data[ASUSEC_ENTRY_BUFSIZE];
+};
+
+static int asus_ec_battery_refresh(struct asus_ec_battery_data *priv)
+{
+	struct i2c_client *client = priv->ec->dockram;
+	struct device *dev = &client->dev;
+	int ret = 0;
+
+	if (time_before(jiffies, priv->batt_data_ts))
+		return ret;
+
+	memset(priv->batt_data, 0, ASUSEC_ENTRY_BUFSIZE);
+	ret = i2c_smbus_read_i2c_block_data(client, ASUSEC_DOCKRAM_BATT_CTL,
+					    ASUSEC_ENTRY_SIZE, priv->batt_data);
+	if (ret < ASUSEC_ENTRY_SIZE)
+		return ret < 0 ? ret : -EIO;
+
+	if (priv->batt_data[0] > ASUSEC_ENTRY_SIZE) {
+		dev_err(dev, "bad data len; buffer: %*ph; ret: %d\n",
+			ASUSEC_ENTRY_BUFSIZE, priv->batt_data, ret);
+		return -EPROTO;
+	}
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
+	guard(mutex)(&priv->battery_lock);
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
+			val->intval = ret * 60;
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
+		goto reschedule;
+
+	if (state & ASUSEC_BATTERY_FULL_CHARGED)
+		state = POWER_SUPPLY_STATUS_FULL;
+	else if (state & ASUSEC_BATTERY_NOT_CHARGING)
+		state = POWER_SUPPLY_STATUS_NOT_CHARGING;
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
+reschedule:
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
+	struct asusec_core *ec = dev_get_drvdata(pdev->dev.parent);
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
+	priv->ec = ec;
+	priv->batt_data_ts = jiffies - 1;
+	priv->last_state = POWER_SUPPLY_STATUS_UNKNOWN;
+
+	cfg.fwnode = dev_fwnode(dev->parent);
+	cfg.drv_data = priv;
+
+	memcpy(&priv->psy_desc, &asus_ec_battery_desc, sizeof(priv->psy_desc));
+	priv->psy_desc.name = devm_kasprintf(dev, GFP_KERNEL, "%s-battery",
+					     priv->ec->name);
+	if (!priv->psy_desc.name)
+		return -ENOMEM;
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
+static struct platform_driver asus_ec_battery_driver = {
+	.driver = {
+		.name = "asus-transformer-ec-battery",
+		.pm = &asus_ec_battery_pm_ops,
+	},
+	.probe = asus_ec_battery_probe,
+};
+module_platform_driver(asus_ec_battery_driver);
+
+MODULE_ALIAS("platform:asus-transformer-ec-battery");
+MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
+MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
+MODULE_DESCRIPTION("ASUS Transformer's battery driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0

