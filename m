Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794506137;
	b=qr53m1oH4KHiiq5K2gcxcesMIZNq5W1scs0SW+8ICovJn4gWSpRHpaz2/qdQmIN4Zp/9
	 rzm0mZB42MT+7DpQjOZHK6EHDXUgrxe6jXQ/mgYVx+tIEkwnt3rxtzJJWO2TCo6wjXvdT
	 fBW+nAdaSq3bb8dXbyyk5Ay+dXfHnbKrc5lNxp8zXFm2qHuN1EDDbfb8bUOUC3RY/7wrc
	 M1Aw64AnLNcSDysInrPR1+5y1aXDzt/nQ2VIZjajYV3OSaSZx/EAqdmy+KF6vFYsBhc26
	 xLfV+90Z+wzxiKUH78ga3StqrVEsW/f3wbpQUAiOD1n74YkcVRbXF1kOXTc8fV8gNXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506137;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=WkABH6HlfUjrN5zv6urgpS5lPLEyczfYd6EYxKA00oQ=;
	b=fKwqvdAjdpgM8kE3paB1wmAN2IKGIgUQCcOlh4SlxCgi2M/ZRjgo9gig7r+6csngCipE
	 MtSTZqJihgp3M3nE7i56/mRb05+p+JRQqmytoHKezWzJjY48UMOYnzA1P7R1R9Oxnf2Sm
	 f5vS3Yq7da8pXJOPg2RFRoDO2Q53gSEQ/5fqDH76k1wNSBPf6SYnlL+oeVvxgLnx/+C6q
	 g3hhbZTQR33MH4f54ZtsE/BQOWHZhuC7xa70ZzVASlbrm7XRCMyyluCQ9MqzTfmGa9zRU
	 N1o6HN81lpAE0jCOXyJ83Y5wpBv8xSSCHM/YtUdK0Wd1b8WV32Bjx5TFg4mUWBYxAvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=FuWy75Jz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D75E606A330;
	Thu, 12 Nov 2026 17:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D75E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=FuWy75Jz
ARC-Seal: i=1; a=rsa-sha256; t=1794506073; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hxFxRA04v9ZIE1x+OXHVTdWKpS+NmGhTXMGIOlBDI+f4S1RBiAgnDy7iHvVVEY0wBhM2ss5j/4nozrGEDH9sxfIRZZKs16CFeb009Bk4S/4g6LeqDXD8LKyOEzDcxMpq/VZSY4ctGhAxtXm+w2X7Q279NLHn5FuOYVP+iTd5tgI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794506073; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WkABH6HlfUjrN5zv6urgpS5lPLEyczfYd6EYxKA00oQ=; 
	b=hhVhJbHB98pANXlbV7smmG7fll1Jsk9jtFKho19uQlBNvALyFYUiu3m5M9ViEzA8tfUympvoG57h2PHk2m0R3H85EJxFPLAW/G9M6aJGp+1iDrEGI+Jgs7CTe930RcApLD7AfQRS6FlpGxlkPZrP7zV2YQDoAcm0E2ip2FB8ZVw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=FuWy75JzLOkzjY8+9aw/k3d1tbPmDjnXzNqTZbUMXUmKCGVFux9om0eVItHmh1OCO/92tK9BxQnxSTf1KJYdMY2rrBxN28E1Hr0GDw3fVdpVB1g6YrqxNUJTI12URk1QgAl26iZnh+jV2AGO51UptJRN3YzVlBg0O09W7MAh9E6WK0V6/7iaefjLCj0Gtzpa5RCtWK/1+eib+xd/74vEHbE8SgqCu/AeEcCdcERyGxNokuNta96kNsnsutF/jLJlknSskPXBaJdGk6bP75xSp2Yu0RXuXNb/ZxpYkXAQXhnMXB4rpYFBoxMlvYhxa6B1+NPF5GPhoedkuz98tsnDyw==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=WkABH6HlfUjrN5zv6urgpS5lPLEyczfYd6EYxKA00oQ=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794506073052776.2172262097902;
	Thu, 12 Nov 2026 09:54:33 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Fri, 13 Nov 2026 01:54:01 +0800
Subject: [PATCH v3 8/9] HID: haptic: Convert into a loadable plugin module
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-hid-haptic-kmod-v3-8-e7dfa8766c0d@rong.moe>
References: <20261113-hid-haptic-kmod-v3-0-e7dfa8766c0d@rong.moe>
In-Reply-To: <20261113-hid-haptic-kmod-v3-0-e7dfa8766c0d@rong.moe>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Angela Czubak <aczubak@google.com>, Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.17-dev-ce4c1
X-ZohoMailClient: External

Commit 083a4f3f3cc7 ("HID: Kconfig: Fix build error from
CONFIG_HID_HAPTIC") built hid-haptic into vmlinux or hid.ko. This is not
optimal for generic kernel images, as a platform with no multitouch
device doesn't need it anyway. It's also a bit harsh for enabling it in
distribution kernels.

With the new hid-plugin framework, hid-haptic can be easily converted
into a loadable plugin module, so that hid-multitouch only requests it
on demand.

The redaundent `default n' statement is also removed for tidiness since
we are anyway touching its context.

Suggested-by: Benjamin Tissoires <bentiss@kernel.org>
Link: https://lore.kernel.org/linux-input/auypydfkhx2eg7vp764way4batdilzc35inqda3exwzs3tk3ff@oagat6g46zto/
Signed-off-by: Rong Zhang <i@rong.moe>
---
 MAINTAINERS              |  1 +
 drivers/hid/Kconfig      |  7 +++++--
 drivers/hid/Makefile     |  2 +-
 drivers/hid/hid-haptic.c | 28 ++++++++++++++++++----------
 drivers/hid/hid-haptic.h | 29 +++++++++++++++++++++++++++--
 drivers/hid/hid-plugin.c |  3 +++
 drivers/hid/hid-plugin.h |  6 ++++++
 7 files changed, 61 insertions(+), 15 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 06c82b4a7614..b772148c031c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11909,6 +11909,7 @@ HID PLUGINS
 M:	Rong Zhang <i@rong.moe>
 L:	linux-input@vger.kernel.org
 S:	Maintained
+F:	drivers/hid/hid-haptic.*
 F:	drivers/hid/hid-plugin.*
 
 HID PULSAR DRIVER
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 604683b4a4a9..97cb4caf9d7e 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -106,9 +106,10 @@ menuconfig HID_PLUGIN
 
 	If unsure, say N.
 
+if HID_PLUGIN
+
 config HID_HAPTIC
-	bool "Haptic touchpad support"
-	default n
+	tristate "Haptic touchpad support"
 	help
 	Support for touchpads with force sensors and haptic actuators instead of a
 	traditional button.
@@ -117,6 +118,8 @@ config HID_HAPTIC
 
 	If unsure, say N.
 
+endif # HID_PLUGIN
+
 menu "Special HID drivers"
 
 config HID_A4TECH
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index b41aa3f52a94..3360347c1cb8 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -6,7 +6,7 @@ hid-y			:= hid-core.o hid-input.o hid-quirks.o
 hid-$(CONFIG_DEBUG_FS)		+= hid-debug.o
 hid-$(CONFIG_HID_PLUGIN)	+= hid-plugin.o
 
-hid-$(CONFIG_HID_HAPTIC)	+= hid-haptic.o
+obj-$(CONFIG_HID_HAPTIC)	+= hid-haptic.o
 
 obj-$(CONFIG_HID_BPF)		+= bpf/
 
diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index a6f3ec514504..0e9708d1f3a9 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -315,12 +315,11 @@ static void hid_haptic_destroy(struct ff_device *ff)
 	if (hdev)
 		put_device(&hdev->dev);
 
-	module_put(THIS_MODULE);
+	hid_plugin_put(HID_PLUGIN_HAPTIC, &haptic->self_plugin->hp);
 }
 
-int hid_haptic_init(struct hid_device *hdev,
-		    struct hid_haptic_device *haptic,
-		    struct input_dev *dev)
+static int __hid_haptic_init(struct hid_device *hdev, struct hid_haptic_device *haptic,
+			     struct input_dev *dev)
 {
 	struct ff_device *ff;
 	int ret = 0, r;
@@ -328,10 +327,6 @@ int hid_haptic_init(struct hid_device *hdev,
 		.hid_usage = HID_HP_WAVEFORMSTOP & HID_USAGE,
 	};
 
-	if (!try_module_get(THIS_MODULE)) {
-		dev_err(&hdev->dev, "Failed to increase module count.\n");
-		return -ENXIO;
-	}
 	if (!get_device(&hdev->dev)) {
 		dev_err(&hdev->dev, "Failed to get hdev device.\n");
 		ret = -ENXIO;
@@ -454,7 +449,20 @@ int hid_haptic_init(struct hid_device *hdev,
 	put_device(&hdev->dev);
 exit:
 	dev_warn(&hdev->dev, "Cannot allocate haptic for %s: %d\n", hdev->name, ret);
-	module_put(THIS_MODULE);
+	hid_plugin_put(HID_PLUGIN_HAPTIC, &haptic->self_plugin->hp);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(hid_haptic_init);
+
+static struct hid_plugin_haptic hid_plugin_haptic = {
+	.hp = {
+		.owner = THIS_MODULE,
+	},
+	.init = __hid_haptic_init,
+};
+module_hid_plugin(haptic, HID_PLUGIN_HAPTIC, &hid_plugin_haptic.hp);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Angela Czubak <aczubak@google.com>");
+MODULE_AUTHOR("Jonathan Denose <jdenose@google.com>");
+MODULE_AUTHOR("Rong Zhang <i@rong.moe>");
+MODULE_DESCRIPTION("HID helpers for Haptics Page");
diff --git a/drivers/hid/hid-haptic.h b/drivers/hid/hid-haptic.h
index 6196041eb4f8..a71ccee569f3 100644
--- a/drivers/hid/hid-haptic.h
+++ b/drivers/hid/hid-haptic.h
@@ -5,9 +5,12 @@
  *  Copyright (c) 2021 Angela Czubak <acz@semihalf.com>
  */
 
+#include <linux/container_of.h>
 #include <linux/err.h>
 #include <linux/hid.h>
 
+#include "hid-plugin.h"
+
 #define HID_HAPTIC_ORDINAL_WAVEFORMNONE 1
 #define HID_HAPTIC_ORDINAL_WAVEFORMSTOP 2
 
@@ -52,6 +55,14 @@ struct hid_haptic_device {
 	u16 release_ordinal;
 	struct hid_haptic_effect *effect;
 	struct hid_haptic_effect stop_effect;
+
+	struct hid_plugin_haptic *self_plugin;
+};
+
+struct hid_plugin_haptic {
+	struct hid_plugin hp;
+	int (*init)(struct hid_device *hdev, struct hid_haptic_device *haptic,
+		    struct input_dev *dev);
 };
 
 #if IS_ENABLED(CONFIG_HID_HAPTIC)
@@ -152,8 +163,22 @@ static inline int hid_haptic_input_mapping(struct hid_device *hdev,
 	return 0;
 }
 
-int hid_haptic_init(struct hid_device *hdev, struct hid_haptic_device *haptic,
-		    struct input_dev *dev);
+static inline int hid_haptic_init(struct hid_device *hdev, struct hid_haptic_device *haptic,
+				  struct input_dev *dev)
+{
+	struct hid_plugin_haptic *self_plugin;
+	struct hid_plugin *plugin;
+
+	plugin = hid_plugin_get(HID_PLUGIN_HAPTIC);
+	if (IS_ERR(plugin))
+		return PTR_ERR(plugin);
+
+	self_plugin = container_of(plugin, struct hid_plugin_haptic, hp);
+
+	haptic->self_plugin = self_plugin;
+
+	return self_plugin->init(hdev, haptic, dev);
+}
 
 static inline bool hid_haptic_input_configured(struct hid_device *hdev,
 					       struct hid_haptic_device *haptic,
diff --git a/drivers/hid/hid-plugin.c b/drivers/hid/hid-plugin.c
index a83275df038c..7357f81c3aac 100644
--- a/drivers/hid/hid-plugin.c
+++ b/drivers/hid/hid-plugin.c
@@ -18,6 +18,9 @@
 #include "hid-plugin.h"
 
 static const char * const hid_plugin_mod_names[NR_HID_PLUGINS] = {
+#if IS_MODULE(CONFIG_HID_HAPTIC)
+	[HID_PLUGIN_HAPTIC] = "hid-haptic",
+#endif
 };
 
 static struct hid_plugin __rcu *hid_plugins[NR_HID_PLUGINS];
diff --git a/drivers/hid/hid-plugin.h b/drivers/hid/hid-plugin.h
index e7bc98639d9f..e2e157b23b69 100644
--- a/drivers/hid/hid-plugin.h
+++ b/drivers/hid/hid-plugin.h
@@ -19,6 +19,12 @@
 enum hid_plugin_id {
 	HID_PLUGIN_DISABLED	= -1,
 
+#if IS_ENABLED(CONFIG_HID_HAPTIC)
+	HID_PLUGIN_HAPTIC,
+#else
+#define HID_PLUGIN_HAPTIC	HID_PLUGIN_DISABLED
+#endif
+
 	NR_HID_PLUGINS,
 };
 

-- 
2.55.0

