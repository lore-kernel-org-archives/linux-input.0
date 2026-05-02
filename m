Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE1F36DA18
	for <linux-input@vger.kernel.org>; Sat,  2 May 2026 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777725689; cv=none; b=faAqU/1oCQXKknSG/jLKt/X2smBL9dnT2fyC4sm4w4uf/Vt6BRUL/P1WAbkJ6/biZsVPwfVPWQ9xFnRGui/r1e9JvSFZU+iK00JS2WjLQCiA7ewo8fESzu8NVcelIZlqYxmnqnFgpVcO0cyXq3JfJfc45zKmmVb/KW6cjWyJKbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777725689; c=relaxed/simple;
	bh=h+nLD17Gg+/kS/+rUXx+SBZ8mWAy9WNiKFCBpWd0IIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+gOpGbqhHy6gwi6ApfdzO+vfhkKQbr4zCgIBItFepD3LS4Wy5vLX7SofJMXY4cAP8h5N1ceZsiP+wU36FYlgimDpKWd/vCg23wqu+nOYVonpfoLNYRzT6ORgK2ryWW7VGpgE2/O6yKP6l5Kwf8AEOHlGQhII45Q8BzLwANFfAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yy3uBtL/; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yy3uBtL/"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b936331786dso315454466b.3
        for <linux-input@vger.kernel.org>; Sat, 02 May 2026 05:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777725685; x=1778330485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60vGHWLIBcb/8ge5YV5kbkl5vbOh3bjKu7Qv+xzYRB4=;
        b=Yy3uBtL/hJDLN27kcMisL3cFVPv13r6e1DyY+feqw4AA4YriZTHlSbI8pS2DAKlIjd
         YvdyWFmtCKMpeCxsua9IaXUmifHPSChKcJBk0kdbIEVxfMLK2XCToI4XelD6I1hJz+DF
         ocqt33G5dpUIle6lZO8NqZAP8YW9T4TRLehmTPjpnR073IJzg3Et69kBEdtpcIRoN6sd
         Cl9TPsngKrR245YR7EA/yJtL+KZq4i2rVWLG9/awvpoxGEZDGTF56jMSFvf+rK6UCwRd
         BbrTOg2pFE8uxzGTIZrj+xYiqeZEsu9WX4tHe4b09kHalyfGDesvx+EoGnWWMUS42Nbq
         z5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777725685; x=1778330485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=60vGHWLIBcb/8ge5YV5kbkl5vbOh3bjKu7Qv+xzYRB4=;
        b=Qhi/Quk/LU1/B/sirkfOazphV0oX180Xpu576/+ZXsWm3xxjTY0U+L119J9ofxEyN6
         /U+lefSc3FC5FVsibcpB/OEr0cnrHxqQdvH0ZbVL2uOuFww0qKe18pX2u79dk/BdkTuD
         Fg8A94LuorBUGzytuNJI1Q3eD6amgxK5tq96zcIug1NT7I1ttfnvgNevpA4Sn12eQVm7
         ylqmCBfKDa7Mip6fuE/d0capzldbwftuS6Elyq2tE3t26SEdK/+0DlU4bLn6E3LxKIL+
         gXP43J1ru+JfG2okiMxfrCifZR01P/O0VRVIWsqxoiAZMzbIVg4VdJVTVGg4ZlO5pL1q
         q/Jg==
X-Forwarded-Encrypted: i=1; AFNElJ/UcHp/z4+yz+JDmfSVQj19iQHHqLMCpDC+mIVe181R9fsxCDb9OjUlRFKjrB0SFF8xJfMI6L+u5IyPfA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7uZ8KxS1lXjmqhWAchgiMERvvjBWFIFoNGElt+dBG3/2FEQ6W
	FR9xWwShmfKVMWNlj8RHGJheCpXvw3mowiJ/PpogbeXgtzQZ+QmMsAJL
X-Gm-Gg: AeBDietd9KWwgOQ0BOoO0V+3KwTb4UTJ5ntYB56NbE3o+0r2Cm4R9lUlURaDcjhNlTc
	LvMF7GNWhMD1ZLFyiFZbQTd1qwV6GP5AITHNb58dikglzmgkcGopyH7WfFUzOSjgUONol7ZtoWa
	xxjNGGK7HV1blYwFI+ICeNUzo5bB2sZ83gjWSKjRqIVLz3r19Jm3hPGeeSLJzUnBbOrcId0OShk
	T+Xktd34GZScRx7xCBPPPKZl9xOJcWB+TN7MprdLPMBJ0AbJPZtw2Vij1aUKQ7OGkIb+QvIHPMc
	7IjntrJDIyW/8ce8nbJe5U2xhPy86KCtge3mMgBp8A8qErme+rk3yLojheDGpttvjMHuxZvNzXB
	3LIKW9JynDB2VPmFAp+0A/JEqM+N4SOKt0aQq0ZHnO90qzB19teNjBMT2VytK+7cf/4OQ7cI961
	PseVzecPHqu+nxIbwHMKLDPeU=
X-Received: by 2002:a17:907:25c5:b0:ba6:4e0f:e3a8 with SMTP id a640c23a62f3a-bbff950b8afmr137113066b.12.1777725684751;
        Sat, 02 May 2026 05:41:24 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b85e281cdsm1649649a12.3.2026.05.02.05.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 05:41:23 -0700 (PDT)
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
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v6 7/7] power: supply: Add charger driver for Asus Transformers
Date: Sat,  2 May 2026 15:40:55 +0300
Message-ID: <20260502124055.22475-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260502124055.22475-1-clamor95@gmail.com>
References: <20260502124055.22475-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Add support for charger detection capabilities found in the embedded
controller of ASUS Transformer devices.

Suggested-by: Maxim Schwalm <maxim.schwalm@gmail.com>
Suggested-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/Kconfig                  |  11 +
 drivers/power/supply/Makefile                 |   1 +
 .../supply/asus-transformer-ec-charger.c      | 193 ++++++++++++++++++
 3 files changed, 205 insertions(+)
 create mode 100644 drivers/power/supply/asus-transformer-ec-charger.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 1dc3d0b2e021..ebc6d5c01330 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -508,6 +508,17 @@ config CHARGER_88PM860X
 	help
 	  Say Y here to enable charger for Marvell 88PM860x chip.
 
+config CHARGER_ASUS_TRANSFORMER_EC
+	tristate "Asus Transformer's charger driver"
+	depends on MFD_ASUS_TRANSFORMER_EC
+	help
+	  Say Y here to enable support AC plug detection on Asus Transformer
+	  Dock.
+
+	  This sub-driver supports charger detection mechanism found in Asus
+	  Transformer tablets and mobile docks and controlled by special
+	  embedded controller.
+
 config CHARGER_PF1550
 	tristate "NXP PF1550 battery charger driver"
 	depends on MFD_PF1550
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 1313f367715c..93d17d28081e 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_CHARGER_RT9471)	+= rt9471.o
 obj-$(CONFIG_CHARGER_RT9756)	+= rt9756.o
 obj-$(CONFIG_BATTERY_TWL4030_MADC)	+= twl4030_madc_battery.o
 obj-$(CONFIG_CHARGER_88PM860X)	+= 88pm860x_charger.o
+obj-$(CONFIG_CHARGER_ASUS_TRANSFORMER_EC)	+= asus-transformer-ec-charger.o
 obj-$(CONFIG_CHARGER_PF1550)	+= pf1550-charger.o
 obj-$(CONFIG_BATTERY_RX51)	+= rx51_battery.o
 obj-$(CONFIG_AB8500_BM)		+= ab8500_bmdata.o ab8500_charger.o ab8500_fg.o ab8500_btemp.o ab8500_chargalg.o
diff --git a/drivers/power/supply/asus-transformer-ec-charger.c b/drivers/power/supply/asus-transformer-ec-charger.c
new file mode 100644
index 000000000000..de01f0bf2fd7
--- /dev/null
+++ b/drivers/power/supply/asus-transformer-ec-charger.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/err.h>
+#include <linux/mfd/asus-transformer-ec.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/property.h>
+
+struct asus_ec_charger_data {
+	struct notifier_block nb;
+	const struct asusec_info *ec;
+	struct power_supply *psy;
+	struct power_supply_desc psy_desc;
+};
+
+static enum power_supply_property asus_ec_charger_properties[] = {
+	POWER_SUPPLY_PROP_USB_TYPE,
+	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+};
+
+static int asus_ec_charger_get_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					union power_supply_propval *val)
+{
+	struct asus_ec_charger_data *priv = power_supply_get_drvdata(psy);
+	enum power_supply_usb_type psu;
+	int ret;
+	u64 ctl;
+
+	ret = asus_ec_get_ctl(priv->ec, &ctl);
+	if (ret)
+		return ret;
+
+	switch (ctl & (ASUSEC_CTL_FULL_POWER_SOURCE | ASUSEC_CTL_DIRECT_POWER_SOURCE)) {
+	case ASUSEC_CTL_FULL_POWER_SOURCE:
+		psu = POWER_SUPPLY_USB_TYPE_CDP;	/* DOCK */
+		break;
+	case ASUSEC_CTL_DIRECT_POWER_SOURCE:
+		psu = POWER_SUPPLY_USB_TYPE_SDP;	/* USB */
+		break;
+	case 0:
+		psu = POWER_SUPPLY_USB_TYPE_UNKNOWN;	/* no power source connected */
+		break;
+	default:
+		psu = POWER_SUPPLY_USB_TYPE_ACA;	/* power adapter */
+		break;
+	}
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = psu != POWER_SUPPLY_USB_TYPE_UNKNOWN;
+		return 0;
+
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		val->intval = psu;
+		return 0;
+
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		if (ctl & ASUSEC_CTL_TEST_DISCHARGE)
+			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE;
+		else if (ctl & ASUSEC_CTL_USB_CHARGE)
+			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
+		else
+			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
+		return 0;
+
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = priv->ec->model;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int asus_ec_charger_set_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					const union power_supply_propval *val)
+{
+	struct asus_ec_charger_data *priv = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		switch ((enum power_supply_charge_behaviour)val->intval) {
+		case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
+			return asus_ec_update_ctl(priv->ec,
+				ASUSEC_CTL_TEST_DISCHARGE | ASUSEC_CTL_USB_CHARGE,
+				ASUSEC_CTL_USB_CHARGE);
+
+		case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
+			return asus_ec_clear_ctl_bits(priv->ec,
+				ASUSEC_CTL_TEST_DISCHARGE | ASUSEC_CTL_USB_CHARGE);
+
+		case POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE:
+			return asus_ec_update_ctl(priv->ec,
+				ASUSEC_CTL_TEST_DISCHARGE | ASUSEC_CTL_USB_CHARGE,
+				ASUSEC_CTL_TEST_DISCHARGE);
+		default:
+			return -EINVAL;
+		}
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int asus_ec_charger_property_is_writeable(struct power_supply *psy,
+						 enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct power_supply_desc asus_ec_charger_desc = {
+	.name = "asus-ec-charger",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.charge_behaviours = BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO) |
+			     BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE) |
+			     BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE),
+	.usb_types = BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN) |
+		     BIT(POWER_SUPPLY_USB_TYPE_SDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_CDP) |
+		     BIT(POWER_SUPPLY_USB_TYPE_ACA),
+	.properties = asus_ec_charger_properties,
+	.num_properties = ARRAY_SIZE(asus_ec_charger_properties),
+	.get_property = asus_ec_charger_get_property,
+	.set_property = asus_ec_charger_set_property,
+	.property_is_writeable = asus_ec_charger_property_is_writeable,
+	.no_thermal = true,
+};
+
+static int asus_ec_charger_notify(struct notifier_block *nb,
+				  unsigned long action, void *data)
+{
+	struct asus_ec_charger_data *priv =
+		container_of(nb, struct asus_ec_charger_data, nb);
+
+	switch (action) {
+	case ASUSEC_SMI_ACTION(POWER_NOTIFY):
+	case ASUSEC_SMI_ACTION(ADAPTER_EVENT):
+		power_supply_changed(priv->psy);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int asus_ec_charger_probe(struct platform_device *pdev)
+{
+	struct asus_ec_charger_data *priv;
+	struct device *dev = &pdev->dev;
+	struct power_supply_config cfg = { };
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+	priv->ec = cell_to_ec(pdev);
+
+	cfg.fwnode = dev_fwnode(dev->parent);
+	cfg.drv_data = priv;
+
+	memcpy(&priv->psy_desc, &asus_ec_charger_desc, sizeof(priv->psy_desc));
+	priv->psy_desc.name = devm_kasprintf(dev, GFP_KERNEL, "%s-charger",
+					     priv->ec->name);
+
+	priv->psy = devm_power_supply_register(dev, &priv->psy_desc, &cfg);
+	if (IS_ERR(priv->psy))
+		return dev_err_probe(dev, PTR_ERR(priv->psy),
+				     "Failed to register power supply\n");
+
+	priv->nb.notifier_call = asus_ec_charger_notify;
+
+	return devm_asus_ec_register_notifier(pdev, &priv->nb);
+}
+
+static struct platform_driver asus_ec_charger_driver = {
+	.driver.name = "asus-transformer-ec-charger",
+	.probe = asus_ec_charger_probe,
+};
+module_platform_driver(asus_ec_charger_driver);
+
+MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
+MODULE_DESCRIPTION("ASUS Transformer Pad battery charger driver");
+MODULE_LICENSE("GPL");
-- 
2.51.0

